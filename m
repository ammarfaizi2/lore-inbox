Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUCPQEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUCPO1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:27:36 -0500
Received: from styx.suse.cz ([82.208.2.94]:2946 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261942AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446778365@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 33/44] Fix for devices that need padded HID packets
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467773323@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.68.2, 2004-03-08 10:09:44+01:00, vojtech@suse.cz
  input: Update the Wacom driver to latest version
         from Ping Cheng from Wacom.


 hid-core.c |    8 ++
 wacom.c    |  177 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 150 insertions(+), 35 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:18:07 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:18:07 2004
@@ -1320,6 +1320,8 @@
 #define USB_DEVICE_ID_WACOM_INTUOS	0x0020
 #define USB_DEVICE_ID_WACOM_PL		0x0030
 #define USB_DEVICE_ID_WACOM_INTUOS2	0x0040
+#define USB_DEVICE_ID_WACOM_VOLITO      0x0060
+#define USB_DEVICE_ID_WACOM_PTU         0x0003
 
 #define USB_VENDOR_ID_KBGEAR            0x084e
 #define USB_DEVICE_ID_KBGEAR_JAMSTUDIO  0x1001
@@ -1404,6 +1406,7 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 3, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 4, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 2, HID_QUIRK_IGNORE },
@@ -1415,11 +1418,14 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 4, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 5, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 4, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 7, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE },
 
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Tue Mar 16 13:18:07 2004
+++ b/drivers/usb/input/wacom.c	Tue Mar 16 13:18:07 2004
@@ -8,8 +8,8 @@
  *  Copyright (c) 2000 James E. Blair		<corvus@gnu.org>
  *  Copyright (c) 2000 Daniel Egger		<egger@suse.de>
  *  Copyright (c) 2001 Frederic Lepied		<flepied@mandrakesoft.com>
- *  Copyright (c) 2002 Ping Cheng		<pingc@wacom.com>
  *  Copyright (c) 2004 Panagiotis Issaris	<panagiotis.issaris@mech.kuleuven.ac.be>
+ *  Copyright (c) 2002-2004 Ping Cheng		<pingc@wacom.com>
  *
  *  ChangeLog:
  *      v0.1 (vp)  - Initial release
@@ -50,6 +50,7 @@
  *		   - Since 2.5 now has input_sync(), remove MSC_SERIAL abuse
  *		   - Cleanups here and there
  *    v1.30.1 (pi) - Added Graphire3 support
+ *	v1.40 (pc) - Add support for several new devices, fix eraser reporting, ...
  */
 
 /*
@@ -108,7 +109,7 @@
 static int usb_set_report(struct usb_interface *intf, unsigned char type,
 				unsigned char id, void *buf, int size)
 {
-        return usb_control_msg(interface_to_usbdev(intf),
+	return usb_control_msg(interface_to_usbdev(intf),
 		usb_sndctrlpipe(interface_to_usbdev(intf), 0),
                 USB_REQ_SET_REPORT, USB_TYPE_CLASS | USB_RECIP_INTERFACE,
                 (type << 8) + id, intf->altsetting[0].desc.bInterfaceNumber,
@@ -139,14 +140,12 @@
 	}
 
 	if (data[0] != 2)
-		dbg("received unknown report #%d", data[0]);
+		dbg("wacom_pl_irq: received unknown report #%d", data[0]);
 
 	prox = data[1] & 0x40;
 
 	input_regs(dev, regs);
 	
-	input_report_key(dev, BTN_TOOL_PEN, prox);
-	
 	if (prox) {
 
 		pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
@@ -154,15 +153,103 @@
 			pressure = (pressure << 1) | ((data[4] >> 6) & 1);
 		pressure += (wacom->features->pressure_max + 1) / 2;
 
+		/*
+		 * if going from out of proximity into proximity select between the eraser
+		 * and the pen based on the state of the stylus2 button, choose eraser if
+		 * pressed else choose pen. if not a proximity change from out to in, send
+		 * an out of proximity for previous tool then a in for new tool.
+		 */
+		if (!wacom->tool[0]) {
+			/* Going into proximity select tool */
+			wacom->tool[1] = (data[4] & 0x20)? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+		}
+		else {
+			/* was entered with stylus2 pressed */
+			if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] & 0x20) ) {
+				/* report out proximity for previous tool */
+				input_report_key(dev, wacom->tool[1], 0);
+				input_sync(dev);
+				wacom->tool[1] = BTN_TOOL_PEN;
+				goto exit;
+			}
+		}
+		if (wacom->tool[1] != BTN_TOOL_RUBBER) {
+			/* Unknown tool selected default to pen tool */
+			wacom->tool[1] = BTN_TOOL_PEN;
+		}
+		input_report_key(dev, wacom->tool[1], prox); /* report in proximity for tool */
 		input_report_abs(dev, ABS_X, data[3] | ((__u32)data[2] << 7) | ((__u32)(data[1] & 0x03) << 14));
 		input_report_abs(dev, ABS_Y, data[6] | ((__u32)data[5] << 7) | ((__u32)(data[4] & 0x03) << 14));
 		input_report_abs(dev, ABS_PRESSURE, pressure);
 
 		input_report_key(dev, BTN_TOUCH, data[4] & 0x08);
 		input_report_key(dev, BTN_STYLUS, data[4] & 0x10);
-		input_report_key(dev, BTN_STYLUS2, data[4] & 0x20);
+		/* Only allow the stylus2 button to be reported for the pen tool. */
+		input_report_key(dev, BTN_STYLUS2, (wacom->tool[1] == BTN_TOOL_PEN) && (data[4] & 0x20));
 	}
-	
+	else {
+		/* report proximity-out of a (valid) tool */
+		if (wacom->tool[1] != BTN_TOOL_RUBBER) {
+			/* Unknown tool selected default to pen tool */
+			wacom->tool[1] = BTN_TOOL_PEN;
+		}
+		input_report_key(dev, wacom->tool[1], prox);
+	}
+
+	wacom->tool[0] = prox; /* Save proximity state */
+	input_sync(dev);
+
+exit:
+	retval = usb_submit_urb (urb, GFP_ATOMIC);
+	if (retval)
+		err ("%s - usb_submit_urb failed with result %d",
+		     __FUNCTION__, retval);
+}
+
+static void wacom_ptu_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct wacom *wacom = urb->context;
+	unsigned char *data = wacom->data;
+	struct input_dev *dev = &wacom->dev;
+	int retval;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d", __FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d", __FUNCTION__, urb->status);
+		goto exit;
+	}
+
+	if (data[0] != 2)
+	{
+		printk(KERN_INFO "wacom_ptu_irq: received unknown report #%d\n", data[0]);
+	}
+
+	input_regs(dev, regs);
+	if (data[1] & 0x04)
+	{
+		input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x20);
+		input_report_key(dev, BTN_TOUCH, data[1] & 0x08);
+	}
+	else
+	{
+		input_report_key(dev, BTN_TOOL_PEN, data[1] & 0x20);
+		input_report_key(dev, BTN_TOUCH, data[1] & 0x01);
+	}
+	input_report_abs(dev, ABS_X, data[3] << 8 | data[2]);
+	input_report_abs(dev, ABS_Y, data[5] << 8 | data[4]);
+	input_report_abs(dev, ABS_PRESSURE, (data[6]|data[7] << 8));
+	input_report_key(dev, BTN_STYLUS, data[1] & 0x02);
+	input_report_key(dev, BTN_STYLUS2, data[1] & 0x10);
+
 	input_sync(dev);
 
 exit:
@@ -233,8 +320,12 @@
 		goto exit;
 	}
 
+	/* check if we can handle the data */
+	if (data[0] == 99)
+		goto exit;
+
 	if (data[0] != 2)
-		dbg("received unknown report #%d", data[0]);
+		dbg("wacom_graphire_irq: received unknown report #%d", data[0]);
 
 	x = data[2] | ((__u32)data[3] << 8);
 	y = data[4] | ((__u32)data[5] << 8);
@@ -251,13 +342,16 @@
 			input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x80);
 			break;
 
-		case 2: /* Mouse */
+		case 2: /* Mouse with wheel */
+			input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);
+			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);
+			/* fall through */
+
+                case 3: /* Mouse without wheel */
 			input_report_key(dev, BTN_TOOL_MOUSE, data[7] > 24);
 			input_report_key(dev, BTN_LEFT, data[1] & 0x01);
 			input_report_key(dev, BTN_RIGHT, data[1] & 0x02);
-			input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);
 			input_report_abs(dev, ABS_DISTANCE, data[7]);
-			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);
 
 			input_report_abs(dev, ABS_X, x);
 			input_report_abs(dev, ABS_Y, y);
@@ -310,7 +404,7 @@
 	}
 
 	if (data[0] != 2)
-		dbg("received unknown report #%d", data[0]);
+		dbg("wacom_intuos_irq: received unknown report #%d", data[0]);
 
 	input_regs(dev, regs);
 
@@ -319,18 +413,18 @@
 
 	if ((data[1] & 0xfc) == 0xc0) {						/* Enter report */
 
-		wacom->serial[idx] = ((__u32)(data[3] & 0x0f) << 4) +		/* serial number of the tool */
-			((__u32)data[4] << 16) + ((__u32)data[5] << 12) +
+		wacom->serial[idx] = ((__u32)(data[3] & 0x0f) << 28) +		/* serial number of the tool */
+			((__u32)data[4] << 20) + ((__u32)data[5] << 12) +
 			((__u32)data[6] << 4) + (data[7] >> 4);
 
 		switch (((__u32)data[2] << 4) | (data[3] >> 4)) {
-			case 0x832:
+			case 0x812:
 			case 0x012: wacom->tool[idx] = BTN_TOOL_PENCIL;		break;	/* Inking pen */
 			case 0x822:
 			case 0x842:
 			case 0x852:
 			case 0x022: wacom->tool[idx] = BTN_TOOL_PEN;		break;	/* Pen */
-			case 0x812:
+			case 0x832:
 			case 0x032: wacom->tool[idx] = BTN_TOOL_BRUSH;		break;	/* Stroke pen */
 			case 0x007:
 		        case 0x09c:
@@ -339,7 +433,10 @@
 			case 0x82a:
 			case 0x85a:
 		        case 0x91a:
+			case 0xd1a:
 			case 0x0fa: wacom->tool[idx] = BTN_TOOL_RUBBER;		break;	/* Eraser */
+			case 0xd12:
+			case 0x912:
 			case 0x112: wacom->tool[idx] = BTN_TOOL_AIRBRUSH;	break;	/* Airbrush */
 			default:    wacom->tool[idx] = BTN_TOOL_PEN;		break;	/* Unknown tool */
 		}
@@ -352,13 +449,14 @@
 
 	if ((data[1] & 0xfe) == 0x80) {						/* Exit report */
 		input_report_key(dev, wacom->tool[idx], 0);
+		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 		input_sync(dev);
 		goto exit;
 	}
 
 	input_report_abs(dev, ABS_X, ((__u32)data[2] << 8) | data[3]);
 	input_report_abs(dev, ABS_Y, ((__u32)data[4] << 8) | data[5]);
-	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);
+	input_report_abs(dev, ABS_DISTANCE, data[9]);
 
 	if ((data[1] & 0xb8) == 0xa0) {						/* general pen packet */
 		input_report_abs(dev, ABS_PRESSURE, t = ((__u32)data[6] << 2) | ((data[7] >> 6) & 3));
@@ -380,8 +478,8 @@
 		if (data[1] & 0x02) {						/* Rotation packet */
 
 			input_report_abs(dev, ABS_RZ, (data[7] & 0x20) ?
-					 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3):
-					 (-(((__u32)data[6] << 2) | ((data[7] >> 6) & 3))) - 1);
+					 ((__u32)data[6] << 3) | ((data[7] >> 5) & 7):
+					 (-(((__u32)data[6] << 3) | ((data[7] >> 5) & 7))) - 1);
 
 		} else {
 
@@ -393,17 +491,17 @@
 
 				input_report_key(dev, BTN_SIDE,   data[8] & 0x20);
 				input_report_key(dev, BTN_EXTRA,  data[8] & 0x10);
-				input_report_abs(dev, ABS_THROTTLE,  (data[8] & 0x08) ?
+				input_report_abs(dev, ABS_THROTTLE,  -((data[8] & 0x08) ?
 						 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3) :
-						 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3));
+						 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3)));
 
 			} else {
 				if (wacom->tool[idx] == BTN_TOOL_MOUSE) {	/* 2D mouse packets */	
 					input_report_key(dev, BTN_LEFT,   data[8] & 0x04);
 					input_report_key(dev, BTN_MIDDLE, data[8] & 0x08);
 					input_report_key(dev, BTN_RIGHT,  data[8] & 0x10);
-					input_report_abs(dev, REL_WHEEL, 
-					    ((__u32)(data[8] & 0x01) - (__u32)((data[8] & 0x02) >> 1)));
+					input_report_rel(dev, REL_WHEEL, 
+					    (-(__u32)(data[8] & 0x01) + (__u32)((data[8] & 0x02) >> 1)));
 				}
 				else {     /* Lens cursor packets */
 					input_report_key(dev, BTN_LEFT,   data[8] & 0x01);
@@ -416,6 +514,8 @@
 		}
 	}
 	
+	input_report_key(dev, wacom->tool[idx], 1);
+	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 	input_sync(dev);
 
 exit:
@@ -431,22 +531,26 @@
 	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 32, 1, wacom_graphire_irq },
  	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, 1, wacom_graphire_irq },
 	{ "Wacom Graphire3",     8,  10208,  7424,  511, 32, 1, wacom_graphire_irq },
-  	{ "Wacom Intuos 4x5",   10,  12700, 10360, 1023, 15, 2, wacom_intuos_irq },
- 	{ "Wacom Intuos 6x8",   10,  20600, 16450, 1023, 15, 2, wacom_intuos_irq },
- 	{ "Wacom Intuos 9x12",  10,  30670, 24130, 1023, 15, 2, wacom_intuos_irq },
- 	{ "Wacom Intuos 12x12", 10,  30670, 31040, 1023, 15, 2, wacom_intuos_irq },
- 	{ "Wacom Intuos 12x18", 10,  45860, 31040, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Graphire3 6x8", 8,  16704, 12064,  511, 32, 1, wacom_graphire_irq },
+  	{ "Wacom Intuos 4x5",   10,  12700, 10600, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 6x8",   10,  20320, 16240, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 9x12",  10,  30480, 24060, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 12x12", 10,  30480, 31680, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 12x18", 10,  45720, 31680, 1023, 15, 2, wacom_intuos_irq },
  	{ "Wacom PL400",         8,   5408,  4056,  255, 32, 3, wacom_pl_irq },
  	{ "Wacom PL500",         8,   6144,  4608,  255, 32, 3, wacom_pl_irq },
  	{ "Wacom PL600",         8,   6126,  4604,  255, 32, 3, wacom_pl_irq },
  	{ "Wacom PL600SX",       8,   6260,  5016,  255, 32, 3, wacom_pl_irq },
  	{ "Wacom PL550",         8,   6144,  4608,  511, 32, 3, wacom_pl_irq },
  	{ "Wacom PL800",         8,   7220,  5780,  511, 32, 3, wacom_pl_irq },
-	{ "Wacom Intuos2 4x5",   10, 12700, 10360, 1023, 15, 2, wacom_intuos_irq },
-	{ "Wacom Intuos2 6x8",   10, 20600, 16450, 1023, 15, 2, wacom_intuos_irq },
-	{ "Wacom Intuos2 9x12",  10, 30670, 24130, 1023, 15, 2, wacom_intuos_irq },
-	{ "Wacom Intuos2 12x12", 10, 30670, 31040, 1023, 15, 2, wacom_intuos_irq },
-	{ "Wacom Intuos2 12x18", 10, 45860, 31040, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 4x5",   10, 12700, 10600, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 9x12",  10, 30480, 24060, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 12x12", 10, 30480, 31680, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 12x18", 10, 45720, 31680, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Volito",        8,   5104,  3712,  511, 32, 1, wacom_graphire_irq },
+	{ "Wacom Cintiq Partner",8,  20480, 15360,  511, 32, 3, wacom_ptu_irq },
+	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, 2, wacom_intuos_irq },
  	{ }
 };
 
@@ -456,6 +560,7 @@
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x13) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x14) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22) },
@@ -472,6 +577,9 @@
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x60) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x03) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x47) },
 	{ }
 };
 
@@ -540,8 +648,9 @@
 			break;
 
 		case 2:
-			wacom->dev.evbit[0] |= BIT(EV_MSC);
+			wacom->dev.evbit[0] |= BIT(EV_MSC) | BIT(EV_REL);
 			wacom->dev.mscbit[0] |= BIT(MSC_SERIAL);
+			wacom->dev.relbit[0] |= BIT(REL_WHEEL);
 			wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE) | BIT(BTN_SIDE) | BIT(BTN_EXTRA);
  			wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE)	| BIT(BTN_TOOL_BRUSH)
 							  | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | BIT(BTN_TOOL_LENS) | BIT(BTN_STYLUS2);

