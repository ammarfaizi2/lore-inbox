Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUB0NIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUB0NIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:08:20 -0500
Received: from ns.suse.de ([195.135.220.2]:12941 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262764AbUB0NIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:08:18 -0500
Date: Fri, 27 Feb 2004 14:08:16 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: sys_alarm() return value
Message-ID: <20040227130816.GB3156@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.2-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when calling=20

alarm(1); alarm(0);

the second alarm can wrongly return 2. This makes an LSB test fail.

It happens due to rounding errors in the timeval to jiffie conversion
and back. On i386 with HZ =3D=3D 1000, there would not need to be rounding
error IMVHO, but they even occur there.  On HZ=3D1024 platforms, they may
even be unavoidable.

Attached patch fixes the return value of alarm().
Please consider applying.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="timer-262.diff"

--- linux-2.6.2.x86/kernel/timer.c.orig	2004-02-04 04:44:25.000000000 +0100
+++ linux-2.6.2.x86/kernel/timer.c	2004-02-27 11:11:57.458593978 +0100
@@ -868,7 +868,7 @@
 	oldalarm = it_old.it_value.tv_sec;
 	/* ehhh.. We can't return 0 if we have an alarm pending.. */
 	/* And we'd better return too much than too little anyway */
-	if (it_old.it_value.tv_usec)
+	if ((!oldalarm && it_old.it_value.tv_usec) || it_old.it_value.tv_usec >= 500000)
 		oldalarm++;
 	return oldalarm;
 }

--i9LlY+UWpKt15+FH--

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAP0E/xmLh6hyYd04RAjg+AKCwJzzvHIkcJnHiadvTJWzSR0XVFACdGQPd
7yOsJMNngkinbygrSbh9zYw=
=GoBZ
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
