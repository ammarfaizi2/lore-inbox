Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTJ2BPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 20:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTJ2BPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 20:15:32 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27356 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261823AbTJ2BP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 20:15:28 -0500
Subject: [PATCH] linxu-2.4.23-pre8_cpu-map-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo.tosatti@cyclades.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067390071.23152.63.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Oct 2003 17:14:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, All,

        I noticed on x440s that when HT is disabled in the BIOS I was
having problems properly booting 2.4 in ACPI mode. Further investigation
found a subtle problem w/ smp_boot_cpus() when clustered_acpi_mode is
set. 

During bootup, phys_cpu_present_map is initialized by ORing
apicid_to_phys_cpu_present() for each cpu apicid(see MP_processor_info).
On flat mode boxes this translates to "phys_cpu_present_map |=
(1<<apicid)". 

On clustered_apic_mode boxes, since we're using phyiscal apic addresses,
the apicids are not sequential so it is possible the
phys_cpu_present_map can have holes in it (see
apicid_to_phys_cpu_present()). 

The problem arises in smp_boot_cpus() because when we are booting the
cpus, we iterate through each apicid, however we bit-AND
phys_cpu_present_map w/ (1<<apicid)  rather then using
apicid_to_phys_cpu_present(apicid). This may cause us to try to boot
apicids that do not exist. 

The following patch corrects the problem by always bit-ANDing
phys_cpu_present_map with apicid_to_phys_cpu_present(). This is safe for
flat mode boxes, as apicid_to_phys_cpu_present(apicid) translates to
(1<<apicid). 

Additionally, the patch insures we do not try to boot BAD_APICIDs and
removes a hack that was added to mpparse.c which worked around this
problem in the non-ACPI boot path.

In 2.5 we do not have this problem as we use logical rather then
physical apic addressing. 

Please consider for inclusion into your tree.

thanks
-john


diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Tue Oct 28 16:53:53 2003
+++ b/arch/i386/kernel/mpparse.c	Tue Oct 28 16:53:53 2003
@@ -587,10 +587,6 @@
 		++mpc_record;
 	}
 
-	if (clustered_apic_mode){
-		phys_cpu_present_map = logical_cpu_present_map;
-	}
-
 
 	printk("Enabling APIC mode: ");
 	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Tue Oct 28 16:53:53 2003
+++ b/arch/i386/kernel/process.c	Tue Oct 28 16:53:53 2003
@@ -44,6 +44,7 @@
 #include <asm/irq.h>
 #include <asm/desc.h>
 #include <asm/mmu_context.h>
+#include <asm/smpboot.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -377,7 +378,7 @@
 		   if its not, default to the BSP */
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
+		      !(phys_cpu_present_map & apicid_to_phys_cpu_present(cpuid)))
 			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Tue Oct 28 16:53:53 2003
+++ b/arch/i386/kernel/smpboot.c	Tue Oct 28 16:53:53 2003
@@ -1108,13 +1108,17 @@
 
 	for (bit = 0; bit < NR_CPUS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
+		
+		/* don't try to boot BAD_APICID */
+		if (apicid == BAD_APICID)
+			continue; 
 		/*
 		 * Don't even attempt to start the boot CPU!
 		 */
 		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1ul << bit)))
+		if (!(phys_cpu_present_map & apicid_to_phys_cpu_present(apicid)))
 			continue;
 		if (max_cpus <= cpucount+1)
 			continue;
@@ -1125,7 +1129,8 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1ul << bit)))
+			(phys_cpu_present_map & 
+				apicid_to_phys_cpu_present(apicid)))
 			printk("CPU #%d/0x%02x not responding - cannot use it.\n",
 								bit, apicid);
 	}



