Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVB0Hzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVB0Hzb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 02:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVB0Hzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 02:55:31 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:38007 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261365AbVB0HzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 02:55:03 -0500
Date: Sun, 27 Feb 2005 01:54:59 -0600
From: Peter Samuelson <peter@p12n.org>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [uPATCH] cross-compile scripts/lxdialog/ on AIX
Message-ID: <20050227075459.GS3077@p12n.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8VTUIDSAwBDIdXuf"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8VTUIDSAwBDIdXuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


AIX curses.h defines macros 'clear_screen' and 'color_names' but does
not define 'scroll()'.

Signed-Off-By: Peter Samuelson <peter@p12n.org>

diff -urN 2.6.11-rc5/scripts/lxdialog/checklist.c.old 2.6.11-rc5/scripts/lx=
dialog/checklist.c
--- 2.6.11-rc5/scripts/lxdialog/checklist.c.old	2005-02-27 00:49:00.0000000=
00 -0600
+++ 2.6.11-rc5/scripts/lxdialog/checklist.c	2005-02-27 01:01:17.000000000 -=
0600
@@ -269,7 +269,7 @@
 				    status[scroll + max_choice - 1],
 				    max_choice - 1, FALSE);
 			scrollok (list, TRUE);
-			scroll (list);
+			wscrl (list, 1);
 			scrollok (list, FALSE);
 		    }
 		    scroll++;
diff -urN 2.6.11-rc5/scripts/lxdialog/colors.h.old 2.6.11-rc5/scripts/lxdia=
log/colors.h
--- 2.6.11-rc5/scripts/lxdialog/colors.h.old	2004-02-03 21:43:07.000000000 =
-0600
+++ 2.6.11-rc5/scripts/lxdialog/colors.h	2005-02-27 01:45:28.000000000 -0600
@@ -152,10 +152,4 @@
  * Global variables
  */
=20
-typedef struct {
-    char name[COLOR_NAME_LEN];
-    int value;
-} color_names_st;
-
-extern color_names_st color_names[];
 extern int color_table[][3];
diff -urN 2.6.11-rc5/scripts/lxdialog/lxdialog.c.old 2.6.11-rc5/scripts/lxd=
ialog/lxdialog.c
--- 2.6.11-rc5/scripts/lxdialog/lxdialog.c.old	2004-02-03 21:43:57.00000000=
0 -0600
+++ 2.6.11-rc5/scripts/lxdialog/lxdialog.c	2005-02-27 01:31:11.000000000 -0=
600
@@ -56,7 +56,7 @@
 int
 main (int argc, const char * const * argv)
 {
-    int offset =3D 0, clear_screen =3D 0, end_common_opts =3D 0, retval;
+    int offset =3D 0, opt_clear =3D 0, end_common_opts =3D 0, retval;
     const char *title =3D NULL;
=20
 #ifdef LOCALE
@@ -89,7 +89,7 @@
                 offset +=3D 2;
             }
 	} else if (!strcmp (argv[offset + 1], "--clear")) {
-	    if (clear_screen) {	/* Hey, "--clear" can't appear twice! */
+	    if (opt_clear) {		/* Hey, "--clear" can't appear twice! */
 		Usage (argv[0]);
 		exit (-1);
 	    } else if (argc =3D=3D 2) {	/* we only want to clear the screen */
@@ -98,7 +98,7 @@
 		end_dialog ();
 		return 0;
 	    } else {
-		clear_screen =3D 1;
+		opt_clear =3D 1;
 		offset++;
 	    }
 	} else			/* no more common options */
@@ -127,7 +127,7 @@
     init_dialog ();
     retval =3D (*(modePtr->jumper)) (title, argc - offset, argv + offset);
=20
-    if (clear_screen) {		/* clear screen before exit */
+    if (opt_clear) {		/* clear screen before exit */
 	attr_clear (stdscr, LINES, COLS, screen_attr);
 	refresh ();
     }
diff -urN 2.6.11-rc5/scripts/lxdialog/menubox.c.old 2.6.11-rc5/scripts/lxdi=
alog/menubox.c
--- 2.6.11-rc5/scripts/lxdialog/menubox.c.old	2005-02-27 00:23:54.000000000=
 -0600
+++ 2.6.11-rc5/scripts/lxdialog/menubox.c	2005-02-27 01:32:08.000000000 -06=
00
@@ -327,7 +327,7 @@
                    ) {
 		    /* Scroll menu up */
 		    scrollok (menu, TRUE);
-                    scroll (menu);
+		    wscrl (menu, 1);
                     scrollok (menu, FALSE);
=20
                     scroll++;
@@ -357,7 +357,7 @@
                 for (i=3D0; (i < max_choice); i++) {
                     if (scroll+max_choice < item_no) {
 			scrollok (menu, TRUE);
-			scroll(menu);
+			wscrl (menu, 1);
 			scrollok (menu, FALSE);
                 	scroll++;
                 	print_item (menu, items[(scroll+max_choice-1)*2+1],

--8VTUIDSAwBDIdXuf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCIXzTXk7sIRPQRh0RAnv1AKCTbl3L8xQGDUqxPIwo/EFiPnxPiQCeMp7u
w0pXRc+5CSWBAOusC3Z2du4=
=APxy
-----END PGP SIGNATURE-----

--8VTUIDSAwBDIdXuf--
