Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVK1JxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVK1JxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 04:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVK1JxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 04:53:03 -0500
Received: from schokokeks.org ([193.201.54.11]:59348 "EHLO schokokeks.org")
	by vger.kernel.org with ESMTP id S1750927AbVK1JxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 04:53:01 -0500
From: "Hanno =?utf-8?q?B=C3=B6ck?=" <mail@hboeck.de>
To: linux-kernel@vger.kernel.org
Subject: Patch to fix asus_acpi on Samsung P30/P35
Date: Mon, 28 Nov 2005 10:52:49 +0100
User-Agent: KMail/1.8.3
Cc: torvalds@osdl.org, acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200511281052.51775.mail@hboeck.de>
Content-Type: multipart/signed;
  boundary="nextPart1651059.8ZZAXQe3Gb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1651059.8ZZAXQe3Gb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46or a while now asus_acpi is broken on samsung laptops (causes oopses on=
=20
module loading and kernel panic if compiled into the kernel).

The attached Patch (by Christian Aichinger, so credits to him) fixes this.=
=20
Please apply this before 2.6.15.

Patch:


diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
=2D-- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1006,6 +1006,24 @@ static int __init asus_hotk_get_info(voi
 	}
=20
 	model =3D (union acpi_object *)buffer.pointer;
+
+	/* INIT on Samsung's P35 returns an integer, possible return
+	 * values are tested below */
+	if (model->type =3D=3D ACPI_TYPE_INTEGER) {
+		if (model->integer.value =3D=3D -1 ||
+			model->integer.value =3D=3D 0x58 ||
+			model->integer.value =3D=3D 0x38) {
+			hotk->model =3D P30;
+			printk(KERN_NOTICE
+				       "  Samsung P35 detected, supported\n");
+			goto out_known;
+		} else {
+			printk(KERN_WARNING=20
+				"  unknown integer returned by INIT\n");
+			goto out_unknown;
+		}
+	}
+
 	if (model->type =3D=3D ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ",
 		       model->string.pointer);
@@ -1057,9 +1075,7 @@ static int __init asus_hotk_get_info(voi
 		hotk->model =3D L5x;
=20
 	if (hotk->model =3D=3D END_MODEL) {
=2D		printk("unsupported, trying default values, supply the "
=2D		       "developers with your DSDT\n");
=2D		hotk->model =3D M2E;
+		goto out_unknown;
 	} else {
 		printk("supported\n");
 	}
@@ -1088,6 +1104,15 @@ static int __init asus_hotk_get_info(voi
 	acpi_os_free(model);
=20
 	return AE_OK;
+
+out_unknown:
+	printk(KERN_WARNING "  unsupported, trying default values, "
+			"supply the developers with your DSDT\n");
+	hotk->model =3D M2E;
+out_known:
+	hotk->methods =3D &model_conf[hotk->model];
+	acpi_os_free(model);
+	return AE_OK;
 }
=20
 static int __init asus_hotk_check(void)

--nextPart1651059.8ZZAXQe3Gb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDitNzr2QksT29OyARAsSfAJ93wwbxn1vLMHxqLrKA69HWXsAxbwCffynF
9KC9IjGNLJjk0blW4lhEtKc=
=xvld
-----END PGP SIGNATURE-----

--nextPart1651059.8ZZAXQe3Gb--
