Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWHPIpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWHPIpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHPIpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:45:23 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:52601 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751013AbWHPIpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:45:19 -0400
Date: Wed, 16 Aug 2006 17:45:13 +0900 (JST)
Message-Id: <20060816.174513.55148016.nemoto@toshiba-tops.co.jp>
To: akpm@osdl.org
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, mm-commits@vger.kernel.org
Subject: Re: -
 simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
 removed from -mm tree
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060816.100750.08077480.nemoto@toshiba-tops.co.jp>
References: <200608141803.k7EI3Plc024729@shell0.pdx.osdl.net>
	<m1veot99ua.fsf@ebiederm.dsl.xmission.com>
	<20060816.100750.08077480.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 10:07:50 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I posted a patch to fix this failure.  Please try with it.  Thanks.
> 
> http://lkml.org/lkml/2006/8/15/135
> 
> I'll cook a new patch including this fix and AVR32 do_timer fix.

This is a replacement of
simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
in 2.6.18-rc4-mm1 tree.  This includes fixes for avr32 and x86_64.


Subject: simplify update_times (avoid jiffies/jiffies_64 aliasing problem)

Pass ticks to do_timer() and update_times(), and adjust x86_64 and s390
timer interrupt handler with this change.

Currently update_times() calculates ticks by "jiffies - wall_jiffies", but
callers of do_timer() should know how many ticks to update.  Passing ticks
get rid of this redundant calculation.  Also there are another redundancy
pointed out by Martin Schwidefsky.

This cleanup make a barrier added by
5aee405c662ca644980c184774277fc6d0769a84 needless.  So this patch removes
it.

As a bonus, this cleanup make wall_jiffies can be removed easily, since now
wall_jiffies is always synced with jiffies.  (This patch does not really
remove wall_jiffies.  It would be another cleanup patch)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff -urNp linux-2.6.18-rc4-mm1.prev/arch/alpha/kernel/time.c linux-2.6.18-rc4-mm1/arch/alpha/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/alpha/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/alpha/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -132,7 +132,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	nticks = delta >> FIX_SHIFT;
 
 	while (nticks > 0) {
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/arm/kernel/time.c linux-2.6.18-rc4-mm1/arch/arm/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/arm/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/arm/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -333,7 +333,7 @@ void timer_tick(struct pt_regs *regs)
 	profile_tick(CPU_PROFILING, regs);
 	do_leds();
 	do_set_rtc();
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/arm26/kernel/time.c linux-2.6.18-rc4-mm1/arch/arm26/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/arm26/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/arm26/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -194,7 +194,7 @@ EXPORT_SYMBOL(do_settimeofday);
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-        do_timer(regs);
+        do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/avr32/kernel/time.c linux-2.6.18-rc4-mm1/arch/avr32/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/avr32/kernel/time.c	2006-08-16 16:55:50.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/avr32/kernel/time.c	2006-08-16 17:27:02.000000000 +0900
@@ -148,7 +148,7 @@ timer_interrupt(int irq, void *dev_id, s
 	 * Call the generic timer interrupt handler
 	 */
 	write_seqlock(&xtime_lock);
-	do_timer(regs);
+	do_timer(1);
 	write_sequnlock(&xtime_lock);
 
 	/*
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/cris/arch-v10/kernel/time.c linux-2.6.18-rc4-mm1/arch/cris/arch-v10/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/cris/arch-v10/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/cris/arch-v10/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -227,7 +227,7 @@ timer_interrupt(int irq, void *dev_id, s
 	
 	/* call the real timer interrupt handler */
 
-	do_timer(regs);
+	do_timer(1);
 	
         cris_do_profile(regs); /* Save profiling information */
 
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/cris/arch-v32/kernel/time.c linux-2.6.18-rc4-mm1/arch/cris/arch-v32/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/cris/arch-v32/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/cris/arch-v32/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -219,7 +219,7 @@ timer_interrupt(int irq, void *dev_id, s
 		return IRQ_HANDLED;
 
 	/* call the real timer interrupt handler */
-	do_timer(regs);
+	do_timer(1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/frv/kernel/time.c linux-2.6.18-rc4-mm1/arch/frv/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/frv/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/frv/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -72,7 +72,7 @@ static irqreturn_t timer_interrupt(int i
 	 */
 	write_seqlock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(1);
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING, regs);
 
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/h8300/kernel/time.c linux-2.6.18-rc4-mm1/arch/h8300/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/h8300/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/h8300/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -40,7 +40,7 @@ static void timer_interrupt(int irq, voi
 	/* may need to kick the hardware timer */
 	platform_timer_eoi();
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/ia64/kernel/time.c linux-2.6.18-rc4-mm1/arch/ia64/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/ia64/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/ia64/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -78,7 +78,7 @@ timer_interrupt (int irq, void *dev_id, 
 			 * xtime_lock.
 			 */
 			write_seqlock(&xtime_lock);
-			do_timer(regs);
+			do_timer(1);
 			local_cpu_data->itm_next = new_itm;
 			write_sequnlock(&xtime_lock);
 		} else
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/m32r/kernel/time.c linux-2.6.18-rc4-mm1/arch/m32r/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/m32r/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/m32r/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -202,7 +202,7 @@ irqreturn_t timer_interrupt(int irq, voi
 #ifndef CONFIG_SMP
 	profile_tick(CPU_PROFILING, regs);
 #endif
-	do_timer(regs);
+	do_timer(1);
 
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/m68k/kernel/time.c linux-2.6.18-rc4-mm1/arch/m68k/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/m68k/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/m68k/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -39,7 +39,7 @@ static inline int set_rtc_mmss(unsigned 
  */
 static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/m68k/sun3/sun3ints.c linux-2.6.18-rc4-mm1/arch/m68k/sun3/sun3ints.c
--- linux-2.6.18-rc4-mm1.prev/arch/m68k/sun3/sun3ints.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/m68k/sun3/sun3ints.c	2006-08-16 17:27:00.000000000 +0900
@@ -65,7 +65,7 @@ static irqreturn_t sun3_int5(int irq, vo
 #ifdef CONFIG_SUN3
 	intersil_clear();
 #endif
-        do_timer(fp);
+        do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(fp));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/m68knommu/kernel/time.c linux-2.6.18-rc4-mm1/arch/m68knommu/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/m68knommu/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/m68knommu/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -51,7 +51,7 @@ static irqreturn_t timer_interrupt(int i
 
 	write_seqlock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/mips/au1000/common/time.c linux-2.6.18-rc4-mm1/arch/mips/au1000/common/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/mips/au1000/common/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/au1000/common/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -96,7 +96,7 @@ void mips_timer_interrupt(struct pt_regs
 		timerlo = count;
 
 		kstat_this_cpu.irqs[irq]++;
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
@@ -137,7 +137,7 @@ irqreturn_t counter0_irq(int irq, void *
 	}
 
 	while (time_elapsed > 0) {
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
@@ -156,7 +156,7 @@ irqreturn_t counter0_irq(int irq, void *
 
 	if (jiffie_drift >= 999) {
 		jiffie_drift -= 999;
-		do_timer(regs); /* increment jiffies by one */
+		do_timer(1); /* increment jiffies by one */
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/mips/galileo-boards/ev96100/time.c linux-2.6.18-rc4-mm1/arch/mips/galileo-boards/ev96100/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/mips/galileo-boards/ev96100/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/galileo-boards/ev96100/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -72,7 +72,7 @@ void mips_timer_interrupt(struct pt_regs
 
 	do {
 		kstat_this_cpu.irqs[irq]++;
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/mips/gt64120/common/time.c linux-2.6.18-rc4-mm1/arch/mips/gt64120/common/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/mips/gt64120/common/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/gt64120/common/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -34,7 +34,7 @@ static void gt64120_irq(int irq, void *d
 	if (irq_src & 0x00000800) {	/* Check for timer interrupt */
 		handled = 1;
 		irq_src &= ~0x00000800;
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/mips/kernel/time.c linux-2.6.18-rc4-mm1/arch/mips/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/mips/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -434,7 +434,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	/*
 	 * call the generic timer interrupt handling
 	 */
-	do_timer(regs);
+	do_timer(1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/mips/momentum/ocelot_g/gt-irq.c linux-2.6.18-rc4-mm1/arch/mips/momentum/ocelot_g/gt-irq.c
--- linux-2.6.18-rc4-mm1.prev/arch/mips/momentum/ocelot_g/gt-irq.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/momentum/ocelot_g/gt-irq.c	2006-08-16 17:27:00.000000000 +0900
@@ -133,7 +133,7 @@ static irqreturn_t gt64240_p0int_irq(int
 		MV_WRITE(TIMER_COUNTER_0_3_INTERRUPT_CAUSE, 0x0);
 
 		/* handle the timer call */
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/mips/sgi-ip27/ip27-timer.c linux-2.6.18-rc4-mm1/arch/mips/sgi-ip27/ip27-timer.c
--- linux-2.6.18-rc4-mm1.prev/arch/mips/sgi-ip27/ip27-timer.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/sgi-ip27/ip27-timer.c	2006-08-16 17:27:00.000000000 +0900
@@ -111,7 +111,7 @@ again:
 	kstat_this_cpu.irqs[irq]++;		/* kstat only for bootcpu? */
 
 	if (cpu == 0)
-		do_timer(regs);
+		do_timer(1);
 
 	update_process_times(user_mode(regs));
 
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/parisc/kernel/time.c linux-2.6.18-rc4-mm1/arch/parisc/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/parisc/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/parisc/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -79,7 +79,7 @@ irqreturn_t timer_interrupt(int irq, voi
 #endif
 		if (cpu == 0) {
 			write_seqlock(&xtime_lock);
-			do_timer(regs);
+			do_timer(1);
 			write_sequnlock(&xtime_lock);
 		}
 	}
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/powerpc/kernel/time.c linux-2.6.18-rc4-mm1/arch/powerpc/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/powerpc/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/powerpc/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -693,7 +693,7 @@ void timer_interrupt(struct pt_regs * re
 		write_seqlock(&xtime_lock);
 		tb_last_jiffy += tb_ticks_per_jiffy;
 		tb_last_stamp = per_cpu(last_jiffy, cpu);
-		do_timer(regs);
+		do_timer(1);
 		timer_recalc_offset(tb_last_jiffy);
 		timer_check_rtc();
 		write_sequnlock(&xtime_lock);
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/ppc/kernel/time.c linux-2.6.18-rc4-mm1/arch/ppc/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/ppc/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/ppc/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -153,7 +153,7 @@ void timer_interrupt(struct pt_regs * re
 		/* We are in an interrupt, no need to save/restore flags */
 		write_seqlock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
-		do_timer(regs);
+		do_timer(1);
 
 		/*
 		 * update the rtc when needed, this should be performed on the
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/s390/kernel/time.c linux-2.6.18-rc4-mm1/arch/s390/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/s390/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/s390/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -166,7 +166,7 @@ EXPORT_SYMBOL(do_settimeofday);
 void account_ticks(struct pt_regs *regs)
 {
 	__u64 tmp;
-	__u32 ticks, xticks;
+	__u32 ticks;
 
 	/* Calculate how many ticks have passed. */
 	if (S390_lowcore.int_clock < S390_lowcore.jiffy_timer) {
@@ -204,6 +204,7 @@ void account_ticks(struct pt_regs *regs)
 	 */
 	write_seqlock(&xtime_lock);
 	if (S390_lowcore.jiffy_timer > xtime_cc) {
+		__u32 xticks;
 		tmp = S390_lowcore.jiffy_timer - xtime_cc;
 		if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
 			xticks = __div(tmp, CLK_TICKS_PER_JIFFY);
@@ -212,13 +213,11 @@ void account_ticks(struct pt_regs *regs)
 			xticks = 1;
 			xtime_cc += CLK_TICKS_PER_JIFFY;
 		}
-		while (xticks--)
-			do_timer(regs);
+		do_timer(xticks);
 	}
 	write_sequnlock(&xtime_lock);
 #else
-	for (xticks = ticks; xticks > 0; xticks--)
-		do_timer(regs);
+	do_timer(ticks);
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/sh/kernel/time.c linux-2.6.18-rc4-mm1/arch/sh/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/sh/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/sh/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -115,7 +115,7 @@ static long last_rtc_update;
  */
 void handle_timer_tick(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/sh64/kernel/time.c linux-2.6.18-rc4-mm1/arch/sh64/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/sh64/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/sh64/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -298,7 +298,7 @@ static inline void do_timer_interrupt(in
 	asm ("getcon cr62, %0" : "=r" (current_ctc));
 	ctc_last_interrupt = (unsigned long) current_ctc;
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/sparc/kernel/pcic.c linux-2.6.18-rc4-mm1/arch/sparc/kernel/pcic.c
--- linux-2.6.18-rc4-mm1.prev/arch/sparc/kernel/pcic.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/sparc/kernel/pcic.c	2006-08-16 17:27:00.000000000 +0900
@@ -712,7 +712,7 @@ static irqreturn_t pcic_timer_handler (i
 {
 	write_seqlock(&xtime_lock);	/* Dummy, to show that we remember */
 	pcic_clear_clock_irq();
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/sparc/kernel/time.c linux-2.6.18-rc4-mm1/arch/sparc/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/sparc/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/sparc/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -128,7 +128,7 @@ irqreturn_t timer_interrupt(int irq, voi
 #endif
 	clear_clock_irq();
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/sparc64/kernel/time.c linux-2.6.18-rc4-mm1/arch/sparc64/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/sparc64/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/sparc64/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -465,7 +465,7 @@ irqreturn_t timer_interrupt(int irq, voi
 		profile_tick(CPU_PROFILING, regs);
 		update_process_times(user_mode(regs));
 #endif
-		do_timer(regs);
+		do_timer(1);
 
 		/* Guarantee that the following sequences execute
 		 * uninterrupted.
@@ -496,7 +496,7 @@ void timer_tick_interrupt(struct pt_regs
 {
 	write_seqlock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(1);
 
 	timer_check_rtc();
 
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/um/kernel/time.c linux-2.6.18-rc4-mm1/arch/um/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/um/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/um/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -93,7 +93,7 @@ irqreturn_t um_timer(int irq, void *dev,
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 
-	do_timer(regs);
+	do_timer(1);
 
 	nsecs = get_time() + local_offset;
 	xtime.tv_sec = nsecs / NSEC_PER_SEC;
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/v850/kernel/time.c linux-2.6.18-rc4-mm1/arch/v850/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/v850/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/v850/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -50,7 +50,7 @@ static irqreturn_t timer_interrupt (int 
 	if (mach_tick)
 	  mach_tick ();
 
-	do_timer (regs);
+	do_timer (1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/x86_64/kernel/time.c linux-2.6.18-rc4-mm1/arch/x86_64/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/x86_64/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/x86_64/kernel/time.c	2006-08-16 17:27:38.000000000 +0900
@@ -415,16 +415,16 @@ void main_timer_handler(struct pt_regs *
 				(((long) offset << US_SCALE) / vxtime.tsc_quot) - 1;
 	}
 
-	if (lost > 0) {
+	if (lost > 0)
 		handle_lost_ticks(lost, regs);
-		jiffies += lost;
-	}
+	else
+		lost = 0;
 
 /*
  * Do the timer stuff.
  */
 
-	do_timer(regs);
+	do_timer(lost + 1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/arch/xtensa/kernel/time.c linux-2.6.18-rc4-mm1/arch/xtensa/kernel/time.c
--- linux-2.6.18-rc4-mm1.prev/arch/xtensa/kernel/time.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/xtensa/kernel/time.c	2006-08-16 17:27:00.000000000 +0900
@@ -175,7 +175,7 @@ again:
 
 		last_ccount_stamp = next;
 		next += CCOUNT_PER_JIFFY;
-		do_timer (regs); /* Linux handler in kernel/timer.c */
+		do_timer (1); /* Linux handler in kernel/timer.c */
 
 		if (ntp_synced() &&
 		    xtime.tv_sec - last_rtc_update >= 659 &&
diff -urNp linux-2.6.18-rc4-mm1.prev/include/asm-arm/arch-clps711x/time.h linux-2.6.18-rc4-mm1/include/asm-arm/arch-clps711x/time.h
--- linux-2.6.18-rc4-mm1.prev/include/asm-arm/arch-clps711x/time.h	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/include/asm-arm/arch-clps711x/time.h	2006-08-16 17:27:00.000000000 +0900
@@ -29,7 +29,7 @@ static irqreturn_t
 p720t_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	do_leds();
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/include/asm-arm/arch-l7200/time.h linux-2.6.18-rc4-mm1/include/asm-arm/arch-l7200/time.h
--- linux-2.6.18-rc4-mm1.prev/include/asm-arm/arch-l7200/time.h	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/include/asm-arm/arch-l7200/time.h	2006-08-16 17:27:00.000000000 +0900
@@ -45,7 +45,7 @@
 static irqreturn_t
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/include/asm-i386/mach-default/do_timer.h linux-2.6.18-rc4-mm1/include/asm-i386/mach-default/do_timer.h
--- linux-2.6.18-rc4-mm1.prev/include/asm-i386/mach-default/do_timer.h	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/include/asm-i386/mach-default/do_timer.h	2006-08-16 17:27:00.000000000 +0900
@@ -16,7 +16,7 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/include/asm-i386/mach-visws/do_timer.h linux-2.6.18-rc4-mm1/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6.18-rc4-mm1.prev/include/asm-i386/mach-visws/do_timer.h	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/include/asm-i386/mach-visws/do_timer.h	2006-08-16 17:27:00.000000000 +0900
@@ -9,7 +9,7 @@ static inline void do_timer_interrupt_ho
 	/* Clear the interrupt */
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/include/asm-i386/mach-voyager/do_timer.h linux-2.6.18-rc4-mm1/include/asm-i386/mach-voyager/do_timer.h
--- linux-2.6.18-rc4-mm1.prev/include/asm-i386/mach-voyager/do_timer.h	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/include/asm-i386/mach-voyager/do_timer.h	2006-08-16 17:27:00.000000000 +0900
@@ -3,7 +3,7 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
diff -urNp linux-2.6.18-rc4-mm1.prev/include/linux/sched.h linux-2.6.18-rc4-mm1/include/linux/sched.h
--- linux-2.6.18-rc4-mm1.prev/include/linux/sched.h	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/include/linux/sched.h	2006-08-16 17:27:00.000000000 +0900
@@ -1228,7 +1228,7 @@ extern void switch_uid(struct user_struc
 
 #include <asm/current.h>
 
-extern void do_timer(struct pt_regs *);
+extern void do_timer(unsigned long ticks);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
diff -urNp linux-2.6.18-rc4-mm1.prev/kernel/timer.c linux-2.6.18-rc4-mm1/kernel/timer.c
--- linux-2.6.18-rc4-mm1.prev/kernel/timer.c	2006-08-16 17:26:37.000000000 +0900
+++ linux-2.6.18-rc4-mm1/kernel/timer.c	2006-08-16 17:27:00.000000000 +0900
@@ -1008,10 +1008,8 @@ static inline void calc_load(unsigned lo
 	unsigned long active_tasks; /* fixed-point */
 	static int count = LOAD_FREQ;
 
-	count -= ticks;
-	if (count < 0) {
-		count += LOAD_FREQ;
-		active_tasks = count_active_tasks();
+	active_tasks = count_active_tasks();
+	for (count -= ticks; count < 0; count += LOAD_FREQ) {
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
 		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
 		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
@@ -1056,11 +1054,8 @@ void run_local_timers(void)
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
-static inline void update_times(void)
+static inline void update_times(unsigned long ticks)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
 	wall_jiffies += ticks;
 	update_wall_time();
 	calc_load(ticks);
@@ -1072,12 +1067,10 @@ static inline void update_times(void)
  * jiffies is defined in the linker script...
  */
 
-void do_timer(struct pt_regs *regs)
+void do_timer(unsigned long ticks)
 {
-	jiffies_64++;
-	/* prevent loading jiffies before storing new jiffies_64 value. */
-	barrier();
-	update_times();
+	jiffies_64 += ticks;
+	update_times(ticks);
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM
