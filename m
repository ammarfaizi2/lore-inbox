Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265653AbSKASPx>; Fri, 1 Nov 2002 13:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265655AbSKASPx>; Fri, 1 Nov 2002 13:15:53 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:20427 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265653AbSKASPr>; Fri, 1 Nov 2002 13:15:47 -0500
Date: Fri, 1 Nov 2002 19:20:53 +0100
From: Dominik Brodowski <linux@brodo.de>
To: James Bottomley <James.Bottomley@steeleye.com>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [2.5. PATCH - UPDATED] cpufreq: update HyperThreading support in p4-clockmod.c driver
Message-ID: <20021101192053.A4212@brodo.de>
References: <200211011603.gA1G3Z503174@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200211011603.gA1G3Z503174@localhost.localdomain>; from James.Bottomley@steeleye.com on Fri, Nov 01, 2002 at 11:03:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2002 at 11:03:35AM -0500, James Bottomley wrote:
> the #define for hyperthreading should be #ifdef CONFIG_X86_HT.
>=20
> Could you also make the symbol export conditional on this so that subarch=
's=20
> which don't have hyperthreading will still compile?

Sorry for that, updated patch below:

[2.5. PATCH] cpufreq: update HyperThreading support in p4-clockmod.c driver

This patch updates the p4-clockmod.c driver to correctly manage
HyperThreading-enabled Pentium IVs as well as those models which do
not support HyperThreading. Additionally, an EXPORT_SYMBOL was
missing. (spotted by Marc-Christian Petersen - thanks!)

	 Dominik

diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c lin=
ux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Oct 3=
1 12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Oct 31 20:00:00 20=
02
@@ -50,7 +50,6 @@
 MODULE_PARM(stock_freq, "i");
=20
 static struct cpufreq_driver *cpufreq_p4_driver;
-static unsigned int cpufreq_p4_old_state =3D 0;
=20
=20
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
@@ -58,24 +57,50 @@
 	u32 l, h;
 	unsigned long cpus_allowed;
 	struct cpufreq_freqs    freqs;
+	int hyperthreading;
+
=20
 	if (!cpu_online(cpu) || (newstate > DC_DISABLE) ||=20
 		(newstate =3D=3D DC_RESV))
 		return -EINVAL;
-	cpu =3D cpu >> 1; /* physical CPU #nr */
+
+	/* switch to physical CPU where state is to be changed*/
+	cpus_allowed =3D current->cpus_allowed;
+
+	/* hyperthreading? */
+#ifdef CONFIG_X86_HT
+	hyperthreading =3D ((cpu_has_ht) && (smp_num_siblings =3D=3D 2));
+#else
+	hyperthreading =3D 0;
+#endif
+	if (hyperthreading) {
+		unsigned int phys_cpu =3D cpu / 2;
+		set_cpus_allowed(current, 3 << (phys_cpu));
+		BUG_ON((cpu & ~1) !=3D (smp_processor_id() & ~1));
+		cpu =3D phys_cpu * 2;
+	} else {
+		set_cpus_allowed(current, 1 <<  cpu);
+		BUG_ON(cpu !=3D smp_processor_id());
+	}
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
+		freqs.cpu++;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
=20
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
 	if (l & 0x01)
@@ -86,10 +111,10 @@
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
@@ -104,9 +129,10 @@
=20
 	/* notifiers */
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	freqs.cpu--;
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	cpufreq_p4_old_state =3D newstate;
+	if (hyperthreading) {
+		freqs.cpu--;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
=20
 	return 0;
 }
@@ -143,9 +169,9 @@
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
@@ -235,7 +261,6 @@
 	for (i=3D0;i<NR_CPUS;i++)
 		driver->cpu_cur_freq[i] =3D stock_freq;
 #endif
-	cpufreq_p4_old_state  =3D DC_DISABLE;
=20
 	driver->verify        =3D &cpufreq_p4_verify;
 	driver->setpolicy     =3D &cpufreq_p4_setpolicy;
diff -ruN linux-2545original/arch/i386/kernel/i386_ksyms.c linux/arch/i386/=
kernel/i386_ksyms.c
--- linux-2545original/arch/i386/kernel/i386_ksyms.c.original	Thu Oct 31 12=
:00:00 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Thu Oct 31 20:00:00 2002
@@ -145,6 +145,9 @@
=20
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
+#ifdef CONFIG_X86_HT
+EXPORT_SYMBOL(smp_num_siblings);
+#endif
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_callout_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9wsYFZ8MDCHJbN8YRAnLpAJ98ljtz5tbF9EAQuBwoQQZWmiVREwCfTHbQ
n9c+7EdfKzo01NpT6jGBOrg=
=0SJf
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
