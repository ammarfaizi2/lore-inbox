Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWHFQLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWHFQLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWHFQLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 12:11:47 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:24010 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932571AbWHFQLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 12:11:47 -0400
Date: Mon, 07 Aug 2006 01:13:19 +0900 (JST)
Message-Id: <20060807.011319.41196590.anemo@mba.ocn.ne.jp>
To: schwidefsky@googlemail.com
Cc: johnstul@us.ibm.com, akpm@osdl.org, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de, schwidefsky@de.ibm.com
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <6e0cfd1d0608040702h15371d31q1c3d1c305c3da424@mail.gmail.com>
References: <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
	<20060804.005352.128616651.anemo@mba.ocn.ne.jp>
	<6e0cfd1d0608040702h15371d31q1c3d1c305c3da424@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 16:02:43 +0200, "Martin Schwidefsky" <schwidefsky@googlemail.com> wrote:
> Good start, now you only have the change the 30+ calls to do_timer in
> the various architecture backends.

OK, then this is a patch contains the changes.
Adding S390 maintainer Martin Schwidefsky to CC.

This patch is against current git tree, so does not contains a change
to arch/avr32 which is in mm tree.  I can create a patch against mm
tree if expected.


[PATCH] cleanup do_timer and update_times

Pass ticks to do_timer() and update_times().

This also make a barrier added by
5aee405c662ca644980c184774277fc6d0769a84 needless.

Also adjust x86_64 and s390 timer interrupt handler with this change.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/alpha/kernel/time.c                 |    2 +-
 arch/arm/kernel/time.c                   |    2 +-
 arch/arm26/kernel/time.c                 |    2 +-
 arch/cris/arch-v10/kernel/time.c         |    2 +-
 arch/cris/arch-v32/kernel/time.c         |    2 +-
 arch/frv/kernel/time.c                   |    2 +-
 arch/h8300/kernel/time.c                 |    2 +-
 arch/ia64/kernel/time.c                  |    2 +-
 arch/m32r/kernel/time.c                  |    2 +-
 arch/m68k/kernel/time.c                  |    2 +-
 arch/m68k/sun3/sun3ints.c                |    2 +-
 arch/m68knommu/kernel/time.c             |    2 +-
 arch/mips/au1000/common/time.c           |    6 +++---
 arch/mips/galileo-boards/ev96100/time.c  |    2 +-
 arch/mips/gt64120/common/time.c          |    2 +-
 arch/mips/kernel/time.c                  |    2 +-
 arch/mips/momentum/ocelot_g/gt-irq.c     |    2 +-
 arch/mips/sgi-ip27/ip27-timer.c          |    2 +-
 arch/parisc/kernel/time.c                |    2 +-
 arch/powerpc/kernel/time.c               |    2 +-
 arch/ppc/kernel/time.c                   |    2 +-
 arch/s390/kernel/time.c                  |    9 ++++-----
 arch/sh/kernel/time.c                    |    2 +-
 arch/sh64/kernel/time.c                  |    2 +-
 arch/sparc/kernel/pcic.c                 |    2 +-
 arch/sparc/kernel/time.c                 |    2 +-
 arch/sparc64/kernel/time.c               |    4 ++--
 arch/um/kernel/time.c                    |    2 +-
 arch/v850/kernel/time.c                  |    2 +-
 arch/x86_64/kernel/time.c                |    6 ++----
 arch/xtensa/kernel/time.c                |    2 +-
 include/asm-arm/arch-clps711x/time.h     |    2 +-
 include/asm-arm/arch-l7200/time.h        |    2 +-
 include/asm-i386/mach-default/do_timer.h |    2 +-
 include/asm-i386/mach-visws/do_timer.h   |    2 +-
 include/asm-i386/mach-voyager/do_timer.h |    2 +-
 include/linux/sched.h                    |    2 +-
 kernel/timer.c                           |   15 +++++----------
 38 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
index b191cc7..7c1e444 100644
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -132,7 +132,7 @@ #endif
 	nticks = delta >> FIX_SHIFT;
 
 	while (nticks > 0) {
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 09a67d7..4892a1f 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -333,7 +333,7 @@ void timer_tick(struct pt_regs *regs)
 	profile_tick(CPU_PROFILING, regs);
 	do_leds();
 	do_set_rtc();
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/arm26/kernel/time.c b/arch/arm26/kernel/time.c
index db63d75..80adbd0 100644
--- a/arch/arm26/kernel/time.c
+++ b/arch/arm26/kernel/time.c
@@ -194,7 +194,7 @@ EXPORT_SYMBOL(do_settimeofday);
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-        do_timer(regs);
+        do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/cris/arch-v10/kernel/time.c b/arch/cris/arch-v10/kernel/time.c
index 9c22b76..ebacf14 100644
--- a/arch/cris/arch-v10/kernel/time.c
+++ b/arch/cris/arch-v10/kernel/time.c
@@ -227,7 +227,7 @@ #endif
 	
 	/* call the real timer interrupt handler */
 
-	do_timer(regs);
+	do_timer(1);
 	
         cris_do_profile(regs); /* Save profiling information */
 
diff --git a/arch/cris/arch-v32/kernel/time.c b/arch/cris/arch-v32/kernel/time.c
index 50f3f93..be0a016 100644
--- a/arch/cris/arch-v32/kernel/time.c
+++ b/arch/cris/arch-v32/kernel/time.c
@@ -219,7 +219,7 @@ timer_interrupt(int irq, void *dev_id, s
 		return IRQ_HANDLED;
 
 	/* call the real timer interrupt handler */
-	do_timer(regs);
+	do_timer(1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
index d5b64e1..77d18f6 100644
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -73,7 +73,7 @@ static irqreturn_t timer_interrupt(int i
 	 */
 	write_seqlock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(1);
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING, regs);
 
diff --git a/arch/h8300/kernel/time.c b/arch/h8300/kernel/time.c
index 688a510..e569d17 100644
--- a/arch/h8300/kernel/time.c
+++ b/arch/h8300/kernel/time.c
@@ -41,7 +41,7 @@ static void timer_interrupt(int irq, voi
 	/* may need to kick the hardware timer */
 	platform_timer_eoi();
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 6928ef0..1626268 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -78,7 +78,7 @@ timer_interrupt (int irq, void *dev_id, 
 			 * xtime_lock.
 			 */
 			write_seqlock(&xtime_lock);
-			do_timer(regs);
+			do_timer(1);
 			local_cpu_data->itm_next = new_itm;
 			write_sequnlock(&xtime_lock);
 		} else
diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
index ded0be0..7a89689 100644
--- a/arch/m32r/kernel/time.c
+++ b/arch/m32r/kernel/time.c
@@ -202,7 +202,7 @@ irqreturn_t timer_interrupt(int irq, voi
 #ifndef CONFIG_SMP
 	profile_tick(CPU_PROFILING, regs);
 #endif
-	do_timer(regs);
+	do_timer(1);
 
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 98e4b1a..1072e49 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -40,7 +40,7 @@ static inline int set_rtc_mmss(unsigned 
  */
 static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/m68k/sun3/sun3ints.c b/arch/m68k/sun3/sun3ints.c
index f18b9d3..dc4ea7e 100644
--- a/arch/m68k/sun3/sun3ints.c
+++ b/arch/m68k/sun3/sun3ints.c
@@ -65,7 +65,7 @@ #endif
 #ifdef CONFIG_SUN3
 	intersil_clear();
 #endif
-        do_timer(fp);
+        do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(fp));
 #endif
diff --git a/arch/m68knommu/kernel/time.c b/arch/m68knommu/kernel/time.c
index 1db9872..db1e1ce 100644
--- a/arch/m68knommu/kernel/time.c
+++ b/arch/m68knommu/kernel/time.c
@@ -51,7 +51,7 @@ static irqreturn_t timer_interrupt(int i
 
 	write_seqlock(&xtime_lock);
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 7fbea1b..0a067f3 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
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
@@ -156,7 +156,7 @@ #endif
 
 	if (jiffie_drift >= 999) {
 		jiffie_drift -= 999;
-		do_timer(regs); /* increment jiffies by one */
+		do_timer(1); /* increment jiffies by one */
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff --git a/arch/mips/galileo-boards/ev96100/time.c b/arch/mips/galileo-boards/ev96100/time.c
index 8cbe842..60c564b 100644
--- a/arch/mips/galileo-boards/ev96100/time.c
+++ b/arch/mips/galileo-boards/ev96100/time.c
@@ -72,7 +72,7 @@ void mips_timer_interrupt(struct pt_regs
 
 	do {
 		kstat_this_cpu.irqs[irq]++;
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff --git a/arch/mips/gt64120/common/time.c b/arch/mips/gt64120/common/time.c
index d837b26..7feca49 100644
--- a/arch/mips/gt64120/common/time.c
+++ b/arch/mips/gt64120/common/time.c
@@ -34,7 +34,7 @@ static void gt64120_irq(int irq, void *d
 	if (irq_src & 0x00000800) {	/* Check for timer interrupt */
 		handled = 1;
 		irq_src &= ~0x00000800;
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 170cb67..6ab8d97 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -434,7 +434,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	/*
 	 * call the generic timer interrupt handling
 	 */
-	do_timer(regs);
+	do_timer(1);
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff --git a/arch/mips/momentum/ocelot_g/gt-irq.c b/arch/mips/momentum/ocelot_g/gt-irq.c
index 9fb2493..6cd87cf 100644
--- a/arch/mips/momentum/ocelot_g/gt-irq.c
+++ b/arch/mips/momentum/ocelot_g/gt-irq.c
@@ -133,7 +133,7 @@ static irqreturn_t gt64240_p0int_irq(int
 		MV_WRITE(TIMER_COUNTER_0_3_INTERRUPT_CAUSE, 0x0);
 
 		/* handle the timer call */
-		do_timer(regs);
+		do_timer(1);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index b029ba7..c62a3a9 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -111,7 +111,7 @@ again:
 	kstat_this_cpu.irqs[irq]++;		/* kstat only for bootcpu? */
 
 	if (cpu == 0)
-		do_timer(regs);
+		do_timer(1);
 
 	update_process_times(user_mode(regs));
 
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 5facc9b..700df10 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -79,7 +79,7 @@ #else
 #endif
 		if (cpu == 0) {
 			write_seqlock(&xtime_lock);
-			do_timer(regs);
+			do_timer(1);
 			write_sequnlock(&xtime_lock);
 		}
 	}
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 774c0a3..914178c 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -693,7 +693,7 @@ #endif
 		write_seqlock(&xtime_lock);
 		tb_last_jiffy += tb_ticks_per_jiffy;
 		tb_last_stamp = per_cpu(last_jiffy, cpu);
-		do_timer(regs);
+		do_timer(1);
 		timer_recalc_offset(tb_last_jiffy);
 		timer_check_rtc();
 		write_sequnlock(&xtime_lock);
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
index 6ab8cc7..1e1f315 100644
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -153,7 +153,7 @@ void timer_interrupt(struct pt_regs * re
 		/* We are in an interrupt, no need to save/restore flags */
 		write_seqlock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
-		do_timer(regs);
+		do_timer(1);
 
 		/*
 		 * update the rtc when needed, this should be performed on the
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 74e6178..ade3f07 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -166,7 +166,7 @@ #endif /* CONFIG_PROFILING */
 void account_ticks(struct pt_regs *regs)
 {
 	__u64 tmp;
-	__u32 ticks, xticks;
+	__u32 ticks;
 
 	/* Calculate how many ticks have passed. */
 	if (S390_lowcore.int_clock < S390_lowcore.jiffy_timer) {
@@ -204,6 +204,7 @@ #ifdef CONFIG_SMP
 	 */
 	write_seqlock(&xtime_lock);
 	if (S390_lowcore.jiffy_timer > xtime_cc) {
+		__u32 xticks;
 		tmp = S390_lowcore.jiffy_timer - xtime_cc;
 		if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
 			xticks = __div(tmp, CLK_TICKS_PER_JIFFY);
@@ -212,13 +213,11 @@ #ifdef CONFIG_SMP
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
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index a1589f8..9351ee9 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -115,7 +115,7 @@ static long last_rtc_update;
  */
 void handle_timer_tick(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/sh64/kernel/time.c b/arch/sh64/kernel/time.c
index b8162e5..3b61e06 100644
--- a/arch/sh64/kernel/time.c
+++ b/arch/sh64/kernel/time.c
@@ -298,7 +298,7 @@ static inline void do_timer_interrupt(in
 	asm ("getcon cr62, %0" : "=r" (current_ctc));
 	ctc_last_interrupt = (unsigned long) current_ctc;
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index bfd31aa..e19b1ba 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -712,7 +712,7 @@ static irqreturn_t pcic_timer_handler (i
 {
 	write_seqlock(&xtime_lock);	/* Dummy, to show that we remember */
 	pcic_clear_clock_irq();
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 845081b..6f84fa1 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -128,7 +128,7 @@ #ifdef CONFIG_SUN4
 #endif
 	clear_clock_irq();
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 094d3e3..f5ed96f 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -465,7 +465,7 @@ #ifndef CONFIG_SMP
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
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 552ca1c..2e2caf0 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -96,7 +96,7 @@ irqreturn_t um_timer(int irq, void *dev,
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 
-	do_timer(regs);
+	do_timer(1);
 
 	nsecs = get_time() + local_offset;
 	xtime.tv_sec = nsecs / NSEC_PER_SEC;
diff --git a/arch/v850/kernel/time.c b/arch/v850/kernel/time.c
index a0b4669..f4d1a4d 100644
--- a/arch/v850/kernel/time.c
+++ b/arch/v850/kernel/time.c
@@ -51,7 +51,7 @@ #endif
 	if (mach_tick)
 	  mach_tick ();
 
-	do_timer (regs);
+	do_timer (1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 7a9b182..fdd9e98 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -421,16 +421,14 @@ #endif
 				(((long) offset << US_SCALE) / vxtime.tsc_quot) - 1;
 	}
 
-	if (lost > 0) {
+	if (lost > 0)
 		handle_lost_ticks(lost, regs);
-		jiffies += lost;
-	}
 
 /*
  * Do the timer stuff.
  */
 
-	do_timer(regs);
+	do_timer(lost + 1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 412ab32..241db20 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -175,7 +175,7 @@ #endif
 
 		last_ccount_stamp = next;
 		next += CCOUNT_PER_JIFFY;
-		do_timer (regs); /* Linux handler in kernel/timer.c */
+		do_timer (1); /* Linux handler in kernel/timer.c */
 
 		if (ntp_synced() &&
 		    xtime.tv_sec - last_rtc_update >= 659 &&
diff --git a/include/asm-arm/arch-clps711x/time.h b/include/asm-arm/arch-clps711x/time.h
index 9cb27cd..0e4a390 100644
--- a/include/asm-arm/arch-clps711x/time.h
+++ b/include/asm-arm/arch-clps711x/time.h
@@ -29,7 +29,7 @@ static irqreturn_t
 p720t_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	do_leds();
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/include/asm-arm/arch-l7200/time.h b/include/asm-arm/arch-l7200/time.h
index 7b98b53..c69cb50 100644
--- a/include/asm-arm/arch-l7200/time.h
+++ b/include/asm-arm/arch-l7200/time.h
@@ -45,7 +45,7 @@ #define RTC_EN_STWDOG	0x08      /* Enabl
 static irqreturn_t
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/include/asm-i386/mach-default/do_timer.h b/include/asm-i386/mach-default/do_timer.h
index 6312c3e..4182c34 100644
--- a/include/asm-i386/mach-default/do_timer.h
+++ b/include/asm-i386/mach-default/do_timer.h
@@ -16,7 +16,7 @@ #include <asm/i8259.h>
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
diff --git a/include/asm-i386/mach-visws/do_timer.h b/include/asm-i386/mach-visws/do_timer.h
index 95568e6..8db618c 100644
--- a/include/asm-i386/mach-visws/do_timer.h
+++ b/include/asm-i386/mach-visws/do_timer.h
@@ -9,7 +9,7 @@ static inline void do_timer_interrupt_ho
 	/* Clear the interrupt */
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
diff --git a/include/asm-i386/mach-voyager/do_timer.h b/include/asm-i386/mach-voyager/do_timer.h
index eaf5180..099fe9f 100644
--- a/include/asm-i386/mach-voyager/do_timer.h
+++ b/include/asm-i386/mach-voyager/do_timer.h
@@ -3,7 +3,7 @@ #include <asm/voyager.h>
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6afa72e..8de3d91 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,7 +1180,7 @@ extern void switch_uid(struct user_struc
 
 #include <asm/current.h>
 
-extern void do_timer(struct pt_regs *);
+extern void do_timer(unsigned long ticks);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
diff --git a/kernel/timer.c b/kernel/timer.c
index b650f04..be7d885 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1218,7 +1218,7 @@ static inline void calc_load(unsigned lo
 	static int count = LOAD_FREQ;
 
 	count -= ticks;
-	if (count < 0) {
+	while (count < 0) {
 		count += LOAD_FREQ;
 		active_tasks = count_active_tasks();
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
@@ -1265,11 +1265,8 @@ void run_local_timers(void)
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
@@ -1281,12 +1278,10 @@ static inline void update_times(void)
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
