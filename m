Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSLOMoK>; Sun, 15 Dec 2002 07:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSLOMoK>; Sun, 15 Dec 2002 07:44:10 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:26029 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266497AbSLOMnU>; Sun, 15 Dec 2002 07:43:20 -0500
Date: Sun, 15 Dec 2002 13:49:34 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, davej@suse.de
Subject: [PATCH 2.5] cpufreq: change setpolicy to event
Message-ID: <20021215124934.GA6238@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[NOTE: This patch depends on the patch "cpufreq: clean up CPU information"=
=20
sent on Friday, but is independend of the patch "cpufreq: move x86=20
configuration to "Power Management" which was also submitted on Friday]

This patch changes the arguments, the name and the nature of the
"main" callback function for cpufreq drivers. It is now called
"event", and gets the following arguments:

struct cpufreq_policy policy - same as before. Because of this, all
       existing cpufreq drivers continue to work, but can be changed
       one-by-one to use the new values described below.

unsigned int event - specifies the "event" which caused this function
	 call. Currently, the following events are defined:
	 _INIT, _EXIT and _CHANGE_POLICY. For interval-based dynamic
	 frequency switching, _INTERVAL may be used later; for other
	 purpouses ("burst mode" on Geode, per-task switching etc.)
	 other events may be added.

unsigned int target_freq - On processors that only allow for frequency=20
	 ranges (like the Transmeta Crusoe processor) the target_freq=20
	 is ignored. The policy->min and policy->max values are used
	 to set the frequency range -- just like before.

	 Most processors, though, only allow to be set to a specific
	 frequency. So far, the different "policy models"
	 (powersave/performance) were implemented in each cpufreq
	 processor driver. This will be abstracted in future: the
	 cpufreq driver will set the processor to the frequency
	 closest to target_freq within the "policy borders"
	 [policy->min, policy->max].

unsigned int relation - if the processor can't set the CPU speed
	 exactly to the value target_freq, this value decides what=20
	 frequency to use instead:

	 CPUFREQ_REL_L means the _lowest_ frequency within the policy=20
	 limit is used, but it shall be not lower than target_freq.
	 If the processor can't be set to a speed between target_freq
	 and policy->max, the highest speed below target_freq is used.

	 CPUFREQ_REL_H means the highest frequency within the policy
	 limit is used, but it shall be not higher than target_freq.
	 If the processor can't be set to a speed between target_freq
	 and policy->min, the lowest speed above target_freq is used.

	 --------------------------------------------------------> CPU freq.
	      |				|		     |
         policy->min		   target_freq 		 policy->max
CPUFREQ_REL_H |----------------------->>|*
  				       *|<<------------------|
						CPUFREQ_REL_L


The target_freq and the relation are calculated by CPUfreq governors.=20
("governor - A feedback device on a machine or engine that is used to
 provide automatic control, as of speed,  pressure, or temperature"
 [http://dictionary.reference.com/search?q=3Dgovernor] [Thanks, David!])

This patch adds two such governors:
"powersave" selects the lowest speed within the policy limits
statically, and
"performance" selects the highest speed within the policy limits statically.
More governors will be added in future, e.g. governors which implement
different "dynamic frequency scaling" models (bounded-delay
limited-past, real-time DVS, etc.).


	Dominik


diff -ruN linux-Kconfig/arch/arm/mach-integrator/cpu.c linux/arch/arm/mach-=
integrator/cpu.c
--- linux-Kconfig/arch/arm/mach-integrator/cpu.c	2002-12-13 16:48:20.000000=
000 +0100
+++ linux/arch/arm/mach-integrator/cpu.c	2002-12-15 12:50:34.000000000 +0100
@@ -118,7 +118,10 @@
 	__raw_writel(0, CM_LOCK);
 }
=20
-static int integrator_set_policy(struct cpufreq_policy *policy)
+static int integrator_event(struct cpufreq_policy *policy,
+			    unsigned int event,
+			    unsigned int target_freq,
+			    unsigned int relation)
 {
 	unsigned long cpus_allowed;
 	int cpu;
@@ -155,7 +158,7 @@
=20
 static struct cpufreq_driver integrator_driver =3D {
 	.verify		=3D integrator_verify_speed,
-	.setpolicy	=3D integrator_set_policy,
+	.event    	=3D integrator_event,
 	.policy		=3D &integrator_policy,
 };
 #endif
diff -ruN linux-Kconfig/arch/arm/mach-sa1100/cpu-sa1100.c linux/arch/arm/ma=
ch-sa1100/cpu-sa1100.c
--- linux-Kconfig/arch/arm/mach-sa1100/cpu-sa1100.c	2002-12-13 16:48:20.000=
000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1100.c	2002-12-15 12:51:57.000000000 +=
0100
@@ -176,7 +176,10 @@
 	}
 }
=20
-static int sa1100_setspeed(struct cpufreq_policy *policy)
+static int sa1100_event (struct cpufreq_policy *policy,
+			 unsigned int event,
+			 unsigned int target_freq,
+			 unsigned int relation)
 {
 	unsigned int cur =3D sa11x0_getspeed();
 	struct cpufreq_freqs freqs;
@@ -210,7 +213,7 @@
=20
 static struct cpufreq_driver sa1100_driver =3D {
 	.verify		=3D sa11x0_verify_speed,
-	.setpolicy	=3D sa1100_setspeed,
+	.event		=3D sa1100_event,
 	.policy		=3D &sa1100_policy,
 };
=20
diff -ruN linux-Kconfig/arch/arm/mach-sa1100/cpu-sa1110.c linux/arch/arm/ma=
ch-sa1100/cpu-sa1110.c
--- linux-Kconfig/arch/arm/mach-sa1100/cpu-sa1110.c	2002-12-13 16:48:20.000=
000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1110.c	2002-12-15 12:52:54.000000000 +=
0100
@@ -212,7 +212,10 @@
  * above, we can match for an exact frequency.  If we don't find
  * an exact match, we will to set the lowest frequency to be safe.
  */
-static int sa1110_setspeed(struct cpufreq_policy *policy)
+static int sa1110_event(struct cpufreq_policy *policy,
+			unsigned int event,
+			unsigned int target_freq,
+			unsigned int relation)
 {
 	struct sdram_params *sdram =3D &sdram_params;
 	struct cpufreq_freqs freqs;
@@ -304,9 +307,9 @@
 };
=20
 static struct cpufreq_driver sa1110_driver =3D {
-	.verify		 =3D sa11x0_verify_speed,
-	.setpolicy	 =3D sa1110_setspeed,
-	.policy		 =3D &sa1110_policy,
+	.verify	 =3D sa11x0_verify_speed,
+	.event	 =3D sa1110_event,
+	.policy	 =3D &sa1110_policy,
 };
=20
 static int __init sa1110_clk_init(void)
diff -ruN linux-Kconfig/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/=
i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-Kconfig/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-13 16:48:=
16.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-15 12:44:05.00000=
0000 +0100
@@ -201,7 +201,10 @@
 	return 0;
 }
=20
-static int elanfreq_setpolicy (struct cpufreq_policy *policy)
+static int elanfreq_event (struct cpufreq_policy *policy,
+			   unsigned int event,
+			   unsigned int target_freq,
+			   unsigned int relation)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i, j=3D4;
@@ -300,7 +303,7 @@
 #endif
=20
 	driver->verify        =3D &elanfreq_verify;
-	driver->setpolicy     =3D &elanfreq_setpolicy;
+	driver->event         =3D &elanfreq_event;
=20
 	driver->policy[0].cpu    =3D 0;
 	driver->policy[0].min    =3D 1000;
diff -ruN linux-Kconfig/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/=
i386/kernel/cpu/cpufreq/longhaul.c
--- linux-Kconfig/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-13 16:48:=
16.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-15 12:46:35.00000=
0000 +0100
@@ -586,7 +586,10 @@
 }
=20
=20
-static int longhaul_setpolicy (struct cpufreq_policy *policy)
+static int longhaul_event (struct cpufreq_policy *policy,
+			   unsigned int event,
+			   unsigned int target_freq,
+			   unsigned int relation)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i;
@@ -782,8 +785,8 @@
 	driver->cpu_cur_freq[0] =3D currentspeed;
 #endif
=20
-	driver->verify    =3D &longhaul_verify;
-	driver->setpolicy =3D &longhaul_setpolicy;
+	driver->verify =3D &longhaul_verify;
+	driver->event  =3D &longhaul_event;
=20
 	driver->policy[0].cpu =3D 0;
 	driver->policy[0].min =3D (unsigned int) lowest_speed;
diff -ruN linux-Kconfig/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/i=
386/kernel/cpu/cpufreq/longrun.c
--- linux-Kconfig/arch/i386/kernel/cpu/cpufreq/longrun.c	2002-12-13 16:48:1=
6.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2002-12-15 12:46:48.000000=
000 +0100
@@ -67,7 +67,10 @@
  * Sets a new CPUFreq policy on LongRun-capable processors. This function
  * has to be called with cpufreq_driver locked.
  */
-static int longrun_set_policy(struct cpufreq_policy *policy)
+static int longrun_event(struct cpufreq_policy *policy,
+			 unsigned int event,
+			 unsigned int target_freq,
+			 unsigned int relation)
 {
 	u32 msr_lo, msr_hi;
 	u32 pctg_lo, pctg_hi;
@@ -258,8 +261,8 @@
 	driver->cpu_cur_freq[0] =3D longrun_high_freq; /* dummy value */
 #endif
=20
-	driver->verify         =3D &longrun_verify_policy;
-	driver->setpolicy      =3D &longrun_set_policy;
+	driver->verify =3D &longrun_verify_policy;
+	driver->event  =3D &longrun_event;
=20
 	longrun_driver =3D driver;
=20
diff -ruN linux-Kconfig/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/ar=
ch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-Kconfig/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-12-13 16:=
48:16.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-12-15 12:45:24.00=
0000000 +0100
@@ -136,7 +136,10 @@
 }
=20
=20
-static int cpufreq_p4_setpolicy(struct cpufreq_policy *policy)
+static int cpufreq_p4_event(struct cpufreq_policy *policy,
+			    unsigned int event,
+			    unsigned int target_freq,
+			    unsigned int relation)
 {
 	unsigned int    i;
 	unsigned int    newstate =3D 0;
@@ -261,8 +264,8 @@
 	}
 #endif
=20
-	driver->verify        =3D &cpufreq_p4_verify;
-	driver->setpolicy     =3D &cpufreq_p4_setpolicy;
+	driver->verify =3D &cpufreq_p4_verify;
+	driver->event  =3D &cpufreq_p4_event;
=20
 	for (i=3D0;i<NR_CPUS;i++) {
 		if (has_N44_O17_errata)
diff -ruN linux-Kconfig/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/ar=
ch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-Kconfig/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-13 16:=
48:16.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-15 12:45:50.00=
0000000 +0100
@@ -154,7 +154,10 @@
  *
  * sets a new CPUFreq policy
  */
-static int powernow_k6_setpolicy (struct cpufreq_policy *policy)
+static int powernow_k6_event (struct cpufreq_policy *policy,
+			      unsigned int event,
+			      unsigned int target_freq,
+			      unsigned int relation)
 {
 	unsigned int    number_states =3D 0;
 	unsigned int    i, j=3D4;
@@ -245,8 +248,8 @@
 	driver->cpu_cur_freq[0]  =3D busfreq * max_multiplier;
 #endif
=20
-	driver->verify        =3D &powernow_k6_verify;
-	driver->setpolicy     =3D &powernow_k6_setpolicy;
+	driver->verify =3D &powernow_k6_verify;
+	driver->event  =3D &powernow_k6_event;
=20
 	driver->policy[0].cpu    =3D 0;
 	driver->policy[0].min    =3D busfreq * 20;
diff -ruN linux-Kconfig/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch=
/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-Kconfig/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-13 16:48=
:16.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-15 12:47:35.0000=
00000 +0100
@@ -567,7 +567,10 @@
  *
  * Sets a new CPUFreq policy.
  */
-static int speedstep_setpolicy (struct cpufreq_policy *policy)
+static int speedstep_event (struct cpufreq_policy *policy,
+			    unsigned int event,
+			    unsigned int target_freq,
+			    unsigned int relation)
 {
 	if (!speedstep_driver || !policy)
 		return -EINVAL;
@@ -696,8 +699,8 @@
 	driver->cpu_cur_freq[0] =3D speed;
 #endif
=20
-	driver->verify      =3D &speedstep_verify;
-	driver->setpolicy   =3D &speedstep_setpolicy;
+	driver->verify =3D &speedstep_verify;
+	driver->event  =3D &speedstep_event;
=20
 	driver->policy[0].cpu    =3D 0;
 	driver->policy[0].min    =3D speedstep_low_freq;
diff -ruN linux-Kconfig/drivers/acpi/processor.c linux/drivers/acpi/process=
or.c
--- linux-Kconfig/drivers/acpi/processor.c	2002-12-13 16:48:42.000000000 +0=
100
+++ linux/drivers/acpi/processor.c	2002-12-15 12:48:38.000000000 +0100
@@ -1655,8 +1655,10 @@
    -----------------------------------------------------------------------=
--- */
 #ifdef CONFIG_ACPI_PROCESSOR_PERF
 static int
-acpi_cpufreq_setpolicy (
-	struct cpufreq_policy   *policy)
+acpi_cpufreq_event (struct cpufreq_policy *policy,
+		    unsigned int event,
+		    unsigned int target_freq,
+		    unsigned int relation)
 {
 	unsigned int cpu =3D 0;
 	unsigned int i =3D 0;
@@ -1664,7 +1666,7 @@
 	unsigned int next_state =3D 0;
 	unsigned int result =3D 0;
=20
-	ACPI_FUNCTION_TRACE("acpi_cpufreq_setpolicy");
+	ACPI_FUNCTION_TRACE("acpi_cpufreq_event");
=20
 	if (!policy)
 		return_VALUE(-EINVAL);
@@ -1858,8 +1860,8 @@
 			driver->policy[0].cpuinfo.transition_latency =3D pr->performance.states=
[i].transition_latency;
 	}
=20
-	driver->verify      =3D &acpi_cpufreq_verify;
-	driver->setpolicy   =3D &acpi_cpufreq_setpolicy;
+	driver->verify =3D &acpi_cpufreq_verify;
+	driver->event  =3D &acpi_cpufreq_event;
=20
 	for (i=3D0;i<NR_CPUS;i++) {
 		driver->policy[i].cpu    =3D pr->id;
diff -ruN linux-Kconfig/include/linux/cpufreq.h linux/include/linux/cpufreq=
.h
--- linux-Kconfig/include/linux/cpufreq.h	2002-12-13 16:48:47.000000000 +01=
00
+++ linux/include/linux/cpufreq.h	2002-12-15 12:39:32.000000000 +0100
@@ -104,27 +104,33 @@
=20
=20
 /*********************************************************************
- *                      DYNAMIC CPUFREQ INTERFACE                    *
+ *                      CPUFREQ GOVERNOR INTERFACE                   *
  *********************************************************************/
-#ifdef CONFIG_CPU_FREQ_DYNAMIC
-/* TBD */
-#endif /* CONFIG_CPU_FREQ_DYNAMIC */
+/* events */
+#define CPUFREQ_EVENT_INIT              1
+#define CPUFREQ_EVENT_EXIT              2
+#define CPUFREQ_EVENT_CHANGE_LIMITS     3
+
+/* relation */
+/* as close to target_freq as possible, but no higher */
+#define CPUFREQ_REL_H                   0=20
+/* as close to target_freq as possible, but no lower */
+#define CPUFREQ_REL_L                   1
=20
=20
 /*********************************************************************
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
=20
-typedef int (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
-
 struct cpufreq_driver {
-	/* needed by all drivers */
-	cpufreq_policy_t        verify;
-	cpufreq_policy_t        setpolicy;
+	/* pointer to policy struct array for all CPUs */
 	struct cpufreq_policy   *policy;
-#ifdef CONFIG_CPU_FREQ_DYNAMIC
-	/* TBD */
-#endif
+	/* verify and event callbacks */
+	int     (*verify)       (struct cpufreq_policy *policy);
+	int     (*event)        (struct cpufreq_policy *policy,
+				 unsigned int event,
+				 unsigned int target_freq,
+				 unsigned int relation);
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
 	unsigned int            cpu_cur_freq[NR_CPUS];
diff -ruN linux-Kconfig/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-Kconfig/kernel/cpufreq.c	2002-12-13 16:48:52.000000000 +0100
+++ linux/kernel/cpufreq.c	2002-12-15 13:08:07.000000000 +0100
@@ -798,7 +798,96 @@
 }
 EXPORT_SYMBOL(cpufreq_unregister_notifier);
=20
+/*********************************************************************
+ *                          CPUFREQ GOVERNORS                        *
+ *********************************************************************/
+
+
+static int cpufreq_driver_event(struct cpufreq_policy *policy,=20
+				unsigned int event,=20
+				unsigned int target_freq,=20
+				unsigned int relation)
+{
+	return cpufreq_driver->event(policy, event, target_freq, relation);
+}
+
+/*
+ * CPUfreq governor "performance": it selects the highest speed within
+ * the current cpufreq policy limit statically.
+ */
+static int cpufreq_governor_performance_event(struct cpufreq_policy *polic=
y,
+					      unsigned int event)
+{
+	if (!policy)
+		return -EINVAL;
=20
+	if (!cpu_online(policy->cpu))
+		return -ENODEV;
+
+	switch (event) {
+	case CPUFREQ_EVENT_INIT:
+		return 0;
+	case CPUFREQ_EVENT_CHANGE_LIMITS:
+		return cpufreq_driver_event(policy, event,
+					    policy->max,=20
+					    CPUFREQ_REL_H);
+	case CPUFREQ_EVENT_EXIT:
+		return 0;
+	}
+	/* unknown event */
+	return -EINVAL;
+}
+
+/*
+ * CPUfreq governor "powersave": it selects the lowest speed within
+ * the current cpufreq policy limit statically.
+ */
+static int cpufreq_governor_powersave_event(struct cpufreq_policy *policy,
+					    unsigned int event)
+{
+	if (!policy)
+		return -EINVAL;
+
+	if (!cpu_online(policy->cpu))
+		return -ENODEV;
+
+	switch (event) {
+	case CPUFREQ_EVENT_INIT:
+		return 0;
+	case CPUFREQ_EVENT_CHANGE_LIMITS:
+		return cpufreq_driver_event(policy, event,
+					    policy->min,=20
+					    CPUFREQ_REL_L);
+	case CPUFREQ_EVENT_EXIT:
+		return 0;
+	}
+	/* unknown event */
+	return -EINVAL;
+}
+
+
+/**
+ * cpufreq_governor_event_l - pass an event to the current cpufreq governo=
r while all locks are held
+ * @cpu: affected CPU
+ * @event: event type
+ *
+ * This passes an event to the current cpufreq governor assigned to the sp=
ecified CPU. It may only
+ * be called when all neccessary locks are held.
+ */
+int cpufreq_governor_event_l(unsigned int cpu, unsigned int event)
+{
+	if (!cpufreq_driver || !cpu_online(cpu))
+		return -ENODEV;
+	switch (cpufreq_driver->policy[cpu].policy) {
+	case CPUFREQ_POLICY_POWERSAVE:
+		return cpufreq_governor_powersave_event(&cpufreq_driver->policy[cpu], ev=
ent);
+	case CPUFREQ_POLICY_PERFORMANCE:
+		return cpufreq_governor_performance_event(&cpufreq_driver->policy[cpu], =
event);
+	default:
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
=20
 /*********************************************************************
  *                          POLICY INTERFACE                         *
@@ -847,7 +936,7 @@
=20
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver || !cpufreq_driver->verify ||=20
-	    !cpufreq_driver->setpolicy || !policy ||
+	    !cpufreq_driver->event || !policy ||
 	    (policy->cpu >=3D NR_CPUS) || (!cpu_online(policy->cpu))) {
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
@@ -909,8 +998,8 @@
 		cpu_cur_freq[policy->cpu] =3D policy->max;
 #endif
=20
-	ret =3D cpufreq_driver->setpolicy(policy);
-=09
+	ret =3D cpufreq_governor_event_l(policy->cpu, CPUFREQ_EVENT_CHANGE_LIMITS=
);
+
 	up(&cpufreq_driver_sem);
=20
 	return ret;
@@ -920,15 +1009,6 @@
=20
=20
 /*********************************************************************
- *                    DYNAMIC CPUFREQ SWITCHING                      *
- *********************************************************************/
-#ifdef CONFIG_CPU_FREQ_DYNAMIC
-/* TBD */
-#endif /* CONFIG_CPU_FREQ_DYNAMIC */
-
-
-
-/*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
=20
@@ -1005,7 +1085,7 @@
 		return -EBUSY;
 =09
 	if (!driver_data || !driver_data->verify ||=20
-	    !driver_data->setpolicy)
+	    !driver_data->event)
 		return -EINVAL;
=20
 	down(&cpufreq_driver_sem);

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9/HpbZ8MDCHJbN8YRAo3fAJ0QJk78HUav5vvfRwC7e79DJ5oq2wCfZJnx
EEkL4O/czdlvnRLR5fB58Sg=
=GmWP
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
