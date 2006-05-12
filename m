Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWELRM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWELRM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWELRM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:12:28 -0400
Received: from homer.mvista.com ([63.81.120.158]:34555 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750745AbWELRM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:12:28 -0400
Date: Fri, 12 May 2006 10:12:17 -0700
Message-Id: <200605121712.k4CHCHXG011893@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] show_held_locks cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - turns show_held_locks into debug_mutex_show_held_locks() . 
 - Adds debug_mutex_show_held_locks() + rt_mutex_show_held_locks() to x86_64
 - cleans up show_held_locks() on arm .

I compile tested i386, arm, not x86_64 . Seems like this should go upstream too.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/kernel/mutex-debug.c
===================================================================
--- linux-2.6.16.orig/kernel/mutex-debug.c
+++ linux-2.6.16/kernel/mutex-debug.c
@@ -117,7 +117,7 @@ static void show_task_locks(struct task_
  * printk all locks held in the system (if filter == NULL),
  * or all locks belonging to a single task (if filter != NULL):
  */
-void show_held_locks(struct task_struct *filter)
+void mutex_debug_show_held_locks(struct task_struct *filter)
 {
 	struct list_head *curr, *cursor = NULL;
 	struct mutex *lock;
@@ -201,7 +201,7 @@ retry:
 	} while_each_thread(g, p);
 
 	printk("\n");
-	show_held_locks(NULL);
+	mutex_debug_show_held_locks(NULL);
 	printk("=============================================\n\n");
 
 	if (unlock)
@@ -216,7 +216,7 @@ static void report_deadlock(struct task_
 	printk_lock(lock, 1);
 	printk("... trying at:                 ");
 	print_symbol("%s\n", ip);
-	show_held_locks(current);
+	mutex_debug_show_held_locks(current);
 
 	if (lockblk) {
 		printk("but %s/%d is deadlocking current task %s/%d!\n\n",
@@ -225,7 +225,7 @@ static void report_deadlock(struct task_
 			task->comm, task->pid);
 		printk_lock(lockblk, 1);
 
-		show_held_locks(task);
+		mutex_debug_show_held_locks(task);
 
 		printk("\n%s/%d's [blocked] stackdump:\n\n",
 			task->comm, task->pid);
Index: linux-2.6.16/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6.16.orig/arch/arm/kernel/traps.c
+++ linux-2.6.16/arch/arm/kernel/traps.c
@@ -176,9 +176,12 @@ static void dump_backtrace(struct pt_reg
 void dump_stack(void)
 {
 #ifdef CONFIG_DEBUG_ERRORS
+	struct task_struct *task = current;
+
 	__backtrace();
-	print_traces(current);
-	show_held_locks(current);
+	print_traces(task);
+	mutex_debug_show_held_locks(task);
+	rt_mutex_show_held_locks(task, 1);
 #endif
 }
 
Index: linux-2.6.16/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.16.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.16/arch/x86_64/kernel/traps.c
@@ -255,6 +255,8 @@ void show_trace(struct task_struct *task
 #undef HANDLE_STACK
 	printk("\n");
 	print_traces(task);
+	mutex_debug_show_held_locks(task);
+	rt_mutex_show_held_locks(task, 1);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long * rsp)
Index: linux-2.6.16/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.16.orig/arch/i386/kernel/traps.c
+++ linux-2.6.16/arch/i386/kernel/traps.c
@@ -175,6 +175,7 @@ static void show_trace_log_lvl(struct ta
 		printk(" =======================\n");
 	}
 	print_traces(task);
+	mutex_debug_show_held_locks(task);
 	rt_mutex_show_held_locks(task, 1);
 }
 
