Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTK1CV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTK1CV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:21:58 -0500
Received: from dialin-212-144-182-198.arcor-ip.net ([212.144.182.198]:128 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261875AbTK1CV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:21:57 -0500
Date: Fri, 28 Nov 2003 03:02:29 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I4L] dc_l1_init() double WORK_INIT kills off keyboard
Message-ID: <20031128020229.GH1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

Sometimes, dc_l1_init is called  on an already initialized card state.
That wouldn't  be too  bad if there  just wasn't that  workqueue entry
which is  going loopy  then. This workqueue  entry will  have (amongst
others) the effect that no keyboard input will be accepted.

The fix here is to skip the work initialization if the work is already
in the work queue.

More on this patch can be found at
<URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/dcl1_init_workqueue.xml>

				Thunder

diff -Nur linux-2.6.0-test9-mm3/drivers/isdn/hisax/isdnl1.c linux-2.6.0-test9-mm3-ta1/drivers/isdn/hisax/isdnl1.c
--- linux-2.6.0-test9-mm3/drivers/isdn/hisax/isdnl1.c	2003-10-08 21:24:03.000000000 +0200
+++ linux-2.6.0-test9-mm3-ta1/drivers/isdn/hisax/isdnl1.c	2003-11-24 13:32:32.000000000 +0100
@@ -913,8 +913,10 @@
 dc_l1_init(struct IsdnCardState *cs, struct dc_l1_ops *ops)
 {
 	cs->dc_l1_ops = ops;
-	INIT_WORK(&cs->work, ops->bh_func, cs);
-	init_timer(&cs->dbusytimer);
+	if (!test_bit(0, &cs->work.pending) {
+		INIT_WORK(&cs->work, ops->bh_func, cs);
+		init_timer(&cs->dbusytimer);
+	}
 	cs->dbusytimer.function = (void *)(unsigned long) ops->dbusy_func;
 	cs->dbusytimer.data = (unsigned long) cs;
 }

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xqy1ygQNIN66kP8RAuo+AJ9MgDWvCkEU7umQD0nKbr4R20nyBACdFG+v
aec4F1ed31Ul/oYmAsDPV7w=
=0DcT
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
