Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSGDMvi>; Thu, 4 Jul 2002 08:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSGDMvh>; Thu, 4 Jul 2002 08:51:37 -0400
Received: from zeus.kernel.org ([204.152.189.113]:18672 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317402AbSGDMvR> convert rfc822-to-8bit;
	Thu, 4 Jul 2002 08:51:17 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.org
Subject: [PATCH] do_timer api change arch part.
Date: Thu, 4 Jul 2002 14:48:30 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207041448.30242.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is part of the do_timer/update_process_times api change that affects
the architecture files.

blue skies,
  Martin.

diff -urN linux-2.5.24/arch/alpha/kernel/smp.c linux-2.5.24-timer/arch/alpha/kernel/smp.c
--- linux-2.5.24/arch/alpha/kernel/smp.c	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-timer/arch/alpha/kernel/smp.c	Thu Jul  4 13:18:35 2002
@@ -646,7 +646,7 @@
 		   which would be a Bad Thing.  */
 		irq_enter(cpu, RTC_IRQ);
 
-		update_process_times(user);
+		update_process_times(user, user ^ 1);
 
 		data->prof_counter = data->prof_multiplier;
 		irq_exit(cpu, RTC_IRQ);
diff -urN linux-2.5.24/arch/alpha/kernel/time.c linux-2.5.24-timer/arch/alpha/kernel/time.c
--- linux-2.5.24/arch/alpha/kernel/time.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-timer/arch/alpha/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -117,10 +117,11 @@
 	state.partial_tick = delta & ((1UL << FIX_SHIFT) - 1); 
 	nticks = delta >> FIX_SHIFT;
 
-	while (nticks > 0) {
-		do_timer(regs);
-		nticks--;
-	}
+	do_timer(nticks);
+	if (user_mode(regs))
+		update_process_times(nticks, 0);
+	else
+		update_process_times(0, nticks);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.5.24/arch/arm/mach-iop310/iq80310-time.c linux-2.5.24-timer/arch/arm/mach-iop310/iq80310-time.c
--- linux-2.5.24/arch/arm/mach-iop310/iq80310-time.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-timer/arch/arm/mach-iop310/iq80310-time.c	Thu Jul  4 13:18:35 2002
@@ -94,6 +94,7 @@
 static void iq80310_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	volatile u_char *timer_en = (volatile u_char *)IQ80310_TIMER_EN;
+	int user = user_mode(regs);
 
 	/* clear timer interrupt */
 	*timer_en &= ~2;
@@ -113,7 +114,8 @@
 	 *
 	 * -DS
 	 */
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 }
 
 extern unsigned long (*gettimeoffset)(void);
diff -urN linux-2.5.24/arch/cris/kernel/time.c linux-2.5.24-timer/arch/cris/kernel/time.c
--- linux-2.5.24/arch/cris/kernel/time.c	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-timer/arch/cris/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -281,6 +281,8 @@
 static inline void
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	/* acknowledge the timer irq */
 
 #ifdef USE_CASCADE_TIMERS
@@ -304,8 +306,9 @@
 	
 	/* call the real timer interrupt handler */
 
-	do_timer(regs);
-	
+	do_timer(1);
+	update_process_times(user, user ^ 1);
+
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
diff -urN linux-2.5.24/arch/i386/kernel/apic.c linux-2.5.24-timer/arch/i386/kernel/apic.c
--- linux-2.5.24/arch/i386/kernel/apic.c	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-timer/arch/i386/kernel/apic.c	Thu Jul  4 13:18:35 2002
@@ -1038,9 +1038,7 @@
 			prof_old_multiplier[cpu] = prof_counter[cpu];
 		}
 
-#ifdef CONFIG_SMP
-		update_process_times(user);
-#endif
+		update_process_times(user, user ^ 1);
 	}
 
 	/*
diff -urN linux-2.5.24/arch/i386/kernel/time.c linux-2.5.24-timer/arch/i386/kernel/time.c
--- linux-2.5.24/arch/i386/kernel/time.c	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-timer/arch/i386/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -396,6 +396,8 @@
  */
 static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
 		/*
@@ -416,18 +418,21 @@
 	/* Clear the interrupt */
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 #endif
-	do_timer(regs);
+	do_timer(1);
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
  * system, in that case we have to call the local interrupt handler.
  */
 #ifndef CONFIG_X86_LOCAL_APIC
-	if (!user_mode(regs))
+	if (!user)
 		x86_do_profile(regs->eip);
+	update_process_times(user, user ^ 1);
 #else
 	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
+	else
+		update_process_times(user, user ^ 1);
 #endif
 
 	/*
diff -urN linux-2.5.24/arch/ia64/kernel/smp.c linux-2.5.24-timer/arch/ia64/kernel/smp.c
--- linux-2.5.24/arch/ia64/kernel/smp.c	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-timer/arch/ia64/kernel/smp.c	Thu Jul  4 13:18:35 2002
@@ -329,7 +329,7 @@
 
 	if (--local_cpu_data->prof_counter <= 0) {
 		local_cpu_data->prof_counter = local_cpu_data->prof_multiplier;
-		update_process_times(user);
+		update_process_times(user, user ^ 1);
 	}
 }
 
diff -urN linux-2.5.24/arch/ia64/kernel/time.c linux-2.5.24-timer/arch/ia64/kernel/time.c
--- linux-2.5.24/arch/ia64/kernel/time.c	Fri Jun 21 00:53:47 2002
+++ linux-2.5.24-timer/arch/ia64/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -151,6 +151,7 @@
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long new_itm;
+	int user = user_mode(regs);
 
 	new_itm = local_cpu_data->itm_next;
 
@@ -164,7 +165,7 @@
 		 * four so that we can use a prof_shift of 2 to get instruction-level
 		 * instead of just bundle-level accuracy.
 		 */
-		if (!user_mode(regs))
+		if (!user)
 			do_profile(regs->cr_iip + 4*ia64_psr(regs)->ri);
 
 #ifdef CONFIG_SMP
@@ -180,7 +181,10 @@
 			 * xtime_lock.
 			 */
 			write_lock(&xtime_lock);
-			do_timer(regs);
+			do_timer(1);
+#ifndef CONFIG_SMP
+			update_process_times(user, user ^ 1);
+#endif
 			local_cpu_data->itm_next = new_itm;
 			write_unlock(&xtime_lock);
 		} else
diff -urN linux-2.5.24/arch/m68k/kernel/time.c linux-2.5.24-timer/arch/m68k/kernel/time.c
--- linux-2.5.24/arch/m68k/kernel/time.c	Fri Jun 21 00:53:47 2002
+++ linux-2.5.24-timer/arch/m68k/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -59,10 +59,12 @@
 {
 	/* last time the cmos clock got updated */
 	static long last_rtc_update=0;
+	int user = user_mode(regs);
 
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 
-	if (!user_mode(regs))
+	if (!user)
 		do_profile(regs->pc);
 
 	/*
diff -urN linux-2.5.24/arch/m68k/sun3/sun3ints.c linux-2.5.24-timer/arch/m68k/sun3/sun3ints.c
--- linux-2.5.24/arch/m68k/sun3/sun3ints.c	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-timer/arch/m68k/sun3/sun3ints.c	Thu Jul  4 13:18:35 2002
@@ -77,6 +77,8 @@
 
 static void sun3_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
+	int user = user_mode(regs);
+
         kstat.irqs[0][SYS_IRQS + irq]++;
 #ifdef CONFIG_SUN3
 	intersil_clear();
@@ -86,7 +88,8 @@
 #ifdef CONFIG_SUN3
 	intersil_clear();
 #endif
-        do_timer(fp);
+        do_timer(1);
+	update_process_times(user, user ^ 1);
         if(!(kstat.irqs[0][SYS_IRQS + irq] % 20))
                 sun3_leds(led_pattern[(kstat.irqs[0][SYS_IRQS+irq]%160)
                 /20]);
diff -urN linux-2.5.24/arch/mips/au1000/common/time.c linux-2.5.24-timer/arch/mips/au1000/common/time.c
--- linux-2.5.24/arch/mips/au1000/common/time.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-timer/arch/mips/au1000/common/time.c	Thu Jul  4 13:18:35 2002
@@ -63,13 +63,15 @@
 void mips_timer_interrupt(struct pt_regs *regs)
 {
 	int irq = 7;
+	int user = user_mode(regs);
 
 	if (r4k_offset == 0)
 		goto null;
 
 	do {
 		kstat.irqs[0][irq]++;
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 		r4k_cur += r4k_offset;
 		ack_r4ktimer(r4k_cur);
 
diff -urN linux-2.5.24/arch/mips/baget/time.c linux-2.5.24-timer/arch/mips/baget/time.c
--- linux-2.5.24/arch/mips/baget/time.c	Fri Jun 21 00:53:41 2002
+++ linux-2.5.24-timer/arch/mips/baget/time.c	Thu Jul  4 13:18:35 2002
@@ -49,9 +49,12 @@
 
 void static timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
+	int user = user_mode(regs);
+
 	if (timer_intr_valid()) {
 		sti();
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 	}
 }
 
diff -urN linux-2.5.24/arch/mips/dec/time.c linux-2.5.24-timer/arch/mips/dec/time.c
--- linux-2.5.24/arch/mips/dec/time.c	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-timer/arch/mips/dec/time.c	Thu Jul  4 13:18:35 2002
@@ -329,6 +329,7 @@
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	volatile unsigned char dummy;
+	int user = user_mode(regs);
 
 	dummy = CMOS_READ(RTC_REG_C);	/* ACK RTC Interrupt */
 
@@ -349,7 +350,8 @@
 			atomic_inc((atomic_t *) & prof_buffer[pc]);
 		}
 	}
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.5.24/arch/mips/gt64120/common/gt_irq.c linux-2.5.24-timer/arch/mips/gt64120/common/gt_irq.c
--- linux-2.5.24/arch/mips/gt64120/common/gt_irq.c	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-timer/arch/mips/gt64120/common/gt_irq.c	Thu Jul  4 13:18:35 2002
@@ -106,6 +106,7 @@
 	unsigned int irq_src, int_high_src, irq_src_mask,
 	    int_high_src_mask;
 	int handled;
+	int user = user_mode(regs);
 
 	GT_READ(GT_INTRCAUSE_OFS, &irq_src);
 	GT_READ(GT_INTRMASK_OFS, &irq_src_mask);
@@ -122,7 +123,8 @@
 		handled = 1;
 		irq_src &= ~0x00000800;
 		//    RESET_REG_BITS (INTERRUPT_CAUSE_REGISTER,BIT8);
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 	}
 
 	if (irq_src) {
diff -urN linux-2.5.24/arch/mips/ite-boards/generic/time.c linux-2.5.24-timer/arch/mips/ite-boards/generic/time.c
--- linux-2.5.24/arch/mips/ite-boards/generic/time.c	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-timer/arch/mips/ite-boards/generic/time.c	Thu Jul  4 13:18:35 2002
@@ -119,12 +119,15 @@
  */
 void mips_timer_interrupt(struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	if (r4k_offset == 0)
 		goto null;
 
 	do {
 		kstat.irqs[0][MIPS_CPU_TIMER_IRQ]++;
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 
 		/* Historical comment/code:
  		 * RTC time of day s updated approx. every 11 
diff -urN linux-2.5.24/arch/mips/kernel/old-time.c linux-2.5.24-timer/arch/mips/kernel/old-time.c
--- linux-2.5.24/arch/mips/kernel/old-time.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-timer/arch/mips/kernel/old-time.c	Thu Jul  4 13:18:35 2002
@@ -342,6 +342,7 @@
 static void inline
 timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
+	int user = user_mode(regs);
 #ifdef CONFIG_DDB5074
 	static unsigned cnt, period, dist;
 
@@ -360,7 +361,7 @@
 	     dist = period / 4;
 	}
 #endif
-	if(!user_mode(regs)) {
+	if(!user) {
 		if (prof_buffer && current->pid) {
 			extern int _stext;
 			unsigned long pc = regs->cp0_epc;
@@ -377,7 +378,8 @@
 			atomic_inc((atomic_t *)&prof_buffer[pc]);
 		}
 	}
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.5.24/arch/mips/kernel/time.c linux-2.5.24-timer/arch/mips/kernel/time.c
--- linux-2.5.24/arch/mips/kernel/time.c	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-timer/arch/mips/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -291,6 +291,8 @@
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	if (mips_cpu.options & MIPS_CPU_COUNTER) {
 		unsigned int count;
 
@@ -312,7 +314,7 @@
 
 	}
 
-	if(!user_mode(regs)) {
+	if(!user) {
 		if (prof_buffer && current->pid) {
 			extern int _stext;
 			unsigned long pc = regs->cp0_epc;
@@ -333,7 +335,8 @@
 	/*
 	 * call the generic timer interrupt handling
 	 */
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.5.24/arch/mips/mips-boards/generic/time.c linux-2.5.24-timer/arch/mips/mips-boards/generic/time.c
--- linux-2.5.24/arch/mips/mips-boards/generic/time.c	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-timer/arch/mips/mips-boards/generic/time.c	Thu Jul  4 13:18:35 2002
@@ -134,13 +134,15 @@
 void mips_timer_interrupt(struct pt_regs *regs)
 {
 	int irq = 7;
+	int user = user_mode(regs);
 
 	if (r4k_offset == 0)
 		goto null;
 
 	do {
 		kstat.irqs[0][irq]++;
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 
 		/* Historical comment/code:
  		 * RTC time of day s updated approx. every 11 
diff -urN linux-2.5.24/arch/mips/philips/nino/time.c linux-2.5.24-timer/arch/mips/philips/nino/time.c
--- linux-2.5.24/arch/mips/philips/nino/time.c	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-timer/arch/mips/philips/nino/time.c	Thu Jul  4 13:18:35 2002
@@ -141,6 +141,7 @@
 static void
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+    int user = user_mode(regs);
 #ifdef POLL_STATUS
     static unsigned long old_IntStatus1 = 0;
     static unsigned long old_IntStatus3 = 0;
@@ -158,7 +159,7 @@
 	    SPIData = 0;
 #endif
 
-    if (!user_mode(regs)) {
+    if (!user) {
 	if (prof_buffer && current->pid) {
 	    extern int _stext;
 	    unsigned long pc = regs->cp0_epc;
@@ -179,7 +180,8 @@
     /*
      * aaaand... action!
      */
-    do_timer(regs);
+    do_timer();
+    update_process_times(user, user ^ 1);
 
     /*
      * If we have an externally syncronized Linux clock, then update
diff -urN linux-2.5.24/arch/mips64/mips-boards/generic/time.c linux-2.5.24-timer/arch/mips64/mips-boards/generic/time.c
--- linux-2.5.24/arch/mips64/mips-boards/generic/time.c	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-timer/arch/mips64/mips-boards/generic/time.c	Thu Jul  4 13:18:35 2002
@@ -133,13 +133,17 @@
 void mips_timer_interrupt(struct pt_regs *regs)
 {
 	int irq = 7;
+	int user = user_mode(regs);
 
 	if (r4k_offset == 0)
 		goto null;
 
 	do {
 		kstat.irqs[0][irq]++;
-		do_timer(regs);
+		do_timer(1);
+#ifndef CONFIG_SMP
+		update_process_times(user, user ^ 1);
+#endif
 
 		/* Historical comment/code:
  		 * RTC time of day s updated approx. every 11 
diff -urN linux-2.5.24/arch/mips64/sgi-ip22/ip22-timer.c linux-2.5.24-timer/arch/mips64/sgi-ip22/ip22-timer.c
--- linux-2.5.24/arch/mips64/sgi-ip22/ip22-timer.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-timer/arch/mips64/sgi-ip22/ip22-timer.c	Thu Jul  4 13:18:35 2002
@@ -85,6 +85,7 @@
 {
 	unsigned long count;
 	int irq = 7;
+	int user = user_mode(regs);
 
 	write_lock(&xtime_lock);
 	/* Ack timer and compute new compare. */
@@ -99,7 +100,10 @@
             r4k_cur += r4k_offset;
 	ack_r4ktimer(r4k_cur);
 	kstat.irqs[0][irq]++;
-	do_timer(regs);
+	do_timer(1);
+#ifndef CONFIG_SMP
+	update_process_times(user, user ^ 1);
+#endif
 
 	/* We update the Dallas time of day approx. every 11 minutes,
 	 * because of how the numbers work out we need to make
diff -urN linux-2.5.24/arch/mips64/sgi-ip27/ip27-timer.c linux-2.5.24-timer/arch/mips64/sgi-ip27/ip27-timer.c
--- linux-2.5.24/arch/mips64/sgi-ip27/ip27-timer.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-timer/arch/mips64/sgi-ip27/ip27-timer.c	Thu Jul  4 13:18:35 2002
@@ -106,7 +106,7 @@
 	kstat.irqs[cpu][irq]++;		/* kstat only for bootcpu? */
 
 	if (cpu == 0)
-		do_timer(regs);
+		do_timer(1);
 
 #ifdef CONFIG_SMP
 	{
@@ -119,7 +119,7 @@
 		 * Picked from i386 code.
 		 */
 		irq_enter(cpu, 0);
-		update_process_times(user);
+		update_process_times(user, user ^ 1);
 		irq_exit(cpu, 0);
 	}
 #endif /* CONFIG_SMP */
diff -urN linux-2.5.24/arch/parisc/kernel/time.c linux-2.5.24-timer/arch/parisc/kernel/time.c
--- linux-2.5.24/arch/parisc/kernel/time.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-timer/arch/parisc/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -43,6 +43,7 @@
 	int old;
 	int lost = 0;
 	int cr16;
+	int user = user_mode(regs);
 	
 	old = timer_value;
 
@@ -54,7 +55,10 @@
 
 	mtctl(timer_value ,16);
 
-	do_timer(regs);
+	do_timer(1);
+#ifndef CONFIG_SMP
+	update_process_times(user, user ^ 1);
+#endif
     
 	led_interrupt_func();
 }
diff -urN linux-2.5.24/arch/ppc/kernel/smp.c linux-2.5.24-timer/arch/ppc/kernel/smp.c
--- linux-2.5.24/arch/ppc/kernel/smp.c	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-timer/arch/ppc/kernel/smp.c	Thu Jul  4 13:18:35 2002
@@ -95,9 +95,10 @@
 void smp_local_timer_interrupt(struct pt_regs * regs)
 {
 	int cpu = smp_processor_id();
+	int user = user_mode(regs);
 
 	if (!--prof_counter[cpu]) {
-		update_process_times(user_mode(regs));
+		update_process_times(user, user ^ 1);
 		prof_counter[cpu]=prof_multiplier[cpu];
 	}
 }
diff -urN linux-2.5.24/arch/ppc/kernel/time.c linux-2.5.24-timer/arch/ppc/kernel/time.c
--- linux-2.5.24/arch/ppc/kernel/time.c	Fri Jun 21 00:53:47 2002
+++ linux-2.5.24-timer/arch/ppc/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -157,6 +157,7 @@
 	unsigned long cpu = smp_processor_id();
 	unsigned jiffy_stamp = last_jiffy_stamp(cpu);
 	extern void do_IRQ(struct pt_regs *);
+	int user = user_mode(regs);
 
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
@@ -173,7 +174,10 @@
 		/* We are in an interrupt, no need to save/restore flags */
 		write_lock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
-		do_timer(regs);
+		do_timer(1);
+#ifndef CONFIG_SMP
+		update_process_times(user, user ^ 1);
+#endif
 
 		/*
 		 * update the rtc when needed, this should be performed on the
diff -urN linux-2.5.24/arch/ppc/platforms/iSeries_time.c linux-2.5.24-timer/arch/ppc/platforms/iSeries_time.c
--- linux-2.5.24/arch/ppc/platforms/iSeries_time.c	Fri Jun 21 00:53:49 2002
+++ linux-2.5.24-timer/arch/ppc/platforms/iSeries_time.c	Thu Jul  4 13:18:35 2002
@@ -107,6 +107,8 @@
 	long next_dec;
 	struct Paca * paca;
 	unsigned long cpu = smp_processor_id();
+	int user = user_mode(regs);
+
 	paca = (struct Paca *)mfspr(SPRG1);
 
 	if ( is_soft_enabled() )
@@ -119,7 +121,7 @@
 	
 	hardirq_enter(cpu);
 
-	if (!user_mode(regs))
+	if (!user)
 		ppc_do_profile(instruction_pointer(regs));
 	while ( next_jiffy_update_tb[cpu] < get_tb64() ) {
 #ifdef CONFIG_SMP
@@ -127,7 +129,10 @@
 #endif
 		if ( cpu == 0 ) {
 			write_lock(&xtime_lock);
-			do_timer(regs);
+			do_timer(1);
+#ifndef CONFIG_SMP
+			update_process_times(user, user ^ 1);
+#endif
 			if ( (time_status & STA_UNSYNC) == 0 &&
 				xtime.tv_sec - last_rtc_update >= 659 &&
 				abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
diff -urN linux-2.5.24/arch/ppc64/kernel/smp.c linux-2.5.24-timer/arch/ppc64/kernel/smp.c
--- linux-2.5.24/arch/ppc64/kernel/smp.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-timer/arch/ppc64/kernel/smp.c	Thu Jul  4 13:18:35 2002
@@ -369,8 +369,10 @@
 
 void smp_local_timer_interrupt(struct pt_regs * regs)
 {
+	int user = user_mode(regs);
+
 	if (!--(get_paca()->prof_counter)) {
-		update_process_times(user_mode(regs));
+		update_process_times(user, user ^ 1);
 		(get_paca()->prof_counter)=get_paca()->prof_multiplier;
 	}
 }
diff -urN linux-2.5.24/arch/ppc64/kernel/time.c linux-2.5.24-timer/arch/ppc64/kernel/time.c
--- linux-2.5.24/arch/ppc64/kernel/time.c	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-timer/arch/ppc64/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -255,6 +255,7 @@
 	struct paca_struct *lpaca = get_paca();
 	unsigned long cpu = lpaca->xPacaIndex;
 	struct ItLpQueue * lpq;
+	int user = user_mode(regs);
 
 	irq_enter(cpu);
 
@@ -273,7 +274,10 @@
 		if (cpu == 0) {
 			write_lock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
-			do_timer(regs);
+			do_timer(1);
+#ifndef CONFIG_SMP
+			update_process_times(user, user ^ 1);
+#endif
 			timer_sync_xtime( cur_tb );
 			timer_check_rtc();
 			write_unlock(&xtime_lock);
diff -urN linux-2.5.24/arch/s390/kernel/time.c linux-2.5.24-timer/arch/s390/kernel/time.c
--- linux-2.5.24/arch/s390/kernel/time.c	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-timer/arch/s390/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -151,6 +151,7 @@
 static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
 {
 	int cpu = smp_processor_id();
+	int user = user_mode(regs);
 
 	irq_enter(cpu, 0);
 
@@ -160,18 +161,16 @@
         S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
         asm volatile ("SCKC %0" : : "m" (S390_lowcore.jiffy_timer));
 
-#ifdef CONFIG_SMP
-	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr)
-		write_lock(&xtime_lock);
-
-	update_process_times(user_mode(regs));
+	update_process_times(user, user ^ 1);
 
+#ifdef CONFIG_SMP
 	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr) {
-		do_timer(regs);
+		write_lock(&xtime_lock);
+		do_timer(1);
 		write_unlock(&xtime_lock);
 	}
 #else
-	do_timer(regs);
+	do_timer(regs, 1);
 #endif
 
 	irq_exit(cpu, 0);
diff -urN linux-2.5.24/arch/s390x/kernel/time.c linux-2.5.24-timer/arch/s390x/kernel/time.c
--- linux-2.5.24/arch/s390x/kernel/time.c	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-timer/arch/s390x/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -124,6 +124,7 @@
 static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
 {
 	int cpu = smp_processor_id();
+	int user = user_mode(regs);
 
 	irq_enter(cpu, 0);
 
@@ -133,18 +134,16 @@
         S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
         asm volatile ("SCKC %0" : : "m" (S390_lowcore.jiffy_timer));
 
-#ifdef CONFIG_SMP
-	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr)
-		write_lock(&xtime_lock);
-
-	update_process_times(user_mode(regs));
+	update_process_times(user, user ^ 1);
 
+#ifdef CONFIG_SMP
 	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr) {
-		do_timer(regs);
+		write_lock(&xtime_lock);
+		do_timer(1);
 		write_unlock(&xtime_lock);
 	}
 #else
-	do_timer(regs);
+	do_timer(regs, 1);
 #endif
 
 	irq_exit(cpu, 0);
diff -urN linux-2.5.24/arch/sh/kernel/time.c linux-2.5.24-timer/arch/sh/kernel/time.c
--- linux-2.5.24/arch/sh/kernel/time.c	Fri Jun 21 00:53:41 2002
+++ linux-2.5.24-timer/arch/sh/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -184,9 +184,12 @@
  */
 static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	int user = user_mode(regs);
 
-	if (!user_mode(regs))
+	do_timer(1);
+	update_process_times(user, user ^ 1);
+
+	if (!user)
 		sh_do_profile(regs->pc);
 
 #ifdef CONFIG_HEARTBEAT
diff -urN linux-2.5.24/arch/sparc/kernel/pcic.c linux-2.5.24-timer/arch/sparc/kernel/pcic.c
--- linux-2.5.24/arch/sparc/kernel/pcic.c	Fri Jun 21 00:53:41 2002
+++ linux-2.5.24-timer/arch/sparc/kernel/pcic.c	Thu Jul  4 13:18:35 2002
@@ -746,8 +746,13 @@
 
 static void pcic_timer_handler (int irq, void *h, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	pcic_clear_clock_irq();
-	do_timer(regs);
+	do_timer(1);
+#ifndef CONFIG_SMP
+	update_process_times(user, user ^ 1);
+#endif
 }
 
 #define USECS_PER_JIFFY  10000  /* We have 100HZ "standard" timer for sparc */
diff -urN linux-2.5.24/arch/sparc/kernel/sun4d_smp.c linux-2.5.24-timer/arch/sparc/kernel/sun4d_smp.c
--- linux-2.5.24/arch/sparc/kernel/sun4d_smp.c	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-timer/arch/sparc/kernel/sun4d_smp.c	Thu Jul  4 13:18:35 2002
@@ -460,7 +460,7 @@
 		int user = user_mode(regs);
 
 		irq_enter(cpu, 0);
-		update_process_times(user);
+		update_process_times(user, user ^ 1);
 		irq_exit(cpu, 0);
 
 		prof_counter[cpu] = prof_multiplier[cpu];
diff -urN linux-2.5.24/arch/sparc/kernel/sun4m_smp.c linux-2.5.24-timer/arch/sparc/kernel/sun4m_smp.c
--- linux-2.5.24/arch/sparc/kernel/sun4m_smp.c	Fri Jun 21 00:53:49 2002
+++ linux-2.5.24-timer/arch/sparc/kernel/sun4m_smp.c	Thu Jul  4 13:18:35 2002
@@ -447,7 +447,7 @@
 		int user = user_mode(regs);
 
 		irq_enter(cpu, 0);
-		update_process_times(user);
+		update_process_times(user, user ^ 1);
 		irq_exit(cpu, 0);
 
 		prof_counter[cpu] = prof_multiplier[cpu];
diff -urN linux-2.5.24/arch/sparc/kernel/time.c linux-2.5.24-timer/arch/sparc/kernel/time.c
--- linux-2.5.24/arch/sparc/kernel/time.c	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-timer/arch/sparc/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -118,9 +118,10 @@
 {
 	/* last time the cmos clock got updated */
 	static long last_rtc_update;
+	int user = user_mode(regs);
 
 #ifndef CONFIG_SMP
-	if(!user_mode(regs))
+	if(!user)
 		sparc_do_profile(regs->pc, regs->u_regs[UREG_RETPC]);
 #endif
 
@@ -137,7 +138,10 @@
 
 	write_lock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(1);
+#ifndef CONFIG_SMP
+	update_process_times(user, user ^ 1);
+#endif
 
 	/* Determine when to update the Mostek clock. */
 	if ((time_status & STA_UNSYNC) == 0 &&
diff -urN linux-2.5.24/arch/sparc64/kernel/smp.c linux-2.5.24-timer/arch/sparc64/kernel/smp.c
--- linux-2.5.24/arch/sparc64/kernel/smp.c	Fri Jun 21 00:53:41 2002
+++ linux-2.5.24-timer/arch/sparc64/kernel/smp.c	Thu Jul  4 13:18:35 2002
@@ -1057,7 +1057,7 @@
 				irq_exit(cpu, 0);
 			}
 
-			update_process_times(user);
+			update_process_times(user, user ^ 1);
 
 			prof_counter(cpu) = prof_multiplier(cpu);
 		}
diff -urN linux-2.5.24/arch/sparc64/kernel/time.c linux-2.5.24-timer/arch/sparc64/kernel/time.c
--- linux-2.5.24/arch/sparc64/kernel/time.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-timer/arch/sparc64/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -113,6 +113,7 @@
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	unsigned long ticks, pstate;
+	int user = user_mode(regs);
 
 	write_lock(&xtime_lock);
 
@@ -121,7 +122,10 @@
 		if ((regs->tstate & TSTATE_PRIV) != 0)
 			sparc64_do_profile(regs->tpc, regs->u_regs[UREG_RETPC]);
 #endif
-		do_timer(regs);
+		do_timer(1);
+#ifndef CONFIG_SMP
+		update_process_times(user, user ^ 1);
+#endif
 
 		/* Guarentee that the following sequences execute
 		 * uninterrupted.
@@ -185,7 +189,7 @@
 {
 	write_lock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(regs, 1);
 
 	/*
 	 * Only keep timer_tick_offset uptodate, but don't set TICK_CMPR.
diff -urN linux-2.5.24/arch/x86_64/kernel/apic.c linux-2.5.24-timer/arch/x86_64/kernel/apic.c
--- linux-2.5.24/arch/x86_64/kernel/apic.c	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-timer/arch/x86_64/kernel/apic.c	Thu Jul  4 13:18:35 2002
@@ -1020,7 +1020,7 @@
 		}
 
 #ifdef CONFIG_SMP
-		update_process_times(user);
+		update_process_times(user, user ^ 1);
 #endif
 	}
 
diff -urN linux-2.5.24/arch/x86_64/kernel/time.c linux-2.5.24-timer/arch/x86_64/kernel/time.c
--- linux-2.5.24/arch/x86_64/kernel/time.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-timer/arch/x86_64/kernel/time.c	Thu Jul  4 13:18:35 2002
@@ -253,6 +253,7 @@
  */
 static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
 		/*
@@ -269,18 +270,21 @@
 	}
 #endif
 
-	do_timer(regs);
+	do_timer(1);
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
  * system, in that case we have to call the local interrupt handler.
  */
 #ifndef CONFIG_X86_LOCAL_APIC
-	if (!user_mode(regs))
+	if (!user)
 		x86_do_profile(regs->rip);
+	update_process_times(user, user ^ 1);
 #else
 	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
+	else
+		update_process_times(user, user ^ 1);
 #endif
 
 	/*
diff -urN linux-2.5.24/include/asm-arm/arch-anakin/time.h linux-2.5.24-timer/include/asm-arm/arch-anakin/time.h
--- linux-2.5.24/include/asm-arm/arch-anakin/time.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-anakin/time.h	Thu Jul  4 13:18:35 2002
@@ -17,7 +17,10 @@
 static void
 anakin_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	int user = user_mode(regs);
+
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 }
 
 void __init time_init(void)
diff -urN linux-2.5.24/include/asm-arm/arch-arc/time.h linux-2.5.24-timer/include/asm-arm/arch-arc/time.h
--- linux-2.5.24/include/asm-arm/arch-arc/time.h	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-arc/time.h	Thu Jul  4 13:18:35 2002
@@ -16,7 +16,10 @@
 
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	int user = user_mode(regs);
+
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_set_rtc();
 	do_profile(regs);
 }
diff -urN linux-2.5.24/include/asm-arm/arch-cl7500/time.h linux-2.5.24-timer/include/asm-arm/arch-cl7500/time.h
--- linux-2.5.24/include/asm-arm/arch-cl7500/time.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-cl7500/time.h	Thu Jul  4 13:18:35 2002
@@ -13,7 +13,10 @@
 
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	int user = user_mode(regs);
+
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_set_rtc();
 	do_profile(regs);
 
diff -urN linux-2.5.24/include/asm-arm/arch-clps711x/time.h linux-2.5.24-timer/include/asm-arm/arch-clps711x/time.h
--- linux-2.5.24/include/asm-arm/arch-clps711x/time.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-clps711x/time.h	Thu Jul  4 13:18:35 2002
@@ -27,8 +27,11 @@
  */
 static void p720t_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	do_leds();
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_profile(regs);
 }
 
diff -urN linux-2.5.24/include/asm-arm/arch-ebsa110/time.h linux-2.5.24-timer/include/asm-arm/arch-ebsa110/time.h
--- linux-2.5.24/include/asm-arm/arch-ebsa110/time.h	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-ebsa110/time.h	Thu Jul  4 13:18:35 2002
@@ -23,9 +23,12 @@
 
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	if (ebsa110_reset_timer()) {
 		do_leds();
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 		do_profile(regs);
 	}
 }
diff -urN linux-2.5.24/include/asm-arm/arch-ebsa285/time.h linux-2.5.24-timer/include/asm-arm/arch-ebsa285/time.h
--- linux-2.5.24/include/asm-arm/arch-ebsa285/time.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-ebsa285/time.h	Thu Jul  4 13:18:35 2002
@@ -70,10 +70,13 @@
 
 static void isa_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	if (machine_is_netwinder())
 		do_leds();
 
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_set_rtc();
 	do_profile(regs);
 }
@@ -187,11 +190,14 @@
 
 static void timer1_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	*CSR_TIMER1_CLR = 0;
 
 	/* Do the LEDs things */
 	do_leds();
-	do_timer(regs);
+	do_timer(regs, 1);
+	update_process_times(user, user ^ 1);
 	do_set_rtc();
 	do_profile(regs);
 }
diff -urN linux-2.5.24/include/asm-arm/arch-epxa10db/time.h linux-2.5.24-timer/include/asm-arm/arch-epxa10db/time.h
--- linux-2.5.24/include/asm-arm/arch-epxa10db/time.h	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-epxa10db/time.h	Thu Jul  4 13:18:35 2002
@@ -29,12 +29,14 @@
  */
 static void excalibur_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
 
 	// ...clear the interrupt
 	*TIMER0_CR(IO_ADDRESS(EXC_TIMER00_BASE))|=TIMER0_CR_CI_MSK;
 
 	do_leds();
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1;
 	do_profile(regs);
 }
 
diff -urN linux-2.5.24/include/asm-arm/arch-integrator/time.h linux-2.5.24-timer/include/asm-arm/arch-integrator/time.h
--- linux-2.5.24/include/asm-arm/arch-integrator/time.h	Fri Jun 21 00:53:47 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-integrator/time.h	Thu Jul  4 13:18:35 2002
@@ -101,12 +101,14 @@
 static void integrator_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	volatile TimerStruct_t *timer1 = (volatile TimerStruct_t *)TIMER1_VA_BASE;
+	int user = user_mode(regs);
 
 	// ...clear the interrupt
 	timer1->TimerClear = 1;
 
 	do_leds();
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_profile(regs);
 }
 
diff -urN linux-2.5.24/include/asm-arm/arch-l7200/time.h linux-2.5.24-timer/include/asm-arm/arch-l7200/time.h
--- linux-2.5.24/include/asm-arm/arch-l7200/time.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-l7200/time.h	Thu Jul  4 13:18:35 2002
@@ -44,7 +44,10 @@
  */
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	int user = user_mode(regs);
+
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_profile(regs);
 	RTC_RTCC = 0;				/* Clear interrupt */
 }
diff -urN linux-2.5.24/include/asm-arm/arch-nexuspci/time.h linux-2.5.24-timer/include/asm-arm/arch-nexuspci/time.h
--- linux-2.5.24/include/asm-arm/arch-nexuspci/time.h	Fri Jun 21 00:53:49 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-nexuspci/time.h	Thu Jul  4 13:18:35 2002
@@ -18,6 +18,8 @@
 {
 	static int count = 25;
 	unsigned char stat = __raw_readb(DUART_BASE + 0x14);
+	int user = user_mode(regs);
+
 	if (!(stat & 0x10))
 		return;		/* Not for us */
 
@@ -40,7 +42,8 @@
 	__raw_readb(DUART_BASE + 0x14);
 	__raw_readb(DUART_BASE + 0x14);
 
-	do_timer(regs);	
+	do_timer(1);	
+	update_process_times(user, user ^ 1);
 }
 
 void __init time_init(void)
diff -urN linux-2.5.24/include/asm-arm/arch-pxa/time.h linux-2.5.24-timer/include/asm-arm/arch-pxa/time.h
--- linux-2.5.24/include/asm-arm/arch-pxa/time.h	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-pxa/time.h	Thu Jul  4 13:18:35 2002
@@ -51,6 +51,7 @@
 {
 	long flags;
 	int next_match;
+	int user = user_mode(regs);
 
 	/* Loop until we get ahead of the free running timer.
 	 * This ensures an exact clock tick count and time acuracy.
@@ -62,7 +63,8 @@
 		do_leds();
 		do_set_rtc();
 		local_irq_save( flags );
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 		OSSR = OSSR_M0;  /* Clear match on timer 0 */
 		next_match = (OSMR0 += LATCH);
 		local_irq_restore( flags );
diff -urN linux-2.5.24/include/asm-arm/arch-rpc/time.h linux-2.5.24-timer/include/asm-arm/arch-rpc/time.h
--- linux-2.5.24/include/asm-arm/arch-rpc/time.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-rpc/time.h	Thu Jul  4 13:18:35 2002
@@ -16,7 +16,10 @@
 
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	int user = user_mode(regs);
+
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_set_rtc();
 	do_profile(regs);
 }
diff -urN linux-2.5.24/include/asm-arm/arch-sa1100/time.h linux-2.5.24-timer/include/asm-arm/arch-sa1100/time.h
--- linux-2.5.24/include/asm-arm/arch-sa1100/time.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-sa1100/time.h	Thu Jul  4 13:18:35 2002
@@ -76,11 +76,13 @@
 {
 	unsigned int next_match;
 	unsigned long flags;
+	int user = user_mode(regs);
 
 	do {
 		do_leds();
 		local_irq_save(flags);
-		do_timer(regs);
+		do_timer(1);
+		update_process_times(user, user ^ 1);
 		OSSR = OSSR_M0;  /* Clear match on timer 0 */
 		next_match = (OSMR0 += LATCH);
 		local_irq_restore(flags);
diff -urN linux-2.5.24/include/asm-arm/arch-shark/time.h linux-2.5.24-timer/include/asm-arm/arch-shark/time.h
--- linux-2.5.24/include/asm-arm/arch-shark/time.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-shark/time.h	Thu Jul  4 13:18:35 2002
@@ -15,8 +15,11 @@
 
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	do_leds();
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 	do_profile(regs);
 }
 
diff -urN linux-2.5.24/include/asm-arm/arch-tbox/time.h linux-2.5.24-timer/include/asm-arm/arch-tbox/time.h
--- linux-2.5.24/include/asm-arm/arch-tbox/time.h	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-timer/include/asm-arm/arch-tbox/time.h	Thu Jul  4 13:18:35 2002
@@ -22,11 +22,14 @@
 
 static void timer_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
+	int user = user_mode(regs);
+
 	/* Clear irq */
 	__raw_writel(1, FPGA1CONT + 0xc); 
 	__raw_writel(0, FPGA1CONT + 0xc);
 
-	do_timer(regs);
+	do_timer(1);
+	update_process_times(user, user ^ 1);
 }
 
 void __init time_init(void)

