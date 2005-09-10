Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVIJWlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVIJWlv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVIJWdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:33:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:17828 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932340AbVIJWdt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:49 -0400
Subject: [PATCH 1/26] psmouse - add support for IBM TrackPoint devices.
In-Reply-To: <20050910223217.GA23380@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:11 +0200
Message-Id: <1126391651592@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: psmouse - add support for IBM TrackPoint devices.
From: Stephen Evanchik <evanchsa@gmail.com>
Date: 1123482378 -0500

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/mouse/Makefile       |    2 
 drivers/input/mouse/psmouse-base.c |   15 ++
 drivers/input/mouse/psmouse.h      |    1 
 drivers/input/mouse/trackpoint.c   |  297 ++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/trackpoint.h   |  147 ++++++++++++++++++
 5 files changed, 460 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/mouse/trackpoint.c
 create mode 100644 drivers/input/mouse/trackpoint.h

541e316aed6f7d6efeb427a88645c2a8f61418d6
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o
+psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -25,6 +25,7 @@
 #include "logips2pp.h"
 #include "alps.h"
 #include "lifebook.h"
+#include "trackpoint.h"
 
 #define DRIVER_DESC	"PS/2 mouse driver"
 
@@ -520,6 +521,12 @@ static int psmouse_extensions(struct psm
 		return PSMOUSE_IMPS;
 
 /*
+ * Try to initialize the IBM TrackPoint
+ */
+	if (max_proto > PSMOUSE_IMEX && trackpoint_detect(psmouse, set_properties) == 0)
+		return PSMOUSE_TRACKPOINT;
+
+/*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
  */
@@ -600,6 +607,12 @@ static struct psmouse_protocol psmouse_p
 		.init		= lifebook_init,
 	},
 	{
+		.type		= PSMOUSE_TRACKPOINT,
+		.name		= "TPPS/2",
+		.alias		= "trackpoint",
+		.detect		= trackpoint_detect,
+	},
+	{
 		.type		= PSMOUSE_AUTO,
 		.name		= "auto",
 		.alias		= "any",
@@ -1234,7 +1247,7 @@ static int psmouse_set_maxproto(const ch
 
 	*((unsigned int *)kp->arg) = proto->type;
 
-	return 0;					\
+	return 0;
 }
 
 static int psmouse_get_maxproto(char *buffer, struct kernel_param *kp)
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -78,6 +78,7 @@ enum psmouse_type {
 	PSMOUSE_SYNAPTICS,
 	PSMOUSE_ALPS,
 	PSMOUSE_LIFEBOOK,
+	PSMOUSE_TRACKPOINT,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
new file mode 100644
--- /dev/null
+++ b/drivers/input/mouse/trackpoint.c
@@ -0,0 +1,297 @@
+/*
+ * Stephen Evanchik <evanchsa@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#include <linux/delay.h>
+#include <linux/serio.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/input.h>
+#include <linux/libps2.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include "psmouse.h"
+#include "trackpoint.h"
+
+PSMOUSE_DEFINE_ATTR(sensitivity);
+PSMOUSE_DEFINE_ATTR(speed);
+PSMOUSE_DEFINE_ATTR(inertia);
+PSMOUSE_DEFINE_ATTR(reach);
+PSMOUSE_DEFINE_ATTR(draghys);
+PSMOUSE_DEFINE_ATTR(mindrag);
+PSMOUSE_DEFINE_ATTR(thresh);
+PSMOUSE_DEFINE_ATTR(upthresh);
+PSMOUSE_DEFINE_ATTR(ztime);
+PSMOUSE_DEFINE_ATTR(jenks);
+PSMOUSE_DEFINE_ATTR(press_to_select);
+PSMOUSE_DEFINE_ATTR(skipback);
+PSMOUSE_DEFINE_ATTR(ext_dev);
+
+#define MAKE_ATTR_READ(_item) \
+	static ssize_t psmouse_attr_show_##_item(struct psmouse *psmouse, char *buf) \
+	{ \
+		struct trackpoint_data *tp = psmouse->private; \
+		return sprintf(buf, "%lu\n", (unsigned long)tp->_item); \
+	}
+
+#define MAKE_ATTR_WRITE(_item, command) \
+	static ssize_t psmouse_attr_set_##_item(struct psmouse *psmouse, const char *buf, size_t count) \
+	{ \
+		char *rest; \
+		unsigned long value; \
+		struct trackpoint_data *tp = psmouse->private; \
+		value = simple_strtoul(buf, &rest, 10); \
+		if (*rest) \
+			return -EINVAL; \
+		tp->_item = value; \
+		trackpoint_write(&psmouse->ps2dev, command, tp->_item); \
+		return count; \
+	}
+
+#define MAKE_ATTR_TOGGLE(_item, command, mask) \
+	static ssize_t psmouse_attr_set_##_item(struct psmouse *psmouse, const char *buf, size_t count) \
+	{ \
+		unsigned char toggle; \
+		struct trackpoint_data *tp = psmouse->private; \
+		toggle = (buf[0] == '1') ? 1 : 0; \
+		if (toggle != tp->_item) { \
+			tp->_item = toggle; \
+			trackpoint_toggle_bit(&psmouse->ps2dev, command, mask); \
+		} \
+		return count; \
+	}
+
+/*
+ * Device IO: read, write and toggle bit
+ */
+static int trackpoint_read(struct ps2dev *ps2dev, unsigned char loc, unsigned char *results)
+{
+	if (ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND)) ||
+	    ps2_command(ps2dev, results, MAKE_PS2_CMD(0, 1, loc))) {
+		return -1;
+	}
+
+	return 0;
+}
+
+static int trackpoint_write(struct ps2dev *ps2dev, unsigned char loc, unsigned char val)
+{
+	if (ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND)) ||
+	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_WRITE_MEM)) ||
+	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, loc)) ||
+	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, val))) {
+		return -1;
+	}
+
+	return 0;
+}
+
+static int trackpoint_toggle_bit(struct ps2dev *ps2dev, unsigned char loc, unsigned char mask)
+{
+	/* Bad things will happen if the loc param isn't in this range */
+	if (loc < 0x20 || loc >= 0x2F)
+		return -1;
+
+	if (ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_COMMAND)) ||
+	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, TP_TOGGLE)) ||
+	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, loc)) ||
+	    ps2_command(ps2dev, NULL, MAKE_PS2_CMD(0, 0, mask))) {
+		return -1;
+	}
+
+	return 0;
+}
+
+MAKE_ATTR_WRITE(sensitivity, TP_SENS);
+MAKE_ATTR_READ(sensitivity);
+
+MAKE_ATTR_WRITE(speed, TP_SPEED);
+MAKE_ATTR_READ(speed);
+
+MAKE_ATTR_WRITE(inertia, TP_INERTIA);
+MAKE_ATTR_READ(inertia);
+
+MAKE_ATTR_WRITE(reach, TP_REACH);
+MAKE_ATTR_READ(reach);
+
+MAKE_ATTR_WRITE(draghys, TP_DRAGHYS);
+MAKE_ATTR_READ(draghys);
+
+MAKE_ATTR_WRITE(mindrag, TP_MINDRAG);
+MAKE_ATTR_READ(mindrag);
+
+MAKE_ATTR_WRITE(thresh, TP_THRESH);
+MAKE_ATTR_READ(thresh);
+
+MAKE_ATTR_WRITE(upthresh, TP_UP_THRESH);
+MAKE_ATTR_READ(upthresh);
+
+MAKE_ATTR_WRITE(ztime, TP_Z_TIME);
+MAKE_ATTR_READ(ztime);
+
+MAKE_ATTR_WRITE(jenks, TP_JENKS_CURV);
+MAKE_ATTR_READ(jenks);
+
+MAKE_ATTR_TOGGLE(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON);
+MAKE_ATTR_READ(press_to_select);
+
+MAKE_ATTR_TOGGLE(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK);
+MAKE_ATTR_READ(skipback);
+
+MAKE_ATTR_TOGGLE(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV);
+MAKE_ATTR_READ(ext_dev);
+
+static struct attribute *trackpoint_attrs[] = {
+	&psmouse_attr_sensitivity.attr,
+	&psmouse_attr_speed.attr,
+	&psmouse_attr_inertia.attr,
+	&psmouse_attr_reach.attr,
+	&psmouse_attr_draghys.attr,
+	&psmouse_attr_mindrag.attr,
+	&psmouse_attr_thresh.attr,
+	&psmouse_attr_upthresh.attr,
+	&psmouse_attr_ztime.attr,
+	&psmouse_attr_jenks.attr,
+	&psmouse_attr_press_to_select.attr,
+	&psmouse_attr_skipback.attr,
+	&psmouse_attr_ext_dev.attr,
+	NULL
+};
+
+static struct attribute_group trackpoint_attr_group = {
+	.attrs = trackpoint_attrs,
+};
+
+static void trackpoint_disconnect(struct psmouse *psmouse)
+{
+	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj, &trackpoint_attr_group);
+
+	kfree(psmouse->private);
+	psmouse->private = NULL;
+}
+
+static int trackpoint_sync(struct psmouse *psmouse)
+{
+	unsigned char toggle;
+	struct trackpoint_data *tp = psmouse->private;
+
+	if (!tp)
+		return -1;
+
+	/* Disable features that may make device unusable with this driver */
+	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_TWOHAND, &toggle);
+	if (toggle & TP_MASK_TWOHAND)
+		trackpoint_toggle_bit(&psmouse->ps2dev, TP_TOGGLE_TWOHAND, TP_MASK_TWOHAND);
+
+	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_SOURCE_TAG, &toggle);
+	if (toggle & TP_MASK_SOURCE_TAG)
+		trackpoint_toggle_bit(&psmouse->ps2dev, TP_TOGGLE_SOURCE_TAG, TP_MASK_SOURCE_TAG);
+
+	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_MB, &toggle);
+	if (toggle & TP_MASK_MB)
+		trackpoint_toggle_bit(&psmouse->ps2dev, TP_TOGGLE_MB, TP_MASK_MB);
+
+	/* Push the config to the device */
+	trackpoint_write(&psmouse->ps2dev, TP_SENS, tp->sensitivity);
+	trackpoint_write(&psmouse->ps2dev, TP_INERTIA, tp->inertia);
+	trackpoint_write(&psmouse->ps2dev, TP_SPEED, tp->speed);
+
+	trackpoint_write(&psmouse->ps2dev, TP_REACH, tp->reach);
+	trackpoint_write(&psmouse->ps2dev, TP_DRAGHYS, tp->draghys);
+	trackpoint_write(&psmouse->ps2dev, TP_MINDRAG, tp->mindrag);
+
+	trackpoint_write(&psmouse->ps2dev, TP_THRESH, tp->thresh);
+	trackpoint_write(&psmouse->ps2dev, TP_UP_THRESH, tp->upthresh);
+
+	trackpoint_write(&psmouse->ps2dev, TP_Z_TIME, tp->ztime);
+	trackpoint_write(&psmouse->ps2dev, TP_JENKS_CURV, tp->jenks);
+
+	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_PTSON, &toggle);
+	if (((toggle & TP_MASK_PTSON) == TP_MASK_PTSON) != tp->press_to_select)
+		 trackpoint_toggle_bit(&psmouse->ps2dev, TP_TOGGLE_PTSON, TP_MASK_PTSON);
+
+	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_SKIPBACK, &toggle);
+	if (((toggle & TP_MASK_SKIPBACK) == TP_MASK_SKIPBACK) != tp->skipback)
+		trackpoint_toggle_bit(&psmouse->ps2dev, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK);
+
+	trackpoint_read(&psmouse->ps2dev, TP_TOGGLE_EXT_DEV, &toggle);
+	if (((toggle & TP_MASK_EXT_DEV) == TP_MASK_EXT_DEV) != tp->ext_dev)
+		trackpoint_toggle_bit(&psmouse->ps2dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV);
+
+	return 0;
+}
+
+static void trackpoint_defaults(struct trackpoint_data *tp)
+{
+	tp->press_to_select = TP_DEF_PTSON;
+	tp->sensitivity = TP_DEF_SENS;
+	tp->speed = TP_DEF_SPEED;
+	tp->reach = TP_DEF_REACH;
+
+	tp->draghys = TP_DEF_DRAGHYS;
+	tp->mindrag = TP_DEF_MINDRAG;
+
+	tp->thresh = TP_DEF_THRESH;
+	tp->upthresh = TP_DEF_UP_THRESH;
+
+	tp->ztime = TP_DEF_Z_TIME;
+	tp->jenks = TP_DEF_JENKS_CURV;
+
+	tp->inertia = TP_DEF_INERTIA;
+	tp->skipback = TP_DEF_SKIPBACK;
+	tp->ext_dev = TP_DEF_EXT_DEV;
+}
+
+int trackpoint_detect(struct psmouse *psmouse, int set_properties)
+{
+	struct trackpoint_data *priv;
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char firmware_id;
+	unsigned char button_info;
+	unsigned char param[2];
+
+	param[0] = param[1] = 0;
+
+	if (ps2_command(ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
+		return -1;
+
+	if (param[0] != TP_MAGIC_IDENT)
+		return -1;
+
+	if (!set_properties)
+		return 0;
+
+	firmware_id = param[1];
+
+	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
+		printk(KERN_WARNING "trackpoint.c: failed to get extended button data\n");
+		button_info = 0;
+	}
+
+	psmouse->private = priv = kcalloc(1, sizeof(struct trackpoint_data), GFP_KERNEL);
+	if (!priv)
+		return -1;
+
+	psmouse->vendor = "IBM";
+	psmouse->name = "TrackPoint";
+
+	psmouse->reconnect = trackpoint_sync;
+	psmouse->disconnect = trackpoint_disconnect;
+
+	trackpoint_defaults(priv);
+	trackpoint_sync(psmouse);
+
+	sysfs_create_group(&ps2dev->serio->dev.kobj, &trackpoint_attr_group);
+
+	printk(KERN_INFO "IBM TrackPoint firmware: 0x%02x, buttons: %d/%d\n",
+		firmware_id, (button_info & 0xf0) >> 4, button_info & 0x0f);
+
+	return 0;
+}
+
diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
new file mode 100644
--- /dev/null
+++ b/drivers/input/mouse/trackpoint.h
@@ -0,0 +1,147 @@
+/*
+ * IBM TrackPoint PS/2 mouse driver
+ *
+ * Stephen Evanchik <evanchsa@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _TRACKPOINT_H
+#define _TRACKPOINT_H
+
+/*
+ * These constants are from the TrackPoint System
+ * Engineering documentation Version 4 from IBM Watson
+ * research:
+ *	http://wwwcssrv.almaden.ibm.com/trackpoint/download.html
+ */
+
+#define TP_COMMAND		0xE2	/* Commands start with this */
+
+#define TP_READ_ID		0xE1	/* Sent for device identification */
+#define TP_MAGIC_IDENT		0x01	/* Sent after a TP_READ_ID followed */
+					/* by the firmware ID */
+
+
+/*
+ * Commands
+ */
+#define TP_RECALIB		0x51	/* Recalibrate */
+#define TP_POWER_DOWN		0x44	/* Can only be undone through HW reset */
+#define TP_EXT_DEV		0x21	/* Determines if external device is connected (RO) */
+#define TP_EXT_BTN		0x4B	/* Read extended button status */
+#define TP_POR			0x7F	/* Execute Power on Reset */
+#define TP_POR_RESULTS		0x25	/* Read Power on Self test results */
+#define TP_DISABLE_EXT		0x40	/* Disable external pointing device */
+#define TP_ENABLE_EXT		0x41	/* Enable external pointing device */
+
+/*
+ * Mode manipulation
+ */
+#define TP_SET_SOFT_TRANS	0x4E	/* Set mode */
+#define TP_CANCEL_SOFT_TRANS	0xB9	/* Cancel mode */
+#define TP_SET_HARD_TRANS	0x45	/* Mode can only be set */
+
+
+/*
+ * Register oriented commands/properties
+ */
+#define TP_WRITE_MEM		0x81
+#define TP_READ_MEM		0x80	/* Not used in this implementation */
+
+/*
+* RAM Locations for properties
+ */
+#define TP_SENS			0x4A	/* Sensitivity */
+#define TP_MB			0x4C	/* Read Middle Button Status (RO) */
+#define TP_INERTIA		0x4D	/* Negative Inertia */
+#define TP_SPEED		0x60	/* Speed of TP Cursor */
+#define TP_REACH		0x57	/* Backup for Z-axis press */
+#define TP_DRAGHYS		0x58	/* Drag Hysteresis */
+					/* (how hard it is to drag */
+					/* with Z-axis pressed) */
+
+#define TP_MINDRAG		0x59	/* Minimum amount of force needed */
+					/* to trigger dragging */
+
+#define TP_THRESH		0x5C	/* Minimum value for a Z-axis press */
+#define TP_UP_THRESH		0x5A	/* Used to generate a 'click' on Z-axis */
+#define TP_Z_TIME		0x5E	/* How sharp of a press */
+#define TP_JENKS_CURV		0x5D	/* Minimum curvature for double click */
+
+/*
+ * Toggling Flag bits
+ */
+#define TP_TOGGLE		0x47	/* Toggle command */
+
+#define TP_TOGGLE_MB		0x23	/* Disable/Enable Middle Button */
+#define TP_MASK_MB			0x01
+#define TP_TOGGLE_EXT_DEV	0x23	/* Toggle external device */
+#define TP_MASK_EXT_DEV			0x02
+#define TP_TOGGLE_DRIFT		0x23	/* Drift Correction */
+#define TP_MASK_DRIFT			0x80
+#define TP_TOGGLE_BURST		0x28	/* Burst Mode */
+#define TP_MASK_BURST			0x80
+#define TP_TOGGLE_PTSON		0x2C	/* Press to Select */
+#define TP_MASK_PTSON			0x01
+#define TP_TOGGLE_HARD_TRANS	0x2C	/* Alternate method to set Hard Transparency */
+#define TP_MASK_HARD_TRANS		0x80
+#define TP_TOGGLE_TWOHAND	0x2D	/* Two handed */
+#define TP_MASK_TWOHAND			0x01
+#define TP_TOGGLE_STICKY_TWO	0x2D	/* Sticky two handed */
+#define TP_MASK_STICKY_TWO		0x04
+#define TP_TOGGLE_SKIPBACK	0x2D	/* Suppress movement after drag release */
+#define TP_MASK_SKIPBACK		0x08
+#define TP_TOGGLE_SOURCE_TAG	0x20	/* Bit 3 of the first packet will be set to
+					   to the origin of the packet (external or TP) */
+#define TP_MASK_SOURCE_TAG		0x80
+#define TP_TOGGLE_EXT_TAG	0x22	/* Bit 3 of the first packet coming from the
+					   external device will be forced to 1 */
+#define TP_MASK_EXT_TAG			0x04
+
+
+/* Power on Self Test Results */
+#define TP_POR_SUCCESS		0x3B
+
+/*
+ * Default power on values
+ */
+#define TP_DEF_SENS		0x80
+#define TP_DEF_INERTIA		0x06
+#define TP_DEF_SPEED		0x61
+#define TP_DEF_REACH		0x0A
+
+#define TP_DEF_DRAGHYS		0xFF
+#define TP_DEF_MINDRAG		0x14
+
+#define TP_DEF_THRESH		0x08
+#define TP_DEF_UP_THRESH	0xFF
+#define TP_DEF_Z_TIME		0x26
+#define TP_DEF_JENKS_CURV	0x87
+
+/* Toggles */
+#define TP_DEF_MB		0x00
+#define TP_DEF_PTSON		0x00
+#define TP_DEF_SKIPBACK		0x00
+#define TP_DEF_EXT_DEV		0x01
+
+#define MAKE_PS2_CMD(params, results, cmd) ((params<<12) | (results<<8) | (cmd))
+
+struct trackpoint_data
+{
+	unsigned char sensitivity, speed, inertia, reach;
+	unsigned char draghys, mindrag;
+	unsigned char thresh, upthresh;
+	unsigned char ztime, jenks;
+
+	unsigned char press_to_select;
+	unsigned char skipback;
+
+	unsigned char ext_dev;
+};
+
+extern int trackpoint_detect(struct psmouse *psmouse, int set_properties);
+
+#endif /* _TRACKPOINT_H */

