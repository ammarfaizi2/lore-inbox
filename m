Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTKFA1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 19:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKFA1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 19:27:46 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:20097
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263282AbTKFA1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 19:27:45 -0500
Date: Wed, 5 Nov 2003 19:27:07 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: [PATCH][2.6] Don't disable IOAPIC with nosmp
Message-ID: <Pine.LNX.4.53.0311051856320.6825@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses bugzilla bug#1487 
http://bugme.osdl.org/show_bug.cgi?id=1487

We're disabling the IOAPIC when someone boots with the nosmp kernel 
parameter, this happens to break interrupt routing for some folks.

Tested on the following;
SMP P3 (afflicted system)
UP AMD K6
UP Intel Celeron
SMP 3x P133

Index: linux-2.6.0-test9-mm2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.0-test9-mm2/arch/i386/kernel/smpboot.c	5 Nov 2003 19:57:23 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm2/arch/i386/kernel/smpboot.c	5 Nov 2003 22:50:48 -0000
@@ -995,11 +995,8 @@ static void __init smp_boot_cpus(unsigne
 	 * If SMP should be disabled, then really disable it!
 	 */
 	if (!max_cpus) {
-		smp_found_config = 0;
-		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
-		smpboot_clear_io_apic_irqs();
+		printk(KERN_INFO "SMP mode deactivated, booting 1 Processor\n");
 		phys_cpu_present_map = physid_mask_of_physid(0);
-		return;
 	}
 
 	connect_bsp_APIC();
@@ -1022,6 +1019,9 @@ static void __init smp_boot_cpus(unsigne
 
 	kicked = 1;
 	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
+		if (kicked > max_cpus)
+			break;
+
 		apicid = cpu_present_to_apicid(bit);
 		/*
 		 * Don't even attempt to start the boot CPU!
