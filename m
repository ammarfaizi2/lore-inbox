Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271871AbRIDOB7>; Tue, 4 Sep 2001 10:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271878AbRIDOBt>; Tue, 4 Sep 2001 10:01:49 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:28164 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S271871AbRIDOBi>;
	Tue, 4 Sep 2001 10:01:38 -0400
Date: Tue, 4 Sep 2001 18:01:45 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS support for i82365.c
Message-ID: <20010904180145.A10608@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 5:50pm  up 1 day,  3:37,  1 user,  load average: 0.15, 0.05, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

attached patch adds PnP BIOS support in i82365 PCMCIA driver.
I hope it will be usefull for people with strange hardware configurations.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i82365-PNPBIOS
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/pcmcia/i82365.c /linux/dr=
ivers/pcmcia/i82365.c
--- /linux.vanilla/drivers/pcmcia/i82365.c	Sun Sep  2 23:42:50 2001
+++ /linux/drivers/pcmcia/i82365.c	Mon Sep  3 00:28:16 2001
@@ -58,6 +58,7 @@
 #include <pcmcia/cs.h>
=20
 #include <linux/isapnp.h>
+#include <linux/pnp_bios.h>
=20
 /* ISA-bus controllers */
 #include "i82365.h"
@@ -821,33 +822,53 @@
 #if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MO=
DULE))
 #define I82365_ISAPNP
 #endif
+#ifdef CONFIG_PNPBIOS
+#define I82365_PNPBIOS
+#endif
+#if defined(I82365_ISAPNP) || defined(I82365_PNPBIOS)
+#define I82365_PNP
+#endif
=20
-#ifdef I82365_ISAPNP
+#ifdef I82365_PNP
 static struct isapnp_device_id id_table[] __initdata =3D {
 	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
-		ISAPNP_FUNCTION(0x0e00), (unsigned long) "Intel 82365-Compatible" },
+		ISAPNP_FUNCTION(0x0e00), (unsigned long) "PNP0e00" },
 	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
-		ISAPNP_FUNCTION(0x0e01), (unsigned long) "Cirrus Logic CL-PD6720" },
+		ISAPNP_FUNCTION(0x0e01), (unsigned long) "PNP0e01" },
 	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
-		ISAPNP_FUNCTION(0x0e02), (unsigned long) "VLSI VL82C146" },
+		ISAPNP_FUNCTION(0x0e02), (unsigned long) "PNP0e02" },
 	{	0 }
 };
 MODULE_DEVICE_TABLE(isapnp, id_table);
=20
 static struct pci_dev *i82365_pnpdev;
+
+static struct pci_dev *pnp_find_dev(struct isapnp_device_id *id)
+{
+	struct pci_dev *dev =3D NULL;
+#ifdef I82365_ISAPNP
+	if ((dev =3D isapnp_find_dev(NULL, id->vendor, id->function, NULL)))
+		return dev;
+#endif
+#ifdef I82365_PNPBIOS
+	if ((dev =3D pnpbios_find_device((char *)id->driver_data, NULL)))
+		return dev;
+#endif
+	return dev;
+}
 #endif
=20
 static void __init isa_probe(void)
 {
     int i, j, sock, k, ns, id;
     ioaddr_t port;
-#ifdef I82365_ISAPNP
+#ifdef I82365_PNP
     struct isapnp_device_id *devid;
     struct pci_dev *dev;
=20
     for (devid =3D id_table; devid->vendor; devid++) {
-	if ((dev =3D isapnp_find_dev(NULL, devid->vendor, devid->function, NULL))=
) {
-	    printk("ISAPNP ");
+	if ((dev =3D pnp_find_dev(devid))) {
+	    printk("PNP ");
=20
 	    if (dev->prepare && dev->prepare(dev) < 0) {
 		printk("prepare failed\n");
@@ -1652,7 +1673,7 @@
 	i365_set(i, I365_CSCINT, 0);
 	release_region(socket[i].ioaddr, 2);
     }
-#if defined(CONFIG_ISA) && defined(I82365_ISAPNP)
+#if defined(CONFIG_ISA) && defined(I82365_PNP)
     if (i82365_pnpdev && i82365_pnpdev->deactivate)
 		i82365_pnpdev->deactivate(i82365_pnpdev);
 #endif

--AqsLC8rIMeq19msA--

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lN7JBm4rlNOo3YgRAnv7AJ4gJnraiNGgjN12Z4uGV3+9eJJTbwCeJbKJ
ngYTzFeBjTA4TxpkJYyOWqA=
=NsTr
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
