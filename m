Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUKCQfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUKCQfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUKCQfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:35:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53991 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261699AbUKCQdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:33:07 -0500
Date: Wed, 3 Nov 2004 10:32:56 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <20041103090112.GJ8907@wotan.suse.de>
Message-ID: <Pine.SGI.4.58.0411031021160.79310@kzerza.americas.sgi.com>
References: <239530000.1099435919@flay> <Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain>
 <20041103090112.GJ8907@wotan.suse.de>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Andi Kleen wrote:

> If you want to go more finegraid then you can always use numactl
> or even libnuma in the application.  For a quick policy decision a sysctl
> is fine imho.

OK, so I'm not seeing a definitive stance by the interested parties
either way.  So since the code's already done, I'm posting the sysctl
method, and defaulting to on.  I assume that if we later decide that
a mount option was correct after all, that it's no big deal to axe the
sysctl?

The sysctl code in this patch is based on work originally done by
Andi.  It has been changed a bit, mostly to make it appear only
in CONFIG_NUMA && CONFIG_TMPFS kernels.

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
+++ linux/mm/shmem.c	2004-11-03 10:26:30.000000000 -0600
@@ -72,6 +72,12 @@
 /* Keep swapped page count in private field of indirect struct page */
 #define nr_swapped		private

+#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
+int sysctl_tmpfs_rr = 1;
+#else
+#define sysctl_tmpfs_rr (0)
+#endif
+
 /* Flag allocation requirements to shmem_getpage and shmem_swp_alloc */
 enum sgp_type {
 	SGP_QUICK,	/* don't try more than file page cache lookup */
@@ -1236,7 +1242,7 @@
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
- 		mpol_shared_policy_init(&info->policy);
+ 		mpol_shared_policy_init(&info->policy, sbinfo ? sysctl_tmpfs_rr : 0);
 		INIT_LIST_HEAD(&info->swaplist);

 		switch (mode & S_IFMT) {
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c	2004-11-03 10:24:20.000000000 -0600
+++ linux/kernel/sysctl.c	2004-11-03 10:26:30.000000000 -0600
@@ -74,6 +74,10 @@
 				  void __user *, size_t *, loff_t *);
 #endif

+#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
+extern int sysctl_tmpfs_rr;
+#endif
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -622,6 +626,16 @@
 		.maxlen         = sizeof (int),
 		.mode           = 0644,
 		.proc_handler   = &proc_unknown_nmi_panic,
+	},
+#endif
+#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
+	{
+		.ctl_name	= KERN_NUMA_TMPFS_RR,
+		.procname	= "numa-tmpfs-rr",
+		.data		= &sysctl_tmpfs_rr,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
 	},
 #endif
 	{ .ctl_name = 0 }
Index: linux/include/linux/sysctl.h
===================================================================
--- linux.orig/include/linux/sysctl.h	2004-11-03 10:26:20.000000000 -0600
+++ linux/include/linux/sysctl.h	2004-11-03 10:26:41.000000000 -0600
@@ -134,6 +134,7 @@
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
+	KERN_NUMA_TMPFS_RR=67,	/* int: NUMA interleave tmpfs allocations */
 };

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
