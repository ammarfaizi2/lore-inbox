Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132519AbRDHI0l>; Sun, 8 Apr 2001 04:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDHI0a>; Sun, 8 Apr 2001 04:26:30 -0400
Received: from colorfullife.com ([216.156.138.34]:33806 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132519AbRDHI0V>;
	Sun, 8 Apr 2001 04:26:21 -0400
Message-ID: <3ACF9473.343CD4A2@colorfullife.com>
Date: Sun, 08 Apr 2001 00:28:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: softirq buggy [Re: Serial port latency]
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)> <000401c0b828$bbdf7380$5517fea9@local> <20010331003645.F1579@atrey.karlin.mff.cuni.cz> <3AC6559E.575C4BAA@colorfullife.com> <20010404010759.A102@bug.ucw.cz> <000901c0bd4c$c16fd5f0$5517fea9@local> <20010406140052.A16871@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------5EDF41A021C886CE3E02C483"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5EDF41A021C886CE3E02C483
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> 
> Ok. I was missing the fact it is checked on going userspace.
>

What about the attached patch?

--
	Manfred
--------------5EDF41A021C886CE3E02C483
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
--- 2.4/include/linux/interrupt.h	Thu Feb 22 22:29:53 2001
+++ build-2.4/include/linux/interrupt.h	Sat Apr  7 23:51:31 2001
@@ -269,4 +269,25 @@
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
 
+/**
+ * cpu_is_idle - helper function for idle functions
+ * 
+ * pm_idle functions must call this function to verify that
+ * the cpu is really idle. It must be called with disabled
+ * local interrupts.
+ * Return values:
+ * 0: cpu was not idle.
+ * 1: go into power saving mode.
+ */
+static inline int cpu_is_idle(void)
+{
+	if (current->need_resched) {
+		return 0;
+	}
+	if (softirq_active(smp_processor_id()) & softirq_mask(smp_processor_id())) {
+		do_softirq();
+		return 0;
+	}
+	return 1;
+}
 #endif
--- 2.4/arch/i386/kernel/process.c	Thu Feb 22 22:28:52 2001
+++ build-2.4/arch/i386/kernel/process.c	Sat Apr  7 23:51:46 2001
@@ -73,6 +73,7 @@
 	hlt_counter--;
 }
 
+
 /*
  * We use this if we don't have any better
  * idle routine..
@@ -81,7 +82,7 @@
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
-		if (!current->need_resched)
+		if (cpu_is_idle())
 			safe_halt();
 		else
 			__sti();
@@ -92,26 +93,21 @@
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
+ *
+ * Isn't this identical to default_idle with the 'no-hlt' boot
+ * option? <manfred@colorfullife.com>
  */
 static void poll_idle (void)
 {
 	int oldval;
 
+	for(;;) {
+		if (!cpu_is_idle())
+			break;
+		__sti();
+		rep_nop();
+	}
 	__sti();
-
-	/*
-	 * Deal with another CPU just having chosen a thread to
-	 * run here:
-	 */
-	oldval = xchg(&current->need_resched, -1);
-
-	if (!oldval)
-		asm volatile(
-			"2:"
-			"cmpl $-1, %0;"
-			"rep; nop;"
-			"je 2b;"
-				: :"m" (current->need_resched));
 }
 
 /*
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

--------------5EDF41A021C886CE3E02C483--

