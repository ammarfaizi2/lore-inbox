Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWBGWnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWBGWnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWBGWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:18 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56283 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932450AbWBGWnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:13 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Complain if driver reenables interrupts during drivers_[suspend|resume] & re-disable
Date: Tue, 7 Feb 2006 19:06:48 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21107747.Ms9F2Pm8Tg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071906.55281.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart21107747.Ms9F2Pm8Tg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all.

This patch is designed to help with diagnosing and fixing the cause of
problems in suspending/resuming, due to drivers wrongly re-enabling
interrupts in their .suspend or .resume methods.=20

I nearly forgot about it in sending patches in suspend2 that might help
where swsusp fails.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 power/resume.c  |    5 +++++
 power/suspend.c |    5 +++++
 sys.c           |   37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)
diff -ruNp 8010-driver-model-debug.patch-old/drivers/base/power/resume.c=20
8010-driver-model-debug.patch-new/drivers/base/power/resume.c
=2D-- 8010-driver-model-debug.patch-old/drivers/base/power/resume.c=09
2006-01-19 21:27:39.000000000 +1000
+++ 8010-driver-model-debug.patch-new/drivers/base/power/resume.c=09
2006-01-31 19:54:52.000000000 +1000
@@ -35,6 +35,11 @@ int resume_device(struct device * dev)
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
 		error =3D dev->bus->resume(dev);
+		if (!irqs_disabled()) {
+			printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming device=
=20
%s.\n",
+				kobject_name(&dev->kobj));
+			local_irq_disable();
+		}
 	}
 	up(&dev->sem);
 	return error;
diff -ruNp 8010-driver-model-debug.patch-old/drivers/base/power/suspend.c=20
8010-driver-model-debug.patch-new/drivers/base/power/suspend.c
=2D-- 8010-driver-model-debug.patch-old/drivers/base/power/suspend.c=09
2006-01-19 21:27:39.000000000 +1000
+++ 8010-driver-model-debug.patch-new/drivers/base/power/suspend.c=09
2006-01-31 19:54:44.000000000 +1000
@@ -58,6 +58,11 @@ int suspend_device(struct device * dev,=20
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
 		dev_dbg(dev, "suspending\n");
 		error =3D dev->bus->suspend(dev, state);
+		if (!irqs_disabled()) {
+			printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending=20
device %s.\n",
+				kobject_name(&dev->kobj));
+			local_irq_disable();
+		}
 	}
 	up(&dev->sem);
 	return error;
diff -ruNp 8010-driver-model-debug.patch-old/drivers/base/sys.c=20
8010-driver-model-debug.patch-new/drivers/base/sys.c
=2D-- 8010-driver-model-debug.patch-old/drivers/base/sys.c	2006-01-19=20
21:27:39.000000000 +1000
+++ 8010-driver-model-debug.patch-new/drivers/base/sys.c	2006-01-31=20
19:54:09.000000000 +1000
@@ -298,16 +298,34 @@ static void __sysdev_resume(struct sys_d
 	if (cls->resume)
 		cls->resume(dev);
=20
+	if (!irqs_disabled()) {
+		printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming sysdev=20
class specific driver %s.\n",
+				kobject_name(&dev->kobj));
+		local_irq_disable();
+	}
+
 	/* Call auxillary drivers next. */
 	list_for_each_entry(drv, &cls->drivers, entry) {
=2D		if (drv->resume)
+		if (drv->resume) {
 			drv->resume(dev);
+			if (!irqs_disabled()) {
+				printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming sysdev=
=20
class driver %s.\n",
+				kobject_name(&dev->kobj));
+				local_irq_disable();
+			}
+		}
 	}
=20
 	/* Call global drivers. */
 	list_for_each_entry(drv, &sysdev_drivers, entry) {
=2D		if (drv->resume)
+		if (drv->resume) {
 			drv->resume(dev);
+			if (!irqs_disabled()) {
+				printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming sysdev=
=20
driver %s.\n",
+				kobject_name(&dev->kobj));
+				local_irq_disable();
+			}
+		}
 	}
 }
=20
@@ -346,6 +364,11 @@ int sysdev_suspend(pm_message_t state)
 			list_for_each_entry(drv, &sysdev_drivers, entry) {
 				if (drv->suspend) {
 					ret =3D drv->suspend(sysdev, state);
+					if (!irqs_disabled()) {
+						printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending=20
sysdev driver %s.\n",
+							kobject_name(&sysdev->kobj));
+						local_irq_disable();
+					}
 					if (ret)
 						goto gbl_driver;
 				}
@@ -355,6 +378,11 @@ int sysdev_suspend(pm_message_t state)
 			list_for_each_entry(drv, &cls->drivers, entry) {
 				if (drv->suspend) {
 					ret =3D drv->suspend(sysdev, state);
+					if (!irqs_disabled()) {
+						printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending=20
sysdev class driver %s.\n",
+						kobject_name(&sysdev->kobj));
+						local_irq_disable();
+					}
 					if (ret)
 						goto aux_driver;
 				}
@@ -363,6 +391,11 @@ int sysdev_suspend(pm_message_t state)
 			/* Now call the generic one */
 			if (cls->suspend) {
 				ret =3D cls->suspend(sysdev, state);
+				if (!irqs_disabled()) {
+					printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending=20
class driver %s.\n",
+					kobject_name(&sysdev->kobj));
+					local_irq_disable();
+				}
 				if (ret)
 					goto cls_driver;
 			}

--nextPart21107747.Ms9F2Pm8Tg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6GMvN0y+n1M3mo0RAq03AJ9bc9T+eZzhQarqmT0LAOrJ/LH7HwCfVI0Y
lrCvt4yT7ujBT7NywX1QLF8=
=crMH
-----END PGP SIGNATURE-----

--nextPart21107747.Ms9F2Pm8Tg--
