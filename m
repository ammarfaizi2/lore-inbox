Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVFWGmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVFWGmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVFWGkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:40:46 -0400
Received: from [24.22.56.4] ([24.22.56.4]:28134 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262313AbVFWGTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:01 -0400
Message-Id: <20050623061754.168101000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:15:53 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Shailabh Nagar <nagar@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 01/38] CKRM e18: Core CKRM Event Callbacks
Content-Disposition: inline; filename=01-diff_ckrm_events
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core CKRM Event Callbacks.

On exec, fork, exit, real/effective gid/uid, use CKRM to associate
tasks with appropriate class.

Addressed all review comments except:
        Use of __bitwise and sparse in enum's
        Use of kernel list type

Signed-off-by:  Shailabh Nagar <nagar@us.ibm.com>
Signed-off-by:  Hubertus Franke <frankeh@us.ibm.com>
Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Gerrit Huizenga <gh@us.ibm.com>


 fs/exec.c                   |    2 
 include/linux/ckrm_events.h |  192 ++++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig                |   16 +++
 kernel/Makefile             |    1 
 kernel/ckrm/Makefile        |    5 +
 kernel/ckrm/ckrm_events.c   |   86 +++++++++++++++++++
 kernel/exit.c               |    3 
 kernel/fork.c               |    4 
 kernel/sys.c                |   10 ++
 9 files changed, 319 insertions(+)

Index: linux-2.6.12-ckrm1/fs/exec.c
===================================================================
--- linux-2.6.12-ckrm1.orig/fs/exec.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/fs/exec.c	2005-06-20 13:08:20.000000000 -0700
@@ -48,6 +48,7 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1090,6 +1091,7 @@ int search_binary_handler(struct linux_b
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
+				ckrm_cb_exec(bprm->filename);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
Index: linux-2.6.12-ckrm1/include/linux/ckrm_events.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/include/linux/ckrm_events.h	2005-06-20 13:08:20.000000000 -0700
@@ -0,0 +1,192 @@
+/*
+ * ckrm_events.h - Class-based Kernel Resource Management (CKRM)
+ *                 event handling
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *
+ *
+ * Provides a base header file including macros and basic data structures.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#ifndef _LINUX_CKRM_EVENTS_H
+#define _LINUX_CKRM_EVENTS_H
+
+#ifdef CONFIG_CKRM
+
+/*
+ * Data structure and function to get the list of registered
+ * resource controllers.
+ */
+
+/*
+ * CKRM defines a set of events at particular points in the kernel
+ * at which callbacks registered by various class types are called
+ */
+
+enum ckrm_event {
+	/*
+	 * we distinguish these events types:
+	 *
+	 * (a) CKRM_LATCHABLE_EVENTS
+	 *      events can be latched for event callbacks by classtypes
+	 *
+	 * (b) CKRM_NONLATACHBLE_EVENTS
+	 *     events can not be latched but can be used to call classification
+	 *
+	 * (c) event that are used for notification purposes
+	 *     range: [ CKRM_EVENT_CANNOT_CLASSIFY .. )
+	 */
+
+	/* events (a) */
+
+	CKRM_LATCHABLE_EVENTS,
+
+	CKRM_EVENT_NEWTASK = CKRM_LATCHABLE_EVENTS,
+	CKRM_EVENT_FORK,
+	CKRM_EVENT_EXIT,
+	CKRM_EVENT_EXEC,
+	CKRM_EVENT_UID,
+	CKRM_EVENT_GID,
+	CKRM_EVENT_LOGIN,
+	CKRM_EVENT_USERADD,
+	CKRM_EVENT_USERDEL,
+	CKRM_EVENT_LISTEN_START,
+	CKRM_EVENT_LISTEN_STOP,
+	CKRM_EVENT_APPTAG,
+
+	/* events (b) */
+
+	CKRM_NONLATCHABLE_EVENTS,
+
+	CKRM_EVENT_RECLASSIFY = CKRM_NONLATCHABLE_EVENTS,
+
+	/* events (c) */
+
+	CKRM_NOTCLASSIFY_EVENTS,
+
+	CKRM_EVENT_MANUAL = CKRM_NOTCLASSIFY_EVENTS,
+
+	CKRM_NUM_EVENTS
+};
+
+/*
+ * CKRM event callback specification for the classtypes or resource controllers
+ *   typically an array is specified using CKRM_EVENT_SPEC terminated with
+ *   CKRM_EVENT_SPEC_LAST and then that array is registered using
+ *   ckrm_register_event_set.
+ *   Individual registration of event_cb is also possible
+ */
+
+struct ckrm_hook_cb {
+	void (*fct)(void *arg);
+	struct ckrm_hook_cb *next;
+};
+
+struct ckrm_event_spec {
+	enum ckrm_event ev;
+	struct ckrm_hook_cb cb;
+};
+
+int ckrm_register_event_set(struct ckrm_event_spec especs[]);
+int ckrm_unregister_event_set(struct ckrm_event_spec especs[]);
+int ckrm_register_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb);
+int ckrm_unregister_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb);
+
+extern void ckrm_invoke_event_cb_chain(enum ckrm_event ev, void *arg);
+
+/* forward declarations for function arguments */
+struct task_struct;
+struct sock;
+struct user_struct;
+
+static inline void ckrm_cb_fork(struct task_struct *p)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_FORK, p);
+}
+
+static inline void ckrm_cb_newtask(struct task_struct *p)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_NEWTASK, p);
+}
+
+static inline void ckrm_cb_exit(struct task_struct *p)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_EXIT, p);
+}
+
+static inline void ckrm_cb_exec(char *c)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_EXEC, c);
+}
+
+static inline void ckrm_cb_uid(void)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_UID, NULL);
+}
+
+static inline void ckrm_cb_gid(void)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_GID, NULL);
+}
+
+static inline void ckrm_cb_apptag(void)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_APPTAG, NULL);
+}
+
+static inline void ckrm_cb_login(void)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_LOGIN, NULL);
+}
+
+static inline void ckrm_cb_useradd(struct user_struct *u)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_USERADD, u);
+}
+
+static inline void ckrm_cb_userdel(struct user_struct *u)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_USERDEL, u);
+}
+
+static inline void ckrm_cb_listen_start(struct sock *s)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_LISTEN_START, s);
+}
+
+static inline void ckrm_cb_listen_stop(struct sock *s)
+{
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_LISTEN_STOP, s);
+}
+
+#else /* !CONFIG_CKRM */
+
+static inline void ckrm_cb_fork(struct task_struct *p) { }
+static inline void ckrm_cb_newtask(struct task_struct *p) { }
+static inline void ckrm_cb_exit(struct task_struct *p) { }
+static inline void ckrm_cb_exec(const char *c) { }
+static inline void ckrm_cb_uid(void) { }
+static inline void ckrm_cb_gid(void) { }
+static inline void ckrm_cb_apptag(void) { }
+static inline void ckrm_cb_login(void) { }
+static inline void ckrm_cb_useradd(struct user_struct *u) { }
+static inline void ckrm_cb_userdel(struct user_struct *u) { }
+static inline void ckrm_cb_listen_start(struct sock *s) { }
+static inline void ckrm_cb_listen_stop(struct sock *s) { }
+
+#endif /* CONFIG_CKRM */
+
+#endif /* _LINUX_CKRM_EVENTS_H */
Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 13:08:20.000000000 -0700
@@ -146,6 +146,22 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+menu "Class Based Kernel Resource Management"
+
+config CKRM
+	bool "Class Based Kernel Resource Management Core"
+	depends on EXPERIMENTAL
+	help
+	  Class-based Kernel Resource Management is a framework for controlling
+	  and monitoring resource allocation of user-defined groups of tasks or
+	  incoming socket connections. For more information, please visit
+	  http://ckrm.sf.net.
+
+	  If you say Y here, enable the Resource Class File System and at least
+	  one of the resource controllers below. Say N if you are unsure.
+
+endmenu
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_events.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_events.c	2005-06-20 13:08:20.000000000 -0700
@@ -0,0 +1,86 @@
+/* ckrm_events.c - Class-based Kernel Resource Management (CKRM)
+ *               - event handling routines
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ *           (C) Chandra Seetharaman,  IBM Corp. 2003
+ *
+ *
+ * Provides API for event registration and handling for different
+ * classtypes.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/ckrm_events.h>
+
+/*******************************************************************
+ *   Event callback invocation
+ *******************************************************************/
+
+struct ckrm_hook_cb *ckrm_event_callbacks[CKRM_NONLATCHABLE_EVENTS];
+
+/* Registration / Deregistration / Invocation functions */
+
+int ckrm_register_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb)
+{
+	struct ckrm_hook_cb **cbptr;
+
+	if ((ev < CKRM_LATCHABLE_EVENTS) || (ev >= CKRM_NONLATCHABLE_EVENTS))
+		return 1;
+	cbptr = &ckrm_event_callbacks[ev];
+	while (*cbptr != NULL)
+		cbptr = &((*cbptr)->next);
+	*cbptr = cb;
+	return 0;
+}
+
+int ckrm_unregister_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb)
+{
+	struct ckrm_hook_cb **cbptr;
+
+	if ((ev < CKRM_LATCHABLE_EVENTS) || (ev >= CKRM_NONLATCHABLE_EVENTS))
+		return -1;
+	cbptr = &ckrm_event_callbacks[ev];
+	while ((*cbptr != NULL) && (*cbptr != cb))
+		cbptr = &((*cbptr)->next);
+	if (*cbptr)
+		(*cbptr)->next = cb->next;
+	return (*cbptr == NULL);
+}
+
+int ckrm_register_event_set(struct ckrm_event_spec especs[])
+{
+	struct ckrm_event_spec *espec = especs;
+
+	for (espec = especs; espec->ev != -1; espec++)
+		ckrm_register_event_cb(espec->ev, &espec->cb);
+	return 0;
+}
+
+int ckrm_unregister_event_set(struct ckrm_event_spec especs[])
+{
+	struct ckrm_event_spec *espec = especs;
+
+	for (espec = especs; espec->ev != -1; espec++)
+		ckrm_unregister_event_cb(espec->ev, &espec->cb);
+	return 0;
+}
+
+void ckrm_invoke_event_cb_chain(enum ckrm_event ev, void *arg)
+{
+	struct ckrm_hook_cb *cb, *anchor;
+
+	if ((anchor = ckrm_event_callbacks[ev]) != NULL) {
+		for (cb = anchor; cb; cb = cb->next)
+			(*cb->fct) (arg);
+	}
+}
+
Index: linux-2.6.12-ckrm1/kernel/ckrm/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/Makefile	2005-06-20 13:08:20.000000000 -0700
@@ -0,0 +1,5 @@
+#
+# Makefile for CKRM
+#
+
+obj-y := ckrm_events.o
Index: linux-2.6.12-ckrm1/kernel/exit.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/exit.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/exit.c	2005-06-20 13:08:20.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -655,6 +656,8 @@ static void exit_notify(struct task_stru
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
+	ckrm_cb_exit(tsk);
+
 	if (signal_pending(tsk) && !(tsk->signal->flags & SIGNAL_GROUP_EXIT)
 	    && !thread_group_empty(tsk)) {
 		/*
Index: linux-2.6.12-ckrm1/kernel/fork.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/fork.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/fork.c	2005-06-20 13:08:20.000000000 -0700
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -174,6 +175,7 @@ static struct task_struct *dup_task_stru
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
+	ckrm_cb_newtask(tsk);
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
@@ -1216,6 +1218,8 @@ long do_fork(unsigned long clone_flags,
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 
+		ckrm_cb_fork(p);
+
 		if (clone_flags & CLONE_VFORK) {
 			p->vfork_done = &vfork;
 			init_completion(&vfork);
Index: linux-2.6.12-ckrm1/kernel/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/Makefile	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/Makefile	2005-06-20 13:08:20.000000000 -0700
@@ -28,6 +28,7 @@ obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_CKRM) += ckrm/
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.12-ckrm1/kernel/sys.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/sys.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/sys.c	2005-06-20 13:08:20.000000000 -0700
@@ -29,6 +29,7 @@
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -535,6 +536,7 @@ asmlinkage long sys_setregid(gid_t rgid,
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
+	ckrm_cb_gid();
 	return 0;
 }
 
@@ -574,6 +576,7 @@ asmlinkage long sys_setgid(gid_t gid)
 		return -EPERM;
 
 	key_fsgid_changed(current);
+	ckrm_cb_gid();
 	return 0;
 }
   
@@ -664,6 +667,8 @@ asmlinkage long sys_setreuid(uid_t ruid,
 
 	key_fsuid_changed(current);
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
@@ -711,6 +716,8 @@ asmlinkage long sys_setuid(uid_t uid)
 
 	key_fsuid_changed(current);
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
@@ -759,6 +766,8 @@ asmlinkage long sys_setresuid(uid_t ruid
 
 	key_fsuid_changed(current);
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
@@ -810,6 +819,7 @@ asmlinkage long sys_setresgid(gid_t rgid
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
+	ckrm_cb_gid();
 	return 0;
 }
 

--
