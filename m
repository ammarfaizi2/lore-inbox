Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVBSAxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVBSAxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVBSAw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:52:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:44998 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261595AbVBSAwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:52:00 -0500
Message-ID: <42168D9E.1010900@sgi.com>
Date: Fri, 18 Feb 2005 16:51:42 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton <akpm@osdl.org>
Subject: A common layer for Accounting packages
Content-Type: multipart/mixed;
 boundary="------------030208060800060603020506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030208060800060603020506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It started with the need of CSA to handle end-of-process (eop) at
do_exit() at exit.c. The hook at exit.c was BSD Accounting specific.

Since the need of Linux system accounting has gone beyond what BSD
accounting provides, i think it is a good idea to create a thin layer
of common code for various accounting packages, such as BSD accounting,
CSA, ELSA, etc. The hook to do_exit() at exit.c was changed to invoke
a routine in the common code which would then invoke those accounting
packages that register to the acct_common to handle do_exit situation.

Here is the description of this acct_common patch:
1) two new files at include/linux/acct_common.h and kernel/acct_common.c
2) A new config flag CONFIG_ACCT_COMMON is created and
    CONFIG_BSD_PROCESS_ACCT and a future CSA config flag depend on it.
    I think it is a good idea to always have acct_common in the kernel;
    in that case, the new config flag may not be really necessary. I can
    go either way.
3) Accounting packages can register themselves to acct_common for
    callbacks. Only do_exit handling is defined now. BSD acct.c has been
    modified to register/unergister to acct_common.
4) The 'enhanced acct data collection' routines have been moved from
    acct.c to acct_common.c. Files used to #include <linux/acct.h> were
    modified to #include <linux/acct_common.h>.

This patch was generated against 2.6.11-rc3-mm2.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------030208060800060603020506
Content-Type: text/plain;
 name="acct_common"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct_common"

Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2005-02-17 19:24:54.388927143 -0800
+++ linux/kernel/fork.c	2005-02-18 09:59:14.179816325 -0800
@@ -40,7 +40,7 @@
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
+#include <linux/acct_common.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2005-02-18 05:45:19.868493728 -0800
+++ linux/fs/exec.c	2005-02-18 09:59:14.196418021 -0800
@@ -47,7 +47,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
+#include <linux/acct_common.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2005-02-17 19:24:54.380138011 -0800
+++ linux/kernel/exit.c	2005-02-18 10:05:43.506174767 -0800
@@ -17,7 +17,7 @@
 #include <linux/key.h>
 #include <linux/security.h>
 #include <linux/cpu.h>
-#include <linux/acct.h>
+#include <linux/acct_common.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
@@ -814,7 +814,7 @@ fastcall NORET_TYPE void do_exit(long co
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
  		del_timer_sync(&tsk->signal->real_timer);
-		acct_process(code);
+		acct_do_exit(code, tsk);
 	}
 	exit_mm(tsk);
 
Index: linux/include/linux/acct_common.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/acct_common.h	2005-02-18 12:41:28.232626074 -0800
@@ -0,0 +1,83 @@
+/*
+ *  Copyright (c) 2005 Silicon Graphics, Inc.
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *  	Jay Lan <jlan@sgi.com>
+ */
+
+/*
+ *  include/linux/acct_common.h
+ *      
+ *  Common Accounting for Linux - Definitions
+ *
+ *  02/17/05 Jay Lan <jlan@sgi.com>. Initial creation of the header file.
+ * 	     This header file contains the definitions needed to support
+ *	     registration/unregistration of various accounting agents to
+ *	     the kernel. It also contains prototypes of common routines.
+ *
+ */
+
+#ifndef _LINUX_ACCT_COMMON_H
+#define _LINUX_ACCT_COMMON_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+
+
+/*
+ * Various accounting modules ID's
+ */
+#define ACCT_BSD	0
+#define ACCT_CSA	1
+#define ACCT_ELSA	2
+#define LAST_ACCT_ID	ACCT_ELSA
+#define ACCT_PKG_COUNT	(LAST_ACCT_ID+1)
+
+/* 
+ * Used by accounting packages to define the callback functions into the
+ * packages.
+ *
+ * STRUCT MEMBERS:
+ *   pkg_id:		Accounting package ID. This should be set the package
+ *			when register.
+ *   do_exit:		Function pointer to function used when do_exit()
+ *			hook is needed.
+ *			This is optional and may be set to NULL if it is
+ *			not needed by the accounting package.
+ */
+struct acct_hook {
+	int	pkg_id;	/* accounting package ID */
+	void	(*do_exit)(long exitcode, void *data);
+};
+
+
+/* Common accounting routines prototypes */
+extern int acct_register(struct acct_hook *);
+extern int acct_unregister(struct acct_hook *);
+
+#ifdef CONFIG_ACCT_COMMON
+extern void acct_do_exit(long, struct task_struct *tsk);
+extern void acct_update_integrals(struct task_struct *tsk);
+extern void acct_clear_integrals(struct task_struct *tsk);
+#else
+#define acct_do_exit(x,y)		do { } while (0)
+#define acct_update_integrals(x)	do { } while (0)
+#define acct_clear_integrals(x)		do { } while (0)
+#endif
+
+#endif	/* _LINUX_ACCT_COMMON_H */
Index: linux/include/linux/acct.h
===================================================================
--- linux.orig/include/linux/acct.h	2005-02-17 19:24:52.843016528 -0800
+++ linux/include/linux/acct.h	2005-02-18 10:02:00.557125382 -0800
@@ -119,14 +119,10 @@ struct acct_v3
 #ifdef CONFIG_BSD_PROCESS_ACCT
 struct super_block;
 extern void acct_auto_close(struct super_block *sb);
-extern void acct_process(long exitcode);
-extern void acct_update_integrals(struct task_struct *tsk);
-extern void acct_clear_integrals(struct task_struct *tsk);
+extern void acct_process(long exitcode, void *data);
 #else
 #define acct_auto_close(x)	do { } while (0)
-#define acct_process(x)		do { } while (0)
-#define acct_update_integrals(x)		do { } while (0)
-#define acct_clear_integrals(task)	do { } while (0)
+#define acct_process(x,y)	do { } while (0)
 #endif
 
 /*
Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c	2005-02-17 19:24:54.307871817 -0800
+++ linux/kernel/acct.c	2005-02-18 12:43:38.704382273 -0800
@@ -46,6 +46,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/acct_common.h>
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/tty.h>
@@ -89,6 +90,37 @@ struct acct_glbs {
 };
 
 static struct acct_glbs acct_globals __cacheline_aligned = {SPIN_LOCK_UNLOCKED};
+static struct acct_hook bsd_hook = {
+	.pkg_id		= ACCT_BSD,
+	.do_exit	= acct_process,
+};
+
+/*
+ * init routine of BSD Process Accounting
+ */
+static int __init
+acct_bsd_init(void)
+{
+	int retval = 0;
+
+	retval = acct_register(&bsd_hook);
+	if (retval == 0)
+		printk(KERN_INFO "BSD Process Accounting Initialized\n");
+	else
+		printk(KERN_ERR "BSD Process Accounting Init Failed\n");
+	return retval;
+}
+
+/*
+ * cleanup routine of BSD Process Accounting
+ */
+static void __exit
+acct_bsd_cleanup(void)
+{
+	(void)acct_unregister(&bsd_hook);
+	printk(KERN_INFO "BSD Proces Accounting Unregistered\n");
+	return;
+}
 
 /*
  * Called whenever the timer says to check the free space.
@@ -506,7 +538,7 @@ static void do_acct_process(long exitcod
 /*
  * acct_process - now just a wrapper around do_acct_process
  */
-void acct_process(long exitcode)
+void acct_process(long exitcode, void *data)
 {
 	struct file *file = NULL;
 
@@ -530,32 +562,5 @@ void acct_process(long exitcode)
 }
 
 
-/*
- * acct_update_integrals
- *    -  update mm integral fields in task_struct
- */
-void acct_update_integrals(struct task_struct *tsk)
-{
-	if (likely(tsk->mm)) {
-		long delta = tsk->stime - tsk->acct_stimexpd;
-
-		if (delta == 0)
-			return;
-		tsk->acct_stimexpd = tsk->stime;
-		tsk->acct_rss_mem1 += delta * tsk->mm->rss;
-		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
-	}
-}
-
-/*
- * acct_clear_integrals
- *    - clear the mm integral fields in task_struct
- */
-void acct_clear_integrals(struct task_struct *tsk)
-{
-	if (tsk) {
-		tsk->acct_stimexpd = 0;
-		tsk->acct_rss_mem1 = 0;
-		tsk->acct_vm_mem1 = 0;
-	}
-}
+module_init(acct_bsd_init);
+module_exit(acct_bsd_cleanup);
Index: linux/kernel/acct_common.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/acct_common.c	2005-02-18 12:39:06.266636027 -0800
@@ -0,0 +1,166 @@
+/*
+ *  Copyright (c) 2005 Silicon Graphics, Inc.
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *  	Jay Lan <jlan@sgi.com>
+ */
+
+/*
+ *  kernel/acct_common.c
+ *
+ *  Common Accounting routines for Linux Accounting
+ *
+ *  The acct.c mainly is BSD-style process accounting. However,
+ *  as more accounting packages are created, such as CSA and
+ *  ELSA, to extend the usage of the BSD accounting, there is
+ *  a need to have a common file for all accounting packages
+ *  including the BSD-style process accounting.
+ *
+ *  02/17/05 Jay Lan <jlan@sgi.com>. Initial creation of the file to
+ *	     provide common codes of Linux accounting. It also provides
+ *	     mechanism for various accounting agents to register and
+ *	     unregister to the kernel with callback hook. Only
+ *	     do_exit callback is supported initially.
+ *
+ */
+
+#include <linux/acct_common.h>
+#include <linux/module.h>
+
+
+/* Accounting packages list */
+static struct acct_hook	*acct_list[ACCT_PKG_COUNT] = {0};
+static			DECLARE_RWSEM(acct_list_sem);
+
+
+/*
+ * acct_register - accounting package registers to the kernel.
+ * @ap: The registering accounting package, in struct acct_pkg pointer type
+ *
+ * returns -errno value on failure, 0 on success.
+ */
+int
+acct_register(struct acct_hook *ap)
+{
+	if (!ap)
+		return -EINVAL;		/* Invalid value */
+	if (ap->pkg_id < 0 || ap->pkg_id > LAST_ACCT_ID)
+		return -EINVAL;		/* Invalid value */
+
+	down_write(&acct_list_sem);
+	if (acct_list[ap->pkg_id] != NULL) {
+		up_write(&acct_list_sem);
+		return -EBUSY;		/* Already registered */
+	}
+
+	acct_list[ap->pkg_id] = ap;
+	up_write(&acct_list_sem);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acct_register);
+
+
+/*
+ * acct_unregister - accounting package unregister to the kernel.
+ * @ap: The unregistering accounting package, in struct acct_hook pointer type
+ *
+ * Returns -errno on failure, 0 on success.
+ */
+int
+acct_unregister(struct acct_hook *ap)
+{
+	if (!ap)
+		return -EINVAL;		/* Invalid value */
+	if (ap->pkg_id < 0 || ap->pkg_id > LAST_ACCT_ID)
+		return -EINVAL;		/* Invalid value */
+
+	down_write(&acct_list_sem);
+
+	if (acct_list[ap->pkg_id] != ap) {
+		up_write(&acct_list_sem);
+		return -EFAULT;		/* Not matching entry */
+	}
+
+	acct_list[ap->pkg_id] = NULL;
+	up_write(&acct_list_sem);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acct_unregister);
+
+
+/*
+ * do_exit() hook for accounting packages
+ * @exitcode: the exitcode to pass along
+ *
+ */
+void acct_do_exit(long exitcode, struct task_struct *tsk)
+{
+	int i;
+
+	down_write(&acct_list_sem);
+	for (i=0; i < ACCT_PKG_COUNT; i++) {
+		if (acct_list[i] == NULL)	/* not registered */
+			continue;
+		if (acct_list[i]->do_exit != NULL) {	/* do_exit callback */
+			switch (acct_list[i]->pkg_id) {
+			    case ACCT_BSD:
+				acct_list[i]->do_exit(exitcode, NULL);
+				break;
+			    case ACCT_CSA:
+			    	acct_list[i]->do_exit(exitcode, tsk);
+				break;
+			    default:
+			    	break;
+			}
+		}
+	}
+	up_write(&acct_list_sem);
+	return;
+}
+
+
+/*
+ * acct_update_integrals
+ *    -  update mm integral fields in task_struct
+ */
+void acct_update_integrals(struct task_struct *tsk)
+{
+	if (likely(tsk->mm)) {
+		long delta = tsk->stime - tsk->acct_stimexpd;
+
+		if (delta == 0) return;
+		tsk->acct_stimexpd = tsk->stime;
+		tsk->acct_rss_mem1 += delta * tsk->mm->rss;
+		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
+	}
+}
+
+
+/*
+ * acct_clear_integrals
+ *    - clear the mm integral fields in task_struct
+ */
+void acct_clear_integrals(struct task_struct *tsk)
+{
+	if (tsk) {
+		tsk->acct_stimexpd = 0;
+		tsk->acct_rss_mem1 = 0;
+		tsk->acct_vm_mem1 = 0;
+	}
+}
+
+
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2005-02-17 19:24:54.485607592 -0800
+++ linux/kernel/Makefile	2005-02-18 10:04:23.279947003 -0800
@@ -16,6 +16,7 @@ obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
+obj-$(CONFIG_ACCT_COMMON) += acct_common.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2005-02-17 19:24:54.282480992 -0800
+++ linux/init/Kconfig	2005-02-18 09:59:14.330208158 -0800
@@ -113,8 +113,19 @@ config POSIX_MQUEUE
 
 	  If unsure, say Y.
 
+config ACCT_COMMON
+	bool "Accounting Comon Layer"
+	help
+	  If you say Y here, an accounting common code is built into the
+	  kernel. In addition to common code for various accounting
+	  agents, such as BSD Process Accounting, CSA, ELSA, etc., this code
+	  allows various accounting agents to register to it.
+
+	  If you ever need system accounting, you need this; so say Y.
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
+	depends on ACCT_COMMON
 	help
 	  If you say Y here, a user level program will be able to instruct the
 	  kernel (via a special system call) to write process accounting
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2005-02-17 19:24:54.628186840 -0800
+++ linux/kernel/sched.c	2005-02-18 11:13:14.200643593 -0800
@@ -48,7 +48,7 @@
 #include <linux/sysctl.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
-#include <linux/acct.h>
+#include <linux/acct_common.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>

--------------030208060800060603020506--

