Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWIPX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWIPX0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIPX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:26:12 -0400
Received: from nef2.ens.fr ([129.199.96.40]:38916 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964844AbWIPX0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:26:10 -0400
Date: Sun, 17 Sep 2006 01:25:40 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Louis Kruger <lpkruger@cs.wisc.edu>,
       "Bill O'Donnell" <billodo@sgi.com>,
       Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] security: add a "cuppabilities" security module (preliminary version)
Message-ID: <20060916232540.GA15092@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 17 Sep 2006 01:25:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a Linux Security Module called "cuppabilities", which
allows for an easy creation of underprivileged processes:

 * add a "cuppabilities" field to the task structure, and two prctl()
   calls (PR_GET_CUPS and PR_ADD_CUPS) which manipulate it,

 * add a LSM which forbids certain operations when various bits are
   set in this field (otherwise it also calls commoncap operations
   secondarily).

So far this is only a preliminary demonstration of concept, so only
very uninteresting cuppabilities are included: CUP_FORK, some variants
on CUP_EXEC (including CUP_EXEC_SXID) and CUP_PTRACE.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---

		*** IMPORTANT NOTE ***

	This patch IS NOT related (nor compatible) with the one posted
	a few days ago on this list under the name "new capabilities
	patch".  The latter treated underprivileged processes as
	lacking some capabilities.  It has been abandoned due to heavy
	criticism on LKML.  *This* patch adds a completely different
	field, "cuppabilities", and treats cuppabilities in a simpler
	fashion than capabilities (only one set per task rather than
	permitted/effective/inheritable, and just a simple prctl() to
	add cups - for example, a simple prctl(PR_ADD_CUPS,
	(1<<CUP_EXEC_SXID)) forbids suid/sgid exec from then on).

	This patch should not break (or indeed change!) anything for
	those who don't activate support for cuppabilities.

	Comments are appreciated on whether this is the right way to
	proceed, especially from those who criticized my earlier
	(aforementioned) capabilities patch.

	[Note that another feature of the earlier patch was that it
	included support for inheriting capabilities.  This is in no
	way addressed by this patch.  However, I also posted a patch,
	see <URL: http://lkml.org/lkml/2006/9/15/158 >, which adds a
	mount option to make capabilities inheritable by default while
	retaining POSIX.1e semantics.]

	Oh, and please don't tell me that CUP_EXEC is useless because
        a program can mmap() an executable in core, etc.  I know that.
        It's just a demonstration cuppability that's simple to
        implement, and it's not meant to be useful.  CUP_EXEC_SXID,
        however, is supposed to be (useful).
	
 fs/exec.c                   |    2 +
 include/linux/binfmts.h     |    1 
 include/linux/cuppability.h |   24 ++++++++
 include/linux/init_task.h   |    1 
 include/linux/prctl.h       |    4 +
 include/linux/sched.h       |    1 
 kernel/sys.c                |    7 ++
 security/Kconfig            |    9 +++
 security/Makefile           |    1 
 security/cuppability.c      |  128 +++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 178 insertions(+), 0 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 54135df..6a8eab5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,6 +929,7 @@ int prepare_binprm(struct linux_binprm *
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
 		if (mode & S_ISUID) {
+			bprm->is_suid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_uid = inode->i_uid;
 		}
@@ -940,6 +941,7 @@ int prepare_binprm(struct linux_binprm *
 		 * executable.
 		 */
 		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+			bprm->is_sgid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_gid = inode->i_gid;
 		}
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c1e82c5..c7fb183 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -29,6 +29,7 @@ struct linux_binprm{
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	char is_suid, is_sgid;
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
diff --git a/include/linux/cuppability.h b/include/linux/cuppability.h
new file mode 100644
index 0000000..3ffc376
--- /dev/null
+++ b/include/linux/cuppability.h
@@ -0,0 +1,24 @@
+/*
+ * This is <linux/cuppability.h>
+ *
+ * David A. Madore <david.madore@ens.fr>
+ */ 
+
+#ifndef _LINUX_CUPPABILITY_H
+#define _LINUX_CUPPABILITY_H
+
+#define CUP_NONE 0UL
+#define CUP_ALL 0xffffffUL
+
+#define CUP_TO_MASK(x) (1UL << (x))
+#define cup_raise(c, flag)   ((c) |=  CAP_TO_MASK(flag))
+#define cup_lower(c, flag)   ((c) &= ~CAP_TO_MASK(flag))
+#define cup_raised(c, flag)  ((c) & CAP_TO_MASK(flag))
+
+#define CUP_FORK		0 /* Forbid fork() */
+#define CUP_EXEC		1 /* Forbid exec() */
+#define CUP_EXEC_ONCE		2 /* Forbid exec() except just once */
+#define CUP_EXEC_SXID		3 /* Forbid s[ug]id exec() */
+#define CUP_PTRACE		4 /* Forbid ptrace() */
+
+#endif /* !_LINUX_CUPPABILITY_H */
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 60aac2c..1878bb8 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -110,6 +110,7 @@ #define INIT_TASK(tsk)	\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
 	.keep_capabilities = 0,						\
+	.cuppabilities  = 0,						\
 	.user		= INIT_USER,					\
 	.comm		= "swapper",					\
 	.thread		= INIT_THREAD,					\
diff --git a/include/linux/prctl.h b/include/linux/prctl.h
index 52a9be4..247d262 100644
--- a/include/linux/prctl.h
+++ b/include/linux/prctl.h
@@ -59,4 +59,8 @@ # define PR_ENDIAN_BIG		0
 # define PR_ENDIAN_LITTLE	1	/* True little endian mode */
 # define PR_ENDIAN_PPC_LITTLE	2	/* "PowerPC" pseudo little endian */
 
+/* Get/set process cuppabilities */
+#define PR_GET_CUPS    21
+#define PR_ADD_CUPS    22
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34ed0d9..6f5b69f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -859,6 +859,7 @@ #endif
 	struct group_info *group_info;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	unsigned keep_capabilities:1;
+	u32 cuppabilities;
 	struct user_struct *user;
 #ifdef CONFIG_KEYS
 	struct key *request_key_auth;	/* assumed request_key authority */
diff --git a/kernel/sys.c b/kernel/sys.c
index e236f98..2bf8564 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -18,6 +18,7 @@ #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/workqueue.h>
 #include <linux/capability.h>
+#include <linux/cuppability.h>
 #include <linux/device.h>
 #include <linux/key.h>
 #include <linux/times.h>
@@ -2055,6 +2056,12 @@ asmlinkage long sys_prctl(int option, un
 		case PR_SET_ENDIAN:
 			error = SET_ENDIAN(current, arg2);
 			break;
+		case PR_GET_CUPS:
+			error = current->cuppabilities;
+			break;
+		case PR_ADD_CUPS:
+			current->cuppabilities |= (arg2 & CUP_ALL);
+			break;
 
 		default:
 			error = -EINVAL;
diff --git a/security/Kconfig b/security/Kconfig
index 67785df..b76d239 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -93,6 +93,15 @@ config SECURITY_ROOTPLUG
 	  
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_CUPPABILITIES
+	tristate "Cuppabilities"
+	depends on SECURITY
+	help
+	  This implements cuppabilities (underprivileged processes) as
+	  an LSM module.
+	  
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_SECLVL
 	tristate "BSD Secure Levels"
 	depends on SECURITY
diff --git a/security/Makefile b/security/Makefile
index 8cbbf2f..2ebdca6 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -16,4 +16,5 @@ # Must precede capability.o in order to 
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_CUPPABILITIES)    += commoncap.o cuppability.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
diff --git a/security/cuppability.c b/security/cuppability.c
new file mode 100644
index 0000000..a7d4e79
--- /dev/null
+++ b/security/cuppability.c
@@ -0,0 +1,128 @@
+/*
+ * Cuppability Linux Security Module
+ *
+ * Copyright (C) 2006 David A. Madore <david.madore@ens.fr>
+ *
+ * Implements "cuppabilities" (underprivileged processes).
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/security.h>
+#include <linux/cuppability.h>
+
+static int secondary;
+
+#if defined(CONFIG_SECURITY_CUPPABILITY_MODULE)
+#define MY_NAME THIS_MODULE->name
+#else
+#define MY_NAME "cuppability"
+#endif
+
+static int cup_ptrace (struct task_struct *parent, struct task_struct *child)
+{
+	if (cup_raised (current->cuppabilities, CUP_PTRACE))
+		return -EPERM;
+	return cap_ptrace (parent, child);
+}
+
+static int cup_task_create (unsigned long clone_flags)
+{
+	if (cup_raised (current->cuppabilities, CUP_FORK))
+		return -EPERM;
+	return 0;
+}
+
+static void cup_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
+{
+	if (bprm->is_suid || bprm->is_sgid) {
+		current->cuppabilities = CUP_NONE;
+	}
+	cap_bprm_apply_creds (bprm, unsafe);
+}
+
+static int cup_bprm_set_security (struct linux_binprm *bprm)
+{
+	if (cup_raised (current->cuppabilities, CUP_EXEC))
+		return -EPERM;
+	if (cup_raised (current->cuppabilities, CUP_EXEC_ONCE))
+		current->cuppabilities = cup_raise (current->cuppabilities,
+						    CUP_EXEC);
+	if (cup_raised (current->cuppabilities, CUP_EXEC_SXID)
+	    && (bprm->is_suid || bprm->is_sgid))
+		return -EPERM;
+	return cap_bprm_set_security (bprm);
+}
+
+static struct security_operations cuppability_security_ops = {
+	/* Use commoncap */
+	.ptrace =			cup_ptrace,
+	.capget =			cap_capget,
+	.capset_check =			cap_capset_check,
+	.capset_set =			cap_capset_set,
+	.capable =			cap_capable,
+	.settime =			cap_settime,
+	.netlink_send =			cap_netlink_send,
+	.netlink_recv =			cap_netlink_recv,
+
+	.bprm_apply_creds =		cup_bprm_apply_creds,
+	.bprm_set_security =		cup_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
+
+	.inode_setxattr =		cap_inode_setxattr,
+	.inode_removexattr =		cap_inode_removexattr,
+
+	.task_create =			cup_task_create,
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.syslog =                       cap_syslog,
+
+	.vm_enough_memory =             cap_vm_enough_memory,
+};
+
+static int __init cuppability_init (void)
+{
+	printk (KERN_INFO "Initializing cuppability module\n");
+	/* register ourselves with the security framework */
+	if (register_security (&cuppability_security_ops)) {
+		/* try registering with primary module */
+		printk (KERN_INFO 
+			"Failed registering cuppability module as primary security module\n");
+		if (mod_reg_security (MY_NAME, &cuppability_security_ops)) {
+			printk (KERN_INFO "Failed registering cuppability module as secondary security module\n");
+			return -EINVAL;
+		}
+		secondary = 1;
+	}
+	return 0;
+}
+
+static void __exit cuppability_exit (void)
+{
+	/* remove ourselves from the security framework */
+	if (secondary) {
+		if (mod_unreg_security (MY_NAME, &cuppability_security_ops))
+			printk (KERN_ERR 
+				"Failed unregistering cuppability module as primary security module.\n");
+	} else { 
+		if (unregister_security (&cuppability_security_ops)) {
+			printk (KERN_ERR
+				"Failed unregistering cuppability module as secondary security module\n");
+		}
+	}
+	printk (KERN_INFO "Removing cuppability module\n");
+}
+
+security_initcall (cuppability_init);
+module_exit (cuppability_exit);
+
+MODULE_DESCRIPTION("Root Plug sample LSM module, written for Linux Journal article");
+MODULE_LICENSE("GPL");
+
