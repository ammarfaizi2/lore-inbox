Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTBTEAR>; Wed, 19 Feb 2003 23:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTBTEAR>; Wed, 19 Feb 2003 23:00:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61157 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264799AbTBTEAN>; Wed, 19 Feb 2003 23:00:13 -0500
Subject: [PATCH] linux-2.5.62_acpitable-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Grover <andrew.grover@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0SUXJapTK3JxxN4d+1i+"
Organization: 
Message-Id: <1045713886.18312.66.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 20:04:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0SUXJapTK3JxxN4d+1i+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Andy, All,
	I've been working to boot up a 16way+HT box here on 2.5 with ACPI, and
have been getting consistent reboots before the console inits. I tracked
down the bug to some ACPI code where we map in the ACPI tables.=20

Unfortunately in a few cases we map in just the header, then immediately
start processing the table, rather then reading the table length and
remapping the entire table into memory. I guess with smaller boxes, we
never had ACPI tables that crossed page boundaries, so it was never
noticed. On this box however, we start calculating the table checksum
and run off the page causing the system to reboot. ouch!

Anyway, here is a patch that fixes the spot I was having troubles with,
along with two other instances of this mistake. Andy, you may have some
stylistic complaints, but something to this effect is needed.

thanks
-john

PS: Big thanks to James Cleverdon for confirming the cause of the
problem and pointing out the other instances of it as well.=20

diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Wed Feb 19 19:46:04 2003
+++ b/drivers/acpi/tables.c	Wed Feb 19 19:46:04 2003
@@ -379,6 +379,7 @@
=20
 		sdt.pa =3D ((struct acpi20_table_rsdp*)rsdp)->xsdt_address;
=20
+		/* map in just the header */
 		header =3D (struct acpi_table_header *)
 			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));
=20
@@ -387,6 +388,15 @@
 			return -ENODEV;
 		}
=20
+		/* remap in the entire table before processing */
+		mapped_xsdt =3D (struct acpi_table_xsdt *)
+			__acpi_map_table(sdt.pa, header->length);
+		if (!mapped_xsdt) {
+			printk(KERN_WARNING PREFIX "Unable to map XSDT\n");
+			return -ENODEV;
+		}
+		header =3D &mapped_xsdt->header;
+
 		if (strncmp(header->signature, "XSDT", 4)) {
 			printk(KERN_WARNING PREFIX "XSDT signature incorrect\n");
 			return -ENODEV;
@@ -404,15 +414,6 @@
 			sdt.count =3D ACPI_MAX_TABLES;
 		}
=20
-		mapped_xsdt =3D (struct acpi_table_xsdt *)
-			__acpi_map_table(sdt.pa, header->length);
-		if (!mapped_xsdt) {
-			printk(KERN_WARNING PREFIX "Unable to map XSDT\n");
-			return -ENODEV;
-		}
-
-		header =3D &mapped_xsdt->header;
-
 		for (i =3D 0; i < sdt.count; i++)
 			sdt.entry[i].pa =3D (unsigned long) mapped_xsdt->entry[i];
 	}
@@ -425,6 +426,7 @@
=20
 		sdt.pa =3D rsdp->rsdt_address;
=20
+		/* map in just the header */
 		header =3D (struct acpi_table_header *)
 			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));
 		if (!header) {
@@ -432,6 +434,15 @@
 			return -ENODEV;
 		}
=20
+		/* remap in the entire table before processing */
+		mapped_rsdt =3D (struct acpi_table_rsdt *)
+			__acpi_map_table(sdt.pa, header->length);
+		if (!mapped_rsdt) {
+			printk(KERN_WARNING PREFIX "Unable to map RSDT\n");
+			return -ENODEV;
+		}
+		header =3D &mapped_rsdt->header;
+
 		if (strncmp(header->signature, "RSDT", 4)) {
 			printk(KERN_WARNING PREFIX "RSDT signature incorrect\n");
 			return -ENODEV;
@@ -449,15 +460,6 @@
 			sdt.count =3D ACPI_MAX_TABLES;
 		}
=20
-		mapped_rsdt =3D (struct acpi_table_rsdt *)
-			__acpi_map_table(sdt.pa, header->length);
-		if (!mapped_rsdt) {
-			printk(KERN_WARNING PREFIX "Unable to map RSDT\n");
-			return -ENODEV;
-		}
-
-		header =3D &mapped_rsdt->header;
-
 		for (i =3D 0; i < sdt.count; i++)
 			sdt.entry[i].pa =3D (unsigned long) mapped_rsdt->entry[i];
 	}
@@ -471,12 +473,20 @@
=20
 	for (i =3D 0; i < sdt.count; i++) {
=20
+		/* map in just the header */
 		header =3D (struct acpi_table_header *)
 			__acpi_map_table(sdt.entry[i].pa,
 				sizeof(struct acpi_table_header));
 		if (!header)
 			continue;
=20
+		/* remap in the entire table before processing */
+		header =3D (struct acpi_table_header *)
+			__acpi_map_table(sdt.entry[i].pa,
+				header->length);
+		if (!header)
+			continue;
+	              =20
 		acpi_table_print(header, sdt.entry[i].pa);
=20
 		if (acpi_table_compute_checksum(header, header->length)) {



--=-0SUXJapTK3JxxN4d+1i+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+VFPeMDAZ/OmgHwwRAjWhAJ9hOQ6w6KKeQMnw7GAEPzYH4Kae5wCZAax7
gKhfaeL5q7rtqJvi1f3Leuc=
=Wmh0
-----END PGP SIGNATURE-----

--=-0SUXJapTK3JxxN4d+1i+--

