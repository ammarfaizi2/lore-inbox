Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSKDSrk>; Mon, 4 Nov 2002 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSKDSrk>; Mon, 4 Nov 2002 13:47:40 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:953 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262646AbSKDSrc>; Mon, 4 Nov 2002 13:47:32 -0500
Date: Mon, 4 Nov 2002 19:53:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.5. PATCH] cpufreq: /proc/sys/cpu and /proc/cpufreq can be used simultaneously
Message-ID: <20021104195341.A1936@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both the /proc/sys/cpu/ and /proc/cpufreq interface can safely be
enabled in the same kernel. This simplifies the transition to the newer
interface. Only minor updates are needed in order to allow this to be=20
done.
	Dominik

diff -ruN linux-2545original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2545original/arch/i386/Kconfig	Thu Oct 31 12:00:00 2002
+++ linux/arch/i386/Kconfig	Thu Oct 31 21:30:00 2002
@@ -471,26 +471,19 @@
 	  If in doubt, say N.
=20
 config CPU_FREQ_24_API
-	bool "/proc/sys/cpu/ interface (2.4.)"
+	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
 	depends on CPU_FREQ
-	---help---
+	help
 	  This enables the /proc/sys/cpu/ sysctl interface for controlling
-	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. Note
-	  that some drivers do not support this interface or offer less
-	  functionality.=20
-
-	  If you say N here, you'll be able to control CPUFreq using the
-	  new /proc/cpufreq interface.
+	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
+	  uses /proc/cpufreq instead. Please note that some drivers do not=20
+	  work well with the 2.4. /proc/sys/cpu sysctl interface, so if in
+	  doubt, say N here.
=20
 	  For details, take a look at linux/Documentation/cpufreq.=20
=20
 	  If in doubt, say N.
=20
-config CPU_FREQ_26_API
-	bool
-	depends on CPU_FREQ && !CPU_FREQ_24_API
-	default y
-
 config X86_POWERNOW_K6
 	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
 	depends on CPU_FREQ
@@ -554,7 +547,7 @@
=20
 config X86_LONGRUN
 	tristate "Transmeta LongRun"
-	depends on CPU_FREQ && !CPU_FREQ_24_API
+	depends on CPU_FREQ
 	help
 	  This adds the CPUFreq driver for Transmeta Crusoe processors which
 	  support LongRun.
diff -ruN linux-2545original/include/linux/cpufreq.h linux/include/linux/cp=
ufreq.h
--- linux-2545original/include/linux/cpufreq.h	Thu Oct 31 12:00:00 2002
+++ linux/include/linux/cpufreq.h	Thu Oct 31 21:30:00 2002
@@ -5,7 +5,7 @@
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *           =20
  *
- * $Id: cpufreq.h,v 1.26 2002/09/21 09:05:29 db Exp $
+ * $Id: cpufreq.h,v 1.27 2002/10/08 14:54:23 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -148,11 +148,9 @@
 int cpufreq_set_policy(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
=20
-#ifdef CONFIG_CPU_FREQ_26_API
 #ifdef CONFIG_PM
 int cpufreq_restore(void);
 #endif
-#endif
=20
=20
 #ifdef CONFIG_CPU_FREQ_24_API
@@ -160,9 +158,6 @@
  *                        CPUFREQ 2.4. INTERFACE                     *
  *********************************************************************/
 int cpufreq_setmax(unsigned int cpu);
-#ifdef CONFIG_PM
-int cpufreq_restore(void);
-#endif
 int cpufreq_set(unsigned int kHz, unsigned int cpu);
 unsigned int cpufreq_get(unsigned int cpu);
=20
diff -ruN linux-2545original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-2545original/kernel/cpufreq.c	Thu Oct 31 12:00:00 2002
+++ linux/kernel/cpufreq.c	Thu Oct 31 21:30:00 2002
@@ -4,7 +4,7 @@
  *  Copyright (C) 2001 Russell King
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *
- *  $Id: cpufreq.c,v 1.43 2002/09/21 09:05:29 db Exp $
+ *  $Id: cpufreq.c,v 1.45 2002/10/08 14:54:23 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,13 +21,10 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/ctype.h>
+#include <linux/proc_fs.h>
=20
 #include <asm/uaccess.h>
=20
-#ifdef CONFIG_CPU_FREQ_26_API
-#include <linux/proc_fs.h>
-#endif
-
 #ifdef CONFIG_CPU_FREQ_24_API
 #include <linux/sysctl.h>
 #endif
@@ -200,7 +197,6 @@
 __setup("cpufreq=3D", cpufreq_setup);
=20
=20
-#ifdef CONFIG_CPU_FREQ_26_API
 #ifdef CONFIG_PROC_FS
=20
 /**
@@ -335,7 +331,6 @@
 	return;
 }
 #endif /* CONFIG_PROC_FS */
-#endif /* CONFIG_CPU_FREQ_26_API */
=20
=20
=20
@@ -344,10 +339,6 @@
  *********************************************************************/
=20
 #ifdef CONFIG_CPU_FREQ_24_API
-/* NOTE #1: when you use this API, you may not use any other calls,
- * except cpufreq_[un]register_notifier, of course.
- */
-
 /**=20
  * cpufreq_set - set the CPU frequency
  * @freq: target frequency in kHz
@@ -879,7 +870,7 @@
 		cpufreq_driver->policy[policy->cpu].max    =3D policy->max;
 		cpufreq_driver->policy[policy->cpu].policy =3D policy->policy;
 	}
-=09
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS) {
 		for (i=3D0;i<NR_CPUS;i++)
@@ -945,6 +936,14 @@
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANG=
E, freqs);
+#ifdef CONFIG_CPU_FREQ_24_API
+		if (freqs->cpu =3D=3D CPUFREQ_ALL_CPUS) {
+			int i;
+			for (i=3D0;i<NR_CPUS;i++)
+				cpu_cur_freq[i] =3D freqs->new;
+		} else
+			cpu_cur_freq[freqs->cpu] =3D freqs->new;
+#endif
 		break;
 	}
 	up(&cpufreq_notifier_sem);
@@ -992,9 +991,7 @@
=20
 	ret =3D cpufreq_set_policy(&default_policy);
=20
-#ifdef CONFIG_CPU_FREQ_26_API
 	cpufreq_proc_init();
-#endif
=20
 #ifdef CONFIG_CPU_FREQ_24_API
 	down(&cpufreq_driver_sem);
@@ -1042,9 +1039,7 @@
=20
 	up(&cpufreq_driver_sem);
=20
-#ifdef CONFIG_CPU_FREQ_26_API
 	cpufreq_proc_exit();
-#endif
=20
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpufreq_sysctl_exit();
@@ -1086,13 +1081,7 @@
 		policy.cpu    =3D i;
 		up(&cpufreq_driver_sem);
=20
-#ifdef CONFIG_CPU_FREQ_26_API
 		cpufreq_set_policy(&policy);
-#endif
-
-#ifdef CONFIG_CPU_FREQ_24_API
-		cpufreq_set(cpu_cur_freq[i], i);
-#endif
 	}
=20
 	return 0;
diff -ruN linux-2545original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/a=
rch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-2545original/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Oct 31 12=
:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Oct 31 21:30:00 2002
@@ -251,6 +251,11 @@
=20
 	longrun_get_policy(&driver->policy[0]);
=20
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq    =3D longrun_low_freq;
+	driver->cpu_cur_freq[0] =3D longrun_high_freq; /* dummy value */
+#endif
+
 	driver->verify         =3D &longrun_verify_policy;
 	driver->setpolicy      =3D &longrun_set_policy;
 	result =3D cpufreq_register(driver);

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9xsI0Z8MDCHJbN8YRAnVRAKCkapuHMJKGE+k/dhh75QnV04C03ACgoSqC
EAxcRtvHNLQ6dfy/fCpLOpc=
=ZnxG
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
