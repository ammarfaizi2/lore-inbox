Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVEYDmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVEYDmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVEYDmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:42:21 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:22690 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262261AbVEYDl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:41:56 -0400
Date: Wed, 25 May 2005 13:41:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppc64: fix initialisation of gettimeofday calculations
Message-Id: <20050525134126.3382e519.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__25_May_2005_13_41_26_+1000_/oyvLL.NX1TjFYay"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__25_May_2005_13_41_26_+1000_/oyvLL.NX1TjFYay
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On PPC64, we keep track of when we need to update jiffies (and the
variables used to calculate the time of day) based on the time base.  If
the time base frequence is sufficiently high compared to the processor
clock frequency, then it is possible for the time of day variables to be
corrupted by at the time of the first decrementer interrupt we take.  This
became obvious on a legacy iSeries where the time base frequency is the
same as the processor clock.  This one line patch fixes the initialisation
so that the time of day variables and the indicator we use to tell when
updates are due are better synchronised.

Signed-off-by:  Stephen Rothwell <sfr@canb.auug.org.au>

Please apply and send to Linus.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/ppc64/kernel/time.c linus-clock.1/arch/ppc64/kernel/t=
ime.c
--- linus/arch/ppc64/kernel/time.c	2005-05-17 09:23:08.000000000 +1000
+++ linus-clock.1/arch/ppc64/kernel/time.c	2005-05-25 13:11:14.000000000 +1=
000
@@ -515,6 +515,7 @@ void __init time_init(void)
 	do_gtod.varp =3D &do_gtod.vars[0];
 	do_gtod.var_idx =3D 0;
 	do_gtod.varp->tb_orig_stamp =3D tb_last_stamp;
+	get_paca()->next_jiffy_update_tb =3D tb_last_stamp + tb_ticks_per_jiffy;
 	do_gtod.varp->stamp_xsec =3D xtime.tv_sec * XSEC_PER_SEC;
 	do_gtod.tb_ticks_per_sec =3D tb_ticks_per_sec;
 	do_gtod.varp->tb_to_xs =3D tb_to_xs;

--Signature=_Wed__25_May_2005_13_41_26_+1000_/oyvLL.NX1TjFYay
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCk/Ps4CJfqux9a+8RAgQ9AJ0XuYh+mVwbi5kUffIGRCe1bM4vEgCglTzu
Ej3fj4rziVwEWzAHqGwsGBE=
=NViH
-----END PGP SIGNATURE-----

--Signature=_Wed__25_May_2005_13_41_26_+1000_/oyvLL.NX1TjFYay--
