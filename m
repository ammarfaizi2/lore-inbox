Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316267AbSEKTU2>; Sat, 11 May 2002 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316265AbSEKTU1>; Sat, 11 May 2002 15:20:27 -0400
Received: from ppp-217-133-216-65.dialup.tiscali.it ([217.133.216.65]:405 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S314684AbSEKTU0>;
	Sat, 11 May 2002 15:20:26 -0400
Subject: [PATCH] [2.4] [2.5] Fix PPPoATM crash on disconnection
	(tasklet_disable; kfree(tasklet))
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-9ZyLQKsRiOkTqgm5n1Vv"
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 May 2002 21:19:31 +0200
Message-Id: <1021144771.3909.27.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9ZyLQKsRiOkTqgm5n1Vv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

PPPoATM uses tasklet_disable() on a tasklet inside a struct and then
frees the struct, leaving a pointer to the freed tasklet inside tasklet
lists.
This patch replaces tasklet_disable() with tasklet_kill().

This bug is present in both 2.4.18 and 2.5.15 (and the patch applies to
both).


--- linux-old/net/atm/pppoatm.c	Wed Apr 10 14:37:34 2002
+++ linux/net/atm/pppoatm.c	Fri May 10 21:56:28 2002
@@ -125,7 +125,7 @@
 	pvcc =3D atmvcc_to_pvcc(atmvcc);
 	atmvcc->push =3D pvcc->old_push;
 	atmvcc->pop =3D pvcc->old_pop;
-	tasklet_disable(&pvcc->wakeup_tasklet);
+	tasklet_kill(&pvcc->wakeup_tasklet);
 	ppp_unregister_channel(&pvcc->chan);
 	atmvcc->user_back =3D NULL;
 	kfree(pvcc);

--=-9ZyLQKsRiOkTqgm5n1Vv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA83W7Ddjkty3ft5+cRAuHJAJ9hgqFsR0U6ZY4sBf55XtWgzIbXPQCeJO9h
bw91pWe1Ln5XDEE/Y82AW/c=
=r8i7
-----END PGP SIGNATURE-----

--=-9ZyLQKsRiOkTqgm5n1Vv--
