Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314658AbSEPUXP>; Thu, 16 May 2002 16:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314659AbSEPUXO>; Thu, 16 May 2002 16:23:14 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:40678 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314658AbSEPUXN>;
	Thu, 16 May 2002 16:23:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>, davidm@hpl.hp.com
Subject: Re: [PATCH] remove 2TB block device limit
Date: Thu, 16 May 2002 22:22:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
        Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <15580.24766.424170.333718@napali.hpl.hp.com> <20020515221733.GG12975@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178Rlf-0008Tj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 May 2002 00:17, Andreas Dilger wrote:
> On May 10, 2002  17:07 -0700, David Mosberger wrote:
> >On Fri, 10 May 2002 17:46:23 -0600, Andreas Dilger <adilger@clusterfs.com> 
said:
> >   Andreas> For 64-bit systems like Alpha, it is relatively easy to use
> >   Andreas> 8kB blocks for ext3.  It has been discouraged because such
> >   Andreas> a filesystem is non-portable to other (smaller page-sized)
> >   Andreas> filesystems.  Maybe this rationale should be re-examined -
> >   Andreas> I could probably whip up a configure option for e2fsprogs
> >   Andreas> to allow 8kB blocks in a few hours.
> > 
> > If you do this, please consider allowing a block size up to 64KB.
> > The ia64 kernel offers a choice of 4, 8, 16, and 64KB page size.
> 
> Well, taking a look at the ext2 code, there is a slight problem when
> trying to use block sizes > 8kB.  This is in the group descriptors,
> where they only store a 16 bit could of free blocks and inodes for
> the group.  Since the maximum number of blocks/inodes is 8*blocksize
> (the number of bits that can fit into a single block) you overflow
> these fields if you have more than 64k (8*8k) blocks in a group.
> 
> Even 8kB blocks would theoretically overflow these fields, but you
> can't yet have a group _totally_ empty (there are always two bitmaps
> and at least one inode table block), so it would always have less
> than 65535 blocks free.  Now I realize that this isn't true of the
> inode table in theory, but you normally also have less than the maximum
> number of inodes per group - need to check for that.
> 
> This could be worked around temporarily by limiting the size of each
> group to at most 65535 free blocks/inodes.  The permanent solution is
> to probably add an extra byte for each of these two fields to allow up
> to 16M blocks/inodes per group, which gives us a max block size of 2MB.
>
> This could be a compat ext2 feature, since at worst if we didn't take
> the high byte into account on a block free it could overflow this field
> and we wouldn't be able to allocate from this group until more blocks
> are freed.  We couldn't underflow because the allocator would stop when
> the free block/inode count hit zero for that group, even if there were
> really more free blocks available.
> 
> So, for now I think I'll stick to a maximum of 8kB blocks, and maybe
> we can slip in support for the high byte of the free blocks/inodes
> count when Ted adds in support for metagroups.

Hi Andreas,

Imposing an absolute upper limit of 2**16 blocks per group makes the most 
sense for now, and may always make the most sense.  Even with a cap on the
blocks per group group size still scales directly with block size.  We
don't want it to scale quadratically.  If it did, then a data block could
end up 32 GB away from the inode, still in the same group.  This
effectively destroys the utility of block groups as a means of reducing
seek latency.
 
-- 
Daniel
