Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264721AbUEEXyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264721AbUEEXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264724AbUEEXyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:54:15 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:25614 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S264721AbUEEXyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:54:04 -0400
Subject: [PATCH] bug fix for megaraid memory leak and DOS against 2.6.5
From: Paul Wagland <paul@wagland.net>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux SCSI mailing list <linux-scsi@vger.kernel.org>, torvalds@osdl.org
Cc: James.Bottomley@HansenPartnership.com, Atul Mukker <atulm@lsil.com>,
       Lester Hightower <hightowe@10east.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2RfBJIj8oWHGAPIXsL/h"
Message-Id: <1083801216.2058.9.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 01:53:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2RfBJIj8oWHGAPIXsL/h
Content-Type: multipart/mixed; boundary="=-wajVShw3KHy3YIdthTkf"


--=-wajVShw3KHy3YIdthTkf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

Well, I was going through the code looking for bits and pieces to pull
across into the new LSI Logic beta megaraid driver /sys fs code and came
across this one.

LSI Logic have already fixed this issue for the 2.4 driver, and the new
beta driver does not use the /proc filesystem at all, so no problem
there.

The problem is that resources are not freed upon certain error
conditions in the in-kernel megaraid driver, to quote from Lester
Hightower (who originally found the issue):

---
The problem occurs only in the circumstance where one reads one of the
/proc/megaraid/hba<X>/diskdrives-ch<N> files where the card <X> does not
have channel <N> on it.  Most people would likely not notice this leak
in normal operation, but due to the way that we monitor our MegaRaid
cards in our company (we read these /proc entries every 180s) so we
found the leak rather quickly, and unpleasantly (when your kernel eats
all your RAM).
---

I leave it up to your own imagination as to how to DOS a machine using
this :-)

Anyway, here is the patch, compiled and tested OK for me.

Cheers,
Paul

--=-wajVShw3KHy3YIdthTkf
Content-Disposition: attachment; filename=patch.fix_megaraid_memleak
Content-Type: text/x-patch; name=patch.fix_megaraid_memleak; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLXJlY3Vyc2l2ZSAtLXVuaWZpZWQgbGludXgtMi42LjYtcmMzL2RyaXZlcnMvc2NzaS9t
ZWdhcmFpZC5jIGxpbnV4LTIuNi42LXJjMy5uZXcvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMNCi0t
LSBsaW51eC0yLjYuNi1yYzMvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMJMjAwNC0wNC0wNCAwNToz
NjoxMi4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuNi1yYzMubmV3L2RyaXZlcnMvc2Nz
aS9tZWdhcmFpZC5jCTIwMDQtMDUtMDQgMDE6MTk6MTUuMDAwMDAwMDAwICswMjAwDQpAQCAtMjU3
MiwyMSArMjU3MiwxNSBAQA0KIAl9DQogDQogCWlmKCAoaW5xdWlyeSA9IG1lZ2FfYWxsb2NhdGVf
aW5xdWlyeSgmZG1hX2hhbmRsZSwgcGRldikpID09IE5VTEwgKSB7DQotCQlmcmVlX2xvY2FsX3Bk
ZXYocGRldik7DQotCQlyZXR1cm4gbGVuOw0KKwkJZ290byBmcmVlX3BkZXY7DQogCX0NCiANCiAJ
aWYoIG1lZ2FfYWRhcGlucShhZGFwdGVyLCBkbWFfaGFuZGxlKSAhPSAwICkgew0KLQ0KIAkJbGVu
ID0gc3ByaW50ZihwYWdlLCAiQWRhcHRlciBpbnF1aXJ5IGZhaWxlZC5cbiIpOw0KIA0KIAkJcHJp
bnRrKEtFUk5fV0FSTklORyAibWVnYXJhaWQ6IGlucXVpcnkgZmFpbGVkLlxuIik7DQogDQotCQlt
ZWdhX2ZyZWVfaW5xdWlyeShpbnF1aXJ5LCBkbWFfaGFuZGxlLCBwZGV2KTsNCi0NCi0JCWZyZWVf
bG9jYWxfcGRldihwZGV2KTsNCi0NCi0JCXJldHVybiBsZW47DQorCQlnb3RvIGZyZWVfaW5xdWly
eTsNCiAJfQ0KIA0KIA0KQEAgLTI1OTUsMTEgKzI1ODksNyBAQA0KIAlpZiggc2NzaV9pbnEgPT0g
TlVMTCApIHsNCiAJCWxlbiA9IHNwcmludGYocGFnZSwgIm1lbW9yeSBub3QgYXZhaWxhYmxlIGZv
ciBzY3NpIGlucS5cbiIpOw0KIA0KLQkJbWVnYV9mcmVlX2lucXVpcnkoaW5xdWlyeSwgZG1hX2hh
bmRsZSwgcGRldik7DQotDQotCQlmcmVlX2xvY2FsX3BkZXYocGRldik7DQotDQotCQlyZXR1cm4g
bGVuOw0KKwkJZ290byBmcmVlX2lucXVpcnk7DQogCX0NCiANCiAJaWYoIGFkYXB0ZXItPmZsYWcg
JiBCT0FSRF80MExEICkgew0KQEAgLTI2MTIsNyArMjYwMiw5IEBADQogDQogCW1heF9jaGFubmVs
cyA9IGFkYXB0ZXItPnByb2R1Y3RfaW5mby5uY2hhbm5lbHM7DQogDQotCWlmKCBjaGFubmVsID49
IG1heF9jaGFubmVscyApIHJldHVybiAwOw0KKwlpZiggY2hhbm5lbCA+PSBtYXhfY2hhbm5lbHMg
KSB7DQorCQlnb3RvIGZyZWVfcGNpOw0KKwl9DQogDQogCWZvciggdGd0ID0gMDsgdGd0IDw9IE1B
WF9UQVJHRVQ7IHRndCsrICkgew0KIA0KQEAgLTI2NzcsMTAgKzI2NjksMTEgQEANCiAJCWxlbiAr
PSBtZWdhX3ByaW50X2lucXVpcnkocGFnZStsZW4sIHNjc2lfaW5xKTsNCiAJfQ0KIA0KK2ZyZWVf
cGNpOg0KIAlwY2lfZnJlZV9jb25zaXN0ZW50KHBkZXYsIDI1Niwgc2NzaV9pbnEsIHNjc2lfaW5x
X2RtYV9oYW5kbGUpOw0KLQ0KK2ZyZWVfaW5xdWlyeToNCiAJbWVnYV9mcmVlX2lucXVpcnkoaW5x
dWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQotDQorZnJlZV9wZGV2Og0KIAlmcmVlX2xvY2FsX3Bk
ZXYocGRldik7DQogDQogCXJldHVybiBsZW47DQo=

--=-wajVShw3KHy3YIdthTkf--

--=-2RfBJIj8oWHGAPIXsL/h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmX6Atch0EvEFvxURAnVhAKDD5OU1jF9j+L57bUdkK0CdX0pNhgCgv2IW
0Appd6mdpGvoKZpKgHyyQKg=
=WbKf
-----END PGP SIGNATURE-----

--=-2RfBJIj8oWHGAPIXsL/h--

