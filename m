Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVGNOh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVGNOh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGNOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:37:28 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:41358 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261415AbVGNOhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:37:25 -0400
Date: Thu, 14 Jul 2005 10:36:47 -0400
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] rocket.c: Fix ldisc ref count handling
Message-ID: <20050714103647.71dc433f@brick.watson.ibm.com>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
T: tytso@mit.edu
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Thu__14_Jul_2005_10_36_47_-0400_nkGmpsO9ak_YCoCi;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Thu__14_Jul_2005_10_36_47_-0400_nkGmpsO9ak_YCoCi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If bailing out because there is nothing to receive in rp_do_receive(),
tty_ldisc_deref is not called.  Failure to do so increases the ref count=20
and causes release_dev() to hang since it can't get the ref count to 0.

---

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

 drivers/char/rocket.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -355,7 +355,7 @@ static void rp_do_receive(struct r_port=20
 		ToRecv =3D space;
=20
 	if (ToRecv <=3D 0)
-		return;
+		goto done;
=20
 	/*
 	 * if status indicates there are errored characters in the
@@ -437,6 +437,7 @@ static void rp_do_receive(struct r_port=20
 	}
 	/*  Push the data up to the tty layer */
 	ld->receive_buf(tty, tty->flip.char_buf, tty->flip.flag_buf, count);
+ done:
 	tty_ldisc_deref(ld);
 }
=20

--Signature_Thu__14_Jul_2005_10_36_47_-0400_nkGmpsO9ak_YCoCi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC1nh/DMDCqU5zPMARAr9FAJ0WoEZcIiq9stwRf4g9TMwNTu/lHgCdHZ/+
uEgBJK1jhjoWvmvQFf4dnt8=
=gjDq
-----END PGP SIGNATURE-----

--Signature_Thu__14_Jul_2005_10_36_47_-0400_nkGmpsO9ak_YCoCi--
