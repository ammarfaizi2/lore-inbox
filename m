Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316450AbSEOWTl>; Wed, 15 May 2002 18:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316507AbSEOWTk>; Wed, 15 May 2002 18:19:40 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:15866 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316450AbSEOWTj>; Wed, 15 May 2002 18:19:39 -0400
Date: Wed, 15 May 2002 16:17:33 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: davidm@hpl.hp.com
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
        Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020515221733.GG12975@turbolinux.com>
Mail-Followup-To: davidm@hpl.hp.com, Peter Chubb <peter@chubb.wattle.id.au>,
	Jeremy Andrews <jeremy@kerneltrap.org>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <20020510084713.43ce396e.jeremy@kerneltrap.org> <15580.7052.396951.568702@wombat.chubb.wattle.id.au> <20020510234623.GC12975@turbolinux.com> <15580.24766.424170.333718@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 10, 2002  17:07 -0700, David Mosberger wrote:
>On Fri, 10 May 2002 17:46:23 -0600, Andreas Dilger <adilger@clusterfs.com> said:
>   Andreas> For 64-bit systems like Alpha, it is relatively easy to use
>   Andreas> 8kB blocks for ext3.  It has been discouraged because such
>   Andreas> a filesystem is non-portable to other (smaller page-sized)
>   Andreas> filesystems.  Maybe this rationale should be re-examined -
>   Andreas> I could probably whip up a configure option for e2fsprogs
>   Andreas> to allow 8kB blocks in a few hours.
> 
> If you do this, please consider allowing a block size up to 64KB.
> The ia64 kernel offers a choice of 4, 8, 16, and 64KB page size.

Well, taking a look at the ext2 code, there is a slight problem when
trying to use block sizes > 8kB.  This is in the group descriptors,
where they only store a 16 bit could of free blocks and inodes for
the group.  Since the maximum number of blocks/inodes is 8*blocksize
(the number of bits that can fit into a single block) you overflow
these fields if you have more than 64k (8*8k) blocks in a group.

Even 8kB blocks would theoretically overflow these fields, but you
can't yet have a group _totally_ empty (there are always two bitmaps
and at least one inode table block), so it would always have less
than 65535 blocks free.  Now I realize that this isn't true of the
inode table in theory, but you normally also have less than the maximum
number of inodes per group - need to check for that.

This could be worked around temporarily by limiting the size of each
group to at most 65535 free blocks/inodes.  The permanent solution is
to probably add an extra byte for each of these two fields to allow up
to 16M blocks/inodes per group, which gives us a max block size of 2MB.

This could be a compat ext2 feature, since at worst if we didn't take
the high byte into account on a block free it could overflow this field
and we wouldn't be able to allocate from this group until more blocks
are freed.  We couldn't underflow because the allocator would stop when
the free block/inode count hit zero for that group, even if there were
really more free blocks available.

So, for now I think I'll stick to a maximum of 8kB blocks, and maybe
we can slip in support for the high byte of the free blocks/inodes
count when Ted adds in support for metagroups.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

