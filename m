Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbUJ0TcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUJ0TcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbUJ0Suu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:50:50 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:11753 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S262529AbUJ0SoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:44:22 -0400
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
	initramfs image updates [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20041026231514.GA3285@mars.ravnborg.org>
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041026221216.GA30918@mars.ravnborg.org>
	 <1098824849.12420.60.camel@nosferatu.lan>
	 <20041026231514.GA3285@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YC4QYZxMNJNwd6Bv1dYd"
Date: Wed, 27 Oct 2004 20:44:05 +0200
Message-Id: <1098902645.12420.75.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YC4QYZxMNJNwd6Bv1dYd
Content-Type: multipart/mixed; boundary="=-OGduxpFI7wozui5Qf/lT"


--=-OGduxpFI7wozui5Qf/lT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-27 at 01:15 +0200, Sam Ravnborg wrote:
> On Tue, Oct 26, 2004 at 11:07:29PM +0200, Martin Schlemmer [c] wrote:
> =20
> > > Current patch will not rebuild image if one of the
> > > programs listed are changed. But it should give a good
> > > foundation to do so.
> > >=20
> >=20
> > I will see if I get the time to get that implemented elegantly if
> > you do not beat me to it.
>=20
> Something as simple as putting relevant timestamps in the generated
> file as coment should do it.
> If timestamp differ then initramfs_list will be updated and initramfs
> image will be remade.
>=20
> All changes isolated to gen_initramfs_list.sh.
> Care to give that a spin?
>=20

How about below?  Works as expected.  I am open to suggestions short of
coding a util to print numeric mtimes besides find, but for the life of
me could not think of another way ...


Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

diff -uprN -X dontdiff linux-2.6.9.orig/scripts/gen_initramfs_list.sh linux=
-2.6.9/scripts/gen_initramfs_list.sh
--- linux-2.6.9.orig/scripts/gen_initramfs_list.sh	2004-10-27 20:06:47.0439=
99448 +0200
+++ linux-2.6.9/scripts/gen_initramfs_list.sh	2004-10-27 20:34:39.121804984=
 +0200
@@ -37,6 +37,18 @@ filetype() {
 	return 0
 }
=20
+print_mtime() {
+	local argv1=3D"$1"
+	local my_mtime=3D"0"
+
+	if [ -e "${argv1}" ]; then
+		my_mtime=3D$(find "${argv1}" -printf "%T@\n" | sort -r | head -n 1)
+	fi
+=09
+	echo "# Last modified: ${my_mtime}"
+	echo
+}
+
 parse() {
 	local location=3D"$1"
 	local name=3D"${location/${srcdir}//}"
@@ -77,16 +89,19 @@ parse() {
 	return 0
 }
=20
-if [ -z $1 ]; then
+if [ -z "$1" ]; then
 	simple_initramfs
-elif [ -f $1 ]; then
-	cat $1
-elif [ -d $1 ]; then
+elif [ -f "$1" ]; then
+	print_mtime "$1"
+	cat "$1"
+elif [ -d "$1" ]; then
 	srcdir=3D$(echo "$1" | sed -e 's://*:/:g')
 	dirlist=3D$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
=20
 	# If $dirlist is only one line, then the directory is empty
 	if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
+		print_mtime "$1"
+	=09
 		echo "${dirlist}" | \
 		while read x; do
 			parse ${x}



--=20
Martin Schlemmer


--=-OGduxpFI7wozui5Qf/lT
Content-Disposition: attachment; filename=initramfs_list-regen-on-mtime-v1.patch
Content-Type: text/x-patch; name=initramfs_list-regen-on-mtime-v1.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS5vcmlnL3NjcmlwdHMvZ2VuX2luaXRy
YW1mc19saXN0LnNoIGxpbnV4LTIuNi45L3NjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0LnNoDQot
LS0gbGludXgtMi42Ljkub3JpZy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaAkyMDA0LTEw
LTI3IDIwOjA2OjQ3LjA0Mzk5OTQ0OCArMDIwMA0KKysrIGxpbnV4LTIuNi45L3NjcmlwdHMvZ2Vu
X2luaXRyYW1mc19saXN0LnNoCTIwMDQtMTAtMjcgMjA6MzQ6MzkuMTIxODA0OTg0ICswMjAwDQpA
QCAtMzcsNiArMzcsMTggQEAgZmlsZXR5cGUoKSB7DQogCXJldHVybiAwDQogfQ0KIA0KK3ByaW50
X210aW1lKCkgew0KKwlsb2NhbCBhcmd2MT0iJDEiDQorCWxvY2FsIG15X210aW1lPSIwIg0KKw0K
KwlpZiBbIC1lICIke2FyZ3YxfSIgXTsgdGhlbg0KKwkJbXlfbXRpbWU9JChmaW5kICIke2FyZ3Yx
fSIgLXByaW50ZiAiJVRAXG4iIHwgc29ydCAtciB8IGhlYWQgLW4gMSkNCisJZmkNCisJDQorCWVj
aG8gIiMgTGFzdCBtb2RpZmllZDogJHtteV9tdGltZX0iDQorCWVjaG8NCit9DQorDQogcGFyc2Uo
KSB7DQogCWxvY2FsIGxvY2F0aW9uPSIkMSINCiAJbG9jYWwgbmFtZT0iJHtsb2NhdGlvbi8ke3Ny
Y2Rpcn0vL30iDQpAQCAtNzcsMTYgKzg5LDE5IEBAIHBhcnNlKCkgew0KIAlyZXR1cm4gMA0KIH0N
CiANCi1pZiBbIC16ICQxIF07IHRoZW4NCitpZiBbIC16ICIkMSIgXTsgdGhlbg0KIAlzaW1wbGVf
aW5pdHJhbWZzDQotZWxpZiBbIC1mICQxIF07IHRoZW4NCi0JY2F0ICQxDQotZWxpZiBbIC1kICQx
IF07IHRoZW4NCitlbGlmIFsgLWYgIiQxIiBdOyB0aGVuDQorCXByaW50X210aW1lICIkMSINCisJ
Y2F0ICIkMSINCitlbGlmIFsgLWQgIiQxIiBdOyB0aGVuDQogCXNyY2Rpcj0kKGVjaG8gIiQxIiB8
IHNlZCAtZSAnczovLyo6LzpnJykNCiAJZGlybGlzdD0kKGZpbmQgIiR7c3JjZGlyfSIgLXByaW50
ZiAiJXAgJW0gJVUgJUdcbiIgMj4vZGV2L251bGwpDQogDQogCSMgSWYgJGRpcmxpc3QgaXMgb25s
eSBvbmUgbGluZSwgdGhlbiB0aGUgZGlyZWN0b3J5IGlzIGVtcHR5DQogCWlmIFsgICIkKGVjaG8g
IiR7ZGlybGlzdH0iIHwgd2MgLWwpIiAtZ3QgMSBdOyB0aGVuDQorCQlwcmludF9tdGltZSAiJDEi
DQorCQkNCiAJCWVjaG8gIiR7ZGlybGlzdH0iIHwgXA0KIAkJd2hpbGUgcmVhZCB4OyBkbw0KIAkJ
CXBhcnNlICR7eH0NCg==


--=-OGduxpFI7wozui5Qf/lT--

--=-YC4QYZxMNJNwd6Bv1dYd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBf+x1qburzKaJYLYRAhvBAJsF8DTruSvcCvsJUIbBnb7rGCv4YQCgmv4C
Ny2Ap2K3VbMWUpxYJzRYUNk=
=uZ/r
-----END PGP SIGNATURE-----

--=-YC4QYZxMNJNwd6Bv1dYd--

