Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRDHVgp>; Sun, 8 Apr 2001 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRDHVgf>; Sun, 8 Apr 2001 17:36:35 -0400
Received: from colorfullife.com ([216.156.138.34]:64784 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130900AbRDHVgT>;
	Sun, 8 Apr 2001 17:36:19 -0400
Message-ID: <3AD0D9A8.189AA43C@colorfullife.com>
Date: Sun, 08 Apr 2001 23:35:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: softirq buggy
In-Reply-To: <200104081758.VAA15670@ms2.inr.ac.ru>
Content-Type: multipart/mixed;
 boundary="------------38599D87F9BACCE3C7E42C2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------38599D87F9BACCE3C7E42C2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've attached a new patch:

* cpu_is_idle() moved to <linux/pm.h>
* function uninlined due to header dependencies
* cpu_is_idle() doesn't call do_softirq directly, instead the caller
returns to schedule()
* cpu_is_idle() exported for modules.
* docu updated.

I'd prefer to inline cpu_is_idle(), but optimizing the idle code path is
probably not that important ;-)

--
	Manfred
--------------38599D87F9BACCE3C7E42C2F
Content-Type: text/plain; charset=us-ascii;
 name="patch-cpu-idle"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cpu-idle"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 3
//  EXTRAVERSION = -ac3
--- 2.4/include/linux/pm.h	Thu Jan  4 23:50:47 2001
+++ build-2.4/include/linux/pm.h	Sun Apr  8 21:02:02 2001
@@ -186,6 +186,8 @@
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
+int cpu_is_idle(void);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */
--- 2.4/kernel/sched.c	Sat Apr  7 22:02:27 2001
+++ build-2.4/kernel/sched.c	Sun Apr  8 21:02:37 2001
@@ -1242,6 +1242,28 @@
 	sched_data->last_schedule = get_cycles();
 }
 
+/**
+ * cpu_is_idle - helper function for idle functions
+ * 
+ * pm_idle functions must call this function to verify that
+ * the cpu is really idle.
+ * The return value is valid until local interrupts are
+ * reenabled.
+ * Return values:
+ * 1: go into power saving mode.
+ * 0: cpu is not idle, return to schedule()
+ */
+int cpu_is_idle(void)
+{
+	if (current->need_resched)
+		return 0;
+
+	if (softirq_active(smp_processor_id()) & softirq_mask(smp_processor_id()))
+		return 0;
+
+	return 1;
+}
+
 extern void init_timervecs (void);
 
 void __init sched_init(void)
--- 2.4/kernel/ksyms.c	Sat Apr  7 22:02:27 2001
+++ build-2.4/kernel/ksyms.c	Sun Apr  8 21:42:48 2001
@@ -440,6 +440,7 @@
 #endif
 EXPORT_SYMBOL(kstat);
 EXPORT_SYMBOL(nr_running);
+EXPORT_SYMBOL(cpu_is_idle);
 
 /* misc */
 EXPORT_SYMBOL(panic);
--- 2.4/arch/i386/kernel/process.c	Thu Feb 22 22:28:52 2001
+++ build-2.4/arch/i386/kernel/process.c	Sun Apr  8 21:25:23 2001
@@ -81,7 +81,7 @@
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
-		if (!current->need_resched)
+		if (cpu_is_idle())
 			safe_halt();
 		else
 			__sti();
@@ -105,13 +105,10 @@
 	 */
 	oldval = xchg(&current->need_resched, -1);
 
-	if (!oldval)
-		asm volatile(
-			"2:"
-			"cmpl $-1, %0;"
-			"rep; nop;"
-			"je 2b;"
-				: :"m" (current->need_resched));
+	if (!oldval) {
+		while(cpu_is_idle())
+			rep_nop();
+	}
 }
 
 /*
@@ -131,7 +128,7 @@
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		while (!current->need_resched)
+		while (cpu_is_idle())
 			idle();
 		schedule();
 		check_pgt_cache();
--- 2.4/drivers/acpi/cpu.c	Sat Apr  7 22:02:01 2001
+++ build-2.4/drivers/acpi/cpu.c	Sat Apr  7 23:55:17 2001
@@ -148,7 +148,7 @@
 		unsigned long diff;
 		
 		__cli();
-		if (current->need_resched)
+		if (!cpu_is_idle())
 			goto out;
 		if (acpi_bm_activity())
 			goto sleep2;
@@ -171,7 +171,7 @@
 		unsigned long diff;
 
 		__cli();
-		if (current->need_resched)
+		if (!cpu_is_idle())
 			goto out;
 		if (acpi_bm_activity())
 			goto sleep2;
@@ -205,7 +205,7 @@
 		unsigned long diff;
 
 		__cli();
-		if (current->need_resched)
+		if (!cpu_is_idle())
 			goto out;
 
 		time = acpi_read_pm_timer();
@@ -235,7 +235,7 @@
 		unsigned long diff;
 
 		__cli();
-		if (current->need_resched)
+		if (!cpu_is_idle())
 			goto out;
 		time = acpi_read_pm_timer();
 		acpi_c1_count++;


--------------38599D87F9BACCE3C7E42C2F--


