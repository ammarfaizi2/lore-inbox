Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbTCQD26>; Sun, 16 Mar 2003 22:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbTCQD26>; Sun, 16 Mar 2003 22:28:58 -0500
Received: from franka.aracnet.com ([216.99.193.44]:44675 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261757AbTCQD2z>; Sun, 16 Mar 2003 22:28:55 -0500
Date: Sun, 16 Mar 2003 19:39:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make kgdb less invasive (when disabled)
Message-ID: <6200000.1047872364@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had it with kgdb remaning schedule to do_schedule, even when
it's disabled ... makes it hard to merge other scheduler diag patches,
and harder to compare profiles. It also seems to introduce an extra 
call into the schedule call path (even when disabled). Grrr. 

Patch below fixes it ... booted without kgdb, and with kgdb+threads. 
Would be nice if you'd merge it into your kgdb patch so we can sync up ....
Nearly all the bits I'm fiddling with are the same as the original
patch was changing, so it shouldn't make it bigger or harder to maintain.

M.

diff -urpN -X /home/fletch/.diff.exclude 550-sched_interactive/arch/i386/kernel/entry.S 560-kgdb_cleanup/arch/i386/kernel/entry.S
--- 550-sched_interactive/arch/i386/kernel/entry.S	Sun Mar 16 13:38:59 2003
+++ 560-kgdb_cleanup/arch/i386/kernel/entry.S	Sun Mar 16 18:34:49 2003
@@ -49,6 +49,10 @@
 #include <asm/page.h>
 #include "irq_vectors.h"
 
+#ifndef CONFIG_KGDB_THREAD
+#define user_schedule schedule
+#endif
+
 EBX		= 0x00
 ECX		= 0x04
 EDX		= 0x08
diff -urpN -X /home/fletch/.diff.exclude 550-sched_interactive/arch/sparc64/kernel/rtrap.S 560-kgdb_cleanup/arch/sparc64/kernel/rtrap.S
--- 550-sched_interactive/arch/sparc64/kernel/rtrap.S	Sun Mar 16 13:38:57 2003
+++ 560-kgdb_cleanup/arch/sparc64/kernel/rtrap.S	Sun Mar 16 18:34:49 2003
@@ -15,6 +15,10 @@
 #include <asm/visasm.h>
 #include <asm/processor.h>
 
+#ifndef CONFIG_KGDB_THREAD
+#define user_schedule schedule
+#endif
+
 #define		RTRAP_PSTATE		(PSTATE_RMO|PSTATE_PEF|PSTATE_PRIV|PSTATE_IE)
 #define		RTRAP_PSTATE_IRQOFF	(PSTATE_RMO|PSTATE_PEF|PSTATE_PRIV)
 #define		RTRAP_PSTATE_AG_IRQOFF	(PSTATE_RMO|PSTATE_PEF|PSTATE_PRIV|PSTATE_AG)
diff -urpN -X /home/fletch/.diff.exclude 550-sched_interactive/arch/x86_64/kernel/entry.S 560-kgdb_cleanup/arch/x86_64/kernel/entry.S
--- 550-sched_interactive/arch/x86_64/kernel/entry.S	Sun Mar 16 13:38:57 2003
+++ 560-kgdb_cleanup/arch/x86_64/kernel/entry.S	Sun Mar 16 18:34:49 2003
@@ -46,6 +46,10 @@
 
 #define PDAREF(field) %gs:field	 		
 
+#ifndef CONFIG_KGDB_THREAD
+#define user_schedule schedule
+#endif
+
 #ifdef CONFIG_PREEMPT
 #define preempt_stop cli
 #else
diff -urpN -X /home/fletch/.diff.exclude 550-sched_interactive/include/linux/sched.h 560-kgdb_cleanup/include/linux/sched.h
--- 550-sched_interactive/include/linux/sched.h	Sun Mar 16 13:39:06 2003
+++ 560-kgdb_cleanup/include/linux/sched.h	Sun Mar 16 18:34:49 2003
@@ -171,9 +171,13 @@ extern unsigned long cache_decay_ticks;
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
-asmlinkage void do_schedule(void);
-asmlinkage void kern_schedule(void);
-asmlinkage void kern_do_schedule(struct pt_regs);
+#ifdef CONFIG_KGDB_THREAD
+ asmlinkage void do_schedule(void);
+ asmlinkage void kern_schedule(void);
+ asmlinkage void kern_do_schedule(struct pt_regs);
+#else
+ asmlinkage void schedule(void);
+#endif
 
 struct namespace;
 
@@ -691,7 +695,7 @@ extern void unhash_process(struct task_s
 #ifdef CONFIG_KGDB_THREAD
 #define schedule() kern_schedule()
 #else
-#define schedule() do_schedule()
+#define user_schedule() schedule()
 #endif
 
 /* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests inside tasklist_lock */
diff -urpN -X /home/fletch/.diff.exclude 550-sched_interactive/kernel/ksyms.c 560-kgdb_cleanup/kernel/ksyms.c
--- 550-sched_interactive/kernel/ksyms.c	Sun Mar 16 13:39:06 2003
+++ 560-kgdb_cleanup/kernel/ksyms.c	Sun Mar 16 18:34:49 2003
@@ -466,9 +466,11 @@ EXPORT_SYMBOL(sleep_on);
 EXPORT_SYMBOL(sleep_on_timeout);
 EXPORT_SYMBOL(interruptible_sleep_on);
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
-EXPORT_SYMBOL(do_schedule);
 #ifdef CONFIG_KGDB_THREAD
 EXPORT_SYMBOL(kern_schedule);
+EXPORT_SYMBOL(do_schedule);
+#else
+EXPORT_SYMBOL(schedule);
 #endif
 #ifdef CONFIG_PREEMPT
 EXPORT_SYMBOL(preempt_schedule);
diff -urpN -X /home/fletch/.diff.exclude 550-sched_interactive/kernel/sched.c 560-kgdb_cleanup/kernel/sched.c
--- 550-sched_interactive/kernel/sched.c	Sun Mar 16 13:51:51 2003
+++ 560-kgdb_cleanup/kernel/sched.c	Sun Mar 16 18:34:49 2003
@@ -1411,7 +1411,11 @@ void scheduling_functions_start_here(voi
 /*
  * schedule() is the main scheduler function.
  */
+#ifdef CONFIG_KGDB_THREAD
 asmlinkage void do_schedule(void)
+#else
+asmlinkage void schedule(void)
+#endif
 {
 	task_t *prev, *next;
 	runqueue_t *rq;
@@ -1667,15 +1671,13 @@ void complete_all(struct completion *x)
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
+#ifdef CONFIG_KGDB_THREAD
 asmlinkage void user_schedule(void)
 {
-#ifdef CONFIG_KGDB_THREAD
 	current->thread.kgdbregs = NULL;
-#endif
 	do_schedule();
 }
 
-#ifdef CONFIG_KGDB_THREAD
 asmlinkage void kern_do_schedule(struct pt_regs regs)
 {
 	current->thread.kgdbregs = &regs;

