Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUJIFuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUJIFuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUJIFuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:50:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29683 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266512AbUJIFrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:47:11 -0400
Message-ID: <41677E4D.1030403@mvista.com>
Date: Fri, 08 Oct 2004 22:59:41 -0700
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
Subject: [ANNOUNCE] Linux 2.6 Real Time Kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Announcing the availability of prototype real-time (RT)
enhancements to the Linux 2.6 kernel.

We will submit 3 additional emails following this one, containing
the remaining 3 patches (of 4) inline, with their descriptions.

Download:

Patches against the Linux-2.6.9-rc3 kernel are available at:

ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_irqthreads.patch
ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_mutex.patch
ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_spinlock1.patch
ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_spinlock2.patch

The patches are to be applied to the linux-2.6.9-rc3 kernel in the
order listed above.

Subsequent announcements will include the links to the ftp site only,
to reduce email bulk on the Linux kernel mailing list.


Introduction:

The purpose of this effort is to to further reduce interrupt latency
and to dramatically reduce task preemption latency in the 2.6 kernel
series.  Our broad objective is to achieve preemption latency bounded
by the worst case IRQ disable.

We are in progress of porting to the 2.6.9-rc3-mm kernel series,
and would like to present our work at this stage, to request
general feedback, and interact with others working on similar kernel
enhancements.

These RT enhancements are an integration of features developed by
others and some new MontaVista components:

	- Voluntary Preemption by Ingo Molnar
	- IRQ thread patches by Scott Wood and Ingo Molnar
	- BKL mutex patch by Ingo Molnar (with MV extensions)
	- PMutex from Germany's Universitaet der Bundeswehr, Munich
	- MontaVista mutex abstraction layer replacing spinlocks with mutexes

WHY IMPLEMENT PRELIMINARY RT SUPPORT IN LINUX:

Our objective is to enable the Linux 2.6 kernel to be usable
for high-performance multi-media applications and for applications
requiring very fast, task level reliable control functions.

The AV industry is building HDTV related technology on Linux,
and desktop systems are increasingly used for similar applications.

Cell phones, PDAs and MP3 players are converging into highly
integrated devices requiring a large number of threads. These
threads support a vast array of communications protocols
(IP, Bluetooth, 802.11, GSM, CDMA, etc.). Especially the
cellular-based protocols require highly deadline-sensitive
operations to work reliably.

GPS processing, for example, requires hard real-time tasks and
guaranteed KHz frequency interrupt processing. Linux-based remote
controlled GPS stations at inaccessible or dangerous sites,
like the inside of Mt. St. Helens, stream live data via IP.

Additionally, Linux is being increasingly utilized in traditional
real-time control environments including radar processing, factory
automation systems, "in the loop" process control systems, medical and
instrumentation systems, and automotive control systems.  Many times
these systems have task level response requirements in the 10's to
hundreds of microsecond ranges, which is a level of guaranteed task
response not achievable with current 2.6 Linux technology.


Other precedent work:

There are several micro-kernel solutions available, which achieve
the required performance, but there are two general concerns with
such solutions:

	1. Two separate kernel environments, creating more overall
         system complexity and application design complexity.
	2. Legal controversy.

In line with the above mentioned previous Kernel enhancements,
our work is designed to be transparent to existing applications
and drivers.



Implementation Details:

We have substituted the definition of kernel spinlocks with
a mutex abstraction that uses the P-mutex from the Bundeswehr
University in Munich, Germany:

http://inf3-www.informatik.unibw-muenchen.de/research/linux/mutex/

The spinlock definitions have been abstracted to invoke
a crude but effective #define-based substitution of spin_lock
to mutex_lock functions (in linux/kmutex.h).

We have abstracted the mutex layer to allow configuration
and selection of the mutex implementation. We have used a
simple mutex implementation, but intend to support use of
other mutexes, for example the existing system semaphore,
or third party plugins such as the the FUSYN project.


Partitioning the Critical Sections:

A partitioning between critical sections protected by spinlocks
and critical sections protected by mutexes has been established.

There are currently some overlaps (or holes) in the partitioning.
It is possible for a task holding a spinlock to block
on a mutex, causing a deadlock. These deadlocks are resolved for
interactive tasks on UP by grace of the interactive scheduler.

We are eliminating this nesting of mutex-protected sections
inside of spinlock-protected critical sections.
Only a minimal set (teens) of the spinlocks will remain.
This set will be composed of spinlocks necessary to protect
immediate hardware, as well as minimal critical sections that
would not benefit from mutex-based preemptability.

Our broad objective is to achieve preemption latency bounded by the
worst case IRQ disable.  Total response latency (i.e, time to
initiate/complete an arbitrary system call) would still be bounded
by the worst case spinlock protected critical region.


Testing

This experimental code requires further enhancement
and is very much a work in progress.

The kernel is fairly stable, failing under high loads
and in low memory conditions.

The kernel has not been extensively tested on SMP systems.

We are reluctant to publish any performance numbers until
we have completed the mutex-spinlock partitioning and
provisioned support for RW locks.

At that point, we expect the worst case preemption latencies
to be in the hundreds of microseconds on a typical workstation.

We are acknowledging performance degradation due to the mutex
debug code and the abstraction layer.
We expect to be able to improve throughput as the code matures,
and the RT kernel becomes more refined.


Documentation:

Please find additional documentation in the
Documentation/rttReleaseNotes file.

Please see this document for a complete list of
known problems and latest status.



Credits and Thanks:

We wish to acknowledge the precedent work that has
allowed us to build this framework, as cited above.

We would also like to thank Dirk Grambow, Arnd Heursch,
and Witold Jaworski of the Universitaet der Bundeswehr,
Muenchen, Germany.

We are providing this kernel patch as waypoint on the course
towards configurable responsiveness in the 2.6 Linux kernel.

Thank you

Sven-Thorsten Dietrich



Attached below, please find the first of 4 patches.


  RT Prototype 2004 (C) MontaVista Software, Inc.
  This file is licensed under the terms of the GNU
  General Public License version 2. This program
  is licensed "as is" without any warranty of any kind,
  whether express or implied.


Linux-2.6.9-rc3-RT_irqthreads.patch
===================================
This patch is a hybrid of several IRQ threads implementations,
as cited above.
We have made some modifications to adapt wake-up to handle
the scenario where an IRQ thread could be blocked on a mutex
at transition of an interrupt.
                                                                                
We expect to revise this IRQ thread code after moving to
the mm kernel series, and while incorporating the voluntary
preemption code.
                                                                                
This patch adds options to the 'General setup' section of
the kernel configuration. Running irqs in threads is
prerequisite for the subsequent patches. We have provided
defaults for running softirqs in threads, and have selected
Ingo Molnar's IRQ thread implementation as default.                                                                               
                                                                                
CONFIG_SOFTIRQ_THREADS
                                                                                
- required for RT kernel. Runs all softirqs in softirqd
                                                                                
CONFIG_INGO_THREADS
                                                                                
- enable Ingo Molnar's version of IRQ threads. This is not
  in sync with the latest releases in the voluntary preempt
  series.
                                                                                
CONFIG_IRQ_THREADS
- version of IRQ threads posted to LKML by Scott Wood.
  This appears to have been superceded by Ingo Molnar's changes.
                                                                                
                                                                                
In addition, this patch includes a port of Ingo Molnar's
proposed substitution of the BKL into the kernel semaphore.

Sign-off: Sven-Thorsten Dietrich (sdietrich@mvista.com)


diff -pruN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/Kconfig	2004-10-09 04:01:36.000000000 +0400
@@ -497,6 +497,7 @@ config SCHED_SMT
 
 config PREEMPT
 	bool "Preemptible Kernel"
+	default y 
 	help
 	  This option reduces the latency of the kernel when reacting to
 	  real-time or interactive events by allowing a low priority process to
diff -pruN a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/kernel/i386_ksyms.c	2004-10-09 04:01:36.000000000 +0400
@@ -76,9 +76,11 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(ioremap_nocache);
 EXPORT_SYMBOL(iounmap);
+#ifndef CONFIG_INGO_IRQ_THREADS
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(disable_irq_nosync);
+#endif
 EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(pm_idle);
@@ -138,6 +140,10 @@ EXPORT_SYMBOL(smp_num_siblings);
 EXPORT_SYMBOL(cpu_sibling_map);
 #endif
 
+#if defined(CONFIG_IRQ_THREADS) && !defined(CONFIG_SMP) && !defined(CONFIG_INGO_IRQ_THREADS)
+EXPORT_SYMBOL(synchronize_irq);
+#endif
+
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(cpu_online_map);
@@ -145,9 +151,9 @@ EXPORT_SYMBOL(cpu_callout_map);
 EXPORT_SYMBOL(__write_lock_failed);
 EXPORT_SYMBOL(__read_lock_failed);
 
-/* Global SMP stuff */
-EXPORT_SYMBOL(synchronize_irq);
+#ifndef CONFIG_INGO_IRQ_THREADS
 EXPORT_SYMBOL(smp_call_function);
+#endif
 
 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
diff -pruN a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/kernel/i8259.c	2004-10-09 04:01:36.000000000 +0400
@@ -358,7 +358,14 @@ static irqreturn_t math_error_irq(int cp
  * New motherboards sometimes make IRQ 13 be a PCI interrupt,
  * so allow interrupt sharing.
  */
-static struct irqaction fpu_irq = { math_error_irq, 0, CPU_MASK_NONE, "fpu", NULL, NULL };
+#ifndef CONFIG_INGO_IRQ_THREADS
+static struct irqaction fpu_irq =
+	{ math_error_irq, SA_NOTHREAD, CPU_MASK_NONE, "fpu", NULL, NULL };
+#else
+static struct irqaction fpu_irq =
+	{ math_error_irq, SA_NODELAY, CPU_MASK_NONE, "fpu", NULL, NULL };
+#endif
+
 
 void __init init_ISA_irqs (void)
 {
diff -pruN a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/kernel/irq.c	2004-10-09 04:01:36.000000000 +0400
@@ -45,6 +45,8 @@
 #include <asm/desc.h>
 #include <asm/irq.h>
 
+static DECLARE_MUTEX(probe_sem);
+
 /*
  * Linux has a controller-independent x86 interrupt architecture.
  * every controller has a 'controller-template', that is used
@@ -71,7 +73,9 @@ irq_desc_t irq_desc[NR_IRQS] __cacheline
 	}
 };
 
+#ifndef CONFIG_INGO_IRQ_THREADS
 static void register_irq_proc (unsigned int irq);
+#endif
 
 /*
  * per-CPU IRQ handling stacks
@@ -198,9 +202,9 @@ skip:
 	return 0;
 }
 
+#ifndef CONFIG_INGO_IRQ_THREADS
 
-
-
+#ifndef CONFIG_IRQ_THREADS 
 #ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
@@ -208,6 +212,7 @@ inline void synchronize_irq(unsigned int
 		cpu_relax();
 }
 #endif
+#endif /* CONFIG_IRQ_THREADS */
 
 /*
  * This should really return information about whether
@@ -226,10 +231,16 @@ asmlinkage int handle_IRQ_event(unsigned
 		local_irq_enable();
 
 	do {
-		ret = action->handler(irq, action->dev_id, regs);
-		if (ret == IRQ_HANDLED)
-			status |= action->flags;
-		retval |= ret;
+#ifdef CONFIG_IRQ_THREADS
+		if (action->flags & SA_NOTHREAD)
+#endif
+		{
+			ret = action->handler(irq, action->dev_id, regs);
+               		if (ret == IRQ_HANDLED)
+                       	status |= action->flags;
+               		retval |= ret;
+
+		}
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
@@ -291,12 +302,10 @@ __setup("noirqdebug", noirqdebug_setup);
  *
  * Called under desc->lock
  */
-static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+static void note_interrupt(int irq, irq_desc_t *desc)
 {
-	if (action_ret != IRQ_HANDLED) {
+	if (desc->status & IRQ_HANDLED) {
 		desc->irqs_unhandled++;
-		if (action_ret != IRQ_NONE)
-			report_bad_irq(irq, desc, action_ret);
 	}
 
 	desc->irq_count++;
@@ -308,7 +317,7 @@ static void note_interrupt(int irq, irq_
 		/*
 		 * The interrupt is stuck
 		 */
-		__report_bad_irq(irq, desc, action_ret);
+		__report_bad_irq(irq, desc, IRQ_NONE);
 		/*
 		 * Now kill the IRQ
 		 */
@@ -340,13 +349,13 @@ static void note_interrupt(int irq, irq_
  
 inline void disable_irq_nosync(unsigned int irq)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	irq_desc_t *desc = irq_descp(irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
 	if (!desc->depth++) {
 		desc->status |= IRQ_DISABLED;
-		desc->handler->disable(irq);
+		SHUTDOWN_IRQ(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
@@ -366,7 +375,7 @@ inline void disable_irq_nosync(unsigned 
  
 void disable_irq(unsigned int irq)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	irq_desc_t *desc = irq_descp(irq);
 	disable_irq_nosync(irq);
 	if (desc->action)
 		synchronize_irq(irq);
@@ -385,7 +394,7 @@ void disable_irq(unsigned int irq)
  
 void enable_irq(unsigned int irq)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	irq_desc_t *desc = irq_descp(irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
@@ -397,7 +406,15 @@ void enable_irq(unsigned int irq)
 			desc->status = status | IRQ_REPLAY;
 			hw_resend_irq(desc->handler,irq);
 		}
-		desc->handler->enable(irq);
+
+		/* Don't unmask the IRQ if it's in progress, or else you
+		   could re-enter the IRQ handler.  As it is now enabled,
+		   the IRQ will be enabled when the handler is finished. */
+				
+		if (!(desc->status & (IRQ_INPROGRESS | IRQ_THREADRUNNING |
+		                      IRQ_THREADPENDING)))
+			STARTUP_IRQ(irq);
+
 		/* fall-through */
 	}
 	default:
@@ -410,6 +427,8 @@ void enable_irq(unsigned int irq)
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+#endif
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -428,7 +447,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * handled by some other CPU. (or is disabled)
 	 */
 	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
-	irq_desc_t *desc = irq_desc + irq;
+	irq_desc_t *desc = irq_descp(irq);
 	struct irqaction * action;
 	unsigned int status;
 
@@ -456,14 +475,17 @@ asmlinkage unsigned int do_IRQ(struct pt
 	   WAITING is used by probe to mark irqs that are being tested
 	   */
 	status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-	status |= IRQ_PENDING; /* we _want_ to handle it */
+	status |= IRQ_PENDING |  /* we _want_ to handle it */
+	          IRQ_UNHANDLED; /* This will be cleared after a
+	                            handler that cares. */
 
 	/*
 	 * If the IRQ is disabled for whatever reason, we cannot
 	 * use the action we have.
 	 */
 	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
+	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS |
+	                       IRQ_THREADPENDING | IRQ_THREADRUNNING)))) {
 		action = desc->action;
 		status &= ~IRQ_PENDING; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
@@ -479,6 +501,14 @@ asmlinkage unsigned int do_IRQ(struct pt
 	if (unlikely(!action))
 		goto out;
 
+#ifdef CONFIG_INGO_IRQ_THREADS
+        /*
+         * hardirq redirection to the irqd process context:
+         */
+        if (generic_redirect_hardirq(desc))
+                goto out_no_end;
+#endif
+
 	/*
 	 * Edge triggered interrupts need to remember
 	 * pending events.
@@ -500,8 +530,16 @@ asmlinkage unsigned int do_IRQ(struct pt
 		curctx = (union irq_ctx *) current_thread_info();
 		irqctx = hardirq_ctx[smp_processor_id()];
 
-		spin_unlock(&desc->lock);
-
+#ifdef CONFIG_IRQ_THREADS
+		if (desc->thread) {
+			desc->status |= IRQ_THREADPENDING;
+			wake_up_process(desc->thread);
+		}
+	
+		if (!desc->thread || (desc->status & IRQ_NOTHREAD))
+#endif
+		{
+			spin_unlock(&desc->lock);
 		/*
 		 * this is where we switch to the IRQ stack. However, if we are already using
 		 * the IRQ stack (because we interrupted a hardirq handler) we can't do that
@@ -509,51 +547,80 @@ asmlinkage unsigned int do_IRQ(struct pt
 		 * after all)
 		 */
 
-		if (curctx == irqctx)
-			action_ret = handle_IRQ_event(irq, &regs, action);
-		else {
-			/* build the stack frame on the IRQ stack */
-			isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
-			irqctx->tinfo.task = curctx->tinfo.task;
-			irqctx->tinfo.previous_esp = current_stack_pointer();
-
-			*--isp = (u32) action;
-			*--isp = (u32) &regs;
-			*--isp = (u32) irq;
-
-			asm volatile(
-				"       xchgl   %%ebx,%%esp     \n"
-				"       call    handle_IRQ_event \n"
-				"       xchgl   %%ebx,%%esp     \n"
-				: "=a"(action_ret)
-				: "b"(isp)
-				: "memory", "cc", "edx", "ecx"
-			);
-
+			if (curctx == irqctx)
+				action_ret = handle_IRQ_event(irq, &regs, action);
+			else {
+				/* build the stack frame on the IRQ stack */
+				isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
+				irqctx->tinfo.task = curctx->tinfo.task;
+				irqctx->tinfo.previous_esp = current_stack_pointer();
+
+				*--isp = (u32) action;
+				*--isp = (u32) &regs;
+				*--isp = (u32) irq;
+
+				asm volatile(
+					"    xchgl  %%ebx,%%esp     \n"
+#ifdef CONFIG_INGO_IRQ_THREADS
+					"    call   generic_handle_IRQ_event \n"
+#else
+					"    call   handle_IRQ_event \n"
+#endif
+					"    xchgl  %%ebx,%%esp     \n"
+					: "=a"(action_ret)
+					: "b"(isp)
+					: "memory", "cc", "edx", "ecx"
+				);
+			}
+			spin_lock(&desc->lock);
+			if (!noirqdebug)
+#ifdef CONFIG_INGO_IRQ_THREADS
+	                        generic_note_interrupt(irq, desc, action_ret);
+#else
+        	                note_interrupt(irq, desc, action_ret);
+#endif
 
+			if (curctx != irqctx)
+				irqctx->tinfo.task = NULL;
+			if (likely(!(desc->status & IRQ_PENDING)))
+				break;
+			desc->status &= ~IRQ_PENDING;
 		}
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
-		if (curctx != irqctx)
-			irqctx->tinfo.task = NULL;
-		if (likely(!(desc->status & IRQ_PENDING)))
-			break;
-		desc->status &= ~IRQ_PENDING;
-	}
 
 #else
 
 	for (;;) {
 		irqreturn_t action_ret;
 
-		spin_unlock(&desc->lock);
-
-		action_ret = handle_IRQ_event(irq, &regs, action);
+# ifdef CONFIG_IRQ_THREADS
+		if (desc->thread) {
+			desc->status |= IRQ_THREADPENDING;
+			wake_up_process(desc->thread);
+		}
+	
+		if (!desc->thread || (desc->status & IRQ_NOTHREAD))
+# endif
+		{
+			spin_unlock(&desc->lock);
+#ifdef CONFIG_INGO_IRQ_THREADS
+                action_ret = generic_handle_IRQ_event(irq, &regs, action);
+#else
+                action_ret = handle_IRQ_event(irq, &regs, action);
+#endif
+			spin_lock(&desc->lock);
+			if (!noirqdebug) 
+#ifdef CONFIG_INGO_IRQ_THREADS
+                        	generic_note_interrupt(irq, desc, action_ret);
+#else
+			{
+				if (action_ret == IRQ_HANDLED)
+					desc->status &= ~IRQ_UNHANDLED;
+				else if (action_ret != IRQ_NONE)
+					report_bad_irq(irq, desc, action_ret);
+			}
+#endif
+		}
 
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
@@ -566,11 +633,20 @@ out:
 	 * The ->end() handler has to deal with interrupts which got
 	 * disabled while the handler was running.
 	 */
-	desc->handler->end(irq);
+	if (!(desc->status & (IRQ_DISABLED | IRQ_INPROGRESS |
+	                      IRQ_THREADPENDING | IRQ_THREADRUNNING))) {
+#ifndef CONFIG_INGO_IRQ_THREADS
+		if (!noirqdebug)
+                        note_interrupt(irq, desc);
+#endif
+
+
+		desc->handler->end(irq);
+	}
+out_no_end:
 	spin_unlock(&desc->lock);
 
 	irq_exit();
-
 	return 1;
 }
 
@@ -659,7 +735,12 @@ int request_irq(unsigned int irq, 
 	action->next = NULL;
 	action->dev_id = dev_id;
 
-	retval = setup_irq(irq, action);
+#ifdef CONFIG_INGO_IRQ_THREADS
+        retval = generic_setup_irq(irq, action);
+#else
+        retval = setup_irq(irq, action);
+#endif
+
 	if (retval)
 		kfree(action);
 	return retval;
@@ -667,6 +748,8 @@ int request_irq(unsigned int irq, 
 
 EXPORT_SYMBOL(request_irq);
 
+
+#ifndef CONFIG_INGO_IRQ_THREADS
 /**
  *	free_irq - free an interrupt
  *	@irq: Interrupt line to free
@@ -691,7 +774,7 @@ void free_irq(unsigned int irq, void *de
 	if (irq >= NR_IRQS)
 		return;
 
-	desc = irq_desc + irq;
+	desc = irq_descp(irq);
 	spin_lock_irqsave(&desc->lock,flags);
 	p = &desc->action;
 	for (;;) {
@@ -706,7 +789,7 @@ void free_irq(unsigned int irq, void *de
 			*pp = action->next;
 			if (!desc->action) {
 				desc->status |= IRQ_DISABLED;
-				desc->handler->shutdown(irq);
+				SHUTDOWN_IRQ(irq);
 			}
 			spin_unlock_irqrestore(&desc->lock,flags);
 
@@ -722,6 +805,7 @@ void free_irq(unsigned int irq, void *de
 }
 
 EXPORT_SYMBOL(free_irq);
+#endif
 
 /*
  * IRQ autodetection code..
@@ -732,7 +816,6 @@ EXPORT_SYMBOL(free_irq);
  * disabled.
  */
 
-static DECLARE_MUTEX(probe_sem);
 
 /**
  *	probe_irq_on	- begin an interrupt autodetect
@@ -755,7 +838,7 @@ unsigned long probe_irq_on(void)
 	 * flush such a longstanding irq before considering it as spurious. 
 	 */
 	for (i = NR_IRQS-1; i > 0; i--)  {
-		desc = irq_desc + i;
+		desc = irq_descp(i);
 
 		spin_lock_irq(&desc->lock);
 		if (!irq_desc[i].action) 
@@ -778,7 +861,7 @@ unsigned long probe_irq_on(void)
 		spin_lock_irq(&desc->lock);
 		if (!desc->action) {
 			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
-			if (desc->handler->startup(i))
+			if (STARTUP_IRQ(i))
 				desc->status |= IRQ_PENDING;
 		}
 		spin_unlock_irq(&desc->lock);
@@ -795,7 +878,7 @@ unsigned long probe_irq_on(void)
 	 */
 	val = 0;
 	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
+		irq_desc_t *desc = irq_descp(i);
 		unsigned int status;
 
 		spin_lock_irq(&desc->lock);
@@ -805,7 +888,7 @@ unsigned long probe_irq_on(void)
 			/* It triggered already - consider it spurious. */
 			if (!(status & IRQ_WAITING)) {
 				desc->status = status & ~IRQ_AUTODETECT;
-				desc->handler->shutdown(i);
+				SHUTDOWN_IRQ(i);
 			} else
 				if (i < 32)
 					val |= 1 << i;
@@ -842,7 +925,7 @@ unsigned int probe_irq_mask(unsigned lon
 
 	mask = 0;
 	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
+		irq_desc_t *desc = irq_descp(i);
 		unsigned int status;
 
 		spin_lock_irq(&desc->lock);
@@ -853,7 +936,7 @@ unsigned int probe_irq_mask(unsigned lon
 				mask |= 1 << i;
 
 			desc->status = status & ~IRQ_AUTODETECT;
-			desc->handler->shutdown(i);
+			SHUTDOWN_IRQ(i);
 		}
 		spin_unlock_irq(&desc->lock);
 	}
@@ -892,7 +975,7 @@ int probe_irq_off(unsigned long val)
 	nr_irqs = 0;
 	irq_found = 0;
 	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
+		irq_desc_t *desc = irq_descp(i);
 		unsigned int status;
 
 		spin_lock_irq(&desc->lock);
@@ -905,7 +988,7 @@ int probe_irq_off(unsigned long val)
 				nr_irqs++;
 			}
 			desc->status = status & ~IRQ_AUTODETECT;
-			desc->handler->shutdown(i);
+			SHUTDOWN_IRQ(i);
 		}
 		spin_unlock_irq(&desc->lock);
 	}
@@ -918,13 +1001,15 @@ int probe_irq_off(unsigned long val)
 
 EXPORT_SYMBOL(probe_irq_off);
 
+#ifndef CONFIG_INGO_IRQ_THREADS
+
 /* this was setup_x86_irq but it seems pretty generic */
 int setup_irq(unsigned int irq, struct irqaction * new)
 {
 	int shared = 0;
 	unsigned long flags;
 	struct irqaction *old, **p;
-	irq_desc_t *desc = irq_desc + irq;
+	irq_desc_t *desc = irq_descp(irq);
 
 	if (desc->handler == &no_irq_type)
 		return -ENOSYS;
@@ -945,6 +1030,8 @@ int setup_irq(unsigned int irq, struct i
 		rand_initialize_irq(irq);
 	}
 
+	setup_irq_spawn_thread(irq, new);
+
 	/*
 	 * The following block of code has to be executed atomically
 	 */
@@ -970,7 +1057,7 @@ int setup_irq(unsigned int irq, struct i
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
-		desc->handler->startup(irq);
+		STARTUP_IRQ(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
 
@@ -1075,7 +1162,7 @@ void init_irq_proc (void)
 	for (i = 0; i < NR_IRQS; i++)
 		register_irq_proc(i);
 }
-
+#endif /* CONFIG_INGO_IRQ_THREADS */
 
 #ifdef CONFIG_4KSTACKS
 /*
diff -pruN a/arch/i386/mach-default/setup.c b/arch/i386/mach-default/setup.c
--- a/arch/i386/mach-default/setup.c	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/mach-default/setup.c	2004-10-09 04:01:36.000000000 +0400
@@ -27,7 +27,12 @@ void __init pre_intr_init_hook(void)
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+#ifdef CONFIG_INGO_IRQ_THREADS
+static struct irqaction irq2 = { no_action, SA_NODELAY, CPU_MASK_NONE, "cascade", NULL, NULL};
+#else
+static struct irqaction irq2 =
+	{ no_action, SA_NOTHREAD, CPU_MASK_NONE, "cascade", NULL, NULL };
+#endif
 
 /**
  * intr_init_hook - post gate setup interrupt initialisation
@@ -71,7 +76,13 @@ void __init trap_init_hook(void)
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+#ifdef CONFIG_INGO_IRQ_THREADS
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT | SA_NODELAY, 
+				CPU_MASK_NONE, "timer", NULL, NULL};
+#else
+static struct irqaction irq0  =
+	{ timer_interrupt, SA_INTERRUPT | SA_NOTHREAD, CPU_MASK_NONE, "timer", NULL, NULL };
+#endif
 
 /**
  * time_init_hook - do any specific initialisations for the system timer.
diff -pruN a/arch/i386/mach-visws/setup.c b/arch/i386/mach-visws/setup.c
--- a/arch/i386/mach-visws/setup.c	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/mach-visws/setup.c	2004-10-09 04:01:36.000000000 +0400
@@ -112,7 +112,11 @@ void __init pre_setup_arch_hook()
 
 static struct irqaction irq0 = {
 	.handler =	timer_interrupt,
+#ifdef CONFIG_INGO_IRQ_THREADS
+        .flags =        SA_INTERRUPT | SA_NODELAY,
+#else
 	.flags =	SA_INTERRUPT,
+#endif
 	.name =		"timer",
 };
 
diff -pruN a/arch/i386/mach-voyager/setup.c b/arch/i386/mach-voyager/setup.c
--- a/arch/i386/mach-voyager/setup.c	2004-10-09 03:50:45.000000000 +0400
+++ b/arch/i386/mach-voyager/setup.c	2004-10-09 04:01:36.000000000 +0400
@@ -17,7 +17,11 @@ void __init pre_intr_init_hook(void)
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
+#ifdef CONFIG_INGO_IRQ_THREADS
+static struct irqaction irq2 = { no_action, SA_NODELAY, 0, "cascade", NULL, NULL};
+#else
 static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+#endif
 
 void __init intr_init_hook(void)
 {
@@ -39,8 +43,11 @@ void __init pre_setup_arch_hook(void)
 void __init trap_init_hook(void)
 {
 }
-
+#ifdef CONFIG_INGO_IRQ_THREADS
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT | SA_NODELAY, 0, "timer", NULL, NULL};
+#else
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+#endif
 
 void __init time_init_hook(void)
 {
diff -pruN a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/block/ll_rw_blk.c	2004-10-09 04:01:36.000000000 +0400
@@ -7,6 +7,9 @@
  * Queue request tables / lock, selectable elevator, Jens Axboe <axboe@suse.de>
  * kernel-doc documentation started by NeilBrown <neilb@cse.unsw.edu.au> -  July2000
  * bio rewrite, highmem i/o, etc, Jens Axboe <axboe@suse.de> - may 2001
+ *
+ *  2004-07-16 Modified by Eugeny S. Mints for RT Prototype.
+ *             RT Prototype 2004 (C) MontaVista Software, Inc.
  */
 
 /*
@@ -1211,7 +1214,16 @@ static int ll_merge_requests_fn(request_
  */
 void blk_plug_device(request_queue_t *q)
 {
+        /* XXX: emints: since irqs in threads patch is employed only routines
+         * executed from do_IRQ() are executed from a real interrupt context.
+         * For others holding a lock should be enough. Thus while irqs in
+         * threads, !irqs_disabled() doesn't a sign that we are not protected
+         * properly. May be substituted by checking corresponding lock later
+         * if paranoja.
+         */
+#if !defined(CONFIG_IRQ_THREADS) && !defined(CONFIG_INGO_IRQ_THREADS)
 	WARN_ON(!irqs_disabled());
+#endif /* CONFIG_IRQ_THREADS */
 
 	/*
 	 * don't plug a stopped queue, it must be paired with blk_start_queue()
@@ -1232,7 +1244,16 @@ EXPORT_SYMBOL(blk_plug_device);
  */
 int blk_remove_plug(request_queue_t *q)
 {
-	WARN_ON(!irqs_disabled());
+        /* XXX: emints: since irqs in threads patch is employed only routines
+         * executed from do_IRQ() are executed from a real interrupt context.
+         * For others holding a lock should be enough. Thus while irqs in
+         * threads, !irqs_disabled() doesn't a sign that we are not protected
+         * properly. May be substituted by checking corresponding lock later
+         * if paranoja.
+         */
+#if !defined(CONFIG_IRQ_THREADS) && !defined(CONFIG_INGO_IRQ_THREADS)
+        WARN_ON(!irqs_disabled());
+#endif /* CONFIG_IRQ_THREADS */
 
 	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
 		return 0;
diff -pruN a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/ide/ide-probe.c	2004-10-09 04:01:36.000000000 +0400
@@ -378,7 +378,10 @@ static int try_to_identify (ide_drive_t 
 		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
 		/* clear drive IRQ */
 		(void) hwif->INB(IDE_STATUS_REG);
-		udelay(5);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
+
 		irq = probe_irq_off(cookie);
 		if (!hwif->irq) {
 			if (irq > 0) {
diff -pruN a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
--- a/drivers/input/serio/ambakmi.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/input/serio/ambakmi.c	2004-10-09 04:01:36.000000000 +0400
@@ -84,7 +84,7 @@ static int amba_kmi_open(struct serio *i
 	writeb(divisor, KMICLKDIV);
 	writeb(KMICR_EN, KMICR);
 
-	ret = request_irq(kmi->irq, amba_kmi_int, 0, "kmi-pl050", kmi);
+	ret = request_irq(kmi->irq, amba_kmi_int, SA_NOTHREAD, "kmi-pl050", kmi);
 	if (ret) {
 		printk(KERN_ERR "kmi: failed to claim IRQ%d\n", kmi->irq);
 		writeb(0, KMICR);
diff -pruN a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/input/serio/ct82c710.c	2004-10-09 04:01:36.000000000 +0400
@@ -113,7 +113,7 @@ static int ct82c710_open(struct serio *s
 {
 	unsigned char status;
 
-	if (request_irq(CT82C710_IRQ, ct82c710_interrupt, 0, "ct82c710", NULL))
+	if (request_irq(CT82C710_IRQ, ct82c710_interrupt, SA_NOTHREAD, "ct82c710", NULL))
 		return -1;
 
 	status = inb_p(CT82C710_STATUS);
diff -pruN a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/input/serio/i8042.c	2004-10-09 04:01:36.000000000 +0400
@@ -10,6 +10,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -303,7 +304,7 @@ static int i8042_open(struct serio *port
 			return 0;
 
 	if (request_irq(values->irq, i8042_interrupt,
-			SA_SHIRQ, "i8042", i8042_request_irq_cookie)) {
+			SA_SHIRQ | SA_NOTHREAD, "i8042", i8042_request_irq_cookie)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
 		goto irq_fail;
 	}
@@ -566,7 +567,7 @@ static int __init i8042_check_aux(struct
  * in trying to detect AUX presence.
  */
 
-	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
+	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ | SA_NOTHREAD,
 				"i8042", &i8042_check_aux_cookie))
                 return -1;
 	free_irq(values->irq, &i8042_check_aux_cookie);
diff -pruN a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- a/drivers/input/serio/pcips2.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/input/serio/pcips2.c	2004-10-09 04:01:36.000000000 +0400
@@ -107,7 +107,7 @@ static int pcips2_open(struct serio *io)
 	outb(PS2_CTRL_ENABLE, ps2if->base);
 	pcips2_flush_input(ps2if);
 
-	ret = request_irq(ps2if->dev->irq, pcips2_interrupt, SA_SHIRQ,
+	ret = request_irq(ps2if->dev->irq, pcips2_interrupt, SA_SHIRQ | SA_NOTHREAD,
 			  "pcips2", ps2if);
 	if (ret == 0)
 		val = PS2_CTRL_ENABLE | PS2_CTRL_RXIRQ;
diff -pruN a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/input/serio/rpckbd.c	2004-10-09 04:01:36.000000000 +0400
@@ -85,12 +85,12 @@ static int rpckbd_open(struct serio *por
 	iomd_writeb(8, IOMD_KCTRL);
 	iomd_readb(IOMD_KARTRX);
 
-	if (request_irq(IRQ_KEYBOARDRX, rpckbd_rx, 0, "rpckbd", port) != 0) {
+	if (request_irq(IRQ_KEYBOARDRX, rpckbd_rx, SA_NOTHREAD, "rpckbd", port) != 0) {
 		printk(KERN_ERR "rpckbd.c: Could not allocate keyboard receive IRQ\n");
 		return -EBUSY;
 	}
 
-	if (request_irq(IRQ_KEYBOARDTX, rpckbd_tx, 0, "rpckbd", port) != 0) {
+	if (request_irq(IRQ_KEYBOARDTX, rpckbd_tx, SA_NOTHREAD, "rpckbd", port) != 0) {
 		printk(KERN_ERR "rpckbd.c: Could not allocate keyboard transmit IRQ\n");
 		free_irq(IRQ_KEYBOARDRX, NULL);
 		return -EBUSY;
diff -pruN a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	2004-10-09 03:50:45.000000000 +0400
+++ b/drivers/input/serio/sa1111ps2.c	2004-10-09 04:01:36.000000000 +0400
@@ -127,7 +127,7 @@ static int ps2_open(struct serio *io)
 
 	sa1111_enable_device(ps2if->dev);
 
-	ret = request_irq(ps2if->dev->irq[0], ps2_rxint, 0,
+	ret = request_irq(ps2if->dev->irq[0], ps2_rxint, SA_NOTHREAD,
 			  SA1111_DRIVER_NAME(ps2if->dev), ps2if);
 	if (ret) {
 		printk(KERN_ERR "sa1111ps2: could not allocate IRQ%d: %d\n",
@@ -135,7 +135,7 @@ static int ps2_open(struct serio *io)
 		return ret;
 	}
 
-	ret = request_irq(ps2if->dev->irq[1], ps2_txint, 0,
+	ret = request_irq(ps2if->dev->irq[1], ps2_txint, SA_NOTHREAD,
 			  SA1111_DRIVER_NAME(ps2if->dev), ps2if);
 	if (ret) {
 		printk(KERN_ERR "sa1111ps2: could not allocate IRQ%d: %d\n",
diff -pruN a/include/asm-i386/hardirq.h b/include/asm-i386/hardirq.h
--- a/include/asm-i386/hardirq.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/asm-i386/hardirq.h	2004-10-09 04:01:36.000000000 +0400
@@ -46,10 +46,28 @@ typedef struct {
 # error HARDIRQ_BITS is too low!
 #endif
 
+/*
+ * Are we doing bottom half or hardware interrupt processing?
+ * Are we in a softirq context? Interrupt context?
+ */
+#ifdef CONFIG_INGO_IRQ_THREADS
+#define in_irq()        (hardirq_count() || (current->flags & PF_HARDIRQ))
+#define in_softirq()    (softirq_count() || (current->flags & PF_SOFTIRQ))
+#else
+#define in_irq()		(hardirq_count())
+#define in_softirq()		(softirq_count())
+#endif
+#define in_interrupt()		(irq_count())
+
+
+#define hardirq_trylock()	(!in_interrupt())
+#define hardirq_endlock()	do { } while (0)
+
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -57,5 +75,55 @@ do {									\
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
+
+#ifndef CONFIG_INGO_IRQ_THREADS
+
+#if !defined(CONFIG_SMP) && !defined(CONFIG_IRQ_THREADS)
+# define synchronize_irq(irq)	barrier()
+#else
+  extern void synchronize_irq(unsigned int irq);
+#endif /* CONFIG_SMP */
+
+#else
+static inline void synchronize_irq(unsigned int irq)
+{
+        generic_synchronize_irq(irq);
+}
+
+static inline void free_irq(unsigned int irq, void *dev_id)
+{
+        generic_free_irq(irq, dev_id);
+}
+
+static inline void disable_irq_nosync(unsigned int irq)
+{
+        generic_disable_irq_nosync(irq);
+}
+
+static inline void disable_irq(unsigned int irq)
+{
+        generic_disable_irq(irq);
+}
+
+static inline void enable_irq(unsigned int irq)
+{
+        generic_enable_irq(irq);
+}
+
+static inline int setup_irq(unsigned int irq, struct irqaction *new)
+{
+        return generic_setup_irq(irq, new);
+}
+#endif /* CONFIG_INGO_IRQ_THREADS */
+
 
 #endif /* __ASM_HARDIRQ_H */
+
+
+
+
+
+
diff -pruN a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
--- a/include/asm-i386/hw_irq.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/asm-i386/hw_irq.h	2004-10-09 04:01:36.000000000 +0400
@@ -54,6 +54,9 @@ void make_8259A_irq(unsigned int irq);
 void init_8259A(int aeoi);
 void FASTCALL(send_IPI_self(int vector));
 void init_VISWS_APIC_irqs(void);
+#ifdef CONFIG_INGO_IRQ_THREADS
+extern void init_hardirqs(void);
+#endif
 void setup_IO_APIC(void);
 void disable_IO_APIC(void);
 void print_IO_APIC(void);
@@ -78,4 +81,7 @@ static inline void hw_resend_irq(struct 
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 #endif
 
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_descp(irq) (irq_desc + (irq))
+
 #endif /* _ASM_HW_IRQ_H */
diff -pruN a/include/asm-i386/irq.h b/include/asm-i386/irq.h
--- a/include/asm-i386/irq.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/asm-i386/irq.h	2004-10-09 04:01:36.000000000 +0400
@@ -20,10 +20,12 @@ static __inline__ int irq_canonicalize(i
 {
 	return ((irq == 2) ? 9 : irq);
 }
-
+#ifndef CONFIG_INGO_IRQ_THREADS
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
+#endif
+
 extern void release_x86_irqs(struct task_struct *);
 extern int can_request_irq(unsigned int, unsigned long flags);
 
diff -pruN a/include/asm-i386/signal.h b/include/asm-i386/signal.h
--- a/include/asm-i386/signal.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/asm-i386/signal.h	2004-10-09 04:01:36.000000000 +0400
@@ -121,6 +121,12 @@ typedef unsigned long sigset_t;
  */
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
+#define SA_NOTHREAD             0x01000000
+#ifdef CONFIG_INGO_IRQ_THREADS
+#define SA_NODELAY              0x02000000
+#undef SA_NOTHREAD
+#define SA_NOTHREAD		SA_NODELAY
+#endif
 #define SA_SHIRQ		0x04000000
 #endif
 
diff -pruN a/include/linux/hardirq.h b/include/linux/hardirq.h
--- a/include/linux/hardirq.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/linux/hardirq.h	2004-10-09 04:01:36.000000000 +0400
@@ -23,24 +23,18 @@
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
  */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
 #ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
+# if defined CONFIG_INGO_BKL
+       /* lock_depth is not incremented if BKL is a mutex */
+#  define in_atomic() ((preempt_count() & ~PREEMPT_ACTIVE) != 0)
+# else
+#  define in_atomic() ((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
+# endif
 # define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
-# define in_atomic()	(preempt_count() != 0)
+# define in_atomic()    (preempt_count() != 0)
 # define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-
-#ifdef CONFIG_SMP
-extern void synchronize_irq(unsigned int irq);
-#else
-# define synchronize_irq(irq)	barrier()
-#endif
-
 #endif /* LINUX_HARDIRQ_H */
diff -pruN a/include/linux/interrupt.h b/include/linux/interrupt.h
--- a/include/linux/interrupt.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/linux/interrupt.h	2004-10-09 04:01:36.000000000 +0400
@@ -39,6 +39,10 @@ struct irqaction {
 	cpumask_t mask;
 	const char *name;
 	void *dev_id;
+#ifdef CONFIG_INGO_IRQ_THREADS
+        int irq;
+        struct proc_dir_entry *dir, *threaded;
+#endif
 	struct irqaction *next;
 };
 
@@ -51,7 +55,7 @@ extern void free_irq(unsigned int, void 
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) && !defined(CONFIG_IRQ_THREADS)
 # define cli()			local_irq_disable()
 # define sti()			local_irq_enable()
 # define save_flags(x)		local_save_flags(x)
@@ -60,6 +64,8 @@ extern void free_irq(unsigned int, void 
 #endif
 
 /* SoftIRQ primitives.  */
+#ifndef CONFIG_SOFTIRQ_THREADS
+
 #define local_bh_disable() \
 		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
 #define __local_bh_enable() \
@@ -67,6 +73,27 @@ extern void free_irq(unsigned int, void 
 
 extern void local_bh_enable(void);
 
+#else
+
+/* As far as I can tell, local_bh_disable() didn't stop ksoftirqd
+   from running before.  Since all softirqs now run from one of
+   the ksoftirqds, this shouldn't be necessary. */
+
+static inline void local_bh_disable(void)
+{
+}
+
+static inline void __local_bh_enable(void)
+{
+}
+
+static inline void local_bh_enable(void)
+{
+}
+
+#endif
+
+
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
    frequency threaded job scheduling. For almost all the purposes
    tasklets are more than enough. F.e. all serial device BHs et
@@ -92,6 +119,10 @@ struct softirq_action
 	void	(*action)(struct softirq_action *);
 	void	*data;
 };
+#ifdef CONFIG_INGO_IRQ_THREADS
+extern void do_hardirq(irq_desc_t *desc);
+extern void wakeup_irqd(void);
+#endif
 
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
@@ -147,6 +178,7 @@ enum
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
+
 #ifdef CONFIG_SMP
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
diff -pruN a/include/linux/irq.h b/include/linux/irq.h
--- a/include/linux/irq.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/linux/irq.h	2004-10-09 04:01:36.000000000 +0400
@@ -7,6 +7,9 @@
  * within this file.
  *
  * Thanks. --rmk
+ *
+ *  2004-07-16 Modified by Eugeny S. Mints for RT Prototype.
+ *             RT Prototype 2004 (C) MontaVista Software, Inc.
  */
 
 #include <linux/config.h>
@@ -32,6 +35,26 @@
 #define IRQ_LEVEL	64	/* IRQ level triggered */
 #define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
 #define IRQ_PER_CPU	256	/* IRQ is per CPU */
+#ifndef CONFIG_INGO_IRQ_THREADS
+#define IRQ_THREAD         512   /* IRQ has at least one threaded handler */
+#else
+#define IRQ_NODELAY 512     /* IRQ must run immediately */
+#endif
+
+#define IRQ_NOTHREAD       1024  /* IRQ has at least one nonthreaded handler */
+#define IRQ_THREADPENDING  2048  /* IRQ thread has been woken */
+#define IRQ_THREADRUNNING  4096  /* IRQ thread is currently running */
+
+/* Nobody has yet handled this IRQ.  This is set when ack() is called,
+   and checked when end() is called.  It is done this way to accomodate
+   threaded and non-threaded IRQs sharing the same IRQ. */
+
+#define IRQ_UNHANDLED      8192
+
+/* The interrupt is supposed to be enabled, but the IRQ thread hasn't
+   been spawned yet.  Call startup_irq() once the thread is spawned. */
+
+#define IRQ_DELAYEDSTARTUP 16384
 
 /*
  * Interrupt controller descriptor. This is all we need
@@ -64,17 +87,58 @@ typedef struct irq_desc {
 	unsigned int depth;		/* nested irq disables */
 	unsigned int irq_count;		/* For detecting broken interrupts */
 	unsigned int irqs_unhandled;
+        /* 
+         * this lock is used from a real interrupt context (do_IRQ) even if
+         * irqs in threads patch is employed.
+         */
 	spinlock_t lock;
+
+#if defined CONFIG_INGO_IRQ_THREADS || defined CONFIG_IRQ_THREADS
+        struct task_struct *thread;
+# ifdef CONFIG_IRQ_THREADS
+	wait_queue_head_t sync;
+# endif
+#endif
 } ____cacheline_aligned irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
-
+#ifndef CONFIG_INGO_IRQ_THREADS
 extern int setup_irq(unsigned int , struct irqaction * );
+#else
+extern int generic_redirect_hardirq(struct irq_desc *desc);
+extern asmlinkage int generic_handle_IRQ_event(unsigned int irq, struct pt_regs *regs, struct irqaction *action);
+extern void generic_synchronize_irq(unsigned int irq);
+extern int generic_setup_irq(unsigned int irq, struct irqaction * new);
+extern void generic_free_irq(unsigned int irq, void *dev_id);
+extern void generic_disable_irq_nosync(unsigned int irq);
+extern void generic_disable_irq(unsigned int irq);
+extern void generic_enable_irq(unsigned int irq);
+extern void generic_note_interrupt(int irq, irq_desc_t *desc, int action_ret);
+
+extern int noirqdebug;
+#endif
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 
-#endif
+#ifdef CONFIG_IRQ_THREADS
+void spawn_irq_threads(void);
+void setup_irq_spawn_thread(unsigned int irq, struct irqaction *new);
+unsigned int it_startup_irq(unsigned int irq);
+void it_shutdown_irq(unsigned int irq);
+#define STARTUP_IRQ(irq) it_startup_irq(irq)
+#define SHUTDOWN_IRQ(irq) it_shutdown_irq(irq)
+#else
+#define setup_irq_spawn_thread(irq, new)
+#define STARTUP_IRQ(irq) desc->handler->startup(irq)
+#define SHUTDOWN_IRQ(irq) desc->handler->shutdown(irq)
+#endif /* CONFIG_IRQ_THREADS */
+
+
+
+
+
+#endif /* CONFIG_ARCH_S390 */
 
 #endif /* __irq_h */
diff -pruN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/linux/sched.h	2004-10-09 04:01:36.000000000 +0400
@@ -178,6 +178,9 @@ extern int in_sched_functions(unsigned l
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+struct timeout;
+#define	MAX_SCHEDULE_TIMEOUT_EXT ((struct timeout *) ~0)
+extern void FASTCALL(schedule_timeout_ext (const struct timeout *timeout));
 asmlinkage void schedule(void);
 
 struct namespace;
@@ -216,7 +219,6 @@ struct mm_struct {
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
 	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
-
 	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
@@ -260,7 +262,7 @@ struct sighand_struct {
 };
 
 /*
- * NOTE! "signal_struct" does not have it's own
+ * NOTE! "signal_struct" des not have it's own
  * locking, because a shared signal_struct always
  * implies a shared sighand_struct, so locking
  * sighand_struct is always a proper superset of
@@ -328,9 +330,10 @@ struct signal_struct {
  */
 
 #define MAX_USER_RT_PRIO	100
-#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define MAX_RT_PRIO		100 /* MAX_USER_RT_PRIO */
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define BOTTOM_PRIO            INT_MAX
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
 
@@ -443,7 +446,7 @@ struct task_struct {
 
 	int lock_depth;		/* Lock depth */
 
-	int prio, static_prio;
+	int prio, static_prio, boost_prio;
 	struct list_head run_list;
 	prio_array_t *array;
 
@@ -454,6 +457,9 @@ struct task_struct {
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
+#ifdef CONFIG_INGO_BKL
+	cpumask_t saved_cpus_allowed;
+#endif
 	unsigned int time_slice, first_time_slice;
 
 #ifdef CONFIG_SCHEDSTATS
@@ -559,7 +565,13 @@ struct task_struct {
 	spinlock_t proc_lock;
 /* context-switch lock */
 	spinlock_t switch_lock;
-
+/*
+ * current io wait handle: wait queue entry to use for io waits
+ * If this thread is processing aio, this points at the waitqueue
+ * inside the currently handled kiocb. It may be NULL (i.e. default
+ * to a stack based synchronous wait) if its doing sync IO.
+ */
+	wait_queue_t *io_wait;
 /* journalling filesystem info */
 	void *journal_info;
 
@@ -573,13 +585,7 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
-/*
- * current io wait handle: wait queue entry to use for io waits
- * If this thread is processing aio, this points at the waitqueue
- * inside the currently handled kiocb. It may be NULL (i.e. default
- * to a stack based synchronous wait) if its doing sync IO.
- */
-	wait_queue_t *io_wait;
+
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
@@ -613,6 +619,12 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FLUSHER	0x00002000	/* responsible for disk writeback */
 
+
+/* Thread is an IRQ handler.  This is used to determine which softirq
+   thread to wake. */
+
+#define PF_IRQHANDLER 0x10000000
+
 #define PF_FREEZE	0x00004000	/* this task should be frozen for suspend */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
@@ -621,6 +633,13 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#ifdef CONFIG_INGO_IRQ_THREADS
+#define PF_SOFTIRQ      0x00400000      /* softirq context */
+#define PF_HARDIRQ      0x00800000      /* hardirq context */
+#endif
+
+#define PF_ADD_TO_HEAD  0x40000000
+#define PF_MUTEX_INTERRUPTIBLE 0x20000000
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
@@ -695,6 +714,7 @@ extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
+extern int try_to_wake_up(struct task_struct *p, unsigned int state, int sync);
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 extern void FASTCALL(wake_up_new_task(struct task_struct * tsk,
@@ -880,6 +900,9 @@ static inline int thread_group_empty(tas
 	return list_empty(&p->pids[PIDTYPE_TGID].pid_list);
 }
 
+asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
+                                       struct sched_param __user *param);
+
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
 
diff -pruN a/include/linux/smp_lock.h b/include/linux/smp_lock.h
--- a/include/linux/smp_lock.h	2004-10-09 03:50:45.000000000 +0400
+++ b/include/linux/smp_lock.h	2004-10-09 04:01:36.000000000 +0400
@@ -7,12 +7,17 @@
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 
-extern spinlock_t kernel_flag;
-
-#define kernel_locked()		(current->lock_depth >= 0)
-
-#define get_kernel_lock()	spin_lock(&kernel_flag)
-#define put_kernel_lock()	spin_unlock(&kernel_flag)
+# ifdef CONFIG_INGO_BKL
+   extern int kernel_locked(void);
+   extern void lock_kernel(void);
+   extern void unlock_kernel(void);
+# else
+
+#  define kernel_locked()	(current->lock_depth >= 0)
+
+#  define get_kernel_lock()	_spin_lock(&kernel_flag)
+#  define put_kernel_lock()	_spin_unlock(&kernel_flag)
+   extern spinlock_t kernel_flag;
 
 /*
  * Release global kernel lock.
@@ -53,14 +58,18 @@ static inline void unlock_kernel(void)
 	if (likely(--current->lock_depth < 0))
 		put_kernel_lock();
 }
+# endif /* !INGO's BKL */
 
 #else
 
-#define lock_kernel()				do { } while(0)
-#define unlock_kernel()				do { } while(0)
-#define release_kernel_lock(task)		do { } while(0)
-#define reacquire_kernel_lock(task)		do { } while(0)
-#define kernel_locked()				1
+# define lock_kernel() 				do { } while(0)
+# define unlock_kernel()			do { } while(0)
+# define kernel_locked()			1
+
+# ifndef CONFIG_INGO_BKL
+#  define release_kernel_lock(task)		do { } while(0)
+#  define reacquire_kernel_lock(task)		do { } while(0)
+# endif /* INGO's BKL */
 
 #endif /* CONFIG_SMP || CONFIG_PREEMPT */
 #endif /* __LINUX_SMPLOCK_H */
diff -pruN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2004-10-09 03:50:45.000000000 +0400
+++ b/init/Kconfig	2004-10-09 04:01:36.000000000 +0400
@@ -224,6 +224,30 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
+config INGO_BKL
+	bool "Replace the BKL with a sleeping lock"
+	default y 
+	---help---
+	   Uses Ingo Molnars code to replace the BKL with
+	   a semaphore.
+
+choice
+        prompt "Select lock"
+	depends on INGO_BKL 
+	default BKL_SEM
+
+config BKL_SEM
+	bool "BKL becomes the system semaphore."
+	---help---
+	  Use the system semaphore to replace the BKL instead of
+	  the kmutex.
+
+config BKL_MTX
+        bool "BKL becomes a mutex"
+        ---help---
+          Use the kmutex to replace the BKL instead of
+          the system semaphore.
+endchoice
 
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
@@ -280,6 +304,40 @@ config EPOLL
 
 source "drivers/block/Kconfig.iosched"
 
+config SOFTIRQ_THREADS
+	bool "Run all softirqs in threads"
+	default y
+	depends on PREEMPT
+	help
+	  This option creates a second softirq thread per CPU, which
+	  runs at high real-time priority, to replace the softirqs
+	  which were previously run immediately.  This allows these
+	  softirqs to be prioritized, so as to avoid preempting
+	  very high priority real-time tasks.  This also allows
+	  certain spinlocks to be converted into sleeping mutexes,
+	  for futher reduction of scheduling latency.
+
+config INGO_IRQ_THREADS
+	bool "Support for Ingo Molnar's version of IRQ Threads." 
+	default y
+	depends on !IRQ_THREADS && SOFTIRQ_THREADS
+	help
+	  Interrupts are redirected to high priority threads.
+
+
+config IRQ_THREADS
+	bool "Run all IRQs in threads by default"
+	depends on PREEMPT && SOFTIRQ_THREADS
+	help
+	  This option creates a thread for each IRQ, which runs at
+	  high real-time priority, unless the SA_NOTHREAD option is
+	  passed to request_irq().  This allows these IRQs to be
+	  prioritized, so as to avoid preempting very high priority
+	  real-time tasks.  This also allows certain spinlocks to be
+	  converted into sleeping mutexes, for futher reduction of
+	  scheduling latency (however, this is not done automatically).
+
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
 	default y if ARM || H8300
@@ -389,3 +447,5 @@ config STOP_MACHINE
 	help
 	  Need stop_machine() primitive.
 endmenu
+
+
diff -pruN a/init/main.c b/init/main.c
--- a/init/main.c	2004-10-09 03:50:45.000000000 +0400
+++ b/init/main.c	2004-10-09 04:01:36.000000000 +0400
@@ -42,6 +42,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/irq.h>
 #include <linux/unistd.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
@@ -435,6 +436,9 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
+#ifdef CONFIG_INGO_BKL
+	preempt_enable_no_resched();
+#endif
  	cpu_idle();
 } 
 
@@ -493,13 +497,21 @@ asmlinkage void __init start_kernel(void
 	 * printk() and can access its per-cpu storage.
 	 */
 	smp_prepare_boot_cpu();
-
 	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
 	 * timer interrupt). Full topology setup happens at smp_init()
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+#ifdef CONFIG_INGO_BKL
+	/*
+	* The early boot stage up until we run the first idle thread
+	* is a very volatile affair for the scheduler. Disable preemption
+	* up until the init thread has been started:
+	*/
+	preempt_disable();
+#endif
+
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
@@ -680,6 +692,10 @@ static inline void fixup_cpu_present_map
 
 static int init(void * unused)
 {
+#ifdef CONFIG_IRQ_THREADS
+	spawn_irq_threads();
+#endif
+
 	lock_kernel();
 	/*
 	 * Tell the world that we're going to be the grim
diff -pruN a/kernel/hardirq.c b/kernel/hardirq.c
--- a/kernel/hardirq.c	1970-01-01 03:00:00.000000000 +0300
+++ b/kernel/hardirq.c	2004-10-09 04:01:36.000000000 +0400
@@ -0,0 +1,697 @@
+/*
+ * linux/kernel/hardirq.c
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/kallsyms.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_INGO_IRQ_THREADS
+extern struct irq_desc irq_desc[NR_IRQS];
+
+static struct proc_dir_entry * root_irq_dir;
+static struct proc_dir_entry * irq_dir [NR_IRQS];
+
+int noirqdebug;
+static void register_irq_proc (unsigned int irq);
+static void register_handler_proc (unsigned int irq, struct irqaction *action);
+static int start_irq_thread(int irq, struct irq_desc *desc);
+
+int generic_redirect_hardirq(struct irq_desc *desc)
+{
+	/*
+	 * Direct execution:
+	 */
+        if ((desc->status & IRQ_NODELAY))
+		return 0;
+
+	BUG_ON(!desc->thread);
+	BUG_ON(!irqs_disabled());
+	if (desc->thread->state != TASK_RUNNING)
+		wake_up_process(desc->thread);
+
+	return 1;
+}
+
+/*
+ * This should really return information about whether
+ * we should do bottom half handling etc. Right now we
+ * end up _always_ checking the bottom half, which is a
+ * waste of time and is not what some drivers would
+ * prefer.
+ */
+asmlinkage int generic_handle_IRQ_event(unsigned int irq,
+		struct pt_regs *regs, struct irqaction *action)
+{
+	int status = 1;	/* Force the "do bottom halves" bit */
+	int retval = 0;
+
+	if (!(action->flags & SA_INTERRUPT))
+		local_irq_enable();
+
+	do {
+		status |= action->flags;
+		retval |= action->handler(irq, action->dev_id, regs);
+		action = action->next;
+	} while (action);
+	if (status & SA_SAMPLE_RANDOM)
+		add_interrupt_randomness(irq);
+	local_irq_disable();
+	return retval;
+}
+
+void do_hardirq(struct irq_desc *desc)
+{
+	struct irqaction * action;
+	unsigned int irq = desc - irq_desc, count;
+
+	local_irq_disable();
+
+repeat:
+	count = 0;
+	while (desc->status & IRQ_INPROGRESS) {
+		action = desc->action;
+		count++;
+		spin_lock(&desc->lock);
+		for (;;) {
+			irqreturn_t action_ret = 0;
+
+			if (action) {
+				spin_unlock(&desc->lock);
+				action_ret = generic_handle_IRQ_event(irq, NULL,action);
+				spin_lock_irq(&desc->lock);
+			}
+			if (!noirqdebug)
+				generic_note_interrupt(irq, desc, action_ret);
+			if (likely(!(desc->status & IRQ_PENDING)))
+				break;
+			desc->status &= ~IRQ_PENDING;
+		}
+		desc->status &= ~IRQ_INPROGRESS;
+		/*
+		 * The ->end() handler has to deal with interrupts which got
+		 * disabled while the handler was running.
+		 */
+		desc->handler->end(irq);
+		spin_unlock(&desc->lock);
+	}
+
+	if (count)
+		goto repeat;
+
+	local_irq_enable();
+}
+
+
+static void __report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	struct irqaction *action;
+
+	if (action_ret != IRQ_HANDLED && action_ret != IRQ_NONE) {
+		printk(KERN_ERR "irq event %d: bogus return value %x\n",
+				irq, action_ret);
+	} else {
+		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
+	}
+	dump_stack();
+	printk(KERN_ERR "handlers:\n");
+	action = desc->action;
+	while (action) {
+		printk(KERN_ERR "[<%p>]", action->handler);
+		print_symbol(" (%s)",
+			(unsigned long)action->handler);
+		printk("\n");
+		action = action->next;
+	}
+}
+
+static void report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	static int count = 100;
+
+	if (count) {
+		count--;
+		__report_bad_irq(irq, desc, action_ret);
+	}
+}
+
+
+static int __init noirqdebug_setup(char *str)
+{
+	noirqdebug = 1;
+	printk("IRQ lockup detection disabled\n");
+	return 1;
+}
+
+__setup("noirqdebug", noirqdebug_setup);
+
+/*
+ * If 99,900 of the previous 100,000 interrupts have not been handled then
+ * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try to
+ * turn the IRQ off.
+ *
+ * (The other 100-of-100,000 interrupts may have been a correctly-functioning
+ *  device sharing an IRQ with the failing one)
+ *
+ * Called under desc->lock
+ */
+void generic_note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	if (action_ret != IRQ_HANDLED) {
+		desc->irqs_unhandled++;
+		if (action_ret != IRQ_NONE)
+			report_bad_irq(irq, desc, action_ret);
+	}
+
+	desc->irq_count++;
+	if (desc->irq_count < 100000)
+		return;
+
+	desc->irq_count = 0;
+	if (desc->irqs_unhandled > 99900) {
+		/*
+		 * The interrupt is stuck
+		 */
+		__report_bad_irq(irq, desc, action_ret);
+		/*
+		 * Now kill the IRQ
+		 */
+		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	desc->irqs_unhandled = 0;
+}
+
+void generic_synchronize_irq(unsigned int irq)
+{
+	while (irq_desc[irq].status & IRQ_INPROGRESS) {
+		cpu_relax();
+		do_hardirq(irq_desc + irq);
+	}
+}
+
+EXPORT_SYMBOL(generic_synchronize_irq);
+
+/*
+ * Generic enable/disable code: this just calls
+ * down into the PIC-specific version for the actual
+ * hardware disable after having gotten the irq
+ * controller lock.
+ */
+
+/**
+ *	disable_irq_nosync - disable an irq without waiting
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Disables and Enables are
+ *	nested.
+ *	Unlike disable_irq(), this function does not ensure existing
+ *	instances of the IRQ handler have completed before returning.
+ *
+ *	This function may be called from IRQ context.
+ */
+
+void generic_disable_irq_nosync(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	if (!desc->depth++) {
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(generic_disable_irq_nosync);
+
+/**
+ *	disable_irq - disable an irq and wait for completion
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Enables and Disables are
+ *	nested.
+ *	This function waits for any pending IRQ handlers for this interrupt
+ *	to complete before returning. If you use this function while
+ *	holding a resource the IRQ handler may need you will deadlock.
+ *
+ *	This function may be called - with care - from IRQ context.
+ */
+
+void generic_disable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	generic_disable_irq_nosync(irq);
+	if (desc->action)
+		synchronize_irq(irq);
+}
+
+EXPORT_SYMBOL(generic_disable_irq);
+
+/**
+ *	enable_irq - enable handling of an irq
+ *	@irq: Interrupt to enable
+ *
+ *	Undoes the effect of one call to disable_irq().  If this
+ *	matches the last disable, processing of interrupts on this
+ *	IRQ line is re-enabled.
+ *
+ *	This function may be called from IRQ context.
+ */
+
+void generic_enable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	switch (desc->depth) {
+	case 1: {
+		unsigned int status = desc->status & ~IRQ_DISABLED;
+		desc->status = status;
+		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
+			desc->status = status | IRQ_REPLAY;
+			hw_resend_irq(desc->handler,irq);
+		}
+		desc->handler->enable(irq);
+		/* fall-through */
+	}
+	default:
+		desc->depth--;
+		break;
+	case 0:
+		printk("enable_irq(%u) unbalanced from %p\n", irq,
+		       __builtin_return_address(0));
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(generic_enable_irq);
+
+/*
+ * If any action has SA_NODELAY then turn IRQ_NODELAY on:
+ */
+static void recalculate_desc_flags(struct irq_desc *desc)
+{
+	struct irqaction *action;
+
+	desc->status &= ~IRQ_NODELAY;
+	for (action = desc->action ; action; action = action->next)
+		if (action->flags & SA_NODELAY)
+			desc->status |= IRQ_NODELAY;
+}
+
+int generic_setup_irq(unsigned int irq, struct irqaction * new)
+{
+	int shared = 0;
+	unsigned long flags;
+	struct irqaction *old, **p;
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (desc->handler == &no_irq_type)
+		return -ENOSYS;
+	/*
+	 * Some drivers like serial.c use request_irq() heavily,
+	 * so we have to be careful not to interfere with a
+	 * running system.
+	 */
+	if (new->flags & SA_SAMPLE_RANDOM) {
+		/*
+		 * This function might sleep, we want to call it first,
+		 * outside of the atomic block.
+		 * Yes, this might clear the entropy pool if the wrong
+		 * driver is attempted to be loaded, without actually
+		 * installing a new handler, but is this really a problem,
+		 * only the sysadmin is able to do this.
+		 */
+		rand_initialize_irq(irq);
+	}
+
+	if (!(new->flags & SA_NODELAY))
+		if (start_irq_thread(irq, desc))
+			return -ENOMEM;
+	/*
+	 * The following block of code has to be executed atomically
+	 */
+	spin_lock_irqsave(&desc->lock,flags);
+	p = &desc->action;
+	if ((old = *p) != NULL) {
+		/* Can't share interrupts unless both agree to */
+		if (!(old->flags & new->flags & SA_SHIRQ)) {
+			spin_unlock_irqrestore(&desc->lock,flags);
+			return -EBUSY;
+		}
+
+		/* add new interrupt at end of irq queue */
+		do {
+			p = &old->next;
+			old = *p;
+		} while (old);
+		shared = 1;
+	}
+
+	*p = new;
+
+	/*
+	 * Propagate any possible SA_NODELAY flag into IRQ_NODELAY:
+	 */
+	recalculate_desc_flags(desc);
+
+	if (!shared) {
+		desc->depth = 0;
+		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
+		desc->handler->startup(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock,flags);
+
+	new->irq = irq;
+	register_irq_proc(irq);
+	new->dir = new->threaded = NULL;
+	register_handler_proc(irq, new);
+
+	return 0;
+}
+
+/**
+ *	generic_free_irq - free an interrupt
+ *	@irq: Interrupt line to free
+ *	@dev_id: Device identity to free
+ *
+ *	Remove an interrupt handler. The handler is removed and if the
+ *	interrupt line is no longer in use by any driver it is disabled.
+ *	On a shared IRQ the caller must ensure the interrupt is disabled
+ *	on the card it drives before calling this function. The function
+ *	does not return until any executing interrupts for this IRQ
+ *	have completed.
+ *
+ *	This function must not be called from interrupt context.
+ */
+
+void generic_free_irq(unsigned int irq, void *dev_id)
+{
+	struct irq_desc *desc;
+	struct irqaction **p;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS)
+		return;
+
+	desc = irq_desc + irq;
+	spin_lock_irqsave(&desc->lock,flags);
+	p = &desc->action;
+	for (;;) {
+		struct irqaction * action = *p;
+		if (action) {
+			struct irqaction **pp = p;
+			p = &action->next;
+			if (action->dev_id != dev_id)
+				continue;
+
+			/* Found it - now remove it from the list of entries */
+			*pp = action->next;
+			if (!desc->action) {
+				desc->status |= IRQ_DISABLED;
+				desc->handler->shutdown(irq);
+			}
+			recalculate_desc_flags(desc);
+			spin_unlock_irqrestore(&desc->lock,flags);
+			if (action->threaded)
+				remove_proc_entry(action->threaded->name, action->dir);
+			if (action->dir)
+				remove_proc_entry(action->dir->name, irq_dir[irq]);
+
+			/* Wait to make sure it's not being used on another CPU */
+			synchronize_irq(irq);
+			kfree(action);
+			return;
+		}
+		printk("Trying to free free IRQ%d\n",irq);
+		spin_unlock_irqrestore(&desc->lock,flags);
+		return;
+	}
+}
+
+EXPORT_SYMBOL(generic_free_irq);
+
+
+#ifdef CONFIG_SMP
+extern cpumask_t irq_affinity[NR_IRQS];
+#endif
+
+static int do_irqd(void * __desc)
+{
+	struct irq_desc *desc = __desc;
+	int irq = desc - irq_desc;
+#ifdef CONFIG_SMP
+	cpumask_t mask = irq_affinity[irq];
+
+	set_cpus_allowed(current, mask);
+#endif
+	current->flags |= PF_NOFREEZE | PF_HARDIRQ;
+
+	set_user_nice(current, -10);
+
+	printk("IRQ#%d thread started up.\n", irq);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		do_hardirq(desc);
+#ifdef CONFIG_SMP
+		/*
+		 * Did IRQ affinities change?
+		 */
+		if (!cpus_equal(mask, irq_affinity[irq])) {
+			mask = irq_affinity[irq];
+			set_cpus_allowed(current, mask);
+		}
+#endif
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static int start_irq_thread(int irq, struct irq_desc *desc)
+{
+	if (desc->thread)
+		return 0;
+
+	printk("requesting new irq thread for IRQ%d...\n", irq);
+	desc->thread = kthread_create(do_irqd, desc, "IRQ %d", irq);
+	if (!desc->thread) {
+		printk(KERN_ERR "irqd: could not create IRQ thread %d!\n", irq);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+
+static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
+
+cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
+
+static int irq_affinity_read_proc(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
+					unsigned long count, void *data)
+{
+	int irq = (long)data, full_count = count, err;
+	cpumask_t new_value, tmp;
+
+	if (!irq_desc[irq].handler->set_affinity)
+		return -EIO;
+
+	err = cpumask_parse(buffer, count, new_value);
+	if (err)
+		return err;
+
+	/*
+	 * Do not allow disabling IRQs completely - it's a too easy
+	 * way to make the system unusable accidentally :-) At least
+	 * one online CPU still has to be targeted.
+	 */
+	cpus_and(tmp, new_value, cpu_online_map);
+	if (cpus_empty(tmp))
+		return -EINVAL;
+
+	irq_affinity[irq] = new_value;
+	irq_desc[irq].handler->set_affinity(irq,
+					cpumask_of_cpu(first_cpu(new_value)));
+
+	return full_count;
+}
+
+#endif
+
+static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
+					unsigned long count, void *data)
+{
+	cpumask_t *mask = (cpumask_t *)data;
+	unsigned long full_count = count, err;
+	cpumask_t new_value;
+
+	err = cpumask_parse(buffer, count, new_value);
+	if (err)
+		return err;
+
+	*mask = new_value;
+	return full_count;
+}
+
+#define MAX_NAMELEN 10
+
+static void register_irq_proc (unsigned int irq)
+{
+	char name [MAX_NAMELEN];
+
+	if (!root_irq_dir || (irq_desc[irq].handler == &no_irq_type) ||
+			irq_dir[irq])
+		return;
+
+	memset(name, 0, MAX_NAMELEN);
+	sprintf(name, "%d", irq);
+
+	/* create /proc/irq/1234 */
+	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
+
+#ifdef CONFIG_SMP
+	{
+		struct proc_dir_entry *entry;
+
+		/* create /proc/irq/1234/smp_affinity */
+		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
+
+		if (entry) {
+			entry->nlink = 1;
+			entry->data = (void *)(long)irq;
+			entry->read_proc = irq_affinity_read_proc;
+			entry->write_proc = irq_affinity_write_proc;
+		}
+
+		smp_affinity_entry[irq] = entry;
+	}
+#endif
+}
+
+#undef MAX_NAMELEN
+
+static int threaded_read_proc (char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	return sprintf(page, "%c\n",
+		((struct irqaction *)data)->flags & SA_NODELAY ? '0' : '1');
+}
+
+static int threaded_write_proc (struct file *file, const char __user *buffer,
+					unsigned long count, void *data)
+{
+	struct irqaction *action = data;
+	irq_desc_t *desc = irq_desc + action->irq;
+	int c;
+
+	if (get_user(c, buffer))
+		return -EFAULT;
+	if (c != '0' && c != '1')
+		return -EINVAL;
+
+	spin_lock_irq(&desc->lock);
+
+	if (c == '0')
+		action->flags |= SA_NODELAY;
+	if (c == '1')
+		action->flags &= ~SA_NODELAY;
+	recalculate_desc_flags(desc);
+
+	spin_unlock_irq(&desc->lock);
+
+	return 1;
+}
+
+
+#define MAX_NAMELEN 128
+
+static void register_handler_proc (unsigned int irq, struct irqaction *action)
+{
+	char name [MAX_NAMELEN];
+	struct proc_dir_entry *entry;
+
+	if (!irq_dir[irq] || action->dir || !action->name)
+		return;
+
+	memset(name, 0, MAX_NAMELEN);
+	snprintf(name, MAX_NAMELEN, "%s", action->name);
+
+	/* create /proc/irq/1234/handler/ */
+	action->dir = proc_mkdir(name, irq_dir[irq]);
+	if (!action->dir)
+		return;
+	/* create /proc/irq/1234/handler/threaded */
+	entry = create_proc_entry("threaded", 0600, action->dir);
+	if (!entry)
+		return;
+	entry->nlink = 1;
+	entry->data = (void *)action;
+	entry->read_proc = threaded_read_proc;
+	entry->write_proc = threaded_write_proc;
+	action->threaded = entry;
+}
+
+
+unsigned long prof_cpu_mask = -1;
+
+void init_irq_proc (void)
+{
+	struct proc_dir_entry *entry;
+	int i;
+
+	/* create /proc/irq */
+	root_irq_dir = proc_mkdir("irq", NULL);
+
+	/* create /proc/irq/prof_cpu_mask */
+	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
+
+	if (!entry)
+	    return;
+
+	entry->nlink = 1;
+	entry->data = (void *)&prof_cpu_mask;
+	entry->read_proc = prof_cpu_mask_read_proc;
+	entry->write_proc = prof_cpu_mask_write_proc;
+
+	/*
+	 * Create entries for all existing IRQs.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		register_irq_proc(i);
+}
+
+#endif /* CONFIG_INGO_IRQ_THREADS */
diff -pruN a/kernel/irq.c b/kernel/irq.c
--- a/kernel/irq.c	1970-01-01 03:00:00.000000000 +0300
+++ b/kernel/irq.c	2004-10-09 04:01:36.000000000 +0400
@@ -0,0 +1,260 @@
+/*
+ *	linux/kernel/irq.c
+ *
+ *	Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
+ * Includes portions of Andrey Panin's IRQ consolidation patches.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/irq.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+#include <asm/pgalloc.h>
+#include <asm/delay.h>
+#include <asm/irq.h>
+
+
+#ifdef CONFIG_IRQ_THREADS
+static const int irq_prio = MAX_USER_RT_PRIO - 9;
+
+static inline void synchronize_hard_irq(unsigned int irq)
+{
+#ifdef CONFIG_SMP
+	while (irq_descp(irq)->status & IRQ_INPROGRESS)
+		cpu_relax();
+#endif
+}
+
+void synchronize_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_descp(irq);
+	
+	synchronize_hard_irq(irq);
+	
+	if (desc->thread)
+		wait_event(desc->sync, !(desc->status & IRQ_THREADRUNNING));
+}
+
+typedef struct {
+	struct semaphore sem;
+	int irq;
+} irq_thread_info;
+
+static int run_irq_thread(void *__info)
+{
+	irq_thread_info *info = __info;
+	int irq = info->irq;
+	struct sched_param param = { .sched_priority = irq_prio };
+	irq_desc_t *desc = irq_descp(irq);
+	
+	daemonize("IRQ %d", irq);
+	
+	set_fs(KERNEL_DS);
+	sys_sched_setscheduler(0, SCHED_FIFO, &param);
+	
+	current->flags |= PF_IRQHANDLER | PF_NOFREEZE;
+	
+	init_waitqueue_head(&desc->sync);
+	smp_wmb();
+	desc->thread = current;
+	
+	spin_lock_irq(&desc->lock);
+	
+	if (desc->status & IRQ_DELAYEDSTARTUP) {
+		desc->status &= ~IRQ_DELAYEDSTARTUP;
+		STARTUP_IRQ(irq);
+	}
+	
+	spin_unlock_irq(&desc->lock);
+	
+	/* Don't reference info after the up(). */
+	up(&info->sem);
+	
+	for (;;) {
+		struct irqaction *action;
+		int status, retval;
+		
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		while (!(desc->status & IRQ_THREADPENDING))
+			schedule();
+		
+		set_current_state(TASK_RUNNING);
+
+		spin_lock_irq(&desc->lock);
+		
+		desc->status |= IRQ_THREADRUNNING;
+		desc->status &= ~IRQ_THREADPENDING;
+		status = desc->status;
+		
+		spin_unlock_irq(&desc->lock);
+		
+		retval = 0;
+		
+		if (!(status & IRQ_DISABLED)) {
+			action = desc->action;
+
+			while (action) {
+				if (!(action->flags & SA_NOTHREAD)) {
+					status |= action->flags;
+					retval |= action->handler(irq, action->dev_id, NULL);
+				}
+				
+				action = action->next;
+			}
+		}
+
+		if (status & SA_SAMPLE_RANDOM)
+			add_interrupt_randomness(irq);
+
+		spin_lock_irq(&desc->lock);
+		
+		
+		desc->status &= ~IRQ_THREADRUNNING;
+		if (!(desc->status & (IRQ_DISABLED | IRQ_INPROGRESS |
+				      IRQ_THREADPENDING | IRQ_THREADRUNNING))) {
+		  desc->handler->end(irq);
+		}
+		
+		spin_unlock_irq(&desc->lock);
+		
+		if (waitqueue_active(&desc->sync))
+			wake_up(&desc->sync);
+	}
+}
+
+static int ok_to_spawn_threads;
+
+void do_spawn_irq_thread(int irq)
+{
+	irq_thread_info info;
+	
+	info.irq = irq;
+	sema_init(&info.sem, 0);
+
+	if (kernel_thread(run_irq_thread, &info, CLONE_KERNEL) < 0) {
+		printk(KERN_EMERG "Could not spawn thread for IRQ %d\n", irq);
+	} else {
+		/* This assumes that up() doesn't touch the semaphore
+		   at all after down() returns... */
+		
+		down(&info.sem);
+	}
+}
+
+void setup_irq_spawn_thread(unsigned int irq, struct irqaction *new)
+{
+	irq_desc_t *desc = irq_descp(irq);
+	int spawn_thread = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	
+	if (new->flags & SA_NOTHREAD) {
+		desc->status |= IRQ_NOTHREAD;
+	} else {
+		/* Only the first threaded handler should spawn
+		   a thread. */
+
+		if (!(desc->status & IRQ_THREAD)) {
+			spawn_thread = 1;
+			desc->status |= IRQ_THREAD;
+		}
+	}
+
+	spin_unlock_irqrestore(&desc->lock, flags);
+	
+	if (ok_to_spawn_threads && spawn_thread)
+		do_spawn_irq_thread(irq);
+}
+
+
+/* This takes care of interrupts that were requested before the
+   scheduler was ready for threads to be created. */
+
+void spawn_irq_threads(void)
+{
+	int i;
+	
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_descp(i);
+	
+		if (desc->action && !desc->thread && (desc->status & IRQ_THREAD))
+			do_spawn_irq_thread(i);
+	}
+	
+	ok_to_spawn_threads = 1;
+}
+
+/*
+ * Workarounds for interrupt types without startup()/shutdown() (ppc, ppc64).
+ * Will be removed some day.
+ */
+
+unsigned int it_startup_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_descp(irq);
+
+#ifdef CONFIG_IRQ_THREADS
+	if ((desc->status & IRQ_THREAD) && !desc->thread) {
+		/* The IRQ threads haven't been spawned yet.  Don't
+		   turn on the IRQ until that happens. */
+		
+		desc->status |= IRQ_DELAYEDSTARTUP;
+		return 0;
+	}
+#endif
+
+	if (desc->handler->startup)
+		return desc->handler->startup(irq);
+	else if (desc->handler->enable)
+		desc->handler->enable(irq);
+	else 
+		BUG();
+	return 0;
+}
+
+void it_shutdown_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_descp(irq);
+
+#ifdef CONFIG_IRQ_THREADS
+	if (desc->status & IRQ_DELAYEDSTARTUP) {
+		desc->status &= ~IRQ_DELAYEDSTARTUP;
+		return;
+	}
+#endif
+
+	if (desc->handler->shutdown)
+		desc->handler->shutdown(irq);
+	else if (desc->handler->disable)
+		desc->handler->disable(irq);
+	else 
+		BUG();
+}
+
+#endif
diff -pruN a/kernel/kthread.c b/kernel/kthread.c
--- a/kernel/kthread.c	2004-10-09 03:50:45.000000000 +0400
+++ b/kernel/kthread.c	2004-10-09 04:01:36.000000000 +0400
@@ -14,6 +14,14 @@
 #include <linux/module.h>
 #include <asm/semaphore.h>
 
+#ifdef CONFIG_INGO_IRQ_THREADS
+/*
+ * We dont want to execute off keventsd since it might
+ * hold a semaphore our callers hold too:
+ */
+static struct workqueue_struct *helper_wq;
+#endif
+
 struct kthread_create_info
 {
 	/* Information passed to kthread() from keventd. */
@@ -126,12 +134,23 @@ struct task_struct *kthread_create(int (
 	init_completion(&create.started);
 	init_completion(&create.done);
 
+#ifdef CONFIG_INGO_IRQ_THREADS
+        /*
+         * The workqueue needs to start up first:
+         */
+        if (!helper_wq)
+#else
 	/* If we're being called to start the first workqueue, we
 	 * can't use keventd. */
 	if (!keventd_up())
+#endif
 		work.func(work.data);
 	else {
-		schedule_work(&work);
+#ifdef CONFIG_INGO_IRQ_THREADS
+                queue_work(helper_wq, &work);
+#else
+                schedule_work(&work);
+#endif
 		wait_for_completion(&create.done);
 	}
 	if (!IS_ERR(create.result)) {
@@ -183,3 +202,20 @@ int kthread_stop(struct task_struct *k)
 	return ret;
 }
 EXPORT_SYMBOL(kthread_stop);
+
+#ifdef CONFIG_INGO_IRQ_THREADS
+static __init int helper_init(void)
+{
+        helper_wq = create_singlethread_workqueue("kthread");
+        BUG_ON(!helper_wq);
+
+        return 0;
+}
+core_initcall(helper_init);
+#endif
+
+
+
+
+
+
diff -pruN a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-10-09 03:50:45.000000000 +0400
+++ b/kernel/Makefile	2004-10-09 04:01:36.000000000 +0400
@@ -3,11 +3,11 @@
 #
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
-	    exit.o itimer.o time.o softirq.o resource.o \
+	    exit.o itimer.o time.o softirq.o hardirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o irq.o 
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
@@ -25,6 +25,7 @@ obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 
+
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
diff -pruN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-10-09 03:50:45.000000000 +0400
+++ b/kernel/sched.c	2004-10-09 04:01:36.000000000 +0400
@@ -450,6 +450,19 @@ static runqueue_t *task_rq_lock(task_t *
 	struct runqueue *rq;
 
 repeat_lock_task:
+	/* Note this potential BUG::
+         * Mutex substitution maps spin_unlock_irqrestore 
+         * to a simple spin_unlock. If we substituted 
+         * a mutex here, we would save flags and disable
+         * ints, but the spin_unlock_irqrestore call wouldn't
+         * unlock irqs because of the remapping .
+	 * Since we are not substitutinng mutexes for
+         * rq lock we are ok, BUT its edemic of problems
+	 * we could encounter elsewhere in the kernel.
+         * This type of construct should be rewritten 
+	 * using a local_irq_restore following the spin_unlock() 
+	 * to be mutex-substitution-safe */
+
 	local_irq_save(*flags);
 	rq = task_rq(p);
 	spin_lock(&rq->lock);
@@ -1118,7 +1131,7 @@ static inline int wake_idle(int cpu, tas
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync)
+int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
 	int cpu, this_cpu, success = 0;
 	unsigned long flags;
@@ -2620,6 +2633,136 @@ static inline int dependent_sleeper(int 
 }
 #endif
 
+#if defined(CONFIG_INGO_BKL)
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+/*
+ * The 'big kernel semaphore'
+ *
+ * This mutex is taken and released recursively by lock_kernel()
+ * and unlock_kernel().Â  It is transparently dropped and reaquired
+ * over schedule().Â  It is used to protect legacy code that hasn't
+ * been migrated to a proper locking design yet.
+ *
+ * Note: code locked by this semaphore will only be serialized against
+ * other code using the same locking facility. The code guarantees that
+ * the task remains on the same CPU.
+ *
+ * Don't use in new code.
+ */
+#ifdef CONFIG_BKL_SEM
+static __cacheline_aligned_in_smp DECLARE_MUTEX(kernel_sem);
+#else 
+kmutex_t kernel_flag __cacheline_aligned_in_smp = KMUTEX_INIT;
+#endif
+
+int kernel_locked(void)
+{
+	return current->lock_depth >= 0;
+}
+
+EXPORT_SYMBOL(kernel_locked);
+
+static inline void put_kernel_sem(void)
+{
+	current->cpus_allowed = current->saved_cpus_allowed;
+#ifdef CONFIG_BKL_SEM
+	up(&kernel_sem);
+#else
+	kmutex_unlock(&kernel_flag);
+#endif
+}
+
+/*
+ * Release global kernel semaphore:
+ */
+static inline void release_kernel_sem(struct task_struct *task)
+{
+	if (unlikely(task->lock_depth >= 0))
+		put_kernel_sem();
+}
+
+/*
+ * Re-acquire the kernel semaphore.
+ *
+ * This function is called with preemption off.
+ *
+ * We are executing in schedule() so the code must be extremely careful
+ * about recursion, both due to the down() and due to the enabling of
+ * preemption. schedule() will re-check the preemption flag after
+ * reacquiring the semaphore.
+ */
+static inline void reacquire_kernel_sem(struct task_struct *task)
+{
+	int this_cpu, saved_lock_depth = task->lock_depth;
+
+	if (likely(saved_lock_depth < 0))
+		return;
+
+	task->lock_depth = -1;
+	preempt_enable_no_resched();
+
+#ifdef CONFIG_BKL_SEM
+	down(&kernel_sem);
+#else
+	kmutex_lock(&kernel_flag);
+#endif
+	this_cpu = get_cpu();
+	/*
+	* Magic. We can pin the task to this CPU safely and
+	* cheaply here because we have preemption disabled
+	* and we are obviously running on the current CPU:
+	*/
+	current->saved_cpus_allowed = current->cpus_allowed;
+	current->cpus_allowed = cpumask_of_cpu(this_cpu);
+	task->lock_depth = saved_lock_depth;
+}
+
+/*
+ * Getting the big kernel semaphore.
+ */
+void lock_kernel(void)
+{
+	int this_cpu, depth = current->lock_depth + 1;
+
+	if (likely(!depth)) {
+		/*
+		* No recursion worries - we set up lock_depth _after_
+		*/
+#ifdef CONFIG_BKL_SEM
+		down(&kernel_sem);
+#else
+		kmutex_lock(&kernel_flag);
+#endif
+		this_cpu = get_cpu();
+		current->saved_cpus_allowed = current->cpus_allowed;
+		current->cpus_allowed = cpumask_of_cpu(this_cpu);
+		current->lock_depth = depth;
+		put_cpu();
+	} else
+	current->lock_depth = depth;
+}
+
+EXPORT_SYMBOL(lock_kernel);
+
+void unlock_kernel(void)
+{
+	BUG_ON(current->lock_depth < 0);
+
+	if (likely(--current->lock_depth < 0))
+	put_kernel_sem();
+}
+
+EXPORT_SYMBOL(unlock_kernel);
+
+#else
+
+static inline void release_kernel_sem(struct task_struct *task) { }
+static inline void reacquire_kernel_sem(struct task_struct *task) { }
+
+#endif
+#endif /* INGO's BKL */
+
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -2645,12 +2788,15 @@ asmlinkage void __sched schedule(void)
 			dump_stack();
 		}
 	}
-
 need_resched:
 	preempt_disable();
 	prev = current;
 	rq = this_rq();
-
+#ifdef CONFIG_INGO_BKL
+	release_kernel_sem(prev);
+#else
+	release_kernel_lock(prev);
+#endif
 	/*
 	 * The idle thread is not allowed to schedule!
 	 * Remove this check after it has been exercised a bit.
@@ -2660,8 +2806,8 @@ need_resched:
 		dump_stack();
 	}
 
-	release_kernel_lock(prev);
 	schedstat_inc(rq, sched_cnt);
+	
 	now = sched_clock();
 	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
 		run_time = now - prev->timestamp;
@@ -2781,7 +2927,11 @@ switch_tasks:
 	} else
 		spin_unlock_irq(&rq->lock);
 
+#ifdef CONFIG_INGO_BKL
+	reacquire_kernel_sem(current);
+#else
 	reacquire_kernel_lock(current);
+#endif
 	preempt_enable_no_resched();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
@@ -2798,6 +2948,9 @@ EXPORT_SYMBOL(schedule);
 asmlinkage void __sched preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
+#ifdef CONFIG_INGO_BKL
+	int saved_lock_depth;
+#endif
 
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
@@ -2808,7 +2961,19 @@ asmlinkage void __sched preempt_schedule
 
 need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
+#ifdef CONFIG_INGO_BKL
+	/*
+	* We keep the big kernel semaphore locked, but we
+	* clear ->lock_depth so that schedule() doesnt
+	* auto-release the semaphore:
+	*/
+	saved_lock_depth = current->lock_depth;
+	current->lock_depth = 0;
 	schedule();
+	current->lock_depth = saved_lock_depth;
+#else
+       schedule();
+#endif
 	ti->preempt_count = 0;
 
 	/* we could miss a preemption opportunity between schedule and now */
@@ -3790,7 +3955,7 @@ void __devinit init_idle(task_t *idle, i
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
-#ifdef CONFIG_PREEMPT
+#if defined CONFIG_PREEMPT && !defined CONFIG_INGO_BKL
 	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
 #else
 	idle->thread_info->preempt_count = 0;
@@ -3839,13 +4004,23 @@ int set_cpus_allowed(task_t *p, cpumask_
 	migration_req_t req;
 	runqueue_t *rq;
 
+#ifdef CONFIG_INGO_BKL
+	lock_kernel();
+#endif
 	rq = task_rq_lock(p, &flags);
+
 	if (!cpus_intersects(new_mask, cpu_online_map)) {
+#ifdef CONFIG_INGO_BKL
+		unlock_kernel();
+#endif
 		ret = -EINVAL;
 		goto out;
 	}
 
 	p->cpus_allowed = new_mask;
+#ifdef CONFIG_INGO_BKL
+        unlock_kernel();
+#endif
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpu_isset(task_cpu(p), new_mask))
 		goto out;
@@ -4205,8 +4380,11 @@ int __init migration_init(void)
  *
  * Note: spinlock debugging needs this even on !CONFIG_SMP.
  */
+#if !defined(CONFIG_INGO_BKL) 
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(kernel_flag);
+#endif
+
 
 #ifdef CONFIG_SMP
 /* Attach the domain 'sd' to 'cpu' as its base domain */
@@ -4766,3 +4944,23 @@ void __might_sleep(char *file, int line)
 }
 EXPORT_SYMBOL(__might_sleep);
 #endif
+
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+/*
+ * This could be a long-held lock.  If another CPU holds it for a long time,
+ * and that CPU is not asked to reschedule then *this* CPU will spin on the
+ * lock for a long time, even if *this* CPU is asked to reschedule.
+ *
+ * So what we do here, in the slow (contended) path is to spin on the lock by
+ * hand while permitting preemption.
+ *
+ * Called inside preempt_disable().
+ */
+
+/* these functions are only called from inside spin_lock
+ * and old_write_lock therefore under spinlock substitution 
+ * they will only be passed old spinlocks or old rwlocks as parameter 
+ * there are no issues with modified mutex behavior here. */
+
+#endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
diff -pruN a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	2004-10-09 03:50:45.000000000 +0400
+++ b/kernel/softirq.c	2004-10-09 04:01:36.000000000 +0400
@@ -16,6 +16,12 @@
 #include <linux/cpu.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_SOFTIRQ_THREADS
+static const int softirq_prio = MAX_USER_RT_PRIO - 8;
+#endif
+ 
 
 #include <asm/irq.h>
 /*
@@ -45,6 +51,10 @@ static struct softirq_action softirq_vec
 
 static DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+static DEFINE_PER_CPU(struct task_struct *, ksoftirqd_high_prio);
+#endif
+
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
@@ -56,10 +66,25 @@ static inline void wakeup_softirqd(void)
 	/* Interrupts are disabled: no need to stop preemption */
 	struct task_struct *tsk = __get_cpu_var(ksoftirqd);
 
-	if (tsk && tsk->state != TASK_RUNNING)
+	if (tsk && (tsk->state != TASK_RUNNING && 
+		    tsk->state != TASK_UNINTERRUPTIBLE))
 		wake_up_process(tsk);
 }
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+
+static inline void wakeup_softirqd_high_prio(void)
+{
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd_high_prio);
+
+	if (tsk && (tsk->state != TASK_RUNNING && 
+		    tsk->state != TASK_UNINTERRUPTIBLE))
+		wake_up_process(tsk);
+}
+
+#endif
+
 /*
  * We restart softirq processing MAX_SOFTIRQ_RESTART times,
  * and we fall back to softirqd after that.
@@ -118,8 +143,13 @@ asmlinkage void do_softirq(void)
 	__u32 pending;
 	unsigned long flags;
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+	if (in_interrupt())
+		BUG();
+#else
 	if (in_interrupt())
 		return;
+#endif
 
 	local_irq_save(flags);
 
@@ -135,17 +165,20 @@ EXPORT_SYMBOL(do_softirq);
 
 #endif
 
+#ifndef CONFIG_SOFTIRQ_THREADS
+
 void local_bh_enable(void)
 {
 	__local_bh_enable();
 	WARN_ON(irqs_disabled());
-	if (unlikely(!in_interrupt() &&
-		     local_softirq_pending()))
+	if (unlikely(!in_interrupt() && local_softirq_pending()))
 		invoke_softirq();
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(local_bh_enable);
 
+#endif
+
 /*
  * This function must run with irqs disabled!
  */
@@ -162,8 +195,19 @@ inline fastcall void raise_softirq_irqof
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
+#ifdef CONFIG_SOFTIRQ_THREADS
+
+	if (in_interrupt() || (current->flags & PF_IRQHANDLER))
+		wakeup_softirqd_high_prio();
+	else
+		wakeup_softirqd();
+
+#else
+
 	if (!in_interrupt())
 		wakeup_softirqd();
+
+#endif
 }
 
 EXPORT_SYMBOL(raise_softirq_irqoff);
@@ -319,6 +363,47 @@ void tasklet_kill(struct tasklet_struct 
 
 EXPORT_SYMBOL(tasklet_kill);
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+ 
+static int ksoftirqd_high_prio(void *__bind_cpu)
+{
+	int cpu = (int)(long)__bind_cpu;
+	struct sched_param param = { .sched_priority = softirq_prio };
+
+	/* Yuck.  Thanks for separating the implementation from the
+	   user API. */
+
+	set_fs(KERNEL_DS);
+	sys_sched_setscheduler(0, SCHED_FIFO, &param);
+	
+	current->flags |= PF_NOFREEZE;  /* PF_IOTHREAD in < 2.6.5 */
+
+	/* Migrate to the right CPU */
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	BUG_ON(smp_processor_id() != cpu);
+
+	__set_current_state(TASK_INTERRUPTIBLE);
+	mb();
+
+	__get_cpu_var(ksoftirqd_high_prio) = current;
+
+	for (;;) {
+		if (!local_softirq_pending())
+			schedule();
+
+		__set_current_state(TASK_RUNNING);
+
+		while (local_softirq_pending()) {
+ 			do_softirq();
+			cond_resched();
+		}
+
+		__set_current_state(TASK_INTERRUPTIBLE);
+	}
+}
+
+#endif
+
 void __init softirq_init(void)
 {
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
@@ -430,15 +515,28 @@ static int __devinit cpu_callback(struct
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/l%d", hotcpu);
 		if (IS_ERR(p)) {
-			printk("ksoftirqd for %i failed\n", hotcpu);
+			printk("ksoftirqd/l%i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
 		kthread_bind(p, hotcpu);
   		per_cpu(ksoftirqd, hotcpu) = p;
+#ifdef CONFIG_SOFTIRQ_THREADS
+		p = kthread_create(ksoftirqd_high_prio, hcpu, "ksoftirqd/h%d", hotcpu);
+		if (IS_ERR(p)) {
+			printk("ksoftirqd/h%i failed\n", hotcpu);
+			return NOTIFY_BAD;
+		}
+		per_cpu(ksoftirqd_high_prio, hotcpu) = p;
+		kthread_bind(p, hotcpu);
+  		per_cpu(ksoftirqd_high_prio, hotcpu) = p;
+#endif
  		break;
 	case CPU_ONLINE:
+#ifdef CONFIG_SOFTIRQ_THREADS
+		wake_up_process(per_cpu(ksoftirqd_high_prio, hotcpu));
+#endif
 		wake_up_process(per_cpu(ksoftirqd, hotcpu));
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
diff -pruN a/Makefile b/Makefile
--- a/Makefile	2004-10-09 03:51:27.000000000 +0400
+++ b/Makefile	2004-10-09 04:01:36.000000000 +0400
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 9
-EXTRAVERSION = -rc3
+EXTRAVERSION = -rc3-RT
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*
diff -pruN a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	2004-10-09 03:50:45.000000000 +0400
+++ b/mm/slab.c	2004-10-09 04:01:36.000000000 +0400
@@ -2730,6 +2730,10 @@ static void drain_array_locked(kmem_cach
 static void cache_reap(void *unused)
 {
 	struct list_head *walk;
+#if DEBUG && !defined(CONFIG_SOFTIRQ_THREADS)
+       BUG_ON(!in_interrupt());
+       BUG_ON(in_irq());
+#endif
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
diff -pruN a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
--- a/net/ipv4/ipconfig.c	2004-10-09 03:50:45.000000000 +0400
+++ b/net/ipv4/ipconfig.c	2004-10-09 04:01:36.000000000 +0400
@@ -1100,8 +1100,10 @@ static int __init ic_dynamic(void)
 
 		jiff = jiffies + (d->next ? CONF_INTER_TIMEOUT : timeout);
 		while (time_before(jiffies, jiff) && !ic_got_reply) {
-			barrier();
-			cpu_relax();
+			/* need to drop the BKL here to allow preemption. */
+			
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(1);
 		}
 #ifdef IPCONFIG_DHCP
 		/* DHCP isn't done until we get a DHCPACK. */



