Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280120AbRKECSt>; Sun, 4 Nov 2001 21:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280122AbRKECSk>; Sun, 4 Nov 2001 21:18:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63236 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280120AbRKECS3>; Sun, 4 Nov 2001 21:18:29 -0500
Message-ID: <3BE5F5BF.7A249BDF@zip.com.au>
Date: Sun, 04 Nov 2001 18:13:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: disk throughput
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been taking a look at one particular workload - the creation
and use of many smallish files.  ie: the things we do every day
with kernel trees.

There are a number of things which cause linux to perform quite badly
with this workload.  I've fixed most of them and the speedups are quite
dramatic.  The changes include:

- reorganise the sync_inode() paths so we don't do
  read-a-block,write-a-block,read-a-block, ...

- asynchronous preread of an ext2 inode's block when we
  create the inode, so:

  a) the reads will cluster into larger requests and
  b) during inode writeout we don't keep stalling on
     reads, preventing write clustering.

- Move ext2's bitmap loading code outside lock_super(),
  so other threads can still get in and write to the
  fs while the reader sleeps, thus increasing write
  request merging.  This benefits multithreaded workloads
  (ie: dbench) and needs more thought.

The above changes are basically a search-and-destroy mission against
the things which are preventing effective writeout request merging.
Once they're in place we also need:

- Alter the request queue size and elvtune settings


The time to create 100,000 4k files (10 per directory) has fallen
from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.


All well and good, and still a WIP.  But by far the most dramatic
speedups come from disabling ext2's policy of placing new directories
in a different blockgroup from the parent:

--- linux-2.4.14-pre8/fs/ext2/ialloc.c	Tue Oct  9 21:31:40 2001
+++ linux-akpm/fs/ext2/ialloc.c	Sun Nov  4 17:40:43 2001
@@ -286,7 +286,7 @@ struct inode * ext2_new_inode (const str
 repeat:
 	gdp = NULL; i=0;
 	
-	if (S_ISDIR(mode)) {
+	if (0 && S_ISDIR(mode)) {
 		avefreei = le32_to_cpu(es->s_free_inodes_count) /
 			sb->u.ext2_sb.s_groups_count;
 /* I am not yet convinced that this next bit is necessary.


Numbers.  The machine has 768 megs; the disk is IDE with a two meg cache.
The workload consists of untarring, tarring, diffing and removing kernel
trees. This filesystem is 21 gigs, and has 176 block groups.


After each test which wrote data a `sync' was performed, and was included
in the timing under the assumption that all the data will be written back
by kupdate in a few seconds, and running `sync' allows measurement of the
cost of that.

The filesystem was unmounted between each test - all tests are with
cold caches.

                                stock   patched 
untar one kernel tree, sync:    0:31     0:14
diff two trees:                 3:04     1:12
tar kernel tree to /dev/null:   0:15     0:03
remove 2 kernel trees, sync:    0:30     0:10

A significant thing here is the improvement in read performance as well
as writes.  All of the other speedup changes only affect writes.

We are paying an extremely heavy price for placing directories in
different block groups from their parent.  Why do we do this, and
is it worth the cost?

-
