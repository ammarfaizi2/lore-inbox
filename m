Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSFCWs4>; Mon, 3 Jun 2002 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSFCWsz>; Mon, 3 Jun 2002 18:48:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315709AbSFCWsy>;
	Mon, 3 Jun 2002 18:48:54 -0400
Message-ID: <3CFBF202.E4A52AB9@zip.com.au>
Date: Mon, 03 Jun 2002 15:47:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <Pine.LNX.4.44.0206031514110.868-100000@home.transmeta.com> <1023143783.31682.28.camel@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Mon, 2002-06-03 at 18:19, Linus Torvalds wrote:
> >
> >
> > On 3 Jun 2002, Chris Mason wrote:
> > >
> > > Or am I missing something?
> >
> > No. I think that in the long run we really would want all of the writeback
> > preallocation should happen in the "struct file", not in "struct inode".
> > And they should be released at file close ("release()"), not at iput()
> > time.
> 
> reiserfs does preallocation and tail packing in release() right now, but
> do we really need preallocation at all once delayed allocation is
> stable?
> 

well..  Will delayed allocation even exist?  Grafting reservations
onto ext2 had a few awkward moments in the area of handling ENOSPC,
and generally a lot of the benefits of that code (ie: avoiding buffers)
have been whittled away by other means.

So right now I don't see a strong reason for adding delayed allocation
support into the core kernel for ext2.  If another fs comes up and
creates a demand for core kernel support then fine.  (Thinking XFS
here).  Probably I should resurrect the ext2 code as something for you
and Steve to poke at.

Plus ext3 needs prealloc as well.  Performing that within the live
bitmaps like ext2 is really awkward.  I have half-a-patch which performs
area reservations in ext3 via a per-private-inode "start, length"
tuple.  These zones never get near being written to disk.  That
seems a reasonable approach for ext3, but it does use the inode.
If that info was inside struct file, writepage() would get rather
confused - it doesn't have a file*.

-
