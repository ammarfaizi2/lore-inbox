Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTIAEkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTIAEkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 00:40:47 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:38302 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262290AbTIAEkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 00:40:35 -0400
Date: Mon, 1 Sep 2003 00:40:40 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH][RESEND] Force mouse detection as imps/2 (and fix my KVM switch)
Message-ID: <20030901044040.GA862@zion.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20030831130619.GA1804@zion.rivenstone.net> <20030831121432.4ac11574.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20030831121432.4ac11574.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2003 at 12:14:32PM -0700, Andrew Morton wrote:
> <jhf@rivenstone.net> wrote:
> >
> >     This patch is against -test4; it applies to -test4-mm4 with
> >  offsets (I'm running -mm4).  More than half the length of the patch is
> >  indentation.  Is there a possibility of getting this applied?
>=20
> Please resend as an attachment.  I was unable to de-mime it.

    Okay, I'm attaching a slightly changed patch that puts things back
in the roughly alphabetical order I found them in.  It compiles and
tests okay.

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="psmouse_imps2.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.6.0-test4/Documentation/kernel-parameters.txt linux-2.6.0=
-test4_changed/Documentation/kernel-parameters.txt
--- linux-2.6.0-test4/Documentation/kernel-parameters.txt	2003-08-31 08:08:=
00.000000000 -0400
+++ linux-2.6.0-test4_changed/Documentation/kernel-parameters.txt	2003-09-0=
1 00:17:53.000000000 -0400
@@ -783,6 +783,8 @@
 			before loading.
 			See Documentation/ramdisk.txt.
=20
+	psmouse_imps2	[HW,MOUSE] Probe only for Intellimouse PS2 mouse protocol e=
xtensions
+
 	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
=20
 	pss=3D		[HW,OSS] Personal Sound System (ECHO ESC614)
diff -urN linux-2.6.0-test4/drivers/input/mouse/psmouse-base.c linux-2.6.0-=
test4_changed/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0-test4/drivers/input/mouse/psmouse-base.c	2003-07-27 12:58:5=
1.000000000 -0400
+++ linux-2.6.0-test4_changed/drivers/input/mouse/psmouse-base.c	2003-09-01=
 00:17:25.000000000 -0400
@@ -23,6 +23,8 @@
=20
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
+MODULE_PARM(psmouse_imps2, "1i");
+MODULE_PARM_DESC(psmouse_imps2, "Limit protocol extensions to the Intellim=
ouse protocol.");
 MODULE_PARM(psmouse_noext, "1i");
 MODULE_PARM_DESC(psmouse_noext, "Disable any protocol extensions. Useful f=
or KVM switches.");
 MODULE_PARM(psmouse_resolution, "i");
@@ -33,6 +35,7 @@
=20
 #define PSMOUSE_LOGITECH_SMARTSCROLL	1
=20
+static int psmouse_imps2;
 static int psmouse_noext;
 int psmouse_resolution;
 int psmouse_smartscroll =3D PSMOUSE_LOGITECH_SMARTSCROLL;
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
@@ -549,6 +554,12 @@
 };
=20
 #ifndef MODULE
+static int __init psmouse_imps2_setup(char *str)
+{
+	psmouse_imps2 =3D 1;
+	return 1;
+}
+
 static int __init psmouse_noext_setup(char *str)
 {
 	psmouse_noext =3D 1;
@@ -567,6 +578,7 @@
 	return 1;
 }
=20
+__setup("psmouse_imps2", psmouse_imps2_setup);
 __setup("psmouse_noext", psmouse_noext_setup);
 __setup("psmouse_resolution=3D", psmouse_resolution_setup);
 __setup("psmouse_smartscroll=3D", psmouse_smartscroll_setup);

--ReaqsoxgOBHFXBhH--

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Us3IWv4KsgKfSVgRAkCqAKCb15Y2wlayWzUXzshW6fkeUjgE8wCdF3qE
rjl9f+ZuCh5T4ZF2pKIq4Ko=
=K8sS
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
