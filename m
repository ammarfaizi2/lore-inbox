Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288124AbSAVGEe>; Tue, 22 Jan 2002 01:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289175AbSAVGEY>; Tue, 22 Jan 2002 01:04:24 -0500
Received: from [24.64.71.161] ([24.64.71.161]:3068 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288124AbSAVGEQ>;
	Tue, 22 Jan 2002 01:04:16 -0500
Date: Mon, 21 Jan 2002 23:02:49 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <20020121230249.P4014@lynx.turbolabs.com>
Mail-Followup-To: Chris Mason <mason@suse.com>,
	Hans Reiser <reiser@namesys.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com> <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny> <3C4C5414.2090104@namesys.com> <1819870000.1011642257@tiny> <3C4C7D08.2020707@namesys.com> <1854570000.1011649986@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1854570000.1011649986@tiny>; from mason@suse.com on Mon, Jan 21, 2002 at 04:53:07PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 21, 2002  16:53 -0500, Chris Mason wrote:
> On Monday, January 21, 2002 11:41:44 PM +0300 Hans Reiser wrote:
> > help me to understand what you mean by triggered.  Do you
> > mean VM sends pressure to the FS?  Do you mean that VM understands what a
> > transaction is?  Is this that generic journaling layer trying to come
> > alive as a piece of the VM?  I am definitely confused.
>
> The vm doesn't know what a transaction is.  But, the vm might know that
> a) this block is pinned by the FS for write ordering reasons
> b) the cost of writing this block is X
> c) calling page->somefunc will trigger writes on those blocks.
> 
> The cost could be in order of magnitude, the idea would be to give the FS
> the chance to say 'one a scale of 1 to 10, writing this block will hurt
> this much'.  Some blocks might have negative costs, meaning they don't
> depend on anything and help free others.
> 
> The same system can be used for transactions and delayed allocation,
> without telling the VM about any specifics.  
> 
> > I think what I need to understand, is do you see the VM as telling the FS
> > when it has (too many dirty pages or too many clean pages) and letting
> > the FS choose to commit a transaction if it wants to as its way of
> > cleaning pages, or do you see the VM as telling the FS to commit a
> > transaction?
> 
> I see the VM calling page->somefunc to flush that page, triggering whatever
> events the FS feels are necessary.  We might want some way to differentiate
> between periodic writes and memory pressure, so the FS has the option of
> doing fancier things during write throttling.

The ext3 developers have also been wanting things like this for a long time,
both having a "memory pressure" notification, and a differentiation between
"write this now" and "this is a periodic sync, write some stuff".  I've
CC'd them in case they want to contribute.

There are also other non-core caches in the kernel which could benefit
from having a generic "memory pressure" notification.  Having a generic
memory pressure notification helps reduce (but not eliminate) the need
to call "write this page now" into the filesystem.

My guess would be that having calls into the FS with "priorities", just
like shrink_dcache_memory() does, would allow the FS to make more
intelligent decisions about what to write/free _before_ you get to the
stage where the VM is in a panic and is telling you _specifically_ what
to write/free/etc.

> > If you think that VM should tell the FS when it has too many pages, does
> > that mean that the VM understands that a particular page in the subcache
> > has not been accessed recently enough?  Is that the pivot point of our
> > disagreement?
> 
> Pretty much.  I don't think the VM should say 'you have too many pages', I
> think it should say 'free this page'.  

As above, it should have the capability to do both, depending on the
circumstances.  The FS can obviously make better judgements locally about
what to write under normal circumstances, so it should be given the best
chance to do so.

The VM can make better _specific_ judgements when it needs to (e.g. free
a DMA page or another specific page to allow a larger contiguous chunk of
memory to be allocated), but in the cases where it just wants _some_ page(s)
to be freed, it should allow the FS to decide which one(s), if it cares.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

