Return-Path: <linux-kernel-owner+w=401wt.eu-S965134AbXATEAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbXATEAF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 23:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbXATEAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 23:00:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:52570 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965134AbXATEAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 23:00:03 -0500
Date: Fri, 19 Jan 2007 20:00:07 -0800
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Containers <containers@lists.osdl.org>
Subject: [PATCH] Statically initialize struct pid for swapper
Message-ID: <20070120040007.GA2831@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Subject: [PATCH] Statically initialize struct pid for swapper

Statically initialize a struct pid for the swapper process (pid_t == 0)
and attach it to init_task. This is needed so task_pid(), task_pgrp()
and task_session() interfaces work on the swapper process also.

Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Serge Hallyn <serue@us.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: containers@lists.osdl.org

---
 include/linux/init_task.h |   27 +++++++++++++++++++++++++++
 include/linux/pid.h       |    2 ++
 kernel/pid.c              |    2 ++
 3 files changed, 31 insertions(+)

Index: lx26-20-rc4-mm1/include/linux/init_task.h
===================================================================
--- lx26-20-rc4-mm1.orig/include/linux/init_task.h	2007-01-19 19:13:35.161859112 -0800
+++ lx26-20-rc4-mm1/include/linux/init_task.h	2007-01-19 19:15:05.893065872 -0800
@@ -90,6 +90,28 @@ extern struct nsproxy init_nsproxy;
 
 extern struct group_info init_groups;
 
+#define INIT_STRUCT_PID {						\
+	.count 		= ATOMIC_INIT(1),				\
+	.nr		= 0, 						\
+	/* Don't put this struct pid in pid_hash */			\
+	.pid_chain	= { .next = NULL, .pprev = NULL },		\
+	.tasks		= {						\
+		{ .first = &init_task.pids[PIDTYPE_PID].node },		\
+		{ .first = &init_task.pids[PIDTYPE_PGID].node },	\
+		{ .first = &init_task.pids[PIDTYPE_SID].node },		\
+	},								\
+	.rcu		= RCU_HEAD_INIT,				\
+}
+
+#define INIT_PID_LINK(type) 					\
+{								\
+	.node = {						\
+		.next = NULL,					\
+		.pprev = &init_struct_pid.tasks[type].first,	\
+	},							\
+	.pid = &init_struct_pid,				\
+}
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -141,6 +163,11 @@ extern struct group_info init_groups;
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
 	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
+	.pids = {							\
+		[PIDTYPE_PID]  = INIT_PID_LINK(PIDTYPE_PID),		\
+		[PIDTYPE_PGID] = INIT_PID_LINK(PIDTYPE_PGID),		\
+		[PIDTYPE_SID]  = INIT_PID_LINK(PIDTYPE_SID),		\
+	},								\
 	INIT_TRACE_IRQFLAGS						\
 	INIT_LOCKDEP							\
 }
Index: lx26-20-rc4-mm1/kernel/pid.c
===================================================================
--- lx26-20-rc4-mm1.orig/kernel/pid.c	2007-01-19 19:13:35.162858960 -0800
+++ lx26-20-rc4-mm1/kernel/pid.c	2007-01-19 19:13:38.925286984 -0800
@@ -27,11 +27,13 @@
 #include <linux/bootmem.h>
 #include <linux/hash.h>
 #include <linux/pid_namespace.h>
+#include <linux/init_task.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
 static struct hlist_head *pid_hash;
 static int pidhash_shift;
 static struct kmem_cache *pid_cachep;
+struct pid init_struct_pid = INIT_STRUCT_PID;
 
 int pid_max = PID_MAX_DEFAULT;
 
Index: lx26-20-rc4-mm1/include/linux/pid.h
===================================================================
--- lx26-20-rc4-mm1.orig/include/linux/pid.h	2007-01-19 19:13:35.161859112 -0800
+++ lx26-20-rc4-mm1/include/linux/pid.h	2007-01-19 19:13:38.925286984 -0800
@@ -51,6 +51,8 @@ struct pid
 	struct rcu_head rcu;
 };
 
+extern struct pid init_struct_pid;
+
 struct pid_link
 {
 	struct hlist_node node;
