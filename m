Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRLUNib>; Fri, 21 Dec 2001 08:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281748AbRLUNiW>; Fri, 21 Dec 2001 08:38:22 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:19925
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S281719AbRLUNiI>; Fri, 21 Dec 2001 08:38:08 -0500
Date: Fri, 21 Dec 2001 08:29:30 -0500
From: Chris Mason <mason@suse.de>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lockups with 2.4.14 and 2.4.16
Message-ID: <1681982704.1008941370@tiny>
In-Reply-To: <3C22CC54.D4F5B01@zip.com.au>
In-Reply-To: <3C1A4BB4.EA8C4B45@zip.com.au>
 ,	<000a01c1829f$75daf7a0$050010ac@FUTURE>
 <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny>
 <3C1A3652.52B989E4@zip.com.au>
 <3845670000.1008352380@tiny>,	<3845670000.1008352380@tiny>; from
 mason@suse.com on Fri, Dec 14, 2001 at 12:53:00PM -0500
 <20011214193217.H2431@athlon.random> <3C1A4BB4.EA8C4B45@zip.com.au>
 <1624652704.1008906979@tiny> <3C22CC54.D4F5B01@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 20, 2001 09:44:52 PM -0800 Andrew Morton
<akpm@zip.com.au> wrote:

> Chris Mason wrote:
>> 
>> Ok, I'm ignoring the shrink_dcache issue I mentioned earlier today
>> for the moment.  It has not shown up in any of the traces from Johan's
>> machines, and I'd like to get his problems fixed before moving on to
>> the (much) rarer iput problems.
>> 
> 
> OK, looks like it'll fix the problem.   Which you previously described
> as:

Hi Andrew, thanks for giving this a look.

> A similar deadlock could occur at writepage().  ext3 goes to some
> lengths to avoid blocking on the journal at writepage - if the caller
> is PF_MEMALLOC and we can't unblockingly start a transaction we redirty
> the page and bale.
> 
> It seems that reiserfs can also start a transaction at writepage.  How
> come it doesn't deadlock there?

I've got patches for this too, I'll them integrated after new year's.  It
seems like the quota semaphore makes the deadlock much more likely with the
quota code.

> 
> A couple of broad-sweep things:
> 
> - The VM refuses to write out swapcached pages when called without
>   __GFP_FS.  For swap devices (as opposed to swapfiles), it appears
>   that we could in fact perform the swapout, which would help, but
>   not cure this.

Yes.

> 
> - Where's bdflush?  It should be madly undirtying pages and making
>   the situation better.

bdflush can flush the dirty buffers on the dirty pages, but it leaves the
page dirty.  I almost think we should move the decision about writing the
page under GFP_NOFS to the filesystem (2.5.x).  If the buffers are already
mapped, the page can be written without taking any FS locks at all.

> 
> Neither of which fix the problem with mapped files.  Bring on
> kinoded, I guess.  Maybe.  Did you think about just kicking kupdate
> and letting it sync the inodes?

The current kupdate won't touch the unused inode list, and we dive into the
quota code while calling clear_inode while freeing unused inodes.  I could
change kupdate to do what kinoded does, but then kupdate moves away from
being a periodic flusher and changes into something that responds to memory
pressure.

-chris

