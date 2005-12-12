Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVLLGja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVLLGja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVLLGja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:39:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19897 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751160AbVLLGj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:39:29 -0500
Date: Sun, 11 Dec 2005 22:39:22 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051212063922.31799.91459.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: remove test for null cpuset from alloc code path
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a couple of more lines of code from the cpuset hooks in
the page allocation code path.

There was a check for a NULL cpuset pointer in the routine
cpuset_update_task_memory_state() that was only needed during
system boot, after the memory subsystem was initialized,
before the cpuset subsystem was initialized, to catch a NULL
task->cpuset pointer.

Add a cpuset_init_early() routine, just before the mem_init()
call in init/main.c, that sets up just enough of the init tasks
cpuset structure to render cpuset_update_task_memory_state()
calls harmless.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/cpuset.h |    2 ++
 init/main.c            |    1 +
 kernel/cpuset.c        |   22 ++++++++++++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)

--- 2.6.15-rc3-mm1.orig/include/linux/cpuset.h	2005-12-11 01:01:21.965124900 -0800
+++ 2.6.15-rc3-mm1/include/linux/cpuset.h	2005-12-11 21:16:38.207522306 -0800
@@ -16,6 +16,7 @@
 
 extern int number_of_cpusets;	/* How many cpusets are defined in system? */
 
+extern int cpuset_init_early(void);
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
@@ -49,6 +50,7 @@ extern char *cpuset_task_status_allowed(
 
 #else /* !CONFIG_CPUSETS */
 
+static inline int cpuset_init_early(void) { return 0; }
 static inline int cpuset_init(void) { return 0; }
 static inline void cpuset_init_smp(void) {}
 static inline void cpuset_fork(struct task_struct *p) {}
--- 2.6.15-rc3-mm1.orig/init/main.c	2005-12-07 15:45:00.720991835 -0800
+++ 2.6.15-rc3-mm1/init/main.c	2005-12-11 21:06:27.926145263 -0800
@@ -513,6 +513,7 @@ asmlinkage void __init start_kernel(void
 	}
 #endif
 	vfs_caches_init_early();
+	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-11 14:30:08.374254561 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-11 22:35:39.051718313 -0800
@@ -619,9 +619,7 @@ static void guarantee_online_mems(const 
  * Do not call this routine if in_interrupt().
  *
  * Call without callback_sem or task_lock() held.  May be called
- * with or without manage_sem held.  Except in early boot or
- * an exiting task, when tsk->cpuset is NULL, this routine will
- * acquire task_lock().  We don't need to use task_lock to guard
+ * with or without manage_sem held.  Doesn't need task_lock to guard
  * against another task changing a non-NULL cpuset pointer to NULL,
  * as that is only done by a task on itself, and if the current task
  * is here, it is not simultaneously in the exit code NULL'ing its
@@ -646,9 +644,6 @@ void cpuset_update_task_memory_state()
 	struct task_struct *tsk = current;
 	struct cpuset *cs = tsk->cpuset;
 
-	if (unlikely(!cs))
-		return;
-
 	rcu_read_lock();
 	my_cpusets_mem_gen = cs->mems_generation;
 	rcu_read_unlock();
@@ -1851,6 +1846,21 @@ static int cpuset_rmdir(struct inode *un
 	return 0;
 }
 
+/*
+ * cpuset_init_early - just enough so that the calls to
+ * cpuset_update_task_memory_state() in early init code
+ * are harmless.
+ */
+
+int __init cpuset_init_early(void)
+{
+	struct task_struct *tsk = current;
+
+	tsk->cpuset = &top_cpuset;
+	tsk->cpuset->mems_generation = atomic_read(&cpuset_mems_generation);
+	return 0;
+}
+
 /**
  * cpuset_init - initialize cpusets at system boot
  *

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
