Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSK2MYc>; Fri, 29 Nov 2002 07:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSK2MYb>; Fri, 29 Nov 2002 07:24:31 -0500
Received: from mail1.heidelberg.com ([193.158.227.198]:37505 "HELO
	wiems06001.ceu.heidelberg.com") by vger.kernel.org with SMTP
	id <S267034AbSK2MY1>; Fri, 29 Nov 2002 07:24:27 -0500
Date: Fri, 29 Nov 2002 13:30:50 +0100
From: Roman Fietze <fietze@swec.muh.de.heidelberg.com>
To: mj@ucw.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: COM20020 Driver Patches for 2.5.49
Message-ID: <20021129133050.C9702@muhapp010.muh.de.heidelberg.com>
Reply-To: fietze@swec.muh.de.heidelberg.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-OriginalArrivalTime: 29 Nov 2002 12:30:51.0820 (UTC) FILETIME=[2783AEC0:01C297A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

These are patches for the com20020.c and com20020-pci.c generic and
PCI specific drivers. These patches incorporate:

- support for SOHARD card
- bug fix checking return code of request_region
- fix for number of I/O ports used by the card
- enable P1Mode for backplane mode

These changes had been submitted once in a while since kernel
2.4.6. We've been running the changed driver in number of application
in RAW mode w/o any problem on the i386.




diff -Naur ./linux-2.5.49/drivers/net/arcnet/com20020-pci.c ./linux-2.5.49-=
arcnet-patches/drivers/net/arcnet/com20020-pci.c
--- ./linux-2.5.49/drivers/net/arcnet/com20020-pci.c	Fri Nov 22 22:40:21 20=
02
+++ ./linux-2.5.49-arcnet-patches/drivers/net/arcnet/com20020-pci.c	Fri Nov=
 29 10:12:09 2002
@@ -1,5 +1,6 @@
 /*
- * Linux ARCnet driver - COM20020 PCI support (Contemporary Controls PCI20)
+ * Linux ARCnet driver - COM20020 PCI support
+ * Contemporary Controls PCI20 and SOHARD SH-ARC PCI
  *=20
  * Written 1994-1999 by Avery Pennarun,
  *    based on an ISA version by David Woodhouse.
@@ -86,7 +87,21 @@
 	memset(lp, 0, sizeof(struct arcnet_local));
 	pci_set_drvdata(pdev, dev);
=20
-	ioaddr =3D pci_resource_start(pdev, 2);
+	// SOHARD needs PCI base addr 4
+	if (pdev->vendor=3D=3D0x10B5) {
+		BUGMSG(D_NORMAL, "SOHARD\n");
+		ioaddr =3D pci_resource_start(pdev, 4);
+	}
+	else {
+		BUGMSG(D_NORMAL, "Contemporary Controls\n");
+		ioaddr =3D pci_resource_start(pdev, 2);
+	}
+
+	// Dummy access after Reset
+	// ARCNET controller needs this access to detect bustype
+	outb(0x00,ioaddr+1);
+	inb(ioaddr+1);
+
 	dev->base_addr =3D ioaddr;
 	dev->irq =3D pdev->irq;
 	dev->dev_addr[0] =3D node;
@@ -152,6 +167,7 @@
 	{ 0x1571, 0xa204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{ 0x1571, 0xa205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{ 0x1571, 0xa206, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
+	{ 0x10B5, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{0,}
 };
=20
diff -Naur ./linux-2.5.49/drivers/net/arcnet/com20020.c ./linux-2.5.49-arcn=
et-patches/drivers/net/arcnet/com20020.c
--- ./linux-2.5.49/drivers/net/arcnet/com20020.c	Fri Nov 22 22:40:27 2002
+++ ./linux-2.5.49-arcnet-patches/drivers/net/arcnet/com20020.c	Fri Nov 29 =
10:00:17 2002
@@ -98,6 +98,9 @@
 	lp->setup =3D lp->clockm ? 0 : (lp->clockp << 1);
 	lp->setup2 =3D (lp->clockm << 4) | 8;
=20
+	/* Enable P1Mode for backplane mode */
+	lp->setup =3D lp->setup | P1MODE;
+
 	SET_SUBADR(SUB_SETUP1);
 	outb(lp->setup, _XREG);
=20
@@ -202,7 +205,7 @@
 		return -ENODEV;
 	}
 	/* reserve the I/O region */
-	if (request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
 		free_irq(dev->irq, dev);
 		return -EBUSY;
 	}
@@ -300,8 +303,9 @@
 	struct arcnet_local *lp =3D (struct arcnet_local *) dev->priv;
 	int ioaddr =3D dev->base_addr;
=20
-	if (open)
+	if (open) {
 		MOD_INC_USE_COUNT;
+	}
 	else {
 		/* disable transmitter */
 		lp->config &=3D ~TXENcfg;
diff -Naur ./linux-2.5.49/include/linux/com20020.h ./linux-2.5.49-arcnet-pa=
tches/include/linux/com20020.h
--- ./linux-2.5.49/include/linux/com20020.h	Fri Nov 22 22:40:19 2002
+++ ./linux-2.5.49-arcnet-patches/include/linux/com20020.h	Fri Nov 29 09:58=
:56 2002
@@ -32,7 +32,7 @@
 void com20020_remove(struct net_device *dev);
=20
 /* The number of low I/O ports used by the card. */
-#define ARCNET_TOTAL_SIZE 9
+#define ARCNET_TOTAL_SIZE 8
=20
 /* various register addresses */
 #define _INTMASK  (ioaddr+0)	/* writable */
@@ -59,6 +59,8 @@
=20
 /* in SETUP register */
 #define PROMISCset	0x10	/* enable RCV_ALL */
+#define P1MODE		0x80    /* enable P1-MODE for Backplane */
+#define SLOWARB		0x01    /* enable Slow Arbitration for >=3D5Mbps */
=20
 /* COM2002x */
 #define SUB_TENTATIVE	0	/* tentative node ID */




Roman

--=20
Roman Fietze (Mail Code 6)  Heidelberg Digital Finishing GmbH, Germany
fietze@swec.muh.de.heidelberg.com          roman.fietze@heidelberg.com
GnuPG/PGP Key Server for my Keys:      http://www.pgp.net/wwwkeys.html

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: mutt

iD8DBQE95136CKffHTBvAFQRAnUcAJ44ME7bv+bSQ9EqrZAMzAN46jf5gQCgmwTs
Kz93qvZSqnuMluGZXSBS9uA=
=0Cd1
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
