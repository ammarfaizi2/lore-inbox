Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbREYAbG>; Thu, 24 May 2001 20:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263471AbREYAaz>; Thu, 24 May 2001 20:30:55 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:40347 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263469AbREYAap>; Thu, 24 May 2001 20:30:45 -0400
Message-ID: <3B0DA651.8151AE93@uow.edu.au>
Date: Fri, 25 May 2001 10:24:49 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Manas Garg <mls@chakpak.net>,
        linux-kernel@vger.kernel.org
Subject: Re: O_TRUNC problem on a full filesystem
In-Reply-To: <3B0CF068.A6ADA562@uow.edu.au> "from Andrew Morton at May 24, 2001
	 09:28:40 pm" <200105241724.f4OHOAhQ014259@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Andrew writes:
> > "Stephen C. Tweedie" wrote:
> > > On Wed, May 23, 2001 at 07:55:48PM +1000, Andrew Morton wrote:
> > > > When you truncated your file, the blocks remained preallocated
> > > > on behalf of the file, and were hence considered "used".  For
> > > > some reason, a subsequent attempt to allocate blocks for the
> > > > same file failed to use that file's preallocated blocks.
> > >
> > > Nope.  ext2_truncate() calls ext2_discard_prealloc() to fix this up.
> > > Both 2.2 and 2.4 do this correctly.
> >
> > But the problem goes away when you disable EXT2_PREALLOCATE.
> > I tested it.
> 
> Are you sure that a truncated file will re-use the same truncated blocks,
> but not the preallocated ones?  I can imagine not re-using all of the data
> blocks within a single transaction, but it would be odd if the preallocated
> blocks are treated differently.

This is vanliia ext2.  The O_TRUNC problem is easy to reproduce,
and goes away when EXT*2*_PREALLOC is undefined.  Haven't looked
into it further, but I suppose one should.  It's not nice having
unexplained mysteries in ext2.

> How have you done the ext3 preallocation code?  One way to do it would be
> to only mark the blocks as used in the in-memory copy of the block bitmap
> and not write that to disk (we keep 2 copies of the block bitmap, IIRC).
> That way you don't need to do anything fancy at recovery time.
> 
> Did you ever benchmark ext2 with and without preallocation to see if it
> made any difference?  No point in doing extra work if there is no benefit.

This is an excellent point - it would be unwise to go to the
effort and complexity of putting prealloc back into ext3
without first analysing how useful it actually is.  Perhaps
some tuning of the other anti-fragmentation algorithms
will suffice.

For example, when we miss the goal block we search forward
up to 63 blocks for a *single* free block, and use that.
Perhaps we shouldn't?

And perhaps the search for eight contiguous free blocks
is no longer appropriate to current disks.  32 may be better?

So I'd prefer to set up a simulator and at least validate the
current algorithms beforehand, perhaps tune them as well.
