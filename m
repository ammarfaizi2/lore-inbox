Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVHYFYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVHYFYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHYFWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:22:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9676 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964821AbVHYFWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:22:11 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (19/22) task_thread_info - part 3/4
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEm-0005ed-Ok@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a) in smp_lock.h #include of sched.h and spinlock.h moved under
#ifdef CONFIG_LOCK_KERNEL.
b) interrupt.h now explicitly pulls sched.h (not via smp_lock.h from
hardirq.h as it used to)
c) in two more places we need changes to compensate for (a) - one place in
arch/sparc needs string.h now and hardirq.h needs forward declaration of
task_struct and direct include of thread_info.h.
d) thread_info-related helpers in sched.h and thread_info.h put under
ifndef __HAVE_THREAD_FUNCTIONS.  Obviously safe.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-other-helpers/arch/sparc/lib/bitext.c RC13-rc7-includes/arch/sparc/lib/bitext.c
--- RC13-rc7-other-helpers/arch/sparc/lib/bitext.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-includes/arch/sparc/lib/bitext.c	2005-08-25 00:54:18.000000000 -0400
@@ -10,6 +10,7 @@
  */
 
 #include <linux/smp_lock.h>
+#include <linux/string.h>
 #include <linux/bitops.h>
 
 #include <asm/bitext.h>
diff -urN RC13-rc7-other-helpers/include/linux/hardirq.h RC13-rc7-includes/include/linux/hardirq.h
--- RC13-rc7-other-helpers/include/linux/hardirq.h	2005-08-10 10:37:54.000000000 -0400
+++ RC13-rc7-includes/include/linux/hardirq.h	2005-08-25 00:54:18.000000000 -0400
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/preempt.h>
 #include <linux/smp_lock.h>
+#include <linux/thread_info.h>
 #include <asm/hardirq.h>
 #include <asm/system.h>
 
@@ -90,6 +91,8 @@
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
+struct task_struct;
+
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 static inline void account_user_vtime(struct task_struct *tsk)
 {
diff -urN RC13-rc7-other-helpers/include/linux/interrupt.h RC13-rc7-includes/include/linux/interrupt.h
--- RC13-rc7-other-helpers/include/linux/interrupt.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-includes/include/linux/interrupt.h	2005-08-25 00:54:18.000000000 -0400
@@ -12,6 +12,7 @@
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
+#include <linux/sched.h>
 
 /*
  * For 2.4.x compatibility, 2.4.x can use
diff -urN RC13-rc7-other-helpers/include/linux/sched.h RC13-rc7-includes/include/linux/sched.h
--- RC13-rc7-other-helpers/include/linux/sched.h	2005-08-25 00:54:17.000000000 -0400
+++ RC13-rc7-includes/include/linux/sched.h	2005-08-25 00:54:18.000000000 -0400
@@ -1136,6 +1136,8 @@
 	spin_unlock(&p->alloc_lock);
 }
 
+#ifndef __HAVE_THREAD_FUNCTIONS
+
 #define task_thread_info(task) (task)->thread_info
 
 static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
@@ -1176,6 +1178,8 @@
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
+#endif
+
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
diff -urN RC13-rc7-other-helpers/include/linux/smp_lock.h RC13-rc7-includes/include/linux/smp_lock.h
--- RC13-rc7-other-helpers/include/linux/smp_lock.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-includes/include/linux/smp_lock.h	2005-08-25 00:54:18.000000000 -0400
@@ -2,11 +2,10 @@
 #define __LINUX_SMPLOCK_H
 
 #include <linux/config.h>
+#ifdef CONFIG_LOCK_KERNEL
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 
-#ifdef CONFIG_LOCK_KERNEL
-
 #define kernel_locked()		(current->lock_depth >= 0)
 
 extern int __lockfunc __reacquire_kernel_lock(void);
diff -urN RC13-rc7-other-helpers/include/linux/thread_info.h RC13-rc7-includes/include/linux/thread_info.h
--- RC13-rc7-other-helpers/include/linux/thread_info.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-includes/include/linux/thread_info.h	2005-08-25 00:54:18.000000000 -0400
@@ -22,6 +22,7 @@
 
 #ifdef __KERNEL__
 
+#ifndef __HAVE_THREAD_FUNCTIONS
 /*
  * flag set/clear/test wrappers
  * - pass TIF_xxxx constants to these functions
@@ -88,5 +89,6 @@
 }
 
 #endif
+#endif
 
 #endif /* _LINUX_THREAD_INFO_H */
