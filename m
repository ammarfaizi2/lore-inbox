Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWIHOkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWIHOkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 10:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWIHOkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 10:40:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750750AbWIHOkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 10:40:17 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157713412.31071.82.camel@localhost.localdomain> 
References: <1157713412.31071.82.camel@localhost.localdomain>  <1157672581.22705.345.camel@localhost.localdomain> <20060907133845.5031.87111.stgit@warthog.cambridge.redhat.com> <10468.1157710616@warthog.cambridge.redhat.com> 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org,
       tglx@linutronix.de
Subject: Re: [PATCH] FRV: Use the generic IRQ stuff 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 08 Sep 2006 15:39:31 +0100
Message-ID: <8193.1157726371@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay... I've got some timings for FRV using my non-genirq code and using the
generic IRQ code.

Adding the attached patch (or similar) into the kernel, I see the following
timings:

				do_IRQ->timer_int	timer_int->do_IRQ
			Cache	Cycles	Time		Cycles	Time
	===============	=======	=======================	=====================
	non-genirq	Cold	380	1.1uS		216	600nS
			Warm	114	320nS		96	270nS
	genirq		Cold	503	1.4uS		409	1.1uS
			Warm	87	240nS		99	270nS

The TIMERL counter increments at core clock speed (360MHz), so each cycle is
approx 2.8nS.  Each cycle executes on instruction or one pair of packed
instructions under ideal circumstances.  Misjudged branches cost 4 clock
cycles.

So the genirq patch bites you on a cold cache, probably due to all the little
bits of unpredictable icache it's got to collect (chip ops and suchlike
dangling off function pointers), but wins a bit on the warm cache front.

The genirq timings above are with __do_IRQ() removed from the kernel.

I used gdb to collect the timings.  The times are initially very high, but
quickly settle to constant lower values.

David
---
diff --git a/arch/frv/kernel/irq.c b/arch/frv/kernel/irq.c
index 5ac041c..8bcb980 100644
--- a/arch/frv/kernel/irq.c
+++ b/arch/frv/kernel/irq.c
@@ -134,6 +134,10 @@ static struct irq_chip frv_cpu_pic = {
 	.end		= frv_cpupic_end,
 };
 
+unsigned long irq_entered_at;
+unsigned long irq_handler_entered_at;
+unsigned long irq_exited_at;
+
 /*
  * handles all normal device IRQ's
  * - registers are referred to by the __frame variable (GR28)
@@ -142,9 +146,15 @@ static struct irq_chip frv_cpu_pic = {
  */
 asmlinkage void do_IRQ(void)
 {
+	asm volatile ("bar" ::: "memory");
+	asm volatile ("movsg timerl,%0" : "=r"(irq_entered_at) :: "memory");
 	irq_enter();
 	generic_handle_irq(__get_IRL(), __frame);
 	irq_exit();
+	asm volatile ("bar" ::: "memory");
+	asm volatile ("movsg timerl,%0" : "=r"(irq_exited_at) :: "memory");
+	asm volatile ("bar" ::: "memory");
+	asm volatile ("break" ::: "memory");
 }
 
 /*
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
index 3d0284b..772b409 100644
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -52,12 +52,18 @@ static inline int set_rtc_mmss(unsigned 
 	return -1;
 }
 
+extern unsigned long irq_handler_entered_at;
+
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
 static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
+	asm volatile ("movsg timerl,%0" : "=r"(irq_handler_entered_at) :: "memory");
+	return IRQ_HANDLED;
+
+#if 0
 	/* last time the cmos clock got updated */
 	static long last_rtc_update = 0;
 
@@ -98,6 +104,7 @@ #endif /* CONFIG_HEARTBEAT */
 
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
+#endif
 }
 
 void time_divisor_init(void)

