Return-Path: <linux-kernel-owner+willy=40w.ods.org-S389452AbUKBBLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S389452AbUKBBLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S389416AbUKBBKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 20:10:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18581 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S293603AbUKBBIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 20:08:15 -0500
Date: Mon, 1 Nov 2004 19:07:53 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
cc: hugh@veritas.com, ak@suse.de
Subject: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch causes memory allocation for tmpfs files to be distributed
evenly across NUMA machines.  In most circumstances today, tmpfs files
will be allocated on the same node as the task writing to the file.
In many cases, particularly when large files are created, or a large
number of files are created by a single task, this leads to a severe
imbalance in free memory amongst nodes.  This patch corrects that
situation.

Memory imbalances such as this can degrade performance in various ways.
The two most typical situations are:

1. An HPC application with tighty synchronized threads has one or more
   of its tasks running on a node with little free memory.  These
   tasks are forced to allocate and/or access memory from remote
   nodes.  Since access to remote memory incurs a performance penalty,
   these threads run slower than those on other nodes.  The threads
   on other nodes end up waiting for the slower threads (i.e. the
   whole application runs only as fast as the slowest thread), thereby
   incurring a significant performance penalty for the application.
2. Many seperate tasks access a given file.  Since the memory is remote
   for almost all processors, this causes a slowdown for the remote
   tasks.  A small performance gain can be seen by distribute the
   file's memory allocation across the system.  This scenario has an
   additional effect of increasing the memory traffic for the node
   hosting the allocation, thereby unfairly penalizing the memory
   bandwidth on the host node when such traffic could be spread more
   evenly across the machine.

This patch builds upon the NUMA memory policy code.  It affects only
the default placement of tmpfs file allocations, and in particular
does not affect /dev/zero memory allocations, which are implemented
in the same code.  /dev/zero mappings are typically of interest only
to a particular process, and thus benefit more from local allocations.
In any case, the NUMA API can still be used to more precisely lay out
allocations if so desired, it is only the default behavior of the
allocations which is changed.

System V shared memory allocations are also unaffected, though implemented
by the same code.  While in theory these allocations could suffer some
of the same problems as tmpfs files (i.e. a need to distribute large
allocations machine-wide, particularly if the allocation is long-lived),
SGI has not seen this to be a significant problem in practice.  As
addressing shm would add to the complexity of the patch with little
perceived value, changes thereto have not been implemented.

The following output (gleaned from /sys/devices/system/node/*/meminfo),
illustrates the effect of this patch.  The tmpfs file was created via
the command 'dd if=/dev/zero of=3G bs=1073741824 count=3' within a
tmpfs directory.

Without patch
=============
Before creating 3GB tmpfs file
------------------------------
 Nid  MemTotal   MemFree   MemUsed      (in kB)
   0   4002480   3787040    215440
   1   4014080   3942368     71712
   2   3882992   3749376    133616
   3   3883008   3824288     58720
   4   3882992   3825824     57168
   5   3883008   3825440     57568
   6   3883008   3304576    578432
   7   3882992   3829408     53584
   8    933888    873696     60192
   9    933888    887424     46464
  10    933872    890720     43152
  11    933888    891328     42560
  12    933888    890464     43424
  13    933888    880608     53280
  14    933872    889408     44464
  15    915696    872672     43024
 ToT  38767440  37164640   1602800

After creating 3GB tmpfs file
-----------------------------
 Nid  MemTotal   MemFree   MemUsed      (in kB)
   0   4002480    633792   3368688
   1   4014080   3938944     75136
   2   3882992   3742624    140368
   3   3883008   3824288     58720
   4   3882992   3825792     57200
   5   3883008   3825440     57568
   6   3883008   3304640    578368
   7   3882992   3829408     53584
   8    933888    873696     60192
   9    933888    887552     46336
  10    933872    890720     43152
  11    933888    891264     42624
  12    933888    890464     43424
  13    933888    880672     53216
  14    933872    889408     44464
  15    915696    872672     43024
 ToT  38767440  34001376   4766064

With patch
==========
Before creating 3GB tmpfs file
------------------------------
 Nid  MemTotal   MemFree   MemUsed      (in kB)
   0   4002496   3263584    738912
   1   4014080   3934656     79424
   2   3882992   3735584    147408
   3   3883008   3815648     67360
   4   3882992   3820640     62352
   5   3883008   3816992     66016
   6   3883008   3803904     79104
   7   3882992   3820000     62992
   8    933888    872160     61728
   9    933888    881888     52000
  10    933872    881376     52496
  11    933888    883072     50816
  12    933888    884000     49888
  13    933888    878144     55744
  14    933872    875008     58864
  15    915696    864256     51440
 ToT  38767456  37030912   1736544

After creating 3GB tmpfs file
-----------------------------
 Nid  MemTotal   MemFree   MemUsed      (in kB)
   0   4002496   3066144    936352
   1   4014080   3738176    275904
   2   3882992   3536800    346192
   3   3883008   3619232    263776
   4   3882992   3624224    258768
   5   3883008   3620576    262432
   6   3883008   3607488    275520
   7   3882992   3623584    259408
   8    933888    675744    258144
   9    933888    685472    248416
  10    933872    684960    248912
  11    933888    686656    247232
  12    933888    687584    246304
  13    933888    681728    252160
  14    933872    678656    255216
  15    915696    667840    247856
 ToT  38767456  33884864   4882592

Note that in all cases shown above, there are additional sources of
memory imbalances.  These do not lie within tmpfs, and will be addressed
in due course.

And now, for your viewing pleasure...

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

Index: linux/mm/mempolicy.c
===================================================================
--- linux.orig/mm/mempolicy.c	2004-11-01 13:47:00.000000000 -0600
+++ linux/mm/mempolicy.c	2004-11-01 15:04:30.000000000 -0600
@@ -1027,6 +1027,28 @@
 	return 0;
 }

+void mpol_shared_policy_init(struct shared_policy *info, unsigned interleave)
+{
+	info->root = RB_ROOT;
+	init_MUTEX(&info->sem);
+
+	if (unlikely(interleave)) {
+		struct mempolicy *newpol;
+
+		/* Falls back to MPOL_DEFAULT on any error */
+		newpol = mpol_new(MPOL_INTERLEAVE, nodes_addr(node_online_map));
+		if (likely(!IS_ERR(newpol))) {
+			/* Create pseudo-vma that contains just the policy */
+			struct vm_area_struct pvma;
+
+			memset(&pvma, 0, sizeof(struct vm_area_struct));
+			/* Policy covers entire file */
+			pvma.vm_end = ~0UL;
+			mpol_set_shared_policy(info, &pvma, newpol);
+		}
+	}
+}
+
 int mpol_set_shared_policy(struct shared_policy *info,
 			struct vm_area_struct *vma, struct mempolicy *npol)
 {
Index: linux/fs/hugetlbfs/inode.c
===================================================================
--- linux.orig/fs/hugetlbfs/inode.c	2004-10-18 16:55:07.000000000 -0500
+++ linux/fs/hugetlbfs/inode.c	2004-11-01 14:18:36.000000000 -0600
@@ -384,7 +384,7 @@
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = HUGETLBFS_I(inode);
-		mpol_shared_policy_init(&info->policy);
+		mpol_shared_policy_init(&info->policy, 0);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
Index: linux/include/linux/mempolicy.h
===================================================================
--- linux.orig/include/linux/mempolicy.h	2004-10-18 16:53:10.000000000 -0500
+++ linux/include/linux/mempolicy.h	2004-11-01 14:20:54.000000000 -0600
@@ -137,11 +137,7 @@
 	struct semaphore sem;
 };

-static inline void mpol_shared_policy_init(struct shared_policy *info)
-{
-	info->root = RB_ROOT;
-	init_MUTEX(&info->sem);
-}
+void mpol_shared_policy_init(struct shared_policy *info, unsigned interleave);

 int mpol_set_shared_policy(struct shared_policy *info,
 				struct vm_area_struct *vma,
@@ -198,7 +194,8 @@
 	return -EINVAL;
 }

-static inline void mpol_shared_policy_init(struct shared_policy *info)
+static inline void mpol_shared_policy_init(struct shared_policy *info,
+					unsigned interleave)
 {
 }

Index: linux/mm/shmem.c
===================================================================
--- linux.orig/mm/shmem.c	2004-11-01 13:47:00.000000000 -0600
+++ linux/mm/shmem.c	2004-11-01 14:21:43.000000000 -0600
@@ -1236,7 +1236,7 @@
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
- 		mpol_shared_policy_init(&info->policy);
+ 		mpol_shared_policy_init(&info->policy, sbinfo ? 1 : 0);
 		INIT_LIST_HEAD(&info->swaplist);

 		switch (mode & S_IFMT) {

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
