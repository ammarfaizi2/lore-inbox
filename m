Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWAQOu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWAQOu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWAQOuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18571 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750979AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143325.218054000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:05 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 07/34] PID Virtualization Change pid accesses: lib/
Content-Disposition: inline; filename=B6-change-pid-tgid-references-lib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change pid accesses under lib/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 rwsem-spinlock.c   |    2 +-
 rwsem.c            |    2 +-
 smp_processor_id.c |    2 +-
 spinlock_debug.c   |   12 ++++++------
 4 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6.15/lib/rwsem-spinlock.c
===================================================================
--- linux-2.6.15.orig/lib/rwsem-spinlock.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/lib/rwsem-spinlock.c	2006-01-17 08:37:00.000000000 -0500
@@ -22,7 +22,7 @@
 {
 	if (sem->debug)
 		printk("[%d] %s({%d,%d})\n",
-		       current->pid, str, sem->activity,
+		       task_pid(current), str, sem->activity,
 		       list_empty(&sem->wait_list) ? 0 : 1);
 }
 #endif
Index: linux-2.6.15/lib/rwsem.c
===================================================================
--- linux-2.6.15.orig/lib/rwsem.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/lib/rwsem.c	2006-01-17 08:37:00.000000000 -0500
@@ -23,7 +23,7 @@
 	printk("sem=%p\n", sem);
 	printk("(sem)=%08lx\n", sem->count);
 	if (sem->debug)
-		printk("[%d] %s({%08lx})\n", current->pid, str, sem->count);
+		printk("[%d] %s({%08lx})\n", task_pid(current), str, sem->count);
 }
 #endif
 
Index: linux-2.6.15/lib/smp_processor_id.c
===================================================================
--- linux-2.6.15.orig/lib/smp_processor_id.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/lib/smp_processor_id.c	2006-01-17 08:37:00.000000000 -0500
@@ -42,7 +42,7 @@
 	if (!printk_ratelimit())
 		goto out_enable;
 
-	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, current->pid);
+	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, task_pid(current));
 	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
 	dump_stack();
 
Index: linux-2.6.15/lib/spinlock_debug.c
===================================================================
--- linux-2.6.15.orig/lib/spinlock_debug.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/lib/spinlock_debug.c	2006-01-17 08:37:00.000000000 -0500
@@ -21,11 +21,11 @@
 			owner = lock->owner;
 		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
 			msg, raw_smp_processor_id(),
-			current->comm, current->pid);
+			current->comm, task_pid(current));
 		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
 			lock, lock->magic,
 			owner ? owner->comm : "<none>",
-			owner ? owner->pid : -1,
+			owner ? task_pid(owner) : -1,
 			lock->owner_cpu);
 		dump_stack();
 #ifdef CONFIG_SMP
@@ -80,7 +80,7 @@
 			print_once = 0;
 			printk("BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
 				raw_smp_processor_id(), current->comm,
-				current->pid, lock);
+				task_pid(current), lock);
 			dump_stack();
 		}
 	}
@@ -122,7 +122,7 @@
 	if (xchg(&print_once, 0)) {
 		printk("BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
 			raw_smp_processor_id(), current->comm,
-			current->pid, lock);
+			task_pid(current), lock);
 		dump_stack();
 #ifdef CONFIG_SMP
 		/*
@@ -151,7 +151,7 @@
 			print_once = 0;
 			printk("BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
 				raw_smp_processor_id(), current->comm,
-				current->pid, lock);
+				task_pid(current), lock);
 			dump_stack();
 		}
 	}
@@ -223,7 +223,7 @@
 			print_once = 0;
 			printk("BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
 				raw_smp_processor_id(), current->comm,
-				current->pid, lock);
+				task_pid(current), lock);
 			dump_stack();
 		}
 	}

--

