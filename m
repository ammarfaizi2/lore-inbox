Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTKXW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKXW4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:56:24 -0500
Received: from holomorphy.com ([199.26.172.102]:42425 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261473AbTKXWze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:55:34 -0500
Date: Mon, 24 Nov 2003 14:55:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Len Brown <len.brown@intel.com>
Cc: Eduard Bloch <edi@gmx.de>, linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Message-ID: <20031124225523.GY22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Len Brown <len.brown@intel.com>, Eduard Bloch <edi@gmx.de>,
	linux-kernel@vger.kernel.org, davej@redhat.com
References: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com> <20031123204532.GA6093@zombie.inka.de> <1069654747.2812.689.camel@dhcppc4> <20031124070016.GX22764@holomorphy.com> <1069692557.3035.17.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069692557.3035.17.camel@dhcppc4>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 02:00, William Lee Irwin III wrote:
>> A similar (but more elaborate) fix is in 2.6.

On Mon, Nov 24, 2003 at 11:49:18AM -0500, Len Brown wrote:
> Why is the additional variable "kicked" in 2.6 necessary?
> Appears that kicked == (cpucount + 1), and the loop already
> compares that to NR_CPUS via max_cpus:
>                 if (max_cpus <= cpucount+1)
>                         continue;
> Though I think it would read more clearly this way:
>                 if (cpucount + 1 >= max_cpus)
>                         break;
> Speaking of max_cpus, it would probably be a good thing if maxcpus() did
> not allow the administrator to set max_cpus > NR_CPUS at boot time.

There's some kind of shenanigan going on with cpucount I can't be arsed
to decipher where it's incremented and decremented all over the place;
do_boot_cpu() returns status, so counting successes got the bug fixed.
Fixing max_cpus > NR_CPUS has some kind of core impact. So I've pretty
much punted on both killing kicked and fixing max_cpus. I anticipate
a particular someone I don't want to hear from complaining loudly.

Maybe something like the below (untested) would be helpful.


-- wli


Propagate kicked down to do_boot_cpu() and nuke the redundant cpucount.
The choice of which to nuke was based on cpucount being modified all
over the place and actually being 1 less than all cpus, vs. kicked being
a counter maintained all in one place and actually representing the
total number of cpus. Old semantics are AFAICT preserved apart from
terminating the wakeup loop at kicked < max(NR_CPUS, max_cpus), which is
actually a darn good idea since there's no reason to fiddle with the
rest of the APIC ID space once we've got all the cpus we're allowed to.


diff -urpN linux-2.6.0-test9/arch/i386/kernel/smpboot.c maxcpus-2.6.0-test9/arch/i386/kernel/smpboot.c
--- linux-2.6.0-test9/arch/i386/kernel/smpboot.c	2003-10-25 11:43:36.000000000 -0700
+++ maxcpus-2.6.0-test9/arch/i386/kernel/smpboot.c	2003-11-24 14:44:50.000000000 -0800
@@ -426,8 +426,6 @@ void __init smp_callin(void)
 		synchronize_tsc_ap();
 }
 
-int cpucount;
-
 extern int cpu_idle(void);
 
 /*
@@ -772,7 +770,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 
 extern cpumask_t cpu_initialized;
 
-static int __init do_boot_cpu(int apicid)
+static int __init do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -781,11 +779,10 @@ static int __init do_boot_cpu(int apicid
 {
 	struct task_struct *idle;
 	unsigned long boot_error;
-	int timeout, cpu;
+	int timeout;
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
-	cpu = ++cpucount;
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -871,7 +868,6 @@ static int __init do_boot_cpu(int apicid
 		unmap_cpu_to_logical_apicid(cpu);
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		cpu_clear(cpu, cpu_initialized); /* was set by cpu_init() */
-		cpucount--;
 	}
 
 	/* mark "stuck" area as not stuck */
@@ -1021,7 +1017,7 @@ static void __init smp_boot_cpus(unsigne
 	Dprintk("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));
 
 	kicked = 1;
-	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
+	for (bit = 0; kicked < min(NR_CPUS, maxcpus) && bit < MAX_APICS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
 		/*
 		 * Don't even attempt to start the boot CPU!
@@ -1031,10 +1027,7 @@ static void __init smp_boot_cpus(unsigne
 
 		if (!check_apicid_present(bit))
 			continue;
-		if (max_cpus <= cpucount+1)
-			continue;
-
-		if (do_boot_cpu(apicid))
+		if (do_boot_cpu(apicid, kicked))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 		else
@@ -1055,7 +1048,7 @@ static void __init smp_boot_cpus(unsigne
 			bogosum += cpu_data[cpu].loops_per_jiffy;
 	printk(KERN_INFO
 		"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
-		cpucount+1,
+		kicked,
 		bogosum/(500000/HZ),
 		(bogosum/(5000/HZ))%100);
 	
@@ -1069,7 +1062,7 @@ static void __init smp_boot_cpus(unsigne
 	 * approved Athlon
 	 */
 	if (tainted & TAINT_UNSAFE_SMP) {
-		if (cpucount)
+		if (kicked > 1)
 			printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
 		else
 			tainted &= ~TAINT_UNSAFE_SMP;
@@ -1113,7 +1106,7 @@ static void __init smp_boot_cpus(unsigne
 	/*
 	 * Synchronize the TSC with the AP
 	 */
-	if (cpu_has_tsc && cpucount && cpu_khz)
+	if (cpu_has_tsc && kicked > 1 && cpu_khz)
 		synchronize_tsc_bp();
 }
 
