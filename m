Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRGXLeO>; Tue, 24 Jul 2001 07:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbRGXLeD>; Tue, 24 Jul 2001 07:34:03 -0400
Received: from juicer38.bigpond.com ([139.134.6.95]:53462 "EHLO
	mailin7.bigpond.com") by vger.kernel.org with ESMTP
	id <S263748AbRGXLdq>; Tue, 24 Jul 2001 07:33:46 -0400
Message-Id: <m15Oyat-000CD5C@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness. 
In-Reply-To: Your message of "Mon, 23 Jul 2001 16:29:09 +0200."
             <20010723162909.D822@athlon.random> 
Date: Tue, 24 Jul 2001 19:35:10 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <20010723162909.D822@athlon.random> you write:
> > Why not fix all the cases?  Why have this wierd secret rule that
> > cpu_raise_softirq() should not be called with irqs disabled?
> 
> cpu_raise_softirq _can_ be called with irq disabled too just now, irq
> enabled or disabled has no influence at all on cpu_raise_softirq.

No, you are wrong.  If I do (NOT in a hw interrupt handler):

	local_irq_save(flags);
	...
	cpu_raise_softirq(smp_processor_id(), FOO_SOFTIRQ);
	...
	local_irq_restore(flags);

ksoftirqd won't get woken, and the FOO soft irq won't get run until
the next interrupt comes in.  You solved (horribly) the analagous case
for local_bh_disable/enable, but not this one.

Below as suggested in my previous email (x86 only, untested).  I also
added a couple of comments.  There's still the issue of stack
overflows if you get hit hard enough with interrupts (do_softirq is
exposed to reentry for short periods), but that's separate.

Linus, please consider,
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/arch/i386/kernel/irq.c working-2.4.7-unclean/arch/i386/kernel/irq.c
--- linux-2.4.7-official/arch/i386/kernel/irq.c	Sat Jul  7 07:48:47 2001
+++ working-2.4.7-unclean/arch/i386/kernel/irq.c	Tue Jul 24 17:29:19 2001
@@ -576,6 +576,7 @@
 	unsigned int status;
 
 	kstat.irqs[cpu][irq]++;
+	in_hw_irq(cpu) = 1;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
@@ -633,6 +634,7 @@
 	 */
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
+	in_hw_irq(cpu) = 0;
 
 	if (softirq_pending(cpu))
 		do_softirq();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/include/asm-i386/hardirq.h working-2.4.7-unclean/include/asm-i386/hardirq.h
--- linux-2.4.7-official/include/asm-i386/hardirq.h	Sun Jul 22 13:13:21 2001
+++ working-2.4.7-unclean/include/asm-i386/hardirq.h	Tue Jul 24 18:40:09 2001
@@ -13,6 +13,7 @@
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned int __nmi_count;	/* arch dependent */
+	int __in_hw_irq;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/include/asm-i386/softirq.h working-2.4.7-unclean/include/asm-i386/softirq.h
--- linux-2.4.7-official/include/asm-i386/softirq.h	Sun Jul 22 13:13:21 2001
+++ working-2.4.7-unclean/include/asm-i386/softirq.h	Tue Jul 24 19:07:24 2001
@@ -4,46 +4,15 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define __cpu_bh_enable(cpu) \
+#define cpu_bh_enable(cpu) \
 		do { barrier(); local_bh_count(cpu)--; } while (0)
 #define cpu_bh_disable(cpu) \
 		do { local_bh_count(cpu)++; barrier(); } while (0)
 
 #define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define __local_bh_enable()	__cpu_bh_enable(smp_processor_id())
+#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
-
-/*
- * NOTE: this assembly code assumes:
- *
- *    (char *)&local_bh_count - 8 == (char *)&softirq_pending
- *
- * If you change the offsets in irq_stat then you have to
- * update this code as well.
- */
-#define local_bh_enable()						\
-do {									\
-	unsigned int *ptr = &local_bh_count(smp_processor_id());	\
-									\
-	barrier();							\
-	if (!--*ptr)							\
-		__asm__ __volatile__ (					\
-			"cmpl $0, -8(%0);"				\
-			"jnz 2f;"					\
-			"1:;"						\
-									\
-			".section .text.lock,\"ax\";"			\
-			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
-			"call %c1;"					\
-			"popl %%edx; popl %%ecx; popl %%eax;"		\
-			"jmp 1b;"					\
-			".previous;"					\
-									\
-		: /* no output */					\
-		: "r" (ptr), "i" (do_softirq)				\
-		/* no registers clobbered */ );				\
-} while (0)
 
 #define __cpu_raise_softirq(cpu, nr) __set_bit(nr, &softirq_pending(cpu))
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/include/linux/irq_cpustat.h working-2.4.7-unclean/include/linux/irq_cpustat.h
--- linux-2.4.7-official/include/linux/irq_cpustat.h	Sun Jul 22 13:13:24 2001
+++ working-2.4.7-unclean/include/linux/irq_cpustat.h	Tue Jul 24 18:40:09 2001
@@ -31,6 +31,7 @@
 #define local_bh_count(cpu)	__IRQ_STAT((cpu), __local_bh_count)
 #define syscall_count(cpu)	__IRQ_STAT((cpu), __syscall_count)
 #define ksoftirqd_task(cpu)	__IRQ_STAT((cpu), __ksoftirqd_task)
+#define in_hw_irq(cpu)		__IRQ_STAT((cpu), __in_hw_irq)
   /* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)		/* i386, ia64 */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.7-official/kernel/softirq.c working-2.4.7-unclean/kernel/softirq.c
--- linux-2.4.7-official/kernel/softirq.c	Sun Jul 22 13:13:25 2001
+++ working-2.4.7-unclean/kernel/softirq.c	Tue Jul 24 19:26:03 2001
@@ -68,6 +68,7 @@
 	long flags;
 	__u32 mask;
 
+	/* Prevent reentry: we always hold an irq or bh count */
 	if (in_interrupt())
 		return;
 
@@ -102,8 +103,10 @@
 			mask &= ~pending;
 			goto restart;
 		}
-		__local_bh_enable();
+		local_bh_enable();
 
+		/* More came in while we were processing?  Let
+                   softirqd handle the overload. */
 		if (pending)
 			wakeup_softirqd(cpu);
 	}
@@ -115,16 +118,10 @@
 {
 	__cpu_raise_softirq(cpu, nr);
 
-	/*
-	 * If we're in an interrupt or bh, we're done
-	 * (this also catches bh-disabled code). We will
-	 * actually run the softirq once we return from
-	 * the irq or bh.
-	 *
-	 * Otherwise we wake up ksoftirqd to make sure we
-	 * schedule the softirq soon.
-	 */
-	if (!(local_irq_count(cpu) | local_bh_count(cpu)))
+	/* If we're in an interrupt handler, then softirqs get
+	   processed on the way out.  For all other (rarer) cases,
+	   wake softirqd to deal with it soon. */
+	if (!in_hw_irq(cpu))
 		wakeup_softirqd(cpu);
 }
 
