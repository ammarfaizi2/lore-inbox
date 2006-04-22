Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDVSGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDVSGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDVSGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:06:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:6868 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750786AbWDVSGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:06:18 -0400
X-Sasl-enc: ysfu+w/LVeJBMSdZYLY73Slj9cxqTaNSnpayHE3mzgIu 1145729136
Message-ID: <444A70E5.1060107@imap.cc>
Date: Sat, 22 Apr 2006 20:07:33 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc2 2/2] i4l gigaset: move sysfs entry to tty class
 device
References: <44497FFE.6050508@imap.cc> <20060421181429.5ea9d777.akpm@osdl.org> <444A5BA5.6040007@imap.cc>
In-Reply-To: <444A5BA5.6040007@imap.cc>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF471BB0C401B50D29D34B7CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF471BB0C401B50D29D34B7CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[Repost - vger.kernel.org rejected the first attempt with "User unknown"]

From: Hansjoerg Lipp <hjlipp@web.de>

Using the class device pointer returned by tty_register_device() with
part 1 of the patch, attach the Gigaset drivers' "cidmode" sysfs entry
to its tty class device, where it can be found more easily by users
who do not know nor care which USB port the device is attached to.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>

---

This patch depends on the preceding one titled:
"return class device pointer from tty_register_device()"
Please merge if and when that one has been accepted.

 Documentation/isdn/README.gigaset |    7 ++++---
 drivers/isdn/gigaset/common.c     |   13 +++++++------
 drivers/isdn/gigaset/gigaset.h    |    1 +
 drivers/isdn/gigaset/interface.c  |   10 +++++++++-
 drivers/isdn/gigaset/proc.c       |   21 +++++++++++++--------
 5 files changed, 34 insertions(+), 18 deletions(-)

diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/Documentation/isdn/README.gigaset linux-2.6.17-rc1-mm2/Documentation/isdn/README.gigaset
--- linux-2.6.17-rc1-mm2.orig/Documentation/isdn/README.gigaset	2006-04-09 18:30:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2/Documentation/isdn/README.gigaset	2006-04-22 16:10:47.000000000 +0200
@@ -124,7 +124,8 @@ GigaSet 307x Device Driver

      You can use some configuration tool of your distribution to configure this
      "modem" or configure pppd/wvdial manually. There are some example ppp
-     configuration files and chat scripts in the gigaset-VERSION/ppp directory.
+     configuration files and chat scripts in the gigaset-VERSION/ppp directory
+     in the driver packages from http://sourceforge.net/projects/gigaset307x/.
      Please note that the USB drivers are not able to change the state of the
      control lines (the M105 driver can be configured to use some undocumented
      control requests, if you really need the control lines, though). This means
@@ -164,8 +165,8 @@ GigaSet 307x Device Driver

      If you want both of these at once, you are out of luck.

-     You can also use /sys/module/<name>/parameters/cidmode for changing
-     the CID mode setting (<name> is usb_gigaset or bas_gigaset).
+     You can also use /sys/class/tty/ttyGxy/cidmode for changing the CID mode
+     setting (ttyGxy is ttyGU0 or ttyGB0).


 3.   Troubleshooting
diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/common.c linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/common.c
--- linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/common.c	2006-04-09 18:30:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/common.c	2006-04-18 22:23:02.000000000 +0200
@@ -460,6 +460,9 @@ void gigaset_freecs(struct cardstate *cs

 	switch (cs->cs_init) {
 	default:
+		/* clear device sysfs */
+		gigaset_free_dev_sysfs(cs);
+
 		gigaset_if_free(cs);

 		gig_dbg(DEBUG_INIT, "clearing hw");
@@ -699,6 +702,7 @@ struct cardstate *gigaset_initcs(struct
 	cs->open_count = 0;
 	cs->dev = NULL;
 	cs->tty = NULL;
+	cs->class = NULL;
 	cs->cidmode = cidmode != 0;

 	//if(onechannel) { //FIXME
@@ -760,6 +764,9 @@ struct cardstate *gigaset_initcs(struct

 	gigaset_if_init(cs);

+	/* set up device sysfs */
+	gigaset_init_dev_sysfs(cs);
+
 	spin_lock_irqsave(&cs->lock, flags);
 	cs->running = 1;
 	spin_unlock_irqrestore(&cs->lock, flags);
@@ -903,9 +910,6 @@ int gigaset_start(struct cardstate *cs)

 	wait_event(cs->waitqueue, !cs->waiting);

-	/* set up device sysfs */
-	gigaset_init_dev_sysfs(cs);
-
 	mutex_unlock(&cs->mutex);
 	return 1;

@@ -970,9 +974,6 @@ void gigaset_stop(struct cardstate *cs)
 		//FIXME
 	}

-	/* clear device sysfs */
-	gigaset_free_dev_sysfs(cs);
-
 	cleanup_cs(cs);

 exit:
diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/gigaset.h linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/gigaset.h
--- linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/gigaset.h	2006-04-09 18:30:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/gigaset.h	2006-04-18 21:29:00.000000000 +0200
@@ -445,6 +445,7 @@ struct cardstate {
 	struct gigaset_driver *driver;
 	unsigned minor_index;
 	struct device *dev;
+	struct class_device *class;

 	const struct gigaset_ops *ops;

diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/interface.c linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/interface.c
--- linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/interface.c	2006-04-09 18:30:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/interface.c	2006-04-22 05:11:03.000000000 +0200
@@ -625,7 +625,14 @@ void gigaset_if_init(struct cardstate *c
 		return;

 	tasklet_init(&cs->if_wake_tasklet, &if_wake, (unsigned long) cs);
-	tty_register_device(drv->tty, cs->minor_index, NULL);
+	cs->class = tty_register_device(drv->tty, cs->minor_index, NULL);
+
+	if (!IS_ERR(cs->class))
+		class_set_devdata(cs->class, cs);
+	else {
+		warn("could not register device to the tty subsystem");
+		cs->class = NULL;
+	}
 }

 void gigaset_if_free(struct cardstate *cs)
@@ -638,6 +645,7 @@ void gigaset_if_free(struct cardstate *c

 	tasklet_disable(&cs->if_wake_tasklet);
 	tasklet_kill(&cs->if_wake_tasklet);
+	cs->class = NULL;
 	tty_unregister_device(drv->tty, cs->minor_index);
 }

diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/proc.c linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/proc.c
--- linux-2.6.17-rc1-mm2.orig/drivers/isdn/gigaset/proc.c	2006-04-09 18:30:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2/drivers/isdn/gigaset/proc.c	2006-04-22 05:21:56.000000000 +0200
@@ -16,12 +16,11 @@
 #include "gigaset.h"
 #include <linux/ctype.h>

-static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t show_cidmode(struct class_device *class, char *buf)
 {
 	int ret;
 	unsigned long flags;
-	struct cardstate *cs = dev_get_drvdata(dev);
+	struct cardstate *cs = class_get_devdata(class);

 	spin_lock_irqsave(&cs->lock, flags);
 	ret = sprintf(buf, "%u\n", cs->cidmode);
@@ -30,10 +29,10 @@ static ssize_t show_cidmode(struct devic
 	return ret;
 }

-static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
+static ssize_t set_cidmode(struct class_device *class,
 			   const char *buf, size_t count)
 {
-	struct cardstate *cs = dev_get_drvdata(dev);
+	struct cardstate *cs = class_get_devdata(class);
 	long int value;
 	char *end;

@@ -65,18 +64,24 @@ static ssize_t set_cidmode(struct device
 	return count;
 }

-static DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
+static CLASS_DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);

 /* free sysfs for device */
 void gigaset_free_dev_sysfs(struct cardstate *cs)
 {
+	if (!cs->class)
+		return;
+
 	gig_dbg(DEBUG_INIT, "removing sysfs entries");
-	device_remove_file(cs->dev, &dev_attr_cidmode);
+	class_device_remove_file(cs->class, &class_device_attr_cidmode);
 }

 /* initialize sysfs for device */
 void gigaset_init_dev_sysfs(struct cardstate *cs)
 {
+	if (!cs->class)
+		return;
+
 	gig_dbg(DEBUG_INIT, "setting up sysfs");
-	device_create_file(cs->dev, &dev_attr_cidmode);
+	class_device_create_file(cs->class, &class_device_attr_cidmode);
 }

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Imagine a world without hypothetical situations.



--------------enigF471BB0C401B50D29D34B7CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESnDlMdB4Whm86/kRAsepAJ0a3Y5DUKMe07h4NsqNHZQP6n6i3wCfYTTl
txjqL9EVLh4hGOPp4naGX0E=
=36Ry
-----END PGP SIGNATURE-----

--------------enigF471BB0C401B50D29D34B7CA--
