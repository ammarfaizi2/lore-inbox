Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVADVz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVADVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVADVya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:54:30 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2019 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262274AbVADVsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:48:32 -0500
Date: Tue, 4 Jan 2005 15:48:33 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
Message-ID: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch introduces a __vm_enough_memory function in
security/security.c which is used by cap_vm_enough_memory,
dummy_vm_enough_memory, and selinux_vm_enough_memory.  This has
been discussed on the lsm mailing list.

Are there any objections to or comments on this patch?

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-mm1/include/linux/security.h
===================================================================
--- linux-2.6.10-mm1.orig/include/linux/security.h	2005-01-04 16:42:10.000000000 -0600
+++ linux-2.6.10-mm1/include/linux/security.h	2005-01-04 16:42:33.000000000 -0600
@@ -1900,6 +1900,7 @@ extern int register_security	(struct sec
 extern int unregister_security	(struct security_operations *ops);
 extern int mod_reg_security	(const char *name, struct security_operations *ops);
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
+extern int __vm_enough_memory	(long pages, int cap_sys_admin);
 
 
 #else /* CONFIG_SECURITY */
Index: linux-2.6.10-mm1/security/commoncap.c
===================================================================
--- linux-2.6.10-mm1.orig/security/commoncap.c	2005-01-04 16:42:10.000000000 -0600
+++ linux-2.6.10-mm1/security/commoncap.c	2005-01-04 16:42:33.000000000 -0600
@@ -316,90 +316,10 @@ int cap_syslog (int type)
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
-
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
+	return __vm_enough_memory(pages,
+			(cap_capable(current, CAP_SYS_ADMIN) == 0));
 }
 
 EXPORT_SYMBOL(cap_capable);
Index: linux-2.6.10-mm1/security/dummy.c
===================================================================
--- linux-2.6.10-mm1.orig/security/dummy.c	2005-01-04 16:42:10.000000000 -0600
+++ linux-2.6.10-mm1/security/dummy.c	2005-01-04 16:42:33.000000000 -0600
@@ -111,69 +111,10 @@ static int dummy_settime(struct timespec
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
-
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
+	return __vm_enough_memory(pages,
+			(dummy_capable(current, CAP_SYS_ADMIN) == 0));
 }
 
 static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
Index: linux-2.6.10-mm1/security/security.c
===================================================================
--- linux-2.6.10-mm1.orig/security/security.c	2005-01-04 16:42:10.000000000 -0600
+++ linux-2.6.10-mm1/security/security.c	2005-01-04 16:44:19.000000000 -0600
@@ -17,6 +17,10 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/security.h>
+#include <linux/mman.h>
+#include <linux/swap.h>
+#include <linux/hugetlb.h>
+#include <linux/pagemap.h>
 
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
 
@@ -173,6 +177,90 @@ int mod_unreg_security(const char *name,
 	return security_ops->unregister_security(name, ops);
 }
 
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
 /**
  * capable - calls the currently loaded security module's capable() function with the specified capability
  * @cap: the requested capability level.
@@ -201,3 +289,4 @@ EXPORT_SYMBOL_GPL(mod_reg_security);
 EXPORT_SYMBOL_GPL(mod_unreg_security);
 EXPORT_SYMBOL(capable);
 EXPORT_SYMBOL(security_ops);
+EXPORT_SYMBOL(__vm_enough_memory);
Index: linux-2.6.10-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-mm1.orig/security/selinux/hooks.c	2005-01-04 16:42:10.000000000 -0600
+++ linux-2.6.10-mm1/security/selinux/hooks.c	2005-01-04 16:42:33.000000000 -0600
@@ -1521,69 +1521,26 @@ static int selinux_syslog(int type)
  * mapping. 0 means there is enough memory for the allocation to
  * succeed and -ENOMEM implies there is not.
  *
- * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
- *
- * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
- * Additional code 2002 Jul 20 by Robert Love.
+ * Note that secondary_ops->capable and task_has_perm return 0 if
+ * the capability is granted, but __vm_enough_memory requires 1 if
+ * the capability is granted.
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
+		cap_sys_admin = avc_has_perm_noaudit(tsec->sid, tsec->sid,
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
