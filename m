Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTJ1D4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 22:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTJ1D4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 22:56:37 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:17673 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S263843AbTJ1D42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 22:56:28 -0500
Date: Mon, 27 Oct 2003 22:56:25 -0500
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031028035625.GB20145@rivenstone.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20031027140217.GA1065@averell> <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org> <20031028035244.GA20145@rivenstone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20031028035244.GA20145@rivenstone.net>
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2003 at 10:52:44PM -0500, I wrote:
> On Mon, Oct 27, 2003 at 08:32:15AM -0800, Linus Torvalds wrote:
> >=20
> > On Mon, 27 Oct 2003, Andi Kleen wrote:
> > >=20
> > > Overall as KVM user I must say I'm not very happy with the 2.6 mouse
> > > driver. 2.4 pretty much worked out of the box, but 2.6 needs
> > > lots of strange options (psmouse_noext, psmouse_rate=3D80)=20
> > > because it does things very differently out of the box.
> >=20
> > I agree. The keyboard driver has also deteriorated, I think.=20
> >=20
> > I'd suggest we _not_ set the rate by default at all (and let the default
> > thing just happen). And only set the rate if the user _asks_ for it with
> > your setup thing. Mind sending me that kind of patch?
> >=20
>=20
>     I need this patch to use the scroll wheel on my Logitech mouse
> with my Belkin KVM switch in 2.6. This patch was in -mm for a while
> before some changes there broke the diff, and I got some mail from
> people who said it was helpful.  I didn't hear about any problems.
>=20
>     Linus, will you please consider applying it?

    D'oh, forgot the patch.  This is the same patch that was in -mm,
rediffed against -test9 and tested to compile.  I've been running this
same patch on vanilla and -mm kernels for months now.

--=20
Joseph Fannin
jhf@rivenstone.net

Rothchild's Rule -- "For every phenomenon, however complex, someone will
eventually come up with a simple and elegant theory. This theory will
be wrong."

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="psmouse_imps2.diff"
Content-Transfer-Encoding: quoted-printable

diff -aur linux-2.6.0-test9_orig/Documentation/kernel-parameters.txt linux-=
2.6.0-test9/Documentation/kernel-parameters.txt
--- linux-2.6.0-test9_orig/Documentation/kernel-parameters.txt	2003-10-27 1=
5:50:46.000000000 -0500
+++ linux-2.6.0-test9/Documentation/kernel-parameters.txt	2003-10-27 15:53:=
58.000000000 -0500
@@ -790,6 +790,8 @@
 			before loading.
 			See Documentation/ramdisk.txt.
=20
+	psmouse_imps2	[HW,MOUSE] Probe only for Intellimouse PS2 mouse protocol e=
xtensions
+
 	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
=20
 	psmouse_resetafter=3D
diff -aur linux-2.6.0-test9_orig/drivers/input/mouse/psmouse-base.c linux-2=
=2E6.0-test9/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0-test9_orig/drivers/input/mouse/psmouse-base.c	2003-10-27 15=
:50:33.000000000 -0500
+++ linux-2.6.0-test9/drivers/input/mouse/psmouse-base.c	2003-10-27 15:53:5=
8.000000000 -0500
@@ -24,6 +24,8 @@
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
@@ -38,6 +40,7 @@
=20
 #define PSMOUSE_LOGITECH_SMARTSCROLL	1
=20
+static int psmouse_imps2;
 static int psmouse_noext;
 int psmouse_resolution;
 unsigned int psmouse_rate =3D 60;
@@ -275,66 +278,68 @@
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
@@ -627,6 +632,12 @@
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
@@ -651,6 +662,7 @@
 	return 1;
 }
=20
+__setup("psmouse_imps2", psmouse_imps2_setup);
 __setup("psmouse_noext", psmouse_noext_setup);
 __setup("psmouse_resolution=3D", psmouse_resolution_setup);
 __setup("psmouse_smartscroll=3D", psmouse_smartscroll_setup);

--yEPQxsgoJgBvi8ip--

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nejpWv4KsgKfSVgRAtFMAJ95JHaF+PzbgnQRSztGziyftyZW0wCeNYm9
zsW5UmjicPCNqarfQPpcxsI=
=MNL4
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
