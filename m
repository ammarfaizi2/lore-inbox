Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbSJIPlp>; Wed, 9 Oct 2002 11:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSJIPlo>; Wed, 9 Oct 2002 11:41:44 -0400
Received: from zeus.kernel.org ([204.152.189.113]:21202 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261789AbSJIPlg>;
	Wed, 9 Oct 2002 11:41:36 -0400
Date: Wed, 9 Oct 2002 17:33:52 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.] cpufreq: p4-clockmod update
Message-ID: <20021009173352.A878@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows p4-clockmod.c to be used both on hyperthreading and
non-hyperthreading CPUs.

	Dominik

diff -ruN -x CVS -x *.o /usr/src/linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- /usr/src/linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Wed Oct  9 00:50:35 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Tue Oct  8 18:33:02 2002
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
+#ifdef CONFIG_SMP
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
-		printk(KERN_INFO PFX "CPU#%d,%d disabling modulation\n", cpu, (cpu + 1));
+		printk(KERN_INFO PFX "CPU#%d disabling modulation\n", cpu);
 		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 	} else {
-		printk(KERN_INFO PFX "CPU#%d,%d setting duty cycle to %d%%\n", cpu, (cpu + 1), ((125 * newstate) / 10));
+		printk(KERN_INFO PFX "CPU#%d setting duty cycle to %d%%\n", cpu, ((125 * newstate) / 10));
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

