Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVKNVdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVKNVdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKNVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:52 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30910 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932154AbVKNVco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:44 -0500
Message-Id: <20051114212528.088769000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:48 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 07/13] Change pid accesses: lib/
Content-Disposition: inline; filename=B6-change-pid-tgid-references-lib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: lib/
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses under lib/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 lib/rwsem-spinlock.c   |    2 +-
 lib/rwsem.c            |    2 +-
 lib/smp_processor_id.c |    2 +-
 lib/spinlock_debug.c   |   12 ++++++------
 4 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6.15-rc1/lib/rwsem-spinlock.c
===================================================================
--- linux-2.6.15-rc1.orig/lib/rwsem-spinlock.c
+++ linux-2.6.15-rc1/lib/rwsem-spinlock.c
@@ -22,7 +22,7 @@ void rwsemtrace(struct rw_semaphore *sem
 {
 	if (sem->debug)
 		printk("[%d] %s({%d,%d})\n",
-		       current->pid, str, sem->activity,
+		       task_pid(current), str, sem->activity,
 		       list_empty(&sem->wait_list) ? 0 : 1);
 }
 #endif
Index: linux-2.6.15-rc1/lib/rwsem.c
===================================================================
--- linux-2.6.15-rc1.orig/lib/rwsem.c
+++ linux-2.6.15-rc1/lib/rwsem.c
@@ -23,7 +23,7 @@ void rwsemtrace(struct rw_semaphore *sem
 	printk("sem=%p\n", sem);
 	printk("(sem)=%08lx\n", sem->count);
 	if (sem->debug)
-		printk("[%d] %s({%08lx})\n", current->pid, str, sem->count);
+		printk("[%d] %s({%08lx})\n", task_pid(current), str, sem->count);
 }
 #endif
 
Index: linux-2.6.15-rc1/lib/smp_processor_id.c
===================================================================
--- linux-2.6.15-rc1.orig/lib/smp_processor_id.c
+++ linux-2.6.15-rc1/lib/smp_processor_id.c
@@ -42,7 +42,7 @@ unsigned int debug_smp_processor_id(void
 	if (!printk_ratelimit())
 		goto out_enable;
 
-	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, current->pid);
+	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, task_pid(current));
 	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
 	dump_stack();
 
Index: linux-2.6.15-rc1/lib/spinlock_debug.c
===================================================================
--- linux-2.6.15-rc1.orig/lib/spinlock_debug.c
+++ linux-2.6.15-rc1/lib/spinlock_debug.c
@@ -20,11 +20,11 @@ static void spin_bug(spinlock_t *lock, c
 		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
 			owner = lock->owner;
 		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
-			msg, smp_processor_id(), current->comm, current->pid);
+			msg, smp_processor_id(), current->comm, task_pid(current));
 		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
 			lock, lock->magic,
 			owner ? owner->comm : "<none>",
-			owner ? owner->pid : -1,
+			owner ? task_pid(owner) : -1,
 			lock->owner_cpu);
 		dump_stack();
 #ifdef CONFIG_SMP
@@ -78,7 +78,7 @@ static void __spin_lock_debug(spinlock_t
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
+				smp_processor_id(), current->comm, task_pid(current),
 					lock);
 			dump_stack();
 		}
@@ -120,7 +120,7 @@ static void rwlock_bug(rwlock_t *lock, c
 
 	if (xchg(&print_once, 0)) {
 		printk("BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
-			smp_processor_id(), current->comm, current->pid, lock);
+			smp_processor_id(), current->comm, task_pid(current), lock);
 		dump_stack();
 #ifdef CONFIG_SMP
 		/*
@@ -148,7 +148,7 @@ static void __read_lock_debug(rwlock_t *
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
+				smp_processor_id(), current->comm, task_pid(current),
 					lock);
 			dump_stack();
 		}
@@ -220,7 +220,7 @@ static void __write_lock_debug(rwlock_t 
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
+				smp_processor_id(), current->comm, task_pid(current),
 					lock);
 			dump_stack();
 		}

--

