Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTK1CXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTK1CWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:22:39 -0500
Received: from dialin-212-144-182-198.arcor-ip.net ([212.144.182.198]:1408
	"EHLO dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261898AbTK1CWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:22:05 -0500
Date: Fri, 28 Nov 2003 03:07:40 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I4L] Unbind slot on failure in ST_SLOT_BOUND
Message-ID: <20031128020740.GI1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

If a dialup attempt fails (e.g. HiSax doesn't define
ISDN_CMD_CLREAZ and thus returns -EINVAL), the slot stays in
ST_SLOT_BOUND. That doesn't seem to be a great idea, because
any disconnect or further connect attempts will fail. This
also causes the kernel to hang on shutdown after a failed
dial attempt.

More on this patch can be found at
<URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/isdn_slot_=
unbind.xml>

				Thunder

diff -Nur linux-2.6.0-test9-mm3/drivers/isdn/i4l/isdn_common.c linux-2.6.0-=
test9-mm3-ta1/drivers/isdn/i4l/isdn_common.c
--- linux-2.6.0-test9-mm3/drivers/isdn/i4l/isdn_common.c	2003-10-08 21:24:0=
4.000000000 +0200
+++ linux-2.6.0-test9-mm3-ta1/drivers/isdn/i4l/isdn_common.c	2003-11-24 13:=
35:38.000000000 +0100
@@ -2105,7 +2105,7 @@
=20
 	retval =3D isdn_slot_command(slot, ISDN_CMD_CLREAZ, &cmd);
 	if (retval)
-		return retval;
+		goto out_unbind;
=20
 	strcpy(cmd.parm.num, msn);
 	retval =3D isdn_slot_command(slot, ISDN_CMD_SETEAZ, &cmd);
@@ -2114,12 +2114,12 @@
 	cmd.parm.fax =3D dial->fax;
 	retval =3D isdn_slot_command(slot, ISDN_CMD_SETL2, &cmd);
 	if (retval)
-		return retval;
+		goto out_unbind;
=20
 	cmd.arg =3D dial->l3_proto << 8;
 	retval =3D isdn_slot_command(slot, ISDN_CMD_SETL3, &cmd);
 	if (retval)
-		return retval;
+		goto out_unbind;
=20
 	cmd.parm.setup.si1 =3D dial->si1;
 	cmd.parm.setup.si2 =3D dial->si2;
@@ -2132,6 +2132,9 @@
 	       dial->l2_proto, dial->l3_proto);
=20
 	return isdn_slot_command(slot, ISDN_CMD_DIAL, &cmd);
+ out_unbind:
+	fsm_event(&slot->fi, EV_SLOT_UNBIND, NULL);
+	return retval;
 }
=20
 int

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xq3sygQNIN66kP8RAicZAKCi74VqYG+npBun5vxAmYtRq76k6wCdEsYb
7h9BLLquKihYE1KSmUhMKX8=
=hMJB
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
