Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbUKITUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUKITUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKITUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:20:32 -0500
Received: from rly-wacommail.wacom.com ([204.119.25.75]:62987 "EHLO
	rly-wacommail.wacom.com") by vger.kernel.org with ESMTP
	id S261632AbUKITTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:19:49 -0500
Message-ID: <28E6D16EC4CCD71196610060CF213AEB065EA7@wacom-nt2.wacom.com>
From: Ping Cheng <pingc@wacom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "''Vojtech Pavlik ' '" <vojtech@ucw.cz>,
       "'Pete Zaitcev '" <IMCEAMAILTO-zaitcev+40redhat+2Ecom@wacom.com>
Subject: wacom driver patch for 2.6
Date: Tue, 9 Nov 2004 11:12:44 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="koi8-r"
X-OriginalArrivalTime: 09 Nov 2004 19:18:51.0217 (UTC) FILETIME=[F2137C10:01C4C690]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech or someone who can access kernel source tree, please commit my patch
for Wacom driver. This patch adds support for a Wacom new tablet, Intuos3,
and its associated tools. The patch was maded against the code at
http://linux.bkbits.net:8080/linux-2.5/anno/drivers/usb/input as of Nov. 8,
2004.

Please reply to me directly since I am not part of this email list. Thank
you.


Ping

P.S., do I need to make a patch for 2.4 as well?


--- /linux.bkbits.net:8080/linux-2.5/anno/drivers/usb/input/wacom.c
2004-11-09 10:38:50.000000000 -0800
+++ wacom.c	2004-11-09 10:51:01.000000000 -0800
@@ -72,7 +72,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.30"
+#define DRIVER_VERSION "v1.40"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB Wacom Graphire and Wacom Intuos tablet driver"
 #define DRIVER_LICENSE "GPL"
@@ -141,8 +141,10 @@
 		goto exit;
 	}
 
-	if (data[0] != 2)
+	if (data[0] != 2) {
 		dbg("wacom_pl_irq: received unknown report #%d", data[0]);
+		goto exit;
+	}
 
 	prox = data[1] & 0x40;
 
@@ -233,6 +235,7 @@
 	if (data[0] != 2)
 	{
 		printk(KERN_INFO "wacom_ptu_irq: received unknown report
#%d\n", data[0]);
+		goto exit;
 	}
 
 	input_regs(dev, regs);
@@ -246,9 +249,9 @@
 		input_report_key(dev, BTN_TOOL_PEN, data[1] & 0x20);
 		input_report_key(dev, BTN_TOUCH, data[1] & 0x01);
 	}
-	input_report_abs(dev, ABS_X, data[3] << 8 | data[2]);
-	input_report_abs(dev, ABS_Y, data[5] << 8 | data[4]);
-	input_report_abs(dev, ABS_PRESSURE, (data[6]|data[7] << 8));
+	input_report_abs(dev, ABS_X, le16_to_cpu(*(__le16 *) &data[2]));
+	input_report_abs(dev, ABS_Y, le16_to_cpu(*(__le16 *) &data[4]));
+	input_report_abs(dev, ABS_PRESSURE, le16_to_cpu(*(__le16 *)
&data[6]));
 	input_report_key(dev, BTN_STYLUS, data[1] & 0x02);
 	input_report_key(dev, BTN_STYLUS2, data[1] & 0x10);
 
@@ -283,10 +286,15 @@
 		goto exit;
 	}
 
+	if (data[0] != 2) {
+		printk(KERN_INFO "wacom_penpartner_irq: received unknown
report #%d\n", data[0]);
+		goto exit;
+	}
+
 	input_regs(dev, regs);
 	input_report_key(dev, BTN_TOOL_PEN, 1);
-	input_report_abs(dev, ABS_X, le16_to_cpu(get_unaligned((__le16 *)
&data[1])));
-	input_report_abs(dev, ABS_Y, le16_to_cpu(get_unaligned((__le16 *)
&data[3])));
+	input_report_abs(dev, ABS_X, le16_to_cpu(*(__le16 *) &data[1]));
+	input_report_abs(dev, ABS_Y, le16_to_cpu(*(__le16 *) &data[3]));
 	input_report_abs(dev, ABS_PRESSURE, (signed char)data[6] + 127);
 	input_report_key(dev, BTN_TOUCH, ((signed char)data[6] > -80) &&
!(data[5] & 0x20));
 	input_report_key(dev, BTN_STYLUS, (data[5] & 0x40));
@@ -322,12 +330,10 @@
 		goto exit;
 	}
 
-	/* check if we can handle the data */
-	if (data[0] == 99)
-		goto exit;
-
-	if (data[0] != 2)
+	if (data[0] != 2) {
 		dbg("wacom_graphire_irq: received unknown report #%d",
data[0]);
+		goto exit;
+	}
 
 	x = le16_to_cpu(*(__le16 *) &data[2]);
 	y = le16_to_cpu(*(__le16 *) &data[4]);
@@ -405,8 +411,10 @@
 		goto exit;
 	}
 
-	if (data[0] != 2)
+	if (data[0] != 2 && data[0] != 5 && data[0] != 6) {
 		dbg("wacom_intuos_irq: received unknown report #%d",
data[0]);
+		goto exit;
+	}
 
 	input_regs(dev, regs);
 
@@ -479,9 +487,8 @@
 
 		if (data[1] & 0x02) {
/* Rotation packet */
 
-			input_report_abs(dev, ABS_RZ, (data[7] & 0x20) ?
-					 ((__u32)data[6] << 3) | ((data[7]
>> 5) & 7):
-					 (-(((__u32)data[6] << 3) |
((data[7] >> 5) & 7))) - 1);
+			t = ((__u32)data[6] << 3) | ((data[7] >> 5) & 7);
+			input_report_abs(dev, ABS_RZ, (data[7] & 0x20) ? ((t
- 1) / 2) : -t / 2);
 
 		} else {
 
@@ -493,9 +500,8 @@
 
 				input_report_key(dev, BTN_SIDE,   data[8] &
0x20);
 				input_report_key(dev, BTN_EXTRA,  data[8] &
0x10);
-				input_report_abs(dev, ABS_THROTTLE,
-((data[8] & 0x08) ?
-						 ((__u32)data[6] << 2) |
((data[7] >> 6) & 3) :
-						 -((__u32)data[6] << 2) |
((data[7] >> 6) & 3)));
+				t = ((__u32)data[6] << 2) | ((data[7] >> 6)
& 3);
+				input_report_abs(dev, ABS_THROTTLE, (data[8]
& 0x08) ? -t : t);
 
 			} else {
 				if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
/* 2D mouse packets */	
@@ -527,6 +533,178 @@
 		     __FUNCTION__, retval);
 }
 
+static void wacom_intuos3_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct wacom *wacom = urb->context;
+	unsigned char *data = wacom->data;
+	struct input_dev *dev = &wacom->dev;
+	unsigned int t;
+	int idx, retval;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d", __FUNCTION__,
urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d", __FUNCTION__,
urb->status);
+		goto exit;
+	}
+
+	/* check for valid report */
+	if (data[0] != 2 && data[0] != 5 && data[0] != 12)
+	{
+		printk(KERN_INFO "wacom_intuos3_irq: received unknown report
#%d\n", data[0]);
+		goto exit;
+	}
+
+	input_regs(dev, regs);
+
+	/* tool index is always 0 here since there is no dual input tool */
+	idx = data[1] & 0x01;
+
+	/* pad packets. Works as a second tool and is always in prox */
+	if (data[0] == 12)
+	{
+		/* initiate the pad as a device */
+		if (wacom->tool[1] != BTN_TOOL_FINGER)
+		{
+			wacom->tool[1] = BTN_TOOL_FINGER;
+			input_report_key(dev, wacom->tool[1], 1);
+		}
+		input_report_key(dev, BTN_0, (data[5] & 0x01));
+		input_report_key(dev, BTN_1, (data[5] & 0x02));
+		input_report_key(dev, BTN_2, (data[5] & 0x04));
+		input_report_key(dev, BTN_3, (data[5] & 0x08));
+		input_report_key(dev, BTN_4, (data[6] & 0x01));
+		input_report_key(dev, BTN_5, (data[6] & 0x02));
+		input_report_key(dev, BTN_6, (data[6] & 0x04));
+		input_report_key(dev, BTN_7, (data[6] & 0x08));
+		input_report_abs(dev, ABS_RX, ((data[1] & 0x1f) << 8) |
data[2]);
+		input_report_abs(dev, ABS_RY, ((data[3] & 0x1f) << 8) |
data[4]);
+		input_event(dev, EV_MSC, MSC_SERIAL, 0xffffffff);
+		input_sync(dev);
+		goto exit;
+	}
+
+	/* Enter report */
+	if ((data[1] & 0xfc) == 0xc0)
+	{
+		/* serial number of the tool */
+		wacom->serial[idx] = ((__u32)(data[3] & 0x0f) << 28) +
+				((__u32)data[4] << 20) + ((__u32)data[5] <<
12) +
+				((__u32)data[6] << 4) + ((__u32)data[7] >>
4);
+
+		switch ((((__u32)data[2] << 4) | (data[3] >> 4)))
+		{
+			case 0x801: /* Ink pen */
+				wacom->tool[idx] = BTN_TOOL_PENCIL; break;
+
+			case 0x823: /* Grip Pen */
+			case 0x813: /* Classic Pen */
+			case 0x885: /* Marker Pen */
+				wacom->tool[idx] = BTN_TOOL_PEN; break;
+
+			case 0x017: /* 2D Mouse */
+				wacom->tool[idx] = BTN_TOOL_MOUSE; break;
+
+			case 0x82B: /* Grip Pen Eraser */
+			case 0x81B: /* Classic Pen Eraser */
+			case 0x91B: /* Airbrush Eraser */
+				wacom->tool[idx] = BTN_TOOL_RUBBER; break;
+
+			case 0x913: /* Airbrush */
+				wacom->tool[idx] = BTN_TOOL_AIRBRUSH; break;
+
+			case 0x097: /* Lens cursor */
+				wacom->tool[idx] = BTN_TOOL_LENS; break;
+
+			default: /* Unknown tool */
+				wacom->tool[idx] = BTN_TOOL_PEN; break;
+		}
+		input_report_key(dev, wacom->tool[idx], 1);
+		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+		input_sync(dev);
+		goto exit;
+	}
+
+	/* Exit report */
+	if ((data[1] & 0xfe) == 0x80)
+	{
+		input_report_key(dev, wacom->tool[idx], 0);
+		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+		input_sync(dev);
+		goto exit;
+	}
+
+	input_report_abs(dev, ABS_X, ((__u32)data[2] << 9) | ((__u32)data[3]
<< 1) | ((data[9] >> 1) & 1));
+	input_report_abs(dev, ABS_Y, ((__u32)data[4] << 9) | ((__u32)data[5]
<< 1) | (data[9] & 1));
+	input_report_abs(dev, ABS_DISTANCE, ((data[9] >> 2) & 0x3f));
+
+	/* general pen packet */
+	if ((data[1] & 0xb8) == 0xa0)
+	{
+		t = ((__u32)data[6] << 2) | ((data[7] >> 6) & 3);
+		input_report_abs(dev, ABS_PRESSURE, t);
+		input_report_abs(dev, ABS_TILT_X,
+				((data[7] << 1) & 0x7e) | (data[8] >> 7));
+		input_report_abs(dev, ABS_TILT_Y, data[8] & 0x7f);
+		input_report_key(dev, BTN_STYLUS, data[1] & 2);
+		input_report_key(dev, BTN_STYLUS2, data[1] & 4);
+		input_report_key(dev, BTN_TOUCH, t > 10);
+	}
+
+	/* airbrush second packet */
+	if ((data[1] & 0xbc) == 0xb4)
+	{
+		input_report_abs(dev, ABS_WHEEL,
+				((__u32)data[6] << 2) | ((data[7] >> 6) &
3));
+		input_report_abs(dev, ABS_TILT_X,
+				((data[7] << 1) & 0x7e) | (data[8] >> 7));
+		input_report_abs(dev, ABS_TILT_Y, data[8] & 0x7f);
+	}
+
+	if ((data[1] & 0xbc) == 0xa8 || (data[1] & 0xbe) == 0xb0)
+	{
+		/* Marker pen rotation packet. Reported as wheel due to
valuator limitation */
+		if (data[1] & 0x02)
+		{
+			t = ((__u32)data[6] << 3) | ((data[7] >> 5) & 7);
+			t = (data[7] & 0x20) ? ((t > 900) ? ((t-1) / 2 -
1350) :
+				((t-1) / 2 + 450)) : (450 - t / 2) ;
+			input_report_abs(dev, ABS_WHEEL, t);
+		}
+
+		/* 2D mouse packets */
+		if (wacom->tool[idx] == BTN_TOOL_MOUSE)
+		{
+			input_report_key(dev, BTN_LEFT,   data[8] & 0x04);
+			input_report_key(dev, BTN_MIDDLE, data[8] & 0x08);
+			input_report_key(dev, BTN_RIGHT,  data[8] & 0x10);
+			input_report_key(dev, BTN_SIDE,   data[8] & 0x40);
+			input_report_key(dev, BTN_EXTRA,  data[8] & 0x20);
+			/* mouse wheel is positive when rolled backwards */
+			input_report_rel(dev, REL_WHEEL,  ((__u32)((data[8]
& 0x02) >> 1)
+					 - (__u32)(data[8] & 0x01)));
+		}
+	}
+
+	input_report_key(dev, wacom->tool[idx], 1);
+	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+	input_sync(dev);
+
+exit:
+	retval = usb_submit_urb (urb, GFP_ATOMIC);
+	if (retval)
+		err ("%s - usb_submit_urb failed with result %d",
+		    __FUNCTION__, retval);
+}
+
 static struct wacom_features wacom_features[] = {
 	{ "Wacom Penpartner",    7,   5040,  3780,  255, 32, 0,
wacom_penpartner_irq },
         { "Wacom Graphire",      8,  10206,  7422,  511, 32, 1,
wacom_graphire_irq },
@@ -552,6 +730,9 @@
 	{ "Wacom Intuos2 12x18", 10, 45720, 31680, 1023, 15, 2,
wacom_intuos_irq },
 	{ "Wacom Volito",        8,   5104,  3712,  511, 32, 1,
wacom_graphire_irq },
 	{ "Wacom Cintiq Partner",8,  20480, 15360,  511, 32, 3,
wacom_ptu_irq },
+	{ "Wacom Intuos3 4x5",   10, 25400, 20320, 1023, 15, 4,
wacom_intuos3_irq },
+	{ "Wacom Intuos3 6x8",   10, 40640, 30480, 1023, 15, 4,
wacom_intuos3_irq },
+	{ "Wacom Intuos3 9x12",  10, 60960, 45720, 1023, 15, 4,
wacom_intuos3_irq },
 	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, 2,
wacom_intuos_irq },
  	{ }
 };
@@ -581,6 +762,9 @@
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x60) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x03) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB0) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB1) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xB2) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x47) },
 	{ }
 };
@@ -651,6 +835,12 @@
  			wacom->dev.keybit[LONG(BTN_DIGI)] |=
BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE) | BIT(BTN_STYLUS2);
 			break;
 
+		case 4: /* new functions for Intuos3 */
+			wacom->dev.keybit[LONG(BTN_DIGI)] |=
BIT(BTN_TOOL_FINGER);
+			wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_0) |
BIT(BTN_1) | BIT(BTN_2) | BIT(BTN_3) | BIT(BTN_4) | BIT(BTN_5) | BIT(BTN_6)
| BIT(BTN_7);
+			wacom->dev.absbit[0] |= BIT(ABS_RX) | BIT(ABS_RY);
+			/* fall through */
+
 		case 2:
 			wacom->dev.evbit[0] |= BIT(EV_MSC) | BIT(EV_REL);
 			wacom->dev.mscbit[0] |= BIT(MSC_SERIAL);
@@ -662,7 +852,7 @@
 			break;
 
 		case 3:
- 			wacom->dev.keybit[LONG(BTN_DIGI)] |=
BIT(BTN_STYLUS2);
+ 			wacom->dev.keybit[LONG(BTN_DIGI)] |=
BIT(BTN_STYLUS2) | BIT(BTN_TOOL_RUBBER);
 			break;
 	}
 
@@ -674,6 +864,8 @@
 	wacom->dev.absmax[ABS_TILT_Y] = 127;
 	wacom->dev.absmax[ABS_WHEEL] = 1023;
 
+	wacom->dev.absmax[ABS_RX] = 4097;
+	wacom->dev.absmax[ABS_RY] = 4097;
 	wacom->dev.absmin[ABS_RZ] = -900;
 	wacom->dev.absmax[ABS_RZ] = 899;
 	wacom->dev.absmin[ABS_THROTTLE] = -1023;
@@ -712,9 +904,10 @@
 
 	input_register_device(&wacom->dev);
 
+	/* ask the tablet to report tablet data */
+	usb_set_report(intf, 3, 2, rep_data, 2);
+	/* repeat once (not sure why the first call often fails) */
 	usb_set_report(intf, 3, 2, rep_data, 2);
-	usb_set_report(intf, 3, 5, rep_data, 0);
-	usb_set_report(intf, 3, 6, rep_data, 0);
 
 	printk(KERN_INFO "input: %s on %s\n", wacom->features->name, path); 




--- /linux.bkbits.net:8080/linux-2.5/anno/drivers/usb/input/hid-core.c
2004-11-08 17:08:14.000000000 -0800
+++ hid-core.c	2004-11-09 10:19:47.000000000 -0800
@@ -1381,6 +1381,7 @@
 #define USB_DEVICE_ID_WACOM_INTUOS2	0x0040
 #define USB_DEVICE_ID_WACOM_VOLITO      0x0060
 #define USB_DEVICE_ID_WACOM_PTU         0x0003
+#define USB_DEVICE_ID_WACOM_INTUOS3     0x00B0
 
 #define USB_VENDOR_ID_KBGEAR            0x084e
 #define USB_DEVICE_ID_KBGEAR_JAMSTUDIO  0x1001
@@ -1521,6 +1522,9 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 7,
HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE
},
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3, HID_QUIRK_IGNORE
},
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3 + 1,
HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3 + 2,
HID_QUIRK_IGNORE },
 
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30,
HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30,
HID_QUIRK_IGNORE },






