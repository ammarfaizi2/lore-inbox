Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVDLVaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVDLVaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVDLV3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:29:37 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:62469 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S262969AbVDLVYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:24:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Hotplug_sig] RE: [PATCH 1/6]sep initializing rework
Date: Tue, 12 Apr 2005 16:23:46 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB5@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Hotplug_sig] RE: [PATCH 1/6]sep initializing rework
Thread-Index: AcU/V/zEAgIOCEcxScKewF5TSmpUBwAMG8iAAAbEMOA=
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Li Shaohua" <shaohua.li@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "ACPI-DEV" <acpi-devel@lists.sourceforge.net>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Apr 2005 21:23:48.0587 (UTC) FILETIME=[EA78DBB0:01C53FA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> This is a hotplug CPU patch for i386, done against 2.6.12-rc2-mm3.
> Somewhat alternative to the one posted by Li Shaohua, but not really
(and I didn't mean that :). 
> If you look closer, our patches are different and can complement each
other I think. 
> Li did great job on sep, after-offline cleanup, __devinit etc., and I
have some radical changes 
> in the AP bringup mechanism. I left alone __init to __devinit part (I
was going through it lately, 
> but I think even though I had few more than Li did, he covered it
sufficiently perhaps). 
> I started having doubts in free_initmem() vs __devinit because look
how many of __init's left! just a few :). 
> I got rid of do_boot_cpu loop in smpboot.c because the loop 
> static void __init smp_init(void) {
>        unsigned int i;
>        /* FIXME: This should be done in userspace --RR */
>        for_each_present_cpu(i) {
>                if (num_online_cpus() >= max_cpus)
>                        break;
>                if (!cpu_online(i))
>                        cpu_up(i);
>        }
> ...
> does it again so why leave it in smpboot.c to boot AP's twice. 
> I also found that my system fails sooner or later when I try not to
synch runtime booted processor with others, 
> so I changed tsc synchronization to only sync between booting CPU and
the one that boots it. 
> The patch works for me on Intel 8x generic box, and on ES7000. 
> I was asked to separate my patch into smaller ones by the theme, but
I'm posting the entire patch for now, 
> because I think it is probably not the final one.
> I think (I hope) I will sync up with Li later on.
> My idea was that if we find a CPU core in ACPI (enabled or disabled),
we encounter for it in sibling map and 
> create a sysfs node accordingly, and cpu_possible_map will reflect
that. We take processors up/down 
> depending on physical presence using the existing node. That's the
scenario implemented on ES7000 
> that reports all possible cores in ACPI marking absent processors as
disabled. 
> Runtime enablement/disablement depends on sysfs only and the driving
agent can be anything (ACPI or user) 
> that triggers sysfs node for this processor.
> Thanks,
> --Natalie

I forgot to mention that while working on the patch, I found a problem
with ACPI driver while counting number of records in
acpi_table_parse_madt_family() (drivers/acpi/tables.c). It always
returns 0 for the number of records, so this should be fixed for my
patch to work properly, since I rely on number of lapic entries found by
ACPI. I am going to post a bugzilla on this, for now it worked for me as
follows:
        while (((unsigned long) entry) + sizeof(acpi_table_entry_header)
< madt_end) {
                if (entry->type == entry_id &&
	 -            (!max_entries || count++ < max_entries) 
       +            ((count++ < max_entries) || !max_entries))
(it wasn't incrementing count if max_entries are >0 ).

Sorry for using attachment in previous email, I am resending the patch
as in-line text:

diff -Naurp linux-2.6.11.6-mm/arch/i386/kernel/acpi/boot.c
linux-2.6.11.6-HC/arch/i386/kernel/acpi/boot.c
--- linux-2.6.11.6-mm/arch/i386/kernel/acpi/boot.c	2005-04-06
23:08:11.000000000 -0400
+++ linux-2.6.11.6-HC/arch/i386/kernel/acpi/boot.c	2005-04-12
08:08:28.000000000 -0400
@@ -229,7 +229,7 @@ acpi_parse_lapic (
 
 	/* no utility in registering a disabled processor */
 	if (processor->flags.enabled == 0)
-		return 0;
+		printk(KERN_DEBUG "apic %d is disabled\n",
processor->id);
 
 	x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
 
@@ -689,6 +689,9 @@ acpi_parse_madt_lapic_entries(void)
 		return count;
 	}
 
+	for (i = 0; i < count; i++)
+		cpu_set(i, cpu_possible_map);
+
 	count = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI,
acpi_parse_lapic_nmi, 0);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI
entry\n");
diff -Naurp linux-2.6.11.6-mm/arch/i386/kernel/cpu/common.c
linux-2.6.11.6-HC/arch/i386/kernel/cpu/common.c
--- linux-2.6.11.6-mm/arch/i386/kernel/cpu/common.c	2005-04-06
23:08:11.000000000 -0400
+++ linux-2.6.11.6-HC/arch/i386/kernel/cpu/common.c	2005-04-12
07:44:54.000000000 -0400
@@ -615,7 +615,11 @@ void __init cpu_init (void)
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 	if (current->mm)
+#ifdef CONFIG_HOTPLUG_CPU
+		current->mm = NULL;
+#else
 		BUG();
+#endif
 	enter_lazy_tlb(&init_mm, current);
 
 	load_esp0(t, thread);
diff -Naurp linux-2.6.11.6-mm/arch/i386/kernel/mpparse.c
linux-2.6.11.6-HC/arch/i386/kernel/mpparse.c
--- linux-2.6.11.6-mm/arch/i386/kernel/mpparse.c	2005-04-06
23:08:12.000000000 -0400
+++ linux-2.6.11.6-HC/arch/i386/kernel/mpparse.c	2005-04-12
08:16:57.000000000 -0400
@@ -125,7 +125,7 @@ static void __init MP_processor_info (st
 	physid_mask_t tmp;
  	
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
-		return;
+		printk(KERN_DEBUG "apicid %x was
disabled\n",m->mpc_apicid);
 
 	apicid = mpc_apic_id(m, translation_table[mpc_record]);
 
@@ -189,11 +189,13 @@ static void __init MP_processor_info (st
 		return;
 	}
 
+#ifndef CONFIG_HOTPLUG_CPU
 	if (num_processors >= maxcpus) {
 		printk(KERN_WARNING "WARNING: maxcpus limit of %i
reached."
 			" Processor ignored.\n", maxcpus); 
 		return;
 	}
+#endif
 	num_processors++;
 	ver = m->mpc_apicver;
 
diff -Naurp linux-2.6.11.6-mm/arch/i386/kernel/smpboot.c
linux-2.6.11.6-HC/arch/i386/kernel/smpboot.c
--- linux-2.6.11.6-mm/arch/i386/kernel/smpboot.c	2005-04-06
23:08:12.000000000 -0400
+++ linux-2.6.11.6-HC/arch/i386/kernel/smpboot.c	2005-04-12
08:40:08.000000000 -0400
@@ -73,6 +73,7 @@ cpumask_t cpu_online_map __cacheline_ali
 
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
+cpumask_t cpu_possible_map;
 static cpumask_t smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
@@ -195,7 +196,13 @@ valid_k7:
 static atomic_t tsc_start_flag = ATOMIC_INIT(0);
 static atomic_t tsc_count_start = ATOMIC_INIT(0);
 static atomic_t tsc_count_stop = ATOMIC_INIT(0);
-static unsigned long long tsc_values[NR_CPUS];
+union _tsc_values {
+	unsigned long long _tsc_value;
+	struct {
+		unsigned long tsc_value_high;
+		unsigned long tsc_value_low;
+	} _part;
+} tsc_values[NR_CPUS];
 
 #define NR_LOOPS 5
 
@@ -241,12 +248,6 @@ static void __init synchronize_tsc_bp (v
 
 		rdtscll(tsc_values[smp_processor_id()]);
 		/*
-		 * We clear the TSC in the last loop:
-		 */
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
-
-		/*
 		 * Wait for all APs to leave the synchronization point:
 		 */
 		while (atomic_read(&tsc_count_stop) !=
num_booting_cpus()-1)
@@ -259,7 +260,7 @@ static void __init synchronize_tsc_bp (v
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
 		if (cpu_isset(i, cpu_callout_map)) {
-			t0 = tsc_values[i];
+			t0 = tsc_values[i]._tsc_value;
 			sum += t0;
 		}
 	}
@@ -270,7 +271,7 @@ static void __init synchronize_tsc_bp (v
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_isset(i, cpu_callout_map))
 			continue;
-		delta = tsc_values[i] - avg;
+		delta = tsc_values[i]._tsc_value - avg;
 		if (delta < 0)
 			delta = -delta;
 		/*
@@ -284,7 +285,7 @@ static void __init synchronize_tsc_bp (v
 			}
 			realdelta = delta;
 			do_div(realdelta, one_usec);
-			if (tsc_values[i] < avg)
+			if (tsc_values[i]._tsc_value < avg)
 				realdelta = -realdelta;
 
 			printk(KERN_INFO "CPU#%d had %ld usecs TSC skew,
fixed it up.\n", i, realdelta);
@@ -312,9 +313,10 @@ static void __init synchronize_tsc_ap (v
 		while (atomic_read(&tsc_count_start) !=
num_booting_cpus())
 			mb();
 
-		rdtscll(tsc_values[smp_processor_id()]);
+		rdtscll(tsc_values[smp_processor_id()]._tsc_value);
 		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
+
write_tsc(tsc_values[master]._part.tsc_value_high,
+				tsc_values[master]._part.tsc_value_low);
 
 		atomic_inc(&tsc_count_stop);
 		while (atomic_read(&tsc_count_stop) !=
num_booting_cpus()) mb();
@@ -449,6 +451,7 @@ static void __init start_secondary(void 
 	local_irq_enable();
 
 	wmb();
+	enable_sep_cpu(0);
 	cpu_idle();
 }
 
@@ -843,7 +846,9 @@ static int __init do_boot_cpu(int apicid
 	x86_cpu_to_apicid[cpu] = apicid;
 	if (boot_error) {
 		/* Try to put things back the way they were before ...
*/
+#ifndef CONFIG_HOTPLUG_CPU
 		unmap_cpu_to_logical_apicid(cpu);
+#endif
 		cpu_clear(cpu, cpu_callout_map); /* was set here
(do_boot_cpu()) */
 		cpu_clear(cpu, cpu_initialized); /* was set by
cpu_init() */
 		cpucount--;
@@ -852,6 +857,8 @@ static int __init do_boot_cpu(int apicid
 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)trampoline_base) = 0;
 
+	if (cpu_has_tsc && cpu_khz)
+		synchronize_tsc_bp();
 	return boot_error;
 }
 
@@ -987,27 +994,6 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	Dprintk("CPU present map: %lx\n",
physids_coerce(phys_cpu_present_map));
 
-	kicked = 1;
-	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
-		apicid = cpu_present_to_apicid(bit);
-		/*
-		 * Don't even attempt to start the boot CPU!
-		 */
-		if ((apicid == boot_cpu_apicid) || (apicid ==
BAD_APICID))
-			continue;
-
-		if (!check_apicid_present(bit))
-			continue;
-		if (max_cpus <= cpucount+1)
-			continue;
-
-		if (do_boot_cpu(apicid))
-			printk("CPU #%d not responding - cannot use
it.\n",
-								apicid);
-		else
-			++kicked;
-	}
-
 	/*
 	 * Cleanup possible dangling ends...
 	 */
@@ -1057,13 +1043,17 @@ static void __init smp_boot_cpus(unsigne
 		struct cpuinfo_x86 *c = cpu_data + cpu;
 		int siblings = 0;
 		int i;
+#ifndef CONFIG_HOTPLUG_CPU
 		if (!cpu_isset(cpu, cpu_callout_map))
 			continue;
+#endif
 
 		if (smp_num_siblings > 1) {
 			for (i = 0; i < NR_CPUS; i++) {
+#ifndef CONFIG_HOTPLUG_CPU
 				if (!cpu_isset(i, cpu_callout_map))
 					continue;
+#endif
 				if (cpu_core_id[cpu] == cpu_core_id[i])
{
 					siblings++;
 					cpu_set(i,
cpu_sibling_map[cpu]);
@@ -1094,6 +1084,7 @@ static void __init smp_boot_cpus(unsigne
 
 	setup_boot_APIC_clock();
 
+	enable_sep_cpu(0);
 	/*
 	 * Synchronize the TSC with the AP
 	 */
@@ -1195,13 +1186,6 @@ void __cpu_die(unsigned int cpu)
 
 int __devinit __cpu_up(unsigned int cpu)
 {
-	/* In case one didn't come up */
-	if (!cpu_isset(cpu, cpu_callin_map)) {
-		printk(KERN_DEBUG "skipping cpu%d, didn't come
online\n", cpu);
-		local_irq_enable();
-		return -EIO;
-	}
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Already up, and in cpu_quiescent now? */
 	if (cpu_isset(cpu, smp_commenced_mask)) {
@@ -1210,11 +1194,19 @@ int __devinit __cpu_up(unsigned int cpu)
 	}
 #endif
 
+	for (i = 0; i < NR_CPUS; i++)
+	cpu_clear(i, cpu_callout_map);
+	cpu_set(smp_processor_id(), cpu_callout_map);
+	apicid = cpu_present_to_apicid(cpu);
+	do_boot_cpu(apicid, cpu);
 	local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
 	while (!cpu_isset(cpu, cpu_online_map))
 		mb();
+	cpu_enable(cpu);
+	cpu_clear(cpu, cpu_callout_map);
+	cpu_clear(smp_processor_id(), cpu_callout_map);
 	return 0;
 }
 
@@ -1223,11 +1215,13 @@ void __init smp_cpus_done(unsigned int m
 #ifdef CONFIG_X86_IO_APIC
 	setup_ioapic_dest();
 #endif
+#ifndef CONFIG_HOTPLUG_CPU
 	zap_low_mappings();
 	/*
 	 * Disable executability of the SMP trampoline:
 	 */
 	set_kernel_exec((unsigned long)trampoline_base,
trampoline_exec);
+#endif
 }
 
 void __init smp_intr_init(void)
diff -Naurp linux-2.6.11.6-mm/arch/i386/kernel/sysenter.c
linux-2.6.11.6-HC/arch/i386/kernel/sysenter.c
--- linux-2.6.11.6-mm/arch/i386/kernel/sysenter.c	2005-04-06
23:08:12.000000000 -0400
+++ linux-2.6.11.6-HC/arch/i386/kernel/sysenter.c	2005-04-12
07:59:36.000000000 -0400
@@ -58,7 +58,6 @@ static int __init sysenter_setup(void)
 	       &vsyscall_sysenter_start,
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
-	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
 	return 0;
 }
 
diff -Naurp linux-2.6.11.6-mm/include/asm/smp.h
linux-2.6.11.6-HC/include/asm/smp.h
--- linux-2.6.11.6-mm/include/asm/smp.h	2005-04-06 23:09:26.000000000
-0400
+++ linux-2.6.11.6-HC/include/asm/smp.h	2005-04-12 08:06:48.000000000
-0400
@@ -55,7 +55,7 @@ extern u8 x86_cpu_to_apicid[];
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
-#define cpu_possible_map cpu_callout_map
+extern cpumask_t cpu_possible_map;
 
 /* We don't mark CPUs online until __cpu_up(), so we need another
measure */
 static inline int num_booting_cpus(void)
diff -Naurp linux-2.6.11.6-mm/include/asm-i386/smp.h
linux-2.6.11.6-HC/include/asm-i386/smp.h
--- linux-2.6.11.6-mm/include/asm-i386/smp.h	2005-04-06
23:09:26.000000000 -0400
+++ linux-2.6.11.6-HC/include/asm-i386/smp.h	2005-04-12
08:06:48.000000000 -0400
@@ -55,7 +55,7 @@ extern u8 x86_cpu_to_apicid[];
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
-#define cpu_possible_map cpu_callout_map
+extern cpumask_t cpu_possible_map;
 
 /* We don't mark CPUs online until __cpu_up(), so we need another
measure */
 static inline int num_booting_cpus(void)
diff -Naurp linux-2.6.11.6-mm/init/main.c linux-2.6.11.6-HC/init/main.c
--- linux-2.6.11.6-mm/init/main.c	2005-04-06 23:08:21.000000000
-0400
+++ linux-2.6.11.6-HC/init/main.c	2005-04-12 08:46:54.000000000
-0400
@@ -684,7 +684,9 @@ static int init(void * unused)
 	 * we're essentially up and running. Get rid of the
 	 * initmem segments and start the user-mode stuff..
 	 */
+#infdef CONFIG_HOTPLUG_CPU
 	free_initmem();
+#endif
 	unlock_kernel();
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 

-----Original Message-----
From: hotplug_sig-bounces@lists.osdl.org
[mailto:hotplug_sig-bounces@lists.osdl.org] On Behalf Of Protasevich,
Natalie
Sent: Tuesday, April 12, 2005 11:57 AM
To: Zwane Mwaikambo; Li Shaohua
Cc: Andrew Morton; Len Brown; ACPI-DEV; Ryan Harper;
hotplug_sig@lists.osdl.org; Pavel Machek; Andi Kleen; lkml
Subject: [Hotplug_sig] RE: [PATCH 1/6]sep initializing rework

-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk]
Sent: Tuesday, April 12, 2005 6:08 AM
To: Li Shaohua
Cc: lkml; ACPI-DEV; Len Brown; Pavel Machek; Andrew Morton; Protasevich,
Natalie; Ryan Harper
Subject: Re: [PATCH 1/6]sep initializing rework

Hello Shaohua,

On Tue, 12 Apr 2005, Li Shaohua wrote:

> These patches (together with 5 patches followed this one) are updated 
> suspend/resume SMP patches. The patches fixed some bugs and do clean 
> up as suggested. Now they work for both suspend-to-ram and
suspend-to-disk.
> Patches are against 2.6.12-rc2-mm3.

These patches look good and i think we should go ahead with them. I've
also cross checked with physical hotplug cpu patches for ES7xxx from
Natalie (added to Cc) and it does indeed look like a lot of the code
will work for her too, but i'd appreciate it if she also does a double
check. 
Obviously this won't work for other upcoming users of hotplug cpu like
Xen (Ryan added to Cc) but i think we can abstract things later on to
cover other special users.

Thanks Shaohua,
	Zwane

