Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbRGQJcf>; Tue, 17 Jul 2001 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbRGQJc0>; Tue, 17 Jul 2001 05:32:26 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:50956 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261561AbRGQJcT>;
	Tue, 17 Jul 2001 05:32:19 -0400
Date: Tue, 17 Jul 2001 13:32:08 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS: bugfixes
Message-ID: <20010717133208.A28013@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 12:55pm  up  3:31,  3 users,  load average: 0.00, 0.04, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
From: pazke@orbita1.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,

this patch (2.4.6-ac5) fixed two significant bugs in PnP BIOS enumeration c=
ode:
	- pnpbios_build_devlist() doesn't check pnp_bios_get_dev_node() return code
	and always builds device list with approximately 250 bogus entries;
	- pnpid32_to_pnpid() function generates bogus strings instead of PNPxxxx.

Patch tested on my machine using parport_pc module.

BTW why pnpid32_to_pnpid() builds device ID using lovercase chars like PNP0=
c01,
may be PNP0C01 will be better ?

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pnpBIOS
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/pnp/pnp_bios.c /linux/dri=
vers/pnp/pnp_bios.c
--- /linux.vanilla/drivers/pnp/pnp_bios.c	Tue Jul 17 23:11:14 2001
+++ /linux/drivers/pnp/pnp_bios.c	Tue Jul 17 23:40:26 2001
@@ -695,16 +695,16 @@
 	const char *hex =3D "0123456789abcdef";
         static char str[8];
 	id =3D cpu_to_le32(id);
-	str[0] =3D CHAR(id, 26);
-	str[1] =3D CHAR(id, 21);
-	str[2] =3D CHAR(id,16);
-	str[3] =3D HEX(id, 12);
-	str[4] =3D HEX(id, 8);
-	str[5] =3D HEX(id, 4);
-	str[6] =3D HEX(id, 0);
+	str[0] =3D CHAR(id, 2);
+	str[1] =3D CHAR((((id & 3) << 3) | ((id >> 13) & 7)), 0);
+	str[2] =3D CHAR(id, 8);
+	str[3] =3D HEX(id, 20);
+	str[4] =3D HEX(id, 16);
+	str[5] =3D HEX(id, 28);
+	str[6] =3D HEX(id, 24);
 	str[7] =3D '\0';
 	return str;
-}                                             =20
+}
=20
 #undef CHAR
 #undef HEX =20
@@ -728,7 +728,7 @@
 =20
 static void __init pnpbios_build_devlist(void)
 {
-	int i;
+	int i, devs =3D 0;
 	struct pnp_bios_node *node;
         struct pnp_dev_node_info node_info;
 	struct pci_dev *dev;
@@ -746,13 +746,15 @@
         if (!node)
                 return;
=20
-	for(i=3D0;i<0xff;i++)
-	{
+	for(i=3D0;i<0xff;i++) {
 		dev =3D  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
 		=09
-                pnp_bios_get_dev_node((u8 *)&num, (char )0 , node);
+                if (pnp_bios_get_dev_node((u8 *)&num, (char )0 , node))
+			continue;
+
+		devs++;
 		pnpbios_rawdata_2_pci_dev(node,dev);
 		dev->devfn=3Dnum;
 		pnpid =3D pnpid32_to_pnpid(node->eisa_id);
@@ -762,6 +764,11 @@
 			kfree(dev);
 	}
 	kfree(node);
+
+	if (devs)
+		printk(KERN_INFO "PnP: %i device%s detected total\n", devs, devs > 1 ? "=
s" : "");
+	else
+		printk(KERN_INFO "PnP: No devices found\n");
 }
=20
=20

--d6Gm4EdcadzBjdND--

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7VAYYBm4rlNOo3YgRAqE5AJ9ze4kNtsFeJwW4dSkcFymYZcXNHACfU3gR
oC47HLCzhl5jLWVBsyAJi3Y=
=A5fo
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
