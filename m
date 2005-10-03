Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVJCSqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVJCSqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVJCSqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:46:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57793 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932601AbVJCSqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:46:50 -0400
Date: Mon, 3 Oct 2005 13:46:47 -0500
From: Erik Jacobson <erikj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: pagg@oss.sgi.com
Subject: [PATCH 1/3] Process Notification / pnotify
Message-ID: <20051003184644.GA19106@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new patch for Process Notification (pnotify).  This patch is 
derived from PAGG.  We've changed the name to better reflect its purpose and
changed the functions and structure names to make it easier to understand.

The pnotify patch allows kernel module authors to associate data with tasks
and receive notification about certain stages in the life of a task through
callbacks.

After applying the patch, please see Documentation/pnotify.txt for more
details and examples.

I implemented feedback received from lse-tech and the pagg mailing list and 
this patch is the result.

We have received positive feedback from multiple sources about this patch.
This patch, in its PAGG form, also has received exposure on ia64 by being 
part of SLES9.  

We're hoping this patch will be considered for mm inclusion and eventually
make it in to the kernel.

There will be two more postings showing two pnotify users:
Linux Job and keyrings.  keyrings is a proof of concept patch showing 
how one might change an existing kernel component to use pnotify.  Job
is the inescapable job container implementation.

I'm hoping we can move beyond this being seen as only a tool for accounting 
and consider its broader applications.

This was discussed in lse-tech recently.  Unfortunately, the threads got a 
bit broken up in the archives but the major pieces are:

main thread:
http://marc.theaimsgroup.com/?l=lse-tech&m=112733871706425&w=2

Performance data, 2p system:
http://marc.theaimsgroup.com/?l=lse-tech&m=112801353626865&w=2

Performance data, 32p system:
http://marc.theaimsgroup.com/?l=lse-tech&m=112810597609896&w=2

In addition, there has been activity on the PAGG mailing list about 
pnotify.  Find the list archives here: 
http://oss.sgi.com/archives/pagg/

Note: In lse-tech, I was asked to implement pnotify using RCU protections 
instead of semaphore read locks.  I did this in a proof of concecpt patch
but I feel RCU is too restrictive for the kernel module users in terms 
of sleep and, as I showed in the performance data, it doesn't buy us 
anything in terms of performance.


Signed-off-by: Erik Jacobson <erikj.sgi.com>
---

 Documentation/pnotify.txt |  368 +++++++++++++++++++++++++++++
 fs/exec.c                 |    2
 include/linux/init_task.h |    2
 include/linux/pnotify.h   |  227 ++++++++++++++++++
 include/linux/sched.h     |    5
 init/Kconfig              |    8
 kernel/Makefile           |    1
 kernel/exit.c             |    4
 kernel/fork.c             |   17 +
 kernel/pnotify.c          |  568 ++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1201 insertions(+), 1 deletion(-)


Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2005-09-30 14:57:55.097213456 -0500
+++ linux/fs/exec.c	2005-09-30 14:57:57.629184199 -0500
@@ -48,6 +48,7 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/pnotify.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1203,6 +1204,7 @@
 	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
 		free_arg_pages(bprm);
+		pnotify_exec(current);
 
 		/* execve success */
 		security_bprm_free(bprm);
Index: linux/include/linux/init_task.h
===================================================================
--- linux.orig/include/linux/init_task.h	2005-09-30 14:57:55.098189920 -0500
+++ linux/include/linux/init_task.h	2005-09-30 14:57:57.636019445 -0500
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
+#include <linux/pnotify.h>
 #include <linux/rcupdate.h>
 
 #define INIT_FDTABLE \
@@ -121,6 +122,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
+	INIT_TASK_PNOTIFY(tsk)						\
 	.fs_excl	= ATOMIC_INIT(0),				\
 }
 
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2005-09-30 14:57:55.098189920 -0500
+++ linux/include/linux/sched.h	2005-09-30 15:25:34.616252251 -0500
@@ -795,6 +795,11 @@
   	struct mempolicy *mempolicy;
 	short il_next;
 #endif
+#ifdef CONFIG_PNOTIFY
+/* List of pnotify kernel module subscribers */
+	struct list_head pnotify_subscriber_list;
+	struct rw_semaphore pnotify_subscriber_list_sem;
+#endif
 #ifdef CONFIG_CPUSETS
 	struct cpuset *cpuset;
 	nodemask_t mems_allowed;
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2005-09-30 14:57:55.099166384 -0500
+++ linux/init/Kconfig	2005-09-30 15:25:34.489311959 -0500
@@ -162,6 +162,14 @@
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+config PNOTIFY
+	bool "Support for Process Notification"
+	help
+     Say Y here if you will be loading modules which provide support
+     for process notification.  Examples of such modules include the
+     Linux Jobs module and the Linux Array Sessions module.  If you will not
+     be using such modules, say N.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2005-09-30 14:57:55.100142848 -0500
+++ linux/kernel/Makefile	2005-09-30 15:25:34.490288423 -0500
@@ -20,6 +20,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_PNOTIFY) += pnotify.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2005-09-30 14:57:55.100142848 -0500
+++ linux/kernel/fork.c	2005-09-30 15:54:50.502255817 -0500
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/pnotify.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -151,6 +152,9 @@
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
+
+	/* Initialize the pnotify list in pid 0 before it can clone itself. */
+	INIT_PNOTIFY_LIST(current);
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -1039,6 +1043,15 @@
 	p->exit_state = 0;
 
 	/*
+	 * Call pnotify kernel module subscribers and add the same subscribers the
+	 * parent has to the new process.
+	 * Fail the fork on error.
+	 */
+	retval = pnotify_fork(p, current);
+	if (retval)
+ 		goto bad_fork_cleanup_namespace;
+
+	/*
 	 * Ok, make it visible to the rest of the system.
 	 * We dont wake it up yet.
 	 */
@@ -1073,7 +1086,7 @@
 	if (sigismember(&current->pending.signal, SIGKILL)) {
 		write_unlock_irq(&tasklist_lock);
 		retval = -EINTR;
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_pnotify;
 	}
 
 	/* CLONE_PARENT re-uses the old parent */
@@ -1159,6 +1172,8 @@
 		return ERR_PTR(retval);
 	return p;
 
+bad_fork_cleanup_pnotify:
+	pnotify_exit(p);
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_keys:
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2005-09-30 14:57:55.100142848 -0500
+++ linux/kernel/exit.c	2005-09-30 15:25:34.617228715 -0500
@@ -29,6 +29,7 @@
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
 #include <linux/cpuset.h>
+#include <linux/pnotify.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
 
@@ -866,6 +867,9 @@
 		module_put(tsk->binfmt->module);
 
 	tsk->exit_code = code;
+
+	pnotify_exit(tsk);
+
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
Index: linux/kernel/pnotify.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/pnotify.c	2005-09-30 16:01:50.518408112 -0500
@@ -0,0 +1,568 @@
+/*
+ * Process Notification (pnotify) interface
+ *
+ *
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
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
+#include <linux/module.h>
+#include <linux/pnotify.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <asm/semaphore.h>
+
+/* list of pnotify event list entries that reference the "module"
+ * implementations */
+static LIST_HEAD(pnotify_event_list);
+static DECLARE_RWSEM(pnotify_event_list_sem);
+
+
+/**
+ * pnotify_get_subscriber - get a pnotify subscriber given a search key
+ * @task: We examine the pnotify_subscriber_list from the given task
+ * @key: Key name of kernel module subscriber we wish to retrieve
+ *
+ * Given a pnotify_subscriber_list structure, this function will return
+ * a pointer to the kernel module pnotify_subsciber struct that matches the
+ * search key.  If the key is not found, the function will return NULL.
+ *
+ * Locking: This is a pnotify_subscriber_list reader.  This function should
+ * be called with at least a read lock on the pnotify_subscriber_list using
+ * down_read(&task->pnotify_subscriber_list_sem).
+ *
+ */
+struct pnotify_subscriber *
+pnotify_get_subscriber(struct task_struct *task, char *key)
+{
+	struct pnotify_subscriber *subscriber;
+
+	list_for_each_entry(subscriber, &task->pnotify_subscriber_list, entry) {
+		if (!strcmp(subscriber->events->name,key))
+			return subscriber;
+	}
+	return NULL;
+}
+
+
+/**
+ * pnotify_subscribe - Add kernel module to the subscriber list for process
+ * @task: Task that gets the new kernel module subscriber added to the list
+ * @events: pnotify_events structure to associate with kernel module
+ *
+ * Given a task and a pnotify_events structure, this function will allocate
+ * a new pnotify_subscriber, initialize the settings, and insert it into
+ * the pnotify_subscriber_list for the task.
+ *
+ * Locking:
+ * The caller for this function should hold at least a read lock on the
+ * pnotify_event_list_sem - or ensure that the pnotify_events entry cannot be
+ * removed. If this function was called from the pnotify module (usually the
+ * case), then the caller need not hold this lock because the event
+ * structure won't disappear until pnotify_unregister is called.
+ *
+ * This is a pnotify_subscriber_list WRITER.  The caller must hold a write
+ * lock on for the tasks pnotify_subscriber_list_sem.  This can be locked
+ * using down_write(&task->pnotify_subscriber_list_sem).
+ */
+struct pnotify_subscriber *
+pnotify_subscribe(struct task_struct *task, struct pnotify_events *events)
+{
+	struct pnotify_subscriber *subscriber;
+
+	subscriber = kmalloc(sizeof(struct pnotify_subscriber), GFP_KERNEL);
+	if (!subscriber)
+		return NULL;
+
+	subscriber->events = events;
+	subscriber->data = NULL;
+	atomic_inc(&events->refcnt);  /* Increase hook's reference count */
+	list_add_tail(&subscriber->entry, &task->pnotify_subscriber_list);
+	return subscriber;
+}
+
+
+/**
+ * pnotify_unsubscribe - Remove kernel module subscriber from process
+ * @subscriber: The subscriber to remove
+ *
+ * This function will ensure the subscriber is deleted form
+ * the list of subscribers for the task. Finally, the memory for the
+ * subscriber is discarded.
+ *
+ * Prior to calling pnotify_unsubscribe, the subscriber should have been
+ * detached from any uses the kernel module may have.  This is often done using
+ * p->events->exit(task, subscriber);
+ *
+ * Locking:
+ * This is a pnotify_subscriber_list WRITER.  The caller of this function must
+ * hold a write lock on the pnotify_subscriber_list_sem for the task. This can
+ * be locked using down_write(&task->pnotify_subscriber_list_sem).  Because
+ * events are referenced, the caller should ensure the events structure
+ * doesn't disappear.  If the caller is a pnotify module, the events
+ * structure won't disappear until pnotify_unregister is called so it's safe
+ * not to lock the pnotify_event_list_sem.
+ *
+ *
+ */
+void
+pnotify_unsubscribe(struct pnotify_subscriber *subscriber)
+{
+	atomic_dec(&subscriber->events->refcnt); /* dec events ref count */
+	list_del(&subscriber->entry);
+	kfree(subscriber);
+}
+
+
+/**
+ * pnotify_get_events - Get the pnotify_events struct matching requested name
+ * @key: The name of the events structure to get
+ *
+ * Given a pnotify_events struct name that represents the kernel module name,
+ * this function will return a pointer to the pnotify_events structure that
+ * matches the name.
+ *
+ * Locking:
+ * You should hold either the write or read lock for pnotify_event_list_sem
+ * before using this function.  This will ensure that the pnotify_event_list
+ * does not change while iterating through the list entries.
+ *
+ */
+static struct pnotify_events *
+pnotify_get_events(char *key)
+{
+	struct pnotify_events *events;
+
+	list_for_each_entry(events, &pnotify_event_list, entry) {
+		if (!strcmp(events->name, key)) {
+			return events;
+		}
+	}
+	return NULL;
+}
+
+/**
+ * remove_subscriber_from_all_tasks - Remove subscribers for given events struct
+ * @events: pnotify_events struct for subscribers to remove
+ *
+ * Given a kernel module events struct registered with pnotify,
+ * this function will remove all subscribers matching the events struct from
+ * all tasks.
+ *
+ * If there is a exit function associated with the subscriber, it is called
+ * before the subscriber is unsubscribed/freed.
+ *
+ * This is meant to be used by pnotify_register and pnotify_unregister
+ *
+ * Locking: This is a pnotify_subscriber_list WRITER and this function
+ * handles locking of the pnotify_subscriber_list_sem so callers don't
+ * need to.
+ *
+ */
+static void
+remove_subscriber_from_all_tasks(struct pnotify_events *events)
+{
+	if (events == NULL)
+		return;
+
+	/* Because of internal race conditions we can't guarantee
+	 * getting every task in just one pass so we just keep going
+	 * until there are no tasks with subscribers from this events struct
+	 * attached. The inefficiency of this should be tempered by the fact
+	 * that this happens at most once for each registered client.
+	 */
+	while (atomic_read(&events->refcnt) != 0) {
+		struct task_struct *g = NULL, *p = NULL;
+
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			struct pnotify_subscriber *subscriber;
+			int task_exited;
+
+			get_task_struct(p);
+			read_unlock(&tasklist_lock);
+			down_write(&p->pnotify_subscriber_list_sem);
+			subscriber = pnotify_get_subscriber(p, events->name);
+			if (subscriber != NULL) {
+				(void)events->exit(p, subscriber);
+				pnotify_unsubscribe(subscriber);
+			}
+			up_write(&p->pnotify_subscriber_list_sem);
+			read_lock(&tasklist_lock);
+			/* If a task exited while we were looping, its sibling
+			 * list would be empty.  In that case, we jump out of
+			 * the do_each_thread and loop again in the outter
+			 * while because the reference count probably isn't
+			 * zero for the pnotify events yet.  Doing it this way
+			 * makes it so we don't hold the tasklist lock too
+			 * long.
+			 */
+
+
+			task_exited = list_empty(&p->sibling);
+			put_task_struct(p);
+			if (task_exited)
+				goto endloop;
+		} while_each_thread(g, p);
+ endloop:
+		read_unlock(&tasklist_lock);
+	}
+}
+
+/**
+ * pnotify_register - Register a new module subscriber and enter it in the list
+ * @events_new: The new pnotify events structure to register.
+ *
+ * Used to register a new module subscriber pnotify_events structure and enter
+ * it into the pnotify_event_list.  The service name for a pnotify_events
+ * struct is restricted to 32 characters.
+ *
+ * If an "init()" function is supplied in the events struct being registered
+ * then the kernel module will be subscribed to all existing tasks and the
+ * supplied "init()" function will be applied to it.  If any call to the
+ * supplied "init()" function returns a non zero result, the registration will
+ * be aborted. As part of the abort process, all subscribers belonging to the
+ * new client will be removed from all tasks and the supplied "detach()"
+ * function will be called on them.
+ *
+ * If a memory error is encountered, the module (pnotify_events structure)
+ * is unregistered and any tasks we became subscribed to are detached.
+ *
+ * Locking: This function is an event list writer as well as a
+ * pnotify_subscriber_list writer.  This function does the locks itself.
+ * Callers don't need to.
+ *
+ */
+int
+pnotify_register(struct pnotify_events *events_new)
+{
+	struct pnotify_events *events = NULL;
+
+	/* Add new pnotify module to access list */
+	if (!events_new)
+		return -EINVAL;			/* error */
+	if (!list_empty(&events_new->entry))
+		return -EINVAL;			/* error */
+	if (events_new->name == NULL || strlen(events_new->name) >
+	    PNOTIFY_NAMELN)
+		return -EINVAL;			/* error */
+	if (!events_new->fork || !events_new->exit)
+		return -EINVAL;                 /* error */
+
+	/* Try to insert new events entry into the events list */
+	down_write(&pnotify_event_list_sem);
+
+	events = pnotify_get_events(events_new->name);
+
+	if (events) {
+		up_write(&pnotify_event_list_sem);
+		printk(KERN_WARNING "Attempt to register duplicate"
+		       " pnotify support (name=%s)\n", events_new->name);
+		return -EBUSY;
+	}
+
+	/* Okay, we can insert into the events list */
+	list_add_tail(&events_new->entry, &pnotify_event_list);
+	/* set the ref count to zero */
+	atomic_set(&events_new->refcnt, 0);
+
+	/* Now we can call the init function (if present) for each task */
+	if (events_new->init != NULL) {
+		struct task_struct *g = NULL, *p = NULL;
+		int init_result = 0;
+
+		/* Because of internal race conditions we can't guarantee
+		 * getting every task in just one pass so we just keep going
+		 * until we don't find any unitialized tasks.  The inefficiency
+		 * of this should be tempered by the fact that this happens
+		 * at most once for each registered client.
+		 */
+		read_lock(&tasklist_lock);
+ repeat:
+		do_each_thread(g, p) {
+			struct pnotify_subscriber *subscriber;
+			int task_exited;
+
+			get_task_struct(p);
+			read_unlock(&tasklist_lock);
+			down_write(&p->pnotify_subscriber_list_sem);
+			subscriber = pnotify_get_subscriber(p,
+							    events_new->name);
+			if (!subscriber && !(p->flags & PF_EXITING)) {
+				subscriber = pnotify_subscribe(p, events_new);
+				if (subscriber != NULL) {
+					init_result = events_new->init(p,
+								subscriber);
+
+					/* Success, but init function pointer
+					 * doesn't want kernel module on the
+					 * subscriber list. */
+					if (init_result > 0) {
+						pnotify_unsubscribe(subscriber);
+					}
+				}
+				else {
+					init_result = -ENOMEM;
+				}
+			}
+			up_write(&p->pnotify_subscriber_list_sem);
+			read_lock(&tasklist_lock);
+			/* Like in remove_subscriber_from_all_tasks, if the
+			 * task disappeared on us while we were going through
+			 * the for_each_thread loop, we need to start over
+			 * with that loop.  That's why we have the list_empty
+			 * here */
+			task_exited = list_empty(&p->sibling);
+			put_task_struct(p);
+			if (init_result < 0)
+				goto endloop;
+			if (task_exited)
+				goto repeat;
+		} while_each_thread(g, p);
+ endloop:
+		read_unlock(&tasklist_lock);
+
+		/*
+		 * if anything went wrong during initialisation abandon the
+		 * registration process
+		 */
+		if (init_result < 0) {
+			remove_subscriber_from_all_tasks(events_new);
+			list_del_init(&events_new->entry);
+			up_write(&pnotify_event_list_sem);
+
+			printk(KERN_WARNING "Registering pnotify support for"
+				" (name=%s) failed\n", events_new->name);
+
+			return init_result; /* init function error result */
+		}
+	}
+
+	up_write(&pnotify_event_list_sem);
+
+	printk(KERN_INFO "Registering pnotify support for (name=%s)\n",
+			events_new->name);
+
+	return 0; /* success */
+
+}
+
+/**
+ * pnotify_unregister - Unregister kernel module/pnotify_event struct
+ * @event_old: pnotify_event struct for the kernel module we're unregistering
+ *
+ * Used to unregister kernel module subscribers indicated by
+ * pnotify_events struct.  Removes them from the list of kernel modules
+ * in pnotify_event_list.
+ *
+ * Once the events entry in the pnotify_event_list is found, subscribers for
+ * this kernel module have their exit functions called and will then be
+ * removed from the list.
+ *
+ * Locking: This functoin is a pnotify_event_list writer.  It also calls
+ * remove_subscriber_from_all_tasks, which is a pnotify_subscriber_list
+ * writer.  Callers don't need to hold these locks ahead of calling this
+ * function.
+ *
+ */
+int
+pnotify_unregister(struct pnotify_events *events_old)
+{
+	struct pnotify_events *events;
+
+	/* Check the validity of the arguments */
+	if (!events_old)
+		return -EINVAL;	/* error */
+	if (list_empty(&events_old->entry))
+		return -EINVAL;	/* error */
+	if (events_old->name == NULL)
+		return -EINVAL;	/* error */
+
+	down_write(&pnotify_event_list_sem);
+
+	events = pnotify_get_events(events_old->name);
+
+	if (events && events == events_old) {
+		remove_subscriber_from_all_tasks(events);
+		list_del_init(&events->entry);
+		up_write(&pnotify_event_list_sem);
+
+		printk(KERN_INFO "Unregistering pnotify support for"
+				 " (name=%s)\n", events_old->name);
+
+		return 0; /* success */
+	}
+
+	up_write(&pnotify_event_list_sem);
+
+	printk(KERN_WARNING "Attempt to unregister pnotify support (name=%s)"
+			    " failed - not found\n", events_old->name);
+
+	return -EINVAL;	/* error */
+}
+
+
+/**
+ * __pnotify_fork - Add kernel module subscribe to same subscribers as parent
+ * @to_task: The child task that will inherit the parent's subscribers
+ * @from_task: The parent task
+ *
+ * Make it so a new task being constructed has the same kernel module
+ * subscribers of its parent.
+ *
+ * The "from" argument is the parent task.  The "to" argument is the child
+ * task.
+ *
+ * See Documentation/pnotify.txt * for details on
+ * how to handle return codes from the attach function pointer.
+ *
+ * Locking: The to_task is currently in-construction, so we don't
+ * need to worry about write-locks.  We do need to be sure the parent's
+ * subscriber list, which we copy here, doesn't go away on us.  This function
+ * read-locks the pnotify_subscriber_list.  Callers don't need to lock.
+ *
+ */
+int
+__pnotify_fork(struct task_struct *to_task, struct task_struct *from_task)
+{
+	struct pnotify_subscriber *from_subscriber;
+	int ret;
+
+	/* lock the parents subscriber list we are copying from */
+	down_read(&from_task->pnotify_subscriber_list_sem);
+
+	list_for_each_entry(from_subscriber,
+			    &from_task->pnotify_subscriber_list, entry) {
+		struct pnotify_subscriber *to_subscriber = NULL;
+
+		to_subscriber = pnotify_subscribe(to_task,
+						  from_subscriber->events);
+		if (!to_subscriber) {
+			/* Failed to get memory.
+			 * we don't force __pnotify_exit to run here because
+			 * the child is in-consturction and not running yet.
+			 * We don't need a write lock on the subscriber
+			 * list because the child is in construction.
+			 */
+			pnotify_unsubscribe(to_task);
+			up_read(&from_task->pnotify_subscriber_list_sem);
+			return -ENOMEM;
+		}
+		ret = to_subscriber->events->fork(to_task, to_subscriber,
+						  from_subscriber->data);
+
+		if (ret < 0) {
+			/* Propagates to copy_process as a fork failure.
+			 * Since the child is in consturction, we don't
+			 * need a write lock on the subscriber list.
+			 * __pnotify_exit isn't run because the child
+			 * never got running, exit doesn't make sense.
+			 */
+			pnotify_unsubscribe(to_task);
+			up_read(&from_task->pnotify_subscriber_list_sem);
+			return ret; /* Fork failure */
+		}
+		else if (ret > 0) {
+			/* Success, but fork function pointer in the
+			 * pnotify_events structure doesn't want the kernel
+			 * module subscribed.  This is an in-construction
+			 * child so we don't need to write lock */
+			pnotify_unsubscribe(to_subscriber);
+		}
+	}
+
+	/* unlock parent's subscriber list */
+	up_read(&from_task->pnotify_subscriber_list_sem);
+
+	return 0; /* success */
+}
+
+/**
+ * __pnotify_exit - Remove all subscribers from given task
+ * @task: Task to remove subscribers from
+ *
+ * For each subscriber for the given task, we run the function pointer
+ * for exit in the associated pnotify_events structure then remove the
+ * it from the tasks's subscriber list until all subscribers are gone.
+ *
+ * Locking: This is a pnotify_subscriber_list writer.  This function
+ * write locks the pnotify_subscriber_list. Callers don't have to do their own
+ * locking.  The pnotify_events structure referenced exit function is called
+ * with the pnotify_subscriber_list write lock held.
+ *
+ */
+void
+__pnotify_exit(struct task_struct *task)
+{
+	struct pnotify_subscriber *subscriber;
+	struct pnotify_subscriber *subscribertmp;
+
+	/* Remove ref. to subscribers from task immediately */
+	down_write(&task->pnotify_subscriber_list_sem);
+
+	list_for_each_entry_safe(subscriber, subscribertmp,
+				 &task->pnotify_subscriber_list, entry) {
+		subscriber->events->exit(task, subscriber);
+		pnotify_unsubscribe(subscriber);
+	}
+
+	up_write(&task->pnotify_subscriber_list_sem);
+
+	return;   /* 0 = success, else return last code for failure */
+}
+
+
+/**
+ * __pnotify_exec - Execute exec callback for each subscriber in this task
+ * @task: We go through the subscriber list in the given task
+ *
+ * Used to when a process that has a subscriber list does an exec.
+ * The exec pointer in the events structure is optional.
+ *
+ * Locking: This is a pnotify_subscriber_list reader and implements the
+ * read locks itself. Callers don't need to do their own locking.  The
+ * pnotify_events referenced exec function pointer is called in an
+ * environment where the pnotify_subscriber_list is read locked.
+ *
+ */
+int
+__pnotify_exec(struct task_struct *task)
+{
+	struct pnotify_subscriber	*subscriber;
+
+	down_read(&task->pnotify_subscriber_list_sem);
+
+	list_for_each_entry(subscriber, &task->pnotify_subscriber_list, entry) {
+		if (subscriber->events->exec) /* exec funct. ptr is optional */
+			subscriber->events->exec(task, subscriber);
+	}
+
+	up_read(&task->pnotify_subscriber_list_sem);
+	return 0;
+}
+
+
+EXPORT_SYMBOL_GPL(pnotify_get_subscriber);
+EXPORT_SYMBOL_GPL(pnotify_subscribe);
+EXPORT_SYMBOL_GPL(pnotify_unsubscribe);
+EXPORT_SYMBOL_GPL(pnotify_register);
+EXPORT_SYMBOL_GPL(pnotify_unregister);
Index: linux/include/linux/pnotify.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/pnotify.h	2005-09-30 14:57:57.651642867 -0500
@@ -0,0 +1,227 @@
+/*
+ * Process Notification (pnotify) interface
+ *
+ *
+ * Copyright (c) 2000-2002, 2004-2005 Silicon Graphics, Inc.
+ * All Rights Reserved.
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
+ * process notification (pnotify).
+ *
+ * pnotify provides a method (service) for kernel modules to be notified when
+ * certain events happen in the life of a process.  It also provides a
+ * data pointer that is associated with a given process.  See
+ * Documentation/pnotify.txt for a full description.
+ */
+
+#ifndef _LINUX_PNOTIFY_H
+#define _LINUX_PNOTIFY_H
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_PNOTIFY
+
+#define PNOTIFY_NAMELN	32	/* Max chars in PNOTIFY kernel module name */
+
+#define PNOTIFY_ERROR	-1	/* Error. Fork fail for pnotify_fork */
+#define PNOTIFY_OK	0	/* All is well, stay subscribed */
+#define PNOTIFY_NOSUB	1	/* All is well but don't subscribe module
+				 * to subscriber list for the process */
+
+
+/**
+ * INIT_PNOTIFY_LIST - init a pnotify subscriber list struct after declaration
+ * @_l: Task struct to init the pnotify_module_subscriber_list and semaphore
+ *
+ */
+#define INIT_PNOTIFY_LIST(_l)						\
+do {									\
+	INIT_LIST_HEAD(&(_l)->pnotify_subscriber_list);			\
+	init_rwsem(&(_l)->pnotify_subscriber_list_sem);			\
+} while(0)
+
+/*
+ * Used by task_struct to manage list of subscriber kernel modules for the
+ * process.  Each pnotify_subscriber provides the link between the process
+ * and the correct kernel module subscriber.
+ *
+ * STRUCT MEMBERS:
+ *     pnotify_events: events:	Reference to pnotify_events structure, which
+ *                              holds the name key and function pointers.
+ *     data:	Opaque data pointer - defined by pnotify kernel modules.
+ *     entry:	List pointers
+ */
+struct pnotify_subscriber {
+       struct pnotify_events	*events;
+       void			*data;
+       struct list_head		entry;
+};
+
+/*
+ * Used by pnotify modules to define the callback functions into the
+ * module.  See Documentation/pnotify.txt for details.
+ *
+ * STRUCT MEMBERS:
+ *     name:           The name of the pnotify container type provided by
+ *                     the module. This will be set by the pnotify module.
+ *     fork:           Function pointer to function used when associating
+ *                     a forked process with a kernel module referenced by
+ *                     this struct.   pnotify.txt will provide details on
+ *                     special return codes interpreted by pnotify.
+ *
+ *     exit:           Function pointer to function used when a process
+ *                     associated with the kernel module owning this struct
+ *                     exits.
+ *
+ *     init:           Function pointer to initialization function.  This
+ *                     function is used when the module registers with pnotify
+ *                     to associate existing processes with the referring
+ *                     kernel module.  This is optional and may be set to NULL
+ *                     if it is not needed by the pnotify kernel module.
+ *
+ *                     Note: The return values are managed the same way as in
+ *                     attach above.  Except, of course, an error doesn't
+ *                     result in a fork failure.
+ *
+ *                     Note: The implementation of pnotify_register causes
+ *                     us to evaluate some tasks more than once in some cases.
+ *                     See the comments in pnotify_register for why.
+ *                     Therefore, if the init function pointer returns
+ *                     PNOTIFY_NOSUB, which means that it doesn't want this
+ *                     process associated with the kernel module, that init
+ *                     function must be prepared to possibly look at the same
+ *                     "skipped" task more than once.
+ *
+ *     data:           Opaque data pointer - defined by pnotify modules.
+ *     module:         Pointer to kernel module struct.  Used to increment &
+ *                     decrement the use count for the module.
+ *     entry:	       List pointers
+ *     exec:           Function pointer to function used when a process
+ *                     this kernel module is subscribed to execs. This
+ *                     is optional and may be set to NULL if it is not
+ *                     needed by the pnotify module.
+ *     refcnt:         Keep track of user count of pnotify_events
+ */
+struct pnotify_events {
+	struct module		*module;
+	char			*name;	/* Name Key - restricted to 32 chars */
+	void			*data;	/* Opaque module specific data */
+	struct list_head	entry;	/* List pointers */
+	atomic_t 		refcnt; /* usage counter */
+	int	(*init)(struct task_struct *, struct pnotify_subscriber *);
+	int	(*fork)(struct task_struct *, struct pnotify_subscriber *, void*);
+	void	(*exit)(struct task_struct *, struct pnotify_subscriber *);
+	void	(*exec)(struct task_struct *, struct pnotify_subscriber *);
+};
+
+
+/* Kernel service functions for providing pnotify support */
+extern struct pnotify_subscriber *pnotify_get_subscriber(struct task_struct
+							 *task, char *key);
+extern struct pnotify_subscriber *pnotify_subscribe(struct task_struct *task,
+						    struct pnotify_events *pt);
+extern void pnotify_unsubscribe(struct pnotify_subscriber *subscriber);
+extern int pnotify_register(struct pnotify_events *pt_new);
+extern int pnotify_unregister(struct pnotify_events *pt_old);
+extern int __pnotify_fork(struct task_struct *to_task,
+			  struct task_struct *from_task);
+extern void __pnotify_exit(struct task_struct *task);
+extern int __pnotify_exec(struct task_struct *task);
+
+/**
+ * pnotify_fork - child inherits subscriber list associations of its parent
+ * @child: child task - to inherit
+ * @parent: parenet task - child inherits subscriber list from this parent
+ *
+ * function used when a child process must inherit subscriber list assocation
+ * from the parent.  Return code is propagated as a fork fail.
+ *
+ */
+static inline int pnotify_fork(struct task_struct *child,
+			       struct task_struct *parent)
+{
+	INIT_PNOTIFY_LIST(child);
+	if (!list_empty(&parent->pnotify_subscriber_list))
+		return __pnotify_fork(child, parent);
+
+	return 0;
+}
+
+
+/**
+ * pnotify_exit - Detach subscriber kernel modules from this process
+ * @task: The task the subscribers will be detached from
+ *
+ */
+static inline void pnotify_exit(struct task_struct *task)
+{
+	if (!list_empty(&task->pnotify_subscriber_list))
+		__pnotify_exit(task);
+}
+
+/**
+ * pnotify_exec - Used when a process exec's
+ * @task: The process doing the exec
+ *
+ */
+static inline void pnotify_exec(struct task_struct *task)
+{
+	if (!list_empty(&task->pnotify_subscriber_list))
+		__pnotify_exec(task);
+}
+
+/**
+ * INIT_TASK_PNOTIFY - Used in INIT_TASK to set head and sem of subscriber list
+ * @tsk: The task work with
+ *
+ * Marco Used in INIT_TASK to set the head and sem of pnotify_subscriber_list
+ * If CONFIG_PNOTIFY is off, it is defined as an empty macro below.
+ *
+ */
+#define INIT_TASK_PNOTIFY(tsk) \
+	.pnotify_subscriber_list = LIST_HEAD_INIT(tsk.pnotify_subscriber_list),\
+	.pnotify_subscriber_list_sem  = \
+	 __RWSEM_INITIALIZER(tsk.pnotify_subscriber_list_sem),
+
+#else  /* CONFIG_PNOTIFY */
+
+/*
+ * Replacement macros used when pnotify (Process Notification) support is not
+ * compiled into the kernel.
+ */
+#define INIT_TASK_PNOTIFY(tsk)
+#define INIT_PNOTIFY_LIST(l) do { } while(0)
+#define pnotify_fork(ct, pt) ({ 0; })
+#define pnotify_exit(t)  do {  } while(0)
+#define pnotify_exec(t)  do {  } while(0)
+#define pnotify_unsubscribe(t) do { } while(0)
+
+#endif /* CONFIG_PNOTIFY */
+
+#endif /* _LINUX_NOTIFY_H */
Index: linux/Documentation/pnotify.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/pnotify.txt	2005-09-30 14:57:57.655548722 -0500
@@ -0,0 +1,368 @@
+Process Notification (pnotify)
+--------------------
+pnotify provides a method (service) for kernel modules to be notified when
+certain events happen in the life of a process.  Events we support include
+fork, exit, and exec.  A special init event is also supported (see events
+below).  More events could be added.  pnotify also provides a generic data
+pointer for the modules to work with so that data can be associated per
+process.
+
+A kernel module will register (pnotify_register) a service request describing
+events it cares about (pnotify_events) with pnotify_register.  The request
+tells pnotify which notifications the kernel module wants.  The kernel module
+passes along function pointers to be called for these events (exit, fork, exec)
+in the pnotify_events service request.
+
+From the process point of view, each process has a kernel module subscriber
+list (pnotify_subscriber_list).  These kernel modules are the ones who want
+notification about the life of the process.  As described above, each kernel
+module subscriber on the list has a generic data pointer to point to data
+associated with the process.
+
+In the case of fork, pnotify will allocate the same kernel module subscriber
+list for the new child that existed for the parent.  The kernel module's
+function pointer for fork is also called for the child being constructed so
+the kernel module can do what ever it needs to do when a parent forks this
+child.  Special return values apply for the fork and init event that don't to
+others.  They are described in the fork and init example below.
+
+For exit, similar things happen but the exit function pointer for each
+kernel module subscriber is called and the kernel module subscriber entry for
+that process is deleted.
+
+
+Events
+------
+Events are stages of a processes life that kernel modules care about.  The
+fork event is triggered in a certain location in copy_process when a parent
+forks.  The exit event happens when a process is going away.  We also support
+an exec event, which happens when a process execs.  Finally, there is an init
+event.  This special event makes it so this kernel module will be associated
+with all current processes in the system at the time of registration.  This is
+used when a kernel module wants to keep track of all current processes as
+opposed to just those it associates by itself (and children that follow).  The
+events a kernel module cares about are set up in the pnotify_events
+structure - see usage below.
+
+When setting up a pnotify_events, you designate which events you care about
+by either associating NULL (meaning you don't care about that event) or a
+pointer to the function to run when the event is triggered.  The fork event
+and the exit event is currently required.
+
+
+How do processes become associated with kernel modules?
+-------------------------------------------------------
+Your kernel module itself can use the pnotify_subscribe function to associate
+a given process with a given pnotify_events structure.  This adds
+your kernel module to the subscriber list of the process.  In the case
+of inescapable job containers making use of PAM, when PAM allows a person to
+log in, PAM contacts job (via a PAM job module which uses the job userland
+library) and the kernel Job code will call pnotify_subscribe to associate the
+process with pnotify.  From that point on, the kernel module will be notified
+about events in the process's life that the module cares about (as well,
+as any children that process may later have).
+
+Likewise, your kernel module can remove an association between it and
+a given process by using pnotify_unsubscribe.
+
+
+Example Usage
+-------------
+
+=== filling out the pnotify_events structure ===
+
+A kernel module wishing to use pnotify needs to set up a pnotify_events
+structure.  This structure tells pnotify which events you care about and what
+functions to call when those events are triggered.  In addition, you supply a
+name (usually the kernel module name).  The entry is always filled out as
+shown below.  .module is usually set to THIS_MODULE.  data can be optionally
+used to store a pointer with the pnotify_events structure.
+
+Example of a filled out pnotify_events:
+
+static struct pnotify_events pnotify_events = {
+	.module  = THIS_MODULE,
+	.name = "test_module",
+	.data = NULL,
+	.entry   = LIST_HEAD_INIT(pnotify_events.entry),
+	.init = test_init,
+	.fork  = test_attach,
+	.exit  = test_detach,
+	.exec = test_exec,
+};
+
+The above pnotify_events structure says the kernel module "test_module" cares
+about events fork, exit, exec, and init.  In fork, call the kernel module's
+test_attach function.  In exec, call test_exec.  In exit, call test_detach.
+The init event is specified, so all processes on the system will be associated
+with this kernel module during registration and the test_init function will
+be run for each.
+
+
+=== Registering with pnotify ===
+
+You will likely register with pnotify in your kernel module's module_init
+function.  Here is an example:
+
+static int __init test_module_init(void)
+{
+	int rc = pnotify_register(&pnotify_events);
+	if (rc < 0) {
+		return -1;
+	}
+
+	return 0;
+}
+
+
+=== Example init event function ====
+
+Since the init event is defined, it means this kernel module is added
+to the subscriber list of all processes -- it will receive notification
+about events it cares about for all processes and all children that
+follow.
+
+Of course, if a kernel module doesn't need to know about all current
+processes, that module shouldn't implement this and '.init' in the
+pnotify_events structure would be NULL.
+
+This is as opposed to the normal method where the kernel module adds itself
+to the subscriber list of a process using pnotify_subscribe.
+
+Important:
+Note: The implementation of pnotify_register causes us to evaluate some tasks
+more than once in some cases.  See the comments in pnotify_register for why.
+Therefore, if the init function pointer returns PNOTIFY_NOSUB, which means
+that it doesn't want a process association, that init function must be
+prepared to possibly look at the same "skipped" task more than once.
+
+Note that the return value here is similar to the fork function pointer
+below except there is no notion of failing the fork since existing processes
+aren't forking.
+
+PNOTIFY_OK - good, adds the kernel module to the subscriber list for process
+PNOTIFY_NOSUB - good, but don't add kernel module to subscriber list for process
+
+static int test_init(struct task_struct *tsk, struct pnotify_subscriber *subscriber)
+{
+	if (pnotify_get_subscriber(tsk, "test_module") == NULL)
+		dprintk("ERROR pnotify expected \"%s\" PID = %d\n", "test_module", tsk->pid);
+
+	dprintk("FYI pnotify init hook fired for PID = %d\n", tsk->pid);
+	atomic_inc(&init_count);
+	return 0;
+}
+
+
+=== Example fork (test_attach) function ===
+
+This function is executed when a process forks - this is associated
+with the pnotify_callout callout in copy_process.  There would be a very
+similar test_detach function (not shown).
+
+pnotify will add the kernel module to the notification list for the child
+process automatically and then execute this fork function pointer (test_attach
+in this example).  However, the kernel module can control whether the kernel
+module stays on the process's subscriber list and wants notification by the
+return value.
+
+PNOTIFY_ERROR - prevent the process from continuing - failing the fork
+PNOTIFY_OK - good, adds the kernel module to the subscriber list for process
+PNOTIFY_NOSUB - good, but don't add kernel module to subscriber list for process
+
+
+static int test_attach(struct task_struct *tsk, struct pnotify_subscriber *subscriber, void *vp)
+{
+	dprintk("pnotify attach hook fired for PID = %d\n", tsk->pid);
+	atomic_inc(&attach_count);
+
+	return PNOTIFY_OK;
+}
+
+
+=== Example exec event function ===
+
+And here is an example function to run when a task gets to exec.  So any
+time a "tracked" process gets to exec, this would execute.
+
+static void test_exec(struct task_struct *tsk, struct pnotify_subscriber *subscriber)
+{
+	dprintk("pnotify exec hook fired for PID %d\n", tsk->pid);
+	atomic_inc(&exec_count);
+}
+
+
+=== Unregistering with pnotify ===
+
+You will likely wish to unregister with pnotify in the kernel module's
+module_exit function.  Here is an example:
+
+static void __exit test_module_cleanup(void)
+{
+	pnotify_unregister(&pnotify_events);
+	printk("detach called %d times...\n", atomic_read(&detach_count));
+	printk("attach called %d times...\n", atomic_read(&attach_count));
+	printk("init called %d times...\n", atomic_read(&init_count));
+	printk("exec called %d times ...\n", atomic_read(&exec_count));
+	if (atomic_read(&attach_count) + atomic_read(&init_count) !=
+	  atomic_read(&detach_count))
+	printk("pnotify PROBLEM: attach count + init count SHOULD equal detach cound and doesn't\n");
+	else
+	printk("Good - attach count + init count equals detach count.\n");
+}
+
+
+
+=== Actually using data associated with the process in your module ===
+
+The above examples show you how to create an example kernel module using
+pnotify, but they didn't show what you might do with the data pointer
+associated with a given process.  Below, find an example of accessing
+the data pointer for a given process from within a kernel module making use
+of pnotify.
+
+pnotify_get_subscriber is used to retrieve the pnotify subscriber for a given
+process and kernel module.  Like this:
+
+subscriber = pnotify_get_subscriber(task, name);
+
+Where name is your kernel module's name (as provided in the pnotify_events
+structure) and task is the process you're interested
+in.
+
+Please be careful about locking.  The task structure has a
+pnotify_subscriber_list_sem to be used for locking.  This example retrieves
+a given task in a way that ensures it doesn't disappear while we try to
+access it (that's why we do locking for the tasklist_lock and task).  The
+pnotify subscriber list is locked to ensure the list doesn't change as we
+search it with pnotify_get_subscriber.
+
+	read_lock(&tasklist_lock);
+	get_task_struct(task); /* Ensure the task doesn't vanish on us */
+	read_unlock(&tasklist_lock); /* Unlock the tasklist */
+	down_read(&task->pnotify_subscriber_list_sem); /* readlock subscriber list */
+
+	subscriber = pnotify_get_subscriber(task, name);
+	if (subscriber) {
+		/* Get the widgitId associated with this task */
+		widgitId = ((widgitId_t *)subscriber->data);
+	}
+	put_task_struct(task);  /* Done accessing the task */
+	up_read(&task->pnotify_subscriber_list_sem); /* unlock subscriber list */
+
+
+Future Events
+-------------
+Kingsley Cheung suggested that we add events for uid and gid changes and this
+may inspire broader use.  Depending on how the discussoin goes, I'll post a
+patch to add this functionality in the next day or two.
+
+History
+-------
+Process Notification used to be known as PAGG (Process Aggregates).
+It was re-written to be called Process Notification because we believe this
+better describes its purpose.  Structures and functions were re-named to
+be more clear and to reflect the new name.
+
+
+Why Not Notifier Lists?
+-----------------------
+We investigated the use of notifier lists, available in newer kernels.
+
+Notifier lists would not be as efficient as pnotify for kernel modules
+wishing to associate data with processes.  With pnotify, if the
+pnotify_subscriber_list of a given task is NULL, we can instantly know
+there are no kernel modules that care about the process.  Further, the
+callbacks happen in places were the task struct is likely to be cached.
+So this is a quick operation.  With notifier lists, the scope is system
+wide rather than per process.  As long as one kernel module wants to be
+notified, we have to walk the notifier list and potentially waste cycles.
+In the case of pnotify, we only walk lists if we're interested about
+a specific task.
+
+On a system where pnotify is used to track only a few processes, the
+overhead of walking the notifier list is high compared to the overhead
+of walking the kernel module subscriber list only when a kernel module
+is interested in a given process.
+
+I don't believe this is easily solved in notifier lists themselves as
+they are meant to be global resources, not per-task resources.
+
+Overlooking performance issues, notifier lists in and of themselves wouldn't
+solve the problem pnotify solves anyway.  Although you could argue notifier
+lists can implement the callback portion of pnotify, there is no association
+of data with a given process.  This is a needed for kernel modules to
+efficiently associate a task with a data pointer without cluttering up
+the task struct.
+
+In addition to data associated with a process, we desire the ability for
+kernel modules to add themselves to the subscriber list for any arbitrary
+process - not just current or a child of current.
+
+
+Some Justification
+------------------
+We feel that pnotify could be used to reduce the size of the task struct or
+the number of functions in copy_process.  For example, if another part of the
+kernel needs to know when a process is forking or exiting, they could use
+pnotify instead of adding additional code to task struct, copy_process, or
+exit.
+
+Some have argued that PAGG in the past shouldn't be used because it will
+allow interesting things to be implemented outside of the kernel.  While this
+might be a small risk, having these in place allows customers and users to
+implement kernel components that you don't want to see in the kernel anyway.
+
+For example, a certain vendor may have an urgent need to implement kernel
+functionality or special types of accounting that nobody else is interested
+in.  That doesn't mean the code isn't open-source, it just means it isn't
+applicable to all of Linux because it satisfies a niche.
+
+All of pnotify's functionality that needs to be exported is exported with
+EXPORT_SYMBOL_GPL to discourage abuse.
+
+The risk already exists in the kernel for people to implement modules outside
+the kernel that suffer from less peer review and possibly bad programming
+practice.  pnotify could add more oppurtunities for out-of-tree kernel module
+authors to make new modules.  I believe this is somewhat mitigated by the
+already-existing 'tainted' warnings in the kernel.
+
+Other Ideas?
+------------
+There have been similar proposals to provide pieces of the pnotify
+functionality.  If there is a better proposal out there, let's explore it.
+Here are some key functions I hope to see in any proposal:
+
+ - Ability to have notification for exec, fork, exit at minimum
+ - Ability to extend to other callouts later (such as uid/gid changes as
+   I described earlier)
+ - Ability for pnotify user modules to implement code that ends up adding
+   a kernel module subscriber to any arbitrary process (not just current and
+   its children).
+
+I believe, if the above are more or less met, we should be in good shape for
+our other open source projects such as linux job.
+
+Variable Name Changes from PAGG to pnotify
+------------------------------------------
+PAGG_NAMELEN -> PNOTIFY_NAMELEN
+struct pagg -> pnotify_subscriber
+pagg_get -> pnotify_get_subscriber
+pagg_alloc -> pnotify_subscribe
+pagg_free -> pnotify_unsubscribe
+pagg_hook_register -> pnotify_register
+pagg_hook_unregister -> pnotify_unregister
+pagg_attach -> pnotify_fork
+pagg_detach -> pnotify_exit
+pagg_exec -> pnotify_exec
+struct pagg_hook -> pnotify_events
+
+With pnotify_events (formerly pagg_hook):
+  attach -> fork
+  detach -> exit
+
+Return codes for the init and fork function pointers should use:
+PNOTIFY_ERROR - prevent the process from continuing - failing the fork
+PNOTIFY_OK - good, adds the kernel module to the subscriber list for process
+PNOTIFY_NOSUB - good, but don't add kernel module to subscriber list for process
+
