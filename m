Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVC2Cac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVC2Cac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVC2Cac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:30:32 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:27633 "EHLO
	trane.bluesong.net") by vger.kernel.org with ESMTP id S262153AbVC2C3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:29:37 -0500
Date: Mon, 28 Mar 2005 18:29:35 -0800
From: Jack F Vogel <jfv@bluesong.net>
To: linux-kernel@vger.kernel.org
Cc: jfv@us.ibm.com
Subject: RFC: [PATCH] check nmi watchdog is broken
Message-ID: <20050329022935.GA25608@trane.bluesong.net>
Reply-To: jfv@bluesong.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A bug against an xSeries system showed up recently
noting that the check_nmi_watchdog() test was failing.

I have been investigating it and discovered in both
i386 and x86_64 the recent change to the routine
to use the cpu_callin_map has uncovered a problem.
Prior to that change, on an SMP box, the test was
trivally passing because all cpu's were found to
not yet be online, but now with the callin_map they
are discovered, it goes on to test the counter
and they have not yet begun to increment, so it
announces a CPU is stuck and bails out.

On all the systems I have access to test, the announcement
of failure is also bougs... by the time you can login
and check /proc/interrupts, the NMI count is happily
incrementing on all CPUs. Its just that the test is
being done too early.

I have tried moving the call to the test around a bit,
and it was always too early. I finally hit on this
proposed solution, it delays the routine via a
late_initcall(), seems like the right solution to
me. 

Please copy me on responses.

Regards,

Jack



--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="watchdog.patch"

diff -Naur linux-2.6.11/arch/i386/kernel/apic.c linux-2.6.11-jfv/arch/i386/kernel/apic.c
--- linux-2.6.11/arch/i386/kernel/apic.c	2005-03-01 23:38:33.000000000 -0800
+++ linux-2.6.11-jfv/arch/i386/kernel/apic.c	2005-03-28 09:12:15.000000000 -0800
@@ -1265,8 +1265,6 @@
 
 	setup_local_APIC();
 
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-		check_nmi_watchdog();
 #ifdef CONFIG_X86_IO_APIC
 	if (smp_found_config)
 		if (!skip_ioapic_setup && nr_ioapics)
diff -Naur linux-2.6.11/arch/i386/kernel/io_apic.c linux-2.6.11-jfv/arch/i386/kernel/io_apic.c
--- linux-2.6.11/arch/i386/kernel/io_apic.c	2005-03-01 23:37:54.000000000 -0800
+++ linux-2.6.11-jfv/arch/i386/kernel/io_apic.c	2005-03-28 09:13:05.000000000 -0800
@@ -2171,7 +2171,6 @@
 				disable_8259A_irq(0);
 				setup_nmi();
 				enable_8259A_irq(0);
-				check_nmi_watchdog();
 			}
 			return;
 		}
@@ -2194,7 +2193,6 @@
 				add_pin_to_irq(0, 0, pin2);
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
-				check_nmi_watchdog();
 			}
 			return;
 		}
diff -Naur linux-2.6.11/arch/i386/kernel/nmi.c linux-2.6.11-jfv/arch/i386/kernel/nmi.c
--- linux-2.6.11/arch/i386/kernel/nmi.c	2005-03-01 23:38:10.000000000 -0800
+++ linux-2.6.11-jfv/arch/i386/kernel/nmi.c	2005-03-28 09:23:17.000000000 -0800
@@ -102,20 +102,21 @@
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
-int __init check_nmi_watchdog (void)
+static int __init check_nmi_watchdog (void)
 {
 	unsigned int prev_nmi_count[NR_CPUS];
 	int cpu;
 
-	printk(KERN_INFO "testing NMI watchdog ... ");
+	if (nmi_watchdog == NMI_NONE)
+		return 0;
+
+	printk(KERN_INFO "Testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
-	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
-           as they come up. */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 #ifdef CONFIG_SMP
 		/* Check cpu_callin_map here because that is set
@@ -139,6 +140,8 @@
 
 	return 0;
 }
+/* This needs to happen later in boot so counters are working */
+late_initcall(check_nmi_watchdog);
 
 static int __init setup_nmi_watchdog(char *str)
 {
diff -Naur linux-2.6.11/arch/i386/kernel/smpboot.c linux-2.6.11-jfv/arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11-jfv/arch/i386/kernel/smpboot.c	2005-03-28 09:12:37.000000000 -0800
@@ -1077,9 +1077,6 @@
 			printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, cpu, smp_num_siblings);
 	}
 
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-		check_nmi_watchdog();
-
 	smpboot_setup_io_apic();
 
 	setup_boot_APIC_clock();
diff -Naur linux-2.6.11/arch/x86_64/kernel/io_apic.c linux-2.6.11-jfv/arch/x86_64/kernel/io_apic.c
--- linux-2.6.11/arch/x86_64/kernel/io_apic.c	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11-jfv/arch/x86_64/kernel/io_apic.c	2005-03-28 09:24:28.000000000 -0800
@@ -1603,7 +1603,6 @@
 				disable_8259A_irq(0);
 				setup_nmi();
 				enable_8259A_irq(0);
-				check_nmi_watchdog();
 			}
 			return;
 		}
@@ -1623,7 +1622,6 @@
 			nmi_watchdog_default();
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
-				check_nmi_watchdog();
 			}
 			return;
 		}
diff -Naur linux-2.6.11/arch/x86_64/kernel/nmi.c linux-2.6.11-jfv/arch/x86_64/kernel/nmi.c
--- linux-2.6.11/arch/x86_64/kernel/nmi.c	2005-03-01 23:38:08.000000000 -0800
+++ linux-2.6.11-jfv/arch/x86_64/kernel/nmi.c	2005-03-28 09:27:03.000000000 -0800
@@ -112,17 +112,20 @@
 	} 	
 }
 
-int __init check_nmi_watchdog (void)
+static int __init check_nmi_watchdog (void)
 {
 	int counts[NR_CPUS];
 	int cpu;
 
+	if (nmi_watchdog == NMI_NONE)
+		return 0;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC && !cpu_has_lapic())  {
 		nmi_watchdog = NMI_NONE;
 		return -1; 
 	}	
 
-	printk(KERN_INFO "testing NMI watchdog ... ");
+	printk(KERN_INFO "Testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		counts[cpu] = cpu_pda[cpu].__nmi_count; 
@@ -154,6 +157,8 @@
 
 	return 0;
 }
+/* Have this called later during boot so counters are updating */
+late_initcall(check_nmi_watchdog);
 
 int __init setup_nmi_watchdog(char *str)
 {

--ikeVEW9yuYc//A+q--
