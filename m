Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVAGTaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVAGTaE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVAGT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:28:31 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49551 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261551AbVAGT0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:26:52 -0500
Date: Fri, 7 Jan 2005 12:26:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-mm1-V0.7.34-00
Message-ID: <20050107192651.GG5259@smtp.west.cox.net>
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104094518.GA13868@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 10:45:18AM +0100, Ingo Molnar wrote:
> 
> * Bill Huey <bhuey@lnxw.com> wrote:
> 
> > You'll have to apply Ingo's patch so that it gets rejects and then
> > apply this patch on top of it so that it resolves those issues. It's a
> > bit sloppy, but this'll at least be somewhat workable until Ingo comes
> > back and pounds us with patches. :)
> 
> i've uploaded my port:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this is mainly a straight port from 2.6.10-rc3-mm1 to 2.6.10-mm1, plus i
> picked up a post-2.6.10-mm1 audio-driver buildsystem fix-patch. Please
> (re-)report any new or old regressions.

Here's a handful of little things to fix issues in the patch for when
you try and use the patchset on an architecture that doesn't (yet) work.

- cycles_t is defined in <asm/timex.h>, but that wasn't part of
  <linux/irq.h> previously (breaks ppc32, I _think_).
- debug_direct_keyboard & such only exist on GENERIC_HARDIRQ arches (and
  I would guess make sense on ones you have a console & !USB keyboard
  on).
- The stubs for init_hardirqs / early_init_hardirqs were in a
  conflicting state (as seen on ppc32, which is GENERIC_HARDIRQ, but not
  yet supported).  I think this gets them down to what was intended.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.10.orig/include/linux/irq.h
+++ linux-2.6.10/include/linux/irq.h
@@ -21,6 +21,7 @@
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
+#include <asm/timex.h>
 
 /*
  * IRQ line status.
@@ -100,11 +101,14 @@ extern void report_bad_irq(unsigned int 
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
 extern void early_init_hardirqs(void);
-extern void init_hardirqs(void);
 extern void init_irq_proc(void);
 extern cycles_t irq_timestamp(unsigned int irq);
 #else
 static inline void early_init_hardirqs(void) { }
+#endif
+#if defined(CONFIG_GENERIC_HARDIRQS) && defined(CONFIG_PREEMPT_HARDIRQS)
+extern void init_hardirqs(void);
+#else
 static inline void init_hardirqs(void) { }
 #endif
 
--- linux-2.6.10.orig/include/linux/sched.h
+++ linux-2.6.10/include/linux/sched.h
@@ -47,7 +47,9 @@ extern void direct_timer_interrupt(struc
 extern struct semaphore kernel_sem;
 #endif
 
+#ifdef CONFIG_GENERIC_HARDIRQS
 extern int debug_direct_keyboard;
+#endif
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
   extern void deadlock_trace_off(void);
--- linux-2.6.10.orig/kernel/irq/manage.c
+++ linux-2.6.10/kernel/irq/manage.c
@@ -527,10 +527,6 @@ void __init init_hardirqs(void)
 
 #else
 
-void __init init_hardirqs(void)
-{
-}
-
 static int start_irq_thread(int irq, struct irq_desc *desc)
 {
 	return 0;
@@ -545,5 +541,3 @@ void __init early_init_hardirqs(void)
 	for (i = 0; i < NR_IRQS; i++)
 		init_waitqueue_head(&irq_desc[i].wait_for_handler);
 }
-
-
--- linux-2.6.10.orig/kernel/sched.c
+++ linux-2.6.10/kernel/sched.c
@@ -5409,8 +5409,10 @@ void __might_sleep(char *file, int line)
 
 	if ((in_atomic() || irqs_disabled()) &&
 	    system_state == SYSTEM_RUNNING) {
+#ifdef CONFIG_GENERIC_HARDIRQS
 		if (debug_direct_keyboard && hardirq_count())
 			return;
+#endif
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
--- linux-2.6.10.orig/kernel/sysctl.c
+++ linux-2.6.10/kernel/sysctl.c
@@ -391,6 +391,7 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_GENERIC_HARDIRQS
 	{
 		.ctl_name	= KERN_PANIC,
 		.procname	= "debug_direct_keyboard",
@@ -399,6 +400,7 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#endif
 	{
 		.ctl_name	= KERN_CORE_USES_PID,
 		.procname	= "core_uses_pid",
--- linux-2.6.10.orig/include/linux/rt_lock.h
+++ linux-2.6.10/include/linux/rt_lock.h
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
-#include <asm/atomic.h>
 
 /*
  * These are the basic SMP spinlocks, allowing only a single CPU anywhere.
@@ -26,6 +25,8 @@ typedef struct {
 # define RAW_SPIN_LOCK_UNLOCKED (raw_spinlock_t) __RAW_SPIN_LOCK_UNLOCKED
 #endif
 
+#include <asm/atomic.h>
+
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
--- linux-2.6.10.orig/include/linux/rt_lock.h
+++ linux-2.6.10/include/linux/rt_lock.h
@@ -25,8 +25,6 @@ typedef struct {
 # define RAW_SPIN_LOCK_UNLOCKED (raw_spinlock_t) __RAW_SPIN_LOCK_UNLOCKED
 #endif
 
-#include <asm/atomic.h>
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -173,6 +171,7 @@ typedef struct {
 
 
 #ifdef CONFIG_PREEMPT_RT
+#include <asm/atomic.h>
 
 /*
  * semaphores - an RT-mutex plus the semaphore count:

-- 
Tom Rini
http://gate.crashing.org/~trini/
