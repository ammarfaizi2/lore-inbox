Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbTCVAX3>; Fri, 21 Mar 2003 19:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbTCVAX3>; Fri, 21 Mar 2003 19:23:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14544 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261610AbTCVAXR>;
	Fri, 21 Mar 2003 19:23:17 -0500
Subject: [RFC] [PATCH] linux-2.5.56_clock-override_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Jerry Cooperstein <coop@axian.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kfaAD/wg8z4+pwtSJzxz"
Organization: 
Message-Id: <1048292898.28178.9.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Mar 2003 16:28:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kfaAD/wg8z4+pwtSJzxz
Content-Type: multipart/mixed; boundary="=-VkqLMWT7gv3g+S2nKC56"


--=-VkqLMWT7gv3g+S2nKC56
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

All,=20
	This patch allows one to manually specify the i386 gettimeofday
time-source by passing clock=3D[pit|tsc|cyclone|...] as a boot argument.
The argument will override the default probled selection, and in case
the selected time-source not be avalible the code defaults to using the
PIT (printing a warning saying so).

The new changes in this release are basically better whitespace and
__init usage (thanks Andrew).=20

I'm still tracking an issue between this and the cpu_freq code, so let
me know if it doesn't work or if you see anything terminally stupid.=20

thanks
-john





--=-VkqLMWT7gv3g+S2nKC56
Content-Disposition: attachment; filename=linux-2.5.65_clock-override_A1.patch
Content-Type: text/x-patch; name=linux-2.5.65_clock-override_A1.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-para=
meters.txt
--- a/Documentation/kernel-parameters.txt	Fri Mar 21 16:18:00 2003
+++ b/Documentation/kernel-parameters.txt	Fri Mar 21 16:18:00 2003
@@ -207,6 +207,12 @@
=20
 	chandev=3D	[HW,NET] Generic channel device initialisation
 =20
+ 	clock=3D		[BUGS=3DIA-32, HW] gettimeofday timesource override.=20
+			Forces specified timesource (if avaliable) to be used
+			when calculating gettimeofday(). If specicified timesource
+			is not avalible, it defaults to PIT.=20
+			Format: { pit | tsc | cyclone | ... }
+		=09
 	cm206=3D		[HW,CD]
 			Format: { auto | [<io>,][<irq>] }
=20
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Fri Mar 21 16:18:00 2003
+++ b/arch/i386/kernel/smpboot.c	Fri Mar 21 16:18:00 2003
@@ -422,7 +422,7 @@
 	/*
 	 *      Synchronize the TSC with the BP
 	 */
-	if (cpu_has_tsc)
+	if (cpu_has_tsc && cpu_khz)
 		synchronize_tsc_ap();
 }
=20
@@ -1114,7 +1114,7 @@
 	/*
 	 * Synchronize the TSC with the AP
 	 */
-	if (cpu_has_tsc && cpucount)
+	if (cpu_has_tsc && cpucount && cpu_khz)
 		synchronize_tsc_bp();
 }
=20
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer=
.c
--- a/arch/i386/kernel/timers/timer.c	Fri Mar 21 16:18:00 2003
+++ b/arch/i386/kernel/timers/timer.c	Fri Mar 21 16:18:00 2003
@@ -1,4 +1,6 @@
+#include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <asm/timer.h>
=20
 /* list of externed timers */
@@ -17,6 +19,17 @@
 	NULL,
 };
=20
+static char clock_override[10] __initdata;
+
+static int __init clock_setup(char* str)
+{
+	if (str) {
+		strncpy(clock_override, str,10);
+		clock_override[9] =3D '\0';
+	}
+	return 1;
+}
+__setup("clock=3D", clock_setup);
=20
 /* iterates through the list of timers, returning the first=20
  * one that initializes successfully.
@@ -28,7 +41,7 @@
 	/* find most preferred working timer */
 	while (timers[i]) {
 		if (timers[i]->init)
-			if (timers[i]->init() =3D=3D 0)
+			if (timers[i]->init(clock_override) =3D=3D 0)
 				return timers[i];
 		++i;
 	}
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/time=
rs/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Fri Mar 21 16:18:00 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Fri Mar 21 16:18:00 2003
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/errno.h>
+#include <linux/string.h>
=20
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -73,7 +74,7 @@
 	return delay_at_last_interrupt + offset;
 }
=20
-static int init_cyclone(void)
+static int __init init_cyclone(char* override)
 {
 	u32* reg;=09
 	u32 base;		/* saved cyclone base address */
@@ -81,8 +82,11 @@
 	u32 offset;		/* offset from pageaddr to cyclone_timer register */
 	int i;
 =09
+	/* check clock override */
+	if (override[0] && strncmp(override,"cyclone",7))
+			return -ENODEV;
+
 	/*make sure we're on a summit box*/
-	/*XXX need to use proper summit hooks! such as xapic -john*/
 	if(!use_cyclone) return -ENODEV;=20
 =09
 	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/=
timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	Fri Mar 21 16:18:00 2003
+++ b/arch/i386/kernel/timers/timer_none.c	Fri Mar 21 16:18:00 2003
@@ -1,6 +1,7 @@
+#include <linux/init.h>
 #include <asm/timer.h>
=20
-static int init_none(void)
+static int __init init_none(char* override)
 {
 	return 0;
 }
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/t=
imer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Fri Mar 21 16:18:00 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Fri Mar 21 16:18:00 2003
@@ -17,8 +17,12 @@
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
=20
-static int init_pit(void)
+static int __init init_pit(char* override)
 {
+	/* check clock override */
+	if (override[0] && strncmp(override,"pit",3))
+		printk(KERN_ERR "Warning: clock=3D override failed. Defaulting to PIT\n"=
);
+
 	return 0;
 }
=20
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/t=
imer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Fri Mar 21 16:18:00 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Fri Mar 21 16:18:00 2003
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/cpufreq.h>
+#include <linux/string.h>
=20
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -244,8 +245,13 @@
 #endif
=20
=20
-static int init_tsc(void)
+static int __init init_tsc(char* override)
 {
+
+	/* check clock override */
+	if (override[0] && strncmp(override,"tsc",3))
+			return -ENODEV;
+
 	/*
 	 * If we have APM enabled or the CPU clock speed is variable
 	 * (CPU stops clock on HLT or slows clock to save power)
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Fri Mar 21 16:18:00 2003
+++ b/include/asm-i386/timer.h	Fri Mar 21 16:18:00 2003
@@ -4,14 +4,14 @@
 /**
  * struct timer_ops - used to define a timer source
  *
- * @init: Probes and initializes the timer.  Returns 0 on success, anythin=
g
- *	else on failure.
+ * @init: Probes and initializes the timer. Takes clock=3D override=20
+ *  string as an argument. Returns 0 on success, anything else on failure.
  * @mark_offset: called by the timer interrupt
  * @get_offset: called by gettimeofday().  Returns the number of ms since =
the
  *	last timer intruupt.
  */
 struct timer_opts{
-	int (*init)(void);
+	int (*init)(char *override);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	void (*delay)(unsigned long);

--=-VkqLMWT7gv3g+S2nKC56--

--=-kfaAD/wg8z4+pwtSJzxz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+e64iMDAZ/OmgHwwRAhbMAJ91opA9QDcdhMhv6KTfUF6+R0owhACfW7G2
1dtibrkvX7UbHgNvDdZQ0Lc=
=lCZZ
-----END PGP SIGNATURE-----

--=-kfaAD/wg8z4+pwtSJzxz--

