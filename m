Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUCVXsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUCVXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:48:12 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:2016 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261503AbUCVXsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:48:10 -0500
Date: Tue, 23 Mar 2004 10:47:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64 iSeries virtual cd fix
Message-Id: <20040323104752.4c2b61f3.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Mar_2004_10_47_52_+1100_nCEHDLO7L0mGx1gp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__23_Mar_2004_10_47_52_+1100_nCEHDLO7L0mGx1gp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch stops an oops caused by certain ioctls being performed
on the virtual cdrom.  In particular, the eject and tray close
operations were affected.

Please apply and forward to Linus.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN ppc64-2.5-iseries/drivers/cdrom/viocd.c ppc64-2.5-iseries.eject/drivers/cdrom/viocd.c
--- ppc64-2.5-iseries/drivers/cdrom/viocd.c	2004-03-07 18:05:28.000000000 +1100
+++ ppc64-2.5-iseries.eject/drivers/cdrom/viocd.c	2004-03-22 17:54:53.000000000 +1100
@@ -338,8 +338,9 @@
 	struct request *req;
 
 	while ((rwreq == 0) && ((req = elv_next_request(q)) != NULL)) {
-		/* check for any kind of error */
-		if (send_request(req) < 0) {
+		if (!blk_fs_request(req))
+			end_request(req, 0);
+		else if (send_request(req) < 0) {
 			printk(VIOCD_KERN_WARNING
 					"unable to send message to OS/400!");
 			end_request(req, 0);

--Signature=_Tue__23_Mar_2004_10_47_52_+1100_nCEHDLO7L0mGx1gp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX3soFG47PeJeR58RAuQaAKCybwddvKSA5dd+UHr+n2xgscW71QCgzivJ
2hfpvmgo+TYQphiH7IZh5lU=
=e+Rl
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Mar_2004_10_47_52_+1100_nCEHDLO7L0mGx1gp--
