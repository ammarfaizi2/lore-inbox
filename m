Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269754AbUHZWXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269754AbUHZWXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269753AbUHZWVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:21:47 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:11983 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269733AbUHZWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:15:02 -0400
Date: Thu, 26 Aug 2004 17:14:55 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates for 2.6.8
In-Reply-To: <Pine.SGI.4.53.0408161127580.663457@subway.americas.sgi.com>
Message-ID: <Pine.SGI.4.53.0408261710390.1552508@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0408161127580.663457@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A problem was discovered with the new location of pagg_detach.  If just
the right situation came up, a kernel panic could happen.

We've decided to move pagg_detach to it's original location in exit.c
(do_exit).

I'm including the new PAGG patch below.

Signed-Off-By: Erik Jacobson <erikj@sgi.com>


Index: linux/Documentation/pagg.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/pagg.txt	2004-08-26 14:34:46.000000000 -0500
@@ -0,0 +1,32 @@
+Linux Process Aggregates (PAGG)
+-------------------------------
+
+The process aggregates infrastructure, or PAGG, provides a generalized
+mechanism for providing arbitrary process groups in Linux.  PAGG consists
+of a series of functions for registering and unregistering support
+for new types of process aggregation containers with the kernel.
+This is similar to the support currently provided within Linux that
+allows for dynamic support of filesystems, block and character devices,
+symbol tables, network devices, serial devices, and execution domains.
+This implementation of PAGG provides developers the basic hooks necessary
+to implement kernel modules for specific process containers, such as
+the job container.
+
+The do_fork function in the kernel was altered to support PAGG.  If a
+process is attached to any PAGG containers and subsequently forks a
+child process, the child process will also be attached to the same PAGG
+containers.  The PAGG containers involved during the fork are notified
+that a new process has been attached.  The notification is accomplished
+via a callback function provided by the PAGG module.
+
+The do_exit function in the kernel has also been altered.  If a process
+is attached to any PAGG containers and that process is exiting, the PAGG
+containers are notified that a process has detached from the container.
+The notification is accomplished via a callback function provided by
+the PAGG module.
+
+The sys_execve function has been modified to support an optional callout
+that can be run when a process in a pagg list does an exec.  It can be
+used, for example, by other kernel modules that wish to do advanced CPU
+placement on multi-processor systems (just one example).
+
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2004-08-14 00:36:56.000000000 -0500
+++ linux/fs/exec.c	2004-08-26 14:34:46.000000000 -0500
@@ -46,6 +46,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
+#include <linux/pagg.h>

 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1140,6 +1141,7 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		free_arg_pages(&bprm);
+		pagg_exec(current);

 		/* execve success */
 		security_bprm_free(&bprm);
Index: linux/include/linux/init_task.h
===================================================================
--- linux.orig/include/linux/init_task.h	2004-08-14 00:36:16.000000000 -0500
+++ linux/include/linux/init_task.h	2004-08-26 14:34:46.000000000 -0500
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H

 #include <linux/file.h>
+#include <linux/pagg.h>

 #define INIT_FILES \
 { 							\
@@ -112,6 +113,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	INIT_TASK_PAGG(tsk)						\
 }


Index: linux/include/linux/pagg.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/pagg.h	2004-08-26 14:34:46.000000000 -0500
@@ -0,0 +1,202 @@
+/*
+ * PAGG (Process Aggregates) interface
+ *
+ *
+ * Copyright (c) 2000-2002, 2004 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ */
+
+/*
+ * Data structure definitions and function prototypes used to implement
+ * process aggregates (paggs).
+ *
+ * Paggs provides a generalized way to implement process groupings or
+ * containers.  Modules use these functions to register with the kernel as
+ * providers of process aggregation containers. The pagg data structures
+ * define the callback functions and data access pointers back into the
+ * pagg modules.
+ */
+
+#ifndef _LINUX_PAGG_H
+#define _LINUX_PAGG_H
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_PAGG
+
+#define PAGG_NAMELN	32		/* Max chars in PAGG module name */
+
+
+/**
+ * INIT_PAGG_LIST - used to initialize a pagg_list structure after declaration
+ * @_l: Task struct to init the pagg_list and semaphore in
+ *
+ */
+#define INIT_PAGG_LIST(_l)						\
+do {									\
+	INIT_LIST_HEAD(&(_l)->pagg_list);					\
+	init_rwsem(&(_l)->pagg_sem);						\
+} while(0)
+
+
+/*
+ * Used by task_struct to manage list of pagg attachments for the process.
+ * Each pagg provides the link between the process and the
+ * correct pagg container.
+ *
+ * STRUCT MEMBERS:
+ *     hook:	Reference to pagg module structure.  That struct
+ *     		holds the name key and function pointers.
+ *     data:	Opaque data pointer - defined by pagg modules.
+ *     entry:	List pointers
+ */
+struct pagg {
+       struct pagg_hook	*hook;
+       void		*data;
+       struct list_head	entry;
+};
+
+/*
+ * Used by pagg modules to define the callback functions into the
+ * module.
+ *
+ * STRUCT MEMBERS:
+ *     name:           The name of the pagg container type provided by
+ *                     the module. This will be set by the pagg module.
+ *     attach:         Function pointer to function used when attaching
+ *                     a process to the pagg container referenced by
+ *                     this struct.
+ *     detach:         Function pointer to function used when detaching
+ *                     a process to the pagg container referenced by
+ *                     this struct.
+ *     init:           Function pointer to initialization function.  This
+ *                     function is used when the module is loaded to attach
+ *                     existing processes to a default container as defined by
+ *                     the pagg module. This is optional and may be set to
+ *                     NULL if it is not needed by the pagg module.
+ *     data:           Opaque data pointer - defined by pagg modules.
+ *     module:         Pointer to kernel module struct.  Used to increment &
+ *                     decrement the use count for the module.
+ *     entry:	       List pointers
+ *     exec:           Function pointer to function used when a process
+ *                     in the pagg container exec's a new process. This
+ *                     is optional and may be set to NULL if it is not
+ *                     needed by the pagg module.
+ *     refcnt:         Keep track of user count of the pagg hook
+ */
+struct pagg_hook {
+       struct module	*module;
+       char		*name;	/* Name Key - restricted to 32 characters */
+       void		*data;	/* Opaque module specific data */
+       struct list_head	entry;	/* List pointers */
+		 atomic_t refcnt; /* usage counter */
+       int		(*init)(struct task_struct *, struct pagg *);
+       int		(*attach)(struct task_struct *, struct pagg *, void*);
+       void		(*detach)(struct task_struct *, struct pagg *);
+       void		(*exec)(struct task_struct *, struct pagg *);
+};
+
+
+/* Kernel service functions for providing PAGG support */
+extern struct pagg *pagg_get(struct task_struct *task, char *key);
+extern struct pagg *pagg_alloc(struct task_struct *task,
+			       struct pagg_hook *pt);
+extern void pagg_free(struct pagg *pagg);
+extern int pagg_hook_register(struct pagg_hook *pt_new);
+extern int pagg_hook_unregister(struct pagg_hook *pt_old);
+extern void __pagg_attach(struct task_struct *to_task,
+			 struct task_struct *from_task);
+extern void __pagg_detach(struct task_struct *task);
+extern int __pagg_exec(struct task_struct *task);
+
+/**
+ * pagg_attach - child inherits attachment to pagg containers of its parent
+ * @child: child task - to inherit
+ * @parent: parenet task - child inherits pagg containers from this parent
+ *
+ * function used when a child process must inherit attachment to pagg
+ * containers from the parent.
+ *
+ */
+static inline void pagg_attach(struct task_struct *child,
+			      struct task_struct *parent)
+{
+	INIT_PAGG_LIST(child);
+	if (!list_empty(&parent->pagg_list))
+		__pagg_attach(child, parent);
+	return;
+}
+
+
+/**
+ * pagg_detach - Detach a process from a pagg container it is a member of
+ * @task: The task the pagg will be detached from
+ *
+ */
+static inline void pagg_detach(struct task_struct *task)
+{
+	if (!list_empty(&task->pagg_list))
+		__pagg_detach(task);
+}
+
+/**
+ * pagg_exec - Used when a process exec's
+ * @task: The process doing the exec
+ *
+ */
+static inline void pagg_exec(struct task_struct *task)
+{
+	if (!list_empty(&task->pagg_list))
+		__pagg_exec(task);
+}
+
+/**
+ * INIT_TASK_PAGG - Used in INIT_TASK to set the head and sem of pagg_list
+ * @tsk: The task work with
+ *
+ * Marco Used in INIT_TASK to set the head and sem of pagg_list.
+ * If CONFIG_PAGG is off, it is defined as an empty macro below.
+ *
+ */
+#define INIT_TASK_PAGG(tsk) \
+	.pagg_list = LIST_HEAD_INIT(tsk.pagg_list),     \
+	.pagg_sem  = __RWSEM_INITIALIZER(tsk.pagg_sem),
+
+#else  /* CONFIG_PAGG */
+
+/*
+ * Replacement macros used when PAGG (Process Aggregates) support is not
+ * compiled into the kernel.
+ */
+#define INIT_TASK_PAGG(tsk)
+#define INIT_PAGG_LIST(l) do { } while(0)
+#define pagg_attach(ct, pt)  do { } while(0)
+#define pagg_detach(t)  do {  } while(0)
+#define pagg_exec(t)  do {  } while(0)
+
+#endif /* CONFIG_PAGG */
+
+#endif /* _LINUX_PAGG_H */
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-08-14 00:36:16.000000000 -0500
+++ linux/include/linux/sched.h	2004-08-26 14:34:46.000000000 -0500
@@ -527,6 +527,13 @@
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+
+#ifdef CONFIG_PAGG
+/* List of pagg (process aggregate) attachments */
+	struct list_head pagg_list;
+	struct rw_semaphore pagg_sem;
+#endif
+
 };

 static inline pid_t process_group(struct task_struct *tsk)
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2004-08-14 00:37:38.000000000 -0500
+++ linux/init/Kconfig	2004-08-26 14:34:46.000000000 -0500
@@ -125,6 +125,14 @@
 	  for processing it. A preliminary version of these tools is available
 	  at <http://http://www.de.kernel.org/pub/linux/utils/acct/>.

+config PAGG
+	bool "Support for process aggregates (PAGGs)"
+	help
+     Say Y here if you will be loading modules which provide support
+     for process aggregate containers.  Examples of such modules include the
+     Linux Jobs module and the Linux Array Sessions module.  If you will not
+     be using such modules, say N.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2004-08-14 00:36:32.000000000 -0500
+++ linux/kernel/Makefile	2004-08-26 14:34:46.000000000 -0500
@@ -18,6 +18,7 @@
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_PAGG) += pagg.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-08-14 00:36:16.000000000 -0500
+++ linux/kernel/fork.c	2004-08-26 14:35:05.000000000 -0500
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/rmap.h>
+#include <linux/pagg.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -236,6 +237,9 @@

 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+
+	/* Initialize the pagg list in pid 0 before it can clone itself. */
+	INIT_PAGG_LIST(current);
 }

 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -1022,6 +1026,12 @@
 	sched_fork(p);

 	/*
+	 * call pagg modules to properly attach new process to the same
+	 * process aggregate containers as the parent process.
+	 */
+	pagg_attach(p, current);
+
+	/*
 	 * Ok, make it visible to the rest of the system.
 	 * We dont wake it up yet.
 	 */
Index: linux/kernel/pagg.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/pagg.c	2004-08-26 14:34:46.000000000 -0500
@@ -0,0 +1,477 @@
+/*
+ * PAGG (Process Aggregates) interface
+ *
+ *
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/pagg.h>
+#include <asm/semaphore.h>
+
+/* list of pagg hook entries that reference the "module" implementations */
+static LIST_HEAD(pagg_hook_list);
+static DECLARE_RWSEM(pagg_hook_list_sem);
+
+
+/**
+ * pagg_get - get a pagg given a search key
+ * @task: We examine the pagg_list from the given task
+ * @key: Key name of pagg we wish to retrieve
+ *
+ * Given a pagg_list list structure, this function will return
+ * a pointer to the pagg struct that matches the search
+ * key.  If the key is not found, the function will return NULL.
+ *
+ * The caller should hold at least a read lock on the pagg_list
+ * for task using down_read(&task->pagg_list.sem).
+ *
+ */
+struct pagg *
+pagg_get(struct task_struct *task, char *key)
+{
+	struct pagg *pagg;
+
+	list_for_each_entry(pagg, &task->pagg_list, entry) {
+		if (!strcmp(pagg->hook->name,key))
+			return pagg;
+	}
+	return NULL;
+}
+
+
+/**
+ * pagg_alloc - Insert a new pagg in to the pagg_list for a task
+ * @task: Task we want to insert the pagg in to
+ * @pagg_hook: Pagg hook to associate with the new pagg
+ *
+ * Given a task and a pagg hook, this function will allocate
+ * a new pagg structure, initialize the settings, and insert the pagg into
+ * the pagg_list for the task.
+ *
+ * The caller for this function should hold at least a read lock on the
+ * pagg_hook_list_sem - or ensure that the pagg hook entry cannot be
+ * removed. If this function was called from the pagg module (usually the
+ * case), then the caller need not hold this lock. The caller should hold
+ * a write lock on for the tasks pagg_sem.  This can be locked using
+ * down_write(&task->pagg_sem)
+ *
+ */
+struct pagg *
+pagg_alloc(struct task_struct *task, struct pagg_hook *pagg_hook)
+{
+	struct pagg *pagg;
+
+	pagg = kmalloc(sizeof(struct pagg), GFP_KERNEL);
+	if (!pagg)
+		return NULL;
+
+	pagg->hook = pagg_hook;
+	pagg->data = NULL;
+	atomic_inc(&pagg_hook->refcnt);  /* Increase hook's reference count */
+	list_add_tail(&pagg->entry, &task->pagg_list);
+	return pagg;
+}
+
+
+/**
+ * pagg_free - Delete pagg from the list and free its memory
+ * @pagg: The pagg to free
+ *
+ * This function will ensure the pagg is deleted form
+ * the list of pagg entries for the task. Finally, the memory for the
+ * pagg is discarded.
+ *
+ * The caller of this function should hold a write lock on the pagg_sem
+ * for the task. This can be locked using down_write(&task->pagg_sem).
+ *
+ * Prior to calling pagg_free, the pagg should have been detached from the
+ * pagg container represented by this pagg.  That is usually done using
+ * p->hook->detach(task, pagg);
+ *
+ */
+void
+pagg_free(struct pagg *pagg)
+{
+	atomic_dec(&pagg->hook->refcnt); /* decr the reference count on the hook */
+	list_del(&pagg->entry);
+	kfree(pagg);
+}
+
+
+/**
+ * get_pagg_hook - Get the pagg hook matching the requested name
+ * @key: The name of the pagg hook to get
+ *
+ * Given a pagg hook name key, this function will return a pointer
+ * to the pagg_hook struct that matches the name.
+ *
+ * You should hold either the write or read lock for pagg_hook_list_sem
+ * before using this function.  This will ensure that the pagg_hook_list
+ * does not change while iterating through the list entries.
+ *
+ */
+static struct pagg_hook *
+get_pagg_hook(char *key)
+{
+	struct pagg_hook *pagg_hook;
+
+	list_for_each_entry(pagg_hook, &pagg_hook_list, entry) {
+		if (!strcmp(pagg_hook->name, key)) {
+			return pagg_hook;
+		}
+	}
+	return NULL;
+}
+
+/**
+ * remove_client_paggs_from_all_tasks - Remove all paggs associated with hook
+ * @php: Pagg hook associated with paggs to purge
+ *
+ * Given a pagg hook, this function will remove all paggs associated with that
+ * pagg hook from all tasks calling the provided function on each pagg.
+ *
+ * If there is a detach function associated with the pagg, it is called
+ * before the pagg is freed.
+ *
+ * This is meant to be used by pagg_hook_register and pagg_hook_unregister
+ *
+ */
+static void
+remove_client_paggs_from_all_tasks(struct pagg_hook *php)
+{
+	if (php == NULL)
+		return;
+
+	/* Because of internal race conditions we can't gaurantee
+	 * getting every task in just one pass so we just keep going
+	 * until there are no tasks with paggs from this hook attached.
+	 * The inefficiency of this should be tempered by the fact that this
+	 * happens at most once for each registered client.
+	 */
+	while (atomic_read(&php->refcnt) != 0) {
+		struct task_struct *p = NULL;
+
+		read_lock(&tasklist_lock);
+		for_each_process(p) {
+			struct pagg *paggp;
+
+			get_task_struct(p);
+			read_unlock(&tasklist_lock);
+			down_write(&p->pagg_sem);
+			paggp = pagg_get(p, php->name);
+			if (paggp != NULL) {
+				(void)php->detach(p, paggp);
+				pagg_free(paggp);
+			}
+			up_write(&p->pagg_sem);
+			read_lock(&tasklist_lock);
+
+			/* If a PAGG got removed from the list while we're going through
+			 * each process, the tasks list for the process would be empty.  In
+			 * that case, break out of this for_each_process so we can do it
+			 * again. */
+			if (list_empty(&p->tasks)) {
+				put_task_struct(p);
+				break;
+			} else
+				put_task_struct(p);
+
+		}
+		read_unlock(&tasklist_lock);
+	}
+}
+
+/**
+ * pagg_hook_register - Register a new pagg hook and enter it the list
+ * @pagg_hook_new: The new pagg hook to register
+ *
+ * Used to register a new pagg hook and enter it into the pagg_hook_list.
+ * The service name for a pagg hook is restricted to 32 characters.
+ *
+ * If an "init()" function is supplied in the hook being registered then a
+ * pagg will be attached to all existing tasks and the supplied "init()"
+ * function will be applied to it.  If any call to the supplied "init()"
+ * function returns a non zero result the registration will be aborted. As
+ * part of the abort process, all paggs belonging to the new client will be
+ * removed from all tasks and the supplied "detach()" function will be
+ * called on them.
+ *
+ * If a memory error is encountered, the pagg hook is unregistered and any
+ * tasks that have been attached to the initial pagg container are detached
+ * from that container.
+ *
+ */
+int
+pagg_hook_register(struct pagg_hook *pagg_hook_new)
+{
+	struct pagg_hook *pagg_hook = NULL;
+
+	/* Add new pagg module to access list */
+	if (!pagg_hook_new)
+		return -EINVAL;			/* error */
+	if (!list_empty(&pagg_hook_new->entry))
+		return -EINVAL;			/* error */
+	if (pagg_hook_new->name == NULL || strlen(pagg_hook_new->name) > PAGG_NAMELN)
+		return -EINVAL;			/* error */
+
+	/* Try to insert new hook entry into the pagg hook list */
+	down_write(&pagg_hook_list_sem);
+
+	pagg_hook = get_pagg_hook(pagg_hook_new->name);
+
+	if (pagg_hook) {
+		up_write(&pagg_hook_list_sem);
+		printk(KERN_WARNING "Attempt to register duplicate"
+				" PAGG support (name=%s)\n", pagg_hook_new->name);
+		return -EBUSY;
+	}
+
+	/* Okay, we can insert into the pagg hook list */
+	list_add_tail(&pagg_hook_new->entry, &pagg_hook_list);
+	/* set the ref count to zero */
+	atomic_set(&pagg_hook_new->refcnt, 0);
+
+	/* Now we can call the initializer function (if present) for each task */
+	if (pagg_hook_new->init != NULL) {
+		int init_result = 0;
+		int task_exited = 0;
+
+		/* Because of internal race conditions we can't gaurantee
+		 * getting every task in just one pass so we just keep going
+		 * until we don't find any unitialized tasks.  The inefficiency
+		 * of this should be tempered by the fact that this happens
+		 * at most once for each registered client.
+		 */
+		do {
+			struct task_struct *p = NULL;
+
+			read_lock(&tasklist_lock);
+			for_each_process(p) {
+				struct pagg *paggp;
+
+				get_task_struct(p);
+				read_unlock(&tasklist_lock);
+				down_write(&p->pagg_sem);
+				paggp = pagg_get(p, pagg_hook_new->name);
+				if (paggp == NULL) {
+					paggp = pagg_alloc(p, pagg_hook_new);
+					if (paggp != NULL)
+						init_result = pagg_hook_new->init(p, paggp);
+					else
+						init_result = -ENOMEM;
+				}
+				up_write(&p->pagg_sem);
+				read_lock(&tasklist_lock);
+				/* Like in remove_client_paggs_from_all_tasks, if the task
+				 * disappeared on us while we were going through the
+				 * for_each_process loop, we need to start over with that loop.
+				 * That's why we have the list_empty here */
+				task_exited = list_empty(&p->tasks);
+				put_task_struct(p);
+				if ((init_result != 0) || task_exited) {
+					break;
+				}
+			}
+			read_unlock(&tasklist_lock);
+		} while ((init_result == 0) && task_exited);
+
+		/*
+		 * if anything went wrong during initialisation abandon the
+		 * registration process
+		 */
+		if (init_result != 0) {
+			remove_client_paggs_from_all_tasks(pagg_hook_new);
+			list_del_init(&pagg_hook_new->entry);
+			up_write(&pagg_hook_list_sem);
+
+			printk(KERN_WARNING "Registering PAGG support for"
+				" (name=%s) failed\n", pagg_hook_new->name);
+
+			return init_result; /* hook init function error result */
+		}
+	}
+
+	up_write(&pagg_hook_list_sem);
+
+	printk(KERN_INFO "Registering PAGG support for (name=%s)\n",
+			pagg_hook_new->name);
+
+	return 0;					/* success */
+
+}
+
+/**
+ * pagg_hook_unregister - Unregister pagg hook and remove it from the list
+ * @pagg_hook_old: The hook to unregister and remove
+ *
+ * Used to unregister pagg hooks and remove them from the pagg_hook_list.
+ * Once the pagg hook entry in the pagg_hook_list is found, paggs associated
+ * with the hook (if any) will have their detach function called and will
+ * be detached.
+ *
+ */
+int
+pagg_hook_unregister(struct pagg_hook *pagg_hook_old)
+{
+	struct pagg_hook *pagg_hook;
+
+	/* Check the validity of the arguments */
+	if (!pagg_hook_old)
+		return -EINVAL;			/* error */
+	if (list_empty(&pagg_hook_old->entry))
+		return -EINVAL;			/* error */
+	if (pagg_hook_old->name == NULL)
+		return -EINVAL;			/* error */
+
+	down_write(&pagg_hook_list_sem);
+
+	pagg_hook = get_pagg_hook(pagg_hook_old->name);
+
+	if (pagg_hook && pagg_hook == pagg_hook_old) {
+		remove_client_paggs_from_all_tasks(pagg_hook);
+		list_del_init(&pagg_hook->entry);
+		up_write(&pagg_hook_list_sem);
+
+		printk(KERN_INFO "Unregistering PAGG support for"
+				" (name=%s)\n", pagg_hook_old->name);
+
+		return 0;			/* success */
+	}
+
+	up_write(&pagg_hook_list_sem);
+
+	printk(KERN_WARNING "Attempt to unregister PAGG support (name=%s)"
+			" failed - not found\n", pagg_hook_old->name);
+
+	return -EINVAL;				/* error */
+}
+
+
+/**
+ * __pagg_attach - Attach a new task to the same containers of its parent
+ * @to_task: The child task that will inherit the parent's containers
+ * @from_task: The parent task
+ *
+ * Used to attach a new task to the same pagg containers to which it's parent
+ * is attached.
+ *
+ * The "from" argument is the parent task.  The "to" argument is the child
+ * task.
+ *
+ */
+void
+__pagg_attach(struct task_struct *to_task, struct task_struct *from_task)
+{
+	struct pagg *from_pagg;
+
+	/* lock the parents pagg_list we are copying from */
+	down_read(&from_task->pagg_sem); /* read lock the pagg list */
+
+	list_for_each_entry(from_pagg, &from_task->pagg_list, entry) {
+		struct pagg *to_pagg = NULL;
+
+		to_pagg = pagg_alloc(to_task, from_pagg->hook);
+		if (!to_pagg) {
+			goto error_return;
+		}
+		if (to_pagg->hook->attach(to_task, to_pagg, from_pagg->data) != 0 )
+			goto error_return;
+	}
+
+	up_read(&from_task->pagg_sem); /* unlock the pagg list */
+
+	return;					/* success */
+
+  error_return:
+	/*
+	 * Clean up all the pagg attachments made on behalf of the new
+	 * task.  Set new task pagg ptr to NULL for return.
+	 */
+	up_read(&from_task->pagg_sem); /* unlock the pagg list */
+	__pagg_detach(to_task);
+	return;				/* failure */
+}
+
+/**
+ * __pagg_detach - Detach a task from all pagg containers it is attached to
+ * @task: Task to detach from pagg containers
+ *
+ * Used to detach a task from all pagg containers to which it is attached.
+ *
+ */
+void
+__pagg_detach(struct task_struct *task)
+{
+	struct pagg *pagg;
+	struct pagg *paggtmp;
+
+	/* Remove ref. to paggs from task immediately */
+	down_write(&task->pagg_sem); /* write lock pagg list */
+
+	list_for_each_entry_safe(pagg, paggtmp, &task->pagg_list, entry) {
+		pagg->hook->detach(task, pagg);
+		pagg_free(pagg);
+	}
+
+	up_write(&task->pagg_sem); /* write unlock the pagg list */
+
+	return;   /* 0 = success, else return last code for failure */
+}
+
+
+/**
+ * __pagg_exec - Execute callback when a process in a container execs
+ * @task: We go through the pagg list in the given task
+ *
+ * Used to when a process that is in a pagg container does an exec.
+ *
+ * The "from" argument is the task.  The "name" argument is the name
+ * of the process being exec'ed.
+ *
+ */
+int
+__pagg_exec(struct task_struct *task)
+{
+	struct pagg	*pagg;
+
+	/* lock the parents pagg_list we are copying from */
+	down_read(&task->pagg_sem); /* lock the pagg list */
+
+	list_for_each_entry(pagg, &task->pagg_list, entry) {
+		if (pagg->hook->exec) /* conditional because it's optional */
+			pagg->hook->exec(task, pagg);
+	}
+
+	up_read(&task->pagg_sem); /* unlock the pagg list */
+	return 0;
+}
+
+
+EXPORT_SYMBOL(pagg_get);
+EXPORT_SYMBOL(pagg_alloc);
+EXPORT_SYMBOL(pagg_free);
+EXPORT_SYMBOL(pagg_hook_register);
+EXPORT_SYMBOL(pagg_hook_unregister);
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2004-08-14 00:37:40.000000000 -0500
+++ linux/kernel/exit.c	2004-08-26 14:35:53.000000000 -0500
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
+#include <linux/pagg.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -837,6 +838,9 @@
 		module_put(tsk->binfmt->module);

 	tsk->exit_code = code;
+
+	pagg_detach(tsk);
+
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
