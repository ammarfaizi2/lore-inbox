Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbTAFNpk>; Mon, 6 Jan 2003 08:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbTAFNpk>; Mon, 6 Jan 2003 08:45:40 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:52359 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266712AbTAFNph>; Mon, 6 Jan 2003 08:45:37 -0500
Date: Mon, 6 Jan 2003 14:55:21 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.54] cpufreq: update timer notifier
Message-ID: <20030106135521.GC1307@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- global loops_per_jiffy, x86 cpu_khz and x86
   fast_gettimeoffset_quotient can only be safely adjusted on UP
- x86 per-CPU loops_per_jiffy does not depend on TSC
- save reference values so that rounding errors do not accumulate

 arch/i386/kernel/timers/timer_tsc.c |   54 ++++++++++++++++++------------------
 kernel/cpufreq.c                    |   20 ++++++++++---
 2 files changed, 42 insertions(+), 32 deletions(-)

diff -ruN linux-original/arch/i386/kernel/timers/timer_tsc.c linux/arch/i386/kernel/timers/timer_tsc.c
--- linux-original/arch/i386/kernel/timers/timer_tsc.c	2003-01-06 12:55:43.000000000 +0100
+++ linux/arch/i386/kernel/timers/timer_tsc.c	2003-01-06 14:20:31.000000000 +0100
@@ -189,39 +189,38 @@
 
 
 #ifdef CONFIG_CPU_FREQ
+static unsigned int  ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+
+#ifndef CONFIG_SMP
+static unsigned long fast_gettimeoffset_ref = 0;
+static unsigned long cpu_khz_ref = 0;
+#endif
 
 static int
 time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		       void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned int i;
 
-	if (!cpu_has_tsc)
-		return 0;
+	if (!ref_freq) {
+		ref_freq = freq->old;
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+#ifndef CONFIG_SMP
+		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
+		cpu_khz_ref = cpu_khz;
+#endif
+	}
 
-	switch (val) {
-	case CPUFREQ_PRECHANGE:
-		if ((freq->old < freq->new) &&
-		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
-			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
-		}
-		for (i=0; i<NR_CPUS; i++)
-			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
-		break;
-
-	case CPUFREQ_POSTCHANGE:
-		if ((freq->new < freq->old) &&
-		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
-			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+		cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+#ifndef CONFIG_SMP
+		if (use_tsc) {
+			fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
+			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 		}
-		for (i=0; i<NR_CPUS; i++)
-			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
-		break;
+#endif
 	}
 
 	return 0;
@@ -260,6 +259,10 @@
  	 *	moaned if you have the only one in the world - you fix it!
  	 */
  
+#ifdef CONFIG_CPU_FREQ
+	cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
@@ -282,9 +285,6 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
-#ifdef CONFIG_CPU_FREQ
-			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
-#endif
 			return 0;
 		}
 	}
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-06 12:55:43.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-06 13:57:18.000000000 +0100
@@ -927,17 +927,27 @@
  * adjust_jiffies - adjust the system "loops_per_jiffy"
  *
  * This function alters the system "loops_per_jiffy" for the clock
- * speed change. Note that loops_per_jiffy is only updated if all
- * CPUs are affected - else there is a need for per-CPU loops_per_jiffy
- * values which are provided by various architectures. 
+ * speed change. Note that loops_per_jiffy cannot be updated on SMP
+ * systems as each CPU might be scaled differently. So, use the arch 
+ * per-CPU loops_per_jiffy value wherever possible.
  */
+#ifndef CONFIG_SMP
+static unsigned long l_p_j_ref = 0;
+static unsigned int  l_p_j_ref_freq = 0;
+
 static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 {
+	if (!l_p_j_ref_freq) {
+		l_p_j_ref = loops_per_jiffy;
+		l_p_j_ref_freq = ci->old;
+	}
 	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
 	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new))
-		if (ci->cpu == CPUFREQ_ALL_CPUS)
-			loops_per_jiffy = cpufreq_scale(loops_per_jiffy, ci->old, ci->new);
+		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
 }
+#else
+#define adjust_jiffies(...)
+#endif
 
 
 /**
