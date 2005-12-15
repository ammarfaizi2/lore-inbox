Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVLOOkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVLOOkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLOOjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:39:43 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:59290 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750722AbVLOOjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:39:11 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143903.828895000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 15/21] PID Virtualization: container object and functions
Content-Disposition: inline; filename=G2-container.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the container object and its managemenent functions,
in particular the creation/deletion of containers and the
linkage between the container object and the task.
By default, if the task->container object is NULL, then the task belongs
to the default global container. 

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 include/linux/container.h |   37 ++++++++++++
 include/linux/sched.h     |   10 +++
 kernel/Makefile           |    3 
 kernel/container.c        |  140 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/pid.c              |   14 ++--
 5 files changed, 198 insertions(+), 6 deletions(-)

Index: linux-2.6.15-rc1/include/linux/container.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc1/include/linux/container.h	2005-12-08 19:43:25.000000000 -0500
@@ -0,0 +1,37 @@
+
+#ifndef _LINUX_CONTAINER_H
+#define _LINUX_CONTAINER_H
+
+/* number of containers will depend on many constraints, which will have to
+ * be integrated here as they become apparent
+ */
+
+
+#define MAX_NR_CONTAINERS		MAX_NR_PIDSPACES
+
+#define MAX_CONTAINER_NAME_LEN 		32
+
+struct container_struct {
+	spinlock_t	    lock;
+	char		    name[MAX_CONTAINER_NAME_LEN];
+	int		    pidspace_id;
+	struct task_struct *init_proc;			/* root proc   */
+	int		    init_pid;			/* pid of root */
+	atomic_t	    tcount;			/* thread count */
+
+	/* and all the other things that will be necessary to track
+	 * for a container
+	 */
+};
+
+/****************************************************************
+ *      Container Management Functions
+ ****************************************************************/
+
+extern struct container_struct *container_find(const char *container_name);
+extern int    container_new     (const char *container_name);
+extern void   container_attach  (struct task_struct *task);
+extern void   container_detach  (struct task_struct *task);
+
+#endif
+
Index: linux-2.6.15-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/sched.h	2005-12-08 19:40:49.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/sched.h	2005-12-08 19:43:25.000000000 -0500
@@ -36,6 +36,7 @@
 #include <linux/seccomp.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
+#include <linux/container.h>
 
 struct exec_domain;
 
@@ -858,6 +859,7 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+	struct container_struct *container;
 };
 
 static inline pid_t process_group(const struct task_struct *tsk)
@@ -965,6 +967,14 @@ static inline pid_t virt_process_group(c
 	return process_group(p);
 }
 
+static inline unsigned int task_pidspace_id(const struct task_struct *p)
+{
+	if (p->container)
+		return p->container->pidspace_id;
+	else
+		return DEFAULT_PIDSPACE;
+}
+
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
Index: linux-2.6.15-rc1/kernel/Makefile
===================================================================
--- linux-2.6.15-rc1.orig/kernel/Makefile	2005-12-08 19:40:49.000000000 -0500
+++ linux-2.6.15-rc1/kernel/Makefile	2005-12-08 19:43:25.000000000 -0500
@@ -7,7 +7,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
+	    container.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6.15-rc1/kernel/container.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc1/kernel/container.c	2005-12-08 19:44:26.000000000 -0500
@@ -0,0 +1,140 @@
+/*
+ * Management of Containers
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2005 <frankeh@watson.ibm.com>
+ *
+ */
+
+/* Changes
+ *
+ * 11/22/2005:  Created
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+#include <linux/proc_fs.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/container.h>
+
+#define DPRINTK( fmt, args... ) // printk( "%s: " fmt, __FUNCTION__, ##args )
+
+static struct container_struct *containers[MAX_NR_CONTAINERS];
+static DEFINE_SPINLOCK(container_lock);
+
+/****************************************************************
+ *      Container Management
+ ****************************************************************/
+
+void container_attach(struct task_struct *task)
+{
+	struct container_struct *container = task->container;
+
+	if (!container)
+		return;
+	atomic_inc(&container->tcount);
+
+	DPRINTK("c=<%p:%s> atask=<%x:%x:%s>\n",
+		container, container->name,
+		task_pid(task), task_vpid(task), task->comm);
+}
+
+void container_detach(struct task_struct *task)
+{
+	struct container_struct *container = task->container;
+	unsigned long flags;
+	int empty;
+
+	if (!container)
+		return;
+
+	DPRINTK("c=<%p:%s> dtask=<%x:%x:%s>\n",
+		container, container->name,
+		task_pid(task), task_vpid(task), task->comm);
+
+	task->container = NULL;
+	if (unlikely(task == container->init_proc)) {
+		container->init_proc = NULL;
+		container->init_pid  = 0;
+		memset(container->name, 0, MAX_CONTAINER_NAME_LEN);
+	}
+	empty = atomic_dec_and_test(&container->tcount);
+	if (!empty)
+		return;
+
+	/* we are the last process, so lets destroy the container */
+
+	DPRINTK("c=<%p:%s> destroy container exiting root proc\n",
+		container, container->name);
+
+	spin_lock_irqsave(&container_lock,flags);
+	containers[container->pidspace_id] = NULL;
+	pidspace_free(container->pidspace_id);
+
+	spin_lock(&container->lock);
+	/* ANYTHING UNDER THE LOCK */
+	spin_unlock(&container->lock);
+
+	spin_unlock_irqrestore(&container_lock,flags);
+
+	kfree(container);
+}
+
+/*
+ * create a new container and make the caller the virtual init_proc
+ * of the container
+ */
+
+int container_new(const char *container_name)
+{
+	struct container_struct *newc = NULL;
+	unsigned long flags;
+	int i;
+	int rc;
+
+	newc = kmalloc(sizeof(struct container_struct),GFP_KERNEL);
+	if (newc == NULL)
+		return -ENOMEM;
+	memset(newc,0,sizeof(struct container_struct));
+	strncpy(newc->name, container_name, MAX_CONTAINER_NAME_LEN-1);
+	newc->init_proc = current;
+	newc->init_pid  = task_pid(current);
+	atomic_set(&newc->tcount,0);
+
+	spin_lock_irqsave(&container_lock,flags);
+	for ( i=1; i<MAX_NR_CONTAINERS; i++) {
+		struct container_struct *cptr = containers[i];
+
+		if (cptr == NULL)
+			break;
+		if (strncmp(container_name, cptr->name, MAX_CONTAINER_NAME_LEN) == 0) {
+			rc = -EEXIST;
+			goto out_unlock_free;
+		}
+	}
+	if ( i == MAX_NR_CONTAINERS ) {
+		rc = -ENOMEM;
+		goto out_unlock_free;
+	}
+
+	spin_lock_init(&newc->lock);
+	pidspace_init(i);
+	newc->pidspace_id = i;
+	containers[i] = newc;
+	DPRINTK("created container #%d: %s\n", newc->pidspace_id, newc->name);
+	current->container = newc;
+	container_attach(current);
+	rc = 0;
+	goto out_unlock;
+
+out_unlock_free:
+	kfree(newc);
+out_unlock:
+	spin_unlock_irqrestore(&container_lock,flags);
+	return rc;
+}
+

--
