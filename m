Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTHaNG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTHaNG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:06:58 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:11665 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261861AbTHaNGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:06:17 -0400
Date: Sun, 31 Aug 2003 09:06:19 -0400
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH][RESEND] Force mouse detection as imps/2 (and fix my KVM switch)
Message-ID: <20030831130619.GA1804@zion.rivenstone.net>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org,
	akpm@osdl.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

    After working out the symptoms of a problem I was having using my
scroll mouse with my KVM switch when running 2.6 kernels, I made this
patch which fixes the problem for me.  I think it would be useful to
have this in the kernel, especially since it has other uses too.

    I have a Logitech mouse with a scroll wheel that 2.6 kernels
detect as supporting the Logitech ps2++ protocol, and enable it as
such.  My KVM switch supports only the Microsoft imps2 protocol for
using the scroll wheel, so after switching away from a box running a
2.6 kernel and back again, my scroll wheel no longer works; evbug
doesn't see any mouse events at all when I turn the scroll wheel.

    2.4 (and Windows) don't have this problem because they use imps2
drivers, which my mouse is compatible with.  So the appended patch
creates a new module/boot parameter, psmouse_imps2, largely copied
=66rom psmouse_noext.  With the option, the mouse detection is limited
to only the base ps2 protocol and the imps2 extensions, my mouse is
detected as a generic imps/2 device, and the scroll wheel works
properly again.

    I've been using this patch for about a month.  I've since seen
another use for this parameter; with it it is possible to disable the
synaptics touchpad driver and still use an external imps2 mouse.

    I'm not sure if short-circuiting the mouse detection this way
might leave some mice wedged, or cause them to be improperly detected
though.  Do the tests for imps/2 mice depend on any of the commands in
the detection this patch skips to initialize the mouse somehow?

    This patch is against -test4; it applies to -test4-mm4 with
offsets (I'm running -mm4).  More than half the length of the patch is
indentation.  Is there a possibility of getting this applied?



diff -urN linux-2.6.0-test4/Documentation/kernel-parameters.txt linux-2.6.0=
-test4_changed/Documentation/kernel-parameters.txt
--- linux-2.6.0-test4/Documentation/kernel-parameters.txt	2003-08-31 08:08:=
00.000000000 -0400
+++ linux-2.6.0-test4_changed/Documentation/kernel-parameters.txt	2003-08-3=
1 08:15:29.000000000 -0400
@@ -785,6 +785,8 @@
=20
 	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
=20
+	psmouse_imps2	[HW,MOUSE] Probe only for Intellimouse PS2 mouse protocol e=
xtensions
+
 	pss=3D		[HW,OSS] Personal Sound System (ECHO ESC614)
 			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
=20
diff -urN linux-2.6.0-test4/drivers/input/mouse/psmouse-base.c linux-2.6.0-=
test4_changed/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0-test4/drivers/input/mouse/psmouse-base.c	2003-07-27 12:58:5=
1.000000000 -0400
+++ linux-2.6.0-test4_changed/drivers/input/mouse/psmouse-base.c	2003-08-31=
 08:15:29.000000000 -0400
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

"Linus, please apply.  Breaks everything.  But is cool." -- Rusty Russell.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/UfLKWv4KsgKfSVgRAmKCAKCeSsXajkN61DJe2edNvPx6keQoJgCglSXM
U5gVANN8HZqleghUy56OvLA=
=XqbA
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
