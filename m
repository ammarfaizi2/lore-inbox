Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUJQQRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUJQQRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUJQQQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:16:38 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:28037 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S269188AbUJQQKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:10:03 -0400
Subject: [PATCH 6/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - smpboot.c
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032575.3023.128.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:11:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro Dprintk (defined in apic.h included via smp.h) with pr_debug from kernel.h.
Use  pr_info when appropriate.
Fix consistency of printks.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/smpboot.c	2004-10-17 16:57:00.505589080 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/smpboot.c	2004-10-17 17:01:20.484066344 +0200
@@ -200,7 +200,7 @@ static void __init synchronize_tsc_bp (v
 	unsigned long one_usec;
 	int buggy = 0;
 
-	printk(KERN_INFO "checking TSC synchronization across %u CPUs: ", num_booting_cpus());
+	pr_info("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
 
 	/* convert from kcyc/sec to cyc/usec */
 	one_usec = cpu_khz / 1000;
@@ -272,20 +272,20 @@ static void __init synchronize_tsc_bp (v
 			long realdelta;
 			if (!buggy) {
 				buggy = 1;
-				printk("\n");
+				pr_info("\n");
 			}
 			realdelta = delta;
 			do_div(realdelta, one_usec);
 			if (tsc_values[i] < avg)
 				realdelta = -realdelta;
 
-			printk(KERN_INFO "CPU#%d had %ld usecs TSC skew, fixed it up.\n", i, realdelta);
+			pr_info("CPU#%d had %ld usecs TSC skew, fixed it up.\n", i, realdelta);
 		}
 
 		sum += delta;
 	}
 	if (!buggy)
-		printk("passed.\n");
+		pr_info("passed.\n");
 }
 
 static void __init synchronize_tsc_ap (void)
@@ -337,11 +337,11 @@ void __init smp_callin(void)
 	phys_id = GET_APIC_ID(apic_read(APIC_ID));
 	cpuid = smp_processor_id();
 	if (cpu_isset(cpuid, cpu_callin_map)) {
-		printk("huh, phys CPU#%d, CPU#%d already present??\n",
+		printk(KERN_ERR "huh, phys CPU#%d, CPU#%d already present??\n",
 					phys_id, cpuid);
 		BUG();
 	}
-	Dprintk("CPU#%d (phys ID: %d) waiting for CALLOUT\n", cpuid, phys_id);
+	pr_debug("CPU#%d (phys ID: %d) waiting for CALLOUT\n", cpuid, phys_id);
 
 	/*
 	 * STARTUP IPIs are fragile beasts as they might sometimes
@@ -365,7 +365,7 @@ void __init smp_callin(void)
 	}
 
 	if (!time_before(jiffies, timeout)) {
-		printk("BUG: CPU%d started up but did not get a callout!\n",
+		printk(KERN_ERR "BUG: CPU%d started up but did not get a callout!\n",
 			cpuid);
 		BUG();
 	}
@@ -377,7 +377,7 @@ void __init smp_callin(void)
 	 * boards)
 	 */
 
-	Dprintk("CALLIN, before setup_local_APIC().\n");
+	pr_debug("CALLIN, before setup_local_APIC().\n");
 	smp_callin_clear_local_apic();
 	setup_local_APIC();
 	map_cpu_to_logical_apicid();
@@ -388,7 +388,7 @@ void __init smp_callin(void)
 	 * Get our bogomips.
 	 */
 	calibrate_delay();
-	Dprintk("Stack at about %p\n",&cpuid);
+	pr_debug("Stack at about %p\n",&cpuid);
 
 	/*
 	 * Save our processor parameters
@@ -577,10 +577,10 @@ wakeup_secondary_cpu(int logical_apicid,
 	/* Kick the second */
 	apic_write_around(APIC_ICR, APIC_DM_NMI | APIC_DEST_LOGICAL);
 
-	Dprintk("Waiting for send to finish...\n");
+	pr_debug("Waiting for send to finish...\n");
 	timeout = 0;
 	do {
-		Dprintk("+");
+		pr_debug("+");
 		udelay(100);
 		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
 	} while (send_status && (timeout++ < 1000));
@@ -598,12 +598,12 @@ wakeup_secondary_cpu(int logical_apicid,
 		apic_write(APIC_ESR, 0);
 	}
 	accept_status = (apic_read(APIC_ESR) & 0xEF);
-	Dprintk("NMI sent.\n");
+	pr_debug("NMI sent.\n");
 
 	if (send_status)
-		printk("APIC never delivered???\n");
+		printk(KERN_ERR "APIC never delivered???\n");
 	if (accept_status)
-		printk("APIC delivery error (%lx).\n", accept_status);
+		printk(KERN_ERR "APIC delivery error (%lx).\n", accept_status);
 
 	return (send_status | accept_status);
 }
@@ -625,7 +625,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 		apic_read(APIC_ESR);
 	}
 
-	Dprintk("Asserting INIT.\n");
+	pr_debug("Asserting INIT.\n");
 
 	/*
 	 * Turn INIT on target chip
@@ -638,17 +638,17 @@ wakeup_secondary_cpu(int phys_apicid, un
 	apic_write_around(APIC_ICR, APIC_INT_LEVELTRIG | APIC_INT_ASSERT
 				| APIC_DM_INIT);
 
-	Dprintk("Waiting for send to finish...\n");
+	pr_debug("Waiting for send to finish...\n");
 	timeout = 0;
 	do {
-		Dprintk("+");
+		pr_debug("+");
 		udelay(100);
 		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
 	} while (send_status && (timeout++ < 1000));
 
 	mdelay(10);
 
-	Dprintk("Deasserting INIT.\n");
+	pr_debug("Deasserting INIT.\n");
 
 	/* Target chip */
 	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(phys_apicid));
@@ -656,10 +656,10 @@ wakeup_secondary_cpu(int phys_apicid, un
 	/* Send IPI */
 	apic_write_around(APIC_ICR, APIC_INT_LEVELTRIG | APIC_DM_INIT);
 
-	Dprintk("Waiting for send to finish...\n");
+	pr_debug("Waiting for send to finish...\n");
 	timeout = 0;
 	do {
-		Dprintk("+");
+		pr_debug("+");
 		udelay(100);
 		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
 	} while (send_status && (timeout++ < 1000));
@@ -680,16 +680,16 @@ wakeup_secondary_cpu(int phys_apicid, un
 	/*
 	 * Run STARTUP IPI loop.
 	 */
-	Dprintk("#startup loops: %d.\n", num_starts);
+	pr_debug("#startup loops: %d.\n", num_starts);
 
 	maxlvt = get_maxlvt();
 
 	for (j = 1; j <= num_starts; j++) {
-		Dprintk("Sending STARTUP #%d.\n",j);
+		pr_debug("Sending STARTUP #%d.\n",j);
 		apic_read_around(APIC_SPIV);
 		apic_write(APIC_ESR, 0);
 		apic_read(APIC_ESR);
-		Dprintk("After apic_write.\n");
+		pr_debug("After apic_write.\n");
 
 		/*
 		 * STARTUP IPI
@@ -708,12 +708,12 @@ wakeup_secondary_cpu(int phys_apicid, un
 		 */
 		udelay(300);
 
-		Dprintk("Startup point 1.\n");
+		pr_debug("Startup point 1.\n");
 
-		Dprintk("Waiting for send to finish...\n");
+		pr_debug("Waiting for send to finish...\n");
 		timeout = 0;
 		do {
-			Dprintk("+");
+			pr_debug("+");
 			udelay(100);
 			send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
 		} while (send_status && (timeout++ < 1000));
@@ -733,12 +733,12 @@ wakeup_secondary_cpu(int phys_apicid, un
 		if (send_status || accept_status)
 			break;
 	}
-	Dprintk("After Startup.\n");
+	pr_debug("After Startup.\n");
 
 	if (send_status)
-		printk("APIC never delivered???\n");
+		printk(KERN_ERR "APIC never delivered???\n");
 	if (accept_status)
-		printk("APIC delivery error (%lx).\n", accept_status);
+		printk(KERN_ERR "APIC delivery error (%lx).\n", accept_status);
 
 	return (send_status | accept_status);
 }
@@ -785,7 +785,7 @@ static int __init do_boot_cpu(int apicid
 
 	atomic_set(&init_deasserted, 0);
 
-	Dprintk("Setting warm reset code and vector.\n");
+	pr_debug("Setting warm reset code and vector.\n");
 
 	store_NMI_vector(&nmi_high, &nmi_low);
 
@@ -800,9 +800,9 @@ static int __init do_boot_cpu(int apicid
 		/*
 		 * allow APs to start initializing.
 		 */
-		Dprintk("Before Callout %d.\n", cpu);
+		pr_debug("Before Callout %d.\n", cpu);
 		cpu_set(cpu, cpu_callout_map);
-		Dprintk("After Callout %d.\n", cpu);
+		pr_debug("After Callout %d.\n", cpu);
 
 		/*
 		 * Wait 5s total for a response
@@ -815,10 +815,10 @@ static int __init do_boot_cpu(int apicid
 
 		if (cpu_isset(cpu, cpu_callin_map)) {
 			/* number CPUs logically, starting from 1 (BSP is 0) */
-			Dprintk("OK.\n");
+			pr_debug("OK.\n");
 			printk("CPU%d: ", cpu);
 			print_cpu_info(&cpu_data[cpu]);
-			Dprintk("CPU has booted.\n");
+			pr_debug("CPU has booted.\n");
 		} else {
 			boot_error= 1;
 			if (*((volatile unsigned char *)trampoline_base)
@@ -966,7 +966,7 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	if (!max_cpus) {
 		smp_found_config = 0;
-		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
+		pr_info("SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		return;
@@ -986,7 +986,7 @@ static void __init smp_boot_cpus(unsigne
 	 * bits 0-3 are quad0, 4-7 are quad1, etc. A perverse twist on the 
 	 * clustered apic ID.
 	 */
-	Dprintk("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));
+	pr_debug("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));
 
 	kicked = 1;
 	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
@@ -1003,7 +1003,7 @@ static void __init smp_boot_cpus(unsigne
 			continue;
 
 		if (do_boot_cpu(apicid))
-			printk("CPU #%d not responding - cannot use it.\n",
+			printk(KERN_ERR "CPU #%d not responding - cannot use it.\n",
 								apicid);
 		else
 			++kicked;
@@ -1017,17 +1017,16 @@ static void __init smp_boot_cpus(unsigne
 	/*
 	 * Allow the user to impress friends.
 	 */
-	Dprintk("Before bogomips.\n");
+	pr_debug("Before bogomips.\n");
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		if (cpu_isset(cpu, cpu_callout_map))
 			bogosum += cpu_data[cpu].loops_per_jiffy;
-	printk(KERN_INFO
-		"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
+	pr_info("Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 		cpucount+1,
 		bogosum/(500000/HZ),
 		(bogosum/(5000/HZ))%100);
 	
-	Dprintk("Before bogocount - setting activated=1.\n");
+	pr_debug("Before bogocount - setting activated=1.\n");
 
 	if (smp_b_stepping)
 		printk(KERN_WARNING "WARNING: SMP operation may be unreliable with B stepping processors.\n");
@@ -1038,12 +1037,12 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	if (tainted & TAINT_UNSAFE_SMP) {
 		if (cpucount)
-			printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
+			pr_info("WARNING: This combination of AMD processors is not suitable for SMP.\n");
 		else
 			tainted &= ~TAINT_UNSAFE_SMP;
 	}
 
-	Dprintk("Boot done.\n");
+	pr_debug("Boot done.\n");
 
 	/*
 	 * construct cpu_sibling_map[], so that we can tell sibling CPUs


