Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSH1Lpw>; Wed, 28 Aug 2002 07:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSH1Lpw>; Wed, 28 Aug 2002 07:45:52 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:29061 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318782AbSH1Lpu>; Wed, 28 Aug 2002 07:45:50 -0400
Date: Wed, 28 Aug 2002 13:47:01 +0200
From: Dominik Brodowski <devel@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.32] CPUfreq i386 core (2/4)
Message-ID: <20020828134701.C19189@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq i386 core for 2.5.32:
arch/i386/kernel/i386_ksyms.c	export cpu_khz
arch/i386/kernel/time.c		update various i386 values on frequency
				changes
include/asm-i386/msr.h		add various MSR defines


diff -ruN linux-2531orig/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kern=
el/i386_ksyms.c
--- linux-2531orig/arch/i386/kernel/i386_ksyms.c	Wed Aug 28 10:06:00 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Wed Aug 28 10:29:59 2002
@@ -50,6 +50,7 @@
 EXPORT_SYMBOL(drive_info);
 #endif
=20
+extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);
=20
 /* platform dependent support */
@@ -73,6 +74,7 @@
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
+EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
=20
 #ifdef CONFIG_DEBUG_IOVIRT
diff -ruN linux-2531orig/arch/i386/kernel/time.c linux/arch/i386/kernel/tim=
e.c
--- linux-2531orig/arch/i386/kernel/time.c	Wed Aug 28 10:06:00 2002
+++ linux/arch/i386/kernel/time.c	Wed Aug 28 10:29:59 2002
@@ -43,6 +43,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cpufreq.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -650,6 +651,50 @@
=20
 __initcall(time_init_driverfs);
=20
+
+#ifdef CONFIG_CPU_FREQ
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+		       void *data)
+{
+	struct cpufreq_freqs *freq =3D data;
+	unsigned int i;
+
+	if (!cpu_has_tsc)
+		return 0;
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		if (freq->cur < freq->new) {
+			cpu_khz =3D cpufreq_scale(cpu_khz, freq->cur, freq->new);
+		        fast_gettimeoffset_quotient =3D cpufreq_scale(cpu_khz, freq->new=
, freq->cur);
+		}
+		for (i=3D0; i<NR_CPUS; i++)
+			if ((freq->cpu =3D=3D CPUFREQ_ALL_CPUS) || (freq->cpu =3D=3D i))
+				cpu_data[i].loops_per_jiffy =3D cpufreq_scale(loops_per_jiffy, freq->c=
ur, freq->new);
+		break;
+
+	case CPUFREQ_POSTCHANGE:
+		if (freq->new < freq->cur) {
+			cpu_khz =3D cpufreq_scale(cpu_khz, freq->cur, freq->new);
+		        fast_gettimeoffset_quotient =3D cpufreq_scale(cpu_khz, freq->new=
, freq->cur);
+		}
+		for (i=3D0; i<NR_CPUS; i++)
+			if ((freq->cpu =3D=3D CPUFREQ_ALL_CPUS) || (freq->cpu =3D=3D i))
+				cpu_data[i].loops_per_jiffy =3D cpufreq_scale(loops_per_jiffy, freq->c=
ur, freq->new);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block =3D {
+	notifier_call:	time_cpufreq_notifier
+};
+#endif
+
+
 void __init time_init(void)
 {
 	extern int x86_udelay_tsc;
@@ -709,6 +754,10 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz =
% 1000);
 			}
+#ifdef CONFIG_CPU_FREQ
+			cpufreq_register_notifier(&time_cpufreq_notifier_block);
+#endif
+
 		}
 	}
=20
diff -ruN linux-2531orig/include/asm-i386/msr.h linux/include/asm-i386/msr.h
--- linux-2531orig/include/asm-i386/msr.h	Wed Aug 28 10:01:02 2002
+++ linux/include/asm-i386/msr.h	Wed Aug 28 10:33:54 2002
@@ -94,12 +94,15 @@
 #define MSR_K6_STAR			0xC0000081
 #define MSR_K6_WHCR			0xC0000082
 #define MSR_K6_UWCCR			0xC0000085
+#define MSR_K6_EPMR			0xC0000086
 #define MSR_K6_PSOR			0xC0000087
 #define MSR_K6_PFIR			0xC0000088
=20
 #define MSR_K7_EVNTSEL0			0xC0010000
 #define MSR_K7_PERFCTR0			0xC0010004
 #define MSR_K7_HWCR			0xC0010015
+#define MSR_K7_FID_VID_CTL		0xC0010041
+#define MSR_K7_VID_STATUS		0xC0010042
=20
 /* Centaur-Hauls/IDT defined MSRs. */
 #define MSR_IDT_FCR1			0x107
@@ -119,5 +122,7 @@
=20
 /* VIA Cyrix defined MSRs*/
 #define MSR_VIA_FCR			0x1107
+#define MSR_VIA_LONGHAUL		0x110a
+#define MSR_VIA_BCR2			0x1147
=20
 #endif /* __ASM_MSR_H */

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9bLg1Z8MDCHJbN8YRApzvAKCJfIurQTlb12VMybfEJUcDPhOgDwCghzvC
/HaD1kWcuOMhM3QfRNjkA+4=
=6Fb0
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
