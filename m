Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVDUR6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDUR6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDUR6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:58:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20973 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261558AbVDUR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:57:15 -0400
Date: Thu, 21 Apr 2005 18:57:23 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421175723.GB13052@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	thread_info part 3: heads.

a) in smp_lock.h #include of sched.h and spinlock.h moved under
#ifdef CONFIG_LOCK_KERNEL.
b) interrupt.h now explicitly pulls sched.h (not via smp_lock.h from
hardirq.h as it used to)
c) in two more places we need changes to compensate for (a) - one place in
arch/sparc needs string.h now and hardirq.h needs forward declaration of
task_struct.

d) thread_info-related helpers in sched.h and thread_info.h put under
ifndef __HAVE_THREAD_FUNCTIONS.  Obviously safe.

That ends changes in generic parts of tree.  And now we can get m68k in
there - that will be localized to asm-m68k and arch/m68k.

As far as I can see that's the minimally intrusive header changes needed
to avoid problems - better than variant with splitting sched.h as in m68k CVS.

diff -urN RC12-rc3-other_helpers/arch/sparc/lib/bitext.c RC12-rc3-includes/arch/sparc/lib/bitext.c
--- RC12-rc3-other_helpers/arch/sparc/lib/bitext.c	Fri Mar 11 15:54:46 2005
+++ RC12-rc3-includes/arch/sparc/lib/bitext.c	Wed Apr 20 22:51:17 2005
@@ -10,6 +10,7 @@
  */
 
 #include <linux/smp_lock.h>
+#include <linux/string.h>
 #include <linux/bitops.h>
 
 #include <asm/bitext.h>
diff -urN RC12-rc3-other_helpers/include/linux/hardirq.h RC12-rc3-includes/include/linux/hardirq.h
--- RC12-rc3-other_helpers/include/linux/hardirq.h	Fri Mar 11 15:54:57 2005
+++ RC12-rc3-includes/include/linux/hardirq.h	Wed Apr 20 22:51:17 2005
@@ -85,6 +85,8 @@
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
+struct task_struct;
+
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 static inline void account_user_vtime(struct task_struct *tsk)
 {
diff -urN RC12-rc3-other_helpers/include/linux/interrupt.h RC12-rc3-includes/include/linux/interrupt.h
--- RC12-rc3-other_helpers/include/linux/interrupt.h	Fri Mar 11 15:54:57 2005
+++ RC12-rc3-includes/include/linux/interrupt.h	Wed Apr 20 22:51:17 2005
@@ -12,6 +12,7 @@
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
+#include <linux/sched.h>
 
 /*
  * For 2.4.x compatibility, 2.4.x can use
diff -urN RC12-rc3-other_helpers/include/linux/sched.h RC12-rc3-includes/include/linux/sched.h
--- RC12-rc3-other_helpers/include/linux/sched.h	Wed Apr 20 22:51:15 2005
+++ RC12-rc3-includes/include/linux/sched.h	Wed Apr 20 22:51:17 2005
@@ -1102,6 +1102,8 @@
 	spin_unlock(&p->alloc_lock);
 }
 
+#ifndef __HAVE_THREAD_FUNCTIONS
+
 #define task_thread_info(task) (task)->thread_info
 
 static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
@@ -1141,6 +1143,8 @@
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
+
+#endif
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
diff -urN RC12-rc3-other_helpers/include/linux/smp_lock.h RC12-rc3-includes/include/linux/smp_lock.h
--- RC12-rc3-other_helpers/include/linux/smp_lock.h	Fri Mar 11 15:54:57 2005
+++ RC12-rc3-includes/include/linux/smp_lock.h	Wed Apr 20 22:51:17 2005
@@ -2,10 +2,9 @@
 #define __LINUX_SMPLOCK_H
 
 #include <linux/config.h>
+#ifdef CONFIG_LOCK_KERNEL
 #include <linux/sched.h>
 #include <linux/spinlock.h>
-
-#ifdef CONFIG_LOCK_KERNEL
 
 #define kernel_locked()		(current->lock_depth >= 0)
 
diff -urN RC12-rc3-other_helpers/include/linux/thread_info.h RC12-rc3-includes/include/linux/thread_info.h
--- RC12-rc3-other_helpers/include/linux/thread_info.h	Wed Feb  4 11:48:57 2004
+++ RC12-rc3-includes/include/linux/thread_info.h	Wed Apr 20 22:51:17 2005
@@ -22,6 +22,7 @@
 
 #ifdef __KERNEL__
 
+#ifndef __HAVE_THREAD_FUNCTIONS
 /*
  * flag set/clear/test wrappers
  * - pass TIF_xxxx constants to these functions
@@ -87,6 +88,7 @@
 	clear_thread_flag(TIF_NEED_RESCHED);
 }
 
+#endif
 #endif
 
 #endif /* _LINUX_THREAD_INFO_H */
