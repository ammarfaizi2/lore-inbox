Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUK2TCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUK2TCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUK2TCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:02:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28840 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261530AbUK2Syz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:54:55 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM 1/10: Base CKRM Events
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19636.1101753960.1@us.ibm.com>
Date: Mon, 29 Nov 2004 10:46:00 -0800
Message-Id: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core CKRM Event Callbacks.

On exec, fork, exit, real/effective gid/uid, use CKRM to associate
tasks with appropriate class.

Signed-off-by:  Shailabh Nagar <nagar@us.ibm.com>
Signed-off-by:  Hubertus Franke <frankeh@us.ibm.com>
Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Gerrit Huizenga <gh@us.ibm.com>


 fs/exec.c                   |    2 
 include/linux/ckrm_events.h |  190 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h       |    1 
 init/Kconfig                |   16 +++
 kernel/Makefile             |    2 
 kernel/ckrm/Makefile        |    7 +
 kernel/ckrm/ckrm_events.c   |   97 ++++++++++++++++++++++
 kernel/exit.c               |    3 
 kernel/fork.c               |    4 
 kernel/sys.c                |   10 ++
 10 files changed, 331 insertions(+), 1 deletion(-)

Index: linux-2.6.10-rc2/fs/exec.c
===================================================================
--- linux-2.6.10-rc2.orig/fs/exec.c	2004-11-14 17:27:20.000000000 -0800
+++ linux-2.6.10-rc2/fs/exec.c	2004-11-19 20:40:52.512304615 -0800
@@ -47,6 +47,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1046,6 +1047,7 @@
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
+				ckrm_cb_exec(bprm->filename);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
Index: linux-2.6.10-rc2/include/linux/ckrm_events.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/include/linux/ckrm_events.h	2004-11-19 20:40:52.517303823 -0800
@@ -0,0 +1,190 @@
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
+/*
+ * Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ * 06 Nov 2003
+ *        Made modifications to suit the new RBCE module.
+ * 10 Nov 2003
+ *        Added callbacks_active and surrounding logic. Added task paramter
+ *        for all CE callbacks.
+ * 19 Nov 2004
+ *        New Event callback structure
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
+#endif
+
+#ifdef __KERNEL__
+#ifdef CONFIG_CKRM
+
+/*
+ * CKRM event callback specification for the classtypes or resource controllers 
+ *   typically an array is specified using CKRM_EVENT_SPEC terminated with 
+ *   CKRM_EVENT_SPEC_LAST and then that array is registered using
+ *   ckrm_register_event_set.
+ *   Individual registration of event_cb is also possible
+ */
+
+typedef void (*ckrm_event_cb) (void *arg);
+
+struct ckrm_hook_cb {
+	ckrm_event_cb fct;
+	struct ckrm_hook_cb *next;
+};
+
+struct ckrm_event_spec {
+	enum ckrm_event ev;
+	struct ckrm_hook_cb cb;
+};
+
+#define CKRM_EVENT_SPEC(EV,FCT) { CKRM_EVENT_##EV, \
+					{ (ckrm_event_cb)FCT, NULL } }
+
+int ckrm_register_event_set(struct ckrm_event_spec especs[]);
+int ckrm_unregister_event_set(struct ckrm_event_spec especs[]);
+int ckrm_register_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb);
+int ckrm_unregister_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb);
+
+extern void ckrm_invoke_event_cb_chain(enum ckrm_event ev, void *arg);
+
+#define CKRM_DEF_CB(EV,fct)					\
+static inline void ckrm_cb_##fct(void)				\
+{								\
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_##EV,NULL);      \
+}
+
+#define CKRM_DEF_CB_ARG(EV,fct,argtp)					\
+static inline void ckrm_cb_##fct(argtp arg)				\
+{									\
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_##EV,(void*)arg);	\
+}
+
+#else /* !CONFIG_CKRM */
+
+#define CKRM_DEF_CB(EV,fct)			\
+static inline void ckrm_cb_##fct(void)  { }
+
+#define CKRM_DEF_CB_ARG(EV,fct,argtp)		\
+static inline void ckrm_cb_##fct(argtp arg) { }
+
+#endif /* CONFIG_CKRM */
+
+/*
+ *   define the CKRM event functions 
+ *               EVENT          FCT           ARG         
+ */
+
+/* forward declarations for function arguments */
+struct task_struct;
+struct sock;
+struct user_struct;
+
+CKRM_DEF_CB_ARG(FORK, fork, struct task_struct *);
+CKRM_DEF_CB_ARG(NEWTASK, newtask, struct task_struct *);
+CKRM_DEF_CB_ARG(EXIT, exit, struct task_struct *);
+CKRM_DEF_CB_ARG(EXEC, exec, const char *);
+CKRM_DEF_CB(UID, uid);
+CKRM_DEF_CB(GID, gid);
+CKRM_DEF_CB(APPTAG, apptag);
+CKRM_DEF_CB(LOGIN, login);
+CKRM_DEF_CB_ARG(USERADD, useradd, struct user_struct *);
+CKRM_DEF_CB_ARG(USERDEL, userdel, struct user_struct *);
+CKRM_DEF_CB_ARG(LISTEN_START, listen_start, struct sock *);
+CKRM_DEF_CB_ARG(LISTEN_STOP, listen_stop, struct sock *);
+
+/* some other functions required */
+#ifdef CONFIG_CKRM
+void ckrm_cb_newtask(struct task_struct *);
+void ckrm_cb_exit(struct task_struct *);
+#else
+#define ckrm_cb_newtask(x)	do { } while (0)
+#define ckrm_cb_exit(x)		do { } while (0)
+#endif
+
+extern int get_exe_path_name(struct task_struct *, char *, int);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CKRM_EVENTS_H */
Index: linux-2.6.10-rc2/init/Kconfig
===================================================================
--- linux-2.6.10-rc2.orig/init/Kconfig	2004-11-14 17:28:18.000000000 -0800
+++ linux-2.6.10-rc2/init/Kconfig	2004-11-19 20:40:52.521303189 -0800
@@ -138,6 +138,22 @@
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
+	  If you say Y here, enable the Resource Class File System and atleast
+	  one of the resource controllers below. Say N if you are unsure. 
+
+endmenu
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux-2.6.10-rc2/kernel/ckrm/ckrm_events.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/kernel/ckrm/ckrm_events.c	2004-11-19 20:40:52.526302397 -0800
@@ -0,0 +1,97 @@
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
+/* Changes
+ *
+ * 29 Sep 2004
+ *        Separated from ckrm.c
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
+#define ECC_PRINTK(fmt, args...) \
+// printk("%s: " fmt, __FUNCTION__ , ## args)
+
+void ckrm_invoke_event_cb_chain(enum ckrm_event ev, void *arg)
+{
+	struct ckrm_hook_cb *cb, *anchor;
+
+	ECC_PRINTK("%d %x\n", current, ev, arg);
+	if ((anchor = ckrm_event_callbacks[ev]) != NULL) {
+		for (cb = anchor; cb; cb = cb->next)
+			(*cb->fct) (arg);
+	}
+}
+
Index: linux-2.6.10-rc2/kernel/ckrm/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/kernel/ckrm/Makefile	2004-11-19 20:40:52.528302080 -0800
@@ -0,0 +1,7 @@
+#
+# Makefile for CKRM
+#
+
+ifeq ($(CONFIG_CKRM),y)
+    obj-y = ckrm_events.o
+endif	
Index: linux-2.6.10-rc2/kernel/exit.c
===================================================================
--- linux-2.6.10-rc2.orig/kernel/exit.c	2004-11-14 17:28:19.000000000 -0800
+++ linux-2.6.10-rc2/kernel/exit.c	2004-11-19 20:40:52.534301130 -0800
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
+#include <linux/ckrm_events.h>
 #include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
@@ -658,6 +659,8 @@
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
+	ckrm_cb_exit(tsk);
+
 	if (signal_pending(tsk) && !tsk->signal->group_exit
 	    && !thread_group_empty(tsk)) {
 		/*
Index: linux-2.6.10-rc2/kernel/fork.c
===================================================================
--- linux-2.6.10-rc2.orig/kernel/fork.c	2004-11-14 17:26:43.000000000 -0800
+++ linux-2.6.10-rc2/kernel/fork.c	2004-11-19 20:40:52.540300179 -0800
@@ -39,6 +39,7 @@
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -155,6 +156,7 @@
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
+	ckrm_cb_newtask(tsk);
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
@@ -1137,6 +1139,8 @@
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 
+		ckrm_cb_fork(p);
+
 		if (clone_flags & CLONE_VFORK) {
 			p->vfork_done = &vfork;
 			init_completion(&vfork);
Index: linux-2.6.10-rc2/kernel/Makefile
===================================================================
--- linux-2.6.10-rc2.orig/kernel/Makefile	2004-11-14 17:27:09.000000000 -0800
+++ linux-2.6.10-rc2/kernel/Makefile	2004-11-19 20:41:21.885651099 -0800
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o
+	    kthread.o wait.o kfifo.o sys_ni.o ckrm/
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6.10-rc2/kernel/sys.c
===================================================================
--- linux-2.6.10-rc2.orig/kernel/sys.c	2004-11-14 17:27:00.000000000 -0800
+++ linux-2.6.10-rc2/kernel/sys.c	2004-11-19 20:40:52.552298279 -0800
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/ckrm_events.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -533,6 +534,7 @@
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
+	ckrm_cb_gid();
 	return 0;
 }
 
@@ -572,6 +574,7 @@
 		return -EPERM;
 
 	key_fsgid_changed(current);
+	ckrm_cb_gid();
 	return 0;
 }
   
@@ -662,6 +665,8 @@
 
 	key_fsuid_changed(current);
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
@@ -709,6 +714,8 @@
 
 	key_fsuid_changed(current);
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
@@ -757,6 +764,8 @@
 
 	key_fsuid_changed(current);
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
@@ -808,6 +817,7 @@
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
+	ckrm_cb_gid();
 	return 0;
 }
 
