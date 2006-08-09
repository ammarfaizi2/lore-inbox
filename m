Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWHICRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWHICRf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWHICRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33466 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751235AbWHICR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:29 -0400
Date: Tue, 8 Aug 2006 22:17:27 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021726.23103.85003.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 3/6] x86_64: Remove apic_runs_main_timer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the x86-64 cleanup for generic timekeeping. 
Remove apic_runs_main_timer, on request from Andi, since it doesn't 
work on many systems.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/kernel/apic.c |   30 +-----------------------------
 arch/x86_64/kernel/time.c |    2 --
 include/asm-x86_64/apic.h |    1 -
 3 files changed, 1 insertion(+), 32 deletions(-)

linux-2.6.18-rc4_timeofday-arch-x86-64-part2_C5.patch
============================================
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 1b9e3d3..6173b2f 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -39,7 +39,6 @@
 #include <asm/hpet.h>
 
 int apic_verbosity;
-int apic_runs_main_timer;
 int apic_calibrate_pmtmr __initdata;
 
 int disable_apic_timer __initdata;
@@ -747,16 +746,6 @@ static void setup_APIC_timer(unsigned in
 		} while (c2 - c1 < 300);
 	}
 	__setup_APIC_LVTT(clocks);
-	/* Turn off PIT interrupt if we use APIC timer as main timer.
-	   Only works with the PM timer right now
-	   TBD fix it for HPET too. */
-	if (vxtime.mode == VXTIME_PMTMR &&
-		smp_processor_id() == boot_cpu_id &&
-		apic_runs_main_timer == 1 &&
-		!cpu_isset(boot_cpu_id, timer_interrupt_broadcast_ipi_mask)) {
-		stop_timer_interrupt();
-		apic_runs_main_timer++;
-	}
 	local_irq_restore(flags);
 }
 
@@ -946,8 +935,6 @@ void smp_local_timer_interrupt(struct pt
 #ifdef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
-	if (apic_runs_main_timer > 1 && smp_processor_id() == boot_cpu_id)
-		main_timer_handler(regs);
 	/*
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the appropriate locks (kernel lock/ irq lock).
@@ -1162,26 +1149,11 @@ static __init int setup_noapictimer(char
 	return 1;
 } 
 
-static __init int setup_apicmaintimer(char *str)
-{
-	apic_runs_main_timer = 1;
-	nohpet = 1;
-	return 1;
-}
-__setup("apicmaintimer", setup_apicmaintimer);
-
-static __init int setup_noapicmaintimer(char *str)
-{
-	apic_runs_main_timer = -1;
-	return 1;
-}
-__setup("noapicmaintimer", setup_noapicmaintimer);
-
 static __init int setup_apicpmtimer(char *s)
 {
 	apic_calibrate_pmtmr = 1;
 	notsc_setup(NULL);
-	return setup_apicmaintimer(NULL);
+	return 1;
 }
 __setup("apicpmtimer", setup_apicpmtimer);
 
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index da89e60..a4aef4e 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -469,8 +469,6 @@ void main_timer_handler(struct pt_regs *
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	if (apic_runs_main_timer > 1)
-		return IRQ_HANDLED;
 	main_timer_handler(regs);
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (using_apic_timer)
diff --git a/include/asm-x86_64/apic.h b/include/asm-x86_64/apic.h
index 9c96a0a..06fcdc2 100644
--- a/include/asm-x86_64/apic.h
+++ b/include/asm-x86_64/apic.h
@@ -16,7 +16,6 @@
 #define APIC_DEBUG   2
 
 extern int apic_verbosity;
-extern int apic_runs_main_timer;
 
 /*
  * Define the default level of output to be very little
