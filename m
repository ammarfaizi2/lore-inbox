Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWGGB6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWGGB6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWGGB6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:58:40 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:51366 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750812AbWGGB6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:58:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KcTOY5ymf4p6cQC0tepCGY0UYkVVaUzesZrIM2NkfYziKrjfUQOHoIJ0DeaObqGnUrgirAwu1+1CFGa9m7918C/l4cc71CwGIgvUNgEp8p2ZFMALlJu8C5Z6TOWw1LliZmwKCKR2FxrnHeW4WplTnQ/c+f90G0iXezih/GdTXSo=
Date: Thu, 6 Jul 2006 21:58:37 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] Create new LED trigger for CPU activity
Message-ID: <20060707015837.GD8900@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Richard Purdie <rpurdie@rpsys.net>
References: <20060706191603.GA13898@phoenix> <20060706235204.GB4821@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <20060706235204.GB4821@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: multipart/mixed; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Reply comes after ChangeLog and Signed-off-by.)

This patch creates a new LED trigger that triggers whenever the CPU is
active.  It can be configured with module parameters to trigger on any
combination of user, nice, system, or iowait time, and defaults to
including user and system time but not nice or iowait time.  I've tested
it a bit, and it seems to work, but no guarantees.  It's diffed against
2.6.17-git25.

Signed-off-by: Thomas Tuttle <thinkinginbinary@gmail.com>

On July 06 at 19:52 EDT, Pavel Machek hastily scribbled:
> Please don't include changelogs in sources.
Okay.  I've attached an updated patch.

> > +#define UPDATE_INTERVAL (5) /* delay between updates, in ms */
> Polling every 5 msec is going to cost _lot_ of juice. Is there a
> better way?
This is a sticky issue.  My first idea was to wire something into
schedule() so that when the idle process was selected, it would switch
the LED off, and when another process was selected, it would switch it
on, but that would have been really hairy.  In addition, it wouldn't
allow the trigger to differentiate between user, system, nice, and
iowait time, which it can now.

I don't think it's that much of a performance hit (the calculations are
fairly short, and a trigger event isn't sent unless the LED state
changed), but if you disagree, I can do a couple of things:

  * Lower the frequency to every 10ms (100Hz) or 40ms (25Hz).  This will
	  reduce the performance hit, but also reduce the accuracy of the LED.
		Right now, it flickers nicely when the CPU is somewhat busy, but if
		I lower the frequency, it will more often stay on rather than
		flickering.  I guess it's a matter of taste.

	* Make the frequency configurable by a module parameter.  This way,
	  users who don't mind the performance hit can increase the speed, and
		those who do mind can lower it.
=09
	* Try to hook it in to the scheduler, so it actually knows the moment
	  the CPU idles or starts doing something.  This will make it
		impossible to differentiate user/system time, and hard to
		differentiate user/nice time.

I personally think it's okay as it is, but I'm willing to make changes
if you prefer.

--Thomas Tuttle

--BQPnanjtCNWHyqYD
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
+++ linux-2.6.17-git25-mine/drivers/leds/ledtrig-cpu.c	2006-07-06 21:50:18.=
000000000 -0400
@@ -0,0 +1,131 @@
+/*
+ * LED CPU Activity Trigger, revision 3.5
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
+#define UPDATE_INTERVAL (5) /* delay between updates, in ms */
+
+/* This *would* be an enum, but I use them as the private data in the
+ * include_* module parameters, so they know which kind of time to=20
+ * include or exclude. */
+
+#define NUM_TIME_TYPES 4
+
+static int USER   =3D 0;
+static int NICE   =3D 1;
+static int SYSTEM =3D 2;
+static int IOWAIT =3D 3;
+
+static int include_time[NUM_TIME_TYPES] =3D { 1, 0, 1, 0 };
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
+		if (include_time[USER])
+			time =3D cputime64_add(time, kstat_cpu(i).cpustat.user);
+		if (include_time[NICE])
+			time =3D cputime64_add(time, kstat_cpu(i).cpustat.nice);
+		if (include_time[SYSTEM])
+			time =3D cputime64_add(time, kstat_cpu(i).cpustat.system);
+		if (include_time[IOWAIT])
+			time =3D cputime64_add(time, kstat_cpu(i).cpustat.iowait);
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
+static int get_include_time(char *buffer, struct kernel_param *kp)
+{
+	int which_time =3D *((int*)kp->arg);
+	if ((which_time < 0) || (which_time >=3D NUM_TIME_TYPES))
+		return -EINVAL;
+	sprintf(buffer, "%d", include_time[which_time]);
+	return strlen(buffer);
+}
+
+static int set_include_time(const char *val, struct kernel_param *kp)
+{
+	int which_time =3D *((int*)kp->arg);
+	int new_value;
+	if ((which_time < 0) || (which_time >=3D NUM_TIME_TYPES))
+		return -EINVAL;
+	if (sscanf(val, "%d", &new_value) !=3D 1)
+		return -EINVAL;
+	include_time[which_time] =3D new_value;
+	return 0;
+}
+
+module_param_call(include_user, set_include_time, get_include_time, &USER,=
 6);
+module_param_call(include_nice, set_include_time, get_include_time, &NICE,=
 6);
+module_param_call(include_system, set_include_time, get_include_time, &SYS=
TEM, 6);
+module_param_call(include_iowait, set_include_time, get_include_time, &IOW=
AIT, 6);
+
+MODULE_AUTHOR("Thomas Tuttle <thinkinginbinary@gmail.com>");
+MODULE_DESCRIPTION("LED CPU Activity Trigger");
+MODULE_PARM_DESC(include_user, "Include user time when measuring CPU activ=
ity");
+MODULE_PARM_DESC(include_nice, "Include nice time when measuring CPU activ=
ity");
+MODULE_PARM_DESC(include_system, "Include system time when measuring CPU a=
ctivity");
+MODULE_PARM_DESC(include_iowait, "Include IO wait time when measuring CPU =
activity");
+MODULE_LICENSE("GPL");
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

--BQPnanjtCNWHyqYD--

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErb/N/UG6u69REsYRAqn9AJ0cZAaRaozoLW02HX3XpjV/KGb8uwCeL2+U
xeTBUJu6rXTe7Yackp8jbaQ=
=JKva
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
