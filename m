Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWGFNzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWGFNzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWGFNzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:55:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:36807 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030272AbWGFNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:55:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:resent-from:resent-date:resent-message-id:resent-to:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rPh7uXyREkkEILx2QCIgX2LdibrKrN8lsrVmxyTwKbMVZfjYDwzZ2JUmasefT9kSyqSK18rhSR5DR52MJ/mauv4QUu7usgfYgR1q7Vstp4nUfFce+5DdgyP6fOM2s1R9WrDxK2r4UEoA/x1C+f/eBig0hR9NIKKVepvCNCfAz+s=
Date: Thu, 6 Jul 2006 09:54:24 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: PATCH: Create new LED trigger for CPU activity (ledtrig-cpu) (UPDATED)
Message-ID: <20060706135424.GA9039@phoenix>
References: <e4cb19870607051948t7e6d208m729a572a65f2da5e@mail.gmail.com> <20060705213901.4c903e4b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20060705213901.4c903e4b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 06 at 00:39 EDT, Andrew Morton hastily scribbled:
> On Wed, 5 Jul 2006 22:48:17 -0400
> "Thomas Tuttle" <thinkinginbinary@gmail.com> wrote:

Omigod, Andrew Morton replied to my email.  Cool.  Linux rocks.

> > Here is a new version of the patch, incorporating code style tips from
> > Randy Dunlap <rdunlap@xenotime.net>, and based on 2.6.17-git25, rather
> > than 2.6.17.1.
> >=20
> > I noticed that there's a Heartbeat LED trigger in the git version.  I
> > hope this isn't too similar.
> >=20
>
> <snip>
>=20
> waaaaaaaaaaay too many config options.  Make up your mind, man ;)

Okay, this new patch includes user and system, excludes iowait, and
makes nice configurable by a boolean module parameter called
include_nice, with the default being to exclude nice time.

> > +cputime64_t last_cputime;
> static.
Done.

> > +static void __exit ledtrig_cpu_exit(void)
> > +{
> > +	del_timer(&ledtrig_cpu_timer);
> del_timer_sync().
Done.

I also made the trigger track the last state of the LED, and avoid
sending a trigger event unless the state has actually changed.  And I
made it turn off the LED when the trigger is unloaded.

--Thomas Tuttle

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ledtrig-cpu.patch"
Content-Transfer-Encoding: quoted-printable

diff -udrN linux-2.6.17-git25/drivers/leds/Kconfig linux-2.6.17-git25-mine/=
drivers/leds/Kconfig
--- linux-2.6.17-git25/drivers/leds/Kconfig	2006-07-05 22:11:45.000000000 -=
0400
+++ linux-2.6.17-git25-mine/drivers/leds/Kconfig	2006-07-06 09:23:18.000000=
000 -0400
@@ -93,6 +93,13 @@
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
 config LEDS_TRIGGER_HEARTBEAT
 	tristate "LED Heartbeat Trigger"
 	depends LEDS_TRIGGERS
diff -udrN linux-2.6.17-git25/drivers/leds/ledtrig-cpu.c linux-2.6.17-git25=
-mine/drivers/leds/ledtrig-cpu.c
--- linux-2.6.17-git25/drivers/leds/ledtrig-cpu.c	1969-12-31 19:00:00.00000=
0000 -0500
+++ linux-2.6.17-git25-mine/drivers/leds/ledtrig-cpu.c	2006-07-06 09:48:43.=
000000000 -0400
@@ -0,0 +1,89 @@
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/leds.h>
+#include <linux/kernel_stat.h>
+#include <asm/cputime.h>
+
+MODULE_AUTHOR("Thomas Tuttle <thinkinginbinary@gmail.com>");
+MODULE_DESCRIPTION("LED CPU Activity Trigger");
+MODULE_PARM_DESC(include_nice, "Turn LED on for nice CPU time");
+MODULE_LICENSE("GPL");
+
+static int include_nice =3D 0;
+
+module_param(include_nice, bool, 0);
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
+		time =3D cputime64_add(time, kstat_cpu(i).cpustat.user);
+		if (include_nice)
+			time =3D cputime64_add(time, kstat_cpu(i).cpustat.nice);
+		time =3D cputime64_add(time, kstat_cpu(i).cpustat.system);
+	}
+
+	return time;
+}
+
+static enum led_brightness last_led_state;
+static cputime64_t last_cputime;
+
+static void ledtrig_cpu_timerfunc(unsigned long data)
+{
+	cputime64_t this_cputime =3D cpu_usage();
+	/* XXX: This assumes that cputime64_t can be subtracted.
+	 * Nobody has defined cputime64_sub, so I had to do this instead. */
+	cputime64_t used_cputime =3D this_cputime - last_cputime;
+	enum led_brightness led_state =3D (used_cputime > 0) ? LED_FULL : LED_OFF;
+	if (led_state !=3D last_led_state)
+		led_trigger_event(ledtrig_cpu, led_state);
+	last_led_state =3D led_state;
+	last_cputime =3D cpu_usage();
+
+	mod_timer(&ledtrig_cpu_timer, jiffies + msecs_to_jiffies(UPDATE_INTERVAL)=
);
+}
+
+static int __init ledtrig_cpu_init(void)
+{
+	led_trigger_register_simple("cpu", &ledtrig_cpu);
+	led_trigger_event(ledtrig_cpu, LED_OFF);
+	last_led_state =3D LED_OFF;
+	last_cputime =3D cpu_usage();
+	mod_timer(&ledtrig_cpu_timer, jiffies + msecs_to_jiffies(UPDATE_INTERVAL)=
);
+	return 0;
+}
+
+static void __exit ledtrig_cpu_exit(void)
+{
+	del_timer_sync(&ledtrig_cpu_timer);
+	led_trigger_event(ledtrig_cpu, LED_OFF);
+	led_trigger_unregister_simple(ledtrig_cpu);
+}
+
+module_init(ledtrig_cpu_init);
+module_exit(ledtrig_cpu_exit);
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

--bg08WKrSYDhXBjb5--

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErRYQ/UG6u69REsYRAiAuAJ9kcQmcOQuJZJmLqioitBXepUzbJgCfWfys
KP+BtPvfsTGpbCBmSZzq2Xg=
=4uxh
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
