Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284754AbRLPSp4>; Sun, 16 Dec 2001 13:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284751AbRLPSpq>; Sun, 16 Dec 2001 13:45:46 -0500
Received: from david.siemens.de ([192.35.17.14]:33786 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S284757AbRLPSph>;
	Sun, 16 Dec 2001 13:45:37 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Mandrake kernel list <kernel@mandrakesoft.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
        Cooker list <cooker@linux-mandrake.com>
Subject: PATCH: apm.c - runtime parameter for APM Idle call
Content-Type: multipart/mixed; boundary="=-aklT5u3R/iX7ur5LKygI"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 16 Dec 2001 21:45:18 +0300
Message-Id: <1008528319.2243.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aklT5u3R/iX7ur5LKygI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After investigating kapm_idled problem here it turned out quite simple -
BIOS neither slows down CPU nor halts it so kapm_idled enters busy loop
doing basically

while !system_busy
  do nothing

eating away CPU. This applies to patch of Andreas as well.

I do not like an option of recompiling without CONFIG_APM_CPU_IDLE
because I think about distribution kernel in the first place. I have
ASUS CUSL2 motherboard - it is not unusual brand and obviously many
people have the same problem and you cannot expect all of them to
recompile kernel. So this patch adds runtime parameter (no-)apm-idle
that has the same effect - enabling/disabling usage of APM Idle BIOS
calls. It is initialised according to CONFIG_APM_CPU_IDLE and should be
100% compatible.

If Andreas patch is accepted it needs the same treatment.

I thought once about run-time detection - if BIOS reports that Idle does
not slow down CPU try Idle call once and compare jiffies (probably
repeat several times to be sure). Is it sensible?

Patch is agains 2.4.16-9.dk but should apply to any version I guess.

-andrej




--=-aklT5u3R/iX7ur5LKygI
Content-Disposition: attachment; filename=apm-idle.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=KOI8-R

--- arch/i386/kernel/apm.c.org	Sat Nov 10 00:58:02 2001
+++ arch/i386/kernel/apm.c	Sun Dec 16 21:23:27 2001
@@ -383,6 +383,11 @@
 static int			allow_ints;
 #endif
 static int			broken_psr;
+#ifdef CONFIG_APM_CPU_IDLE
+static int			apm_idle_enabled =3D 1;
+#else
+static int			apm_idle_enabled;
+#endif
=20
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
@@ -1366,7 +1371,8 @@
 		 */
 		set_current_state(TASK_INTERRUPTIBLE);
 		apm_event_handler();
-#ifdef CONFIG_APM_CPU_IDLE
+		if (!apm_idle_enabled)
+			continue;
 		if (!system_idle())
 			continue;
 	=09
@@ -1393,7 +1399,6 @@
 			apm_event_handler();
 			timeout =3D 1;
 		}
-#endif
 	}
 	remove_wait_queue(&apm_waitqueue, &wait);
 }
@@ -1814,6 +1819,8 @@
 		if ((strncmp(str, "realmode-power-off", 18) =3D=3D 0) ||
 		    (strncmp(str, "realmode_power_off", 18) =3D=3D 0))
 			apm_info.realmode_power_off =3D !invert;
+		if (strncmp(str, "apm-idle", 8) =3D=3D 0)
+			apm_idle_enabled =3D !invert;
 		str =3D strchr(str, ',');
 		if (str !=3D NULL)
 			str +=3D strspn(str, ", \t");

--=-aklT5u3R/iX7ur5LKygI--
