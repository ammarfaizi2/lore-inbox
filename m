Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbVIAV7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbVIAV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbVIAV7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:59:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59271 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030428AbVIAV7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:59:22 -0400
Date: Thu, 1 Sep 2005 23:59:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 3/10] m68k: thread_info header cleanup
Message-ID: <Pine.LNX.4.61.0509012359040.9708@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

a) in smp_lock.h #include of sched.h and spinlock.h moved under
#ifdef CONFIG_LOCK_KERNEL.
b) interrupt.h now explicitly pulls sched.h (not via smp_lock.h from
hardirq.h as it used to)
c) in three more places we need changes to compensate for (a) - one
place in arch/sparc needs string.h now, hardirq.h needs forward
declaration of task_struct and preempt.h needs direct include of
thread_info.h.
d) thread_info-related helpers in sched.h and thread_info.h put under
ifndef __HAVE_THREAD_FUNCTIONS.  Obviously safe.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/sparc/lib/bitext.c   |    1 +
 include/linux/hardirq.h   |    2 ++
 include/linux/interrupt.h |    1 +
 include/linux/preempt.h   |    1 +
 include/linux/sched.h     |    4 ++++
 include/linux/smp_lock.h  |    3 +--
 6 files changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6-mm/arch/sparc/lib/bitext.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/lib/bitext.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc/lib/bitext.c	2005-09-01 21:04:33.219211431 +0200
@@ -10,6 +10,7 @@
  */
 
 #include <linux/smp_lock.h>
+#include <linux/string.h>
 #include <linux/bitops.h>
 
 #include <asm/bitext.h>
Index: linux-2.6-mm/include/linux/hardirq.h
===================================================================
--- linux-2.6-mm.orig/include/linux/hardirq.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/hardirq.h	2005-09-01 21:04:33.240207823 +0200
@@ -90,6 +90,8 @@ extern void synchronize_irq(unsigned int
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
+struct task_struct;
+
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 static inline void account_user_vtime(struct task_struct *tsk)
 {
Index: linux-2.6-mm/include/linux/interrupt.h
===================================================================
--- linux-2.6-mm.orig/include/linux/interrupt.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/interrupt.h	2005-09-01 21:04:33.241207651 +0200
@@ -9,6 +9,7 @@
 #include <linux/preempt.h>
 #include <linux/cpumask.h>
 #include <linux/hardirq.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-09-01 21:04:28.637998577 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-09-01 21:04:33.241207651 +0200
@@ -1209,6 +1209,8 @@ static inline void task_unlock(struct ta
 	spin_unlock(&p->alloc_lock);
 }
 
+#ifndef __HAVE_THREAD_FUNCTIONS
+
 #define task_thread_info(task) (task)->thread_info
 
 static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
@@ -1222,6 +1224,8 @@ static inline unsigned long *end_of_stac
 	return (unsigned long *)(p->thread_info + 1);
 }
 
+#endif
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
Index: linux-2.6-mm/include/linux/smp_lock.h
===================================================================
--- linux-2.6-mm.orig/include/linux/smp_lock.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/smp_lock.h	2005-09-01 21:04:33.247206621 +0200
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
Index: linux-2.6-mm/include/linux/preempt.h
===================================================================
--- linux-2.6-mm.orig/include/linux/preempt.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/preempt.h	2005-09-01 21:04:33.252205762 +0200
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/thread_info.h>
 #include <linux/linkage.h>
 
 #ifdef CONFIG_DEBUG_PREEMPT
