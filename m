Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWBNIVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWBNIVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbWBNIV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:21:29 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:13495 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030483AbWBNIV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:21:29 -0500
Date: Tue, 14 Feb 2006 09:21:26 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] [CM4000,CM4040] Driver fixes
Message-ID: <20060214082126.GC4605@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please apply this driver bugfix to your 2.6.16 tree, thanks!


[CM4000,CM4040] Driver fixes

Using this patch, Omnikey CardMan 4000 and 4040 devices automatically
get their device nodes created by udev.

Also, we now check for (and handle) failure of pcmcia_register_driver()

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_c=
s.c
index 649677b..5fdf185 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -13,11 +13,12 @@
   *
   * (C) 2000,2001,2002,2003,2004 Omnikey AG
   *
-  * (C) 2005 Harald Welte <laforge@gnumonks.org>
+  * (C) 2005-2006 Harald Welte <laforge@gnumonks.org>
   * 	- Adhere to Kernel CodingStyle
   * 	- Port to 2.6.13 "new" style PCMCIA
   * 	- Check for copy_{from,to}_user return values
   * 	- Use nonseekable_open()
+  * 	- add class interface for udev device creation
   *
   * All rights reserved. Licensed under dual BSD/GPL license.
   */
@@ -56,7 +57,7 @@ module_param(pc_debug, int, 0600);
 #else
 #define DEBUGP(n, rdr, x, args...)
 #endif
-static char *version =3D "cm4000_cs.c v2.4.0gm5 - All bugs added by Harald=
 Welte";
+static char *version =3D "cm4000_cs.c v2.4.0gm6 - All bugs added by Harald=
 Welte";
=20
 #define	T_1SEC		(HZ)
 #define	T_10MSEC	msecs_to_jiffies(10)
@@ -156,6 +157,7 @@ struct cm4000_dev {
 		/*queue*/ 4*sizeof(wait_queue_head_t))
=20
 static dev_link_t *dev_table[CM4000_MAX_DEV];
+static struct class *cmm_class;
=20
 /* This table doesn't use spaces after the comma between fields and thus
  * violates CodingStyle.  However, I don't really think wrapping it around=
 will
@@ -1937,6 +1939,9 @@ static int cm4000_attach(struct pcmcia_d
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
 	cm4000_config(link, i);
=20
+	class_device_create(cmm_class, NULL, MKDEV(major, i), NULL,
+			    "cmm%d", i);
+
 	return 0;
 }
=20
@@ -1962,6 +1967,8 @@ static void cm4000_detach(struct pcmcia_
 	dev_table[devno] =3D NULL;
  	kfree(dev);
=20
+	class_device_destroy(cmm_class, MKDEV(major, devno));
+
 	return;
 }
=20
@@ -1995,8 +2002,18 @@ static struct pcmcia_driver cm4000_drive
=20
 static int __init cmm_init(void)
 {
+	int rc;
+
 	printk(KERN_INFO "%s\n", version);
-	pcmcia_register_driver(&cm4000_driver);
+
+	cmm_class =3D class_create(THIS_MODULE, "cardman_4000");
+	if (!cmm_class)
+		return -1;
+
+	rc =3D pcmcia_register_driver(&cm4000_driver);
+	if (rc < 0)
+		return rc;
+
 	major =3D register_chrdev(0, DEVICE_NAME, &cm4000_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
@@ -2012,6 +2029,7 @@ static void __exit cmm_exit(void)
 	printk(KERN_INFO MODULE_NAME ": unloading\n");
 	pcmcia_unregister_driver(&cm4000_driver);
 	unregister_chrdev(major, DEVICE_NAME);
+	class_destroy(cmm_class);
 };
=20
 module_init(cmm_init);
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_c=
s.c
index 46eb371..466e33b 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -3,12 +3,13 @@
  *
  * (c) 2000-2004 Omnikey AG (http://www.omnikey.com/)
  *
- * (C) 2005 Harald Welte <laforge@gnumonks.org>
+ * (C) 2005-2006 Harald Welte <laforge@gnumonks.org>
  * 	- add support for poll()
  * 	- driver cleanup
  * 	- add waitqueues
  * 	- adhere to linux kernel coding style and policies
  * 	- support 2.6.13 "new style" pcmcia interface
+ * 	- add class interface for udev device creation
  *
  * The device basically is a USB CCID compliant device that has been
  * attached to an I/O-Mapped FIFO.
@@ -53,7 +54,7 @@ module_param(pc_debug, int, 0600);
 #endif
=20
 static char *version =3D
-"OMNIKEY CardMan 4040 v1.1.0gm4 - All bugs added by Harald Welte";
+"OMNIKEY CardMan 4040 v1.1.0gm5 - All bugs added by Harald Welte";
=20
 #define	CCID_DRIVER_BULK_DEFAULT_TIMEOUT  	(150*HZ)
 #define	CCID_DRIVER_ASYNC_POWERUP_TIMEOUT 	(35*HZ)
@@ -67,6 +68,7 @@ static char *version =3D
 static void reader_release(dev_link_t *link);
=20
 static int major;
+static struct class *cmx_class;
=20
 #define		BS_READABLE	0x01
 #define		BS_WRITABLE	0x02
@@ -696,6 +698,9 @@ static int reader_attach(struct pcmcia_d
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
 	reader_config(link, i);
=20
+	class_device_create(cmx_class, NULL, MKDEV(major, i), NULL,
+			    "cmx%d", i);
+
 	return 0;
 }
=20
@@ -721,6 +726,8 @@ static void reader_detach(struct pcmcia_
 	dev_table[devno] =3D NULL;
 	kfree(dev);
=20
+	class_device_destroy(cmx_class, MKDEV(major, devno));
+
 	return;
 }
=20
@@ -755,8 +762,17 @@ static struct pcmcia_driver reader_drive
=20
 static int __init cm4040_init(void)
 {
+	int rc;
+
 	printk(KERN_INFO "%s\n", version);
-	pcmcia_register_driver(&reader_driver);
+	cmx_class =3D class_create(THIS_MODULE, "cardman_4040");
+	if (!cmx_class)
+		return -1;
+
+	rc =3D pcmcia_register_driver(&reader_driver);
+	if (rc < 0)
+		return rc;
+
 	major =3D register_chrdev(0, DEVICE_NAME, &reader_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
@@ -771,6 +787,7 @@ static void __exit cm4040_exit(void)
 	printk(KERN_INFO MODULE_NAME ": unloading\n");
 	pcmcia_unregister_driver(&reader_driver);
 	unregister_chrdev(major, DEVICE_NAME);
+	class_destroy(cmx_class);
 }
=20
 module_init(cm4040_init);
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8ZMGXaXGVTD0i/8RAvAeAKCn9oYhwyHOc1vNHIw3U9nUo5/pqACdE5dy
WR8TYxURB5N7BbeJ2q+wgmE=
=jYWm
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
