Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRAZSrR>; Fri, 26 Jan 2001 13:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRAZSrI>; Fri, 26 Jan 2001 13:47:08 -0500
Received: from [172.16.18.1] ([172.16.18.1]:38661 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129998AbRAZSqy>; Fri, 26 Jan 2001 13:46:54 -0500
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Subject: [RFC] Task Ornaments
Date: Fri, 26 Jan 2001 18:46:47 +0000
Message-ID: <31885.980534807@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PROPOSAL
========

I have written a patch (appended) that gives a task structure a list of
arbitrary "ornaments". Any number of ornaments can then be added without
increasing the size of the task_struct.

Each ornament has an operations table, much as do inodes and address
spaces. These operations include a destructor and routines for destroying and
duplicating ornaments under signal, exit, execve and fork/clone conditions.

For instance, the frame buffer drivers use a three fields in the task
structure to gain notification of signals that are blocked from being
delivered to a process:
	- notifier
	- notifier_data
	- notifier_mask

Instead, these fields could be attached to an ornament which is only present
when the FB driver is doing this. They would use the signal notification
operation to perform this function.

In this way, the task_struct size could actually be _reduced_ by 4 bytes.

Functions are provided for traversing the list and calling the appropriate
notification routine on each ornament. Multiple traversals can be in progress
at once, and they can be recursive, and the list can be safely modified at the
same time.

The implementation I've appended does work in userspace tests (as far as it is
possible to test it there), though it has not been tried in the kernel as yet.

One optimisation that can be made is to make alloc_lock in the task_struct an
rwlock_t instead of a spinlock_t. This means that the list can be searched
simultaneously be several different processes.


REASON FOR IMPLEMENTATION
=========================

In the Win32 kernel module that I'm writing to help accelerate Wine, one of
the things I want to do is to be able to store a Win32 handle map in a task
structure (currently I attach it to an open fd).

There are a number of things my code needs to be able to do:

  (1) Destroy the handle map upon exit, signal and potentially execve.

  (2) Trim the handle map during execve.

  (3) Duplicate/share the handle map of a process with a child process during
      forking/cloning.

  (4) A process needs to be able to add objects to the handle map of another
      arbitrary process that also has a handle map.

  (5) A process needs to be able to gain notification of the death of another
      arbitrary process.

The way I'm proposing to do this is by providing notifications from certain
routines, such as do_fork().

There are a number of further considerations:

  (1) A notification service routine can sleep (eg: on kmalloc).

  (2) A service routine may modify the list (eg: remove itself).

  (3) The list must be guarded against modifications during traversal without
      preventing modifications from happening.


Thanks for your consideration/comments/better ways of doing it,
David

======================================================
diff -uNr linux-2.4.1-pre10.orig/fs/exec.c linux-2.4.1-pre10/fs/exec.c
--- linux-2.4.1-pre10.orig/fs/exec.c	Fri Jan 26 15:57:12 2001
+++ linux-2.4.1-pre10/fs/exec.c	Fri Jan 26 17:28:32 2001
@@ -541,6 +541,7 @@
 	if (retval) goto mmap_failed;
 
 	/* This is the point of no return */
+	task_ornament_notify_execve(current);
 	release_old_signals(oldsig);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
diff -uNr linux-2.4.1-pre10.orig/include/linux/sched.h linux-2.4.1-pre10/include/linux/sched.h
--- linux-2.4.1-pre10.orig/include/linux/sched.h	Fri Jan 26 15:57:16 2001
+++ linux-2.4.1-pre10/include/linux/sched.h	Fri Jan 26 16:08:32 2001
@@ -394,7 +394,8 @@
    	u32 parent_exec_id;
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
-	spinlock_t alloc_lock;
+	rwlock_t alloc_lock;
+	struct list_head ornaments;
 };
 
 /*
@@ -474,7 +475,7 @@
     sig:		&init_signals,					\
     pending:		{ NULL, &tsk.pending.head, {{0}}},		\
     blocked:		{{0}},						\
-    alloc_lock:		SPIN_LOCK_UNLOCKED				\
+    alloc_lock:		RW_LOCK_UNLOCKED				\
 }
 
 
@@ -859,12 +860,12 @@
 
 static inline void task_lock(struct task_struct *p)
 {
-	spin_lock(&p->alloc_lock);
+	write_lock(&p->alloc_lock);
 }
 
 static inline void task_unlock(struct task_struct *p)
 {
-	spin_unlock(&p->alloc_lock);
+	write_unlock(&p->alloc_lock);
 }
 
 /* write full pathname into buffer and return start of pathname */
diff -uNr linux-2.4.1-pre10.orig/include/linux/taskornament.h linux-2.4.1-pre10/include/linux/taskornament.h
--- linux-2.4.1-pre10.orig/include/linux/taskornament.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.1-pre10/include/linux/taskornament.h	Fri Jan 26 17:16:22 2001
@@ -0,0 +1,129 @@
+/* taskornament.h: task ornaments
+ *
+ * (c) Copyright 2001   David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _H_F92CE22E_93FF_11D4_8781_0000C0005742
+#define _H_F92CE22E_93FF_11D4_8781_0000C0005742
+
+#ifdef __KERNEL__
+
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <asm/atomic.h>
+
+struct task_ornament;
+struct task_struct;
+
+struct task_ornament_operations {
+	/* ornament name */
+	const char *name;
+
+	/* responsible module */
+	struct module *owner;
+
+	/* request to destruct */
+	void (*close)(struct task_ornament *ornament);
+
+	/* notification of exit */
+	void (*exit)(struct task_ornament *ornament, int status);
+
+	/* notification of signal */
+	void (*signal)(struct task_ornament *ornament, int signal);
+
+	/* notification of execve
+	 * - if this is NULL, an ornament will be destroyed on execve
+	 */
+	void (*execve)(struct task_ornament *ornament);
+
+	/* notification that fork/clone has set up the new process and
+	 * is just about to dispatch it
+	 * - no ornaments will have been copied by default
+	 */
+	void (*fork)(struct task_ornament *ornament,
+		     struct task_struct *parent,
+		     struct task_struct *child,
+		     unsigned long clone_flags);
+};
+
+struct task_ornament {
+	atomic_t to_count;
+	struct list_head to_list;
+	const struct task_ornament_operations *to_ops;
+};
+
+static __inline__
+void ornget(struct task_ornament *orn)
+{
+	atomic_inc(&orn->to_count);
+}
+
+static __inline__
+void ornput(struct task_struct *tsk,
+	    struct task_ornament *orn)
+{
+	if (atomic_dec_and_test(&orn->to_count))
+		orn->to_ops->close(orn);
+}
+
+#define orn_entry(ptr, type, member) list_entry(ptr,type,member)
+
+/*****************************************************************************/
+/*
+ * add an ornament to a task
+ */
+static __inline__
+void add_task_ornament(struct task_struct *tsk,
+		       struct task_ornament *orn)
+{
+	ornget(orn);
+	write_lock(&tsk->alloc_lock);
+	list_add_tail(&orn->to_list,&tsk->ornaments);
+	write_unlock(&tsk->alloc_lock);
+}
+
+/*
+ * remove an ornament from a task
+ */
+extern void remove_task_ornament(struct task_struct *tsk,
+				 struct task_ornament *orn);
+
+/*
+ * find an ornament by type
+ * - must be called with the task structure locked
+ * - increments the usage counter of the ornament returned
+ */
+static __inline__
+struct task_ornament *task_ornament_find(struct task_struct *tsk,
+					 struct task_ornament_operations *type)
+{
+	struct task_ornament *orn;
+	struct list_head *ptr;
+
+	read_lock(&tsk->alloc_lock);
+	for (ptr=tsk->ornaments.next; ptr!=&tsk->ornaments; ptr=ptr->next) {
+		orn = list_entry(ptr,struct task_ornament,to_list);
+		if (orn->to_ops==type)
+			goto found;
+	}
+
+	read_unlock(&tsk->alloc_lock);
+	return NULL;
+
+ found:
+	ornget(orn);
+	read_unlock(&tsk->alloc_lock);
+	return orn;
+}
+
+extern void exit_task_ornaments(void);
+extern void task_ornament_notify_exit(struct task_struct *tsk, int exit_code);
+extern void task_ornament_notify_signal(struct task_struct *tsk, int signal);
+extern void task_ornament_notify_execve(struct task_struct *tsk);
+extern void task_ornament_notify_fork(struct task_struct *tsk,
+				      struct task_struct *child,
+				      unsigned long clone_flags);
+
+#endif /* __KERNEL__ */
+
+#endif /* _H_F92CE22E_93FF_11D4_8781_0000C0005742 */
diff -uNr linux-2.4.1-pre10.orig/kernel/exit.c linux-2.4.1-pre10/kernel/exit.c
--- linux-2.4.1-pre10.orig/kernel/exit.c	Fri Jan 26 15:57:16 2001
+++ linux-2.4.1-pre10/kernel/exit.c	Fri Jan 26 17:30:32 2001
@@ -371,6 +371,9 @@
 	    && !capable(CAP_KILL))
 		current->exit_signal = SIGCHLD;
 
+	/* tell our ornaments we're dying */
+	task_ornament_notify_exit(current,current->exit_code);
+	exit_task_ornaments();
 
 	/*
 	 * This loop does two things:
diff -uNr linux-2.4.1-pre10.orig/kernel/fork.c linux-2.4.1-pre10/kernel/fork.c
--- linux-2.4.1-pre10.orig/kernel/fork.c	Fri Jan 26 15:57:16 2001
+++ linux-2.4.1-pre10/kernel/fork.c	Fri Jan 26 17:25:24 2001
@@ -612,7 +612,7 @@
 	p->p_cptr = NULL;
 	init_waitqueue_head(&p->wait_chldexit);
 	p->vfork_sem = NULL;
-	spin_lock_init(&p->alloc_lock);
+	rwlock_init(&p->alloc_lock);
 
 	p->sigpending = 0;
 	init_sigpending(&p->pending);
@@ -675,6 +675,11 @@
 	current->counter >>= 1;
 	if (!current->counter)
 		current->need_resched = 1;
+
+	/*
+	 * tell any ornaments to duplicate themselves
+	 */
+	task_ornament_notify_fork(current,p,clone_flags);
 
 	/*
 	 * Ok, add it to the run-queues and make it
diff -uNr linux-2.4.1-pre10.orig/kernel/signal.c linux-2.4.1-pre10/kernel/signal.c
--- linux-2.4.1-pre10.orig/kernel/signal.c	Fri Jan 26 15:57:16 2001
+++ linux-2.4.1-pre10/kernel/signal.c	Fri Jan 26 17:26:53 2001
@@ -242,6 +242,9 @@
 #endif
 
 	sig = next_signal(current, mask);
+
+	task_ornament_notify_signal(tsk,sig);
+
 	if (current->notifier) {
 		if (sigismember(current->notifier_mask, sig)) {
 			if (!(current->notifier)(current->notifier_data)) {
diff -uNr linux-2.4.1-pre10.orig/kernel/taskornament.c linux-2.4.1-pre10/kernel/taskornament.c
--- linux-2.4.1-pre10.orig/kernel/taskornament.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.1-pre10/kernel/taskornament.c	Fri Jan 26 17:20:36 2001
@@ -0,0 +1,330 @@
+/* taskornament.c: task ornament handling
+ *
+ * Copyright (c) 2001   David Howells (dhowells@redhat.com)
+ */
+#include <linux/sched.h>
+#include <linux/taskornament.h>
+
+/*****************************************************************************/
+/*
+ * remove an ornament from a task
+ */
+void remove_task_ornament(struct task_struct *tsk,
+			  struct task_ornament *orn)
+{
+	write_lock(&tsk->alloc_lock);
+	list_del(&orn->to_list);
+	write_unlock(&tsk->alloc_lock);
+	ornput(tsk,orn);
+} /* end remove_task_ornament() */
+
+/*****************************************************************************/
+/*
+ * notify an ornament of a process that is exiting
+ * - this'll be called from notify_parent() in kernel/signal.c
+ * - the list is _not_ locked whilst the notification routine is running
+ * - place a buoy in the list to mark the next ornament to be processed
+ * - place a second buoy at the end of the list to prevent processing of
+ *   ornaments added during processing
+ */
+void task_ornament_notify_exit(struct task_struct *tsk, int exit_code)
+{
+	struct task_ornament buoy[2], *orn;
+	struct list_head *ptr;
+
+	read_lock(&tsk->alloc_lock);
+	if (list_empty(&tsk->ornaments))
+		return;
+	read_unlock(&tsk->alloc_lock);
+
+	atomic_set(&buoy[0].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[0].to_list);
+	buoy[0].to_ops = NULL;
+
+	atomic_set(&buoy[1].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[1].to_list);
+	buoy[1].to_ops = NULL;
+
+	/* loop through all task ornaments, but be careful in case the
+	 * list is rearranged. The buoy is used as a marker between the current
+	 * position and the next
+	 */
+	write_lock(&tsk->alloc_lock);
+	list_add_tail(&buoy[1].to_list,&tsk->ornaments);
+	ptr = tsk->ornaments.next;
+
+	for (;;) {
+		/* skip over buoys from other processors */
+		for (;;) {
+			if (ptr==&buoy[1].to_list)
+				goto end_of_list_reached;
+
+			orn = list_entry(ptr,struct task_ornament,to_list);
+			if (orn->to_ops)
+				break;
+
+			ptr = ptr->next;
+
+		}
+
+		/* we've found a real ornament */
+		ornget(orn);
+
+		/* stuff a buoy in the queue after it */
+		list_add(&buoy[0].to_list,ptr);
+		write_unlock(&tsk->alloc_lock);
+
+		/* call the operation */
+		orn->to_ops->exit(orn,exit_code);
+		ornput(tsk,orn);
+
+		/* remove the buoy */
+		write_lock(&tsk->alloc_lock);
+		ptr = buoy[0].to_list.next;
+		list_del(&buoy[0].to_list);
+	}
+
+ end_of_list_reached:
+	list_del(&buoy[1].to_list);
+	write_unlock(&tsk->alloc_lock);
+
+} /* end task_ornament_notify_exit() */
+
+/*****************************************************************************/
+/*
+ * notify an ornament of a signal being delivered to a process that would cause
+ * the parent process to get SIGCHLD
+ * - this'll be called from notify_parent() in kernel/signal.c
+ * - the list is _not_ locked whilst the notification routine is running
+ * - place a buoy in the list to mark the next ornament to be processed
+ * - place a second buoy at the end of the list to prevent processing of
+ *   ornaments added during processing
+ */
+void task_ornament_notify_signal(struct task_struct *tsk, int signal)
+{
+	struct task_ornament buoy[2], *orn;
+	struct list_head *ptr;
+
+	read_lock(&tsk->alloc_lock);
+	if (list_empty(&tsk->ornaments))
+		return;
+	read_unlock(&tsk->alloc_lock);
+
+	atomic_set(&buoy[0].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[0].to_list);
+	buoy[0].to_ops = NULL;
+
+	atomic_set(&buoy[1].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[1].to_list);
+	buoy[1].to_ops = NULL;
+
+	/* loop through all task ornaments, but be careful in case the
+	 * list is rearranged. The buoy is used as a marker between the current
+	 * position and the next
+	 */
+	write_lock(&tsk->alloc_lock);
+	list_add_tail(&buoy[1].to_list,&tsk->ornaments);
+	ptr = tsk->ornaments.next;
+
+	for (;;) {
+		/* skip over buoys from other processors */
+		for (;;) {
+			if (ptr==&buoy[1].to_list)
+				goto end_of_list_reached;
+
+			orn = list_entry(ptr,struct task_ornament,to_list);
+			if (orn->to_ops)
+				break;
+
+			ptr = ptr->next;
+
+		}
+
+		/* we've found a real ornament */
+		ornget(orn);
+
+		/* stuff a buoy in the queue after it */
+		list_add(&buoy[0].to_list,ptr);
+		write_unlock(&tsk->alloc_lock);
+
+		/* call the operation */
+		orn->to_ops->signal(orn,signal);
+		ornput(tsk,orn);
+
+		/* remove the buoy */
+		write_lock(&tsk->alloc_lock);
+		ptr = buoy[0].to_list.next;
+		list_del(&buoy[0].to_list);
+	}
+
+ end_of_list_reached:
+	list_del(&buoy[1].to_list);
+	write_unlock(&tsk->alloc_lock);
+
+} /* end task_ornament_notify_signal() */
+
+/*****************************************************************************/
+/*
+ * notify an ornament of a process execve'ing itself
+ * - this'll be called from flush_old_exec() in kernel/exec.c
+ * - the list is _not_ locked whilst the notification routine is running
+ * - place a buoy in the list to mark the next ornament to be processed
+ * - place a second buoy at the end of the list to prevent processing of
+ *   ornaments added during processing
+ */
+void task_ornament_notify_execve(struct task_struct *tsk)
+{
+	struct task_ornament buoy[2], *orn;
+	struct list_head *ptr;
+
+	read_lock(&tsk->alloc_lock);
+	if (list_empty(&tsk->ornaments))
+		return;
+	read_unlock(&tsk->alloc_lock);
+
+	atomic_set(&buoy[0].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[0].to_list);
+	buoy[0].to_ops = NULL;
+
+	atomic_set(&buoy[1].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[1].to_list);
+	buoy[1].to_ops = NULL;
+
+	/* loop through all task ornaments, but be careful in case the
+	 * list is rearranged. The buoy is used as a marker between the current
+	 * position and the next
+	 */
+	write_lock(&tsk->alloc_lock);
+	list_add_tail(&buoy[1].to_list,&tsk->ornaments);
+	ptr = tsk->ornaments.next;
+
+	for (;;) {
+		/* skip over buoys from other processors */
+		for (;;) {
+			if (ptr==&buoy[1].to_list)
+				goto end_of_list_reached;
+
+			orn = list_entry(ptr,struct task_ornament,to_list);
+			if (orn->to_ops)
+				break;
+
+			ptr = ptr->next;
+
+		}
+
+		/* we've found a real ornament */
+		ornget(orn);
+
+		/* stuff a buoy in the queue after it */
+		list_add(&buoy[0].to_list,ptr);
+		write_unlock(&tsk->alloc_lock);
+
+		/* call the operation */
+		orn->to_ops->execve(orn);
+		ornput(tsk,orn);
+
+		/* remove the buoy */
+		write_lock(&tsk->alloc_lock);
+		ptr = buoy[0].to_list.next;
+		list_del(&buoy[0].to_list);
+	}
+
+ end_of_list_reached:
+	list_del(&buoy[1].to_list);
+	write_unlock(&tsk->alloc_lock);
+
+} /* end task_ornament_notify_execve() */
+
+/*****************************************************************************/
+/*
+ * notify an ornament of a process forking/cloning itself
+ * - this'll be called from do_fork() in kernel/fork.c
+ * - the list is _not_ locked whilst the notification routine is running
+ * - place a buoy in the list to mark the next ornament to be processed
+ * - place a second buoy at the end of the list to prevent processing of
+ *   ornaments added during processing
+ */
+void task_ornament_notify_fork(struct task_struct *tsk,
+			       struct task_struct *child,
+			       unsigned long clone_flags)
+{
+	struct task_ornament buoy[2], *orn;
+	struct list_head *ptr;
+
+	read_lock(&tsk->alloc_lock);
+	if (list_empty(&tsk->ornaments))
+		return;
+	read_unlock(&tsk->alloc_lock);
+
+	atomic_set(&buoy[0].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[0].to_list);
+	buoy[0].to_ops = NULL;
+
+	atomic_set(&buoy[1].to_count,0x3fffffff);
+	INIT_LIST_HEAD(&buoy[1].to_list);
+	buoy[1].to_ops = NULL;
+
+	/* loop through all task ornaments, but be careful in case the
+	 * list is rearranged. The buoy is used as a marker between the current
+	 * position and the next
+	 */
+	write_lock(&tsk->alloc_lock);
+	list_add_tail(&buoy[1].to_list,&tsk->ornaments);
+	ptr = tsk->ornaments.next;
+
+	for (;;) {
+		/* skip over buoys from other processors */
+		for (;;) {
+			if (ptr==&buoy[1].to_list)
+				goto end_of_list_reached;
+
+			orn = list_entry(ptr,struct task_ornament,to_list);
+			if (orn->to_ops)
+				break;
+
+			ptr = ptr->next;
+
+		}
+
+		/* we've found a real ornament */
+		ornget(orn);
+
+		/* stuff a buoy in the queue after it */
+		list_add(&buoy[0].to_list,ptr);
+		write_unlock(&tsk->alloc_lock);
+
+		/* call the operation */
+		orn->to_ops->fork(orn,tsk,child,clone_flags);
+		ornput(tsk,orn);
+
+		/* remove the buoy */
+		write_lock(&tsk->alloc_lock);
+		ptr = buoy[0].to_list.next;
+		list_del(&buoy[0].to_list);
+	}
+
+ end_of_list_reached:
+	list_del(&buoy[1].to_list);
+	write_unlock(&tsk->alloc_lock);
+
+} /* end task_ornament_notify_fork() */
+
+/*****************************************************************************/
+/*
+ * clean up all task ornaments for exit()
+ */
+void exit_task_ornaments(void)
+{
+	struct task_ornament *orn;
+	struct list_head *ptr;
+
+	write_lock(&current->alloc_lock);
+
+	while (!list_empty(tsk->ornaments.next)) {
+		list_del(&orn->to_list);
+		ornput(current,orn);
+	}
+
+	write_unlock(&current->alloc_lock);
+
+} /* end exit_task_ornaments() */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
