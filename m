Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263046AbSJHNjH>; Tue, 8 Oct 2002 09:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbSJHNjG>; Tue, 8 Oct 2002 09:39:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39060 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263046AbSJHNiq>;
	Tue, 8 Oct 2002 09:38:46 -0400
Date: Tue, 8 Oct 2002 15:44:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Update of wacom.c from 2.4 and Wacom Inc. [6/23]
Message-ID: <20021008154415.E18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154246.D18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:42:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.35, 2002-09-24 21:24:25+02:00, vojtech@suse.cz
  Update Wacom driver to 2.4 changes and changes from Ping Cheng of Wacom.


 hid-core.c |   26 +++++++
 wacom.c    |  208 +++++++++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 166 insertions(+), 68 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Oct  8 15:27:04 2002
+++ b/drivers/usb/input/hid-core.c	Tue Oct  8 15:27:04 2002
@@ -1284,8 +1284,14 @@
 }
 
 #define USB_VENDOR_ID_WACOM		0x056a
+#define USB_DEVICE_ID_WACOM_PENPARTNER	0x0000
 #define USB_DEVICE_ID_WACOM_GRAPHIRE	0x0010
 #define USB_DEVICE_ID_WACOM_INTUOS	0x0020
+#define USB_DEVICE_ID_WACOM_PL		0x0030
+#define USB_DEVICE_ID_WACOM_INTUOS2	0x0040
+
+#define USB_VENDOR_ID_AIPTEK		0x08ca
+#define USB_VENDOR_ID_AIPTEK_6000	0x0020
 
 #define USB_VENDOR_ID_GRIFFIN		0x077d
 #define USB_DEVICE_ID_POWERMATE		0x0410
@@ -1306,14 +1312,30 @@
 	__u16 idProduct;
 	unsigned quirks;
 } hid_blacklist[] = {
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PENPARTNER, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 4, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE  },
-	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE  },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 3, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 4, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 4, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_6000, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Tue Oct  8 15:27:04 2002
+++ b/drivers/usb/input/wacom.c	Tue Oct  8 15:27:04 2002
@@ -1,15 +1,14 @@
 /*
- * $Id: wacom.c,v 1.28 2001/09/25 10:12:07 vojtech Exp $
+ *  USB Wacom Graphire and Wacom Intuos tablet support
  *
- *  Copyright (c) 2000-2001 Vojtech Pavlik	<vojtech@ucw.cz>
+ *  Copyright (c) 2000-2002 Vojtech Pavlik	<vojtech@ucw.cz>
  *  Copyright (c) 2000 Andreas Bach Aaen	<abach@stofanet.dk>
  *  Copyright (c) 2000 Clifford Wolf		<clifford@clifford.at>
  *  Copyright (c) 2000 Sam Mosel		<sam.mosel@computer.org>
  *  Copyright (c) 2000 James E. Blair		<corvus@gnu.org>
  *  Copyright (c) 2000 Daniel Egger		<egger@suse.de>
  *  Copyright (c) 2001 Frederic Lepied		<flepied@mandrakesoft.com>
- *
- *  USB Wacom Graphire and Wacom Intuos tablet support
+ *  Copyright (c) 2002 Ping Cheng		<pingc@wacom.com>
  *
  *  ChangeLog:
  *      v0.1 (vp)  - Initial release
@@ -37,6 +36,18 @@
  *	v1.21 (vp) - Removed protocol descriptions
  *		   - Added MISC_SERIAL for tool serial numbers
  *	      (gb) - Identify version on module load.
+ *    v1.21.1 (fl) - added Graphire2 support
+ *    v1.21.2 (fl) - added Intuos2 support
+ *                 - added all the PL ids
+ *    v1.21.3 (fl) - added another eraser id from Neil Okamoto
+ *                 - added smooth filter for Graphire from Peri Hankey
+ *                 - added PenPartner support from Olaf van Es
+ *                 - new tool ids from Ole Martin Bjoerndalen
+ *	v1.29 (pc) - Add support for more tablets
+ *		   - Fix pressure reporting
+ *	v1.30 (vp) - Merge 2.4 and 2.5 drivers
+ *		   - Since 2.5 now has input_sync(), remove MSC_SERIAL abuse
+ *		   - Cleanups here and there
  */
 
 /*
@@ -44,19 +55,6 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/kernel.h>
@@ -69,7 +67,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.21"
+#define DRIVER_VERSION "v1.30"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB Wacom Graphire and Wacom Intuos tablet driver"
 #define DRIVER_LICENSE "GPL"
@@ -104,7 +102,6 @@
 	struct wacom_features *features;
 	int tool[2];
 	int open;
-	int x, y;
 	__u32 serial[2];
 	char phys[32];
 };
@@ -114,29 +111,50 @@
 	struct wacom *wacom = urb->context;
 	unsigned char *data = wacom->data;
 	struct input_dev *dev = &wacom->dev;
-	int prox;
+	int prox, pressure;
 
 	if (urb->status) return;
 
 	if (data[0] != 2)
 		dbg("received unknown report #%d", data[0]);
 
-	prox = data[1] & 0x20;
+	prox = data[1] & 0x40;
 	
 	input_report_key(dev, BTN_TOOL_PEN, prox);
 	
 	if (prox) {
-		int pressure = (data[4] & 0x04) >> 2 | ((__u32)(data[7] & 0x7f) << 1);
 
-		input_report_abs(dev, ABS_X, data[3] | ((__u32)data[2] << 8) | ((__u32)(data[1] & 0x03) << 16));
-		input_report_abs(dev, ABS_Y, data[6] | ((__u32)data[5] << 8) | ((__u32)(data[4] & 0x03) << 8));
-		input_report_abs(dev, ABS_PRESSURE, (data[7] & 0x80) ? (255 - pressure) : (pressure + 255));
+		pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
+		if (wacom->features->pressure_max > 255)
+			pressure = (pressure << 1) | ((data[4] >> 6) & 1);
+		pressure += (wacom->features->pressure_max + 1) / 2;
+
+		input_report_abs(dev, ABS_X, data[3] | ((__u32)data[2] << 7) | ((__u32)(data[1] & 0x03) << 14));
+		input_report_abs(dev, ABS_Y, data[6] | ((__u32)data[5] << 7) | ((__u32)(data[4] & 0x03) << 14));
+		input_report_abs(dev, ABS_PRESSURE, pressure);
+
 		input_report_key(dev, BTN_TOUCH, data[4] & 0x08);
 		input_report_key(dev, BTN_STYLUS, data[4] & 0x10);
 		input_report_key(dev, BTN_STYLUS2, data[4] & 0x20);
 	}
 	
-	input_event(dev, EV_MSC, MSC_SERIAL, 0);
+	input_sync(dev);
+}
+
+static void wacom_penpartner_irq(struct urb *urb)
+{
+	struct wacom *wacom = urb->context;
+	unsigned char *data = wacom->data;
+	struct input_dev *dev = &wacom->dev;
+
+	if (urb->status) return;
+
+	input_report_key(dev, BTN_TOOL_PEN, 1);
+	input_report_abs(dev, ABS_X, data[2] << 8 | data[1]);
+	input_report_abs(dev, ABS_Y, data[4] << 8 | data[3]);
+	input_report_abs(dev, ABS_PRESSURE, (signed char)data[6] + 127);
+	input_report_key(dev, BTN_TOUCH, ((signed char)data[6] > -80) && !(data[5] & 0x20));
+	input_report_key(dev, BTN_STYLUS, (data[5] & 0x40));
 	input_sync(dev);
 }
 
@@ -176,13 +194,13 @@
 			input_report_abs(dev, ABS_X, x);
 			input_report_abs(dev, ABS_Y, y);
 
-			input_event(dev, EV_MSC, MSC_SERIAL, data[1] & 0x01);
+			input_sync(dev);
 			return;
 	}
 
 	if (data[1] & 0x80) {
-		input_report_abs(dev, ABS_X, wacom->x = x);
-		input_report_abs(dev, ABS_Y, wacom->y = y);
+		input_report_abs(dev, ABS_X, x);
+		input_report_abs(dev, ABS_Y, y);
 	}
 
 	input_report_abs(dev, ABS_PRESSURE, data[6] | ((__u32)data[7] << 8));
@@ -190,8 +208,6 @@
 	input_report_key(dev, BTN_STYLUS, data[1] & 0x02);
 	input_report_key(dev, BTN_STYLUS2, data[1] & 0x04);
 
-	input_event(dev, EV_MSC, MSC_SERIAL, data[1] & 0x01);
-
 	input_sync(dev);
 }
 
@@ -221,27 +237,32 @@
 			case 0x832:
 			case 0x012: wacom->tool[idx] = BTN_TOOL_PENCIL;		break;	/* Inking pen */
 			case 0x822:
+			case 0x842:
+			case 0x852:
 			case 0x022: wacom->tool[idx] = BTN_TOOL_PEN;		break;	/* Pen */
 			case 0x812:
 			case 0x032: wacom->tool[idx] = BTN_TOOL_BRUSH;		break;	/* Stroke pen */
+			case 0x007:
 		        case 0x09c:
-			case 0x094: wacom->tool[idx] = BTN_TOOL_MOUSE;		break;	/* Mouse 4D */
+			case 0x094: wacom->tool[idx] = BTN_TOOL_MOUSE;		break;	/* Mouse 4D and 2D */
 			case 0x096: wacom->tool[idx] = BTN_TOOL_LENS;		break;	/* Lens cursor */
 			case 0x82a:
+			case 0x85a:
 		        case 0x91a:
 			case 0x0fa: wacom->tool[idx] = BTN_TOOL_RUBBER;		break;	/* Eraser */
 			case 0x112: wacom->tool[idx] = BTN_TOOL_AIRBRUSH;	break;	/* Airbrush */
 			default:    wacom->tool[idx] = BTN_TOOL_PEN;		break;	/* Unknown tool */
-		}	
+		}
 
 		input_report_key(dev, wacom->tool[idx], 1);
-		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+		input_report_abs(dev, ABS_SERIAL, wacom->serial[idx]);
+		input_sync(dev);
 		return;
 	}
 
 	if ((data[1] & 0xfe) == 0x80) {						/* Exit report */
 		input_report_key(dev, wacom->tool[idx], 0);
-		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+		input_sync(dev);
 		return;
 	}
 
@@ -274,61 +295,109 @@
 
 		} else {
 
-			input_report_key(dev, BTN_LEFT,   data[8] & 0x01);
-			input_report_key(dev, BTN_MIDDLE, data[8] & 0x02);
-			input_report_key(dev, BTN_RIGHT,  data[8] & 0x04);
-
 	 		if ((data[1] & 0x10) == 0) {				/* 4D mouse packets */
 
+				input_report_key(dev, BTN_LEFT,   data[8] & 0x01);
+				input_report_key(dev, BTN_MIDDLE, data[8] & 0x02);
+				input_report_key(dev, BTN_RIGHT,  data[8] & 0x04);
+
 				input_report_key(dev, BTN_SIDE,   data[8] & 0x20);
 				input_report_key(dev, BTN_EXTRA,  data[8] & 0x10);
 				input_report_abs(dev, ABS_THROTTLE,  (data[8] & 0x08) ?
 						 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3) :
 						 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3));
 
-			} else {						/* Lens cursor packets */
-
-				input_report_key(dev, BTN_SIDE,   data[8] & 0x10);
-				input_report_key(dev, BTN_EXTRA,  data[8] & 0x08);
+			} else {
+				if (wacom->tool[idx] == BTN_TOOL_MOUSE) {	/* 2D mouse packets */	
+					input_report_key(dev, BTN_LEFT,   data[8] & 0x04);
+					input_report_key(dev, BTN_MIDDLE, data[8] & 0x08);
+					input_report_key(dev, BTN_RIGHT,  data[8] & 0x10);
+					input_report_abs(dev, REL_WHEEL, 
+					    ((__u32)(data[8] & 0x01) - (__u32)((data[8] & 0x02) >> 1)));
+				}
+				else {     /* Lens cursor packets */
+					input_report_key(dev, BTN_LEFT,   data[8] & 0x01);
+					input_report_key(dev, BTN_MIDDLE, data[8] & 0x02);
+					input_report_key(dev, BTN_RIGHT,  data[8] & 0x04);
+					input_report_key(dev, BTN_SIDE,   data[8] & 0x10);
+					input_report_key(dev, BTN_EXTRA,  data[8] & 0x08);
+				}
 			}
 		}
 	}
 	
-	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
-
 	input_sync(dev);
 }
 
 #define WACOM_INTUOS_TOOLS	(BIT(BTN_TOOL_BRUSH) | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | BIT(BTN_TOOL_LENS))
 #define WACOM_INTUOS_BUTTONS	(BIT(BTN_SIDE) | BIT(BTN_EXTRA))
-#define WACOM_INTUOS_ABS	(BIT(ABS_TILT_X) | BIT(ABS_TILT_Y) | BIT(ABS_RZ) | BIT(ABS_THROTTLE))
+#define WACOM_INTUOS_ABS	(BIT(ABS_TILT_X) | BIT(ABS_TILT_Y) | BIT(ABS_RZ) | BIT(ABS_THROTTLE) | BIT(ABS_SERIAL))
 
 struct wacom_features wacom_features[] = {
-	{ "Wacom Graphire",      8, 10206,  7422,  511, 32, wacom_graphire_irq,
-		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
-	{ "Wacom Intuos 4x5",   10, 12700, 10360, 1023, 15, wacom_intuos_irq,
+	{ "Wacom Penpartner",    7,   5040,  3780,  255, 32, wacom_penpartner_irq,
+		0, 0, 0, 0 },
+        { "Wacom Graphire",      8,  10206,  7422,  511, 32, wacom_graphire_irq,
+                BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
+	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 32, wacom_graphire_irq,
+ 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
+ 	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, wacom_graphire_irq,
+ 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
+  	{ "Wacom Intuos 4x5",   10,  12700, 10360, 1023, 15, wacom_intuos_irq,
+ 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
+ 	{ "Wacom Intuos 6x8",   10,  20600, 16450, 1023, 15, wacom_intuos_irq,
+ 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
+ 	{ "Wacom Intuos 9x12",  10,  30670, 24130, 1023, 15, wacom_intuos_irq,
+ 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
+ 	{ "Wacom Intuos 12x12", 10,  30670, 31040, 1023, 15, wacom_intuos_irq,
+ 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
+ 	{ "Wacom Intuos 12x18", 10,  45860, 31040, 1023, 15, wacom_intuos_irq,
+ 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
+ 	{ "Wacom PL400",         8,   5408,  4056,  255, 32, wacom_pl_irq,
+ 		0,  0, 0, 0 },
+ 	{ "Wacom PL500",         8,   6144,  4608,  255, 32, wacom_pl_irq,
+ 		0,  0, 0, 0 },
+ 	{ "Wacom PL600",         8,   6126,  4604,  255, 32, wacom_pl_irq,
+ 		0,  0, 0, 0 },
+ 	{ "Wacom PL600SX",       8,   6260,  5016,  255, 32, wacom_pl_irq,
+ 		0,  0, 0, 0 },
+ 	{ "Wacom PL550",         8,   6144,  4608,  511, 32, wacom_pl_irq,
+ 		0,  0, 0, 0 },
+ 	{ "Wacom PL800",         8,   7220,  5780,  511, 32, wacom_pl_irq,
+ 		0,  0, 0, 0 },
+	{ "Wacom Intuos2 4x5",   10, 12700, 10360, 1023, 15, wacom_intuos_irq,
 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos 6x8",   10, 20320, 15040, 1023, 15, wacom_intuos_irq,
+	{ "Wacom Intuos2 6x8",   10, 20600, 16450, 1023, 15, wacom_intuos_irq,
 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos 9x12",  10, 30480, 23060, 1023, 15, wacom_intuos_irq,
+	{ "Wacom Intuos2 9x12",  10, 30670, 24130, 1023, 15, wacom_intuos_irq,
 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos 12x12", 10, 30480, 30480, 1023, 15, wacom_intuos_irq,
+	{ "Wacom Intuos2 12x12", 10, 30670, 31040, 1023, 15, wacom_intuos_irq,
 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos 12x18", 10, 47720, 30480, 1023, 15, wacom_intuos_irq,
+	{ "Wacom Intuos2 12x18", 10, 45860, 31040, 1023, 15, wacom_intuos_irq,
 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom PL500",        8,  12328, 9256,   511, 32, wacom_pl_irq,
-		0,  0, 0, 0 },
-	{ NULL , 0 }
+ 	{ }
 };
 
 struct usb_device_id wacom_ids[] = {
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x10), .driver_info = 0 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20), .driver_info = 1 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21), .driver_info = 2 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22), .driver_info = 3 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x23), .driver_info = 4 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x24), .driver_info = 5 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x31), .driver_info = 6 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x00), driver_info: 0 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x10), driver_info: 1 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11), driver_info: 2 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12), driver_info: 3 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20), driver_info: 4 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21), driver_info: 5 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22), driver_info: 6 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x23), driver_info: 7 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x24), driver_info: 8 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x30), driver_info: 9 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x31), driver_info: 10 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x32), driver_info: 11 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x33), driver_info: 12 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x34), driver_info: 13 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x35), driver_info: 14 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x41), driver_info: 15 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x42), driver_info: 16 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43), driver_info: 17 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44), driver_info: 18 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45), driver_info: 19 },
 	{ }
 };
 
@@ -358,9 +427,10 @@
 
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
-	struct usb_device *dev = interface_to_usbdev (intf);
+	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *endpoint;
 	struct wacom *wacom;
+	char rep_data[2] = {0x02, 0x02};
 	char path[64];
 
 	if (!(wacom = kmalloc(sizeof(struct wacom), GFP_KERNEL)))
@@ -382,13 +452,12 @@
 
 	wacom->features = wacom_features + id->driver_info;
 
-	wacom->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_MSC) | wacom->features->evbit;
+	wacom->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | wacom->features->evbit;
 	wacom->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) | BIT(ABS_DISTANCE) | BIT(ABS_WHEEL) | wacom->features->absbit;
 	wacom->dev.relbit[0] |= wacom->features->relbit;
 	wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE) | wacom->features->btnbit;
 	wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE) |
 		BIT(BTN_TOUCH) | BIT(BTN_STYLUS) | BIT(BTN_STYLUS2) | wacom->features->digibit;
-	wacom->dev.mscbit[0] |= BIT(MSC_SERIAL);
 
 	wacom->dev.absmax[ABS_X] = wacom->features->x_max;
 	wacom->dev.absmax[ABS_Y] = wacom->features->y_max;
@@ -435,9 +504,16 @@
 
 	input_register_device(&wacom->dev);
 
+#if 0	/* Missing usb_set_report() */
+	usb_set_report(intf, 3, 2, rep_data, 2);
+	usb_set_report(intf, 3, 5, rep_data, 0);
+	usb_set_report(intf, 3, 6, rep_data, 0);
+#endif
+
 	printk(KERN_INFO "input: %s on %s\n", wacom->features->name, path);
 
 	dev_set_drvdata(&intf->dev, wacom);
+
 	return 0;
 }
 

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.35
## Wrapped with gzip_uu ##


begin 664 bkpatch18328
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
E1_)?H#+EUVE_+?];I3-FSDTXNSW2B&+7=&K(_P>K9$7GL2D`````
`
end
