Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTEWAyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTEWAyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:54:03 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:8088 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263535AbTEWAyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:54:01 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Error during compile of 2.5.69-mm8
Date: Fri, 23 May 2003 03:06:45 +0200
User-Agent: KMail/1.5.9
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
References: <200305230147.00730.schlicht@uni-mannheim.de> <200305230213.39460.schlicht@uni-mannheim.de> <20030522.172304.08334616.davem@redhat.com>
In-Reply-To: <20030522.172304.08334616.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_uQXz+t6puIURr+W";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305230306.54981.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_uQXz+t6puIURr+W
Content-Type: multipart/mixed;
  boundary="Boundary-01=_lQXz+sx/CGwmuE6"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_lQXz+sx/CGwmuE6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

On May 23, David S. Miller wrote:
>    From: Thomas Schlichter <schlicht@uni-mannheim.de>
>    Date: Fri, 23 May 2003 02:13:34 +0200
>
>    > Therefore, it was a complete error for anyone else to start using th=
is
>    > macro for other structures.
>
>    So nobody should better use THIS_MODULE?!
>
> No, it is exactly what they should use.
>
> They should avoid using SET_MODULE_OWNER.

This is clear to me, of course, it should have been just a very extreme=20
example...

>    For ME and many other driver developers SET_MODULE_OWNER does not belo=
ng
> to netdevice, it belongs to the module infrastructure!
>
> Then by changing SET_MODULE_OWNER you will break source backwards
> compatability for every single network device driver out there,
> something I was explicitly trying to avoid.

OK, now I see clearer...
What you did broke everything but netdevices and what I did broke nothing b=
ut=20
netdevices... So I attached a very small patch that will help braking=20
nothing... ;-)

> SET_MODULE_OWNER() is a bogus interface because it is typeless.
>
> Therefore I suggest that you create macros specific to your individual
> structures, and use these to achieve 2.4.x/2.5.x build compatability
> in setting the ->owner field of such structs.

That is a good idea, but how should we get rid off this when it is used ove=
r=20
and over??

Best regards
   Thomas Schlichter

--Boundary-01=_lQXz+sx/CGwmuE6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="SET_MODULE_OWNER.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="SET_MODULE_OWNER.diff"

=2D-- linux-2.5.69-bk15/include/linux/module.h.orig	Fri May 23 02:42:07 2003
+++ linux-2.5.69-bk15/include/linux/module.h	Fri May 23 02:45:39 2003
@@ -438,6 +438,10 @@
=20
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:"=
 #x)
=20
+#ifndef SET_MODULE_OWNER
+#define SET_MODULE_OWNER(dev) ((dev)->owner =3D THIS_MODULE)
+#endif
+
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
=20
 struct obsolete_modparm {
=2D-- linux-2.5.69-bk15/include/linux/netdevice.h.orig	Fri May 23 02:48:53 =
2003
+++ linux-2.5.69-bk15/include/linux/netdevice.h	Fri May 23 02:49:06 2003
@@ -451,6 +451,7 @@
 	struct kobject		stats_kobj;
 };
=20
+#undef SET_MODULE_OWNER
 #define SET_MODULE_OWNER(dev) do { } while (0)
 /* Set the sysfs physical device reference for the network logical device
  * if set prior to registration will cause a symlink during initialization.

--Boundary-01=_lQXz+sx/CGwmuE6--

--Boundary-03=_uQXz+t6puIURr+W
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+zXQuYAiN+WRIZzQRAk7qAKC102tVsKGELrQ8DLjuPz+LSuAG9wCePuvt
1/nMqx1NsbZSvFE/OnQH32I=
=zDpE
-----END PGP SIGNATURE-----

--Boundary-03=_uQXz+t6puIURr+W--
