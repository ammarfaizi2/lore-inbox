Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSKIGry>; Sat, 9 Nov 2002 01:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSKIGrx>; Sat, 9 Nov 2002 01:47:53 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:17423
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264659AbSKIGrw>; Sat, 9 Nov 2002 01:47:52 -0500
Date: Sat, 9 Nov 2002 01:53:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] do_nmi needs irq_enter/irq_exit lovin...
In-Reply-To: <Pine.LNX.4.44.0211082147380.1622-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211090123520.10475-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Linus Torvalds wrote:

> I think it would be cleaner to have the smp_processor_id() within the 
> irq_enter/exit() pair, even if the thing should be safe the way you do it 
> thanks to local interrupts being disabled..

Ok done, but i still think we're not safe, preempt seems to only take into 
account normal interrupts and isn't NMI aware.

e.g.

#define irq_exit()							\
do {									\
		preempt_count() -= IRQ_EXIT_OFFSET;			\
		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
			do_softirq();					\
		preempt_enable_no_resched();				\
} while (0)

That in_interrupt flag wouldn't catch NMI would it? Especially after we 
drop the preempt count. How about an nmi_enter, nmi_exit instead? Plus i 
wouldn't want to start processing softirqs on nmi exit.

Index: linux-2.5.46-bochs/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.46/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 traps.c
--- linux-2.5.46-bochs/arch/i386/kernel/traps.c	5 Nov 2002 01:47:29 -0000	1.1.1.1
+++ linux-2.5.46-bochs/arch/i386/kernel/traps.c	9 Nov 2002 06:31:21 -0000
@@ -526,12 +526,17 @@
  
 asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
 {
-	int cpu = smp_processor_id();
+	int cpu;
 
+	nmi_enter();
+
+	cpu = smp_processor_id();
 	++nmi_count(cpu);
 
 	if (!nmi_callback(regs, cpu))
 		default_do_nmi(regs);
+
+	nmi_exit();
 }
 
 void set_nmi_callback(nmi_callback_t callback)
Index: linux-2.5.46-bochs/include/asm-i386/hardirq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.46/include/asm-i386/hardirq.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 hardirq.h
--- linux-2.5.46-bochs/include/asm-i386/hardirq.h	5 Nov 2002 01:47:19 -0000	1.1.1.1
+++ linux-2.5.46-bochs/include/asm-i386/hardirq.h	9 Nov 2002 06:31:03 -0000
@@ -76,6 +76,7 @@
 #define hardirq_endlock()	do { } while (0)
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define nmi_enter()		(irq_enter())
 
 #if CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
@@ -90,6 +91,12 @@
 		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
 			do_softirq();					\
 		preempt_enable_no_resched();				\
+} while (0)
+
+#define nmi_exit()				\
+do {						\
+	preempt_count() -= IRQ_EXIT_OFFSET;	\
+	preempt_enable_no_resched();		\
 } while (0)
 
 #ifndef CONFIG_SMP

-- 
function.linuxpower.ca


