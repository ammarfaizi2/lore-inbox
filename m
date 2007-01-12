Return-Path: <linux-kernel-owner+w=401wt.eu-S932373AbXALRqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbXALRqv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbXALRqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:46:51 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:1434 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbXALRqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:46:50 -0500
Message-ID: <45A7C95F.6020507@imap.cc>
Date: Fri, 12 Jan 2007 18:46:07 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: spurious sparse warnings from linux/aio.h
References: <20070111222627.66bb75ab.akpm@osdl.org> <45A77726.2030605@imap.cc> <20070112131120.GA22364@in.ibm.com>
In-Reply-To: <20070112131120.GA22364@in.ibm.com>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDEB2CFDA035AD1237B3D8632"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEB2CFDA035AD1237B3D8632
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Suparna Bhattacharya schrieb:
> On Fri, Jan 12, 2007 at 12:55:18PM +0100, Tilman Schmidt wrote:
[...]
>> causes a sparse warning:
>>=20
>> > include/linux/sched.h:1313:29: warning: symbol '__mptr' shadows an e=
arlier one
>> > include/linux/sched.h:1313:29: originally declared here
>>=20
>> for every source file referencing <linux/sched.h>.
>> Could that be avoided please?
>=20
> So ... the nested container_of() is a problem ? I guess changing
> io_wait_to_kiocb() to be an inline function instead of a macro could he=
lp ?

So it would seem. The following experimental patch indeed makes
the warnings disappear:

--- linux-2.6.20-rc4-mm1-orig/include/linux/aio.h	2007-01-12 10:33:12.000=
000000 +0100
+++ linux-2.6.20-rc4-mm1-work/include/linux/aio.h	2007-01-12 18:31:16.000=
000000 +0100
@@ -243,8 +243,12 @@

-#define io_wait_to_kiocb(io_wait) container_of(container_of(io_wait,	\
-	struct wait_bit_queue, wait), struct kiocb, ki_wait)
+static inline struct kiocb *io_wait_to_kiocb(wait_queue_t *io_wait)
+{
+	struct wait_bit_queue *wbqptr =3D
+		container_of(io_wait, struct wait_bit_queue, wait);
+	return container_of(wbqptr, struct kiocb, ki_wait);
+}

 #include <linux/aio_abi.h>


Compile checked only - please review.

Thanks
Tilman

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigDEB2CFDA035AD1237B3D8632
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFp8lnMdB4Whm86/kRAigtAJ4zXFFqoUtnpui+ASQHbYm1U5RQlQCdG9z6
qVazGce5uSprdI7h1lrJbq4=
=9GYn
-----END PGP SIGNATURE-----

--------------enigDEB2CFDA035AD1237B3D8632--
