Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279454AbRKIGUn>; Fri, 9 Nov 2001 01:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279467AbRKIGUe>; Fri, 9 Nov 2001 01:20:34 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36362 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279454AbRKIGUZ>; Fri, 9 Nov 2001 01:20:25 -0500
Message-ID: <3BEB7464.245FBB23@zip.com.au>
Date: Thu, 08 Nov 2001 22:15:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andreas Dilger <adilger@turbolabs.com>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011108154311.E9043@lynx.no> <Pine.GSO.4.21.0111081802250.8052-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Al.

First a couple of comments on the patch (looks nice, BTW):

/*
 * Orlov's allocator for directories.
 *
 * We always try to spread first-level directories:
 *      If there are directories with both free inodes and free blocks counts
                     ^^^^^^^^^^^
                               cylinder groups
 *      not worse than average we return one with smallest directory count.

(I agree with Andreas on this one.  Why switch terminology?)




                get_random_bytes(&group, sizeof(group));
                parent_cg = group % ngroups;
                goto fallback;

AFAICT, get_random_bytes() here can set `group' to a negative
value, and parent_cg can go negative, and that propagates to
`group' going negative, and getting passed to ext2_get_group_desc(),
and everything goes generally pear-shaped.  Really, all this arith
should be using unsigneds.



>From here:

        max_dirs = ndirs / ngroups + inodes_per_group / 16;
        min_inodes = avefreei - inodes_per_group / 4;
        min_blocks = avefreeb - EXT2_BLOCKS_PER_GROUP(sb) / 4;

things start to get a bit confusing.  A couple of 1-2 line comments
which explain what the variables actually represent would help to
clarify things.  Also, an explanation of `debt' is needed.



Offtopic, in ext2_new_inode():

        mark_buffer_dirty(bh);
        if (sb->s_flags & MS_SYNCHRONOUS) {
                ll_rw_block (WRITE, 1, &bh);
                wait_on_buffer (bh);
        }

Does the inode bitmap writeout actually need to be synchronous
here?  The file will still be recoverable by fsck if this is
not done?  If the sync _is_ needed, shouldn't we be doing it with
the group descriptors?


Finally, please, please, please take the opportunity to rename
`bh', `bh2', `i' and `j' in ext2_new_inode() to something
semantically meaningful.  What we have now is just insane.


We need to test carefully with ENOSPC, but it looks solid.


Performance-wise, the Orlov approach is almost as good as
the `if (0 &&' approach for fast growth.  This is the "manipulate
kernel trees on an empty partition" test:

		Stock	Patched	Orlov
				
untar		31	14	14
diff		184	72	82.6
tar		15	3	3
rm		30	10	10.3

So the diffing was a bit slower; not much.


For the slow growth test, same as last time (cut-n-paste
from the very excellent staroffice 6 spreadsheet):

Tree	Stock	Stock/ideal	Patched	Patched/stock	Orlov	Orlov/ideal
	(secs)			(secs)			(secs)	
0	37	2.85		74	200.00%		63	4.85
1	41	3.15		89	217.07%		68	5.23
2	41	3.15		97	236.59%		74	5.69
3	38	2.92		97	255.26%		84	6.46
4	55	4.23		102	185.45%		78	6
5	51	3.92		98	192.16%		76	5.85
6	72	5.54		94	130.56%		73	5.62
7	56	4.31		96	171.43%		71	5.46
8	64	4.92		102	159.38%		73	5.62
9	63	4.85		100	158.73%		71	5.46
10	57	4.38		95	166.67%		74	5.69
11	83	6.38		102	122.89%		78	6
12	54	4.15		101	187.04%		76	5.85
13	82	6.31		104	126.83%		78	6
14	89	6.85		103	115.73%		77	5.92
15	88	6.77		95	107.95%		77	5.92
16	106	8.15		99	93.40%		77	5.92


We see that Orlov is more prone to fragmentation than stock 2.4.14: The
time to read the first batch of 378 megs of files is 37 seconds with
2.4.14, 63 seconds with Orlov.  But it's better than the `if (0 && '
approach.


So I just don't know at this stage.  Even after a single pass of the Smith
workload, we're running at 3x to 5x worse than ideal.  If that's simply
the best we can do, then we need to compare stock 2.4.14 with Orlov
partway through the progress of the Smith workload to evaluate how much
more serious the fragmentation is.   That's easy enough - I'll do it.


The next task is to work out why a single pass of the Smith workload
fragments the filesystem so much, and whether this can be improved.


Oh.  And some preliminary testing with SCSI shows markedly different
behaviour: those 3x to 5x speedups I was demonstrating with IDE are
only 1.5x with a Quantum Atlas IV.  There is some magical characteristic
of modern IDE disks which stock 2.4.14 is failing to exploit, and I
don't yet have a handle on precisely what it is.

-
