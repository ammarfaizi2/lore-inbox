Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVKNUUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVKNUUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVKNUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:19:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:45254 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932086AbVKNUTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:18 -0500
Date: Mon, 14 Nov 2005 12:05:31 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dtor_core@ameritech.net, vojtech@suse.cz
Subject: [patch 04/12] USB: wacom tablet driver update
Message-ID: <20051114200531.GE2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-wacom-tablet-driver-update.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping Cheng <pingc@wacom.com>


This patch adds support for Graphire4, Cintiq 710, Intuos3 6x11, etc. and
report Device IDs.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/input/wacom.c |  133 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 110 insertions(+), 23 deletions(-)

--- gregkh-2.6.orig/drivers/usb/input/wacom.c
+++ gregkh-2.6/drivers/usb/input/wacom.c
@@ -52,8 +52,10 @@
  *    v1.30.1 (pi) - Added Graphire3 support
  *	v1.40 (pc) - Add support for several new devices, fix eraser reporting, ...
  *	v1.43 (pc) - Added support for Cintiq 21UX
-		   - Fixed a Graphire bug
-		   - Merged wacom_intuos3_irq into wacom_intuos_irq
+ *		   - Fixed a Graphire bug
+ *		   - Merged wacom_intuos3_irq into wacom_intuos_irq
+ *	v1.44 (pc) - Added support for Graphire4, Cintiq 710, Intuos3 6x11, etc.
+ *		   - Report Device IDs
  */
 
 /*
@@ -76,7 +78,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.43"
+#define DRIVER_VERSION "v1.44"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB Wacom Graphire and Wacom Intuos tablet driver"
 #define DRIVER_LICENSE "GPL"
@@ -86,10 +88,14 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE(DRIVER_LICENSE);
 
 #define USB_VENDOR_ID_WACOM	0x056a
+#define STYLUS_DEVICE_ID	0x02
+#define CURSOR_DEVICE_ID	0x06
+#define ERASER_DEVICE_ID	0x0A
 
 enum {
 	PENPARTNER = 0,
 	GRAPHIRE,
+	G4,
 	PL,
 	INTUOS,
 	INTUOS3,
@@ -116,6 +122,7 @@ struct wacom {
 	struct urb *irq;
 	struct wacom_features *features;
 	int tool[2];
+	int id[2];
 	__u32 serial[2];
 	char phys[32];
 };
@@ -136,7 +143,7 @@ static void wacom_pl_irq(struct urb *urb
 	struct wacom *wacom = urb->context;
 	unsigned char *data = wacom->data;
 	struct input_dev *dev = wacom->dev;
-	int prox, pressure;
+	int prox, pressure, id;
 	int retval;
 
 	switch (urb->status) {
@@ -163,6 +170,7 @@ static void wacom_pl_irq(struct urb *urb
 
 	input_regs(dev, regs);
 
+	id = ERASER_DEVICE_ID;
 	if (prox) {
 
 		pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
@@ -177,11 +185,15 @@ static void wacom_pl_irq(struct urb *urb
 		 * an out of proximity for previous tool then a in for new tool.
 		 */
 		if (!wacom->tool[0]) {
-			/* Going into proximity select tool */
-			wacom->tool[1] = (data[4] & 0x20)? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+			/* Eraser bit set for DTF */
+			if (data[1] & 0x10)
+				wacom->tool[1] = BTN_TOOL_RUBBER;
+			else
+				/* Going into proximity select tool */
+				wacom->tool[1] = (data[4] & 0x20) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
 		} else {
 			/* was entered with stylus2 pressed */
-			if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] & 0x20) ) {
+			if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] & 0x20)) {
 				/* report out proximity for previous tool */
 				input_report_key(dev, wacom->tool[1], 0);
 				input_sync(dev);
@@ -192,8 +204,9 @@ static void wacom_pl_irq(struct urb *urb
 		if (wacom->tool[1] != BTN_TOOL_RUBBER) {
 			/* Unknown tool selected default to pen tool */
 			wacom->tool[1] = BTN_TOOL_PEN;
+			id = STYLUS_DEVICE_ID;
 		}
-		input_report_key(dev, wacom->tool[1], prox); /* report in proximity for tool */
+		input_report_key(dev, wacom->tool[1], id); /* report in proximity for tool */
 		input_report_abs(dev, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
 		input_report_abs(dev, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
 		input_report_abs(dev, ABS_PRESSURE, pressure);
@@ -250,10 +263,10 @@ static void wacom_ptu_irq(struct urb *ur
 
 	input_regs(dev, regs);
 	if (data[1] & 0x04) {
-		input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x20);
+		input_report_key(dev, BTN_TOOL_RUBBER, (data[1] & 0x20) ? ERASER_DEVICE_ID : 0);
 		input_report_key(dev, BTN_TOUCH, data[1] & 0x08);
 	} else {
-		input_report_key(dev, BTN_TOOL_PEN, data[1] & 0x20);
+		input_report_key(dev, BTN_TOOL_PEN, (data[1] & 0x20) ? STYLUS_DEVICE_ID : 0);
 		input_report_key(dev, BTN_TOUCH, data[1] & 0x01);
 	}
 	input_report_abs(dev, ABS_X, le16_to_cpu(*(__le16 *) &data[2]));
@@ -299,7 +312,7 @@ static void wacom_penpartner_irq(struct 
 	}
 
 	input_regs(dev, regs);
-	input_report_key(dev, BTN_TOOL_PEN, 1);
+	input_report_key(dev, BTN_TOOL_PEN, STYLUS_DEVICE_ID);
 	input_report_abs(dev, ABS_X, le16_to_cpu(*(__le16 *) &data[1]));
 	input_report_abs(dev, ABS_Y, le16_to_cpu(*(__le16 *) &data[3]));
 	input_report_abs(dev, ABS_PRESSURE, (signed char)data[6] + 127);
@@ -319,7 +332,7 @@ static void wacom_graphire_irq(struct ur
 	struct wacom *wacom = urb->context;
 	unsigned char *data = wacom->data;
 	struct input_dev *dev = wacom->dev;
-	int x, y;
+	int x, y, id, rw;
 	int retval;
 
 	switch (urb->status) {
@@ -344,6 +357,7 @@ static void wacom_graphire_irq(struct ur
 
 	input_regs(dev, regs);
 
+	id = STYLUS_DEVICE_ID;
 	if (data[1] & 0x10) { /* in prox */
 
 		switch ((data[1] >> 5) & 3) {
@@ -354,18 +368,27 @@ static void wacom_graphire_irq(struct ur
 
 			case 1: /* Rubber */
 				wacom->tool[0] = BTN_TOOL_RUBBER;
+				id = ERASER_DEVICE_ID;
 				break;
 
 			case 2: /* Mouse with wheel */
 				input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);
-				input_report_rel(dev, REL_WHEEL, (signed char) data[6]);
+				if (wacom->features->type == G4) {
+					rw = data[7] & 0x04 ? -(data[7] & 0x03) : (data[7] & 0x03);
+					input_report_rel(dev, REL_WHEEL, rw);
+				} else
+					input_report_rel(dev, REL_WHEEL, (signed char) data[6]);
 				/* fall through */
 
 			case 3: /* Mouse without wheel */
 				wacom->tool[0] = BTN_TOOL_MOUSE;
+				id = CURSOR_DEVICE_ID;
 				input_report_key(dev, BTN_LEFT, data[1] & 0x01);
 				input_report_key(dev, BTN_RIGHT, data[1] & 0x02);
-				input_report_abs(dev, ABS_DISTANCE, data[7]);
+				if (wacom->features->type == G4)
+					input_report_abs(dev, ABS_DISTANCE, data[6]);
+				else
+					input_report_abs(dev, ABS_DISTANCE, data[7]);
 				break;
 		}
 	}
@@ -376,16 +399,50 @@ static void wacom_graphire_irq(struct ur
 		input_report_abs(dev, ABS_X, x);
 		input_report_abs(dev, ABS_Y, y);
 		if (wacom->tool[0] != BTN_TOOL_MOUSE) {
-			input_report_abs(dev, ABS_PRESSURE, le16_to_cpu(*(__le16 *) &data[6]));
+			input_report_abs(dev, ABS_PRESSURE, data[6] | ((data[7] & 0x01) << 8));
 			input_report_key(dev, BTN_TOUCH, data[1] & 0x01);
 			input_report_key(dev, BTN_STYLUS, data[1] & 0x02);
 			input_report_key(dev, BTN_STYLUS2, data[1] & 0x04);
 		}
 	}
 
-	input_report_key(dev, wacom->tool[0], data[1] & 0x10);
+	input_report_key(dev, wacom->tool[0], (data[1] & 0x10) ? id : 0);
 	input_sync(dev);
 
+	/* send pad data */
+	if (wacom->features->type == G4) {
+		/* fist time sending pad data */
+		if (wacom->tool[1] != BTN_TOOL_FINGER) {
+			wacom->id[1] = 0;
+			wacom->serial[1] = (data[7] & 0x38) >> 2;
+		}
+		if (data[7] & 0xf8) {
+			input_report_key(dev, BTN_0, (data[7] & 0x40));
+			input_report_key(dev, BTN_4, (data[7] & 0x80));
+			if (((data[7] & 0x38) >> 2) == (wacom->serial[1] & 0x0e))
+				/* alter REL_WHEEL value so X apps can get it */
+				wacom->serial[1] += (wacom->serial[1] & 0x01) ? -1 : 1;
+			else
+				 wacom->serial[1] = (data[7] & 0x38 ) >> 2;
+
+			/* don't alter the value when there is no wheel event */
+			if (wacom->serial[1] == 1)
+				wacom->serial[1] = 0;
+			rw = wacom->serial[1];
+			rw = (rw & 0x08) ? -(rw & 0x07) : (rw & 0x07);
+			input_report_rel(dev, REL_WHEEL, rw);
+			wacom->tool[1] = BTN_TOOL_FINGER;
+			wacom->id[1] = data[7] & 0xf8;
+			input_report_key(dev, wacom->tool[1], 0xf0);
+			input_event(dev, EV_MSC, MSC_SERIAL, 0xf0);
+		} else if (wacom->id[1]) {
+			wacom->id[1] = 0;
+			wacom->serial[1] = 0;
+			input_report_key(dev, wacom->tool[1], 0);
+			input_event(dev, EV_MSC, MSC_SERIAL, 0xf0);
+		}
+		input_sync(dev);
+	}
  exit:
 	retval = usb_submit_urb (urb, GFP_ATOMIC);
 	if (retval)
@@ -410,7 +467,8 @@ static int wacom_intuos_inout(struct urb
 			(data[4] << 20) + (data[5] << 12) +
 			(data[6] << 4) + (data[7] >> 4);
 
-		switch ((data[2] << 4) | (data[3] >> 4)) {
+		wacom->id[idx] = (data[2] << 4) | (data[3] >> 4);
+		switch (wacom->id[idx]) {
 			case 0x812: /* Inking pen */
 			case 0x801: /* Intuos3 Inking pen */
 			case 0x012:
@@ -458,7 +516,7 @@ static int wacom_intuos_inout(struct urb
 			default: /* Unknown tool */
 				wacom->tool[idx] = BTN_TOOL_PEN;
 		}
-		input_report_key(dev, wacom->tool[idx], 1);
+		input_report_key(dev, wacom->tool[idx], wacom->id[idx]);
 		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 		input_sync(dev);
 		return 1;
@@ -637,7 +695,7 @@ static void wacom_intuos_irq(struct urb 
 		}
 	}
 
-	input_report_key(dev, wacom->tool[idx], 1);
+	input_report_key(dev, wacom->tool[idx], wacom->id[idx]);
 	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 	input_sync(dev);
 
@@ -655,6 +713,13 @@ static struct wacom_features wacom_featu
 	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom Graphire3",     8,  10208,  7424,  511, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom Graphire3 6x8", 8,  16704, 12064,  511, 32, GRAPHIRE,   wacom_graphire_irq },
+	{ "Wacom Graphire4 4x5", 8,  10208,  7424,  511, 32, G4,	 wacom_graphire_irq },
+	{ "Wacom Graphire4 6x8", 8,  16704, 12064,  511, 32, G4,	 wacom_graphire_irq },
+	{ "Wacom Volito",        8,   5104,  3712,  511, 32, GRAPHIRE,   wacom_graphire_irq },
+	{ "Wacom PenStation2",   8,   3250,  2320,  255, 32, GRAPHIRE,   wacom_graphire_irq },
+	{ "Wacom Volito2 4x5",   8,   5104,  3712,  511, 32, GRAPHIRE,   wacom_graphire_irq },
+	{ "Wacom Volito2 2x3",   8,   3248,  2320,  511, 32, GRAPHIRE,   wacom_graphire_irq },
+	{ "Wacom PenPartner2",   8,   3250,  2320,  255, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom Intuos 4x5",   10,  12700, 10600, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ "Wacom Intuos 6x8",   10,  20320, 16240, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ "Wacom Intuos 9x12",  10,  30480, 24060, 1023, 15, INTUOS,     wacom_intuos_irq },
@@ -666,16 +731,20 @@ static struct wacom_features wacom_featu
 	{ "Wacom PL600SX",       8,   6260,  5016,  255, 32, PL,         wacom_pl_irq },
 	{ "Wacom PL550",         8,   6144,  4608,  511, 32, PL,         wacom_pl_irq },
 	{ "Wacom PL800",         8,   7220,  5780,  511, 32, PL,         wacom_pl_irq },
+	{ "Wacom PL700",         8,   6758,  5406,  511, 32, PL,	 wacom_pl_irq },
+	{ "Wacom PL510",         8,   6282,  4762,  511, 32, PL,	 wacom_pl_irq },
+	{ "Wacom PL710",         8,  34080, 27660,  511, 32, PL,	 wacom_pl_irq },
+	{ "Wacom DTF720",        8,   6858,  5506,  511, 32, PL,	 wacom_pl_irq },
+	{ "Wacom Cintiq Partner",8,  20480, 15360,  511, 32, PL,         wacom_ptu_irq },
 	{ "Wacom Intuos2 4x5",   10, 12700, 10600, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ "Wacom Intuos2 9x12",  10, 30480, 24060, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ "Wacom Intuos2 12x12", 10, 30480, 31680, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ "Wacom Intuos2 12x18", 10, 45720, 31680, 1023, 15, INTUOS,     wacom_intuos_irq },
-	{ "Wacom Volito",        8,   5104,  3712,  511, 32, GRAPHIRE,   wacom_graphire_irq },
-	{ "Wacom Cintiq Partner",8,  20480, 15360,  511, 32, PL,         wacom_ptu_irq },
 	{ "Wacom Intuos3 4x5",   10, 25400, 20320, 1023, 15, INTUOS3,    wacom_intuos_irq },
 	{ "Wacom Intuos3 6x8",   10, 40640, 30480, 1023, 15, INTUOS3,    wacom_intuos_irq },
 	{ "Wacom Intuos3 9x12",  10, 60960, 45720, 1023, 15, INTUOS3,    wacom_intuos_irq },
+	{ "Wacom Intuos3 6x11",  10, 54204, 31750, 1023, 15, INTUOS3,    wacom_intuos_irq },
 	{ "Wacom Cintiq 21UX",   10, 87200, 65600, 1023, 15, CINTIQ,     wacom_intuos_irq },
 	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, INTUOS,     wacom_intuos_irq },
 	{ }
@@ -688,6 +757,13 @@ static struct usb_device_id wacom_ids[] 
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x13) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x14) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x15) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x16) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x60) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x61) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x62) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x63) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x64) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22) },
@@ -699,16 +775,20 @@ static struct usb_device_id wacom_ids[] 
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x33) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x34) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x35) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x37) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x38) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x39) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xC0) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x03) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x41) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x42) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45) },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x60) },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x03) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB0) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB1) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB2) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB5) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x3F) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x47) },
 	{ }
@@ -779,6 +859,13 @@ static int wacom_probe(struct usb_interf
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, wacom->features->pressure_max, 0, 0);
 
 	switch (wacom->features->type) {
+		case G4:
+			input_dev->evbit[0] |= BIT(EV_MSC);
+			input_dev->mscbit[0] |= BIT(MSC_SERIAL);
+			input_dev->keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_FINGER);
+			input_dev->keybit[LONG(BTN_LEFT)] |= BIT(BTN_0) | BIT(BTN_1) | BIT(BTN_2) | BIT(BTN_3) | BIT(BTN_4) | BIT(BTN_5) | BIT(BTN_6) | BIT(BTN_7);
+			/* fall through */
+
 		case GRAPHIRE:
 			input_dev->evbit[0] |= BIT(EV_REL);
 			input_dev->relbit[0] |= BIT(REL_WHEEL);

--
