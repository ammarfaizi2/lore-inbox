Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUHESMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUHESMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267862AbUHESMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:12:16 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50096 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267846AbUHESDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:03:35 -0400
Date: Thu, 5 Aug 2004 20:03:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu
Cc: arjanv@redhat.com, tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       crisw@osdl.org, jan.glauber@de.ibm.com
Subject: [PATCH] cputime (1/6): move call to update_process_times.
Message-ID: <20040805180335.GB9240@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cputime (1/6): move call to update_process_times.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

For non-smp kernels the call to update_process_times is done
in the do_timer function. It is more consistent with smp kernels
to move this call to the architecture file which calls do_timer. 

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/alpha/kernel/time.c                 |    3 +++
 arch/arm/kernel/time.c                   |    3 +++
 arch/arm/mach-iop3xx/iq80310-time.c      |    3 +++
 arch/arm26/kernel/time.c                 |    3 +++
 arch/cris/arch-v10/kernel/time.c         |    3 +++
 arch/h8300/kernel/time.c                 |    3 +++
 arch/ia64/kernel/time.c                  |    8 +-------
 arch/m68k/kernel/time.c                  |    3 +++
 arch/m68k/sun3/sun3ints.c                |    3 +++
 arch/m68knommu/kernel/time.c             |    3 +++
 arch/mips/au1000/common/time.c           |    9 +++++++++
 arch/mips/baget/time.c                   |    3 +++
 arch/mips/galileo-boards/ev96100/time.c  |    3 +++
 arch/mips/gt64120/common/time.c          |    3 +++
 arch/mips/kernel/time.c                  |    3 ---
 arch/mips/momentum/ocelot_g/gt-irq.c     |    3 +++
 arch/mips/sgi-ip27/ip27-timer.c          |    2 --
 arch/parisc/kernel/time.c                |    2 ++
 arch/ppc/kernel/time.c                   |    3 +++
 arch/ppc64/kernel/time.c                 |    3 +++
 arch/s390/kernel/time.c                  |    4 +++-
 arch/sh/kernel/time.c                    |    3 +++
 arch/sh64/kernel/time.c                  |    3 +++
 arch/sparc/kernel/pcic.c                 |    3 +++
 arch/sparc/kernel/time.c                 |    4 ++++
 arch/sparc64/kernel/time.c               |    1 +
 arch/um/kernel/time_kern.c               |    2 --
 arch/v850/kernel/time.c                  |    3 +++
 arch/x86_64/kernel/time.c                |    3 +++
 include/asm-arm/arch-clps711x/time.h     |    3 +++
 include/asm-arm/arch-integrator/time.h   |    3 +++
 include/asm-arm/arch-l7200/time.h        |    3 +++
 include/asm-i386/mach-default/do_timer.h |    3 +++
 include/asm-i386/mach-visws/do_timer.h   |    3 +++
 include/asm-i386/mach-voyager/do_timer.h |    3 +++
 kernel/timer.c                           |    5 -----
 36 files changed, 98 insertions(+), 20 deletions(-)

diff -urN linux-2.6.8-rc3/arch/alpha/kernel/time.c linux-2.6.8-s390/arch/alpha/kernel/time.c
--- linux-2.6.8-rc3/arch/alpha/kernel/time.c	Thu Aug  5 18:39:48 2004
+++ linux-2.6.8-s390/arch/alpha/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -138,6 +138,9 @@
 
 	while (nticks > 0) {
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		nticks--;
 	}
 
diff -urN linux-2.6.8-rc3/arch/arm/kernel/time.c linux-2.6.8-s390/arch/arm/kernel/time.c
--- linux-2.6.8-rc3/arch/arm/kernel/time.c	Thu Aug  5 18:39:48 2004
+++ linux-2.6.8-s390/arch/arm/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -321,6 +321,9 @@
 	do_leds();
 	do_set_rtc();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 }
 
 void (*init_arch_time)(void);
diff -urN linux-2.6.8-rc3/arch/arm/mach-iop3xx/iq80310-time.c linux-2.6.8-s390/arch/arm/mach-iop3xx/iq80310-time.c
--- linux-2.6.8-rc3/arch/arm/mach-iop3xx/iq80310-time.c	Wed Jun 16 07:19:43 2004
+++ linux-2.6.8-s390/arch/arm/mach-iop3xx/iq80310-time.c	Thu Aug  5 18:40:21 2004
@@ -97,6 +97,9 @@
 	*timer_en |= 2;
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	return IRQ_HANDLED;
 }
diff -urN linux-2.6.8-rc3/arch/arm26/kernel/time.c linux-2.6.8-s390/arch/arm26/kernel/time.c
--- linux-2.6.8-rc3/arch/arm26/kernel/time.c	Wed Jun 16 07:19:42 2004
+++ linux-2.6.8-s390/arch/arm26/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -188,6 +188,9 @@
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
         do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
         do_set_rtc(); //FIME - EVERY timer IRQ?
         do_profile(regs);
 	return IRQ_HANDLED; //FIXME - is this right?
diff -urN linux-2.6.8-rc3/arch/cris/arch-v10/kernel/time.c linux-2.6.8-s390/arch/cris/arch-v10/kernel/time.c
--- linux-2.6.8-rc3/arch/cris/arch-v10/kernel/time.c	Thu Aug  5 18:39:48 2004
+++ linux-2.6.8-s390/arch/cris/arch-v10/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -227,6 +227,9 @@
 	/* call the real timer interrupt handler */
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.6.8-rc3/arch/h8300/kernel/time.c linux-2.6.8-s390/arch/h8300/kernel/time.c
--- linux-2.6.8-rc3/arch/h8300/kernel/time.c	Wed Jun 16 07:19:10 2004
+++ linux-2.6.8-s390/arch/h8300/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -64,6 +64,9 @@
 	platform_timer_eoi();
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	if (!user_mode(regs))
 		do_profile(regs->pc);
diff -urN linux-2.6.8-rc3/arch/ia64/kernel/time.c linux-2.6.8-s390/arch/ia64/kernel/time.c
--- linux-2.6.8-rc3/arch/ia64/kernel/time.c	Wed Jun 16 07:19:01 2004
+++ linux-2.6.8-s390/arch/ia64/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -252,14 +252,8 @@
 	ia64_do_profile(regs);
 
 	while (1) {
-#ifdef CONFIG_SMP
-		/*
-		 * For UP, this is done in do_timer().  Weird, but
-		 * fixing that would require updates to all
-		 * platforms.
-		 */
 		update_process_times(user_mode(regs));
-#endif
+
 		new_itm += local_cpu_data->itm_delta;
 
 		if (smp_processor_id() == TIME_KEEPER_ID) {
diff -urN linux-2.6.8-rc3/arch/m68k/kernel/time.c linux-2.6.8-s390/arch/m68k/kernel/time.c
--- linux-2.6.8-rc3/arch/m68k/kernel/time.c	Wed Jun 16 07:19:02 2004
+++ linux-2.6.8-s390/arch/m68k/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -63,6 +63,9 @@
 static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	if (!user_mode(regs))
 		do_profile(regs->pc);
diff -urN linux-2.6.8-rc3/arch/m68k/sun3/sun3ints.c linux-2.6.8-s390/arch/m68k/sun3/sun3ints.c
--- linux-2.6.8-rc3/arch/m68k/sun3/sun3ints.c	Wed Jun 16 07:20:26 2004
+++ linux-2.6.8-s390/arch/m68k/sun3/sun3ints.c	Thu Aug  5 18:40:21 2004
@@ -85,6 +85,9 @@
 	intersil_clear();
 #endif
         do_timer(fp);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(fp));
+#endif
         if(!(kstat_cpu(0).irqs[SYS_IRQS + irq] % 20))
                 sun3_leds(led_pattern[(kstat_cpu(0).irqs[SYS_IRQS+irq]%160)
                 /20]);
diff -urN linux-2.6.8-rc3/arch/m68knommu/kernel/time.c linux-2.6.8-s390/arch/m68knommu/kernel/time.c
--- linux-2.6.8-rc3/arch/m68knommu/kernel/time.c	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-s390/arch/m68knommu/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -75,6 +75,9 @@
 	write_seqlock(&xtime_lock);
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	if (!user_mode(regs))
 		do_profile(regs->pc);
diff -urN linux-2.6.8-rc3/arch/mips/au1000/common/time.c linux-2.6.8-s390/arch/mips/au1000/common/time.c
--- linux-2.6.8-rc3/arch/mips/au1000/common/time.c	Wed Jun 16 07:19:13 2004
+++ linux-2.6.8-s390/arch/mips/au1000/common/time.c	Thu Aug  5 18:40:21 2004
@@ -99,6 +99,9 @@
 
 		kstat_this_cpu.irqs[irq]++;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		r4k_cur += r4k_offset;
 		ack_r4ktimer(r4k_cur);
 
@@ -137,6 +140,9 @@
 
 	while (time_elapsed > 0) {
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		time_elapsed -= MATCH20_INC;
 		last_match20 += MATCH20_INC;
 		jiffie_drift++;
@@ -153,6 +159,9 @@
 	if (jiffie_drift >= 999) {
 		jiffie_drift -= 999;
 		do_timer(regs); /* increment jiffies by one */
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 }
 
diff -urN linux-2.6.8-rc3/arch/mips/baget/time.c linux-2.6.8-s390/arch/mips/baget/time.c
--- linux-2.6.8-rc3/arch/mips/baget/time.c	Thu Aug  5 18:39:49 2004
+++ linux-2.6.8-s390/arch/mips/baget/time.c	Thu Aug  5 18:40:21 2004
@@ -52,6 +52,9 @@
 	if (timer_intr_valid()) {
 		sti();
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 }
 
diff -urN linux-2.6.8-rc3/arch/mips/galileo-boards/ev96100/time.c linux-2.6.8-s390/arch/mips/galileo-boards/ev96100/time.c
--- linux-2.6.8-rc3/arch/mips/galileo-boards/ev96100/time.c	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-s390/arch/mips/galileo-boards/ev96100/time.c	Thu Aug  5 18:40:21 2004
@@ -73,6 +73,9 @@
 	do {
 		kstat_this_cpu.irqs[irq]++;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		r4k_cur += r4k_offset;
 		ack_r4ktimer(r4k_cur);
 
diff -urN linux-2.6.8-rc3/arch/mips/gt64120/common/time.c linux-2.6.8-s390/arch/mips/gt64120/common/time.c
--- linux-2.6.8-rc3/arch/mips/gt64120/common/time.c	Thu Aug  5 18:39:49 2004
+++ linux-2.6.8-s390/arch/mips/gt64120/common/time.c	Thu Aug  5 18:40:21 2004
@@ -36,6 +36,9 @@
 		handled = 1;
 		irq_src &= ~0x00000800;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 
 	GT_WRITE(GT_INTRCAUSE_OFS, 0);
diff -urN linux-2.6.8-rc3/arch/mips/kernel/time.c linux-2.6.8-s390/arch/mips/kernel/time.c
--- linux-2.6.8-rc3/arch/mips/kernel/time.c	Thu Aug  5 18:39:49 2004
+++ linux-2.6.8-s390/arch/mips/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -434,10 +434,7 @@
 		}
 	}
 
-#ifdef CONFIG_SMP
-	/* in UP mode, update_process_times() is invoked by do_timer() */
 	update_process_times(user_mode(regs));
-#endif
 }
 
 /*
diff -urN linux-2.6.8-rc3/arch/mips/momentum/ocelot_g/gt-irq.c linux-2.6.8-s390/arch/mips/momentum/ocelot_g/gt-irq.c
--- linux-2.6.8-rc3/arch/mips/momentum/ocelot_g/gt-irq.c	Thu Aug  5 18:39:49 2004
+++ linux-2.6.8-s390/arch/mips/momentum/ocelot_g/gt-irq.c	Thu Aug  5 18:40:21 2004
@@ -134,6 +134,9 @@
 
 		/* handle the timer call */
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 
 	if (irq_src) {
diff -urN linux-2.6.8-rc3/arch/mips/sgi-ip27/ip27-timer.c linux-2.6.8-s390/arch/mips/sgi-ip27/ip27-timer.c
--- linux-2.6.8-rc3/arch/mips/sgi-ip27/ip27-timer.c	Wed Jun 16 07:19:13 2004
+++ linux-2.6.8-s390/arch/mips/sgi-ip27/ip27-timer.c	Thu Aug  5 18:40:21 2004
@@ -112,9 +112,7 @@
 	if (cpu == 0)
 		do_timer(regs);
 
-#ifdef CONFIG_SMP
 	update_process_times(user_mode(regs));
-#endif /* CONFIG_SMP */
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.6.8-rc3/arch/parisc/kernel/time.c linux-2.6.8-s390/arch/parisc/kernel/time.c
--- linux-2.6.8-rc3/arch/parisc/kernel/time.c	Wed Jun 16 07:20:27 2004
+++ linux-2.6.8-s390/arch/parisc/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -117,6 +117,8 @@
 	while (nticks--) {
 #ifdef CONFIG_SMP
 		smp_do_timer(regs);
+#else
+		update_process_times(user_mode(regs));
 #endif
 		if (cpu == 0) {
 			write_seqlock(&xtime_lock);
diff -urN linux-2.6.8-rc3/arch/ppc/kernel/time.c linux-2.6.8-s390/arch/ppc/kernel/time.c
--- linux-2.6.8-rc3/arch/ppc/kernel/time.c	Thu Aug  5 18:39:50 2004
+++ linux-2.6.8-s390/arch/ppc/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -173,6 +173,9 @@
 		write_seqlock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 
 		/*
 		 * update the rtc when needed, this should be performed on the
diff -urN linux-2.6.8-rc3/arch/ppc64/kernel/time.c linux-2.6.8-s390/arch/ppc64/kernel/time.c
--- linux-2.6.8-rc3/arch/ppc64/kernel/time.c	Thu Aug  5 18:39:50 2004
+++ linux-2.6.8-s390/arch/ppc64/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -287,6 +287,9 @@
 			write_seqlock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			do_timer(regs);
+#ifndef CONFIG_SMP
+			update_process_times(user_mode(regs));
+#endif
 			timer_sync_xtime( cur_tb );
 			timer_check_rtc();
 			write_sequnlock(&xtime_lock);
diff -urN linux-2.6.8-rc3/arch/s390/kernel/time.c linux-2.6.8-s390/arch/s390/kernel/time.c
--- linux-2.6.8-rc3/arch/s390/kernel/time.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/s390/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -273,8 +273,10 @@
 	while (ticks--)
 		update_process_times(user_mode(regs));
 #else
-	while (ticks--)
+	while (ticks--) {
 		do_timer(regs);
+		update_process_times(user_mode(regs));
+	}
 #endif
 	s390_do_profile(regs);
 }
diff -urN linux-2.6.8-rc3/arch/sh/kernel/time.c linux-2.6.8-s390/arch/sh/kernel/time.c
--- linux-2.6.8-rc3/arch/sh/kernel/time.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/sh/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -287,6 +287,9 @@
 static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	if (!user_mode(regs))
 		sh_do_profile(regs->pc);
diff -urN linux-2.6.8-rc3/arch/sh64/kernel/time.c linux-2.6.8-s390/arch/sh64/kernel/time.c
--- linux-2.6.8-rc3/arch/sh64/kernel/time.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/sh64/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -340,6 +340,9 @@
 	ctc_last_interrupt = (unsigned long) current_ctc;
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	sh64_do_profile(regs);
 
diff -urN linux-2.6.8-rc3/arch/sparc/kernel/pcic.c linux-2.6.8-s390/arch/sparc/kernel/pcic.c
--- linux-2.6.8-rc3/arch/sparc/kernel/pcic.c	Wed Jun 16 07:19:29 2004
+++ linux-2.6.8-s390/arch/sparc/kernel/pcic.c	Thu Aug  5 18:40:21 2004
@@ -720,6 +720,9 @@
 	write_seqlock(&xtime_lock);	/* Dummy, to show that we remember */
 	pcic_clear_clock_irq();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
 }
diff -urN linux-2.6.8-rc3/arch/sparc/kernel/time.c linux-2.6.8-s390/arch/sparc/kernel/time.c
--- linux-2.6.8-rc3/arch/sparc/kernel/time.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/sparc/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -147,6 +147,10 @@
 	clear_clock_irq();
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
+
 
 	/* Determine when to update the Mostek clock. */
 	if ((time_status & STA_UNSYNC) == 0 &&
diff -urN linux-2.6.8-rc3/arch/sparc64/kernel/time.c linux-2.6.8-s390/arch/sparc64/kernel/time.c
--- linux-2.6.8-rc3/arch/sparc64/kernel/time.c	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-s390/arch/sparc64/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -491,6 +491,7 @@
 	do {
 #ifndef CONFIG_SMP
 		sparc64_do_profile(regs);
+		update_process_times(user_mode(regs));
 #endif
 		do_timer(regs);
 
diff -urN linux-2.6.8-rc3/arch/um/kernel/time_kern.c linux-2.6.8-s390/arch/um/kernel/time_kern.c
--- linux-2.6.8-rc3/arch/um/kernel/time_kern.c	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-s390/arch/um/kernel/time_kern.c	Thu Aug  5 18:40:21 2004
@@ -124,9 +124,7 @@
 
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
-#ifdef CONFIG_SMP
 	update_process_times(user_context(UPT_SP(regs)));
-#endif
 	if(current->thread_info->cpu == 0)
 		timer_irq(regs);
 }
diff -urN linux-2.6.8-rc3/arch/v850/kernel/time.c linux-2.6.8-s390/arch/v850/kernel/time.c
--- linux-2.6.8-rc3/arch/v850/kernel/time.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/v850/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -74,6 +74,9 @@
 	  mach_tick ();
 
 	do_timer (regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	if (! user_mode (regs))
 		do_profile (regs->pc);
diff -urN linux-2.6.8-rc3/arch/x86_64/kernel/time.c linux-2.6.8-s390/arch/x86_64/kernel/time.c
--- linux-2.6.8-rc3/arch/x86_64/kernel/time.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/x86_64/kernel/time.c	Thu Aug  5 18:40:21 2004
@@ -368,6 +368,9 @@
  */
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 /*
  * In the SMP case we use the local APIC timer interrupt to do the profiling,
diff -urN linux-2.6.8-rc3/include/asm-arm/arch-clps711x/time.h linux-2.6.8-s390/include/asm-arm/arch-clps711x/time.h
--- linux-2.6.8-rc3/include/asm-arm/arch-clps711x/time.h	Wed Jun 16 07:20:26 2004
+++ linux-2.6.8-s390/include/asm-arm/arch-clps711x/time.h	Thu Aug  5 18:40:21 2004
@@ -30,6 +30,9 @@
 {
 	do_leds();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	do_profile(regs);
 	return IRQ_HANDLED;
 }
diff -urN linux-2.6.8-rc3/include/asm-arm/arch-integrator/time.h linux-2.6.8-s390/include/asm-arm/arch-integrator/time.h
--- linux-2.6.8-rc3/include/asm-arm/arch-integrator/time.h	Wed Jun 16 07:19:44 2004
+++ linux-2.6.8-s390/include/asm-arm/arch-integrator/time.h	Thu Aug  5 18:40:21 2004
@@ -107,6 +107,9 @@
 
 	do_leds();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	do_profile(regs);
 
 	return IRQ_HANDLED;
diff -urN linux-2.6.8-rc3/include/asm-arm/arch-l7200/time.h linux-2.6.8-s390/include/asm-arm/arch-l7200/time.h
--- linux-2.6.8-rc3/include/asm-arm/arch-l7200/time.h	Wed Jun 16 07:19:36 2004
+++ linux-2.6.8-s390/include/asm-arm/arch-l7200/time.h	Thu Aug  5 18:40:21 2004
@@ -46,6 +46,9 @@
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	do_profile(regs);
 	RTC_RTCC = 0;				/* Clear interrupt */
 
diff -urN linux-2.6.8-rc3/include/asm-i386/mach-default/do_timer.h linux-2.6.8-s390/include/asm-i386/mach-default/do_timer.h
--- linux-2.6.8-rc3/include/asm-i386/mach-default/do_timer.h	Wed Jun 16 07:20:03 2004
+++ linux-2.6.8-s390/include/asm-i386/mach-default/do_timer.h	Thu Aug  5 18:40:21 2004
@@ -16,6 +16,9 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
diff -urN linux-2.6.8-rc3/include/asm-i386/mach-visws/do_timer.h linux-2.6.8-s390/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6.8-rc3/include/asm-i386/mach-visws/do_timer.h	Wed Jun 16 07:19:09 2004
+++ linux-2.6.8-s390/include/asm-i386/mach-visws/do_timer.h	Thu Aug  5 18:40:21 2004
@@ -9,6 +9,9 @@
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
diff -urN linux-2.6.8-rc3/include/asm-i386/mach-voyager/do_timer.h linux-2.6.8-s390/include/asm-i386/mach-voyager/do_timer.h
--- linux-2.6.8-rc3/include/asm-i386/mach-voyager/do_timer.h	Wed Jun 16 07:19:44 2004
+++ linux-2.6.8-s390/include/asm-i386/mach-voyager/do_timer.h	Thu Aug  5 18:40:21 2004
@@ -4,6 +4,9 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	voyager_timer_interrupt(regs);
 }
diff -urN linux-2.6.8-rc3/kernel/timer.c linux-2.6.8-s390/kernel/timer.c
--- linux-2.6.8-rc3/kernel/timer.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/timer.c	Thu Aug  5 18:40:21 2004
@@ -945,11 +945,6 @@
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
-#ifndef CONFIG_SMP
-	/* SMP process accounting uses the local APIC timer */
-
-	update_process_times(user_mode(regs));
-#endif
 	update_times();
 }
 
