Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTDVCgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTDVCgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:36:21 -0400
Received: from dracula.eas.gatech.edu ([130.207.67.209]:11979 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S262845AbTDVCgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:36:15 -0400
Date: Mon, 21 Apr 2003 22:46:28 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5.68] [BUG #18] Add Synaptics touchpad tweaking to psmouse driver
Message-ID: <20030422024628.GA8906@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the side-effects of the new input layer is that the old usermode=20
tools for manipulating the touchpad configuration don't work any more.

Most importantly, the ability to disable the tap-to-click "feature".
And this has been long-recognized, as bug #18.  :)

So, here's my crack at scratching this itch.  it defaults to disabling=20
the tap-to-click, but there's a module parameter to re-enable it.

I started writing this from the perspective of a full-native synaptics
driver, using the absolute mode of operation, which will let us do all
sorts of yummy things like corner taps and virtual scroll wheels and
sensitivity and whatnot... Anyone else working on this, before I wade
further in?

All of the new code is wrapped in #ifdef SYNAPTICS.

It should work on all models of the touchpad, old and new, but I've only=20
tested this on my rev5.7 touchpad (Dell Inspiron 4100)

Feedback welcome!

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
                                                           ICQ #1318444
Quidquid latine dictum sit, altum viditur                 Melbourne, FL

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="psmouse_syn.diff"
Content-Transfer-Encoding: quoted-printable

--- psmouse.ORIG	2003-04-21 20:03:25.000000000 -0400
+++ psmouse.c	2003-04-21 22:42:19.000000000 -0400
@@ -10,6 +10,11 @@
  * the Free Software Foundation.
  */
=20
+/*=20
+ * Initial Snaptics support by Solomon Peachy (pizza@shaftnet.org)
+ */
+#define SYNAPTICS
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -25,6 +30,11 @@
=20
 static int psmouse_noext;
=20
+#ifdef SYNAPTICS
+static int synaptics_tap =3D 0;
+MODULE_PARM(synaptics_tap, "1i");
+#endif
+
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETRES	0x10e8
 #define PSMOUSE_CMD_GETINFO	0x03e9
@@ -33,6 +43,7 @@
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
+#define PSMOUSE_CMD_DISABLE	0x00f5
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
=20
@@ -40,6 +51,52 @@
 #define PSMOUSE_RET_ACK		0xfa
 #define PSMOUSE_RET_NAK		0xfe
=20
+#ifdef SYNAPTICS
+
+/* Synaptics special queries */
+#define STP_QRY_IDENTIFY	0x00
+#define STP_QRY_READ_MODES	0x01
+#define STP_QRY_READ_CAPS	0x02
+#define STP_QRY_READ_MODEL_ID	0x03
+#define STP_QRY_READ_SN_PREFIX	0x06
+#define STP_QRY_READ_SN_SUFFIX	0x07
+#define STP_QRY_READ_RES	0x08
+
+/* Model ID bits */
+#define STP_INFO_ROT180(id)	(((id) & 0x800000) >> 23)
+#define STP_INFO_PORTRAIT(id)	(((id) & 0x400000) >> 22)
+#define STP_INFO_SENSOR(id)	(((id) & 0x3F0000) >> 16)
+#define STP_INFO_HARDWARE(id)	(((id) & 0x00FE00) >> 9)
+#define STP_INFO_NEW_ABS(id)	(((id) & 0x000080) >> 7)
+#define STP_INFO_CAP_PEN(id)	(((id) & 0x000040) >> 6)
+#define STP_INFO_SIMPLE_CMD(id)	(((id) & 0x000020) >> 5)
+#define STP_INFO_GEOMETRY(id)	 ((id) & 0x00000F)
+
+#define STP_SET_MODE_ABSOLUTE(m, a)	(((m) &~ 0x80) | ((a) << 7))
+#define STP_SET_MODE_RATE(m, a)		(((m) &~ 0x40) | ((a) << 6))
+#define STP_SET_MODE_SLEEP(m, a)	(((m) &~ 0x08) | ((a) << 3))
+#define STP_SET_MODE_GESTURE(m, a)	(((m) &~ 0x04) | ((!a) << 2))
+#define STP_SET_MODE_PACKSIZE(m, a)	(((m) &~ 0x02) | ((a) << 1))
+#define STP_SET_MODE_WMODE(m, a)	(((m) &~ 0x01) | (a))
+
+#define STP_SET_OMODE_CORNER(m, a)	(((m) &~ 0x80000000) | ((a) << 31))
+#define STP_SET_OMODE_Z_THRESH(m, a)	(((m) &~ 0x70000000) | ((a) << 28))
+#define STP_SET_OMODE_TAP_MODE(m, a)	(((m) &~ 0x0C000000) | ((a) << 26))
+#define STP_SET_OMODE_EDGE_MOTN(m, a)	(((m) &~ 0x03000000) | ((a) << 24))
+#define STP_SET_OMODE_ABSOLUTE(m, a)	(((m) &~ 0x00800000) | ((a) << 23))
+#define STP_SET_OMODE_RATE(m, a)	(((m) &~ 0x00400000) | ((a) << 22))
+#define STP_SET_OMODE_BAUD(m, a)	(((m) &~ 0x00080000) | ((a) << 19))
+#define STP_SET_OMODE_3_BUTTON(m, a)	(((m) &~ 0x00040000) | ((a) << 18))
+#define STP_SET_OMODE_MIDDLE(m, a)	(((m) &~ 0x00020000) | ((a) << 17))
+#define STP_SET_OMODE_HOP(m, a)		(((m) &~ 0x00010000) | ((a) << 16))
+#define STP_SET_OMODE_RIGHT_MGN(m, a)	(((m) &~ 0x0000F000) | ((a) << 12))
+#define STP_SET_OMODE_LEFT_MGN(m, a)	(((m) &~ 0x00000F00) | ((a) << 8))
+#define STP_SET_OMODE_TOP_MGN(m, a)	(((m) &~ 0x000000F0) | ((a) << 4))
+#define STP_SET_OMODE_BOTTOM_MGN(m, a)	(((m) &~ 0x0000000F) |  (a))
+#define QUAD_MODE_BYTE		0x0302
+
+#endif
+
 struct psmouse {
 	struct input_dev dev;
 	struct serio *serio;
@@ -57,8 +114,22 @@
 	char error;
 	char devname[64];
 	char phys[32];
+
+#ifdef SYNAPTICS
+	unsigned int fw_version;
+	unsigned int single_mode_byte;
+	unsigned int model_id;
+	unsigned int modes;
+	unsigned int caps;
+#endif
 };
=20
+#ifdef SYNAPTICS
+static void synaptics_command(struct psmouse *psmouse, unsigned char cmd);
+static void synaptics_set_mode(struct psmouse *psmouse, unsigned int mode);
+unsigned int synaptics_get_mode(struct psmouse *psmouse);
+#endif
+
 #define PSMOUSE_PS2	1
 #define PSMOUSE_PS2PP	2
 #define PSMOUSE_PS2TPP	3
@@ -345,6 +416,54 @@
                   thing up. */
                psmouse->vendor =3D "Synaptics";
                psmouse->name =3D "TouchPad";
+
+#ifdef SYNAPTICS
+	       param[0] =3D 0;
+	       synaptics_command(psmouse, STP_QRY_IDENTIFY);
+	       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	       psmouse->fw_version =3D ((param[2] & 0x0f) << 8) | param[0];
+
+	       synaptics_command(psmouse, STP_QRY_READ_MODEL_ID);
+	       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+	       psmouse->model_id =3D ((param[1] & 0x1) ? 0x1 :
+				    (((unsigned int) param[0] << 16) |
+				     ((unsigned int) param[1] << 8) |
+				     ((unsigned int) param[2])));
+
+	       psmouse->single_mode_byte =3D STP_INFO_SIMPLE_CMD (psmouse->model_=
id);
+	       /* Fetch capabilities */
+	       synaptics_command(psmouse, STP_QRY_READ_MODEL_ID);
+	       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	       psmouse->caps =3D (((unsigned int) param[0] << 8) |=20
+				(unsigned int) param[2]);
+
+	       printk(KERN_INFO "Found Synaptics Touchpad rev %d.%d\n",
+		      (psmouse->fw_version >> 8) & 0x0f,
+		      (psmouse->fw_version & 0xff));
+
+	       /* pull the modes down */
+	       psmouse->modes =3D synaptics_get_mode(psmouse);
+
+	       /* Now, disable tap-to-click and enable high rate. */
+	      =20
+	       if (psmouse->single_mode_byte) {
+		       psmouse->modes =3D STP_SET_MODE_GESTURE(psmouse->modes, synaptics=
_tap);
+		       psmouse->modes =3D STP_SET_MODE_RATE(psmouse->modes, 1);
+
+		       synaptics_set_mode(psmouse, psmouse->modes);
+	       } else {
+		       psmouse->modes =3D STP_SET_OMODE_TAP_MODE(psmouse->modes, synapti=
cs_tap);
+		       psmouse->modes =3D STP_SET_OMODE_RATE(psmouse->modes, 1);
+
+		       synaptics_set_mode(psmouse, psmouse->modes);
+	       }
+			      =20
+	       psmouse->modes =3D synaptics_get_mode(psmouse);
+#else
+	       printk(KERN_INFO "Found Synaptics touchpad, support disabled\n");
+#endif
+
                return PSMOUSE_PS2;
        }
=20
@@ -682,5 +801,78 @@
 	serio_unregister_device(&psmouse_dev);
 }
=20
+#ifdef SYNAPTICS
+void synaptics_command(struct psmouse *psmouse, unsigned char cmd)=20
+{
+	unsigned char param[4];
+
+	param[0] =3D (cmd & 0xC0) >> 6;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	param[0] =3D (cmd & 0x30) >> 4;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	param[0] =3D (cmd & 0x0C) >> 2;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	param[0] =3D (cmd & 0x03);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+}
+
+void synaptics_set_mode(struct psmouse *psmouse, unsigned int mode)
+{
+	unsigned char param[4];
+//	printk(KERN_INFO "Synaptics set mode: %08x\n", mode);
+ =20
+	psmouse_command(psmouse, param, PSMOUSE_CMD_DISABLE);
+=09
+	if (psmouse->single_mode_byte) {
+		synaptics_command(psmouse, mode & 0xff);
+		param[0] =3D 20;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	} else {
+		synaptics_command(psmouse, (mode >> 24) & 0xff);
+		param[0] =3D 10;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+		synaptics_command(psmouse, (mode >> 16) & 0xff);
+		param[0] =3D 20;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+		if (psmouse->fw_version < QUAD_MODE_BYTE) {
+			synaptics_command(psmouse, (mode >> 8) & 0xff);
+			param[0] =3D 40;
+			psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+			synaptics_command(psmouse, mode & 0xff);
+			param[0] =3D 60;
+			psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+		}
+	}
+
+	psmouse_command(psmouse, param, PSMOUSE_CMD_ENABLE);
+}
+
+unsigned int synaptics_get_mode(struct psmouse *psmouse)
+{
+	unsigned char param[4];
+	unsigned int retval =3D 0;
+=09
+	synaptics_command(psmouse, STP_QRY_READ_MODES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+=09
+	param[1] =3D 0;
+=09
+	if (psmouse->single_mode_byte) {
+		retval =3D param[2];
+	} else {
+		retval =3D ((param[0] << 24) |
+			  (param[2] << 16));
+	=09
+		if (psmouse->fw_version < QUAD_MODE_BYTE) {
+			synaptics_command(psmouse, STP_QRY_READ_CAPS);
+			psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+			retval |=3D ((param[0] << 8) |
+				   (param[2]));
+		}=20
+	}
+	return retval;
+}
+#endif
+
 module_init(psmouse_init);
 module_exit(psmouse_exit);

--CE+1k2dSO48ffgeK--

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+pK0EPuLgii2759ARAtoMAJ90RMyczPk5osb+z6T+gaooZHcoLQCfdThO
ZMc6FA5WO5NSK5/XoEZHxf4=
=b1W/
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
