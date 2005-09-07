Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVIGJwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVIGJwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVIGJwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:52:47 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:11225 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750851AbVIGJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:52:47 -0400
Date: Wed, 7 Sep 2005 19:52:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: paulus@samba.org, anton@samba.org, LKML <linux-kernel@vger.kernel.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
Subject: [PATCH] ppc64: iSeries early printk breakage
Message-Id: <20050907195238.5523dada.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__7_Sep_2005_19_52_38_+1000_S_dVQnFnOMjhJI/7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__7_Sep_2005_19_52_38_+1000_S_dVQnFnOMjhJI/7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The earlier commit 8d9273918635f0301368c01b56c03a6f339e8d51
(Consolidate early console and PPCDBG code) broke iSeries because
it caused unregister_console(&udbg_console) to be called
unconditionally.  iSeries never registers the udbg_console.

This just reverts part of the change.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc64/kernel/udbg.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

234f5032f6ccb4d72e4b74d33af55716b67d8a27
diff --git a/arch/ppc64/kernel/udbg.c b/arch/ppc64/kernel/udbg.c
--- a/arch/ppc64/kernel/udbg.c
+++ b/arch/ppc64/kernel/udbg.c
@@ -158,14 +158,20 @@ static struct console udbg_console =3D {
 	.index	=3D -1,
 };
=20
+static int early_console_initialized;
+
 void __init disable_early_printk(void)
 {
+	if (!early_console_initialized)
+		return;
 	unregister_console(&udbg_console);
+	early_console_initialized =3D 0;
 }
=20
 /* called by setup_system */
 void register_early_udbg_console(void)
 {
+	early_console_initialized =3D 1;
 	register_console(&udbg_console);
 }
=20

--Signature=_Wed__7_Sep_2005_19_52_38_+1000_S_dVQnFnOMjhJI/7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHrhvFdBgD/zoJvwRAupmAJ9X79UWaAtYlLyq79eHdSh4lDzICACeLFPZ
dpNdzU4F0Y5q+FiPtvubWPw=
=14Ac
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Sep_2005_19_52_38_+1000_S_dVQnFnOMjhJI/7--
