Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWIJUKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWIJUKp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWIJUKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:10:45 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:48829 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S964859AbWIJUKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:10:42 -0400
Date: Sun, 10 Sep 2006 16:10:37 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Dmitry Torokhov <dtor@insightbb.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>
Subject: [RFC] OLPC tablet input driver, take two.
Message-ID: <20060910201036.GD4187@aehallh.com>
Mail-Followup-To: linux-input@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Torokhov <dtor@insightbb.com>
References: <20060829073339.GA4181@aehallh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20060829073339.GA4181@aehallh.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Take two, with most of the items people commented about addressed.


The OLPC will ship with a somewhat unique input device made by ALPS,
connected via PS/2 and speaking a protocol only loosely based on that
spoken by other ALPS devices.

This is required by the noticeable different between this device and
others made by alps, specificly that it is very wide, with the center
1/3rd usable with the GS sensor, and the entire area usable with the PT
sensor, with support for using both at once.

It uses a 9 byte protocol that differs enough that I split the driver
for this off from the ALPS driver.

The patch is below, but there are a few things of note.

1: Cosmetic: Some line lengths, and outputs with debugging enabled, are
over 80 columns wide.  I've fixed most of them, but it would just get
into ugly stuff to fix the last few remaining.  Suggestions are always
welcome though.

2: Technical, maybe: We're seeing a very low sample rate, however we're
fairly sure that this is due to the clock on our hardware, should be
verified sometime tomorrow.  It is doubtful that any changes to this
driver will be necessary.

3: Technical: At least the pressure range is a lot smaller then we are
reporting, leaving as is until others weigh in on if we need ALPS to
give a larger range.

4: Technical: I've not implemented the KCONFIG option for this driver
yet, it's on my todo list, but for after we get the sample rate stuff
figured out.


That said, here the patch is for comments.
(And possibly for the OLPC kernel tree for others with samples to play
with.)


Zephaniah E. Hull.


Signed-off-by: Zephaniah E. Hull <warp@aehallh.com>

diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 21a1de6..6218e5a 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -14,4 +14,4 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
+psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o olpc.o
diff --git a/drivers/input/mouse/olpc.c b/drivers/input/mouse/olpc.c
new file mode 100644
index 0000000..45a24ec
--- /dev/null
+++ b/drivers/input/mouse/olpc.c
@@ -0,0 +1,344 @@
+/*
+ * OLPC touchpad PS/2 mouse driver
+ *
+ * Copyright (c) 2006 One Laptop Per Child, inc.
+ * Author Zephaniah E. Hull.
+ *
+ * This driver is partly based on the ALPS driver, which is:
+ *
+ * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
+ * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
+ * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
+ * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * The touchpad on the OLPC is fairly wide, with the entire area usable
+ * as a tablet, and the center 1/3rd also usable as a touchpad.
+ *
+ * The device has simultanious reporting, so that both can be used at once.
+ *
+ * The PT+GS protocol is similar to the base ALPS protocol, in that the
+ * GS data is where the ALPS parser would expect to find it, however
+ * there are several additional bytes, the button bits are in a
+ * different byte, and the bits used for finger and gesture indication
+ * are replaced by two bits which indicate if it is reporting PT or GS
+ * coordinate data in that packet.
+ */
+
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/libps2.h>
+
+#include "psmouse.h"
+#include "olpc.h"
+
+static const struct olpc_model_info olpc_model_data[] = {
+	{ { 0x67, 0x00, 0x0a }, 0xeb, 0xff, 0 }, /* OLPC in PT+GS mode. */
+};
+
+/*
+ * OLPC absolute Mode - simultanious format
+ *
+ * byte 0:  1    1    1    0    1    0     1     1
+ * byte 1:  0  gx6  gx5  gx4  gx3  gx2   gx1   gx0
+ * byte 2:  0  gx10 gx9  gx8  gx7  px9   px8   px7
+ * byte 3:  0  gy9  gy8  gy7    1    ? pt-dsw gs-dsw
+ * byte 4:  0  gy6  gy5  gy4  gy3  gy2   gy1   gy0
+ * byte 5:  0  gz6  gz5  gz4  gz3  gz2   gz1   gz0
+ * byte 6:  0  py9  py8  py7    1    ?   swr   swl
+ * byte 7:  0  py6  py5  py4  py3  py2   py1   py0
+ * byte 8:  0  px6  px5  px4  px3  px2   px1   px0
+ *
+ * ?'s are not defined in the protocol spec, may vary between models.
+ *
+ * gx/gy/gz is for the GlideSensor.
+ * px/py is for the PenTablet sensor.
+ *
+ * swr/swl are the left/right buttons.
+ *
+ * pt-dsw/gs-dsw indicate that the pt/gs sensor is detecting a
+ * pen/finger and is thus sending data this packet.
+ */
+
+static void olpc_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	struct olpc_data *priv = psmouse->private;
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = psmouse->dev;
+	struct input_dev *dev2 = priv->dev2;
+	int px, py, gx, gy, gz, gs_down, pt_down, left, right;
+
+	input_regs(dev, regs);
+
+	left = packet[6] & 1;
+	right = packet[6] & 2;
+	gx = packet[1] | ((packet[2] & 0x78) << (7 - 3));
+	gy = packet[4] | ((packet[3] & 0x70) << (7 - 4));
+	gz = packet[5];
+	px = packet[8] | ((packet[2] & 0x7) << 7);
+	py = packet[7] | ((packet[6] & 0x70) << (7 - 4));
+
+	pt_down = packet[3] & 1;
+	gs_down = packet[3] & 2;
+
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev2, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
+	input_report_key(dev2, BTN_RIGHT, right);
+
+	input_report_key(dev, BTN_TOUCH, pt_down);
+	input_report_key(dev, BTN_TOOL_PEN, pt_down);
+	input_report_key(dev2, BTN_TOUCH, gs_down);
+	input_report_key(dev2, BTN_TOOL_FINGER, gs_down);
+
+	if (gs_down) {
+		input_report_abs(dev2, ABS_X, gx);
+		input_report_abs(dev2, ABS_Y, gy);
+	}
+	input_report_abs(dev2, ABS_PRESSURE, gz);
+
+	if (pt_down) {
+		input_report_abs(dev, ABS_X, px);
+		input_report_abs(dev, ABS_Y, py);
+	}
+
+	input_sync(dev);
+}
+
+static psmouse_ret_t olpc_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	struct olpc_data *priv = psmouse->private;
+	psmouse_ret_t ret = PSMOUSE_BAD_DATA;
+
+	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0) {
+		ret = PSMOUSE_BAD_DATA;
+		goto out;
+	}
+
+	/* Bytes 2 - 9 should have 0 in the highest bit */
+	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 9 &&
+		(psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
+	    ret = PSMOUSE_BAD_DATA;
+	    goto out;
+	}
+
+	/*
+	 * Bytes 4 and 7 should have 1 in the 4th bit, and the high bit unset.
+	 */
+	if ((psmouse->pktcnt == 4 || psmouse->pktcnt == 7) &&
+		((psmouse->packet[psmouse->pktcnt - 1] & 0x88) != 8)) {
+	    ret = PSMOUSE_BAD_DATA;
+	    goto out;
+	}
+
+	if (psmouse->pktcnt == 9) {
+	    olpc_process_packet(psmouse, regs);
+
+	    ret = PSMOUSE_FULL_PACKET;
+	    goto out;
+	}
+
+	ret = PSMOUSE_GOOD_DATA;
+out:
+	if (ret != PSMOUSE_GOOD_DATA)
+		dev_dbg(psmouse->dev->cdev.dev, "olpc.c(%d): ret: %d, len: %u,"
+			"data: %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x",
+			__LINE__, ret, psmouse->pktcnt,
+			psmouse->packet[0], psmouse->packet[1],
+			psmouse->packet[2], psmouse->packet[3],
+			psmouse->packet[4], psmouse->packet[5],
+			psmouse->packet[6], psmouse->packet[7],
+			psmouse->packet[8]);
+	return ret;
+}
+
+static const struct olpc_model_info *olpc_get_model(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[4];
+	int i;
+
+	/*
+	 * Now try "E7 report". Allowed responses are in
+	 * olpc_model_data[].signature
+	 */
+	if (ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21))
+		return NULL;
+
+	param[0] = param[1] = param[2] = 0xff;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+		return NULL;
+
+	pr_debug("olpc.c(%d): E7 report: %2.2x %2.2x %2.2x",
+		__LINE__, param[0], param[1], param[2]);
+
+	for (i = 0; i < ARRAY_SIZE(olpc_model_data); i++)
+		if (!memcmp(param, olpc_model_data[i].signature,
+			    sizeof(olpc_model_data[i].signature)))
+			return olpc_model_data + i;
+
+	return NULL;
+}
+
+static int olpc_absolute_mode(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param;
+
+	/* Switch to 'Advanced mode.', four disables in a row. */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
+		return -1;
+
+	/*
+	 * Switch to simultanious mode, F2 (GETID) three times with no
+	 * arguments or reply, followed by SETRES with an argument of 2.
+	 */
+	ps2_command(ps2dev, NULL, 0xF2);
+	ps2_command(ps2dev, NULL, 0xF2);
+	ps2_command(ps2dev, NULL, 0xF2);
+	param = 0x02;
+	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
+
+	ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+	param = 100;
+	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
+
+	return 0;
+}
+
+/*
+ * olpc_poll() - poll the touchpad for current motion packet.
+ * Used in resync.
+ * Note: We can't poll, so always return failure.
+ */
+static int olpc_poll(struct psmouse *psmouse)
+{
+	return -1;
+}
+
+static int olpc_reconnect(struct psmouse *psmouse)
+{
+	struct olpc_data *priv = psmouse->private;
+
+	psmouse_reset(psmouse);
+
+	if (!(priv->i = olpc_get_model(psmouse)))
+		return -1;
+
+	if (olpc_absolute_mode(psmouse)) {
+		printk(KERN_ERR "olpc.c: Failed to reenable absolute mode.\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void olpc_disconnect(struct psmouse *psmouse)
+{
+	struct olpc_data *priv = psmouse->private;
+
+	psmouse_reset(psmouse);
+	input_unregister_device(priv->dev2);
+	kfree(priv);
+}
+
+int olpc_init(struct psmouse *psmouse)
+{
+	struct olpc_data *priv;
+	struct input_dev *dev = psmouse->dev;
+	struct input_dev *dev2;
+
+	priv = kzalloc(sizeof(struct olpc_data), GFP_KERNEL);
+	dev2 = input_allocate_device();
+	if (!priv || !dev2)
+		goto init_fail;
+
+	psmouse->private = priv;
+	priv->dev2 = dev2;
+
+	if (!(priv->i = olpc_get_model(psmouse)))
+		goto init_fail;
+
+	if (olpc_absolute_mode(psmouse)) {
+		printk(KERN_ERR "olpc.c: Failed to enable absolute mode\n");
+		goto init_fail;
+	}
+
+	/*
+	 * Unset some of the default bits for things we don't have.
+	 */
+	dev->evbit[LONG(EV_REL)] &= ~BIT(EV_REL);
+	dev->relbit[LONG(REL_X)] &= ~(BIT(REL_X) | BIT(REL_Y));
+	dev->keybit[LONG(BTN_MIDDLE)] &= ~BIT(BTN_MIDDLE);
+
+	dev->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
+	dev->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	dev->keybit[LONG(BTN_TOOL_PEN)] |= BIT(BTN_TOOL_PEN);
+	dev->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT);
+
+	dev->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
+	input_set_abs_params(dev, ABS_X, 0, 1023, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, 1023, 0, 0);
+
+	snprintf(priv->phys, sizeof(priv->phys),
+		"%s/input1", psmouse->ps2dev.serio->phys);
+	dev2->phys = priv->phys;
+	dev2->name = "OLPC ALPS GlideSensor";
+	dev2->id.bustype = BUS_I8042;
+	dev2->id.vendor  = 0x0002;
+	dev2->id.product = PSMOUSE_OLPC;
+	dev2->id.version = 0x0000;
+
+	dev2->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
+	dev2->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	dev2->keybit[LONG(BTN_TOOL_FINGER)] |= BIT(BTN_TOOL_FINGER);
+	dev2->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT);
+
+	dev2->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
+	input_set_abs_params(dev2, ABS_X, 0, 2047, 0, 0);
+	input_set_abs_params(dev2, ABS_Y, 0, 1023, 0, 0);
+	input_set_abs_params(dev2, ABS_PRESSURE, 0, 63, 0, 0);
+
+	if (input_register_device(dev2))
+	    goto init_fail;
+
+	psmouse->protocol_handler = olpc_process_byte;
+	psmouse->poll = olpc_poll;
+	psmouse->disconnect = olpc_disconnect;
+	psmouse->reconnect = olpc_reconnect;
+	psmouse->pktsize = 9;
+
+	/* Disable the idle resync. */
+	psmouse->resync_time = 0;
+
+	return 0;
+
+init_fail:
+	input_free_device(dev2);
+	kfree(priv);
+	return -1;
+}
+
+int olpc_detect(struct psmouse *psmouse, int set_properties)
+{
+	if (!olpc_get_model(psmouse))
+		return -1;
+
+	if (set_properties) {
+		psmouse->vendor = "ALPS";
+		psmouse->name = "PenTablet";
+		psmouse->model = 0;
+	}
+	return 0;
+}
+
diff --git a/drivers/input/mouse/olpc.h b/drivers/input/mouse/olpc.h
new file mode 100644
index 0000000..8ed2e96
--- /dev/null
+++ b/drivers/input/mouse/olpc.h
@@ -0,0 +1,35 @@
+/*
+ * OLPC touchpad PS/2 mouse driver
+ *
+ * Copyright (c) 2006 One Laptop Per Child, inc.
+ *
+ * This driver is partly based on the ALPS driver.
+ * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
+ * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _OLPC_H
+#define _OLPC_H
+
+int olpc_detect(struct psmouse *psmouse, int set_properties);
+int olpc_init(struct psmouse *psmouse);
+
+struct olpc_model_info {
+        unsigned char signature[3];
+        unsigned char byte0, mask0;
+        unsigned char flags;
+};
+
+struct olpc_data {
+	struct input_dev *dev2;		/* Relative device */
+	char name[32];			/* Name */
+	char phys[32];			/* Phys */
+	const struct olpc_model_info *i;/* Info */
+};
+
+
+#endif
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 8bc9f51..20060b0 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -26,6 +26,7 @@
 #include "synaptics.h"
 #include "logips2pp.h"
 #include "alps.h"
+#include "olpc.h"
 #include "lifebook.h"
 #include "trackpoint.h"
 
@@ -616,6 +617,15 @@ static int psmouse_extensions(struct psm
  */
 			max_proto = PSMOUSE_IMEX;
 		}
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+		if (olpc_detect(psmouse, set_properties) == 0) {
+			if (!set_properties || olpc_init(psmouse) == 0)
+				return PSMOUSE_OLPC;
+/*
+ * Init failed, try basic relative protocols
+ */
+			max_proto = PSMOUSE_IMEX;
+		}
 	}
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
@@ -726,6 +736,13 @@ static struct psmouse_protocol psmouse_p
 		.detect		= trackpoint_detect,
 	},
 	{
+		.type		= PSMOUSE_OLPC,
+		.name		= "OLPC",
+		.alias		= "olpc",
+		.maxproto	= 1,
+		.detect		= olpc_detect,
+	},
+	{
 		.type		= PSMOUSE_AUTO,
 		.name		= "auto",
 		.alias		= "any",
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 4d9107f..f3d7199 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -42,7 +42,7 @@ struct psmouse {
 	struct work_struct resync_work;
 	char *vendor;
 	char *name;
-	unsigned char packet[8];
+	unsigned char packet[9];
 	unsigned char badbyte;
 	unsigned char pktcnt;
 	unsigned char pktsize;
@@ -86,6 +86,7 @@ enum psmouse_type {
 	PSMOUSE_ALPS,
 	PSMOUSE_LIFEBOOK,
 	PSMOUSE_TRACKPOINT,
+	PSMOUSE_OLPC,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

     "First they came for the Jews, and I didn't speak out - because I
was not a jew. Then they came for the Communists, and I did not speak
out - because I was not a Communist. Then they came for the trade
unionists, and I did not speak out - because I was not a trade unionist.
Then they came for me and there was no one left to speak for me!"
  - Pastor Niemoeller - victim of Hitler's Nazis

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBHE8RFMAi+ZaeAERAsECAKC6TXUjCFsvH45Qaxz8wB5RQlvvxQCfZYP8
qXJffqLtq3MnDKJ50BeYODs=
=LES1
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
