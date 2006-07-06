Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWGFC4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWGFC4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWGFC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:56:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:42475 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965143AbWGFC4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:56:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=YaIFMxZa56mDn0H21I5jUpiYru+Fu6ut2xPkcDB32kT69GH+4b9E3d97CVVzg5kLH0cV9bIsJ4KydPAulWuLTr0PB6y9/X/UPs13aUXiThxwGlaaKikOpLNH2Gk3O4GuCWnqI1hHfj5WXzVPMB8k1S3aqy3/m1+GW0HCRyEVAZc=
Date: Wed, 5 Jul 2006 22:56:35 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: Create new LED trigger for CPU activity (ledtrig-cpu)
Message-ID: <20060706025635.GA25835@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to apologize profusely for the incompetence of my previous
mailer.  Rest assured, the programmers responsible will be sacked, if I
ever meet them.

Here's a version that's plain text, and against 2.6.17-git25.  It *should*
simply be a plain text MIME attachment.

I'd appreciate any comments, now that you can read my patch. :-\

Thanks,

Thomas Tuttle

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ledtrig-cpu.patch"
Content-Transfer-Encoding: quoted-printable

diff -udrN linux-2.6.17-git25/drivers/leds/Kconfig linux-2.6.17-git25-mine/=
drivers/leds/Kconfig
--- linux-2.6.17-git25/drivers/leds/Kconfig	2006-07-05 22:11:45.000000000 -=
0400
+++ linux-2.6.17-git25-mine/drivers/leds/Kconfig	2006-07-05 22:42:58.000000=
000 -0400
@@ -93,6 +93,41 @@
 	  This allows LEDs to be controlled by IDE disk activity.
 	  If unsure, say Y.
=20
+config LEDS_TRIGGER_CPU
+	tristate "LED CPU Trigger"
+	depends LEDS_TRIGGERS
+	help
+	  This allows LEDs to be controlled by CPU activity.
+	  If unsure, say Y.
+
+config LEDS_TRIGGER_CPU_INCLUDE_USER
+	bool "Include user time in CPU trigger"
+	depends LEDS_TRIGGER_CPU
+	default y
+	help
+	  This option makes user CPU time cause the CPU trigger to activate.
+
+config LEDS_TRIGGER_CPU_INCLUDE_NICE
+	bool "Include nice time in CPU trigger"
+	depends LEDS_TRIGGER_CPU
+	default n
+	help
+	  This option makes nice CPU time cause the CPU trigger to activate.
+
+config LEDS_TRIGGER_CPU_INCLUDE_SYSTEM
+	bool "Include system time in CPU trigger"
+	depends LEDS_TRIGGER_CPU
+	default y
+	help
+	  This option makes system CPU time cause the CPU trigger to activate.
+
+config LEDS_TRIGGER_CPU_INCLUDE_IOWAIT
+	bool "Include iowait time in CPU trigger"
+	depends LEDS_TRIGGER_CPU
+	default n
+	help
+	  This option makes iowait CPU time cause the CPU trigger to activate.
+
 config LEDS_TRIGGER_HEARTBEAT
 	tristate "LED Heartbeat Trigger"
 	depends LEDS_TRIGGERS
diff -udrN linux-2.6.17-git25/drivers/leds/ledtrig-cpu.c linux-2.6.17-git25=
-mine/drivers/leds/ledtrig-cpu.c
--- linux-2.6.17-git25/drivers/leds/ledtrig-cpu.c	1969-12-31 19:00:00.00000=
0000 -0500
+++ linux-2.6.17-git25-mine/drivers/leds/ledtrig-cpu.c	2006-07-05 22:42:38.=
000000000 -0400
@@ -0,0 +1,87 @@
+/*
+ * LED CPU Activity Trigger
+ *
+ * Copyright 2006 Thomas Tuttle
+ *
+ * Author: Thomas Tuttle <thinkinginbinary@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/leds.h>
+#include <linux/kernel_stat.h>
+#include <asm/cputime.h>
+
+#define UPDATE_INTERVAL (5) /* delay between updates, in ms */
+
+static void ledtrig_cpu_timerfunc(unsigned long data);
+
+DEFINE_LED_TRIGGER(ledtrig_cpu);
+static DEFINE_TIMER(ledtrig_cpu_timer, ledtrig_cpu_timerfunc, 0, 0);
+
+static cputime64_t cpu_usage(void)
+{
+	int i;
+	cputime64_t time =3D cputime64_zero;
+
+	for_each_possible_cpu(i) {
+#ifdef CONFIG_LEDS_TRIGGER_CPU_INCLUDE_USER
+		time =3D cputime64_add(time, kstat_cpu(i).cpustat.user);
+#endif
+#ifdef CONFIG_LEDS_TRIGGER_CPU_INCLUDE_NICE
+		time =3D cputime64_add(time, kstat_cpu(i).cpustat.nice);
+#endif
+#ifdef CONFIG_LEDS_TRIGGER_CPU_INCLUDE_SYSTEM
+		time =3D cputime64_add(time, kstat_cpu(i).cpustat.system);
+#endif
+#ifdef CONFIG_LEDS_TRIGGER_CPU_INCLUDE_IOWAIT
+		time =3D cputime64_add(time, kstat_cpu(i).cpustat.iowait);
+#endif
+	}
+
+	return time;
+}
+
+cputime64_t last_cputime;
+
+static void ledtrig_cpu_timerfunc(unsigned long data)
+{
+	cputime64_t this_cputime =3D cpu_usage();
+	/* XXX: This assumes that cputime64_t can be subtracted.
+	 * Nobody has defined cputime64_sub, so I had to do this instead. */
+	cputime64_t used_cputime =3D this_cputime - last_cputime;
+	enum led_brightness led_state =3D (used_cputime > 0) ? LED_FULL : LED_OFF;
+	led_trigger_event(ledtrig_cpu, led_state);
+	last_cputime =3D cpu_usage();
+
+	mod_timer(&ledtrig_cpu_timer, jiffies + msecs_to_jiffies(UPDATE_INTERVAL)=
);
+}
+
+static int __init ledtrig_cpu_init(void)
+{
+	led_trigger_register_simple("cpu", &ledtrig_cpu);
+	last_cputime =3D cpu_usage();
+	mod_timer(&ledtrig_cpu_timer, jiffies + msecs_to_jiffies(UPDATE_INTERVAL)=
);
+	return 0;
+}
+
+static void __exit ledtrig_cpu_exit(void)
+{
+	del_timer(&ledtrig_cpu_timer);
+	led_trigger_unregister_simple(ledtrig_cpu);
+}
+
+module_init(ledtrig_cpu_init);
+module_exit(ledtrig_cpu_exit);
+
+MODULE_AUTHOR("Thomas Tuttle <thinkinginbinary@gmail.com>");
+MODULE_DESCRIPTION("LED CPU Activity Trigger");
+MODULE_LICENSE("GPL");
diff -udrN linux-2.6.17-git25/drivers/leds/Makefile linux-2.6.17-git25-mine=
/drivers/leds/Makefile
--- linux-2.6.17-git25/drivers/leds/Makefile	2006-07-05 22:11:45.000000000 =
-0400
+++ linux-2.6.17-git25-mine/drivers/leds/Makefile	2006-07-05 22:40:52.00000=
0000 -0400
@@ -16,4 +16,5 @@
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+=3D ledtrig-timer.o
 obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+=3D ledtrig-ide-disk.o
+obj-$(CONFIG_LEDS_TRIGGER_CPU)		+=3D ledtrig-cpu.o
 obj-$(CONFIG_LEDS_TRIGGER_HEARTBEAT)	+=3D ledtrig-heartbeat.o

--0F1p//8PRICkK4MW--

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErHvj/UG6u69REsYRAtQjAJ41BVbXg6ggUJNFMD//p52GLuhKRQCcC8/k
ofw65I5P6Z6wAzDJpzsM754=
=1a2R
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
