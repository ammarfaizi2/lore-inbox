Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265744AbSKAUbm>; Fri, 1 Nov 2002 15:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265768AbSKAUbl>; Fri, 1 Nov 2002 15:31:41 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:25012 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265744AbSKAU3b>; Fri, 1 Nov 2002 15:29:31 -0500
Date: Fri, 1 Nov 2002 21:35:03 +0100
From: Dominik Brodowski <linux@brodo.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       torvalds@transmeta.com
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [2.5. PATCH - 2nd UPDATE] cpufreq: update HyperThreading support in p4-clockmod.c driver
Message-ID: <20021101213503.A12861@brodo.de>
References: <10C8636AE359D4119118009027AE99871E606C41@fmsmsx34.fm.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <10C8636AE359D4119118009027AE99871E606C41@fmsmsx34.fm.intel.com>; from venkatesh.pallipadi@intel.com on Fri, Nov 01, 2002 at 10:41:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2002 at 10:41:57AM -0800, Pallipadi, Venkatesh wrote:
> Well.. I was working on a similar patch too. But, you beat me in sending =
out
> the patch onto lkml..
>=20
> One comment: P4 HT doesn't promise any order in the cpuid of HT siblings.=
 I
> mean, it is possible to have CPU0 and CPU 3 in one package and CPU 1 and =
CPU
> 4 in one package. The right way to know the cpu id of HT sibling is to lo=
ok
> at cpu_sibling_map[], in place of doing cpu*2 and cpu/2.

Thanks - this patch uses cpu_sibling_map[] instead. Please apply,
	Dominik

[2.5. PATCH] cpufreq: update HyperThreading support in p4-clockmod.c driver

This patch updates the p4-clockmod.c driver to correctly manage
HyperThreading-enabled Pentium IVs as well as those models which do
not support HyperThreading - thanks to Venkatesh Pallipadi for
explaining cpu_sibling_map to me. Additionally, an EXPORT_SYMBOL=20
was missing. (spotted by Marc-Christian Petersen - thanks!)

	 Dominik

diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c lin=
ux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Fri Nov  =
1 21:12:23 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Fri Nov  1 21:01:30 20=
02
@@ -50,32 +50,55 @@
 MODULE_PARM(stock_freq, "i");
=20
 static struct cpufreq_driver *cpufreq_p4_driver;
-static unsigned int cpufreq_p4_old_state =3D 0;
=20
=20
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 {
 	u32 l, h;
 	unsigned long cpus_allowed;
-	struct cpufreq_freqs    freqs;
+	struct cpufreq_freqs freqs;
+	int hyperthreading =3D 0;
+	int affected_cpu_map =3D 0;
+	int sibling =3D 0;
=20
 	if (!cpu_online(cpu) || (newstate > DC_DISABLE) ||=20
 		(newstate =3D=3D DC_RESV))
 		return -EINVAL;
-	cpu =3D cpu >> 1; /* physical CPU #nr */
+
+	/* switch to physical CPU where state is to be changed*/
+	cpus_allowed =3D current->cpus_allowed;
+
+	/* only run on CPU to be set, or on its sibling */
+	affected_cpu_map =3D 1 << cpu;
+#ifdef CONFIG_X86_HT
+	hyperthreading =3D ((cpu_has_ht) && (smp_num_siblings =3D=3D 2));
+	if (hyperthreading) {
+		sibling =3D cpu_sibling_map[cpu];
+		affected_cpu_map |=3D (1 << sibling);
+	}
+#endif
+	set_cpus_allowed(current, affected_cpu_map);
+	BUG_ON(!(smp_processor_id() & affected_cpu_map));
+
+	/* get current state */
+	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+	l =3D l >> 1;
+	l &=3D 0x7;
+
+	if (l =3D=3D newstate) {
+		set_cpus_allowed(current, cpus_allowed);
+		return 0;
+	}
=20
 	/* notifiers */
-	freqs.old =3D stock_freq * cpufreq_p4_old_state / 8;
+	freqs.old =3D stock_freq * l / 8;
 	freqs.new =3D stock_freq * newstate / 8;
-	freqs.cpu =3D 2*cpu;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	freqs.cpu++;
+	freqs.cpu =3D cpu;
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-
-	/* switch to physical CPU where state is to be changed*/
-	cpus_allowed =3D current->cpus_allowed;
-	set_cpus_allowed(current, 3 << (2 * cpu));
-	BUG_ON(cpu !=3D (smp_processor_id() >> 1));
+	if (hyperthreading) {
+		freqs.cpu =3D sibling;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
=20
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
 	if (l & 0x01)
@@ -86,10 +109,10 @@
=20
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
 	if (newstate =3D=3D DC_DISABLE) {
-		printk(KERN_INFO PFX "CPU#%d,%d disabling modulation\n", cpu, (cpu + 1));
+		printk(KERN_INFO PFX "CPU#%d disabling modulation\n", cpu);
 		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 	} else {
-		printk(KERN_INFO PFX "CPU#%d,%d setting duty cycle to %d%%\n", cpu, (cpu=
 + 1), ((125 * newstate) / 10));
+		printk(KERN_INFO PFX "CPU#%d setting duty cycle to %d%%\n", cpu, ((125 *=
 newstate) / 10));
 		/* bits 63 - 5	: reserved=20
 		 * bit  4	: enable/disable
 		 * bits 3-1	: duty cycle
@@ -104,9 +127,10 @@
=20
 	/* notifiers */
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	freqs.cpu--;
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	cpufreq_p4_old_state =3D newstate;
+	if (hyperthreading) {
+		freqs.cpu =3D cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
=20
 	return 0;
 }
@@ -143,9 +167,9 @@
 	/* if (number_states =3D=3D 1) */
 	{
 		if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS) {
-			for (i=3D0; i<(NR_CPUS/2); i++)
-				if (cpu_online(2*i))
-					cpufreq_p4_setdc((2*i), newstate);
+			for (i=3D0; i<NR_CPUS; i++)
+				if (cpu_online(i))
+					cpufreq_p4_setdc(i, newstate);
 		} else {
 			cpufreq_p4_setdc(policy->cpu, newstate);
 		}
@@ -235,7 +259,6 @@
 	for (i=3D0;i<NR_CPUS;i++)
 		driver->cpu_cur_freq[i] =3D stock_freq;
 #endif
-	cpufreq_p4_old_state  =3D DC_DISABLE;
=20
 	driver->verify        =3D &cpufreq_p4_verify;
 	driver->setpolicy     =3D &cpufreq_p4_setpolicy;
diff -ruN linux-2545original/arch/i386/kernel/i386_ksyms.c linux/arch/i386/=
kernel/i386_ksyms.c
--- linux-2545original/arch/i386/kernel/i386_ksyms.c	Fri Nov  1 21:12:23 20=
02
+++ linux/arch/i386/kernel/i386_ksyms.c	Fri Nov  1 21:08:44 2002
@@ -143,6 +143,11 @@
 EXPORT_SYMBOL(mmx_copy_page);
 #endif
=20
+#ifdef CONFIG_X86_HT
+EXPORT_SYMBOL(smp_num_siblings);
+EXPORT_SYMBOL(cpu_sibling_map);
+#endif
+
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(cpu_online_map);

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9wuV2Z8MDCHJbN8YRAoGBAJ4raaRZc68b+svCP44l1fYU0b5NIQCeMkyG
8NmQywTLpBw+/MkuJ6oDNW4=
=CikX
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
