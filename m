Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSCNLp6>; Thu, 14 Mar 2002 06:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311589AbSCNLpt>; Thu, 14 Mar 2002 06:45:49 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:39430 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S311587AbSCNLpk>;
	Thu, 14 Mar 2002 06:45:40 -0500
Date: Thu, 14 Mar 2002 14:49:45 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] driverfs support for ISAPNP
Message-ID: <20020314114945.GB283@pazke.ipt>
Mail-Followup-To: perex@suse.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LSp5EJdfMPwZcMS1
Content-Type: multipart/mixed; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

attached patch adds initial driverfs support to ISAPNP driver.
Please take a look at it.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-isapnp-driverfs
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/pnp/isapnp.c linux/d=
rivers/pnp/isapnp.c
--- linux.vanilla/drivers/pnp/isapnp.c	Tue Mar  5 19:44:02 2002
+++ linux/drivers/pnp/isapnp.c	Tue Mar  5 23:57:44 2002
@@ -2273,6 +2273,39 @@
 EXPORT_SYMBOL(isapnp_register_driver);
 EXPORT_SYMBOL(isapnp_unregister_driver);
=20
+static struct device_driver isapnp_device_driver =3D {};
+
+static inline int isapnp_init_device_tree(void)
+{
+	struct pci_bus *card;
+	struct pci_dev *parent =3D pci_find_class(PCI_CLASS_BRIDGE_ISA << 8, NULL=
);
+
+	isapnp_for_each_card(card) {
+		struct list_head *devlist;
+
+		card->dev =3D isapnp_alloc(sizeof(*card->dev));
+		if (!card->dev)
+			break;
+		snprintf(card->dev->name, sizeof(card->dev->name), "%s", card->name);
+		sprintf(card->dev->bus_id, "isapnp%d", card->number);
+		card->dev->parent =3D parent ? &parent->dev : NULL;
+		card->dev->driver =3D &isapnp_device_driver;
+		device_register(card->dev);
+
+		for (devlist =3D card->devices.next; devlist !=3D &card->devices; devlis=
t =3D devlist->next) {
+			struct pci_dev *dev =3D pci_dev_b(devlist);
+
+			snprintf(dev->dev.name, sizeof(dev->dev.name), "%s", dev->name);
+			sprintf(dev->dev.bus_id, "%d", dev->devfn);
+			dev->dev.parent =3D card->dev;
+			dev->dev.driver =3D &isapnp_device_driver;
+			device_register(&dev->dev);
+		}
+	}
+
+	return 0;
+}
+
 int __init isapnp_init(void)
 {
 	int cards;
@@ -2351,6 +2384,9 @@
 	} else {
 		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
 	}
+
+	isapnp_init_device_tree();
+
 #ifdef CONFIG_PROC_FS
 	isapnp_proc_init();
 #endif
@@ -2361,10 +2397,28 @@
=20
 #ifdef MODULE
=20
+static inline void isapnp_cleanup_device_tree(void)
+{
+	struct pci_bus *card;
+
+	isapnp_for_each_card(card) {
+		struct list_head *devlist;
+
+		for (devlist =3D card->devices.next; devlist !=3D &card->devices; devlis=
t =3D devlist->next) {
+			struct pci_dev *dev =3D pci_dev_b(devlist);
+
+			put_device(&dev->dev);
+		}
+		put_device(card->dev);
+	}
+}
+
 void cleanup_module(void)
 {
-	if (isapnp_detected)
+	if (isapnp_detected) {
+		isapnp_cleanup_device_tree();
 		isapnp_free_all_resources();
+	}
 }
=20
 #else

--8nsIa27JVQLqB7/C--

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8kI5ZBm4rlNOo3YgRAjBrAJ493vSePYnmU8Lk072TvLPGb/7OcwCfU2ut
f7XbM859JQXhWNInd0kiYr8=
=j0RN
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
