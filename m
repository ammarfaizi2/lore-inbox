Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSKVSHx>; Fri, 22 Nov 2002 13:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKVSHw>; Fri, 22 Nov 2002 13:07:52 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:1494 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265168AbSKVSHf>; Fri, 22 Nov 2002 13:07:35 -0500
Date: Fri, 22 Nov 2002 19:14:01 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.5. PATCH] cpufreq: cleanups
Message-ID: <20021122181401.GA929@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This patch changes the return type of the verify and setpolicy
functions from void to int. While doing this, I've changed the values for
minimum and maximum supported frequency to be per CPU, as UltraSPARC
needs this. Additionally, small cleanups in various drivers.

Please apply,

       Dominik


diff -ruN linux-original/Documentation/cpufreq linux/Documentation/cpufreq
--- linux-original/Documentation/cpufreq	2002-11-17 19:04:11.000000000 +0100
+++ linux/Documentation/cpufreq	2002-11-18 16:34:44.000000000 +0100
@@ -87,7 +87,8 @@
 Transmeta Crusoe Longrun:
     Transmeta Crusoe processors:
 --------------------------------
-    Does not work with the 2.4. /proc/sys/cpu/ interface.
+    It is recommended to use the 2.6. /proc/cpufreq interface when
+    using this driver
=20
=20
=20
@@ -283,15 +284,17 @@
=20
 cpufreq_verify_t verify: This is a pointer to a function with the
 	following definition:
-	void verify_function (struct cpufreq_policy *policy).
+	int verify_function (struct cpufreq_policy *policy).
 	This function must verify the new policy is within the limits
 	supported by the CPU, and at least one supported CPU is within
 	this range. It may be useful to use cpufreq.h /
-	cpufreq_verify_within_limits for this.
+	cpufreq_verify_within_limits for this. If this is called with
+        CPUFREQ_ALL_CPUS, and there is no common subset of frequencies
+        for all CPUs, exit with an error.
=20
 cpufreq_setpolicy_t setpolicy: This is a pointer to a function with
 	the following definition:
-	void setpolicy_function (struct cpufreq_policy *policy).
+	int setpolicy_function (struct cpufreq_policy *policy).
 	This function must set the CPU to the new policy. If it is a
 	"dumb" CPU which only allows fixed frequencies to be set, it
 	shall set it to the lowest within the limit for
@@ -302,30 +305,30 @@
=20
 struct cpufreq_policy   *policy: This is an array of NR_CPUS struct
 	cpufreq_policies, containing the current policies set for these
-	CPUs. Note that policy[0].max_cpu_freq must contain the
-	absolute maximum CPU frequency supported by _all_ CPUs.
+	CPUs. Note that policy[cpu].max_cpu_freq must contain the
+	absolute maximum CPU frequency supported by the specified cpu.
=20
 In case the driver is expected to run with the 2.4.-style API
 (/proc/sys/cpu/.../), two more values must be passed
 #ifdef CONFIG_CPU_FREQ_24_API
-	unsigned int            cpu_min_freq;
+	unsigned int            cpu_min_freq[NR_CPUS];
 	unsigned int            cpu_cur_freq[NR_CPUS];
 #endif
-	with cpu_min_freq being the minimum CPU frequency supported by
-	the CPUs; and the entries in cpu_cur_freq reflecting the
-	current speed of the appropriate CPU.
+	with cpu_min_freq[cpu] being the minimum CPU frequency
+	supported by the CPU; and the entries in cpu_cur_freq
+	reflecting the current speed of the appropriate CPU.
=20
 Some Requirements to CPUFreq architecture drivers
 -------------------------------------------------
 * Only call cpufreq_register() when the ability to switch CPU
-  frequencies is _verified_ or can't be missing
+  frequencies is _verified_ or can't be missing. Also, all
+  other initialization must be done beofre this call, as
+  cpfureq_register calls the driver's verify and setpolicy code for
+  each CPU.
 * cpufreq_unregister() may only be called if cpufreq_register() has
   been successfully(!) called before.
 * kfree() the struct cpufreq_driver only after the call to=20
   cpufreq_unregister(), unless cpufreq_register() failed.
-* Be aware that there is currently no error management in the
-  setpolicy() code in the CPUFreq core. So only call yourself a
-  cpufreq_driver if you are really a working cpufreq_driver!
=20
=20
=20
diff -ruN linux-original/arch/arm/mach-integrator/cpu.c linux/arch/arm/mach=
-integrator/cpu.c
--- linux-original/arch/arm/mach-integrator/cpu.c	2002-11-17 19:04:12.00000=
0000 +0100
+++ linux/arch/arm/mach-integrator/cpu.c	2002-11-18 16:34:44.000000000 +0100
@@ -73,7 +73,7 @@
  * Validate the speed in khz.  If it is outside our
  * range, then return the lowest.
  */
-static void integrator_verify_speed(struct cpufreq_policy *policy)
+static int integrator_verify_speed(struct cpufreq_policy *policy)
 {
 	struct vco vco;
=20
@@ -93,6 +93,8 @@
 		vco.vdw =3D 152;
=20
 	policy->min =3D policy->max =3D vco_to_freq(vco, 1);
+
+	return 0;
 }
=20
 static void do_set_policy(int cpu, struct cpufreq_policy *policy)
@@ -116,7 +118,7 @@
 	__raw_writel(0, CM_LOCK);
 }
=20
-static void integrator_set_policy(struct cpufreq_policy *policy)
+static int integrator_set_policy(struct cpufreq_policy *policy)
 {
 	unsigned long cpus_allowed;
 	int cpu;
@@ -139,6 +141,8 @@
 	 * Restore the CPUs allowed mask.
 	 */
 	set_cpus_allowed(current, cpus_allowed);
+
+	return 0;
 }
=20
 static struct cpufreq_policy integrator_policy =3D {
@@ -151,7 +155,6 @@
 	.verify		=3D integrator_verify_speed,
 	.setpolicy	=3D integrator_set_policy,
 	.policy		=3D &integrator_policy,
-	.cpu_min_freq	=3D 12000,
 };
 #endif
=20
@@ -202,6 +205,8 @@
 	set_cpus_allowed(current, cpus_allowed);
=20
 #ifdef CONFIG_CPU_FREQ
+	for (cpu=3D0; cpu<NR_CPUS; cpu++)
+		integrator_driver.cpu_min_freq[cpu] =3D 12000;
 	integrator_driver.policy =3D policies;
 	cpufreq_register(&integrator_driver);
 #else
diff -ruN linux-original/arch/arm/mach-sa1100/cpu-sa1100.c linux/arch/arm/m=
ach-sa1100/cpu-sa1100.c
--- linux-original/arch/arm/mach-sa1100/cpu-sa1100.c	2002-11-17 19:04:12.00=
0000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1100.c	2002-11-18 16:34:44.000000000 +=
0100
@@ -176,7 +176,7 @@
 	}
 }
=20
-static void sa1100_setspeed(struct cpufreq_policy *policy)
+static int sa1100_setspeed(struct cpufreq_policy *policy)
 {
 	unsigned int cur =3D sa11x0_getspeed();
 	struct cpufreq_freqs freqs;
@@ -196,6 +196,8 @@
 		sa1100_update_dram_timings(cur, policy->max);
=20
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
 }
=20
 static struct cpufreq_policy sa1100_policy =3D {
@@ -208,7 +210,7 @@
 	.verify		=3D sa11x0_verify_speed,
 	.setpolicy	=3D sa1100_setspeed,
 	.policy		=3D &sa1100_policy,
-	.cpu_min_freq	=3D 59000,
+	.cpu_min_freq[0]=3D 59000,
 };
=20
 static int __init sa1100_dram_init(void)
@@ -216,7 +218,7 @@
 	int ret =3D -ENODEV;
=20
 	if ((processor_id & CPU_SA1100_MASK) =3D=3D CPU_SA1100_ID) {
-		sa1100_driver.cpu_curr_freq[0] =3D
+		sa1100_driver.cpu_cur_freq[0] =3D
 		sa1100_policy.min =3D
 		sa1100_policy.max =3D sa11x0_getspeed();
=20
diff -ruN linux-original/arch/arm/mach-sa1100/cpu-sa1110.c linux/arch/arm/m=
ach-sa1100/cpu-sa1110.c
--- linux-original/arch/arm/mach-sa1100/cpu-sa1110.c	2002-11-17 19:04:12.00=
0000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1110.c	2002-11-18 16:34:44.000000000 +=
0100
@@ -212,7 +212,7 @@
  * above, we can match for an exact frequency.  If we don't find
  * an exact match, we will to set the lowest frequency to be safe.
  */
-static void sa1110_setspeed(struct cpufreq_policy *policy)
+static int sa1110_setspeed(struct cpufreq_policy *policy)
 {
 	struct sdram_params *sdram =3D &sdram_params;
 	struct cpufreq_freqs freqs;
@@ -291,6 +291,8 @@
 	sdram_update_refresh(policy->max, sdram);
=20
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
 }
=20
 static struct cpufreq_policy sa1110_policy =3D {
@@ -300,10 +302,10 @@
 };
=20
 static struct cpufreq_driver sa1110_driver =3D {
-	.verify		=3D sa11x0_verify_speed,
-	.setpolicy	=3D sa1110_setspeed,
-	.policy		=3D &sa1110_policy,
-	.cpu_min_freq	=3D 59000,
+	.verify		 =3D sa11x0_verify_speed,
+	.setpolicy	 =3D sa1110_setspeed,
+	.policy		 =3D &sa1110_policy,
+	.cpu_min_freq[0] =3D 59000,
 };
=20
 static int __init sa1110_clk_init(void)
diff -ruN linux-original/arch/arm/mach-sa1100/generic.c linux/arch/arm/mach=
-sa1100/generic.c
--- linux-original/arch/arm/mach-sa1100/generic.c	2002-11-17 19:04:12.00000=
0000 +0100
+++ linux/arch/arm/mach-sa1100/generic.c	2002-11-18 16:34:35.000000000 +0100
@@ -67,7 +67,7 @@
  * scaling, so we force min=3Dmax, and set the policy to "performance".
  * If we can't generate the precise frequency requested, round it up.
  */
-void sa11x0_verify_speed(struct cpufreq_policy *policy)
+int sa11x0_verify_speed(struct cpufreq_policy *policy)
 {
 	if (policy->max > policy->max_cpu_freq)
 		policy->max =3D policy->max_cpu_freq;
@@ -75,6 +75,7 @@
 	policy->max =3D cclk_frequency_100khz[sa11x0_freq_to_ppcr(policy->max)] *=
 100;
 	policy->min =3D policy->max;
 	policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
+	return 0;
 }
=20
 unsigned int sa11x0_getspeed(void)
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch=
/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-11-17 19:04=
:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-11-18 16:34:44.00000=
0000 +0100
@@ -172,13 +172,13 @@
  *      for the hardware supported by the driver.=20
  */
=20
-static void elanfreq_verify (struct cpufreq_policy *policy)
+static int elanfreq_verify (struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i;
=20
 	if (!policy || !max_freq)
-		return;
+		return -EINVAL;
=20
 	policy->cpu =3D 0;
=20
@@ -190,7 +190,7 @@
 			number_states++;
=20
 	if (number_states)
-		return;
+		return 0;
=20
 	for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); =
i>=3D0; i--)
 		if (elan_multiplier[i].clock < policy->max)
@@ -198,16 +198,16 @@
=20
 	policy->max =3D elan_multiplier[i+1].clock;
=20
-	return;
+	return 0;
 }
=20
-static void elanfreq_setpolicy (struct cpufreq_policy *policy)
+static int elanfreq_setpolicy (struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i, j=3D4;
=20
 	if (!elanfreq_driver)
-		return;
+		return -EINVAL;
=20
 	for (i=3D(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); =
i>=3D0; i--)
 		if ((elan_multiplier[i].clock >=3D policy->min) &&
@@ -219,7 +219,7 @@
=20
 	if (number_states =3D=3D 1) {
 		elanfreq_set_cpu_state(j);
-		return;
+		return 0;
 	}
=20
 	switch (policy->policy) {
@@ -236,14 +236,14 @@
 				j =3D i;
 		break;
 	default:
-		return;
+		return -EINVAL;
 	}
=20
 	if (elan_multiplier[j].clock > max_freq)
-		BUG();
+		return -EINVAL;
=20
 	elanfreq_set_cpu_state(j);
-	return;
+	return 0;
 }
=20
=20
@@ -296,7 +296,7 @@
 		max_freq =3D elanfreq_get_cpu_frequency();
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq    =3D 1000;
+	driver->cpu_min_freq[0] =3D 1000;
 	driver->cpu_cur_freq[0] =3D elanfreq_get_cpu_frequency();
 #endif
=20
@@ -309,15 +309,15 @@
 	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
 	driver->policy[0].max_cpu_freq  =3D max_freq;
=20
+	elanfreq_driver =3D driver;
+
 	ret =3D cpufreq_register(driver);
 	if (ret) {
+		elanfreq_driver =3D NULL;
 		kfree(driver);
-		return ret;
 	}
=20
-	elanfreq_driver =3D driver;
-
-	return 0;
+	return ret;
 }
=20
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch=
/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-11-17 19:04=
:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-11-18 16:46:41.00000=
0000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: longhaul.c,v 1.72 2002/09/29 23:43:10 db Exp $
+ *  $Id: longhaul.c,v 1.77 2002/10/31 21:17:40 db Exp $
  *
  *  (C) 2001  Dave Jones. <davej@suse.de>
  *  (C) 2002  Padraig Brady. <padraig@antefacto.com>
@@ -436,8 +436,10 @@
 	switch (longhaul) {
 	case 1:
 		/* Ugh, Longhaul v1 didn't have the min/max MSRs.
-		   Assume max =3D whatever we booted at. */
+		   Assume min=3D3.0x & max =3D whatever we booted at. */
+		minmult =3D 30;
 		maxmult =3D longhaul_get_cpu_mult();
+		minfsb =3D maxfsb =3D current_fsb;
 		break;
=20
 	case 2 ... 3:
@@ -531,7 +533,7 @@
 }
=20
=20
-static void longhaul_verify(struct cpufreq_policy *policy)
+static int longhaul_verify(struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i;
@@ -540,7 +542,7 @@
 	unsigned int    newmax =3D -1;
=20
 	if (!policy || !longhaul_driver)
-		return;
+		return -EINVAL;
=20
 	policy->cpu =3D 0;
 	cpufreq_verify_within_limits(policy, lowest_speed, highest_speed);
@@ -552,7 +554,7 @@
 		number_states =3D longhaul_statecount_fsb(policy, current_fsb);
=20
 	if (number_states)
-		return;
+		return 0;
=20
 	/* get frequency closest above current policy->max */
 	if (can_scale_fsb=3D=3D1) {
@@ -579,10 +581,12 @@
 	}
=20
 	policy->max =3D newmax;
+
+	return 0;
 }
=20
=20
-static void longhaul_setpolicy (struct cpufreq_policy *policy)
+static int longhaul_setpolicy (struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i;
@@ -592,7 +596,7 @@
 	unsigned int    best_freq =3D -1;
=20
 	if (!longhaul_driver)
-		return;
+		return -EINVAL;
=20
 	if (policy->policy=3D=3DCPUFREQ_POLICY_PERFORMANCE)
 		fsb_search_table =3D perf_fsb_table;
@@ -613,7 +617,7 @@
 	}
=20
 	if (!number_states)
-		return;
+		return -EINVAL;
 	else if (number_states =3D=3D 1) {
 		for(i=3D0; i<numscales; i++) {
 			if ((clock_ratio[i] !=3D -1) &&
@@ -692,11 +696,11 @@
 		}
 		break;
 	default:
-		return;
+		return -EINVAL;
 	}
=20
 	longhaul_setstate(new_clock_ratio, new_fsb);
-	return;
+	return 0;
 }
=20
=20
@@ -775,7 +779,7 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq    =3D (unsigned int) lowest_speed;
+	driver->cpu_min_freq[0] =3D (unsigned int) lowest_speed;
 	driver->cpu_cur_freq[0] =3D currentspeed;
 #endif
=20
@@ -788,15 +792,15 @@
 	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
 	driver->policy[0].max_cpu_freq =3D (unsigned int) highest_speed;
=20
-	ret =3D cpufreq_register(driver);
+	longhaul_driver =3D driver;
=20
+	ret =3D cpufreq_register(driver);
 	if (ret) {
+		longhaul_driver =3D NULL;
 		kfree(driver);
-		return ret;
 	}
=20
-	longhaul_driver =3D driver;
-	return 0;
+	return ret;
 }
=20
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/=
i386/kernel/cpu/cpufreq/longrun.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c	2002-11-17 19:09:=
07.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2002-11-18 16:34:44.000000=
000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: longrun.c,v 1.12 2002/09/29 23:43:10 db Exp $
+ *  $Id: longrun.c,v 1.14 2002/10/31 21:17:40 db Exp $
  *
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
  *
@@ -67,13 +67,13 @@
  * Sets a new CPUFreq policy on LongRun-capable processors. This function
  * has to be called with cpufreq_driver locked.
  */
-static void longrun_set_policy(struct cpufreq_policy *policy)
+static int longrun_set_policy(struct cpufreq_policy *policy)
 {
 	u32 msr_lo, msr_hi;
 	u32 pctg_lo, pctg_hi;
=20
 	if (!longrun_driver || !policy)
-		return;
+		return -EINVAL;
=20
 	pctg_lo =3D (policy->min - longrun_low_freq) /=20
 		((longrun_high_freq - longrun_low_freq) / 100);
@@ -105,7 +105,7 @@
 	msr_hi |=3D pctg_hi;
 	wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
=20
-	return;
+	return 0;
 }
=20
=20
@@ -115,16 +115,16 @@
  * Validates a new CPUFreq policy. This function has to be called with=20
  * cpufreq_driver locked.
  */
-static void longrun_verify_policy(struct cpufreq_policy *policy)
+static int longrun_verify_policy(struct cpufreq_policy *policy)
 {
 	if (!policy || !longrun_driver)
-		return;
+		return -EINVAL;
=20
 	policy->cpu =3D 0;
 	cpufreq_verify_within_limits(policy, 0,=20
 		longrun_driver->policy[0].max_cpu_freq);
=20
-	return;
+	return 0;
 }
=20
=20
@@ -252,20 +252,22 @@
 	longrun_get_policy(&driver->policy[0]);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq    =3D longrun_low_freq;
+	driver->cpu_min_freq[0] =3D longrun_low_freq;
 	driver->cpu_cur_freq[0] =3D longrun_high_freq; /* dummy value */
 #endif
=20
 	driver->verify         =3D &longrun_verify_policy;
 	driver->setpolicy      =3D &longrun_set_policy;
+
+	longrun_driver =3D driver;
+
 	result =3D cpufreq_register(driver);
 	if (result) {
+		longrun_driver =3D NULL;
 		kfree(driver);
-		return result;
 	}
-	longrun_driver =3D driver;
=20
-	return 0;
+	return result;
 }
=20
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/a=
rch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-11-17 20=
:42:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-11-18 16:54:30.00=
0000000 +0100
@@ -78,7 +78,7 @@
 	}
 #endif
 	set_cpus_allowed(current, affected_cpu_map);
-	BUG_ON(!(smp_processor_id() & affected_cpu_map));
+	BUG_ON(!(affected_cpu_map & (1 << smp_processor_id())));
=20
 	/* get current state */
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
@@ -136,14 +136,14 @@
 }
=20
=20
-static void cpufreq_p4_setpolicy(struct cpufreq_policy *policy)
+static int cpufreq_p4_setpolicy(struct cpufreq_policy *policy)
 {
 	unsigned int    i;
 	unsigned int    newstate =3D 0;
 	unsigned int    number_states =3D 0;
=20
 	if (!cpufreq_p4_driver || !stock_freq || !policy)
-		return;
+		return -EINVAL;
=20
 	if (policy->policy =3D=3D CPUFREQ_POLICY_POWERSAVE)
 	{
@@ -183,16 +183,17 @@
 			min_state =3D newstate - (number_states - 1);
 		}
 	} */
+	return 0;
 }
=20
=20
-static void cpufreq_p4_verify(struct cpufreq_policy *policy)
+static int cpufreq_p4_verify(struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i;
=20
 	if (!cpufreq_p4_driver || !stock_freq || !policy)
-		return;
+		return -EINVAL;
=20
 	if (!cpu_online(policy->cpu))
 		policy->cpu =3D CPUFREQ_ALL_CPUS;
@@ -205,10 +206,10 @@
 			number_states++;
=20
 	if (number_states)
-		return;
+		return 0;
=20
 	policy->max =3D (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / =
stock_freq)) + 1);
-	return;
+	return 0;
 }
=20
=20
@@ -255,9 +256,10 @@
 		stock_freq =3D cpu_khz;
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq    =3D stock_freq / 8;
-	for (i=3D0;i<NR_CPUS;i++)
+	for (i=3D0;i<NR_CPUS;i++) {
+		driver->cpu_min_freq[i] =3D stock_freq / 8;
 		driver->cpu_cur_freq[i] =3D stock_freq;
+	}
 #endif
=20
 	driver->verify        =3D &cpufreq_p4_verify;
@@ -274,15 +276,15 @@
 		driver->policy[i].cpu    =3D i;
 	}
=20
+	cpufreq_p4_driver =3D driver;
+=09
 	ret =3D cpufreq_register(driver);
 	if (ret) {
+		cpufreq_p4_driver =3D NULL;
 		kfree(driver);
-		return ret;
 	}
=20
-	cpufreq_p4_driver =3D driver;
-=09
-	return 0;
+	return ret;
 }
=20
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/a=
rch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-11-17 19=
:04:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-11-18 16:34:44.00=
0000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: powernow-k6.c,v 1.33 2002/09/29 23:43:11 db Exp $
+ *  $Id: powernow-k6.c,v 1.36 2002/10/31 21:17:40 db Exp $
  *  This file was part of Powertweak Linux (http://powertweak.sf.net)
  *  and is shared with the Linux Kernel module.
  *
@@ -113,13 +113,13 @@
  * Policy must be within lowest and highest possible CPU Frequency,
  * and at least one possible state must be within min and max.
  */
-static void powernow_k6_verify(struct cpufreq_policy *policy)
+static int powernow_k6_verify(struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i, j;
=20
 	if (!policy || !busfreq)
-		return;
+		return -EINVAL;
=20
 	policy->cpu =3D 0;
 	cpufreq_verify_within_limits(policy, (20 * busfreq),
@@ -131,7 +131,7 @@
 			number_states++;
=20
 	if (number_states)
-		return;
+		return 0;
=20
 	/* no state is available within range -- find next larger state */
=20
@@ -144,7 +144,7 @@
=20
 	policy->max =3D clock_ratio[j] * busfreq;
=20
-	return;
+	return 0;
 }
=20
=20
@@ -154,13 +154,13 @@
  *
  * sets a new CPUFreq policy
  */
-static void powernow_k6_setpolicy (struct cpufreq_policy *policy)
+static int powernow_k6_setpolicy (struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i, j=3D4;
=20
 	if (!powernow_driver)
-		return;
+		return -EINVAL;
=20
 	for (i=3D0; i<8; i++)
 		if ((policy->min <=3D (busfreq * clock_ratio[i])) &&
@@ -174,7 +174,7 @@
 		/* if only one state is within the limit borders, it
 		   is easily detected and set */
 		powernow_k6_set_state(j);
-		return;
+		return 0;
 	}
=20
 	/* more than one state within limit */
@@ -196,14 +196,14 @@
 				j =3D i;
 		break;
 	default:
-		return;
+		return -EINVAL;
 	}
=20
 	if (clock_ratio[i] > max_multiplier)
-		BUG();
+		return -EINVAL;
=20
 	powernow_k6_set_state(j);
-	return;
+	return 0;
 }
=20
=20
@@ -242,7 +242,7 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq     =3D busfreq * 20;
+	driver->cpu_min_freq[0]  =3D busfreq * 20;
 	driver->cpu_cur_freq[0]  =3D busfreq * max_multiplier;
 #endif
=20
@@ -255,16 +255,16 @@
 	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
 	driver->policy[0].max_cpu_freq  =3D busfreq * max_multiplier;
=20
+	powernow_driver =3D driver;
=20
 	result =3D cpufreq_register(driver);
 	if (result) {
 		release_region (POWERNOW_IOPORT, 16);
+		powernow_driver =3D NULL;
 		kfree(driver);
-		return result;
 	}
-	powernow_driver =3D driver;
=20
-	return 0;
+	return result;
 }
=20
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arc=
h/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-11-17 19:0=
9:17.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-11-18 16:36:36.0000=
00000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.57 2002/11/05 12:01:12 db Exp $
+ *  $Id: speedstep.c,v 1.58 2002/11/11 15:35:46 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
@@ -567,10 +567,10 @@
  *
  * Sets a new CPUFreq policy.
  */
-static void speedstep_setpolicy (struct cpufreq_policy *policy)
+static int speedstep_setpolicy (struct cpufreq_policy *policy)
 {
 	if (!speedstep_driver || !policy)
-		return;
+		return -EINVAL;
=20
 	if (policy->min > speedstep_low_freq)=20
 		speedstep_set_state(SPEEDSTEP_HIGH, 1);
@@ -585,6 +585,7 @@
 				speedstep_set_state(SPEEDSTEP_HIGH, 1);
 		}
 	}
+	return 0;
 }
=20
=20
@@ -595,11 +596,11 @@
  * Limit must be within speedstep_low_freq and speedstep_high_freq, with
  * at least one border included.
  */
-static void speedstep_verify (struct cpufreq_policy *policy)
+static int speedstep_verify (struct cpufreq_policy *policy)
 {
 	if (!policy || !speedstep_driver ||=20
 	    !speedstep_low_freq || !speedstep_high_freq)
-		return;
+		return -EINVAL;
=20
 	policy->cpu =3D 0; /* UP only */
=20
@@ -609,7 +610,7 @@
 	    (policy->max < speedstep_high_freq))
 		policy->max =3D speedstep_high_freq;
 =09
-	return;
+	return 0;
 }
=20
=20
@@ -654,12 +655,11 @@
 		speedstep_processor =3D speedstep_detect_processor();
=20
 	if ((!speedstep_chipset) || (!speedstep_processor)) {
-		printk(KERN_INFO "a 0x%x b 0x%x\n", speedstep_processor, speedstep_chips=
et);
 		printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) =
available.\n", speedstep_chipset ? "processor" : "chipset");
 		return -ENODEV;
 	}
=20
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.5=
7 $\n");
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.5=
8 $\n");
 	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n",=20
 	       speedstep_chipset, speedstep_processor);
=20
@@ -693,7 +693,7 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq    =3D speedstep_low_freq;
+	driver->cpu_min_freq[0] =3D speedstep_low_freq;
 	driver->cpu_cur_freq[0] =3D speed;
 #endif
=20
@@ -707,14 +707,15 @@
 	driver->policy[0].policy =3D (speed =3D=3D speedstep_low_freq) ?=20
 	    CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
=20
+	speedstep_driver =3D driver;
+
 	result =3D cpufreq_register(driver);
 	if (result) {
+		speedstep_driver =3D NULL;
 		kfree(driver);
-		return result;
 	}
-	speedstep_driver =3D driver;
=20
-	return 0;
+	return result;
 }
=20
=20
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/proces=
sor.c
--- linux-original/drivers/acpi/processor.c	2002-11-18 16:30:03.000000000 +=
0100
+++ linux/drivers/acpi/processor.c	2002-11-18 16:34:44.000000000 +0100
@@ -1613,7 +1613,7 @@
                                cpufreq interface
    -----------------------------------------------------------------------=
--- */
 #ifdef CONFIG_ACPI_PROCESSOR_PERF
-static void
+static int
 acpi_cpufreq_setpolicy (
 	struct cpufreq_policy   *policy)
 {
@@ -1626,7 +1626,7 @@
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_setpolicy");
=20
 	if (!policy)
-		return_VOID;
+		return_VALUE(-EINVAL);
=20
 	/* get a present, initialized CPU */
 	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS)
@@ -1644,7 +1644,7 @@
 		cpu =3D policy->cpu;
 		pr =3D processors[cpu];
 		if (!pr)
-			return_VOID;
+			return_VALUE(-EINVAL);
 	}
=20
 	/* select appropriate P-State */
@@ -1686,11 +1686,11 @@
 		result =3D acpi_processor_set_performance (pr, next_state);
 	}
=20
-	return_VOID;
+	return_VALUE(0);
 }
=20
=20
-static void
+static int
 acpi_cpufreq_verify (
 	struct cpufreq_policy   *policy)
 {
@@ -1703,7 +1703,7 @@
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_verify");
=20
 	if (!policy)
-		return_VOID;
+		return_VALUE(-EINVAL);
=20
 	/* get a present, initialized CPU */
 	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS)
@@ -1721,7 +1721,7 @@
 		cpu =3D policy->cpu;
 		pr =3D processors[cpu];
 		if (!pr)
-			return_VOID;
+			return_VALUE(-EINVAL);
 	}
=20
 	/* first check if min and max are within valid limits */
@@ -1741,13 +1741,12 @@
 			next_larger_state =3D i;
 	}
=20
-	if (number_states)
-		return_VOID;
-
-	/* round up now */
-	policy->max =3D pr->performance.states[next_larger_state].core_frequency =
* 1000;
+	if (!number_states) {
+		/* round up now */
+		policy->max =3D pr->performance.states[next_larger_state].core_frequency=
 * 1000;
+	}
=20
-	return_VOID;
+	return_VALUE(0);
 }
=20
 static int
@@ -1807,9 +1806,10 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq    =3D pr->performance.states[pr->performance.state_=
count - 1].core_frequency * 1000;
-	for (i=3D0;i<NR_CPUS;i++)
+	for (i=3D0;i<NR_CPUS;i++) {
 		driver->cpu_cur_freq[0] =3D pr->performance.states[current_state].core_f=
requency * 1000;
+		driver->cpu_min_freq[0] =3D pr->performance.states[pr->performance.state=
_count - 1].core_frequency * 1000;
+	}
 #endif
=20
 	driver->verify      =3D &acpi_cpufreq_verify;
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufre=
q.h
--- linux-original/include/linux/cpufreq.h	2002-11-17 19:09:26.000000000 +0=
100
+++ linux/include/linux/cpufreq.h	2002-11-18 16:35:13.000000000 +0100
@@ -5,7 +5,7 @@
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *           =20
  *
- * $Id: cpufreq.h,v 1.27 2002/10/08 14:54:23 db Exp $
+ * $Id: cpufreq.h,v 1.29 2002/11/11 15:35:47 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -104,7 +104,7 @@
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
=20
-typedef void (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
+typedef int (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
=20
 struct cpufreq_driver {
 	/* needed by all drivers */
@@ -116,7 +116,7 @@
 #endif
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
-	unsigned int            cpu_min_freq;
+	unsigned int            cpu_min_freq[NR_CPUS];
 	unsigned int            cpu_cur_freq[NR_CPUS];
 #endif
 };
@@ -205,19 +205,19 @@
 	CPU_NR_FREQ =3D 3,
 };
=20
-#define CTL_CPU_VARS_SPEED_MAX { \
+#define CTL_CPU_VARS_SPEED_MAX(cpunr) { \
                 .ctl_name	=3D CPU_NR_FREQ_MAX, \
-                .data		=3D &cpu_max_freq, \
+                .data		=3D &cpu_max_freq[cpunr], \
                 .procname	=3D "speed-max", \
-                .maxlen		=3D sizeof(cpu_max_freq),\
+                .maxlen		=3D sizeof(cpu_max_freq[cpunr]),\
                 .mode		=3D 0444, \
                 .proc_handler	=3D proc_dointvec, }
=20
-#define CTL_CPU_VARS_SPEED_MIN { \
+#define CTL_CPU_VARS_SPEED_MIN(cpunr) { \
                 .ctl_name	=3D CPU_NR_FREQ_MIN, \
-                .data		=3D &cpu_min_freq, \
+                .data		=3D &cpu_min_freq[cpunr], \
                 .procname	=3D "speed-min", \
-                .maxlen		=3D sizeof(cpu_min_freq),\
+                .maxlen		=3D sizeof(cpu_min_freq[cpunr]),\
                 .mode		=3D 0444, \
                 .proc_handler	=3D proc_dointvec, }
=20
@@ -230,8 +230,8 @@
                 .extra1		=3D (void*) (cpunr), }
=20
 #define CTL_TABLE_CPU_VARS(cpunr) static ctl_table ctl_cpu_vars_##cpunr[] =
=3D {\
-                CTL_CPU_VARS_SPEED_MAX, \
-                CTL_CPU_VARS_SPEED_MIN, \
+                CTL_CPU_VARS_SPEED_MAX(cpunr), \
+                CTL_CPU_VARS_SPEED_MIN(cpunr), \
                 CTL_CPU_VARS_SPEED(cpunr),  \
                 { .ctl_name =3D 0, }, }
=20
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2002-11-17 19:09:26.000000000 +0100
+++ linux/kernel/cpufreq.c	2002-11-18 16:35:44.000000000 +0100
@@ -4,7 +4,7 @@
  *  Copyright (C) 2001 Russell King
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *
- *  $Id: cpufreq.c,v 1.45 2002/10/08 14:54:23 db Exp $
+ *  $Id: cpufreq.c,v 1.50 2002/11/11 15:35:48 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -69,8 +69,8 @@
 /**
  * A few values needed by the 2.4.-compatible API
  */
-static unsigned int     cpu_max_freq;
-static unsigned int     cpu_min_freq;
+static unsigned int     cpu_max_freq[NR_CPUS];
+static unsigned int     cpu_min_freq[NR_CPUS];
 static unsigned int     cpu_cur_freq[NR_CPUS];
 #endif
=20
@@ -228,6 +228,10 @@
 			continue;
=20
 		cpufreq_get_policy(&policy, i);
+
+		if (!policy.max_cpu_freq)
+			continue;
+
 		min_pctg =3D (policy.min * 100) / policy.max_cpu_freq;
 		max_pctg =3D (policy.max * 100) / policy.max_cpu_freq;
=20
@@ -378,7 +382,7 @@
 {
 	if (!cpu_online(cpu) && (cpu !=3D CPUFREQ_ALL_CPUS))
 		return -EINVAL;
-	return cpufreq_set(cpu_max_freq, cpu);
+	return cpufreq_set(cpu_max_freq[cpu], cpu);
 }
 EXPORT_SYMBOL_GPL(cpufreq_setmax);
=20
@@ -807,13 +811,14 @@
 	policy->min    =3D cpufreq_driver->policy[cpu].min;
 	policy->max    =3D cpufreq_driver->policy[cpu].max;
 	policy->policy =3D cpufreq_driver->policy[cpu].policy;
-	policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
+	policy->max_cpu_freq =3D cpufreq_driver->policy[cpu].max_cpu_freq;
 	policy->cpu    =3D cpu;
=20
 	up(&cpufreq_driver_sem);
=20
 	return 0;
 }
+EXPORT_SYMBOL(cpufreq_get_policy);
=20
=20
 /**
@@ -825,6 +830,7 @@
 int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
 	unsigned int i;
+	int ret;
=20
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver || !cpufreq_driver->verify ||=20
@@ -834,12 +840,20 @@
 		return -EINVAL;
 	}
=20
-	down(&cpufreq_notifier_sem);
+	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS)
+		policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
+	else
+		policy->max_cpu_freq =3D cpufreq_driver->policy[policy->cpu].max_cpu_fre=
q;
=20
-	policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
=20
 	/* verify the cpu speed can be set within this limit */
-	cpufreq_driver->verify(policy);
+	ret =3D cpufreq_driver->verify(policy);
+	if (ret) {
+		up(&cpufreq_driver_sem);
+		return ret;
+	}
+
+	down(&cpufreq_notifier_sem);
=20
 	/* adjust if neccessary - all reasons */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_ADJUST,
@@ -851,7 +865,12 @@
=20
 	/* verify the cpu speed can be set within this limit,
 	   which might be different to the first one */
-	cpufreq_driver->verify(policy);
+	ret =3D cpufreq_driver->verify(policy);
+	if (ret) {
+		up(&cpufreq_notifier_sem);
+		up(&cpufreq_driver_sem);
+		return ret;
+	}
=20
 	/* notification of the new policy */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_NOTIFY,
@@ -879,11 +898,11 @@
 		cpu_cur_freq[policy->cpu] =3D policy->max;
 #endif
=20
-	cpufreq_driver->setpolicy(policy);
+	ret =3D cpufreq_driver->setpolicy(policy);
 =09
 	up(&cpufreq_driver_sem);
=20
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(cpufreq_set_policy);
=20
@@ -968,6 +987,8 @@
 int cpufreq_register(struct cpufreq_driver *driver_data)
 {
 	unsigned int            ret;
+	unsigned int            i;
+	struct cpufreq_policy   policy;
=20
 	if (cpufreq_driver)
 		return -EBUSY;
@@ -979,41 +1000,55 @@
 	down(&cpufreq_driver_sem);
 	cpufreq_driver        =3D driver_data;
 =09
-	if (!default_policy.policy)
-		default_policy.policy =3D driver_data->policy[0].policy;
-	if (!default_policy.min)
-		default_policy.min =3D driver_data->policy[0].min;
-	if (!default_policy.max)
-		default_policy.max =3D driver_data->policy[0].max;
-	default_policy.cpu =3D CPUFREQ_ALL_CPUS;
+	/* check for a default policy - if it exists, use it on _all_ CPUs*/
+	for (i=3D0; i<NR_CPUS; i++)
+	{
+		if (default_policy.policy)
+			cpufreq_driver->policy[i].policy =3D default_policy.policy;
+		if (default_policy.min)
+			cpufreq_driver->policy[i].min =3D default_policy.min;
+		if (default_policy.max)
+			cpufreq_driver->policy[i].max =3D default_policy.max;
+	}
=20
-	up(&cpufreq_driver_sem);
+	/* set default policy on all CPUs. Must be called per-CPU and not
+	 * with CPUFREQ_ALL_CPUs as there might be no common policy for all
+	 * CPUs (UltraSPARC etc.)
+	 */
+	for (i=3D0; i<NR_CPUS; i++)
+	{
+		policy.policy =3D cpufreq_driver->policy[i].policy;
+		policy.min    =3D cpufreq_driver->policy[i].min;
+		policy.max    =3D cpufreq_driver->policy[i].max;
+		policy.cpu    =3D i;
+		up(&cpufreq_driver_sem);
+		ret =3D cpufreq_set_policy(&policy);
+		down(&cpufreq_driver_sem);
+		if (ret) {
+			cpufreq_driver =3D NULL;
+			up(&cpufreq_driver_sem);
+			return ret;
+		}
+	}
=20
-	ret =3D cpufreq_set_policy(&default_policy);
+	up(&cpufreq_driver_sem);
=20
 	cpufreq_proc_init();
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	down(&cpufreq_driver_sem);
-	cpu_min_freq          =3D driver_data->cpu_min_freq;
-	cpu_max_freq          =3D driver_data->policy[0].max_cpu_freq;
+ 	down(&cpufreq_driver_sem);
+	for (i=3D0; i<NR_CPUS; i++)=20
 	{
-		unsigned int i;
-		for (i=3D0; i<NR_CPUS; i++) {
-			cpu_cur_freq[i] =3D driver_data->cpu_cur_freq[i];
-		}
+		cpu_min_freq[i] =3D driver_data->cpu_min_freq[i];
+		cpu_max_freq[i] =3D driver_data->policy[i].max_cpu_freq;
+		cpu_cur_freq[i] =3D driver_data->cpu_cur_freq[i];
 	}
 	up(&cpufreq_driver_sem);
=20
 	cpufreq_sysctl_init();
 #endif
-	if (ret) {
-		down(&cpufreq_driver_sem);
-		cpufreq_driver =3D NULL;
-		up(&cpufreq_driver_sem);
-	}
=20
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register);
=20
@@ -1061,6 +1096,7 @@
 {
 	struct cpufreq_policy policy;
 	unsigned int i;
+	unsigned int ret =3D 0;
=20
 	if (in_interrupt())
 		panic("cpufreq_restore() called from interrupt context!");
@@ -1081,10 +1117,10 @@
 		policy.cpu    =3D i;
 		up(&cpufreq_driver_sem);
=20
-		cpufreq_set_policy(&policy);
+		ret +=3D cpufreq_set_policy(&policy);
 	}
=20
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_restore);
 #else

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE93nPmZ8MDCHJbN8YRApViAJ4r3nYoYLjbwQX1siKYlRYL1xq/ZACfRGx0
UB2294XecIfYrKe8xyTZkso=
=qL5d
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
