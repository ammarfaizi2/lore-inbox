Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVBKUOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVBKUOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVBKUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:13:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:23727 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262330AbVBKUJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:09:45 -0500
Date: Fri, 11 Feb 2005 21:10:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050211201013.GA6937@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I've reimplemented the Lifebook touchscreen driver using libps2 and
input, to make it short and fitting into the kernel drivers.

Please comment on code and test for functionality!

PS.: The driver should register two input devices. It doesn't yet,
since that isn't very straightforward in the psmouse framework.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lifebook

ChangeSet@1.2020, 2005-02-11 21:03:32+01:00, vojtech@suse.cz
  input: Fujitsu Lifebook driver, experimental.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 Makefile       |    2 
 lifebook.c     |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lifebook.h     |   16 ++++++
 psmouse-base.c |    6 ++
 psmouse.h      |    1 
 5 files changed, 157 insertions(+), 2 deletions(-)


diff -Nru a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
--- a/drivers/input/mouse/Makefile	2005-02-11 21:04:00 +01:00
+++ b/drivers/input/mouse/Makefile	2005-02-11 21:04:00 +01:00
@@ -15,4 +15,4 @@
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
+psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o
diff -Nru a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/mouse/lifebook.c	2005-02-11 21:04:00 +01:00
@@ -0,0 +1,134 @@
+/*
+ * Fujitsu B-series Lifebook PS/2 TouchScreen driver
+ *
+ * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ *
+ * TouchSceeen detection, absolute mode setting and packet layout is taken from
+ * Harald Hoyer's description of the device.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/libps2.h>
+
+#include "psmouse.h"
+#include "lifebook.h"
+
+static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = &psmouse->dev;
+
+	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
+		if (psmouse->pktcnt == 3) {
+
+			input_regs(dev, regs);
+			input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
+			input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
+			input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
+			input_report_rel(dev, REL_X, packet[1] ?
+				(int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
+			input_report_rel(dev, REL_Y, packet[2] ?
+				(int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
+			input_sync(dev);
+
+			return PSMOUSE_FULL_PACKET;
+		}
+		return PSMOUSE_GOOD_DATA;
+	}
+
+	if ((psmouse->packet[0] & 0x0b) == 0x00) { /* Absolute packet */
+		if (psmouse->pktcnt == 3) {
+
+			input_regs(dev, regs);
+			input_report_key(dev, BTN_TOUCH,   packet[0]       & 4);
+			input_report_rel(dev, ABS_X, ((packet[0] & 0x30) << 4) | packet[1]);
+			input_report_rel(dev, ABS_Y, ((packet[0] & 0xc0) << 2) | packet[2]);
+			input_sync(dev);
+
+			return PSMOUSE_FULL_PACKET;
+		}
+		return PSMOUSE_GOOD_DATA;
+	}
+
+	return PSMOUSE_BAD_DATA;
+}
+
+static int lifebook_reconnect(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param;
+
+	param = 7;
+	if (ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES))
+		return -1;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE))
+		return -1;
+
+	return 0;
+}
+
+static void lifebook_disconnect(struct psmouse *psmouse)
+{
+	psmouse_reset(psmouse);
+}
+
+int lifebook_detect(struct psmouse *psmouse, int set_properties)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param;
+
+/*
+ * This might be a magic knock sequence, or just a part of
+ * a standard mouse init for the mouse behind the screen.
+ * Rate of 40 also seems pretty low, but that's what the
+ * Windows driver supposedly does.
+ */
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	param = 40;
+	if (ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRATE))
+		return -1;
+
+	param = 3;
+	if (ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES))
+		return -1;
+
+/*
+ * This should fail on normal mice, SETRES only accepts
+ * values from 0 to 3.
+ */
+
+	param = 7;
+	if (ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES))
+		return -1;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE))
+		return -1;
+
+	if (set_properties) {
+		psmouse->vendor = "Fujitsu Lifebook";
+		psmouse->name = "TouchScreen";
+	}
+
+	psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
+	psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	input_set_abs_params(&psmouse->dev, ABS_X, 130, 885, 0, 0);
+	input_set_abs_params(&psmouse->dev, ABS_Y, 272, 830, 0, 0);
+
+	psmouse->protocol_handler = lifebook_process_byte;
+	psmouse->disconnect = lifebook_disconnect;
+	psmouse->reconnect = lifebook_reconnect;
+	psmouse->pktsize = 3;
+
+	return 0;
+}
diff -Nru a/drivers/input/mouse/lifebook.h b/drivers/input/mouse/lifebook.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/mouse/lifebook.h	2005-02-11 21:04:00 +01:00
@@ -0,0 +1,16 @@
+/*
+ * Fujitsu B-series Lifebook PS/2 TouchScreen driver
+ *
+ * Copyright (c) 2005 Vojtech Pavlik
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _LIFEBOOK_H
+#define _LIFEBOOK_H
+
+int lifebook_detect(struct psmouse *psmouse, int set_properties);
+
+#endif
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2005-02-11 21:04:00 +01:00
+++ b/drivers/input/mouse/psmouse-base.c	2005-02-11 21:04:00 +01:00
@@ -24,6 +24,7 @@
 #include "synaptics.h"
 #include "logips2pp.h"
 #include "alps.h"
+#include "lifebook.h"
 
 #define DRIVER_DESC	"PS/2 mouse driver"
 
@@ -62,7 +63,7 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2", "LBPS/2" };
 
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
@@ -462,6 +463,9 @@
 			max_proto = PSMOUSE_IMEX;
 		}
 	}
+
+	if (max_proto > PSMOUSE_IMEX && lifebook_detect(psmouse, set_properties) == 0)
+		return PSMOUSE_LIFEBOOK;
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
 		return PSMOUSE_GENPS;
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2005-02-11 21:04:00 +01:00
+++ b/drivers/input/mouse/psmouse.h	2005-02-11 21:04:00 +01:00
@@ -77,6 +77,7 @@
 	PSMOUSE_IMEX,
 	PSMOUSE_SYNAPTICS,
 	PSMOUSE_ALPS,
+	PSMOUSE_LIFEBOOK,
 };
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);

--cWoXeonUoKmBZSoM--
