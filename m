Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRCKNt1>; Sun, 11 Mar 2001 08:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131411AbRCKNtS>; Sun, 11 Mar 2001 08:49:18 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:52236 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S131408AbRCKNtB>; Sun, 11 Mar 2001 08:49:01 -0500
Date: Sun, 11 Mar 2001 16:47:47 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /drivers/char/cyclades.c: panic() call removal
Message-ID: <20010311164747.A332@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch removes panic() calls and adds MODULE_DEVICE_TABLE to cyclades d=
river.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-cyclades
Content-Transfer-Encoding: quoted-printable

--- /linux/drivers/char/cyclades.c.orig	Sun Mar 11 19:50:00 2001
+++ /linux/drivers/char/cyclades.c	Sun Mar 11 20:09:08 2001
@@ -866,17 +866,21 @@
 static unsigned short	cy_isa_nboard;
 static unsigned short	cy_nboard;
 #ifdef CONFIG_PCI
-static unsigned short	cy_pci_dev_id[] =3D {
-			    PCI_DEVICE_ID_CYCLOM_Y_Lo,	/* PCI < 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_Y_Hi,	/* PCI > 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_4Y_Lo,	/* 4Y PCI < 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_4Y_Hi,	/* 4Y PCI > 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_8Y_Lo,	/* 8Y PCI < 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_8Y_Hi,	/* 8Y PCI > 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_Z_Lo,	/* Z PCI < 1Mb */
-			    PCI_DEVICE_ID_CYCLOM_Z_Hi,	/* Z PCI > 1Mb */
-			    0				/* end of table */
-			};
+#define CYCLADES_DEVICE(x) { PCI_VENDOR_ID_CYCLADES, PCI_DEVICE_ID_CYCLOM_=
##x##, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }
+
+static struct pci_device_id cy_pci_dev_id[] =3D {
+	CYCLADES_DEVICE(Y_Lo),		/* PCI < 1Mb */
+	CYCLADES_DEVICE(Y_Hi),		/* PCI > 1Mb */
+	CYCLADES_DEVICE(4Y_Lo),		/* 4Y PCI < 1Mb */
+	CYCLADES_DEVICE(4Y_Hi),		/* 4Y PCI > 1Mb */
+	CYCLADES_DEVICE(8Y_Lo),		/* 8Y PCI < 1Mb */
+	CYCLADES_DEVICE(8Y_Hi),		/* 8Y PCI > 1Mb */
+	CYCLADES_DEVICE(Z_Lo),		/* Z PCI < 1Mb */
+	CYCLADES_DEVICE(Z_Hi),		/* Z PCI > 1Mb */
+	{ 0, }				/* end of table */
+};
+
+MODULE_DEVICE_TABLE(pci, cy_pci_dev_id);
 #endif
=20
 static void cy_start(struct tty_struct *);
@@ -4970,7 +4974,7 @@
=20
         for (i =3D 0; i < NR_CARDS; i++) {
                 /* look for a Cyclades card by vendor and device id */
-                while((device_id =3D cy_pci_dev_id[dev_index]) !=3D 0) {
+                while((device_id =3D cy_pci_dev_id[dev_index].device) !=3D=
 0) {
                         if((pdev =3D pci_find_device(PCI_VENDOR_ID_CYCLADE=
S,
                                         device_id, pdev)) =3D=3D NULL) {
                                 dev_index++;    /* try next device id */
@@ -5478,6 +5482,15 @@
     extra ports are ignored.
  */
=20
+static void __init cy_cleanup_after_failure(struct tty_driver *tty)
+{
+	unsigned long flags;
+	save_flags(flags); cli();
+	remove_bh(CYCLADES_BH);
+	if (tty) tty_unregister_driver(tty);
+	restore_flags(flags);
+}
+
 int __init
 cy_init(void)
 {
@@ -5544,10 +5557,16 @@
     cy_callout_driver.proc_entry =3D 0;
=20
=20
-    if (tty_register_driver(&cy_serial_driver))
-	     panic("Couldn't register Cyclades serial driver\n");
-    if (tty_register_driver(&cy_callout_driver))
-	     panic("Couldn't register Cyclades callout driver\n");
+    if ((i =3D tty_register_driver(&cy_serial_driver))) {
+	    printk(KERN_ERR "cyclades: Couldn't register Cyclades serial driver\n=
");
+	    cy_cleanup_after_failure(NULL);
+	    return i;
+    }
+    if ((i =3D tty_register_driver(&cy_callout_driver))) {
+	    printk(KERN_ERR "cyclades: Couldn't register Cyclades callout driver\=
n");
+	    cy_cleanup_after_failure(&cy_serial_driver);
+	    return i;
+    }
=20
     for (i =3D 0; i < NR_CARDS; i++) {
             /* base_addr=3D0 indicates board not found */

--x+6KMIRAuhnl3hBn--

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE6q4IDBm4rlNOo3YgRAoQRAJiWvd6MtxxmHudjINJ+sNE3VYBkAJ0Upvvn
q7kXf4StCj9O2Z4pPB163g==
=7ril
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
