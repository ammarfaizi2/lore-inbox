Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbREXRYz>; Thu, 24 May 2001 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbREXRYp>; Thu, 24 May 2001 13:24:45 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:28406 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261489AbREXRYg>; Thu, 24 May 2001 13:24:36 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105241724.f4OHOAhQ014259@webber.adilger.int>
Subject: Re: O_TRUNC problem on a full filesystem
In-Reply-To: <3B0CF068.A6ADA562@uow.edu.au> "from Andrew Morton at May 24, 2001
 09:28:40 pm"
To: Andrew Morton <andrewm@uow.edu.au>
Date: Thu, 24 May 2001 11:24:10 -0600 (MDT)
CC: "Stephen C. Tweedie" <sct@redhat.com>, Manas Garg <mls@chakpak.net>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew writes:
> "Stephen C. Tweedie" wrote:
> > On Wed, May 23, 2001 at 07:55:48PM +1000, Andrew Morton wrote:
> > > When you truncated your file, the blocks remained preallocated
> > > on behalf of the file, and were hence considered "used".  For
> > > some reason, a subsequent attempt to allocate blocks for the
> > > same file failed to use that file's preallocated blocks.
> > 
> > Nope.  ext2_truncate() calls ext2_discard_prealloc() to fix this up.
> > Both 2.2 and 2.4 do this correctly.
> 
> But the problem goes away when you disable EXT2_PREALLOCATE.
> I tested it.

Are you sure that a truncated file will re-use the same truncated blocks,
but not the preallocated ones?  I can imagine not re-using all of the data
blocks within a single transaction, but it would be odd if the preallocated
blocks are treated differently.

How have you done the ext3 preallocation code?  One way to do it would be
to only mark the blocks as used in the in-memory copy of the block bitmap
and not write that to disk (we keep 2 copies of the block bitmap, IIRC).
That way you don't need to do anything fancy at recovery time.

Did you ever benchmark ext2 with and without preallocation to see if it
made any difference?  No point in doing extra work if there is no benefit.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
