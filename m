Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSLURgy>; Sat, 21 Dec 2002 12:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSLURgy>; Sat, 21 Dec 2002 12:36:54 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:35521 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262266AbSLURgw>; Sat, 21 Dec 2002 12:36:52 -0500
Date: Sat, 21 Dec 2002 18:45:14 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org
Subject: [PATCH 2.5] cpufreq: x86 tsc cpufreq notifier
Message-ID: <20021221174514.GB1149@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fast_gettimeoffset_quotient and the cpu_khz values should only be
updated on UP -- on SMP, these values might be different for each CPU, so
using the default values obtained at boot time should be safest.
Additionally, to get rid of accumulating rounding errors, reference values
are saved.
cpu_data[cpu].loops_per_jiffy is independent of the TSC and will be changed
in a different cpufreq notifier instead.


	Dominik

diff -ruN linux-original/arch/i386/kernel/timers/timer_tsc.c linux/arch/i386/kernel/timers/timer_tsc.c
--- linux-original/arch/i386/kernel/timers/timer_tsc.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/timers/timer_tsc.c	2002-12-21 18:22:12.000000000 +0100
@@ -186,45 +186,45 @@
 
 #ifdef CONFIG_CPU_FREQ
 
+static unsigned long fast_gettimeoffset_ref = 0;
+static unsigned long cpu_khz_ref = 0;
+static unsigned int  ref_freq = 0;
+
 static int
-time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+tsc_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		       void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned int i;
 
-	if (!cpu_has_tsc)
+	if (!use_tsc)
 		return 0;
 
+	if (!fast_gettimeoffset_ref) {
+		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
+		cpu_khz_ref = cpu_khz;
+		ref_freq = freq->old;
+	}
+
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if ((freq->old < freq->new) &&
-		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
-			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+		if (freq->old < freq->new) {
+		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
+		        cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 		}
-		for (i=0; i<NR_CPUS; i++)
-			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
 		break;
-
 	case CPUFREQ_POSTCHANGE:
-		if ((freq->new < freq->old) &&
-		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
-			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+		if (freq->new < freq->old) {
+		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
+		        cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 		}
-		for (i=0; i<NR_CPUS; i++)
-			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
 		break;
 	}
 
 	return 0;
 }
 
-static struct notifier_block time_cpufreq_notifier_block = {
-	.notifier_call	= time_cpufreq_notifier
+static struct notifier_block tsc_cpufreq_notifier_block = {
+	.notifier_call	= tsc_cpufreq_notifier
 };
 #endif
 
@@ -278,8 +278,8 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
-#ifdef CONFIG_CPU_FREQ
-			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+#if defined(CONFIG_CPU_FREQ) && !defined(CONFIG_UP)
+			cpufreq_register_notifier(&tsc_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 			return 0;
 		}

