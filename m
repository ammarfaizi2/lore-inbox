Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTJJCQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 22:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTJJCQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 22:16:54 -0400
Received: from smtp02.fuse.net ([216.68.1.133]:35209 "EHLO smtp02.fuse.net")
	by vger.kernel.org with ESMTP id S261271AbTJJCQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 22:16:50 -0400
From: Steven Michalske <michalsc@email.uc.edu>
Organization: University of Cincinnati
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7 byteorder.h  ( as you go AGAIN! )
Date: Thu, 9 Oct 2003 22:13:59 -0400
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_uXhh/QYkBMwnZ0E";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310092214.06719.michalsc@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_uXhh/QYkBMwnZ0E
Content-Type: multipart/mixed;
  boundary="Boundary-01=_nXhh/eS1OH5c9iV"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_nXhh/eS1OH5c9iV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

I am running 2.6.0-test7 and this issue is still in the kernel, I guess i'l=
l=20
have to argue for the fix yet again.

=46irst some background.

This problem was first introduced with the XFS patches back in the 2.4.21=20
series or so. and it has continued on since then. reading the list i have=20
seen many patches to attempt to fix this issue.

In my digging I have uncovered that this is because the type __u64 is guard=
ed=20
as follows

#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef __signed__ long long __s64;
typedef unsigned long long __u64;
#endif

now with these types being inside of a #ifdef i would expect any subsquent=
=20
type dependent to be #ifdefed out as well.

but in byteorder.h

This function is defined:
static inline __u64 ___arch__swab64(__u64 val)  with out any protection

Attached is my proposed patch to correct this error.

This patch is required because this file is included from the file=20
include/linux/cdrom.h=20

Which states
snip lines 17-18
 * As of Linux 2.1.x, all Linux CD-ROM application programs will use this
 * (and only this) include file.
end snip

This issuse will always occur unless we patch the file to protect the=20
___arch__swab64 function in the same fashion as its return type.

Steven Michalske
aka Hardkrash

=2D-- linux-2.6.0-test7/include/asm-i386/byteorder.h.scm  2003-10-09=20
21:52:16.727080480 -0400
+++ linux-2.6.0-test7/include/asm-i386/byteorder.h      2003-10-08=20
17:20:10.000000000 -0400
@@ -34,7 +34,7 @@
                return x;
 }

=2D
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 static inline __u64 ___arch__swab64(__u64 val)
 {
        union {
@@ -55,10 +55,11 @@
 }

 #define __arch__swab64(x) ___arch__swab64(x)
+#define __BYTEORDER_HAS_U64__
+#endif
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)

=2D#define __BYTEORDER_HAS_U64__

 #endif /* __GNUC__ */

--Boundary-01=_nXhh/eS1OH5c9iV
Content-Type: application/x-tbz;
  name="byteorder.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="byteorder.tar.bz2"

QlpoOTFBWSZTWaY4P14AAbl/hMowAEBpf//4f+ee8P/v/+oEAIAIUAQ+2jm7ruxjoAwJUjTIT1T0
HqjI9I9Ahk9TQZGTTCZBhGQ00w1MJMI0KYQAaDIaGgAAABiGgJTSBAUzTTQTRAaA0AAAAAGnqBwD
CMJpiGAQDIAYRpkyYRgIaCSQEnppMqeUemSeU0DQyANADIyAM1B+p+Tk3+sYkDI4QmkJINOzrlA2
O1xkjAZJK1J13nWlBFoH7F6o4iaqeN5LhdeTTwwgkHC8h7c5OWN2w4ETWAyV+DiFi0fDW/zVELgn
YOoT0joe5C8dTFNrNOiicbRbzPynBHeqb7xw5UGTWAewDNjnGw9pN+FxR1aZ4rJF8kpIIMOfJXJX
tBkCclSHHF2nOVzHTZojjFL0mbRdFLQhX+e+6I13RD2NQHEzCH6ZazHbLNUOGlM+1G7BWhbGA6li
EUkufVdBSeQpuRt2ceoukX0fihv47cEiRr2O0HcTudgRUFw/g78Hd8jclgIds1DvK65knJegrI8C
X+s7S8SxkwUZox8IxbXa/JSBdKg4gTAQuRElbrnREBhMfAqgn4mO4DPSyjJeMULyJ7eiJomaSRSE
BobIoOKOBRzPEiXoR4IL9iasPi2TFCgdImoWeeE8t59SEX3FezHvDEdwRgZaFCo5zRGYKl9axkWA
sTeZkyCQ/J+TgyKuUMLcCwkLQqhddUnPioeQNhaJJTSPPJHb41GfWZ8POnYdx+MQMUYCJJ9vsNaH
6Aoxqd2Bz7TKUP6XmcwwZSJpz9pniBcMjAYyGopvaRxRbQYU2ZmBlxIGTxniFaOPig3+DixInD63
U9jlYWoK2wOTjIcoE1zS5nESz8IIo+Xp2T5azXpbI11x91mYKIyYL3FJjVaz2sIvf3poISEmCyxA
+lLmYqmjmE6vYdne63Np3IoJMazbA52A77H4tNqJxeKqxlU3BcKWTpRvsVWNk43IasjUAIyoootF
YhaZCpzAdJMFcnhtMY2zEmgRDmss0kbDCOO4IGTFYChwolo84kitJJOmCcEJgfQ7i35nbkQgUzlH
M2eefFsmFA1heWBBbhEWKxMy0U0qQXbybPemybZZGgmSZJkyRNXso4xbcKmsOGzaitsFVMzwCxiM
32yxHnOKchBUQ/Tcg2oeMBr2oQdBADJDJEhCFGsTkOg8JkYM1G0jUrtSE0mHWAPfEZ1WxAz2BExm
Sz1m4iN9W8qLVbbmmxz81IkjCA6bGLBBiNM5fSB8nkW4rZu6RvI2iLisuEyV7skwlh3IwC53MJ6I
dXRloapXRKtRSEBcK46rGwcLCRNXlbBaG2aVcnUC2uZoBgyIAWD8yH9oKKogeWUTnifDPC8irxrx
XaNaHUxMJ6ht1i+7MM9smJYblqJEiBJA+rINBn4BanqHV3bWYsyirciYa0kukXckU4UJCmOD9eA=

--Boundary-01=_nXhh/eS1OH5c9iV--

--Boundary-03=_uXhh/QYkBMwnZ0E
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/hhXuJhwOdxS4dYERArEcAJ9+CQPhDE9XRjt4B3rVbjZfvv5dagCeKbgI
mN+M5dm0NvFO6O/tZ19pUw8=
=CwjE
-----END PGP SIGNATURE-----

--Boundary-03=_uXhh/QYkBMwnZ0E--

