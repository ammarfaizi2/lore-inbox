Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVCATGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVCATGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVCATGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:06:41 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:9703 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261641AbVCATGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:06:33 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050227212536.GG3120@waste.org>
References: <2.416337461@selenic.com> <200502271417.51654.agruen@suse.de>
	 <20050227212536.GG3120@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mk64tZH3MCYAv1FxVOzE"
Date: Tue, 01 Mar 2005 20:06:22 +0100
Message-Id: <1109703983.16139.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mk64tZH3MCYAv1FxVOzE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 27.02.2005, 13:25 -0800 schrieb Matt Mackall:

> Which kernel? There was an off-by-one for odd array sizes in the
> original posted version that was quickly spotted:
>=20
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4=
/2.6.11-rc4-mm1/broken-out/sort-fix.patch
>=20
> I've since tested all sizes 1 - 1000 with 100 random arrays each, so
> I'm fairly confident it's now fixed.

-	int i =3D (num/2 - 1) * size, n =3D num * size, c, r;
+	int i =3D (num/2) * size, n =3D num * size, c, r;

What's probably meant is: ((num - 1)/2) * size

`i' must cover half of the array or a little bit more (not less, in case
of odd numbers). `i' (before my patch) is the highest address to start
with, so that's why it should be ((num + 1)/2 - 1) * size or simpler:
((num - 1)/2) * size

Anyway, I was wondering, is there a specific reason you are not using
size_t for the offset variables? size is a size_t and the only purpose
of the variables i, n, c and r is to be compared or added to the start
pointer (also I think it's just ugly to cast size_t down to an int).

On system where int is 32 bit but pointers are 64 bit the compiler might
need to extend to adjust the size of the operands for the address
calculation. Right?

Since size_t is unsigned I also had to modify the two loops since I
can't check for any of the variables becoming negative. Tested with all
kinds of array sizes.

Signed-off-by: Christophe Saout <christophe@saout.de>

diff -Nur linux-2.6.11-rc4-mm1.orig/include/linux/sort.h linux-2.6.11-rc4-m=
m1/include/linux/sort.h
--- linux-2.6.11-rc4-mm1.orig/include/linux/sort.h	2005-03-01 19:45:11.0000=
00000 +0100
+++ linux-2.6.11-rc4-mm1/include/linux/sort.h	2005-03-01 19:47:13.456097896=
 +0100
@@ -5,6 +5,6 @@
=20
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp)(const void *, const void *),
-	  void (*swap)(void *, void *, int));
+	  void (*swap)(void *, void *, size_t));
=20
 #endif
diff -Nur linux-2.6.11-rc4-mm1.orig/lib/sort.c linux-2.6.11-rc4-mm1/lib/sor=
t.c
--- linux-2.6.11-rc4-mm1.orig/lib/sort.c	2005-03-01 19:46:05.000000000 +010=
0
+++ linux-2.6.11-rc4-mm1/lib/sort.c	2005-03-01 19:47:55.688677568 +0100
@@ -7,14 +7,14 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
=20
-void u32_swap(void *a, void *b, int size)
+void u32_swap(void *a, void *b, size_t size)
 {
 	u32 t =3D *(u32 *)a;
 	*(u32 *)a =3D *(u32 *)b;
 	*(u32 *)b =3D t;
 }
=20
-void generic_swap(void *a, void *b, int size)
+void generic_swap(void *a, void *b, size_t size)
 {
 	char t;
=20
@@ -44,17 +44,19 @@
=20
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp)(const void *, const void *),
-	  void (*swap)(void *, void *, int size))
+	  void (*swap)(void *, void *, size_t size))
 {
 	/* pre-scale counters for performance */
-	int i =3D (num/2) * size, n =3D num * size, c, r;
+	size_t i =3D ((num + 1)/2) * size, n =3D num * size, c, r;
=20
 	if (!swap)
 		swap =3D (size =3D=3D 4 ? u32_swap : generic_swap);
=20
 	/* heapify */
-	for ( ; i >=3D 0; i -=3D size) {
-		for (r =3D i; r * 2 < n; r  =3D c) {
+	while(i > 0) {
+		i -=3D size;
+
+		for (r =3D i; r * 2 < n; r =3D c) {
 			c =3D r * 2;
 			if (c < n - size && cmp(base + c, base + c + size) < 0)
 				c +=3D size;
@@ -65,7 +67,9 @@
 	}
=20
 	/* sort */
-	for (i =3D n - size; i >=3D 0; i -=3D size) {
+	for (i =3D n; i > 0;) {
+		i -=3D size;
+
 		swap(base, base + i, size);
 		for (r =3D 0; r * 2 < i; r =3D c) {
 			c =3D r * 2;


--=-mk64tZH3MCYAv1FxVOzE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCJL0uZCYBcts5dM0RAsngAJ9MnLJb7EEoqEuYMLK/OzgFtvdsEgCfeu8K
rj9ePV6OeY6Z6GiD6EG9YUE=
=gWRJ
-----END PGP SIGNATURE-----

--=-mk64tZH3MCYAv1FxVOzE--

