Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSL2UzS>; Sun, 29 Dec 2002 15:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSL2UzS>; Sun, 29 Dec 2002 15:55:18 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:63935 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261346AbSL2UzN>; Sun, 29 Dec 2002 15:55:13 -0500
Date: Sun, 29 Dec 2002 22:03:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53 - Oops] CPU Frequency scaling
Message-ID: <20021229210341.GA1657@brodo.de>
References: <009d01c2af2b$24ecabe0$2101a8c0@witbe> <12349.1041189727@www40.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <12349.1041189727@www40.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for testing cpufreq - and sorry for that oops. The attached patches
should resolve this problem. For further cpufreq updates, check
http://www.brodo.de/cpufreq/advanced.html

	Dominik

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq-2.5.53-1-p4-1"

[PATCH 2.5][RESEND] cpufreq: p4-clockmod bugfixes

The "get current state" algorithm wasn't aware of the disable/enable bit,
and the policy verification function wasn't aware of the N44 / O17 bug.
Also, some unused code is removed.

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-12-21 18:24:29.000000000 +0100
@@ -82,12 +82,17 @@
 
 	/* get current state */
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
-	l = l >> 1;
-	l &= 0x7;
-
+	if (l & 0x10) {
+		l = l >> 1;
+		l &= 0x7;
+	} else
+		l = DC_DISABLE;
+	
 	if (l == newstate) {
 		set_cpus_allowed(current, cpus_allowed);
 		return 0;
+	} else if (l == DC_RESV) {
+		printk(KERN_ERR PFX "BIG FAT WARNING: currently in invalid setting\n");
 	}
 
 	/* notifiers */
@@ -141,13 +146,18 @@
 	unsigned int    i;
 	unsigned int    newstate = 0;
 	unsigned int    number_states = 0;
+	unsigned int    minstate = 1;
 
-	if (!cpufreq_p4_driver || !stock_freq || !policy)
+	if (!cpufreq_p4_driver || !stock_freq || 
+	    !policy || !cpu_online(policy->cpu))
 		return -EINVAL;
 
+	if (has_N44_O17_errata)
+		minstate = 3;
+
 	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
 	{
-		for (i=8; i>0; i--)
+		for (i=8; i>=minstate; i--)
 			if ((policy->min <= ((stock_freq / 8) * i)) &&
 			    (policy->max >= ((stock_freq / 8) * i))) 
 			{
@@ -155,7 +165,7 @@
 				number_states++;
 			}
 	} else {
-		for (i=1; i<=8; i++)
+		for (i=minstate; i<=8; i++)
 			if ((policy->min <= ((stock_freq / 8) * i)) &&
 			    (policy->max >= ((stock_freq / 8) * i))) 
 			{
@@ -164,25 +174,8 @@
 			}
 	}
 
-	/* if (number_states == 1) */
-	{
-		if (policy->cpu == CPUFREQ_ALL_CPUS) {
-			for (i=0; i<NR_CPUS; i++)
-				if (cpu_online(i))
-					cpufreq_p4_setdc(i, newstate);
-		} else {
-			cpufreq_p4_setdc(policy->cpu, newstate);
-		}
-	}
-	/* else {
-		if (policy->policy == CPUFREQ_POLICY_POWERSAVE) {
-			min_state = newstate;
-			max_state = newstate + (number_states - 1);
-		} else {
-			max_state = newstate;
-			min_state = newstate - (number_states - 1);
-		}
-	} */
+	cpufreq_p4_setdc(policy->cpu, newstate);
+
 	return 0;
 }
 
@@ -190,17 +183,21 @@
 static int cpufreq_p4_verify(struct cpufreq_policy *policy)
 {
 	unsigned int    number_states = 0;
-	unsigned int    i;
+	unsigned int    i = 1;
 
-	if (!cpufreq_p4_driver || !stock_freq || !policy)
+	if (!cpufreq_p4_driver || !stock_freq || 
+	    !policy || !cpu_online(policy->cpu))
 		return -EINVAL;
 
-	if (!cpu_online(policy->cpu))
-		policy->cpu = CPUFREQ_ALL_CPUS;
-	cpufreq_verify_within_limits(policy, (stock_freq / 8), stock_freq);
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
+
+	if (has_N44_O17_errata)
+		i = 3;
 
-	/* is there at least one state within limit? */
-	for (i=1; i<=8; i++)
+	/* is there at least one state within the limit? */
+	for (; i<=8; i++)
 		if ((policy->min <= ((stock_freq / 8) * i)) &&
 		    (policy->max >= ((stock_freq / 8) * i)))
 			number_states++;
@@ -209,6 +206,9 @@
 		return 0;
 
 	policy->max = (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / stock_freq)) + 1);
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
 	return 0;
 }
 
@@ -292,13 +292,14 @@
 
 void __exit cpufreq_p4_exit(void)
 {
-	u32 l, h;
+	unsigned int i;
 
 	if (cpufreq_p4_driver) {
+		for (i=0; i<NR_CPUS; i++) {
+			if (cpu_online(i)) 
+				cpufreq_p4_setdc(i, DC_DISABLE);
+		}
 		cpufreq_unregister();
-		/* return back to a non modulated state */
-		rdmsr(MSR_IA32_THERM_CONTROL, l, h);
-		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 		kfree(cpufreq_p4_driver);
 	}
 }


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq-2.5.53-2-timer-2"

[PATCH] cpufreq: update timer notifiers

- The global loops_per_jiffy can only be safely adjusted on UP. 
- x86 per-CPU loops_per_jiffy is not dependend of TSC, so move it to
      non-TSC code.
- Save reference values so that rounding errors do not accumulate

 arch/i386/kernel/cpu/common.c       |   47 ++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/timers/timer_tsc.c |   44 ++++++++++++++++-----------------
 kernel/cpufreq.c                    |   20 +++++++++++----
 3 files changed, 84 insertions(+), 27 deletions(-)
diff -ruN linux-original/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-original/arch/i386/kernel/cpu/common.c	2002-12-24 13:37:12.000000000 +0100
+++ linux/arch/i386/kernel/cpu/common.c	2002-12-24 14:44:14.000000000 +0100
@@ -1,5 +1,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/cpufreq.h>
+#include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <asm/semaphore.h>
@@ -64,6 +66,41 @@
 #endif
 __setup("notsc", tsc_setup);
 
+#ifdef CONFIG_CPU_FREQ
+static unsigned long loops_per_jiffy_ref = 0;
+static unsigned int  ref_freq = 0;
+
+static int
+loops_per_jiffy_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+				       void *data)
+{
+	struct cpufreq_freqs *freq = data;
+
+	if (!loops_per_jiffy_ref) {
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+		ref_freq = freq->old;
+	}
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		if (freq->old < freq->new)
+		        cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+		break;
+	case CPUFREQ_POSTCHANGE:
+		if (freq->new < freq->old)
+		        cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block loops_per_jiffy_cpufreq_notifier_block = {
+	.notifier_call	= loops_per_jiffy_cpufreq_notifier
+};
+#endif
+
+
 int __init get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
@@ -373,6 +410,16 @@
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
 
+	/*
+	 * Update the per-CPU loops_per_jiffy count on CPU frequency
+	 * transitions
+	 */
+#ifdef CONFIG_CPU_FREQ
+	if (c == &boot_cpu_data) {
+			cpufreq_register_notifier(&loops_per_jiffy_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+	}
+#endif
+
 	/* Init Machine Check Exception if available. */
 #ifdef CONFIG_X86_MCE
 	mcheck_init(c);
diff -ruN linux-original/arch/i386/kernel/timers/timer_tsc.c linux/arch/i386/kernel/timers/timer_tsc.c
--- linux-original/arch/i386/kernel/timers/timer_tsc.c	2002-12-24 13:37:12.000000000 +0100
+++ linux/arch/i386/kernel/timers/timer_tsc.c	2002-12-24 14:41:28.000000000 +0100
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
+#if defined(CONFIG_CPU_FREQ) && !defined(CONFIG_SMP)
+			cpufreq_register_notifier(&tsc_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 			return 0;
 		}
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2002-12-24 13:38:25.000000000 +0100
+++ linux/kernel/cpufreq.c	2002-12-24 14:46:25.000000000 +0100
@@ -936,17 +936,27 @@
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

--ikeVEW9yuYc//A+q--
