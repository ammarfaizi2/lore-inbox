Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265686AbSKASfi>; Fri, 1 Nov 2002 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265691AbSKASff>; Fri, 1 Nov 2002 13:35:35 -0500
Received: from fmr02.intel.com ([192.55.52.25]:496 "EHLO caduceus.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265686AbSKASfb>;
	Fri, 1 Nov 2002 13:35:31 -0500
Message-ID: <10C8636AE359D4119118009027AE99871E606C41@fmsmsx34.fm.intel.com>
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "'Dominik Brodowski'" <linux@brodo.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: RE: [2.5. PATCH - UPDATED] cpufreq: update HyperThreading support
	 in p4-clockmod.c driver
Date: Fri, 1 Nov 2002 10:41:57 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well.. I was working on a similar patch too. But, you beat me in sending out
the patch onto lkml..

One comment: P4 HT doesn't promise any order in the cpuid of HT siblings. I
mean, it is possible to have CPU0 and CPU 3 in one package and CPU 1 and CPU
4 in one package. The right way to know the cpu id of HT sibling is to look
at cpu_sibling_map[], in place of doing cpu*2 and cpu/2.

Thanks,
-Venkatesh 

-----Original Message-----
From: Dominik Brodowski [mailto:linux@brodo.de]
Sent: Friday, November 01, 2002 10:21 AM
To: James Bottomley; torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org; cpufreq@www.linux.org.uk
Subject: [2.5. PATCH - UPDATED] cpufreq: update HyperThreading support
in p4-clockmod.c driver


On Fri, Nov 01, 2002 at 11:03:35AM -0500, James Bottomley wrote:
> the #define for hyperthreading should be #ifdef CONFIG_X86_HT.
> 
> Could you also make the symbol export conditional on this so that
subarch's 
> which don't have hyperthreading will still compile?

Sorry for that, updated patch below:

[2.5. PATCH] cpufreq: update HyperThreading support in p4-clockmod.c driver

This patch updates the p4-clockmod.c driver to correctly manage
HyperThreading-enabled Pentium IVs as well as those models which do
not support HyperThreading. Additionally, an EXPORT_SYMBOL was
missing. (spotted by Marc-Christian Petersen - thanks!)

	 Dominik

diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu
Oct 31 12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Oct 31 20:00:00
2002
@@ -50,7 +50,6 @@
 MODULE_PARM(stock_freq, "i");
 
 static struct cpufreq_driver *cpufreq_p4_driver;
-static unsigned int cpufreq_p4_old_state = 0;
 
 
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
@@ -58,24 +57,50 @@
 	u32 l, h;
 	unsigned long cpus_allowed;
 	struct cpufreq_freqs    freqs;
+	int hyperthreading;
+
 
 	if (!cpu_online(cpu) || (newstate > DC_DISABLE) || 
 		(newstate == DC_RESV))
 		return -EINVAL;
-	cpu = cpu >> 1; /* physical CPU #nr */
+
+	/* switch to physical CPU where state is to be changed*/
+	cpus_allowed = current->cpus_allowed;
+
+	/* hyperthreading? */
+#ifdef CONFIG_X86_HT
+	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
+#else
+	hyperthreading = 0;
+#endif
+	if (hyperthreading) {
+		unsigned int phys_cpu = cpu / 2;
+		set_cpus_allowed(current, 3 << (phys_cpu));
+		BUG_ON((cpu & ~1) != (smp_processor_id() & ~1));
+		cpu = phys_cpu * 2;
+	} else {
+		set_cpus_allowed(current, 1 <<  cpu);
+		BUG_ON(cpu != smp_processor_id());
+	}
+	/* get current state */
+	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+	l = l >> 1;
+	l &= 0x7;
+
+	if (l == newstate) {
+		set_cpus_allowed(current, cpus_allowed);
+		return 0;
+	}
 
 	/* notifiers */
-	freqs.old = stock_freq * cpufreq_p4_old_state / 8;
+	freqs.old = stock_freq * l / 8;
 	freqs.new = stock_freq * newstate / 8;
-	freqs.cpu = 2*cpu;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	freqs.cpu++;
+	freqs.cpu = cpu;
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-
-	/* switch to physical CPU where state is to be changed*/
-	cpus_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, 3 << (2 * cpu));
-	BUG_ON(cpu != (smp_processor_id() >> 1));
+	if (hyperthreading) {
+		freqs.cpu++;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
 
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
 	if (l & 0x01)
@@ -86,10 +111,10 @@
 
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
 	if (newstate == DC_DISABLE) {
-		printk(KERN_INFO PFX "CPU#%d,%d disabling modulation\n",
cpu, (cpu + 1));
+		printk(KERN_INFO PFX "CPU#%d disabling modulation\n", cpu);
 		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 	} else {
-		printk(KERN_INFO PFX "CPU#%d,%d setting duty cycle to
%d%%\n", cpu, (cpu + 1), ((125 * newstate) / 10));
+		printk(KERN_INFO PFX "CPU#%d setting duty cycle to %d%%\n",
cpu, ((125 * newstate) / 10));
 		/* bits 63 - 5	: reserved 
 		 * bit  4	: enable/disable
 		 * bits 3-1	: duty cycle
@@ -104,9 +129,10 @@
 
 	/* notifiers */
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	freqs.cpu--;
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	cpufreq_p4_old_state = newstate;
+	if (hyperthreading) {
+		freqs.cpu--;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
 
 	return 0;
 }
@@ -143,9 +169,9 @@
 	/* if (number_states == 1) */
 	{
 		if (policy->cpu == CPUFREQ_ALL_CPUS) {
-			for (i=0; i<(NR_CPUS/2); i++)
-				if (cpu_online(2*i))
-					cpufreq_p4_setdc((2*i), newstate);
+			for (i=0; i<NR_CPUS; i++)
+				if (cpu_online(i))
+					cpufreq_p4_setdc(i, newstate);
 		} else {
 			cpufreq_p4_setdc(policy->cpu, newstate);
 		}
@@ -235,7 +261,6 @@
 	for (i=0;i<NR_CPUS;i++)
 		driver->cpu_cur_freq[i] = stock_freq;
 #endif
-	cpufreq_p4_old_state  = DC_DISABLE;
 
 	driver->verify        = &cpufreq_p4_verify;
 	driver->setpolicy     = &cpufreq_p4_setpolicy;
diff -ruN linux-2545original/arch/i386/kernel/i386_ksyms.c
linux/arch/i386/kernel/i386_ksyms.c
--- linux-2545original/arch/i386/kernel/i386_ksyms.c.original	Thu Oct 31
12:00:00 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Thu Oct 31 20:00:00 2002
@@ -145,6 +145,9 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
+#ifdef CONFIG_X86_HT
+EXPORT_SYMBOL(smp_num_siblings);
+#endif
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_callout_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
