Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946738AbWJTAJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946738AbWJTAJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946735AbWJTAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:09:24 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:27581 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946733AbWJTAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:09:24 -0400
Date: Thu, 19 Oct 2006 17:09:22 -0700
Message-Id: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
Subject: [PATCH 1/5] Skip timer works.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 20 Oct 2006 00:09:21.0851 (UTC) FILETIME=[FE6BE8B0:01C6F3DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way to disable the timer IRQ routing check via a boot option.  The
VMI timer code uses this to avoid triggering the pester Mingo code, which
probes for some very unusual and broken motherboard routings.  It fires
100% of the time when using a paravirtual delay mechanism instead of
using a realtime delay, since there is no elapsed real time, and the 4 timer
IRQs have not yet been delivered.

In addition, it is entirely possible, though improbable, that this bug
could surface on real hardware which picks a particularly bad time to enter
SMM mode, causing a long latency during one of the timer IRQs.

While here, make check_timer be __init.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -603,8 +603,6 @@ and is between 256 and 4096 characters. 
 
 	hugepages=	[HW,IA-32,IA-64] Maximal number of HugeTLB pages.
 
-	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
-
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
 			     keyboard and cannot control its state
@@ -1060,8 +1058,13 @@ and is between 256 and 4096 characters. 
 			in certain environments such as networked servers or
 			real-time systems.
 
+	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
+
 	noirqdebug	[IA-32] Disables the code which attempts to detect and
 			disable unhandled interrupt sources.
+
+	noirqtest	[IA-32,APIC] Disables the code which tests for broken
+			timer IRQ sources.
 
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
===================================================================
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1864,6 +1864,15 @@ static void __init setup_ioapic_ids_from
 static void __init setup_ioapic_ids_from_mpc(void) { }
 #endif
 
+int timer_irq_really_works __initdata;
+int __init irqtest_disable(char *str)
+{
+	timer_irq_really_works = 1;
+	return 1;
+}
+
+__setup("noirqtest", irqtest_disable);
+
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
  * about the timer IRQ. We do the following to work around the situation:
@@ -1872,9 +1881,12 @@ static void __init setup_ioapic_ids_from
  *	- if this function detects that timer IRQs are defunct, then we fall
  *	  back to ISA timer IRQs
  */
-static int __init timer_irq_works(void)
+int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
+
+	if (timer_irq_really_works)
+		return 1;
 
 	local_irq_enable();
 	/* Let ten ticks pass... */
@@ -2146,7 +2158,7 @@ int timer_uses_ioapic_pin_0;
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
-static inline void check_timer(void)
+static inline void __init check_timer(void)
 {
 	int apic1, pin1, apic2, pin2;
 	int vector;
