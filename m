Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSEPW5y>; Thu, 16 May 2002 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSEPW5y>; Thu, 16 May 2002 18:57:54 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:47101 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315191AbSEPW5x>; Thu, 16 May 2002 18:57:53 -0400
Date: Thu, 16 May 2002 16:54:51 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: davidm@hpl.hp.com, Peter Chubb <peter@chubb.wattle.id.au>,
        Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020516225451.GO12975@turbolinux.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	davidm@hpl.hp.com, Peter Chubb <peter@chubb.wattle.id.au>,
	Jeremy Andrews <jeremy@kerneltrap.org>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <15580.24766.424170.333718@napali.hpl.hp.com> <20020515221733.GG12975@turbolinux.com> <E178Rlf-0008Tj-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2002  22:22 +0200, Daniel Phillips wrote:
> On Thursday 16 May 2002 00:17, Andreas Dilger wrote:
> > Even 8kB blocks would theoretically overflow these fields, but you
> > can't yet have a group _totally_ empty (there are always two bitmaps
> > and at least one inode table block), so it would always have less
> > than 65535 blocks free.  Now I realize that this isn't true of the
> > inode table in theory, but you normally also have less than the maximum
> > number of inodes per group - need to check for that.
> > 
> > This could be worked around temporarily by limiting the size of each
> > group to at most 65535 free blocks/inodes.
> 
> Imposing an absolute upper limit of 2**16 blocks per group makes the most 
> sense for now, and may always make the most sense.  Even with a cap on the
> blocks per group group size still scales directly with block size.  We
> don't want it to scale quadratically.  If it did, then a data block could
> end up 32 GB away from the inode, still in the same group.  This
> effectively destroys the utility of block groups as a means of reducing
> seek latency.

Yes, Ted said the same.

A minor question is whether to cap it at 65536 blocks/group or 65528?
(The number of blocks per group must be a multiple of 8).

The current layout is such that you will _always_ have at least 3
blocks in use for each group.  However, if we implement Ted's
"metagroup" layout (which puts all of a group's bitmaps/itable blocks
in the first group of its block of group descriptors) then there could
be cases where a group has no blocks in use, and the free count will
overflow.

Having the upper limit at 65536 is aesthetically pleasing, and it aligns
nicely with LVM (which allocates chunks in power-of-two sizes), but may
preclude changing such a filesystem to the metagroup layout without a
larger effort on the resizer's part.  I'll go with 65528 I guess.

Note that going to a metagroup layout would also grow the distance
between the itable and possible blocks quadratically (the number of
group descriptors that fit into a block also grows with blocksize),
but at least it is not cubic growth.  That said, the metagroup layout
is probably only useful for cases where you _know_ you want huge files
(in the multi-GB range) and locality of blocks to the single inode block
is irrelevant.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

