Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSLMPBh>; Fri, 13 Dec 2002 10:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLMPBh>; Fri, 13 Dec 2002 10:01:37 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:9710 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264739AbSLMPBS>; Fri, 13 Dec 2002 10:01:18 -0500
Date: Fri, 13 Dec 2002 16:07:32 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk, davej@suse.de
Subject: [PATCH 2.5] cpufreq: clean up CPU information
Message-ID: <20021213150732.GA14724@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch moves some basic per-CPU static information (minimum frequency,=
=20
maximum frequency and maximum transition latency) into a struct=20
cpufreq_cpuinfo. This offers a much cleaner struct cpufreq_driver and=20
struct cpufreq_policy.=20

	Dominik

diff -ruN linux-original/arch/arm/mach-integrator/cpu.c linux/arch/arm/mach=
-integrator/cpu.c
--- linux-original/arch/arm/mach-integrator/cpu.c	2002-11-23 09:08:56.00000=
0000 +0100
+++ linux/arch/arm/mach-integrator/cpu.c	2002-12-13 15:44:26.000000000 +0100
@@ -77,8 +77,8 @@
 {
 	struct vco vco;
=20
-	if (policy->max > policy->max_cpu_freq)
-		policy->max =3D policy->max_cpu_freq;
+	if (policy->max > policy->cpuinfo.max_freq)
+		policy->max =3D policy->cpuinfo.max_freq;
=20
 	if (policy->max < 12000)
 		policy->max =3D 12000;
@@ -148,7 +148,9 @@
 static struct cpufreq_policy integrator_policy =3D {
 	.cpu		=3D 0,
 	.policy		=3D CPUFREQ_POLICY_POWERSAVE,
-	.max_cpu_freq	=3D 160000,
+	.cpuinfo.max_cpu_freq	=3D 160000,
+	.cpuinfo.min_cpu_freq   =3D 12000,
+	.cpuinfo.transition_latency  =3D CPUFREQ_ETERNAL,
 };
=20
 static struct cpufreq_driver integrator_driver =3D {
@@ -197,7 +199,9 @@
=20
 		policies[cpu].cpu =3D cpu;
 		policies[cpu].policy =3D CPUFREQ_POLICY_POWERSAVE,
-		policies[cpu].max_cpu_freq =3D 160000;
+		policies[cpu].cpuinfo.max_freq =3D 160000;
+		policies[cpu].cpuinfo.min_freq =3D 12000;
+		policies[cpu].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
 		policies[cpu].min =3D
 		policies[cpu].max =3D vco_to_freq(vco, 1);
 	}
@@ -205,8 +209,6 @@
 	set_cpus_allowed(current, cpus_allowed);
=20
 #ifdef CONFIG_CPU_FREQ
-	for (cpu=3D0; cpu<NR_CPUS; cpu++)
-		integrator_driver.cpu_min_freq[cpu] =3D 12000;
 	integrator_driver.policy =3D policies;
 	cpufreq_register(&integrator_driver);
 #else
diff -ruN linux-original/arch/arm/mach-sa1100/cpu-sa1100.c linux/arch/arm/m=
ach-sa1100/cpu-sa1100.c
--- linux-original/arch/arm/mach-sa1100/cpu-sa1100.c	2002-11-23 09:08:56.00=
0000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1100.c	2002-12-13 15:25:38.000000000 +=
0100
@@ -203,14 +203,15 @@
 static struct cpufreq_policy sa1100_policy =3D {
 	.cpu		=3D 0,
 	.policy		=3D CPUFREQ_POLICY_POWERSAVE,
-	.max_cpu_freq	=3D 287000,
+	.cpuinfo.max_freq	=3D 287000,
+	.cpuinfo.min_freq	=3D 59000,
+	.cpuinfo.transition_latency	=3D CPUFREQ_ETERNAL,
 };
=20
 static struct cpufreq_driver sa1100_driver =3D {
 	.verify		=3D sa11x0_verify_speed,
 	.setpolicy	=3D sa1100_setspeed,
 	.policy		=3D &sa1100_policy,
-	.cpu_min_freq[0]=3D 59000,
 };
=20
 static int __init sa1100_dram_init(void)
diff -ruN linux-original/arch/arm/mach-sa1100/cpu-sa1110.c linux/arch/arm/m=
ach-sa1100/cpu-sa1110.c
--- linux-original/arch/arm/mach-sa1100/cpu-sa1110.c	2002-12-13 14:41:27.00=
0000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1110.c	2002-12-13 15:27:01.000000000 +=
0100
@@ -298,14 +298,15 @@
 static struct cpufreq_policy sa1110_policy =3D {
 	.cpu		=3D 0,
 	.policy		=3D CPUFREQ_POLICY_POWERSAVE,
-	.max_cpu_freq	=3D 287000,
+	.cpuinfo.max_freq	=3D 287000,
+	.cpuinfo.min_freq	=3D 59000,
+	.cpuinfo.transition_latency	=3D CPUFREQ_ETERNAL,
 };
=20
 static struct cpufreq_driver sa1110_driver =3D {
 	.verify		 =3D sa11x0_verify_speed,
 	.setpolicy	 =3D sa1110_setspeed,
 	.policy		 =3D &sa1110_policy,
-	.cpu_min_freq	 =3D { 59000, },
 };
=20
 static int __init sa1110_clk_init(void)
diff -ruN linux-original/arch/arm/mach-sa1100/generic.c linux/arch/arm/mach=
-sa1100/generic.c
--- linux-original/arch/arm/mach-sa1100/generic.c	2002-11-23 09:08:56.00000=
0000 +0100
+++ linux/arch/arm/mach-sa1100/generic.c	2002-12-13 15:22:36.000000000 +0100
@@ -69,8 +69,8 @@
  */
 int sa11x0_verify_speed(struct cpufreq_policy *policy)
 {
-	if (policy->max > policy->max_cpu_freq)
-		policy->max =3D policy->max_cpu_freq;
+	if (policy->max > policy->cpuinfo.max_freq)
+		policy->max =3D policy->cpuinfo.max_freq;
=20
 	policy->max =3D cclk_frequency_100khz[sa11x0_freq_to_ppcr(policy->max)] *=
 100;
 	policy->min =3D policy->max;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch=
/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-11-23 09:08=
:56.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-13 15:01:35.00000=
0000 +0100
@@ -296,7 +296,6 @@
 		max_freq =3D elanfreq_get_cpu_frequency();
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq[0] =3D 1000;
 	driver->cpu_cur_freq[0] =3D elanfreq_get_cpu_frequency();
 #endif
=20
@@ -307,7 +306,9 @@
 	driver->policy[0].min    =3D 1000;
 	driver->policy[0].max    =3D max_freq;
 	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
-	driver->policy[0].max_cpu_freq  =3D max_freq;
+	driver->policy[0].cpuinfo.max_freq =3D max_freq;
+	driver->policy[0].cpuinfo.min_freq =3D min_freq;
+	driver->policy[0].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
=20
 	elanfreq_driver =3D driver;
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch=
/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-11-23 09:08=
:56.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-13 15:03:20.00000=
0000 +0100
@@ -779,7 +779,6 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq[0] =3D (unsigned int) lowest_speed;
 	driver->cpu_cur_freq[0] =3D currentspeed;
 #endif
=20
@@ -790,7 +789,9 @@
 	driver->policy[0].min =3D (unsigned int) lowest_speed;
 	driver->policy[0].max =3D (unsigned int) highest_speed;
 	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
-	driver->policy[0].max_cpu_freq =3D (unsigned int) highest_speed;
+	driver->policy[0].cpuinfo.min_freq =3D (unsigned int) lowest_speed;
+	driver->policy[0].cpuinfo.max_freq =3D (unsigned int) highest_speed;
+	driver->policy[0].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
=20
 	longhaul_driver =3D driver;
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/=
i386/kernel/cpu/cpufreq/longrun.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c	2002-11-23 09:08:=
56.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2002-12-13 15:06:32.000000=
000 +0100
@@ -121,8 +121,9 @@
 		return -EINVAL;
=20
 	policy->cpu =3D 0;
-	cpufreq_verify_within_limits(policy, 0,=20
-		longrun_driver->policy[0].max_cpu_freq);
+	cpufreq_verify_within_limits(policy,=20
+		longrun_driver->policy[0].cpuinfo.min_freq,=20
+		longrun_driver->policy[0].cpuinfo.max_freq);
=20
 	return 0;
 }
@@ -247,12 +248,13 @@
 		kfree(driver);
 		return -EIO;
 	}
-	driver->policy[0].max_cpu_freq  =3D longrun_high_freq;
+	driver->policy[0].cpuinfo.min_freq =3D longrun_low_freq;
+	driver->policy[0].cpuinfo.max_freq =3D longrun_high_freq;
+	driver->policy[0].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
=20
 	longrun_get_policy(&driver->policy[0]);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq[0] =3D longrun_low_freq;
 	driver->cpu_cur_freq[0] =3D longrun_high_freq; /* dummy value */
 #endif
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/a=
rch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-11-23 09=
:08:56.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-12-13 15:04:26.00=
0000000 +0100
@@ -257,7 +257,6 @@
=20
 #ifdef CONFIG_CPU_FREQ_24_API
 	for (i=3D0;i<NR_CPUS;i++) {
-		driver->cpu_min_freq[i] =3D stock_freq / 8;
 		driver->cpu_cur_freq[i] =3D stock_freq;
 	}
 #endif
@@ -272,7 +271,10 @@
 			driver->policy[i].min    =3D stock_freq / 8;
 		driver->policy[i].max    =3D stock_freq;
 		driver->policy[i].policy =3D CPUFREQ_POLICY_PERFORMANCE;
-		driver->policy[i].max_cpu_freq  =3D stock_freq;
+		driver->policy[i].cpuinfo.min_freq  =3D driver->policy[i].min;
+		driver->policy[i].cpuinfo.max_freq  =3D stock_freq;
+		driver->policy[i].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
+
 		driver->policy[i].cpu    =3D i;
 	}
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/a=
rch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-11-23 09=
:08:56.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-13 15:04:49.00=
0000000 +0100
@@ -242,7 +242,6 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq[0]  =3D busfreq * 20;
 	driver->cpu_cur_freq[0]  =3D busfreq * max_multiplier;
 #endif
=20
@@ -253,7 +252,9 @@
 	driver->policy[0].min    =3D busfreq * 20;
 	driver->policy[0].max    =3D busfreq * max_multiplier;
 	driver->policy[0].policy =3D CPUFREQ_POLICY_PERFORMANCE;
-	driver->policy[0].max_cpu_freq  =3D busfreq * max_multiplier;
+	driver->policy[0].cpuinfo.max_freq =3D busfreq * max_multiplier;
+	driver->policy[0].cpuinfo.min_freq =3D busfreq * 20;
+	driver->policy[0].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
=20
 	powernow_driver =3D driver;
=20
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arc=
h/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-11-23 09:0=
8:56.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-13 15:05:14.0000=
00000 +0100
@@ -693,7 +693,6 @@
 	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_min_freq[0] =3D speedstep_low_freq;
 	driver->cpu_cur_freq[0] =3D speed;
 #endif
=20
@@ -703,7 +702,10 @@
 	driver->policy[0].cpu    =3D 0;
 	driver->policy[0].min    =3D speedstep_low_freq;
 	driver->policy[0].max    =3D speedstep_high_freq;
-	driver->policy[0].max_cpu_freq =3D speedstep_high_freq;
+	driver->policy[0].cpuinfo.min_freq =3D speedstep_low_freq;
+	driver->policy[0].cpuinfo.max_freq =3D speedstep_high_freq;
+	driver->policy[0].cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
+
 	driver->policy[0].policy =3D (speed =3D=3D speedstep_low_freq) ?=20
 	    CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
=20
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/proces=
sor.c
--- linux-original/drivers/acpi/processor.c	2002-12-13 14:41:28.000000000 +=
0100
+++ linux/drivers/acpi/processor.c	2002-12-13 15:11:27.000000000 +0100
@@ -1849,10 +1849,15 @@
 #ifdef CONFIG_CPU_FREQ_24_API
 	for (i=3D0;i<NR_CPUS;i++) {
 		driver->cpu_cur_freq[0] =3D pr->performance.states[current_state].core_f=
requency * 1000;
-		driver->cpu_min_freq[0] =3D pr->performance.states[pr->performance.state=
_count - 1].core_frequency * 1000;
 	}
 #endif
=20
+	/* detect highest transition latency */
+	for (i=3D0;i<pr->performance.state_count;i++) {
+		if (pr->performance.states[i].transition_latency > driver->policy[0].cpu=
info.transition_latency)
+			driver->policy[0].cpuinfo.transition_latency =3D pr->performance.states=
[i].transition_latency;
+	}
+
 	driver->verify      =3D &acpi_cpufreq_verify;
 	driver->setpolicy   =3D &acpi_cpufreq_setpolicy;
=20
@@ -1860,7 +1865,9 @@
 		driver->policy[i].cpu    =3D pr->id;
 		driver->policy[i].min    =3D pr->performance.states[pr->performance.stat=
e_count - 1].core_frequency * 1000;
 		driver->policy[i].max    =3D pr->performance.states[pr->limit.state.px].=
core_frequency * 1000;
-		driver->policy[i].max_cpu_freq =3D pr->performance.states[0].core_freque=
ncy * 1000;
+		driver->policy[i].cpuinfo.max_freq =3D pr->performance.states[0].core_fr=
equency * 1000;
+		driver->policy[i].cpuinfo.min_freq =3D pr->performance.states[pr->perfor=
mance.state_count - 1].core_frequency * 1000;
+		driver->policy[i].cpuinfo.transition_latency =3D driver->policy[0].cpuin=
fo.transition_latency;
 		driver->policy[i].policy =3D ( pr->performance.states[current_state].cor=
e_frequency * 1000 =3D=3D driver->policy[i].max) ?=20
 			CPUFREQ_POLICY_PERFORMANCE : CPUFREQ_POLICY_POWERSAVE;
 	}
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufre=
q.h
--- linux-original/include/linux/cpufreq.h	2002-11-23 09:09:03.000000000 +0=
100
+++ linux/include/linux/cpufreq.h	2002-12-13 14:50:53.000000000 +0100
@@ -37,15 +37,26 @@
 #define CPUFREQ_POLICY_POWERSAVE        (1)
 #define CPUFREQ_POLICY_PERFORMANCE      (2)
=20
-/* values here are CPU kHz so that hardware which doesn't run with some
- * frequencies can complain without having to guess what per cent / per
- * mille means. */
+/* Frequency values here are CPU kHz so that hardware which doesn't run=20
+ * with some frequencies can complain without having to guess what per=20
+ * cent / per mille means.=20
+ * Maximum transition latency is in nanoseconds - if it's unknown,
+ * CPUFREQ_ETERNAL shall be used.
+ */
+
+#define CPUFREQ_ETERNAL (-1)
+struct cpufreq_cpuinfo {
+	unsigned int            max_freq;
+	unsigned int            min_freq;
+	unsigned int            transition_latency;
+};
+
 struct cpufreq_policy {
 	unsigned int            cpu;    /* cpu nr or CPUFREQ_ALL_CPUS */
 	unsigned int            min;    /* in kHz */
 	unsigned int            max;    /* in kHz */
         unsigned int            policy; /* see above */
-	unsigned int            max_cpu_freq; /* for information */
+	struct cpufreq_cpuinfo  cpuinfo;     /* see above */
 };
=20
 #define CPUFREQ_ADJUST          (0)
@@ -116,7 +127,6 @@
 #endif
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
-	unsigned int            cpu_min_freq[NR_CPUS];
 	unsigned int            cpu_cur_freq[NR_CPUS];
 #endif
 };
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2002-11-23 09:09:03.000000000 +0100
+++ linux/kernel/cpufreq.c	2002-12-13 15:07:23.000000000 +0100
@@ -119,8 +119,8 @@
 	if (sscanf(input_string, "%d%%%d%%%d%%%s", &cpu, &min, &max, policy_strin=
g) =3D=3D 4)
 	{
 		if (!cpufreq_get_policy(&current_policy, cpu)) {
-			policy->min =3D (min * current_policy.max_cpu_freq) / 100;
-			policy->max =3D (max * current_policy.max_cpu_freq) / 100;
+			policy->min =3D (min * current_policy.cpuinfo.max_freq) / 100;
+			policy->max =3D (max * current_policy.cpuinfo.max_freq) / 100;
 			policy->cpu =3D cpu;
 			result =3D 0;
 			goto scan_policy;
@@ -138,8 +138,8 @@
 	if (sscanf(input_string, "%d%%%d%%%s", &min, &max, policy_string) =3D=3D =
3)
 	{
 		if (!cpufreq_get_policy(&current_policy, cpu)) {
-			policy->min =3D (min * current_policy.max_cpu_freq) / 100;
-			policy->max =3D (max * current_policy.max_cpu_freq) / 100;
+			policy->min =3D (min * current_policy.cpuinfo.max_freq) / 100;
+			policy->max =3D (max * current_policy.cpuinfo.max_freq) / 100;
 			result =3D 0;
 			goto scan_policy;
 		}
@@ -229,11 +229,11 @@
=20
 		cpufreq_get_policy(&policy, i);
=20
-		if (!policy.max_cpu_freq)
+		if (!policy.cpuinfo.max_freq)
 			continue;
=20
-		min_pctg =3D (policy.min * 100) / policy.max_cpu_freq;
-		max_pctg =3D (policy.max * 100) / policy.max_cpu_freq;
+		min_pctg =3D (policy.min * 100) / policy.cpuinfo.max_freq;
+		max_pctg =3D (policy.max * 100) / policy.cpuinfo.max_freq;
=20
 		p +=3D sprintf(p, "CPU%3d    %9d kHz (%3d %%)  -  %9d kHz (%3d %%)  -  ",
 			     i , policy.min, min_pctg, policy.max, max_pctg);
@@ -279,6 +279,7 @@
 	int                     result =3D 0;
 	char			proc_string[42] =3D {'\0'};
 	struct cpufreq_policy   policy;
+	unsigned int            i =3D 0;
=20
=20
 	if ((count > sizeof(proc_string) - 1))
@@ -293,7 +294,17 @@
 	if (result)
 		return -EFAULT;
=20
-	cpufreq_set_policy(&policy);
+	if (policy.cpu =3D=3D CPUFREQ_ALL_CPUS)
+	{
+		for (i=3D0; i<NR_CPUS; i++)=20
+		{
+			policy.cpu =3D i;
+			if (cpu_online(i))
+				cpufreq_set_policy(&policy);
+		}
+	}=20
+	else
+		cpufreq_set_policy(&policy);
=20
 	return count;
 }
@@ -811,7 +822,9 @@
 	policy->min    =3D cpufreq_driver->policy[cpu].min;
 	policy->max    =3D cpufreq_driver->policy[cpu].max;
 	policy->policy =3D cpufreq_driver->policy[cpu].policy;
-	policy->max_cpu_freq =3D cpufreq_driver->policy[cpu].max_cpu_freq;
+	policy->cpuinfo.max_freq       =3D cpufreq_driver->policy[cpu].cpuinfo.ma=
x_freq;
+	policy->cpuinfo.min_freq       =3D cpufreq_driver->policy[cpu].cpuinfo.mi=
n_freq;
+	policy->cpuinfo.transition_latency =3D cpufreq_driver->policy[cpu].cpuinf=
o.transition_latency;
 	policy->cpu    =3D cpu;
=20
 	up(&cpufreq_driver_sem);
@@ -835,16 +848,14 @@
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver || !cpufreq_driver->verify ||=20
 	    !cpufreq_driver->setpolicy || !policy ||
-	    (policy->cpu > NR_CPUS)) {
+	    (policy->cpu >=3D NR_CPUS) || (!cpu_online(policy->cpu))) {
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
 	}
=20
-	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS)
-		policy->max_cpu_freq =3D cpufreq_driver->policy[0].max_cpu_freq;
-	else
-		policy->max_cpu_freq =3D cpufreq_driver->policy[policy->cpu].max_cpu_fre=
q;
-
+	policy->cpuinfo.max_freq       =3D cpufreq_driver->policy[policy->cpu].cp=
uinfo.max_freq;
+	policy->cpuinfo.min_freq       =3D cpufreq_driver->policy[policy->cpu].cp=
uinfo.min_freq;
+	policy->cpuinfo.transition_latency =3D cpufreq_driver->policy[policy->cpu=
].cpuinfo.transition_latency;
=20
 	/* verify the cpu speed can be set within this limit */
 	ret =3D cpufreq_driver->verify(policy);
@@ -1039,8 +1050,8 @@
  	down(&cpufreq_driver_sem);
 	for (i=3D0; i<NR_CPUS; i++)=20
 	{
-		cpu_min_freq[i] =3D driver_data->cpu_min_freq[i];
-		cpu_max_freq[i] =3D driver_data->policy[i].max_cpu_freq;
+		cpu_min_freq[i] =3D driver_data->policy[i].cpuinfo.min_freq;
+		cpu_max_freq[i] =3D driver_data->policy[i].cpuinfo.max_freq;
 		cpu_cur_freq[i] =3D driver_data->cpu_cur_freq[i];
 	}
 	up(&cpufreq_driver_sem);

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9+fexZ8MDCHJbN8YRApcGAJ0RyoBzoqYJ60fNSvdHiwbnmIXyWwCcDwKa
ApI0nZndYTDulCzsDt51N/M=
=+W56
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
