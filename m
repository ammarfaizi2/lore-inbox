Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUKHT7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUKHT7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUKHT7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:59:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31963 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261206AbUKHT7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:59:20 -0500
Date: Mon, 8 Nov 2004 13:58:51 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andi Kleen <ak@suse.de>, colpatch@us.ibm.com,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <276730000.1099515644@flay>
Message-ID: <Pine.SGI.4.58.0411081314160.101942@kzerza.americas.sgi.com>
References: <239530000.1099435919@flay>
 <Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain><20041103090112.GJ8907@wotan.suse.de>
 <Pine.SGI.4.58.0411031021160.79310@kzerza.americas.sgi.com> <276730000.1099515644@flay>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Martin J. Bligh wrote:

> Matt has volunteered to write the mount option for this, so let's hold
> off for a couple of days until that's done.

I had the time to do this myself.  Updated patch attached below.

Description:

This patch creates a tmpfs mount option and adds code which causes
tmpfs allocations to be interleaved across the nodes of a NUMA machine.
This is useful in situations where a large tmpfs file would otherwise
consume most of the memory on a single node, forcing tasks running on
that node to perform off-node allocations for other (i.e. non-tmpfs)
memory needs.

Tightly synchronized HPC applications with large (on the order of
a single node's total RAM) per-task memory requirements are an example
of a type of application which benefits from this change.  Other
types of workloads may prefer local tmpfs allocations, thus a mount
option is provided.

The new mount option is "interleave=", and defaults to 0.  Any non-zero
setting turns on interleaving.  Interleaving behavior can be changed
via a remount operation.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

Index: linux/mm/mempolicy.c
===================================================================
--- linux.orig/mm/mempolicy.c	2004-11-03 10:24:16.000000000 -0600
+++ linux/mm/mempolicy.c	2004-11-03 10:26:30.000000000 -0600
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
--- linux.orig/fs/hugetlbfs/inode.c	2004-11-03 10:24:16.000000000 -0600
+++ linux/fs/hugetlbfs/inode.c	2004-11-03 10:26:30.000000000 -0600
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
--- linux.orig/include/linux/mempolicy.h	2004-11-03 10:24:16.000000000 -0600
+++ linux/include/linux/mempolicy.h	2004-11-03 10:26:30.000000000 -0600
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
--- linux.orig/mm/shmem.c	2004-11-03 10:24:16.000000000 -0600
+++ linux/mm/shmem.c	2004-11-05 17:41:46.000000000 -0600
@@ -66,6 +66,9 @@
 #define SHMEM_PAGEIN	 VM_READ
 #define SHMEM_TRUNCATE	 VM_WRITE

+/* sbinfo flags */
+#define SHMEM_INTERLEAVE 0x1	/* Interleave tmpfs allocations */
+
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20

@@ -1236,7 +1239,8 @@
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
- 		mpol_shared_policy_init(&info->policy);
+ 		mpol_shared_policy_init(&info->policy,
+			sbinfo && (sbinfo->flags & SHMEM_INTERLEAVE) ? 1 : 0);
 		INIT_LIST_HEAD(&info->swaplist);

 		switch (mode & S_IFMT) {
@@ -1784,7 +1788,9 @@
 #endif
 };

-static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid,
+				gid_t *gid, unsigned long *blocks,
+				unsigned long *inodes, int *interleave)
 {
 	char *this_char, *value, *rest;

@@ -1838,6 +1844,12 @@
 			*gid = simple_strtoul(value,&rest,0);
 			if (*rest)
 				goto bad_val;
+		} else if (!strcmp(this_char,"interleave")) {
+			if (!interleave)
+				continue;
+			*interleave = (0 != simple_strtoul(value,&rest,0));
+			if (*rest)
+				goto bad_val;
 		} else {
 			printk(KERN_ERR "tmpfs: Bad mount option %s\n",
 			       this_char);
@@ -1858,12 +1870,14 @@
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	unsigned long max_blocks = 0;
 	unsigned long max_inodes = 0;
+	int interleave = 0;

 	if (sbinfo) {
 		max_blocks = sbinfo->max_blocks;
 		max_inodes = sbinfo->max_inodes;
 	}
-	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes))
+	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks,
+				&max_inodes, &interleave))
 		return -EINVAL;
 	/* Keep it simple: disallow limited <-> unlimited remount */
 	if ((max_blocks || max_inodes) == !sbinfo)
@@ -1871,6 +1885,12 @@
 	/* But allow the pointless unlimited -> unlimited remount */
 	if (!sbinfo)
 		return 0;
+	/* Allow change of interleaving */
+	if (interleave)
+		sbinfo->flags |= SHMEM_INTERLEAVE;
+	else
+		sbinfo->flags &= ~SHMEM_INTERLEAVE;
+
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
 #endif
@@ -1900,6 +1920,7 @@
 #ifdef CONFIG_TMPFS
 	unsigned long blocks = 0;
 	unsigned long inodes = 0;
+	int interleave = 0;

 	/*
 	 * Per default we only allow half of the physical ram per
@@ -1912,12 +1933,12 @@
 		if (inodes > blocks)
 			inodes = blocks;

-		if (shmem_parse_options(data, &mode,
-					&uid, &gid, &blocks, &inodes))
+		if (shmem_parse_options(data, &mode, &uid, &gid, &blocks,
+					&inodes, &interleave))
 			return -EINVAL;
 	}

-	if (blocks || inodes) {
+	if (blocks || inodes || interleave) {
 		struct shmem_sb_info *sbinfo;
 		sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
 		if (!sbinfo)
@@ -1928,6 +1949,9 @@
 		sbinfo->free_blocks = blocks;
 		sbinfo->max_inodes = inodes;
 		sbinfo->free_inodes = inodes;
+		sbinfo->flags = 0;
+		if (interleave)
+			sbinfo->flags |= SHMEM_INTERLEAVE;
 	}
 	sb->s_xattr = shmem_xattr_handlers;
 #endif
Index: linux/include/linux/shmem_fs.h
===================================================================
--- linux.orig/include/linux/shmem_fs.h	2004-10-18 16:54:55.000000000 -0500
+++ linux/include/linux/shmem_fs.h	2004-11-05 17:35:25.000000000 -0600
@@ -26,6 +26,7 @@
 	unsigned long free_blocks;  /* How many are left for allocation */
 	unsigned long max_inodes;   /* How many inodes are allowed */
 	unsigned long free_inodes;  /* How many are left for allocation */
+	unsigned long flags;
 	spinlock_t    stat_lock;
 };


-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
