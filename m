Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTEXOYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTEXOYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:24:09 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:14050 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262019AbTEXOYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:24:03 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Error during compile of 2.5.69-mm8
Date: Sat, 24 May 2003 16:36:59 +0200
User-Agent: KMail/1.5.9
References: <200305230327.57985.schlicht@uni-mannheim.de> <200305230538.38946.schlicht@uni-mannheim.de> <20030522.213217.27796203.davem@redhat.com>
In-Reply-To: <20030522.213217.27796203.davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_TO4z+5k460j6U36";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305241637.07395.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_TO4z+5k460j6U36
Content-Type: multipart/mixed;
  boundary="Boundary-01=_LO4z+OmqhAoH0Et"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_LO4z+OmqhAoH0Et
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

On Friday, 23 May 2003 06:32, David S. Miller wrote:
>    From: Thomas Schlichter <schlicht@uni-mannheim.de>
>    Date: Fri, 23 May 2003 05:38:38 +0200
>
>    OK, done...
>
> I already did it myself and sent the changes to Linus, he should pick
> them up by tomorrow.

Well it seems you missed one file that my patch would have cought. So here =
is=20
a seperate diff to fix drivers/usb/media/pwc-if.c, too.

I also attached a patch that fixes the SET_MODULE_OWNER thing for net/ipv4/=
 by=20
using static initializers instead of performing the assignment at runtime.=
=20
This should be no problem here, as SET_MODULE_OWNER was called from static=
=20
init functions once. I also made 'esp4_init' static to be safe. This functi=
on=20
is not called from anywhere else in the whole kernel tree. (That's whar gre=
p=20
says)

Both patches should cleanly apply to current bk.
=46or me it compiles and runs without any problems...

Best regards
  Thomas Schlichter

--Boundary-01=_LO4z+OmqhAoH0Et
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="missed_wrong_SET_MODULE_OWNER.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="missed_wrong_SET_MODULE_OWNER.diff"

=2D-- linux-2.5.69-bk/drivers/usb/media/pwc-if.c.orig	Sat May 24 16:12:40 2=
003
+++ linux-2.5.69-bk/drivers/usb/media/pwc-if.c	Sat May 24 16:13:43 2003
@@ -1804,7 +1804,7 @@
 	}
 	memcpy(vdev, &pwc_template, sizeof(pwc_template));
 	strcpy(vdev->name, name);
=2D	SET_MODULE_OWNER(vdev);
+	vdev->owner =3D THIS_MODULE;
 	pdev->vdev =3D vdev;
 	vdev->priv =3D pdev;
=20

--Boundary-01=_LO4z+OmqhAoH0Et
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="better_wrong_SET_MODULE_OWNER.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="better_wrong_SET_MODULE_OWNER.diff"

=2D-- linux-2.5.69-bk/net/ipv4/esp.c.orig	Sat May 24 16:14:29 2003
+++ linux-2.5.69-bk/net/ipv4/esp.c	Sat May 24 16:13:43 2003
@@ -567,7 +567,7 @@
 	.no_policy	=3D	1,
 };
=20
=2Dint __init esp4_init(void)
+static int __init esp4_init(void)
 {
 	struct xfrm_decap_state decap;
=20
@@ -578,7 +578,6 @@
 		decap_data_too_small();
 	}
=20
=2D	esp_type.owner =3D THIS_MODULE;
 	if (xfrm_register_type(&esp_type, AF_INET) < 0) {
 		printk(KERN_INFO "ip esp init: can't add xfrm type\n");
 		return -EAGAIN;
=2D-- linux-2.5.69-bk/net/ipv4/ipcomp.c.orig	Sat May 24 16:15:04 2003
+++ linux-2.5.69-bk/net/ipv4/ipcomp.c	Sat May 24 16:13:43 2003
@@ -385,6 +385,7 @@
 static struct xfrm_type ipcomp_type =3D
 {
 	.description	=3D "IPCOMP4",
+	.owner		=3D THIS_MODULE,
 	.proto	     	=3D IPPROTO_COMP,
 	.init_state	=3D ipcomp_init_state,
 	.destructor	=3D ipcomp_destroy,
@@ -400,7 +401,6 @@
=20
 static int __init ipcomp4_init(void)
 {
=2D	ipcomp_type.owner =3D THIS_MODULE;
 	if (xfrm_register_type(&ipcomp_type, AF_INET) < 0) {
 		printk(KERN_INFO "ipcomp init: can't add xfrm type\n");
 		return -EAGAIN;
=2D-- linux-2.5.69-bk/net/ipv4/xfrm4_tunnel.c.orig	Sat May 24 16:15:34 2003
+++ linux-2.5.69-bk/net/ipv4/xfrm4_tunnel.c	Sat May 24 16:13:43 2003
@@ -215,6 +215,7 @@
=20
 static struct xfrm_type ipip_type =3D {
 	.description	=3D "IPIP",
+	.owner		=3D THIS_MODULE,
 	.proto	     	=3D IPPROTO_IPIP,
 	.init_state	=3D ipip_init_state,
 	.destructor	=3D ipip_destroy,
@@ -229,7 +230,6 @@
=20
 static int __init ipip_init(void)
 {
=2D	ipip_type.owner =3D THIS_MODULE;
 	if (xfrm_register_type(&ipip_type, AF_INET) < 0) {
 		printk(KERN_INFO "ipip init: can't add xfrm type\n");
 		return -EAGAIN;

--Boundary-01=_LO4z+OmqhAoH0Et--

--Boundary-03=_TO4z+5k460j6U36
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+z4OTYAiN+WRIZzQRApWAAJ9boWJe8RUI2hUlu14MwRz5ypKtdQCg7EM5
j/86bTIeCO1n0tm2nlMf0RA=
=GF+q
-----END PGP SIGNATURE-----

--Boundary-03=_TO4z+5k460j6U36--
