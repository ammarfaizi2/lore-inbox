Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUGNPfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUGNPfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUGNPfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:35:42 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:65455 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267407AbUGNPf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:35:26 -0400
Date: Wed, 14 Jul 2004 17:35:25 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: mconf.c: Honor $LINES and $COLUMNS if TIOCGWINSZ failed
Message-ID: <20040714153525.GU2019@lug-owl.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z118w8IfbP8nVdqq"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z118w8IfbP8nVdqq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

While reading code, I found this buglet. If the TIOCGWINSZ fails,
mconf.c assumes 24/80 as screen size, without honoring the LINES and
COLUMNS environment variables. This is the shorter and IMHO more correct
version:

Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>


--- linux-2.6.7-tar-pkg/scripts/kconfig/mconf.c~	Wed Jul 14 15:38:48 2004
+++ linux-2.6.7-tar-pkg/scripts/kconfig/mconf.c	Wed Jul 14 15:47:52 2004
@@ -87,7 +87,7 @@
 static char *args[1024], **argptr =3D args;
 static int indent;
 static struct termios ios_org;
-static int rows, cols;
+static int rows =3D 0, cols =3D 0;
 static struct menu *current_menu;
 static int child_count;
 static int do_resize;
@@ -113,26 +113,24 @@
 	struct winsize ws;
 	char *env;
=20
-	if (ioctl(1, TIOCGWINSZ, &ws) =3D=3D -1) {
-		rows =3D 24;
-		cols =3D 80;
-	} else {
+	if (!ioctl(STDIN_FILENO, TIOCGWINSZ, &ws)) {
 		rows =3D ws.ws_row;
 		cols =3D ws.ws_col;
-		if (!rows) {
-			env =3D getenv("LINES");
-			if (env)
-				rows =3D atoi(env);
-			if (!rows)
-				rows =3D 24;
-		}
-		if (!cols) {
-			env =3D getenv("COLUMNS");
-			if (env)
-				cols =3D atoi(env);
-			if (!cols)
-				cols =3D 80;
-		}
+	}
+
+	if (!rows) {
+		env =3D getenv("LINES");
+		if (env)
+			rows =3D atoi(env);
+		if (!rows)
+			rows =3D 24;
+	}
+	if (!cols) {
+		env =3D getenv("COLUMNS");
+		if (env)
+			cols =3D atoi(env);
+		if (!cols)
+			cols =3D 80;
 	}
=20
 	if (rows < 19 || cols < 80) {

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--z118w8IfbP8nVdqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9VK9Hb1edYOZ4bsRAleJAJ9jog6FyYZBEQy/szrHH9lxRFsncACdGpbh
3fAnhjAKdgEfPBSWo+TWg3g=
=6ZR+
-----END PGP SIGNATURE-----

--z118w8IfbP8nVdqq--
