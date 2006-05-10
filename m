Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWEJKTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWEJKTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWEJKTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:19:22 -0400
Received: from mail.df.lth.se ([194.47.250.12]:64653 "EHLO df.lth.se")
	by vger.kernel.org with ESMTP id S964889AbWEJKTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:19:21 -0400
Date: Wed, 10 May 2006 12:18:42 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linux-kernel@vger.kernel.org
Cc: "Mike A. Harris" <mharris@mharris.ca>
Subject: [PATCH] Make SysRq work with odd keyboards
Message-ID: <20060510101842.GT20178@igloo.df.lth.se>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Mike A. Harris" <mharris@mharris.ca>
References: <Pine.LNX.4.21.0002270925290.803-200000@asdf.capslock.lan> <Pine.LNX.4.21.0002260917480.966-200000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b2ktwntdbf0dPnbx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0002270925290.803-200000@asdf.capslock.lan> <Pine.LNX.4.21.0002260917480.966-200000@asdf.capslock.lan>
User-Agent: Mutt/1.4.2.1i
X-PGP-Public-Key: http://www.df.lth.se/~roubert/pubkey.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b2ktwntdbf0dPnbx
Content-Type: multipart/mixed; boundary="TDVcAd+kFgbLxwBe"
Content-Disposition: inline


--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

My keyboard is quite old, but I'm very fond of it so I wouldn't like to
replace it, even though it behaves quite odd when the SysRq key is
pressed: It sends the make and break codes immediately after another,
even when the key is beeing held down. After searching the list archives
I found that Mike A. Harris used to have a keyboard that be behaved in
the same way:

http://www.ussg.iu.edu/hypermail/linux/kernel/0001.2/1515.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0001.3/0099.html

He also wrote a patch for the 2.2.14 kernel with a work-around for the
troublesome keyboard:

http://www.ussg.iu.edu/hypermail/linux/kernel/0002.3/0518.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0002.3/0683.html

Using the same work-around as in Mike's patch, I've now written a new
patch (see attachment) for the 2.6.15 kernel.

The idea is quite simple: Discard the SysRq break code if Alt is still
being held down. This way the broken keyboard can send the break code
(or the user with a normal keyboard can release the SysRq key) and the
kernel waits until the next key is pressed or the Alt key is released.

Would this work-around be acceptable for inclusion in the kernel?

(I don't know how common these kinds of keyboards are, but we at least
know that they are common enough to get two people to write patches to
support them.)

In the patch, I've used the constant sysrq_fix to show where the
work-around is being invoked. If the code with the work-around is used
with a normal keyboard, SysRq will work as expected with the addition
that one can release SysRq after initially pressed. This behaviour might
not be desireable, and in Mike's original patch /proc/sys/kernel/sysrq
was used to control activation of the work-around.

The method he used to get the value from /proc/sys/kernel/sysrq doesn't
work with current kernels, so before I write a new way to configure it,
I'd like to ask you kernel developers if you think that this should be
configurable and if it should be, if it's best to use /proc or to make
it a compile-time option?

Cheers // Fredrik Roubert

--=20
S=F6rbyplan 5       |  +46 8 7609169 / +46 708 776974
SE-163 71 Sp=E5nga  |  http://www.df.lth.se/~roubert/

--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.15-keyboard-sysrq-1.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.15/drivers/char/keyboard.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-sysrq/drivers/char/keyboard.c	2006-03-14 00:05:48.00000000=
0 +0100
@@ -141,6 +141,7 @@
 /* Simple translation table for the SysRq keys */
=20
 #ifdef CONFIG_MAGIC_SYSRQ
+static const int sysrq_fix =3D 1;
 unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =3D
         "\000\0331234567890-=3D\177\t"                    /* 0x00 - 0x0f */
         "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
@@ -150,6 +151,7 @@
         "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" =
/* 0x50 - 0x5f */
         "\r\000/";                                      /* 0x60 - 0x6f */
 static int sysrq_down;
+static int sysrq_alt_use;
 #endif
 static int sysrq_alt;
=20
@@ -1044,7 +1046,7 @@
 	kbd =3D kbd_table + fg_console;
=20
 	if (keycode =3D=3D KEY_LEFTALT || keycode =3D=3D KEY_RIGHTALT)
-		sysrq_alt =3D down;
+		sysrq_alt =3D down ? keycode : 0;
 #ifdef CONFIG_SPARC
 	if (keycode =3D=3D KEY_STOP)
 		sparc_l1_a_state =3D down;
@@ -1064,9 +1066,14 @@
=20
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
 	if (keycode =3D=3D KEY_SYSRQ && (sysrq_down || (down =3D=3D 1 && sysrq_al=
t))) {
-		sysrq_down =3D down;
+		if (!sysrq_fix || !sysrq_down) {
+			sysrq_down =3D down;
+			sysrq_alt_use =3D sysrq_alt;
+		}
 		return;
 	}
+	if (sysrq_fix && sysrq_down && !down && keycode =3D=3D sysrq_alt_use)
+		sysrq_down =3D 0;
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 		return;

--TDVcAd+kFgbLxwBe--

--b2ktwntdbf0dPnbx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRGG+AsRKuLhQMn35AQKGfQP/XWxNT7DWlWDlJQzKW/uxSJM5ozPmzNTA
TYb7W810+LibfjIu5NcZ+seGOqVlTQYXRKOj9Wj5WH+AGgXS8vuRqWnrYJUq1wK7
/+gb3H+HQoud8YKb3Y5S34vljbI4KUyGY2e5f6IYrMEdJtRwoHjpWnvh92EUHcLz
3XNNMK5JWSg=
=NxXc
-----END PGP SIGNATURE-----

--b2ktwntdbf0dPnbx--
