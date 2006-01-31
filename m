Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWAaKKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWAaKKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWAaKKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:10:49 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:46034 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750711AbWAaKKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:10:49 -0500
Date: Tue, 31 Jan 2006 11:10:46 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Joachim Breitner <mail@joachim-breitner.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: [PATCH] [CM4000,CM4040] Add device class bits to enable udev device creation
Message-ID: <20060131101046.GS4603@sunbeam.de.gnumonks.org>
References: <1138536696.6509.9.camel@otto.ehbuehl.net> <1138541796.6395.8.camel@otto.ehbuehl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2SCFAybeao0WS1g"
Content-Disposition: inline
In-Reply-To: <1138541796.6395.8.camel@otto.ehbuehl.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f2SCFAybeao0WS1g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please apply this fix to the cm4000/4040 drivers, thanks!

[CM4000,CM4040] Add device class bits to enable udev device creation

Using this patch, Omnikey CardMan 4000 and 4040 devices automatically
get their device nodes created by udev.

Signed-off-by: Harald Welte <laforge@gnumonks.org>

---
commit 904a871a628c42031c3093c2b90bde526f0f35f0
tree fd05d26498ff86bf857331f270b7db13f4e077c0
parent 5b130c9da429fe28af1e59ce6589890f326cc182
author Harald Welte <laforge@gnumonks.org> Tue, 31 Jan 2006 11:08:33 +0100
committer Harald Welte <laforge@gnumonks.org> Tue, 31 Jan 2006 11:08:33 +01=
00

 drivers/char/pcmcia/cm4000_cs.c |   14 +++++++++++++-
 drivers/char/pcmcia/cm4040_cs.c |   13 ++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_c=
s.c
index 649677b..d5cc5f3 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -56,7 +56,7 @@ module_param(pc_debug, int, 0600);
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
@@ -156,6 +156,7 @@ struct cm4000_dev {
 		/*queue*/ 4*sizeof(wait_queue_head_t))
=20
 static dev_link_t *dev_table[CM4000_MAX_DEV];
+static struct class *cmm_class;
=20
 /* This table doesn't use spaces after the comma between fields and thus
  * violates CodingStyle.  However, I don't really think wrapping it around=
 will
@@ -1937,6 +1938,9 @@ static int cm4000_attach(struct pcmcia_d
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
 	cm4000_config(link, i);
=20
+	class_device_create(cmm_class, NULL, MKDEV(major, i), NULL,
+			    "cmm%d", i);
+
 	return 0;
 }
=20
@@ -1962,6 +1966,8 @@ static void cm4000_detach(struct pcmcia_
 	dev_table[devno] =3D NULL;
  	kfree(dev);
=20
+	class_device_destroy(cmm_class, MKDEV(major, devno));
+
 	return;
 }
=20
@@ -1996,6 +2002,11 @@ static struct pcmcia_driver cm4000_drive
 static int __init cmm_init(void)
 {
 	printk(KERN_INFO "%s\n", version);
+
+	cmm_class =3D class_create(THIS_MODULE, "cmm");
+	if (!cmm_class)
+		return -1;
+
 	pcmcia_register_driver(&cm4000_driver);
 	major =3D register_chrdev(0, DEVICE_NAME, &cm4000_fops);
 	if (major < 0) {
@@ -2012,6 +2023,7 @@ static void __exit cmm_exit(void)
 	printk(KERN_INFO MODULE_NAME ": unloading\n");
 	pcmcia_unregister_driver(&cm4000_driver);
 	unregister_chrdev(major, DEVICE_NAME);
+	class_destroy(cmm_class);
 };
=20
 module_init(cmm_init);
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_c=
s.c
index 46eb371..e907a7c 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -53,7 +53,7 @@ module_param(pc_debug, int, 0600);
 #endif
=20
 static char *version =3D
-"OMNIKEY CardMan 4040 v1.1.0gm4 - All bugs added by Harald Welte";
+"OMNIKEY CardMan 4040 v1.1.0gm5 - All bugs added by Harald Welte";
=20
 #define	CCID_DRIVER_BULK_DEFAULT_TIMEOUT  	(150*HZ)
 #define	CCID_DRIVER_ASYNC_POWERUP_TIMEOUT 	(35*HZ)
@@ -67,6 +67,7 @@ static char *version =3D
 static void reader_release(dev_link_t *link);
=20
 static int major;
+static struct class *cmx_class;
=20
 #define		BS_READABLE	0x01
 #define		BS_WRITABLE	0x02
@@ -696,6 +697,9 @@ static int reader_attach(struct pcmcia_d
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
 	reader_config(link, i);
=20
+	class_device_create(cmx_class, NULL, MKDEV(major, i), NULL,
+			    "cmx%d", i);
+
 	return 0;
 }
=20
@@ -721,6 +725,8 @@ static void reader_detach(struct pcmcia_
 	dev_table[devno] =3D NULL;
 	kfree(dev);
=20
+	class_device_destroy(cmx_class, MKDEV(major, devno));
+
 	return;
 }
=20
@@ -756,6 +762,10 @@ static struct pcmcia_driver reader_drive
 static int __init cm4040_init(void)
 {
 	printk(KERN_INFO "%s\n", version);
+	cmx_class =3D class_create(THIS_MODULE, "cmx");
+	if (!cmx_class)
+		return -1;
+
 	pcmcia_register_driver(&reader_driver);
 	major =3D register_chrdev(0, DEVICE_NAME, &reader_fops);
 	if (major < 0) {
@@ -771,6 +781,7 @@ static void __exit cm4040_exit(void)
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

--f2SCFAybeao0WS1g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD3zemXaXGVTD0i/8RAiCsAJ4/9cj3EN/h1V95GcdrT8j2gNdf5wCghOna
6iHb34tpbOsemuJuA7ilHck=
=9bxd
-----END PGP SIGNATURE-----

--f2SCFAybeao0WS1g--
