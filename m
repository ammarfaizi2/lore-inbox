Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUEKMyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUEKMyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUEKMyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:54:18 -0400
Received: from smtp.golden.net ([199.166.210.31]:3844 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S264669AbUEKMyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:54:11 -0400
Date: Tue, 11 May 2004 08:54:05 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix 8139too ring size for dreamcast/embedded
Message-ID: <20040511125405.GA14578@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jgarzik@pobox.com>, shemminger@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Presently 2.6.6 backs out the CONFIG_8139_RXBUF_IDX in favor of using a
hardcoded 8139_RXBUF_IDX (again). This seems to have been done due to
some issues occuring with 8139_RXBUF_IDX =3D=3D 3, however (as the Kconfig
pointed out), we still need 8139_RXBUF_IDX =3D=3D 1 in the CONFIG_SH_DREAMC=
AST
case.

The patch which made this change can be seen at:

http://linux.bkbits.net:8080/linux-2.5/user=3Dshemminger/cset@1.1371.719.67=
?nav=3D!-|index.html|stats|!+|index.html|ChangeSet@-8w

Before that, CONFIG_8139_RXBUF_IDX was set to 1 both in the CONFIG_SH_DREAM=
CAST
and CONFIG_EMBEDDED cases. This patch adds that back into the current 8139t=
oo.

Additionally, why remove the config option at all? Wouldn't it just be
easier to drop the range from 0 - 3 to 0 - 2 until problems with a 64K ring
size are resolved?

--- linux-2.6.6/drivers/net/8139too.c.orig	Tue May 11 08:36:24 2004
+++ linux-2.6.6/drivers/net/8139too.c	Tue May 11 08:36:29 2004
@@ -171,7 +171,11 @@
  * Receive ring size=20
  * Warning: 64K ring has hardware issues and may lock up.
  */
+#if defined(CONFIG_SH_DREAMCAST) || defined(CONFIG_EMBEDDED)
+#define RX_BUF_IDX	1	/* 16K ring */
+#else
 #define RX_BUF_IDX	2	/* 32K ring */
+#endif
 #define RX_BUF_LEN	(8192 << RX_BUF_IDX)
 #define RX_BUF_PAD	16
 #define RX_BUF_WRAP_PAD 2048 /* spare padding to handle lack of packet wra=
p */


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAoMzt1K+teJFxZ9wRApPBAJ9lm8LJiCcpbo0m3mv3oCvIyFLctQCfVm7D
SG8pMhTiz/s3YaPvyTVMY9M=
=OKVZ
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
