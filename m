Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWAMQVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWAMQVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWAMQVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:21:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43756 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422727AbWAMQVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:21:31 -0500
Date: Fri, 13 Jan 2006 10:21:19 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Brent Casavant <bcasavan@americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [Patch] Add tmpfs options for memory placement policies (Resend with corrected addresses).
Message-ID: <20060113162119.GF19156@lnx-holt.americas.sgi.com>
References: <20060113160406.GE19156@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113160406.GE19156@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch introduces a tmpfs mount option which allows specifying a
memory policy and a second option to specify the nodelist for that policy.
With the default policy, tmpfs will behave as it does today.  This patch
adds support for preferred, bind, and interleave policies.

The default policy will cause pages to be added to tmpfs files on the
node which is doing the writing.  Some jobs expect a single process to
create and manage the tmpfs files.  This results in a node which has a
significantly reduced number of free pages.

With this patch, the administrator can specify the policy and nodes for
that policy where they would prefer allocations.

This patch was originally written by Brent Casavant and Hugh Dickins.
I added support for the bind and preferred policies and the mpol_nodelist
mount option.


Signed-off-by: Brent Casavant <bcasavan@sgi.com>
Signed-off-by: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Robin Holt <holt@sgi.com>

----
Andrew,

Could you add this to the -mm tree?  I am not sure if you do this, but if
there are no complaints with this patch, would you consider pushing it
to Linus before 2.6.16-rc1?

Diffstat output.

 Documentation/filesystems/tmpfs.txt |   12 +++++++++++
 fs/hugetlbfs/inode.c                |    2 -
 include/linux/mempolicy.h           |   11 +++-------
 include/linux/shmem_fs.h            |    2 +
 mm/mempolicy.c                      |   24 ++++++++++++++++++++++
 mm/shmem.c                          |   39 +++++++++++++++++++++++++++++-------
 6 files changed, 75 insertions(+), 15 deletions(-)

Index: linux-2.6/Documentation/filesystems/tmpfs.txt
===================================================================
--- linux-2.6.orig/Documentation/filesystems/tmpfs.txt	2006-01-12 13:03:29.294732378 -0600
+++ linux-2.6/Documentation/filesystems/tmpfs.txt	2006-01-13 06:50:20.727105630 -0600
@@ -78,6 +78,18 @@ use up all the memory on the machine; bu
 that instance in a system with many cpus making intensive use of it.
 
 
+tmpfs has a mount option to set the NUMA memory allocation policy for
+all files in that instance:
+mpol=interleave		prefers to allocate memory from each node in turn
+mpol=default		prefers to allocate memory from the local node
+mpol=bind		prefers to allocate from mpol_nodelist
+mpol=preferred		prefers to allocate from first node in mpol_nodelist
+
+The following mount option is used in conjunction with mpol=interleave,
+mpol=bind or mpol=preferred:
+mpol_nodelist:	nodelist suitable for parsing with nodelist_parse.
+
+
 To specify the initial root directory you can use the following mount
 options:
 
Index: linux-2.6/fs/hugetlbfs/inode.c
===================================================================
--- linux-2.6.orig/fs/hugetlbfs/inode.c	2006-01-12 13:03:29.309379364 -0600
+++ linux-2.6/fs/hugetlbfs/inode.c	2006-01-13 06:58:55.566379423 -0600
@@ -401,7 +401,7 @@ static struct inode *hugetlbfs_get_inode
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = HUGETLBFS_I(inode);
-		mpol_shared_policy_init(&info->policy);
+		mpol_shared_policy_init(&info->policy, MPOL_DEFAULT, NULL);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
Index: linux-2.6/include/linux/mempolicy.h
===================================================================
--- linux-2.6.orig/include/linux/mempolicy.h	2006-01-12 13:03:29.314261693 -0600
+++ linux-2.6/include/linux/mempolicy.h	2006-01-13 06:38:02.610834339 -0600
@@ -132,12 +132,8 @@ struct shared_policy {
 	spinlock_t lock;
 };
 
-static inline void mpol_shared_policy_init(struct shared_policy *info)
-{
-	info->root = RB_ROOT;
-	spin_lock_init(&info->lock);
-}
-
+void mpol_shared_policy_init(struct shared_policy *info, int policy,
+				nodemask_t *nodes);
 int mpol_set_shared_policy(struct shared_policy *info,
 				struct vm_area_struct *vma,
 				struct mempolicy *new);
@@ -211,7 +207,8 @@ static inline int mpol_set_shared_policy
 	return -EINVAL;
 }
 
-static inline void mpol_shared_policy_init(struct shared_policy *info)
+static inline void mpol_shared_policy_init(struct shared_policy *info,
+					int policy, nodemask_t *nodes)
 {
 }
 
Index: linux-2.6/include/linux/shmem_fs.h
===================================================================
--- linux-2.6.orig/include/linux/shmem_fs.h	2006-01-12 13:03:29.315238158 -0600
+++ linux-2.6/include/linux/shmem_fs.h	2006-01-13 06:29:11.048546866 -0600
@@ -26,6 +26,8 @@ struct shmem_sb_info {
 	unsigned long free_blocks;  /* How many are left for allocation */
 	unsigned long max_inodes;   /* How many inodes are allowed */
 	unsigned long free_inodes;  /* How many are left for allocation */
+	int policy;		    /* Default NUMA memory alloc policy */
+	nodemask_t policy_nodes;    /* nodemask for preferred and bind */
 	spinlock_t    stat_lock;
 };
 
Index: linux-2.6/mm/mempolicy.c
===================================================================
--- linux-2.6.orig/mm/mempolicy.c	2006-01-12 13:03:29.315238158 -0600
+++ linux-2.6/mm/mempolicy.c	2006-01-13 09:16:22.264432446 -0600
@@ -1357,6 +1357,30 @@ restart:
 	return 0;
 }
 
+void mpol_shared_policy_init(struct shared_policy *info, int policy,
+				nodemask_t *policy_nodes)
+{
+	info->root = RB_ROOT;
+	spin_lock_init(&info->lock);
+
+	if (policy != MPOL_DEFAULT) {
+		struct mempolicy *newpol;
+
+		/* Falls back to MPOL_DEFAULT on any error */
+		newpol = mpol_new(policy, policy_nodes);
+		if (!IS_ERR(newpol)) {
+			/* Create pseudo-vma that contains just the policy */
+			struct vm_area_struct pvma;
+
+			memset(&pvma, 0, sizeof(struct vm_area_struct));
+			/* Policy covers entire file */
+			pvma.vm_end = TASK_SIZE;
+			mpol_set_shared_policy(info, &pvma, newpol);
+			mpol_free(newpol);
+		}
+	}
+}
+
 int mpol_set_shared_policy(struct shared_policy *info,
 			struct vm_area_struct *vma, struct mempolicy *npol)
 {
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c	2006-01-12 13:03:29.315238158 -0600
+++ linux-2.6/mm/shmem.c	2006-01-13 07:08:09.259198432 -0600
@@ -1316,7 +1316,8 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
-			mpol_shared_policy_init(&info->policy);
+			mpol_shared_policy_init(&info->policy, sbinfo->policy,
+							&sbinfo->policy_nodes);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1330,7 +1331,8 @@ shmem_get_inode(struct super_block *sb, 
 			 * Must not load anything in the rbtree,
 			 * mpol_free_shared_policy will not be called.
 			 */
-			mpol_shared_policy_init(&info->policy);
+			mpol_shared_policy_init(&info->policy, MPOL_DEFAULT,
+						NULL);
 			break;
 		}
 	} else if (sbinfo->max_inodes) {
@@ -1843,7 +1845,9 @@ static struct inode_operations shmem_sym
 	.put_link	= shmem_put_link,
 };
 
-static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid,
+	gid_t *gid, unsigned long *blocks, unsigned long *inodes,
+	int *policy, nodemask_t *policy_nodes)
 {
 	char *this_char, *value, *rest;
 
@@ -1897,6 +1901,19 @@ static int shmem_parse_options(char *opt
 			*gid = simple_strtoul(value,&rest,0);
 			if (*rest)
 				goto bad_val;
+		} else if (!strcmp(this_char,"mpol")) {
+			if (!strcmp(value,"default"))
+				*policy = MPOL_DEFAULT;
+			else if (!strcmp(value,"preferred"))
+				*policy = MPOL_PREFERRED;
+			else if (!strcmp(value,"bind"))
+				*policy = MPOL_BIND;
+			else if (!strcmp(value,"interleave"))
+				*policy = MPOL_INTERLEAVE;
+			else
+				goto bad_val;
+		} else if (!strcmp(this_char,"mpol_nodelist")) {
+			nodelist_parse(value, *policy_nodes);
 		} else {
 			printk(KERN_ERR "tmpfs: Bad mount option %s\n",
 			       this_char);
@@ -1917,12 +1934,14 @@ static int shmem_remount_fs(struct super
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	unsigned long max_blocks = sbinfo->max_blocks;
 	unsigned long max_inodes = sbinfo->max_inodes;
+	int policy = sbinfo->policy;
+	nodemask_t policy_nodes = sbinfo->policy_nodes;
 	unsigned long blocks;
 	unsigned long inodes;
 	int error = -EINVAL;
 
-	if (shmem_parse_options(data, NULL, NULL, NULL,
-				&max_blocks, &max_inodes))
+	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks,
+				&max_inodes, &policy, &policy_nodes))
 		return error;
 
 	spin_lock(&sbinfo->stat_lock);
@@ -1948,6 +1967,8 @@ static int shmem_remount_fs(struct super
 	sbinfo->free_blocks = max_blocks - blocks;
 	sbinfo->max_inodes  = max_inodes;
 	sbinfo->free_inodes = max_inodes - inodes;
+	sbinfo->policy = policy;
+	sbinfo->policy_nodes = policy_nodes;
 out:
 	spin_unlock(&sbinfo->stat_lock);
 	return error;
@@ -1972,6 +1993,8 @@ static int shmem_fill_super(struct super
 	struct shmem_sb_info *sbinfo;
 	unsigned long blocks = 0;
 	unsigned long inodes = 0;
+	int policy = MPOL_DEFAULT;
+	nodemask_t policy_nodes = node_online_map;
 
 #ifdef CONFIG_TMPFS
 	/*
@@ -1984,8 +2007,8 @@ static int shmem_fill_super(struct super
 		inodes = totalram_pages - totalhigh_pages;
 		if (inodes > blocks)
 			inodes = blocks;
-		if (shmem_parse_options(data, &mode, &uid, &gid,
-					&blocks, &inodes))
+		if (shmem_parse_options(data, &mode, &uid, &gid, &blocks,
+					&inodes, &policy, &policy_nodes))
 			return -EINVAL;
 	}
 #else
@@ -2003,6 +2026,8 @@ static int shmem_fill_super(struct super
 	sbinfo->free_blocks = blocks;
 	sbinfo->max_inodes = inodes;
 	sbinfo->free_inodes = inodes;
+	sbinfo->policy = policy;
+	sbinfo->policy_nodes = policy_nodes;
 
 	sb->s_fs_info = sbinfo;
 	sb->s_maxbytes = SHMEM_MAX_BYTES;
