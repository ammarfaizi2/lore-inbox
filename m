Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUAIET1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUAIET1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:19:27 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:48779 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264284AbUAIETU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:19:20 -0500
Date: Fri, 09 Jan 2004 17:19:48 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: PATCH: Fix support for wide consoles in vt.c and
	include/linux/selection.h
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073621988.2003.40.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-oUqhMdS0ZM2B5WrA8jX/";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oUqhMdS0ZM2B5WrA8jX/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

In implementing a 'nice' display for Software Suspend, some users with
wide VTs reported problems with distortion. These changes from signed to
unsigned int/char fixed the issue and have been tested for around a year
(guesstimate).

The only other user of getconsxy is vc_screen.c. It might benefit from
matching changes, although the users who reported the problem to me said
nothing about other issues with their displays, so far as I recall.

To actually use the functions from Suspend, the functions also had to be
made non-static. Of course I could make this into 2 patches if desired.

Regards,

Nigel


diff -ruN linux-2.6.1-rc3/drivers/char/vt.c software-suspend-linux-2.6.1-rc=
3/drivers/char/vt.c
--- linux-2.6.1-rc3/drivers/char/vt.c	2004-01-09 14:24:45.000000000 +1300
+++ software-suspend-linux-2.6.1-rc3/drivers/char/vt.c	2004-01-09 14:41:54.=
000000000 +1300
@@ -149,13 +149,13 @@
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
 static void blank_screen(unsigned long dummy);
-static void gotoxy(int currcons, int new_x, int new_y);
+void gotoxy(int currcons, unsigned int new_x, unsigned int new_y);
 static void save_cur(int currcons);
-static void reset_terminal(int currcons, int do_clear);
+void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
 static void set_vesa_blanking(unsigned long arg);
 static void set_cursor(int currcons);
-static void hide_cursor(int currcons);
+void hide_cursor(int currcons);
 static void unblank_screen_t(unsigned long dummy);
 static void console_callback(void *ignored);
=20
@@ -530,7 +530,7 @@
 		sw->con_putc(vc_cons[currcons].d, i, y, x);
 }
=20
-static void hide_cursor(int currcons)
+void hide_cursor(int currcons)
 {
 	if (currcons =3D=3D sel_cons)
 		clear_selection();
@@ -859,9 +859,9 @@
  * might also be negative. If the given position is out of
  * bounds, the cursor is placed at the nearest margin.
  */
-static void gotoxy(int currcons, int new_x, int new_y)
+void gotoxy(int currcons, unsigned int new_x, unsigned int new_y)
 {
-	int min_y, max_y;
+	unsigned int min_y, max_y;
=20
 	if (new_x < 0)
 		x =3D 0;
@@ -888,7 +888,7 @@
 }
=20
 /* for absolute user moves, when decom is set */
-static void gotoxay(int currcons, int new_x, int new_y)
+static void gotoxay(int currcons, unsigned int new_x, unsigned int new_y)
 {
 	gotoxy(currcons, new_x, decom ? (top+new_y) : new_y);
 }
@@ -1403,7 +1403,7 @@
 	ESpalette };
=20
 /* console_sem is held (except via vc_init()) */
-static void reset_terminal(int currcons, int do_clear)
+void reset_terminal(int currcons, int do_clear)
 {
 	top		=3D 0;
 	bottom		=3D video_num_lines;
@@ -2996,13 +2996,13 @@
 	return screenpos(currcons, 2 * w_offset, viewed);
 }
=20
-void getconsxy(int currcons, char *p)
+void getconsxy(int currcons, unsigned char *p)
 {
 	p[0] =3D x;
 	p[1] =3D y;
 }
=20
-void putconsxy(int currcons, char *p)
+void putconsxy(int currcons, unsigned char *p)
 {
 	gotoxy(currcons, p[0], p[1]);
 	set_cursor(currcons);
diff -ruN linux-2.6.1-rc3/include/linux/selection.h software-suspend-linux-=
2.6.1-rc3/include/linux/selection.h
--- linux-2.6.1-rc3/include/linux/selection.h	2004-01-09 14:22:25.000000000=
 +1300
+++ software-suspend-linux-2.6.1-rc3/include/linux/selection.h	2004-01-09 1=
4:41:54.000000000 +1300
@@ -36,8 +36,8 @@
 extern void complement_pos(int currcons, int offset);
 extern void invert_screen(int currcons, int offset, int count, int shift);
=20
-extern void getconsxy(int currcons, char *p);
-extern void putconsxy(int currcons, char *p);
+extern void getconsxy(int currcons, unsigned char *p);
+extern void putconsxy(int currcons, unsigned char *p);
=20
 extern u16 vcs_scr_readw(int currcons, const u16 *org);
 extern void vcs_scr_writew(int currcons, u16 val, u16 *org);

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-oUqhMdS0ZM2B5WrA8jX/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//ivkVfpQGcyBBWkRAjeBAJ0UveqadnuyZu+Q7/pxRLvbZENyIgCfZZXb
rEYdy2N0T1P3CwywNhfg+Uw=
=DWpC
-----END PGP SIGNATURE-----

--=-oUqhMdS0ZM2B5WrA8jX/--

