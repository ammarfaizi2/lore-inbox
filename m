Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSKEKrM>; Tue, 5 Nov 2002 05:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbSKEKrL>; Tue, 5 Nov 2002 05:47:11 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:34301 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264799AbSKEKqM>; Tue, 5 Nov 2002 05:46:12 -0500
Date: Tue, 5 Nov 2002 11:51:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.5. PATCH] cpufreq: modify return type from void to int for cpufreq_policy_t
Message-ID: <20021105115141.A11428@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch changes the return type of the cpufreq policy-verifying and
applying functions from void to int. This is a first step towards
UltraSPARC support - there might be no common subset of possible
frequencies, so there would be nothing that verify could do on
CPUFREQ_ALL_CPUS. Also, make the first setpolicy call actually work on
all cpufreq drivers.

	Dominik

--- linux-2545original/include/linux/cpufreq.h	Thu Oct 31 12:00:00 2002
+++ linux/include/linux/cpufreq.h	Thu Oct 31 23:00:00 2002
@@ -104,7 +104,7 @@
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
=20
-typedef void (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
+typedef int (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
=20
 struct cpufreq_driver {
 	/* needed by all drivers */
--- linux-2545original/kernel/cpufreq.c	Thu Oct 31 12:00:00 2002
+++ linux/kernel/cpufreq.c	Thu Oct 31 23:00:00 2002
@@ -825,6 +825,7 @@
 int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
 	unsigned int i;
+	int ret;
=20
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver || !cpufreq_driver->verify ||=20
@@ -834,12 +835,16 @@
 		return -EINVAL;
 	}
=20
-	down(&cpufreq_notifier_sem);
-
 	policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
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
@@ -851,7 +856,12 @@
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
@@ -879,11 +889,11 @@
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
--- linux-2545original/Documentation/cpufreq	Thu Oct 31 12:00:00 2002
+++ linux/Documentation/cpufreq	Thu Oct 31 23:00:00 2002
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
@@ -318,14 +321,14 @@
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
--- linux-2545original/drivers/acpi/processor.c	Thu Oct 31 12:00:00 2002
+++ linux/drivers/acpi/processor.c	Thu Oct 31 23:00:00 2002
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
diff -ruN linux-2545original/arch/arm/mach-integrator/cpu.c linux/arch/arm/=
mach-integrator/cpu.c
--- linux-2545original/arch/arm/mach-integrator/cpu.c	Thu Oct 31 12:00:00 2=
002
+++ linux/arch/arm/mach-integrator/cpu.c	Thu Oct 31 23:00:00 2002
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
diff -ruN linux-2545original/arch/arm/mach-sa1100/cpu-sa1100.c linux/arch/a=
rm/mach-sa1100/cpu-sa1100.c
--- linux-2545original/arch/arm/mach-sa1100/cpu-sa1100.c	Thu Oct 31 12:00:0=
0 2002
+++ linux/arch/arm/mach-sa1100/cpu-sa1100.c	Thu Oct 31 23:00:00 2002
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
@@ -216,7 +218,7 @@
 	int ret =3D -ENODEV;
=20
 	if ((processor_id & CPU_SA1100_MASK) =3D=3D CPU_SA1100_ID) {
-		sa1100_driver.cpu_curr_freq[0] =3D
+		sa1100_driver.cpu_cur_freq[0] =3D
 		sa1100_policy.min =3D
 		sa1100_policy.max =3D sa11x0_getspeed();
=20
diff -ruN linux-2545original/arch/arm/mach-sa1100/cpu-sa1110.c linux/arch/a=
rm/mach-sa1100/cpu-sa1110.c
--- linux-2545original/arch/arm/mach-sa1100/cpu-sa1110.c	Thu Oct 31 12:00:0=
0 2002
+++ linux/arch/arm/mach-sa1100/cpu-sa1110.c	Thu Oct 31 23:00:00 2002
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
diff -ruN linux-2545original/arch/arm/mach-sa1100/generic.c linux/arch/arm/=
mach-sa1100/generic.c
--- linux-2545original/arch/arm/mach-sa1100/generic.c	Thu Oct 31 12:00:00 2=
002
+++ linux/arch/arm/mach-sa1100/generic.c	Thu Oct 31 23:00:00 2002
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
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/=
arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Thu Oct 31 1=
2:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Thu Oct 31 23:00:00 2002
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
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/=
arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Oct 31 1=
2:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Oct 31 23:00:00 2002
@@ -531,7 +531,7 @@
 }
=20
=20
-static void longhaul_verify(struct cpufreq_policy *policy)
+static int longhaul_verify(struct cpufreq_policy *policy)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i;
@@ -540,7 +540,7 @@
 	unsigned int    newmax =3D -1;
=20
 	if (!policy || !longhaul_driver)
-		return;
+		return -EINVAL;
=20
 	policy->cpu =3D 0;
 	cpufreq_verify_within_limits(policy, lowest_speed, highest_speed);
@@ -552,7 +552,7 @@
 		number_states =3D longhaul_statecount_fsb(policy, current_fsb);
=20
 	if (number_states)
-		return;
+		return 0;
=20
 	/* get frequency closest above current policy->max */
 	if (can_scale_fsb=3D=3D1) {
@@ -579,10 +579,12 @@
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
@@ -592,7 +594,7 @@
 	unsigned int    best_freq =3D -1;
=20
 	if (!longhaul_driver)
-		return;
+		return -EINVAL;
=20
 	if (policy->policy=3D=3DCPUFREQ_POLICY_PERFORMANCE)
 		fsb_search_table =3D perf_fsb_table;
@@ -613,7 +615,7 @@
 	}
=20
 	if (!number_states)
-		return;
+		return -EINVAL;
 	else if (number_states =3D=3D 1) {
 		for(i=3D0; i<numscales; i++) {
 			if ((clock_ratio[i] !=3D -1) &&
@@ -692,11 +694,11 @@
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
@@ -788,15 +790,15 @@
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
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/a=
rch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Oct 31 12=
:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Oct 31 23:00:00 2002
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
@@ -258,14 +258,16 @@
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
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c lin=
ux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Oct 3=
1 12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Oct 31 23:00:00 20=
02
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
@@ -274,15 +275,15 @@
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
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c lin=
ux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Thu Oct 3=
1 12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Thu Oct 31 23:00:00 20=
02
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
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux=
/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Oct 31 =
12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Oct 31 23:00:00 2002
@@ -576,10 +576,10 @@
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
@@ -594,6 +594,7 @@
 				speedstep_set_state(SPEEDSTEP_HIGH, 1);
 		}
 	}
+	return 0;
 }
=20
=20
@@ -604,11 +605,11 @@
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
@@ -618,7 +619,7 @@
 	    (policy->max < speedstep_high_freq))
 		policy->max =3D speedstep_high_freq;
 =09
-	return;
+	return 0;
 }
=20
=20
@@ -696,14 +697,15 @@
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

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9x6K8Z8MDCHJbN8YRAi4HAJ90bcoULY563m5o8673xT/MVqiMqACbBkFu
R8/9OkMI4m+HE+5b3V0H/KU=
=EDTv
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
