Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUE1HXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUE1HXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 03:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUE1HXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 03:23:44 -0400
Received: from mail.donpac.ru ([80.254.111.2]:34452 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263001AbUE1HXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 03:23:39 -0400
Date: Fri, 28 May 2004 11:23:36 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r - Upgrade to v2.6.6 kernel
Message-ID: <20040528072336.GD7499@pazke>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	linux-kernel@vger.kernel.org
References: <20040528.131611.28785624.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20040528.131611.28785624.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 149, 05 28, 2004 at 01:16:11PM +0900, Hirokazu Takata wrote:
> Hello,
>=20
> I would like to send the latest 2.6.6 kernel patch for=20
> the Renesas M32R processor.
>=20
> Patch information to the stock 2.6.6 kernel is placed as follows:
> - m32r architecture dependent portions (arch/m32r, include/asm-m32r)
>   http://www.linux-m32r.org/public/linux-2.6.6_m32r_20040528.arch-m32r.pa=
tch

Single megapatch (1.5 Mb in size) is not the best way to merge something in=
to Linux kernel.

Now quick look at the patch itself:

1)

diff -ruN linux-2.6.6.org/arch/m32r/drivers/8390.c linux-2.6.6/arch/m32r/dr=
ivers/8390.c
--- linux-2.6.6.org/arch/m32r/drivers/8390.c    1970-01-01 09:00:00.0000000=
00 +0900
+++ linux-2.6.6/arch/m32r/drivers/8390.c        2003-09-09 10:15:02.0000000=
00 +0900
@@ -0,0 +1 @@
+#include "../../../drivers/net/8390.c"
diff -ruN linux-2.6.6.org/arch/m32r/drivers/8390.h linux-2.6.6/arch/m32r/dr=
ivers/8390.h
--- linux-2.6.6.org/arch/m32r/drivers/8390.h    1970-01-01 09:00:00.0000000=
00 +0900
+++ linux-2.6.6/arch/m32r/drivers/8390.h        2003-09-09 10:15:02.0000000=
00 +0900
@@ -0,0 +1 @@
+#include "../../../drivers/net/8390.h"

Is this really needed ?

2) File arch/m32r/drivers/mappi_ne.c contains almost complete copy of drive=
rs/net/ne.c
with lots of code probably useless for your systems (old style ISA probing,=
 ISAPnP=20
support etc.)

Also code like this is definetely unacceptable:

+#ifdef CONFIG_PLAT_MAPPI
+		outb_p(0x4b, ioaddr + EN0_DCFG);
+#elif CONFIG_PLAT_OAKS32R
+		outb_p(0x48, ioaddr + EN0_DCFG);
+#else
+		outb_p(0x49, ioaddr + EN0_DCFG);
+#endif

This fragment can be rewritten this way, with all  #ifdef mess hidden in th=
e some header file:

+		outb_p(MY_MAGIC_OFFSET, ioaddr + EN0_DCFG);

3) arch/m32r/drivers/smc91111.copying contains GPL copy. Do you really need=
 it ?
arch/m32r/drivers/smc91111.readme.txt can happily live in Documentation/net=
working.

4) Do you really need to reimplement Linux console subsystem in arch/m32r/d=
rivers/video/console.c,
arch/m32r/drivers/video/fbmem.c, arch/m32r/drivers/video/fbcon.h ?

5) Any specific reason to implement read[bwl]/write[bwl] this way:

+unsigned char _readb(unsigned long addr)
+{
+       return *(volatile unsigned char *)addr;
+}

Why not to inline them ?


6) Lots of ugly debugging #ifdef's in arch/m32r/kernel/ptrace.c

7) arch/m32r/lib/clib.c contains slightly strange abs() function which
isn't used anywhere in the patch.


Best reards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtuj4by9O0+A2ZecRAv3EAJ4i4F5HEZPrwd+9CibAxe7d7c3MxACfX/4t
FsJ++BHvDLSifTFstxy3NnA=
=4qJN
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
