Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVCAIOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVCAIOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVCAIOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:14:08 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:4001 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261294AbVCAINR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:13:17 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050224090338.GA3699@ucw.cz>
References: <1108457880.2843.5.camel@localhost>
	 <20050215134308.GE7250@ucw.cz> <1108578892.2994.2.camel@localhost>
	 <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost>
	 <20050217150455.GA1723@ucw.cz> <20050217194217.GA2458@ucw.cz>
	 <1108817681.5774.44.camel@localhost> <20050219131639.GA4922@ucw.cz>
	 <1108973216.5774.72.camel@localhost>  <20050224090338.GA3699@ucw.cz>
Content-Type: multipart/mixed; boundary="=-FBlt2ppM/POvHXgrOJpP"
Date: Tue, 01 Mar 2005 09:11:49 +0100
Message-Id: <1109664709.18617.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FBlt2ppM/POvHXgrOJpP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 24.02.2005, 10:03 +0100 schrieb Vojtech Pavlik: 
> On Mon, Feb 21, 2005 at 09:06:55AM +0100, Kenan Esau wrote:
> 
> > > > I also checked my original standalone-driver: Because of this behaviour
> > > > I always retried the last command 3 times if the responce from the
> > > > device was 0xfe or 0xfc.
> > > 
> > > And did it actually help? Did the touchscreen ever respond with a 0xfa
> > > "ACK, OK" response to these commands?
> > 
> > I played around a little bit last weekend. And obviously the touchscreen
> > always responds 0xfe to the 0xe8 0x07 command. Also repeating the
> > command does not really help. After the firxt 0x07 you get back the 0xfe
> > and the next byte you send to the device is ALWAYS answered by a
> > 0xfc!?!?
> 
> This looks like it either expects some other data (like a second
> parameter to the command?) or just wants the 0x07 again (and not the
> whole command) to make sure you really mean it.
> 
> Could you try sending 0xe8 0x07 0x07?

My old driver did that. But with the same result. It doesn't seem to
matter what the first and the second bytes are -- the answers from the
device are alway the same.

> > At the end of this mail you'll find some traces I did.
> > 
> > I also wonder if it is possible at all to probe this device. I think
> > not. IMHO we should go for a module-parameter which enforces the
> > lifebook-protokoll. Something like "force_lb=1". Any Ideas /
> > suggestions? 
> 
> I'd suggest using psmouse.proto=lifebook

The current patch has implemented it that way. But the meaning is a
little bit different. With proto=lifebook you ENFORCE the lifebook
protocol. As far as I read the meaning of the other ones this does not
really enforce these protocols.

> > How does this work out with a second/external mouse?
> 
> The external mouse has to be in bare PS/2 mode anyway, so we don't need
> to care.

Why that?

I have attached the newest version of the patch.

--=-FBlt2ppM/POvHXgrOJpP
Content-Disposition: attachment; filename=psmouse-lifebook.diff
Content-Type: text/x-patch; name=psmouse-lifebook.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -uprN -X dontdiff linux-2.6.11-rc5/drivers/input/mouse/lifebook.c linux-2.6.11-rc5-kenan/drivers/input/mouse/lifebook.c
--- linux-2.6.11-rc5/drivers/input/mouse/lifebook.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc5-kenan/drivers/input/mouse/lifebook.c	2005-02-28 16:56:37.000000000 +0100
@@ -0,0 +1,109 @@
+/*
+ * Fujitsu B-series Lifebook PS/2 TouchScreen driver
+ *
+ * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2005 Kenan Esau <kenan.esau@conan.de>
+ *
+ * TouchScreen detection, absolute mode setting and packet layout is taken from
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
+static int max_y = 1024;
+
+
+static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = &psmouse->dev;
+
+	if ( psmouse->pktcnt != 3 )
+		return PSMOUSE_GOOD_DATA;
+
+	input_regs(dev, regs);
+
+	/* calculate X and Y */
+	if ((packet[0] & 0x08) == 0x00) {
+		input_report_abs(dev, ABS_X,
+				 (packet[1] | ((packet[0] & 0x30) << 4)));
+		input_report_abs(dev, ABS_Y,
+				 max_y - (packet[2] | ((packet[0] & 0xC0) << 2)));
+	} else {
+		input_report_rel(dev, REL_X, 
+				((packet[0] & 0x10) ? packet[1]-256 : packet[1]));
+		input_report_rel(dev, REL_Y, 
+				(- (int)((packet[0] & 0x20) ? packet[2]-256 : packet[2])));
+	}
+
+	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
+	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	input_report_key(dev, BTN_TOUCH, packet[0] & 0x04);
+
+	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
+}
+
+static int lifebook_initialize(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
+		return -1;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_BAT))
+		return -1;
+
+	/* 
+	   Enable absolute output -- ps2_command fails always but if
+	   you leave this call out the touchsreen will never send
+	   absolute coordinates
+	*/ 
+	param = 0x07;
+	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
+
+	psmouse->set_rate(psmouse, psmouse->rate);
+	psmouse->set_resolution(psmouse, psmouse->resolution);
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
+	if (set_properties) {
+		psmouse->vendor = "Fujitsu Lifebook";
+		psmouse->name = "TouchScreen";
+		psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
+		psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+		psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+		psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+		input_set_abs_params(&psmouse->dev, ABS_X, 0, 1024, 0, 0);
+		input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1024, 0, 0);
+
+		psmouse->protocol_handler = lifebook_process_byte;
+		psmouse->disconnect = lifebook_disconnect;
+		psmouse->reconnect  = lifebook_initialize;
+		psmouse->pktsize = 3;
+	}
+
+        return lifebook_initialize(psmouse);
+}
diff -uprN -X dontdiff linux-2.6.11-rc5/drivers/input/mouse/lifebook.h linux-2.6.11-rc5-kenan/drivers/input/mouse/lifebook.h
--- linux-2.6.11-rc5/drivers/input/mouse/lifebook.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc5-kenan/drivers/input/mouse/lifebook.h	2005-02-27 12:41:30.000000000 +0100
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
diff -uprN -X dontdiff linux-2.6.11-rc5/drivers/input/mouse/Makefile linux-2.6.11-rc5-kenan/drivers/input/mouse/Makefile
--- linux-2.6.11-rc5/drivers/input/mouse/Makefile	2005-02-27 12:32:01.000000000 +0100
+++ linux-2.6.11-rc5-kenan/drivers/input/mouse/Makefile	2005-02-27 12:41:30.000000000 +0100
@@ -14,4 +14,4 @@ obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
+psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o
diff -uprN -X dontdiff linux-2.6.11-rc5/drivers/input/mouse/psmouse-base.c linux-2.6.11-rc5-kenan/drivers/input/mouse/psmouse-base.c
--- linux-2.6.11-rc5/drivers/input/mouse/psmouse-base.c	2005-02-27 12:32:01.000000000 +0100
+++ linux-2.6.11-rc5-kenan/drivers/input/mouse/psmouse-base.c	2005-02-28 19:26:40.000000000 +0100
@@ -24,6 +24,7 @@
 #include "synaptics.h"
 #include "logips2pp.h"
 #include "alps.h"
+#include "lifebook.h"
 
 #define DRIVER_DESC	"PS/2 mouse driver"
 
@@ -34,7 +35,7 @@ MODULE_LICENSE("GPL");
 static char *psmouse_proto;
 static unsigned int psmouse_max_proto = -1U;
 module_param_named(proto, psmouse_proto, charp, 0);
-MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
+MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps, lifebook). Useful for KVM switches.");
 
 static unsigned int psmouse_resolution = 200;
 module_param_named(resolution, psmouse_resolution, uint, 0);
@@ -62,7 +63,7 @@ __obsolete_setup("psmouse_smartscroll=")
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2", "LBPS/2" };
 
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
@@ -418,6 +419,12 @@ static int psmouse_extensions(struct psm
 {
 	int synaptics_hardware = 0;
 
+	if (max_proto == PSMOUSE_LIFEBOOK) {
+		lifebook_detect(psmouse, set_properties);
+		max_proto--;
+		return PSMOUSE_LIFEBOOK;
+	}
+
 /*
  * Try Kensington ThinkingMouse (we try first, because synaptics probe
  * upsets the thinkingmouse).
@@ -951,6 +958,8 @@ static inline void psmouse_parse_proto(v
 			psmouse_max_proto = PSMOUSE_IMPS;
 		else if (!strcmp(psmouse_proto, "exps"))
 			psmouse_max_proto = PSMOUSE_IMEX;
+		else if (!strcmp(psmouse_proto, "lifebook"))
+			psmouse_max_proto = PSMOUSE_LIFEBOOK;
 		else
 			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
 	}
diff -uprN -X dontdiff linux-2.6.11-rc5/drivers/input/mouse/psmouse.h linux-2.6.11-rc5-kenan/drivers/input/mouse/psmouse.h
--- linux-2.6.11-rc5/drivers/input/mouse/psmouse.h	2005-02-27 12:32:02.000000000 +0100
+++ linux-2.6.11-rc5-kenan/drivers/input/mouse/psmouse.h	2005-02-28 10:34:33.000000000 +0100
@@ -77,6 +77,7 @@ enum psmouse_type {
 	PSMOUSE_IMEX,
 	PSMOUSE_SYNAPTICS,
 	PSMOUSE_ALPS,
+	PSMOUSE_LIFEBOOK,
 };
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);

--=-FBlt2ppM/POvHXgrOJpP--

