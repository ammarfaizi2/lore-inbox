Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272216AbTHDUCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272215AbTHDUCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:02:14 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:60645 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S272216AbTHDUBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:01:32 -0400
Date: Mon, 4 Aug 2003 22:01:30 +0200
From: bert hubert <ahu@ds9a.nl>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com
Subject: [PATCH] LSM root_plug fixup
Message-ID: <20030804200130.GA8719@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, greg@kroah.com,
	linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

For root_plug, which is a fun way to demonstrate LSM, depends on
capability.o, but when loaded, capability.o installs its own security module
which won't accept root_plug anymore.

This patch abstracts out the functionality of capability.o which is needed
by root_plug, but leaves the actual security module in capability.o.

This creates the new file commoncap.c, which contains the functions
capability.o and root_plug.o both need.

It also fixes a cosmetic oddity in root_plug.

Please apply.

diff -uBbrN linux-2.6.0-test1/security/Makefile linux-2.6.0-test2-ahu/security/Makefile
--- linux-2.6.0-test1/security/Makefile	Mon Jul 14 05:36:37 2003
+++ linux-2.6.0-test2-ahu/security/Makefile	Mon Aug  4 19:49:58 2003
@@ -4,10 +4,10 @@
 
 # if we don't select a security model, use the default capabilities
 ifneq ($(CONFIG_SECURITY),y)
-obj-y		+= capability.o
+obj-y		+= commoncap.c capability.o
 endif
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o
-obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
-obj-$(CONFIG_SECURITY_ROOTPLUG)		+= root_plug.o
+obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
+obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
diff -uBbrN linux-2.6.0-test1/security/capability.c linux-2.6.0-test2-ahu/security/capability.c
--- linux-2.6.0-test1/security/capability.c	Mon Jul 14 05:32:43 2003
+++ linux-2.6.0-test2-ahu/security/capability.c	Mon Aug  4 19:48:26 2003
@@ -23,333 +23,6 @@
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
 
-int cap_capable (struct task_struct *tsk, int cap)
-{
-	/* Derived from include/linux/sched.h:capable. */
-	if (cap_raised (tsk->cap_effective, cap))
-		return 0;
-	else
-		return -EPERM;
-}
-
-int cap_ptrace (struct task_struct *parent, struct task_struct *child)
-{
-	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
-	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
-	    !capable (CAP_SYS_PTRACE))
-		return -EPERM;
-	else
-		return 0;
-}
-
-int cap_capget (struct task_struct *target, kernel_cap_t *effective,
-		kernel_cap_t *inheritable, kernel_cap_t *permitted)
-{
-	/* Derived from kernel/capability.c:sys_capget. */
-	*effective = cap_t (target->cap_effective);
-	*inheritable = cap_t (target->cap_inheritable);
-	*permitted = cap_t (target->cap_permitted);
-	return 0;
-}
-
-int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
-		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
-{
-	/* Derived from kernel/capability.c:sys_capset. */
-	/* verify restrictions on target's new Inheritable set */
-	if (!cap_issubset (*inheritable,
-			   cap_combine (target->cap_inheritable,
-					current->cap_permitted))) {
-		return -EPERM;
-	}
-
-	/* verify restrictions on target's new Permitted set */
-	if (!cap_issubset (*permitted,
-			   cap_combine (target->cap_permitted,
-					current->cap_permitted))) {
-		return -EPERM;
-	}
-
-	/* verify the _new_Effective_ is a subset of the _new_Permitted_ */
-	if (!cap_issubset (*effective, *permitted)) {
-		return -EPERM;
-	}
-
-	return 0;
-}
-
-void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
-		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
-{
-	target->cap_effective = *effective;
-	target->cap_inheritable = *inheritable;
-	target->cap_permitted = *permitted;
-}
-
-int cap_bprm_set_security (struct linux_binprm *bprm)
-{
-	/* Copied from fs/exec.c:prepare_binprm. */
-
-	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
-
-	/*  To support inheritance of root-permissions and suid-root
-	 *  executables under compatibility mode, we raise all three
-	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
-	 */
-
-	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
-			cap_set_full (bprm->cap_inheritable);
-			cap_set_full (bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0)
-			cap_set_full (bprm->cap_effective);
-	}
-	return 0;
-}
-
-/* Copied from fs/exec.c */
-static inline int must_not_trace_exec (struct task_struct *p)
-{
-	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
-}
-
-void cap_bprm_compute_creds (struct linux_binprm *bprm)
-{
-	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
-
-	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-	working = cap_intersect (bprm->cap_inheritable,
-				 current->cap_inheritable);
-	new_permitted = cap_combine (new_permitted, working);
-
-	task_lock(current);
-	if (!cap_issubset (new_permitted, current->cap_permitted)) {
-		current->mm->dumpable = 0;
-
-		if (must_not_trace_exec (current)
-		    || atomic_read (&current->fs->count) > 1
-		    || atomic_read (&current->files->count) > 1
-		    || atomic_read (&current->sighand->count) > 1) {
-			if (!capable (CAP_SETPCAP)) {
-				new_permitted = cap_intersect (new_permitted,
-							       current->
-							       cap_permitted);
-			}
-		}
-	}
-
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
-	}
-
-	/* AUD: Audit candidate if current->cap_effective is set */
-	task_unlock(current);
-
-	current->keep_capabilities = 0;
-}
-
-int cap_bprm_secureexec (struct linux_binprm *bprm)
-{
-	/* If/when this module is enhanced to incorporate capability
-	   bits on files, the test below should be extended to also perform a 
-	   test between the old and new capability sets.  For now,
-	   it simply preserves the legacy decision algorithm used by
-	   the old userland. */
-	return (current->euid != current->uid ||
-		current->egid != current->gid);
-}
-
-/* moved from kernel/sys.c. */
-/* 
- * cap_emulate_setxuid() fixes the effective / permitted capabilities of
- * a process after a call to setuid, setreuid, or setresuid.
- *
- *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
- *  {r,e,s}uid != 0, the permitted and effective capabilities are
- *  cleared.
- *
- *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
- *  capabilities of the process are cleared.
- *
- *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
- *  capabilities are set to the permitted capabilities.
- *
- *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
- *  never happen.
- *
- *  -astor 
- *
- * cevans - New behaviour, Oct '99
- * A process may, via prctl(), elect to keep its capabilities when it
- * calls setuid() and switches away from uid==0. Both permitted and
- * effective sets will be retained.
- * Without this change, it was impossible for a daemon to drop only some
- * of its privilege. The call to setuid(!=0) would drop all privileges!
- * Keeping uid 0 is not an option because uid 0 owns too many vital
- * files..
- * Thanks to Olaf Kirch and Peter Benie for spotting this.
- */
-static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
-					int old_suid)
-{
-	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
-	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
-	    !current->keep_capabilities) {
-		cap_clear (current->cap_permitted);
-		cap_clear (current->cap_effective);
-	}
-	if (old_euid == 0 && current->euid != 0) {
-		cap_clear (current->cap_effective);
-	}
-	if (old_euid != 0 && current->euid == 0) {
-		current->cap_effective = current->cap_permitted;
-	}
-}
-
-int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
-			  int flags)
-{
-	switch (flags) {
-	case LSM_SETID_RE:
-	case LSM_SETID_ID:
-	case LSM_SETID_RES:
-		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
-		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
-		}
-		break;
-	case LSM_SETID_FS:
-		{
-			uid_t old_fsuid = old_ruid;
-
-			/* Copied from kernel/sys.c:setfsuid. */
-
-			/*
-			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-			 *          if not, we might be a bit too harsh here.
-			 */
-
-			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-				if (old_fsuid == 0 && current->fsuid != 0) {
-					cap_t (current->cap_effective) &=
-					    ~CAP_FS_MASK;
-				}
-				if (old_fsuid != 0 && current->fsuid == 0) {
-					cap_t (current->cap_effective) |=
-					    (cap_t (current->cap_permitted) &
-					     CAP_FS_MASK);
-				}
-			}
-			break;
-		}
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-void cap_task_reparent_to_init (struct task_struct *p)
-{
-	p->cap_effective = CAP_INIT_EFF_SET;
-	p->cap_inheritable = CAP_INIT_INH_SET;
-	p->cap_permitted = CAP_FULL_SET;
-	p->keep_capabilities = 0;
-	return;
-}
-
-int cap_syslog (int type)
-{
-	if ((type != 3) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
-/*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 0 means there is enough memory for the allocation to
- * succeed and -ENOMEM implies there is not.
- *
- * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
- *
- * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
- * Additional code 2002 Jul 20 by Robert Love.
- */
-int cap_vm_enough_memory(long pages)
-{
-	unsigned long free, allowed;
-
-	vm_acct_memory(pages);
-
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == 1)
-		return 0;
-
-	if (sysctl_overcommit_memory == 0) {
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
-		if (!capable(CAP_SYS_ADMIN))
-			free -= free / 32;
-
-		if (free > pages)
-			return 0;
-		vm_unacct_memory(pages);
-		return -ENOMEM;
-	}
-
-	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
-	allowed += total_swap_pages;
-
-	if (atomic_read(&vm_committed_space) < allowed)
-		return 0;
-
-	vm_unacct_memory(pages);
-
-	return -ENOMEM;
-}
-
-EXPORT_SYMBOL(cap_capable);
-EXPORT_SYMBOL(cap_ptrace);
-EXPORT_SYMBOL(cap_capget);
-EXPORT_SYMBOL(cap_capset_check);
-EXPORT_SYMBOL(cap_capset_set);
-EXPORT_SYMBOL(cap_bprm_set_security);
-EXPORT_SYMBOL(cap_bprm_compute_creds);
-EXPORT_SYMBOL(cap_bprm_secureexec);
-EXPORT_SYMBOL(cap_task_post_setuid);
-EXPORT_SYMBOL(cap_task_reparent_to_init);
-EXPORT_SYMBOL(cap_syslog);
-EXPORT_SYMBOL(cap_vm_enough_memory);
-
 #ifdef CONFIG_SECURITY
 
 

diff -uBbrN linux-2.6.0-test1/security/commoncap.c linux-2.6.0-test2-ahu/security/commoncap.c
--- linux-2.6.0-test1/security/commoncap.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6.0-test2-ahu/security/commoncap.c	Mon Aug  4 19:48:19 2003
@@ -0,0 +1,341 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/smp_lock.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/ptrace.h>
+
+int cap_capable (struct task_struct *tsk, int cap)
+{
+	/* Derived from include/linux/sched.h:capable. */
+	if (cap_raised (tsk->cap_effective, cap))
+		return 0;
+	else
+		return -EPERM;
+}
+
+int cap_ptrace (struct task_struct *parent, struct task_struct *child)
+{
+	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
+	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
+	    !capable (CAP_SYS_PTRACE))
+		return -EPERM;
+	else
+		return 0;
+}
+
+int cap_capget (struct task_struct *target, kernel_cap_t *effective,
+		kernel_cap_t *inheritable, kernel_cap_t *permitted)
+{
+	/* Derived from kernel/capability.c:sys_capget. */
+	*effective = cap_t (target->cap_effective);
+	*inheritable = cap_t (target->cap_inheritable);
+	*permitted = cap_t (target->cap_permitted);
+	return 0;
+}
+
+int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
+		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
+{
+	/* Derived from kernel/capability.c:sys_capset. */
+	/* verify restrictions on target's new Inheritable set */
+	if (!cap_issubset (*inheritable,
+			   cap_combine (target->cap_inheritable,
+					current->cap_permitted))) {
+		return -EPERM;
+	}
+
+	/* verify restrictions on target's new Permitted set */
+	if (!cap_issubset (*permitted,
+			   cap_combine (target->cap_permitted,
+					current->cap_permitted))) {
+		return -EPERM;
+	}
+
+	/* verify the _new_Effective_ is a subset of the _new_Permitted_ */
+	if (!cap_issubset (*effective, *permitted)) {
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
+		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
+{
+	target->cap_effective = *effective;
+	target->cap_inheritable = *inheritable;
+	target->cap_permitted = *permitted;
+}
+
+int cap_bprm_set_security (struct linux_binprm *bprm)
+{
+	/* Copied from fs/exec.c:prepare_binprm. */
+
+	/* We don't have VFS support for capabilities yet */
+	cap_clear (bprm->cap_inheritable);
+	cap_clear (bprm->cap_permitted);
+	cap_clear (bprm->cap_effective);
+
+	/*  To support inheritance of root-permissions and suid-root
+	 *  executables under compatibility mode, we raise all three
+	 *  capability sets for the file.
+	 *
+	 *  If only the real uid is 0, we only raise the inheritable
+	 *  and permitted sets of the executable file.
+	 */
+
+	if (!issecure (SECURE_NOROOT)) {
+		if (bprm->e_uid == 0 || current->uid == 0) {
+			cap_set_full (bprm->cap_inheritable);
+			cap_set_full (bprm->cap_permitted);
+		}
+		if (bprm->e_uid == 0)
+			cap_set_full (bprm->cap_effective);
+	}
+	return 0;
+}
+
+/* Copied from fs/exec.c */
+static inline int must_not_trace_exec (struct task_struct *p)
+{
+	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
+}
+
+void cap_bprm_compute_creds (struct linux_binprm *bprm)
+{
+	/* Derived from fs/exec.c:compute_creds. */
+	kernel_cap_t new_permitted, working;
+
+	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
+	working = cap_intersect (bprm->cap_inheritable,
+				 current->cap_inheritable);
+	new_permitted = cap_combine (new_permitted, working);
+
+	task_lock(current);
+	if (!cap_issubset (new_permitted, current->cap_permitted)) {
+		current->mm->dumpable = 0;
+
+		if (must_not_trace_exec (current)
+		    || atomic_read (&current->fs->count) > 1
+		    || atomic_read (&current->files->count) > 1
+		    || atomic_read (&current->sighand->count) > 1) {
+			if (!capable (CAP_SETPCAP)) {
+				new_permitted = cap_intersect (new_permitted,
+							       current->
+							       cap_permitted);
+			}
+		}
+	}
+
+	/* For init, we want to retain the capabilities set
+	 * in the init_task struct. Thus we skip the usual
+	 * capability rules */
+	if (current->pid != 1) {
+		current->cap_permitted = new_permitted;
+		current->cap_effective =
+		    cap_intersect (new_permitted, bprm->cap_effective);
+	}
+
+	/* AUD: Audit candidate if current->cap_effective is set */
+	task_unlock(current);
+
+	current->keep_capabilities = 0;
+}
+
+int cap_bprm_secureexec (struct linux_binprm *bprm)
+{
+	/* If/when this module is enhanced to incorporate capability
+	   bits on files, the test below should be extended to also perform a 
+	   test between the old and new capability sets.  For now,
+	   it simply preserves the legacy decision algorithm used by
+	   the old userland. */
+	return (current->euid != current->uid ||
+		current->egid != current->gid);
+}
+
+/* moved from kernel/sys.c. */
+/* 
+ * cap_emulate_setxuid() fixes the effective / permitted capabilities of
+ * a process after a call to setuid, setreuid, or setresuid.
+ *
+ *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
+ *  {r,e,s}uid != 0, the permitted and effective capabilities are
+ *  cleared.
+ *
+ *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
+ *  capabilities of the process are cleared.
+ *
+ *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
+ *  capabilities are set to the permitted capabilities.
+ *
+ *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
+ *  never happen.
+ *
+ *  -astor 
+ *
+ * cevans - New behaviour, Oct '99
+ * A process may, via prctl(), elect to keep its capabilities when it
+ * calls setuid() and switches away from uid==0. Both permitted and
+ * effective sets will be retained.
+ * Without this change, it was impossible for a daemon to drop only some
+ * of its privilege. The call to setuid(!=0) would drop all privileges!
+ * Keeping uid 0 is not an option because uid 0 owns too many vital
+ * files..
+ * Thanks to Olaf Kirch and Peter Benie for spotting this.
+ */
+static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
+					int old_suid)
+{
+	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
+	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
+	    !current->keep_capabilities) {
+		cap_clear (current->cap_permitted);
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid == 0 && current->euid != 0) {
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid != 0 && current->euid == 0) {
+		current->cap_effective = current->cap_permitted;
+	}
+}
+
+int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
+			  int flags)
+{
+	switch (flags) {
+	case LSM_SETID_RE:
+	case LSM_SETID_ID:
+	case LSM_SETID_RES:
+		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
+		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
+		}
+		break;
+	case LSM_SETID_FS:
+		{
+			uid_t old_fsuid = old_ruid;
+
+			/* Copied from kernel/sys.c:setfsuid. */
+
+			/*
+			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
+			 *          if not, we might be a bit too harsh here.
+			 */
+
+			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+				if (old_fsuid == 0 && current->fsuid != 0) {
+					cap_t (current->cap_effective) &=
+					    ~CAP_FS_MASK;
+				}
+				if (old_fsuid != 0 && current->fsuid == 0) {
+					cap_t (current->cap_effective) |=
+					    (cap_t (current->cap_permitted) &
+					     CAP_FS_MASK);
+				}
+			}
+			break;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void cap_task_reparent_to_init (struct task_struct *p)
+{
+	p->cap_effective = CAP_INIT_EFF_SET;
+	p->cap_inheritable = CAP_INIT_INH_SET;
+	p->cap_permitted = CAP_FULL_SET;
+	p->keep_capabilities = 0;
+	return;
+}
+
+int cap_syslog (int type)
+{
+	if ((type != 3) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	return 0;
+}
+
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 0 means there is enough memory for the allocation to
+ * succeed and -ENOMEM implies there is not.
+ *
+ * We currently support three overcommit policies, which are set via the
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ *
+ * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
+ * Additional code 2002 Jul 20 by Robert Love.
+ */
+int cap_vm_enough_memory(long pages)
+{
+	unsigned long free, allowed;
+
+	vm_acct_memory(pages);
+
+        /*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory == 1)
+		return 0;
+
+	if (sysctl_overcommit_memory == 0) {
+		free = get_page_cache_size();
+		free += nr_free_pages();
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
+		if (!capable(CAP_SYS_ADMIN))
+			free -= free / 32;
+
+		if (free > pages)
+			return 0;
+		vm_unacct_memory(pages);
+		return -ENOMEM;
+	}
+
+	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed += total_swap_pages;
+
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 0;
+
+	vm_unacct_memory(pages);
+
+	return -ENOMEM;
+}
+
+EXPORT_SYMBOL(cap_capable);
+EXPORT_SYMBOL(cap_ptrace);
+EXPORT_SYMBOL(cap_capget);
+EXPORT_SYMBOL(cap_capset_check);
+EXPORT_SYMBOL(cap_capset_set);
+EXPORT_SYMBOL(cap_bprm_set_security);
+EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_bprm_secureexec);
+EXPORT_SYMBOL(cap_task_post_setuid);
+EXPORT_SYMBOL(cap_task_reparent_to_init);
+EXPORT_SYMBOL(cap_syslog);
+EXPORT_SYMBOL(cap_vm_enough_memory);

diff -uBbrN linux-2.6.0-test1/security/root_plug.c linux-2.6.0-test2-ahu/security/root_plug.c
--- linux-2.6.0-test1/security/root_plug.c	Mon Jul 14 05:38:46 2003
+++ linux-2.6.0-test2-ahu/security/root_plug.c	Mon Aug  4 19:42:52 2003
@@ -108,7 +108,7 @@
 		/* try registering with primary module */
 		if (mod_reg_security (MY_NAME, &rootplug_security_ops)) {
 			printk (KERN_INFO "Failure registering Root Plug "
-				" module with primary security module.\n");
+				"module with primary security module.\n");
 			return -EINVAL;
 		}
 		secondary = 1;
@@ -124,7 +124,7 @@
 	if (secondary) {
 		if (mod_unreg_security (MY_NAME, &rootplug_security_ops))
 			printk (KERN_INFO "Failure unregistering Root Plug "
-				" module with primary module.\n");
+				"module with primary module.\n");
 	} else { 
 		if (unregister_security (&rootplug_security_ops)) {
 			printk (KERN_INFO "Failure unregistering Root Plug "


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
