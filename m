Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVAEQdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVAEQdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVAEQdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:33:23 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:65016 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262500AbVAEQaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:30:46 -0500
Date: Wed, 5 Jan 2005 10:30:46 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
Message-ID: <20050105163046.GA2060@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a new version of the patch introducing the __vm_enough_memory
helper, which takes into account yesterday's suggestions.  The selinux/hooks.c
typo was definately a dangerous bug, and __vm_enough_memory() has been moved
to vm_enough_memory()'s original location in mm/mmap.c.

Thank you all for the comments.

-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-bk8/include/linux/mm.h
===================================================================
--- linux-2.6.10-bk8.orig/include/linux/mm.h	2005-01-05 08:59:54.000000000 -0600
+++ linux-2.6.10-bk8/include/linux/mm.h	2005-01-05 10:41:13.000000000 -0600
@@ -704,6 +704,7 @@ static inline void vma_nonlinear_insert(
 }
 
 /* mmap.c */
+extern int __vm_enough_memory(long pages, int cap_sys_admin);
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert);
 extern struct vm_area_struct *vma_merge(struct mm_struct *,
Index: linux-2.6.10-bk8/mm/mmap.c
===================================================================
--- linux-2.6.10-bk8.orig/mm/mmap.c	2005-01-05 08:59:55.000000000 -0600
+++ linux-2.6.10-bk8/mm/mmap.c	2005-01-05 10:42:33.000000000 -0600
@@ -61,10 +61,98 @@ int sysctl_overcommit_ratio = 50;	/* def
 int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;
 atomic_t vm_committed_space = ATOMIC_INIT(0);
 
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 0 means there is enough memory for the allocation to
+ * succeed and -ENOMEM implies there is not.
+ *
+ * We currently support three overcommit policies, which are set via the
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
+ *
+ * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
+ * Additional code 2002 Jul 20 by Robert Love.
+ *
+ * cap_sys_admin is 1 if the process has admin privileges, 0 otherwise.
+ *
+ * Note this is a helper function intended to be used by LSMs which
+ * wish to use this logic.
+ */
+int __vm_enough_memory(long pages, int cap_sys_admin)
+{
+	unsigned long free, allowed;
+
+	vm_acct_memory(pages);
+
+	/*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
+		return 0;
+
+	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
+		unsigned long n;
+
+		free = get_page_cache_size();
+		free += nr_swap_pages;
+
+		/*
+		 * Any slabs which are created with the
+		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
+		 * which are reclaimable, under pressure.  The dentry
+		 * cache and most inode caches should fall into this
+		 */
+		free += atomic_read(&slab_reclaim_pages);
+
+		/*
+		 * Leave the last 3% for root
+		 */
+		if (!cap_sys_admin)
+			free -= free / 32;
+
+		if (free > pages)
+			return 0;
+
+		/*
+		 * nr_free_pages() is very expensive on large systems,
+		 * only call if we're about to fail.
+		 */
+		n = nr_free_pages();
+		if (!cap_sys_admin)
+			n -= n / 32;
+		free += n;
+
+		if (free > pages)
+			return 0;
+		vm_unacct_memory(pages);
+		return -ENOMEM;
+	}
+
+	allowed = (totalram_pages - hugetlb_total_pages())
+	       	* sysctl_overcommit_ratio / 100;
+	/*
+	 * Leave the last 3% for root
+	 */
+	if (!cap_sys_admin)
+		allowed -= allowed / 32;
+	allowed += total_swap_pages;
+
+	/* Don't let a single process grow too big:
+	   leave 3% of the size of this process for other processes */
+	allowed -= current->mm->total_vm / 32;
+
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 0;
+
+	vm_unacct_memory(pages);
+
+	return -ENOMEM;
+}
+
 EXPORT_SYMBOL(sysctl_overcommit_memory);
 EXPORT_SYMBOL(sysctl_overcommit_ratio);
 EXPORT_SYMBOL(sysctl_max_map_count);
 EXPORT_SYMBOL(vm_committed_space);
+EXPORT_SYMBOL(__vm_enough_memory);
 
 /*
  * Requires inode->i_mapping->i_mmap_lock
Index: linux-2.6.10-bk8/security/commoncap.c
===================================================================
--- linux-2.6.10-bk8.orig/security/commoncap.c	2005-01-05 08:59:55.000000000 -0600
+++ linux-2.6.10-bk8/security/commoncap.c	2005-01-05 10:43:59.000000000 -0600
@@ -316,86 +316,13 @@ int cap_syslog (int type)
 	return 0;
 }
 
-/*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 0 means there is enough memory for the allocation to
- * succeed and -ENOMEM implies there is not.
- *
- * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
- *
- * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
- * Additional code 2002 Jul 20 by Robert Love.
- */
 int cap_vm_enough_memory(long pages)
 {
-	unsigned long free, allowed;
+	int cap_sys_admin = 0;
 
-	vm_acct_memory(pages);
-
-	/*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
-		return 0;
-
-	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
-		unsigned long n;
-
-		free = get_page_cache_size();
-		free += nr_swap_pages;
-
-		/*
-		 * Any slabs which are created with the
-		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
-		 * which are reclaimable, under pressure.  The dentry
-		 * cache and most inode caches should fall into this
-		 */
-		free += atomic_read(&slab_reclaim_pages);
-
-		/*
-		 * Leave the last 3% for root
-		 */
-		if (!capable(CAP_SYS_ADMIN))
-			free -= free / 32;
-
-		if (free > pages)
-			return 0;
-
-		/*
-		 * nr_free_pages() is very expensive on large systems,
-		 * only call if we're about to fail.
-		 */
-		n = nr_free_pages();
-		if (!capable(CAP_SYS_ADMIN))
-			n -= n / 32;
-		free += n;
-
-		if (free > pages)
-			return 0;
-		vm_unacct_memory(pages);
-		return -ENOMEM;
-	}
-
-	allowed = (totalram_pages - hugetlb_total_pages())
-	       	* sysctl_overcommit_ratio / 100;
-	/*
-	 * Leave the last 3% for root
-	 */
-	if (!capable(CAP_SYS_ADMIN))
-		allowed -= allowed / 32;
-	allowed += total_swap_pages;
-
-	/* Don't let a single process grow too big:
-	   leave 3% of the size of this process for other processes */
-	allowed -= current->mm->total_vm / 32;
-
-	if (atomic_read(&vm_committed_space) < allowed)
-		return 0;
-
-	vm_unacct_memory(pages);
-
-	return -ENOMEM;
+	if (cap_capable(current, CAP_SYS_ADMIN) == 0)
+		cap_sys_admin = 1;
+	return __vm_enough_memory(pages, cap_sys_admin);
 }
 
 EXPORT_SYMBOL(cap_capable);
Index: linux-2.6.10-bk8/security/dummy.c
===================================================================
--- linux-2.6.10-bk8.orig/security/dummy.c	2005-01-05 10:39:16.000000000 -0600
+++ linux-2.6.10-bk8/security/dummy.c	2005-01-05 10:51:50.000000000 -0600
@@ -108,69 +108,13 @@ static int dummy_settime(struct timespec
 	return 0;
 }
 
-/*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 0 means there is enough memory for the allocation to
- * succeed and -ENOMEM implies there is not.
- *
- * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
- */
 static int dummy_vm_enough_memory(long pages)
 {
-	unsigned long free, allowed;
+	int cap_sys_admin = 0;
 
-	vm_acct_memory(pages);
-
-	/*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
-		return 0;
-
-	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
-		free = get_page_cache_size();
-		free += nr_free_pages();
-		free += nr_swap_pages;
-
-		/*
-		 * Any slabs which are created with the
-		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
-		 * which are reclaimable, under pressure.  The dentry
-		 * cache and most inode caches should fall into this
-		 */
-		free += atomic_read(&slab_reclaim_pages);
-
-		/*
-		 * Leave the last 3% for root
-		 */
-		if (current->euid)
-			free -= free / 32;
-
-		if (free > pages)
-			return 0;
-		vm_unacct_memory(pages);
-		return -ENOMEM;
-	}
-
-	allowed = (totalram_pages - hugetlb_total_pages())
-		* sysctl_overcommit_ratio / 100;
-	allowed += total_swap_pages;
-
-	/* Leave the last 3% for root */
-	if (current->euid)
-		allowed -= allowed / 32;
-
-	/* Don't let a single process grow too big:
-	   leave 3% of the size of this process for other processes */
-	allowed -= current->mm->total_vm / 32;
-
-	if (atomic_read(&vm_committed_space) < allowed)
-		return 0;
-
-	vm_unacct_memory(pages);
-
-	return -ENOMEM;
+	if (dummy_capable(current, CAP_SYS_ADMIN) == 0)
+		cap_sys_admin = 1;
+	return __vm_enough_memory(pages, cap_sys_admin);
 }
 
 static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
Index: linux-2.6.10-bk8/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-bk8.orig/security/selinux/hooks.c	2005-01-05 10:39:16.000000000 -0600
+++ linux-2.6.10-bk8/security/selinux/hooks.c	2005-01-05 10:47:04.000000000 -0600
@@ -1515,69 +1515,29 @@ static int selinux_syslog(int type)
  * mapping. 0 means there is enough memory for the allocation to
  * succeed and -ENOMEM implies there is not.
  *
- * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
+ * Note that secondary_ops->capable and task_has_perm_noaudit return 0
+ * if the capability is granted, but __vm_enough_memory requires 1 if
+ * the capability is granted.
  *
- * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
- * Additional code 2002 Jul 20 by Robert Love.
+ * Do not audit the selinux permission check, as this is applied to all
+ * processes that allocate mappings.
  */
 static int selinux_vm_enough_memory(long pages)
 {
-	unsigned long free, allowed;
-	int rc;
+	int rc, cap_sys_admin = 0;
 	struct task_security_struct *tsec = current->security;
 
-	vm_acct_memory(pages);
-
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
-		return 0;
-
-	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
-		free = get_page_cache_size();
-		free += nr_free_pages();
-		free += nr_swap_pages;
-
-		/*
-		 * Any slabs which are created with the
-		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
-		 * which are reclaimable, under pressure.  The dentry
-		 * cache and most inode caches should fall into this
-		 */
-		free += atomic_read(&slab_reclaim_pages);
-
-		/*
-		 * Leave the last 3% for privileged processes.
-		 * Don't audit the check, as it is applied to all processes
-		 * that allocate mappings.
-		 */
-		rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
-		if (!rc) {
-			rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
-						  SECCLASS_CAPABILITY,
-						  CAP_TO_MASK(CAP_SYS_ADMIN), NULL);
-		}
-		if (rc)
-			free -= free / 32;
-
-		if (free > pages)
-			return 0;
-		vm_unacct_memory(pages);
-		return -ENOMEM;
-	}
-
-	allowed = (totalram_pages - hugetlb_total_pages())
-		* sysctl_overcommit_ratio / 100;
-	allowed += total_swap_pages;
-
-	if (atomic_read(&vm_committed_space) < allowed)
-		return 0;
+	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
+	if (rc == 0)
+		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
+					SECCLASS_CAPABILITY,
+					CAP_TO_MASK(CAP_SYS_ADMIN),
+					NULL);
 
-	vm_unacct_memory(pages);
+	if (rc == 0)
+		cap_sys_admin = 1;
 
-	return -ENOMEM;
+	return __vm_enough_memory(pages, cap_sys_admin);
 }
 
 /* binprm security operations */
