Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRKIG6T>; Fri, 9 Nov 2001 01:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279581AbRKIG6M>; Fri, 9 Nov 2001 01:58:12 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:48366 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S279509AbRKIG54>;
	Fri, 9 Nov 2001 01:57:56 -0500
Date: Thu, 8 Nov 2001 23:56:32 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
Message-ID: <20011108235632.D907@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	ext2-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011108154311.E9043@lynx.no> <Pine.GSO.4.21.0111081802250.8052-100000@weyl.math.psu.edu> <3BEB7464.245FBB23@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BEB7464.245FBB23@zip.com.au>; from akpm@zip.com.au on Thu, Nov 08, 2001 at 10:15:00PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08, 2001  22:15 -0800, Andrew Morton wrote:
>         max_dirs = ndirs / ngroups + inodes_per_group / 16;
>         min_inodes = avefreei - inodes_per_group / 4;
>         min_blocks = avefreeb - EXT2_BLOCKS_PER_GROUP(sb) / 4;
> 
> things start to get a bit confusing.  A couple of 1-2 line comments
> which explain what the variables actually represent would help to
> clarify things.  Also, an explanation of `debt' is needed.

Yes, my eyes glazed over at this point as well.

> Tree	Stock	Stock/ideal	Patched	Patched/stock	Orlov	Orlov/ideal
> 	(secs)			(secs)			(secs)	

Andrew, could you stick with a single metric (either /ideal or /stock)?

> 12	54	4.15		101	187.04%		76	5.85
> 13	82	6.31		104	126.83%		78	6
> 14	89	6.85		103	115.73%		77	5.92
> 15	88	6.77		95	107.95%		77	5.92
> 16	106	8.15		99	93.40%		77	5.92

What else would be useful here is percent full for the filesystem.
Since stock ext2 preallocates up to 7 blocks for each file, this is good
for reducing fragmentation, but as the filesystem gets full it makes
fragmentation worse in the end.

> So I just don't know at this stage.  Even after a single pass of the Smith
> workload, we're running at 3x to 5x worse than ideal.  If that's simply
> the best we can do, then we need to compare stock 2.4.14 with Orlov
> partway through the progress of the Smith workload to evaluate how much
> more serious the fragmentation is.   That's easy enough - I'll do it.
> 
> The next task is to work out why a single pass of the Smith workload
> fragments the filesystem so much, and whether this can be improved.

After reading the paper, one possible cause of skewed results may be
a result of their "reverse engineering" of the filesystem layout from
the inode numbers.  They state that they were not able to capture the
actual pathnames of the files in the workload, so they invented pathnames
that would put the files in the same cylinder groups based on the FFS
allocation algorithms then in use, assuming the test filesystem had an
identical layout.

It may be possible to hack the test data into ext2 by creating a filesystem
with the same number of block groups as the test FFS filesystem with the
Smith workload.  It may also not be valid for our needs, as we are playing
with the actual group selection algorithm, so real pathnames may give us
a different layout.

Have you ever looked at the resulting data from a Smith test?  Does it do
more than simply create 27 directories (the number of cylinder groups) and
dump files directly therein, as opposed to creating more subdirectories?
Remember that they were strictly concerned with block allocation for files,
and not cylinder group selection for directories.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

