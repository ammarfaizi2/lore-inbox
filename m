Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbSIQJiv>; Tue, 17 Sep 2002 05:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSIQJiv>; Tue, 17 Sep 2002 05:38:51 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:47091 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263963AbSIQJip>; Tue, 17 Sep 2002 05:38:45 -0400
Date: Tue, 17 Sep 2002 11:32:50 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.35] CPUfreq i386 core (2/5)
Message-ID: <20020917113250.E25385@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq i386 core for 2.5.35:
arch/i386/kernel/i386_ksyms.c	export cpu_khz
arch/i386/kernel/time.c		update various i386 values on frequency
				changes
include/asm-i386/msr.h		add Transmeta MSR defines


diff -ruN linux-2535original/arch/i386/kernel/i386_ksyms.c linux/arch/i386/=
kernel/i386_ksyms.c
--- linux-2535original/arch/i386/kernel/i386_ksyms.c	Tue Sep 17 09:22:43 20=
02
+++ linux/arch/i386/kernel/i386_ksyms.c	Tue Sep 17 09:30:59 2002
@@ -50,6 +50,7 @@
 EXPORT_SYMBOL(drive_info);
 #endif
=20
+extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);
=20
 /* platform dependent support */
@@ -76,6 +77,7 @@
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
+EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
=20
 #ifdef CONFIG_DEBUG_IOVIRT
diff -ruN linux-2535original/arch/i386/kernel/time.c linux/arch/i386/kernel=
/time.c
--- linux-2535original/arch/i386/kernel/time.c	Tue Sep 17 09:24:52 2002
+++ linux/arch/i386/kernel/time.c	Tue Sep 17 09:30:59 2002
@@ -43,6 +43,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cpufreq.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -651,6 +652,52 @@
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
+		if ((freq->old < freq->new) &&
+		((freq->cpu =3D=3D CPUFREQ_ALL_CPUS) || (freq->cpu =3D=3D 0)))  {
+			cpu_khz =3D cpufreq_scale(cpu_khz, freq->old, freq->new);
+		        fast_gettimeoffset_quotient =3D cpufreq_scale(fast_gettimeoffset=
_quotient, freq->new, freq->old);
+		}
+		for (i=3D0; i<NR_CPUS; i++)
+			if ((freq->cpu =3D=3D CPUFREQ_ALL_CPUS) || (freq->cpu =3D=3D i))
+				cpu_data[i].loops_per_jiffy =3D cpufreq_scale(loops_per_jiffy, freq->o=
ld, freq->new);
+		break;
+
+	case CPUFREQ_POSTCHANGE:
+		if ((freq->new < freq->old) &&
+		((freq->cpu =3D=3D CPUFREQ_ALL_CPUS) || (freq->cpu =3D=3D 0)))  {
+			cpu_khz =3D cpufreq_scale(cpu_khz, freq->old, freq->new);
+		        fast_gettimeoffset_quotient =3D cpufreq_scale(fast_gettimeoffset=
_quotient, freq->new, freq->old);
+		}
+		for (i=3D0; i<NR_CPUS; i++)
+			if ((freq->cpu =3D=3D CPUFREQ_ALL_CPUS) || (freq->cpu =3D=3D i))
+				cpu_data[i].loops_per_jiffy =3D cpufreq_scale(loops_per_jiffy, freq->o=
ld, freq->new);
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
@@ -710,6 +757,9 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz =
% 1000);
 			}
+#ifdef CONFIG_CPU_FREQ
+			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSIT=
ION_NOTIFIER);
+#endif
 		}
 	}
=20
diff -ruN linux-2535original/include/asm-i386/msr.h linux/include/asm-i386/=
msr.h
--- linux-2535original/include/asm-i386/msr.h	Tue Sep 17 09:23:54 2002
+++ linux/include/asm-i386/msr.h	Tue Sep 17 09:30:59 2002
@@ -125,4 +125,8 @@
 #define MSR_VIA_LONGHAUL		0x110a
 #define MSR_VIA_BCR2			0x1147
=20
+/* Transmeta defined MSRs */
+#define MSR_TMTA_LONGRUN_CTRL		0x80868010
+#define MSR_TMTA_LONGRUN_FLAGS		0x80868011
+
 #endif /* __ASM_MSR_H */


--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9hvbBZ8MDCHJbN8YRAvmZAJ0WdEg0r2AP8sDQduS65gRtIrzS5QCdEtnK
gOHmIkx5EnNCSExnrpKGbt4=
=3bYg
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
