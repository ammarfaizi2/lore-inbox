Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270693AbTGUU2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270696AbTGUU2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:28:42 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:16397 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S270693AbTGUU21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:28:27 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Mon, 21 Jul 2003 16:43:28 -0400
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: Logitech ps2++ scroll wheel + KVM fix (sort of)
Message-ID: <20030721204328.GA721@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

    I've found a fix for a problem I was having with the combination
of my Logitech trackball's scrollwheel and my KVM switch.  My scroll
wheel would work until I switched away from my Linux desktop; after
switching back, the evbug module reported no events when turning the
wheel.

    According to Belkin, this is because my KVM switch does not
support the Logitech protocol, only the MS Intellimouse one.  I
noticed that WinXP had no such problems, so I commented out the section
in psmouse_extensions() that detected Logitech mice.  Now my trackball
is detected as a "ImPS/2 Generic Wheel Mouse" and the scroll wheel
always works.

    It would be good to have a parameter that would allow me to force
this mouse to use the ImPS/2 protocol rather than the logitech PS2++; I
probably won't be the last person to have this kind of problem (which
I didn't have with 2.4).

    The following patch makes that parameter: psmouse_imps2.  Will you
consider it applying it, or something like it?
   =20
diff -urN linux-2.6.0-test1/Documentation/kernel-parameters.txt linux-2.6.0=
-test1-changed/Documentation/kernel-parameters.txt
--- linux-2.6.0-test1/Documentation/kernel-parameters.txt	2003-07-21 15:27:=
06.000000000 -0400
+++ linux-2.6.0-test1-changed/Documentation/kernel-parameters.txt	2003-07-2=
1 16:31:16.000000000 -0400
@@ -780,6 +780,8 @@
=20
 	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
=20
+	psmouse_imps2	[HW,MOUSE] Probe only for Intellimouse PS2 mouse protocol e=
xtensions
+
 	pss=3D		[HW,OSS] Personal Sound System (ECHO ESC614)
 			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
=20
diff -urN linux-2.6.0-test1/drivers/input/mouse/psmouse-base.c linux-2.6.0-=
test1-changed/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0-test1/drivers/input/mouse/psmouse-base.c	2003-07-02 16:43:3=
0.000000000 -0400
+++ linux-2.6.0-test1-changed/drivers/input/mouse/psmouse-base.c	2003-07-21=
 16:05:24.000000000 -0400
@@ -25,6 +25,8 @@
 MODULE_DESCRIPTION("PS/2 mouse driver");
 MODULE_PARM(psmouse_noext, "1i");
 MODULE_PARM_DESC(psmouse_noext, "Disable any protocol extensions. Useful f=
or KVM switches.");
+MODULE_PARM(psmouse_imps2, "1i");
+MODULE_PARM_DESC(psmouse_imps2, "Limit protocol extensions to the Intellim=
ouse protocol.");
 MODULE_PARM(psmouse_resolution, "i");
 MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
 MODULE_PARM(psmouse_smartscroll, "i");
@@ -34,6 +36,7 @@
 #define PSMOUSE_LOGITECH_SMARTSCROLL	1
=20
 static int psmouse_noext;
+static int psmouse_imps2;
 int psmouse_resolution;
 int psmouse_smartscroll =3D PSMOUSE_LOGITECH_SMARTSCROLL;
=20
@@ -250,66 +253,68 @@
 	if (psmouse_noext)
 		return PSMOUSE_PS2;
=20
-/*
- * Try Synaptics TouchPad magic ID
- */
-
-       param[0] =3D 0;
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	if (!psmouse_imps2) {
=20
-       if (param[1] =3D=3D 0x47) {
-		psmouse->vendor =3D "Synaptics";
-		psmouse->name =3D "TouchPad";
-		if (!synaptics_init(psmouse))
-			return PSMOUSE_SYNAPTICS;
-		else
-			return PSMOUSE_PS2;
-       }
+		/*
+		 * Try Synaptics TouchPad magic ID
+		 */
=20
-/*
- * Try Genius NetMouse magic init.
- */
+		param[0] =3D 0;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+		if (param[1] =3D=3D 0x47) {
+			psmouse->vendor =3D "Synaptics";
+			psmouse->name =3D "TouchPad";
+			if (!synaptics_init(psmouse))
+				return PSMOUSE_SYNAPTICS;
+			else
+				return PSMOUSE_PS2;
+		}
=20
-	param[0] =3D 3;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+		/*
+		 * Try Genius NetMouse magic init.
+		 */
=20
-	if (param[0] =3D=3D 0x00 && param[1] =3D=3D 0x33 && param[2] =3D=3D 0x55)=
 {
+		param[0] =3D 3;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
=20
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		if (param[0] =3D=3D 0x00 && param[1] =3D=3D 0x33 && param[2] =3D=3D 0x55=
) {
=20
-		psmouse->vendor =3D "Genius";
-		psmouse->name =3D "Wheel Mouse";
-		return PSMOUSE_GENPS;
-	}
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
=20
-/*
- * Try Logitech magic ID.
- */
+			psmouse->vendor =3D "Genius";
+			psmouse->name =3D "Wheel Mouse";
+			return PSMOUSE_GENPS;
+		}
=20
-	param[0] =3D 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	param[1] =3D 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+		/*
+		 * Try Logitech magic ID.
+		 */
=20
-	if (param[1]) {
-		int type =3D ps2pp_detect_model(psmouse, param);
-		if (type)
-			return type;
+		param[0] =3D 0;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		param[1] =3D 0;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+		if (param[1]) {
+			int type =3D ps2pp_detect_model(psmouse, param);
+			if (type)
+				return type;
+		}
 	}
-
 /*
  * Try IntelliMouse magic init.
  */
@@ -555,6 +560,12 @@
 	return 1;
 }
=20
+static int __init psmouse_imps2_setup(char *str)
+{
+	psmouse_imps2 =3D 1;
+	return 1;
+}
+
 static int __init psmouse_resolution_setup(char *str)
 {
 	get_option(&str, &psmouse_resolution);
@@ -568,6 +579,7 @@
 }
=20
 __setup("psmouse_noext", psmouse_noext_setup);
+__setup("psmouse_imps2", psmouse_imps2_setup);
 __setup("psmouse_resolution=3D", psmouse_resolution_setup);
 __setup("psmouse_smartscroll=3D", psmouse_smartscroll_setup);
=20
--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HFBwWv4KsgKfSVgRAo+oAJ4+ogRb7kN5dOMKVh3wy3C9phYwOwCfSpef
PZvFJwRlNrP8nIW2b2T/3FQ=
=zT0c
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
