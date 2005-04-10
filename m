Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVDJJQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVDJJQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVDJJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:16:37 -0400
Received: from postman4.arcor-online.net ([151.189.20.158]:27895 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261446AbVDJJQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:16:32 -0400
Date: Sun, 10 Apr 2005 11:16:25 +0200
To: linux-kernel@vger.kernel.org
Subject: unregister_netdevice(): negative refcnt, suggest patch against 2.6.11
Message-ID: <20050410091625.GA29283@palmen.homeip.net>
Mail-Followup-To: fmp, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
Organization: University of Karlsruhe, Germany
X-Face: K~w3A&?OT;vit*S.e$nb*yhXg?1~W$[{'\ac!fDp)'/c2g@rs-=Rm|%qi`!)J4QmlC2$x-' ^gR/WY=6e$E#PY'(~.5%U"h[yh.C^AK^8%t=tuq`8s`'+a]15|Bo&Uk>PD~Cu:_cJ5B!oVU0*3A!hH dUPeD{&b5hpczhAh&O0oeH.U@[|inep"(ye[R^7_I?8of&8eF\hIAZbRV3(D>n)1\^yjoy}\
User-Agent: Mutt/1.5.6+20040907i
From: Felix Palmen <fmp@palmen.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi lkml-members,

I recently had a problem with appletalk. After starting atalkd on a TAP
interface and stopping it later, unregister_netdevice() just stated
| unregister_netdevice: waiting for tap0 to become free. Usage count =3D -1

So I assume there is a problem in the appletalk code, but I didn't try
reproducing that on other systems so far.

I changed my kernel to "correct" a negative refcnt to 0 and that kind
of fixes the problem. I'm not sure whether this could break anything,
but certainly waiting for a device to become free is no use when there
is a negative number of users, so I think it would be better to allow
the system to shut down cleanly in this case.

Here's m suggestion:

#v+
--- linux-2.6.11-orig/net/core/dev.c 2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11/net/core/dev.c    2005-04-09 16:44:42.000000000 +0200
@@ -2876,7 +2876,7 @@
	unsigned long rebroadcast_time, warning_time;

	rebroadcast_time =3D warning_time =3D jiffies;
-	while (atomic_read(&dev->refcnt) !=3D 0) {
+	while (atomic_read(&dev->refcnt) > 0) {
		if (time_after(jiffies, rebroadcast_time + 1 * HZ)) {
			rtnl_shlock();

@@ -2910,6 +2910,13 @@
			warning_time =3D jiffies;
		}
	}
+	if (atomic_read(&dev->refcnt) !=3D 0) {
+		printk(KERN_ERR "unregister_netdevice: "
+			"%s has negative refcnt (%d). "
+			"This should never happen! Setting refcnt to 0.\n",
+			dev->name, atomic_read(&dev->refcnt));
+		atomic_set(&dev->refcnt, 0);
+	}
 }

 /* The sequence is:
#v-

Greets, Felix

PS: Please note I'm not subscribed to lkml and CC me in replies, thanks.

--=20
 | /"\   ASCII Ribbon   | Felix M. Palmen (Zirias)    http://zirias.ath.cx/=
 |
 | \ / Campaign Against | fmp@palmen.homeip.net      encrypted mail welcome=
 |
 |  X    HTML In Mail   | PGP key: http://zirias.ath.cx/pub.txt            =
 |
 | / \     And News     | ED9B 62D0 BE39 32F9 2488 5D0C 8177 9D80 5ECF F683=
 |

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUBQlju6QSq+3gxG9cNAQJGWQP8CgHP74RBD7DBWS/8D1uvSbk8U2hF5Nc9
E+BgTOcFb345YCVqSPynj0cOR1ISL2eSY7NXDJjpDAxFnF5SY/cOulgqFJ3LHWJ4
kivk8uysTsVagjFjwTJd6z4rFxIwR0V4tRjFbN0BLaGtOsfwObjwKdvO6YT2tBU7
FsBwNnkifCY=
=FOmM
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
