Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQJZV60>; Thu, 26 Oct 2000 17:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQJZV6R>; Thu, 26 Oct 2000 17:58:17 -0400
Received: from styx.suse.cz ([195.70.145.226]:45564 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129110AbQJZV57>;
	Thu, 26 Oct 2000 17:57:59 -0400
Date: Thu, 26 Oct 2000 23:57:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Fixes for the input (joystick, USB) drivers
Message-ID: <20001026235728.A6232@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

The attached patch fixes many different little bugs in the USB input,
joystick input and core input drivers maintained by me.

drivers/char/joystick/adi.c:
	Fix gamepad handling for Logitech ThunderPad Digital and WingMan Gamepad

drivers/char/joystick/gamecon.c
	Fix PSX gamepad support - patch by Nathan Hand

drivers/char/joystick/iforce.c
	Fix breakage caused by recent usb_submit_urb() changes

drivers/char/joystick/ns558.c
	Fix the already fixed 'oops on rmmod' problem in a slightly different way
	Fix another two possible causes for 'oops on rmmod'

drivers/char/joystick/sidewinder.c
	Fix a missing button for Microsoft ForceFeedback Wheel

drivers/char/joystick/tmdc.c
	Fix the ThrustMaster FragMaster by adding specific support,
	generic support isn't good enough

drivers/input/evdev.c
	Fix two possible overflow cases.
	Add event write() support, needed badly

drivers/input/joydev.c
	Fix two possible overflow cases.
	
drivers/input/mousedev.c
	Fix two possible overflow cases.
	Change 5-button support from GenPS/2 to ImExPS/2, making it
	finally useful with XFree (which only supports ImExPS/2 5-button mice)
	Add xmax and ymax module parameters, needed for binary distribution

drivers/usb/usbkbd.c
	Fix breakage caused by recent usb_submit_urb() changes

drivers/usb/usbmouse.c
	Unify the usb_submit_urb() fix to match usbkbd, wacom and others

drivers/usb/wacom.c
	Fix the Intuos 4DMouse and Intuos Lens tool behavior (James E. Blair)

The patch is against 2.4.0-test10-pre5.

TIA.

-- 
Vojtech Pavlik
SuSE Labs

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="joybig2.diff"

diff -urN linux-test10-pre5-old/drivers/char/joystick/adi.c linux/drivers/char/joystick/adi.c
--- linux-test10-pre5-old/drivers/char/joystick/adi.c	Thu Jun 22 15:59:58 2000
+++ linux/drivers/char/joystick/adi.c	Thu Oct 26 23:02:11 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: adi.c,v 1.12 2000/06/03 20:18:52 vojtech Exp $
+ * $Id: adi.c,v 1.14 2000/10/23 07:28:57 vojtech Exp $
  *
  *  Copyright (c) 1998-2000 Vojtech Pavlik
  *
@@ -418,7 +418,7 @@
 	adi->dev.private = port;
 	adi->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
-	for (i = 0; i < adi->axes10 + adi->axes8 + adi->hats * 2; i++)
+	for (i = 0; i < adi->axes10 + adi->axes8 + (adi->hats + (adi->pad > 0)) * 2; i++)
 		set_bit(adi->abs[i], &adi->dev.absbit);
 
 	for (i = 0; i < adi->buttons; i++)
@@ -431,7 +431,7 @@
 
 	if (!adi->length) return;
 
-	for (i = 0; i < adi->axes10 + adi->axes8 + adi->hats * 2; i++) {
+	for (i = 0; i < adi->axes10 + adi->axes8 + (adi->hats + (adi->pad > 0)) * 2; i++) {
 
 		t = adi->abs[i];
 		x = adi->dev.abs[t];
diff -urN linux-test10-pre5-old/drivers/char/joystick/gamecon.c linux/drivers/char/joystick/gamecon.c
--- linux-test10-pre5-old/drivers/char/joystick/gamecon.c	Mon Aug 14 22:55:01 2000
+++ linux/drivers/char/joystick/gamecon.c	Thu Oct 26 23:02:11 2000
@@ -1,11 +1,11 @@
 /*
- * $Id: gamecon.c,v 1.5 2000/06/25 09:56:58 vojtech Exp $
+ * $Id: gamecon.c,v 1.10 2000/08/19 19:51:02 vojtech Exp $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
  *
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom
- *  	David Kuder
+ *  	David Kuder		Nathan Hand
  *
  *  Sponsored by SuSE
  */
@@ -75,8 +75,7 @@
 static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
 
 static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
-				"Multisystem 2-button joystick", "N64 controller", "PSX pad",
-				"PSX NegCon", "PSX Analog contoller" };
+				"Multisystem 2-button joystick", "N64 controller", "PSX controller" };
 /*
  * N64 support.
  */
@@ -205,22 +204,30 @@
 
 /*
  * PSX support
- */
-
-#define GC_PSX_DELAY	10
-#define GC_PSX_LENGTH	8	/* talk to the controller in bytes */
+ *
+ * See documentation at:
+ *	http://www.dim.com/~mackys/psxmemcard/ps-eng2.txt
+ *	http://www.gamesx.com/controldata/psxcont/psxcont.htm
+ *	ftp://milano.usal.es/pablo/
+ *	
+ */
+
+#define GC_PSX_DELAY	60		/* 60 usec */
+#define GC_PSX_LENGTH	8		/* talk to the controller in bytes */
+
+#define GC_PSX_MOUSE	1		/* Mouse */
+#define GC_PSX_NEGCON	2		/* NegCon */
+#define GC_PSX_NORMAL	4		/* Digital / Analog or Rumble in Digital mode  */
+#define GC_PSX_ANALOG	5		/* Analog in Analog mode / Rumble in Green mode */
+#define GC_PSX_RUMBLE	7		/* Rumble in Red mode */
+
+#define GC_PSX_CLOCK	0x04		/* Pin 4 */
+#define GC_PSX_COMMAND	0x01		/* Pin 1 */
+#define GC_PSX_POWER	0xf8		/* Pins 5-9 */
+#define GC_PSX_SELECT	0x02		/* Pin 3 */
 
-#define GC_PSX_MOUSE	0x12	/* PSX Mouse */
-#define GC_PSX_NEGCON	0x23	/* NegCon pad */
-#define GC_PSX_NORMAL	0x41	/* Standard Digital controller */
-#define GC_PSX_ANALOGR	0x73	/* Analog controller in Red mode */
-#define GC_PSX_ANALOGG	0x53	/* Analog controller in Green mode */
-
-#define GC_PSX_CLOCK	0x04	/* Pin 3 */
-#define GC_PSX_COMMAND	0x01	/* Pin 1 */
-#define GC_PSX_POWER	0xf8	/* Pins 5-9 */
-#define GC_PSX_SELECT	0x02	/* Pin 2 */
-#define GC_PSX_NOPOWER  0x04
+#define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
+#define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
 static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
@@ -233,19 +240,18 @@
 
 static int gc_psx_command(struct gc *gc, int b)
 {
-	int i, cmd, ret = 0;
+	int i, cmd, data = 0;
 
-	cmd = (b & 1) ? GC_PSX_COMMAND : 0;
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 8; i++, b >>= 1) {
+		cmd = (b & 1) ? GC_PSX_COMMAND : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_POWER);
 		udelay(GC_PSX_DELAY);
-		ret |= ((parport_read_status(gc->pd->port) ^ 0x80) & gc->pads[GC_PSX]) ? (1 << i) : 0;
-		cmd = (b & 1) ? GC_PSX_COMMAND : 0;
+		if (parport_read_status(gc->pd->port) ^ 0x80) & gc->pads[GC_PSX])
+		data |= ((parport_read_status(gc->pd->port) ^ 0x80) & gc->pads[GC_PSX]) ? (1 << i) : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
 		udelay(GC_PSX_DELAY);
-		b >>= 1;
 	}
-	return ret;
+	return data;
 }
 
 /*
@@ -253,29 +259,31 @@
  * device identifier code.
  */
 
-static int gc_psx_read_packet(struct gc *gc, int length, unsigned char *data)
+static int gc_psx_read_packet(struct gc *gc, unsigned char *data)
 {
-	int i, ret;
+	int i, id;
 	unsigned long flags;
 
+	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);	/* Select pad */
+	udelay(GC_PSX_DELAY * 2);
+	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_POWER);			/* Deselect, begin command */
+	udelay(GC_PSX_DELAY * 2);
+
 	__save_flags(flags);
 	__cli();
 
-	parport_write_data(gc->pd->port, GC_PSX_POWER);
-
-	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);	/* Select pad */
-	udelay(GC_PSX_DELAY * 2);
 	gc_psx_command(gc, 0x01);							/* Access pad */
-	ret = gc_psx_command(gc, 0x42);							/* Get device id */
-	if (gc_psx_command(gc, 0) == 'Z')						/* okay? */
-		for (i = 0; i < length; i++)
+	id = gc_psx_command(gc, 0x42);							/* Get device id */
+	if (gc_psx_command(gc, 0) == 0x5a) {						/* Okay? */
+		for (i = 0; i < GC_PSX_LEN(id) * 2; i++)
 			data[i] = gc_psx_command(gc, 0);
-	else ret = -1;
+	} else id = 0;
 
-	parport_write_data(gc->pd->port, GC_PSX_SELECT | GC_PSX_CLOCK | GC_PSX_POWER);
 	__restore_flags(flags);
 
-	return ret;
+	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);
+
+	return GC_PSX_ID(id);
 }
 
 /*
@@ -316,8 +324,8 @@
 				input_report_abs(dev + i, ABS_X,  axes[0]);
 				input_report_abs(dev + i, ABS_Y, -axes[1]);
 
-				input_report_abs(dev + i, ABS_HAT0X, !!(s & data[7]) - !!(s & data[6]));
-				input_report_abs(dev + i, ABS_HAT0Y, !!(s & data[5]) - !!(s & data[4]));
+				input_report_abs(dev + i, ABS_HAT0X, !(s & data[6]) - !(s & data[7]));
+				input_report_abs(dev + i, ABS_HAT0Y, !(s & data[4]) - !(s & data[5]));
 
 				for (j = 0; j < 10; j++)
 					input_report_key(dev + i, gc_n64_btn[j], s & data[gc_n64_bytes[j]]);
@@ -338,8 +346,8 @@
 			s = gc_status_bit[i];
 
 			if (s & (gc->pads[GC_NES] | gc->pads[GC_SNES])) {
-				input_report_abs(dev + i, ABS_X, !!(s & data[7]) - !!(s & data[6]));
-				input_report_abs(dev + i, ABS_Y, !!(s & data[5]) - !!(s & data[4]));
+				input_report_abs(dev + i, ABS_X, ! - !(s & data[6]) - !(s & data[7]));
+				input_report_abs(dev + i, ABS_Y, ! - !(s & data[4]) - !(s & data[5]));
 			}
 
 			if (s & gc->pads[GC_NES])
@@ -365,8 +373,8 @@
 			s = gc_status_bit[i];
 
 			if (s & (gc->pads[GC_MULTI] | gc->pads[GC_MULTI2])) {
-				input_report_abs(dev + i, ABS_X, !!(s & data[3]) - !!(s & data[2]));
-				input_report_abs(dev + i, ABS_Y, !!(s & data[1]) - !!(s & data[0]));
+				input_report_abs(dev + i, ABS_X,  !(s & data[2]) - !(s & data[3]));
+				input_report_abs(dev + i, ABS_Y,  !(s & data[0]) - !(s & data[1]));
 				input_report_key(dev + i, BTN_TRIGGER, s & data[4]);
 			}
 
@@ -385,37 +393,37 @@
 	       		if (gc->pads[GC_PSX] & gc_status_bit[i])
 				break;
 
- 		switch (gc_psx_read_packet(gc, 6, data)) {
+ 		switch (gc_psx_read_packet(gc, data)) {
+
+			case GC_PSX_RUMBLE:
+
+				input_report_key(dev + i, BTN_THUMB,  ~data[0] & 0x04);
+				input_report_key(dev + i, BTN_THUMB2, ~data[0] & 0x02);
+
+			case GC_PSX_NEGCON:
+			case GC_PSX_ANALOG:
 
-			case GC_PSX_ANALOGG:
-	
 				for (j = 0; j < 4; j++)
 					input_report_abs(dev + i, gc_psx_abs[j], data[j + 2]);
 
-				input_report_abs(dev + i, ABS_HAT0X, !!(data[0]&0x20) - !!(data[0]&0x80));
-				input_report_abs(dev + i, ABS_HAT0Y, !!(data[0]&0x40) - !!(data[0]&0x10));
+				input_report_abs(dev + i, ABS_HAT0X, !(data[0] & 0x20) - !(data[0] & 0x80));
+				input_report_abs(dev + i, ABS_HAT0Y, !(data[0] & 0x40) - !(data[0] & 0x10));
 
 				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << i));
+					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
 
 				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
 				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
 
 				break;
 
-			case GC_PSX_ANALOGR:
-
-				input_report_key(dev + i, BTN_THUMB,  ~data[0] & 0x04);
-				input_report_key(dev + i, BTN_THUMB2, ~data[0] & 0x02);
-
 			case GC_PSX_NORMAL:
-			case GC_PSX_NEGCON:
 
-				input_report_abs(dev + i, ABS_X, 128 + !!(data[0] & 0x20) * 127 - !!(data[0] & 0x80) * 128);
-				input_report_abs(dev + i, ABS_Y, 128 + !!(data[0] & 0x40) * 127 - !!(data[0] & 0x10) * 128);
+				input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
+				input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
 
 				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << i));
+					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
 
 				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
 				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
@@ -448,14 +456,12 @@
 	}
 }
 
-
-
 static struct gc __init *gc_probe(int *config)
 {
 	struct gc *gc;
 	struct parport *pp;
-	int i, j, psx, pbtn;
-	unsigned char data[2];
+	int i, j, psx;
+	unsigned char data[32];
 
 	if (config[0] < 0)
 		return NULL;
@@ -545,44 +551,42 @@
 
 			case GC_PSX:
 				
-				psx = gc_psx_read_packet(gc, 2, data);
+				psx = gc_psx_read_packet(gc, data);
 
 				switch(psx) {
 					case GC_PSX_NEGCON:
-						config[i + 1] += 1;
 					case GC_PSX_NORMAL:
-						pbtn = 10;
-						break;
+					case GC_PSX_ANALOG:
+					case GC_PSX_RUMBLE:
 
-					case GC_PSX_ANALOGG:
-					case GC_PSX_ANALOGR:
-						config[i + 1] += 2;
-						pbtn = 12;
 						for (j = 0; j < 6; j++) {
 							psx = gc_psx_abs[j];
 							set_bit(psx, gc->dev[i].absbit);
-							gc->dev[i].absmin[psx] = 4;
-							gc->dev[i].absmax[psx] = 252;
-							gc->dev[i].absflat[psx] = 2;
+							if (j < 4) {
+								gc->dev[i].absmin[psx] = 4;
+								gc->dev[i].absmax[psx] = 252;
+								gc->dev[i].absflat[psx] = 2;
+							} else {
+								gc->dev[i].absmin[psx] = -1;
+								gc->dev[i].absmax[psx] = 1;
+							}
 						}
+
+						for (j = 0; j < 12; j++)
+							set_bit(gc_psx_btn[j], gc->dev[i].keybit);
+
 						break;
 
-					case -1:
+					case 0:
 						gc->pads[GC_PSX] &= ~gc_status_bit[i];
-						pbtn = 0;
 						printk(KERN_ERR "gamecon.c: No PSX controller found.\n");
 						break;
 
 					default:
 						gc->pads[GC_PSX] &= ~gc_status_bit[i];
-						pbtn = 0;
 						printk(KERN_WARNING "gamecon.c: Unsupported PSX controller %#x,"
 							" please report to <vojtech@suse.cz>.\n", psx);
 				}
-
-				for (j = 0; j < pbtn; j++)
-					set_bit(gc_psx_btn[j], gc->dev[i].keybit);
-
 				break;
 		}
 
diff -urN linux-test10-pre5-old/drivers/char/joystick/iforce.c linux/drivers/char/joystick/iforce.c
--- linux-test10-pre5-old/drivers/char/joystick/iforce.c	Tue Aug 22 20:41:14 2000
+++ linux/drivers/char/joystick/iforce.c	Thu Oct 26 23:13:29 2000
@@ -54,6 +54,7 @@
 
 struct iforce {
 	signed char data[IFORCE_MAX_LENGTH];
+	struct usb_device *usbdev;
 	struct input_dev dev;
 	struct urb irq;
 	int open;
@@ -113,9 +114,11 @@
 {
 	struct iforce *iforce = dev->private;
 
-	if (dev->idbus == BUS_USB && !iforce->open++)
+	if (dev->idbus == BUS_USB && !iforce->open++) {
+		iforce->irq.dev = iforce->usbdev;
 		if (usb_submit_urb(&iforce->irq))
 			return -EIO;
+	}
 
 	return 0;
 }
diff -urN linux-test10-pre5-old/drivers/char/joystick/ns558.c linux/drivers/char/joystick/ns558.c
--- linux-test10-pre5-old/drivers/char/joystick/ns558.c	Thu Oct 26 23:04:19 2000
+++ linux/drivers/char/joystick/ns558.c	Thu Oct 26 23:02:53 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: ns558.c,v 1.16 2000/08/17 20:03:56 vojtech Exp $
+ * $Id: ns558.c,v 1.21 2000/10/18 12:29:35 vojtech Exp $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
  *  Copyright (c) 1999 Brian Gerst
@@ -37,6 +37,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/gameport.h>
 #include <linux/malloc.h>
 #include <linux/isapnp.h>
@@ -47,7 +48,7 @@
 #define NS558_PNP	2
 #define NS558_PCI	3
 
-static int ns558_isa_portlist[] = { 0x201, 0x202, 0x203, 0x204, 0x205, 0x207, 0x209,
+static int ns558_isa_portlist[] = { 0x200, 0x201, 0x202, 0x203, 0x204, 0x205, 0x207, 0x209,
 				    0x20b, 0x20c, 0x20e, 0x20f, 0x211, 0x219, 0x101, 0 };
 
 struct ns558 {
@@ -58,7 +59,7 @@
 };
 	
 static struct ns558 *ns558;
-static int have_pci_devices;
+static int ns558_pci;
 
 /*
  * ns558_isa_probe() tries to find an isa gameport at the
@@ -188,12 +189,10 @@
 	}
 	memset(port, 0, sizeof(struct ns558));
 
-	port->next = ns558;
 	port->type = NS558_PCI;
 	port->gameport.io = ioport;
 	port->gameport.size = iolen;
 	port->dev = pdev;
-	ns558 = port;
 
 	pdev->driver_data = port;
 
@@ -312,13 +311,10 @@
 #endif
 
 /*
- * Probe for PCI ports.  Always probe for PCI first,
- * it is the least-invasive probe.
+ * Probe for PCI ports.
  */
 
-	i = pci_module_init(&ns558_pci_driver);
-	if (i == 0)
-		have_pci_devices = 1;
+	ns558_pci = !pci_module_init(&ns558_pci_driver);
 
 /*
  * Probe for ISA ports.
@@ -339,12 +335,15 @@
 	}
 #endif
 
-	return ns558 ? 0 : -ENODEV;
+	return (ns558 || ns558_pci) ? 0 : -ENODEV;
 }
 
 void __exit ns558_exit(void)
 {
-	struct ns558 *port = ns558;
+	struct ns558 *next, *port = ns558;
+
+	if (ns558_pci)
+		pci_unregister_driver(&ns558_pci_driver);
 
 	while (port) {
 		gameport_unregister_port(&port->gameport);
@@ -365,11 +364,10 @@
 				break;
 		}
 		
-		port = port->next;
+		next = port->next;
+		kfree(port);
+		port = next;
 	}
-
-	if (have_pci_devices)
-		pci_unregister_driver(&ns558_pci_driver);
 }
 
 module_init(ns558_init);
diff -urN linux-test10-pre5-old/drivers/char/joystick/sidewinder.c linux/drivers/char/joystick/sidewinder.c
--- linux-test10-pre5-old/drivers/char/joystick/sidewinder.c	Mon Aug 14 22:55:01 2000
+++ linux/drivers/char/joystick/sidewinder.c	Thu Oct 26 23:02:53 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: sidewinder.c,v 1.16 2000/07/14 09:02:41 vojtech Exp $
+ * $Id: sidewinder.c,v 1.17 2000/10/25 09:56:09 vojtech Exp $
  *
  *  Copyright (c) 1998-2000 Vojtech Pavlik
  *
@@ -102,7 +102,7 @@
 	{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_SELECT },
 	{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_SELECT },
 	{ BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z, BTN_TL, BTN_TR, BTN_START, BTN_MODE, BTN_SELECT },
-	{ BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_THUMB2, BTN_BASE, BTN_BASE2, BTN_BASE3 }};
+	{ BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_THUMB2, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4 }};
 
 static struct {
 	int x;
diff -urN linux-test10-pre5-old/drivers/char/joystick/tmdc.c linux/drivers/char/joystick/tmdc.c
--- linux-test10-pre5-old/drivers/char/joystick/tmdc.c	Wed Jun 21 17:22:21 2000
+++ linux/drivers/char/joystick/tmdc.c	Thu Oct 26 23:24:34 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: tmdc.c,v 1.18 2000/06/08 19:59:59 vojtech Exp $
+ * $Id: tmdc.c,v 1.20 2000/08/25 16:28:03 vojtech Exp $
  *
  *  Copyright (c) 1998-2000 Vojtech Pavlik
  *
@@ -49,6 +49,7 @@
 
 #define TMDC_MODE_M3DI		1
 #define TMDC_MODE_3DRP		3
+#define TMDC_MODE_FM		8
 #define TMDC_MODE_FGP		163
 
 #define TMDC_BYTE_ID		10
@@ -192,6 +193,15 @@
 
 					break;
 
+				case TMDC_MODE_FM:
+
+					for (i = 0; i < 8; i++)
+						input_report_key(dev, tmdc_btn_joy[i],
+							(data[j][tmdc_byte_d[0]] >> (i + 0)) & 1);
+					for (i = 0; i < 2; i++)
+						input_report_key(dev, tmdc_btn_joy[i + 8],
+							(data[j][tmdc_byte_d[1]] >> (i + 6)) & 1);
+
 				default:
 
 					for (i = 0; i < ((data[j][TMDC_BYTE_DEF] & 0xf) << 3) && i < TMDC_BTN_JOY; i++)
@@ -239,6 +249,7 @@
 		char padbtn;
 	} models[] = {	{   1, "ThrustMaster Millenium 3D Inceptor",	  6, 0, 6,  0 },
 			{   3, "ThrustMaster Rage 3D Gamepad",		  2, 0, 0, 10 },
+			{   8, "ThrustMaster FragMaster",		  4, 0, 0, 10 },
 			{ 163, "Thrustmaster Fusion GamePad",		  2, 0, 0, 10 },
 			{   0, "Unknown %d-axis, %d-button TM device %d", 0, 0, 0,  0 }};
 	unsigned char data[2][TMDC_MAX_LENGTH];
diff -urN linux-test10-pre5-old/drivers/input/evdev.c linux/drivers/input/evdev.c
--- linux-test10-pre5-old/drivers/input/evdev.c	Fri Jul 28 03:36:54 2000
+++ linux/drivers/input/evdev.c	Thu Oct 26 23:02:53 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: evdev.c,v 1.10 2000/06/23 09:23:00 vojtech Exp $
+ * $Id: evdev.c,v 1.16 2000/10/17 07:41:53 vojtech Exp $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
  *
@@ -123,7 +123,7 @@
 	struct evdev_list *list;
 	int i = MINOR(inode->i_rdev) - EVDEV_MINOR_BASE;
 
-	if (i > EVDEV_MINORS || !evdev_table[i])
+	if (i >= EVDEV_MINORS || !evdev_table[i])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct evdev_list), GFP_KERNEL)))
@@ -145,7 +145,19 @@
 
 static ssize_t evdev_write(struct file * file, const char * buffer, size_t count, loff_t *ppos)
 {
-	return -EINVAL;
+	struct evdev_list *list = file->private_data;
+	struct input_event event;
+	int retval = 0;
+
+	while (retval < count) {
+
+		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
+			return -EFAULT;
+		input_event(list->evdev->handle.dev, event.type, event.code, event.value);
+		retval += sizeof(struct input_event);
+	}
+
+	return retval;
 }
 
 static ssize_t evdev_read(struct file * file, char * buffer, size_t count, loff_t *ppos)
@@ -288,7 +300,7 @@
 	int minor;
 
 	for (minor = 0; minor < EVDEV_MINORS && evdev_table[minor]; minor++);
-	if (evdev_table[minor]) {
+	if (minor == EVDEV_MINORS) {
 		printk(KERN_ERR "evdev: no more free evdev devices\n");
 		return NULL;
 	}
diff -urN linux-test10-pre5-old/drivers/input/joydev.c linux/drivers/input/joydev.c
--- linux-test10-pre5-old/drivers/input/joydev.c	Tue Aug 22 18:06:31 2000
+++ linux/drivers/input/joydev.c	Thu Oct 26 23:02:53 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: joydev.c,v 1.13 2000/08/14 21:05:26 vojtech Exp $
+ * $Id: joydev.c,v 1.15 2000/10/17 07:41:53 vojtech Exp $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik 
  *  Copyright (c) 1999 Colin Van Dyke 
@@ -193,7 +193,7 @@
 	struct joydev_list *list;
 	int i = MINOR(inode->i_rdev) - JOYDEV_MINOR_BASE;
 
-	if (i > JOYDEV_MINORS || !joydev_table[i])
+	if (i >= JOYDEV_MINORS || !joydev_table[i])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct joydev_list), GFP_KERNEL)))
@@ -395,7 +395,7 @@
 		|| test_bit(BTN_1, dev->keybit)))) return NULL; 
 
 	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
-	if (joydev_table[minor]) {
+	if (minor == JOYDEV_MINORS) {
 		printk(KERN_ERR "joydev: no more free joydev devices\n");
 		return NULL;
 	}
diff -urN linux-test10-pre5-old/drivers/input/mousedev.c linux/drivers/input/mousedev.c
--- linux-test10-pre5-old/drivers/input/mousedev.c	Tue Aug 22 18:06:31 2000
+++ linux/drivers/input/mousedev.c	Thu Oct 26 23:02:53 2000
@@ -1,9 +1,9 @@
 /*
- * $Id: mousedev.c,v 1.15 2000/08/14 21:05:26 vojtech Exp $
+ * $Id: mousedev.c,v 1.20 2000/10/18 12:12:26 vojtech Exp $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
  *
- *  Input driver to PS/2 or ImPS/2 device driver module.
+ *  Input driver to ImExPS/2 device driver module.
  *
  *  Sponsored by SuSE
  */
@@ -65,20 +65,22 @@
 	signed char ps2[6];
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
-	unsigned char mode, genseq, impseq;
+	unsigned char mode, imexseq, impsseq;
 };
 
-#define MOUSEDEV_GENIUS_LEN	5
-#define MOUSEDEV_IMPS_LEN	6
+#define MOUSEDEV_SEQ_LEN	6
 
-static unsigned char mousedev_genius_seq[] = { 0xe8, 3, 0xe6, 0xe6, 0xe6 };
 static unsigned char mousedev_imps_seq[] = { 0xf3, 200, 0xf3, 100, 0xf3, 80 };
+static unsigned char mousedev_imex_seq[] = { 0xf3, 200, 0xf3, 200, 0xf3, 80 };
 
 static struct input_handler mousedev_handler;
 
 static struct mousedev *mousedev_table[MOUSEDEV_MINORS];
 static struct mousedev mousedev_mix;
 
+static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
+static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
+
 static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct mousedev *mousedevs[3] = { handle->private, &mousedev_mix, NULL };
@@ -96,12 +98,12 @@
 					switch (code) {
 						case ABS_X:	
 							size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-							list->dx += (value * CONFIG_INPUT_MOUSEDEV_SCREEN_X - list->oldx) / size;
+							list->dx += (value * xres - list->oldx) / size;
 							list->oldx += list->dx * size;
 							break;
 						case ABS_Y:
 							size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-							list->dy -= (value * CONFIG_INPUT_MOUSEDEV_SCREEN_Y - list->oldy) / size;
+							list->dy -= (value * yres - list->oldy) / size;
 							list->oldy -= list->dy * size;
 							break;
 					}
@@ -121,12 +123,12 @@
 						case BTN_TOUCH:
 						case BTN_LEFT:   index = 0; break;
 						case BTN_4:
-						case BTN_EXTRA:  if (list->mode > 1) { index = 4; break; }
+						case BTN_EXTRA:  if (list->mode == 2) { index = 4; break; }
 						case BTN_STYLUS:
 						case BTN_1:
 						case BTN_RIGHT:  index = 1; break;
 						case BTN_3:
-						case BTN_SIDE:   if (list->mode > 1) { index = 3; break; }
+						case BTN_SIDE:   if (list->mode == 2) { index = 3; break; }
 						case BTN_2:
 						case BTN_STYLUS2:
 						case BTN_MIDDLE: index = 2; break;	
@@ -213,7 +215,7 @@
 	struct mousedev_list *list;
 	int i = MINOR(inode->i_rdev) - MOUSEDEV_MINOR_BASE;
 
-	if (i > MOUSEDEV_MINORS || !mousedev_table[i])
+	if (i >= MOUSEDEV_MINORS || !mousedev_table[i])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct mousedev_list), GFP_KERNEL)))
@@ -254,14 +256,19 @@
 	list->dy -= list->ps2[off + 2];
 	list->bufsiz = off + 3;
 
-	if (list->mode > 1)
-		list->ps2[off] |= ((list->buttons & 0x18) << 3);
+	if (list->mode == 2) {
+		list->ps2[off + 3] = (list->dz > 7 ? 7 : (list->dz < -7 ? -7 : list->dz)) & 0x0f;
+		list->dz -= list->ps2[off + 3];
+		list->ps2[off + 3] |= ((list->buttons & 0x18) << 1);
+		list->bufsiz++;
+	}
 	
-	if (list->mode) {
+	if (list->mode == 1) {
 		list->ps2[off + 3] = (list->dz > 127 ? 127 : (list->dz < -127 ? -127 : list->dz));
-		list->bufsiz++;
 		list->dz -= list->ps2[off + 3];
+		list->bufsiz++;
 	}
+
 	if (!list->dx && !list->dy && (!list->mode || !list->dz)) list->ready = 0;
 	list->buffer = list->bufsiz;
 }
@@ -277,24 +284,23 @@
 
 		c = buffer[i];
 
-		if (c == mousedev_genius_seq[list->genseq]) {
-			if (++list->genseq == MOUSEDEV_GENIUS_LEN) {
-				list->genseq = 0;
-				list->ready = 1;
+		if (c == mousedev_imex_seq[list->imexseq]) {
+			if (++list->imexseq == MOUSEDEV_SEQ_LEN) {
+				list->imexseq = 0;
 				list->mode = 2;
 			}
-		} else list->genseq = 0;
+		} else list->imexseq = 0;
 
-		if (c == mousedev_imps_seq[list->impseq]) {
-			if (++list->impseq == MOUSEDEV_IMPS_LEN) {
-				list->impseq = 0;
-				list->ready = 1;
+		if (c == mousedev_imps_seq[list->impsseq]) {
+			if (++list->impsseq == MOUSEDEV_SEQ_LEN) {
+				list->impsseq = 0;
 				list->mode = 1;
 			}
-		} else list->impseq = 0;
+		} else list->impsseq = 0;
 
 		list->ps2[0] = 0xfa;
 		list->bufsiz = 1;
+		list->ready = 1;
 
 		switch (c) {
 
@@ -303,16 +309,16 @@
 				break;
 
 			case 0xf2: /* Get ID */
-				list->ps2[1] = (list->mode == 1) ? 3 : 0;
+				switch (list->mode) {
+					case 0: list->ps2[1] = 0;
+					case 1: list->ps2[1] = 3;
+					case 2: list->ps2[1] = 4;
+				}
 				list->bufsiz = 2;
 				break;
 
 			case 0xe9: /* Get info */
-				if (list->mode == 2) {
-					list->ps2[1] = 0x00; list->ps2[2] = 0x33; list->ps2[3] = 0x55;
-				} else {
-					list->ps2[1] = 0x60; list->ps2[2] = 3; list->ps2[3] = 200;
-				}
+				list->ps2[1] = 0x60; list->ps2[2] = 3; list->ps2[3] = 200;
 				list->bufsiz = 4;
 				break;
 		}
@@ -407,7 +413,7 @@
 		return NULL;
 
 	for (minor = 0; minor < MOUSEDEV_MINORS && mousedev_table[minor]; minor++);
-	if (mousedev_table[minor]) {
+	if (minor == MOUSEDEV_MINORS) {
 		printk(KERN_ERR "mousedev: no more free mousedev devices\n");
 		return NULL;
 	}
@@ -487,3 +493,7 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input driver to PS/2 or ImPS/2 device driver");
+MODULE_PARM(xres, "i");
+MODULE_PARM_DESC(xres, "Horizontal screen resolution");
+MODULE_PARM(yres, "i");
+MODULE_PARM_DESC(yres, "Vertical screen resolution");
diff -urN linux-test10-pre5-old/drivers/usb/usbkbd.c linux/drivers/usb/usbkbd.c
--- linux-test10-pre5-old/drivers/usb/usbkbd.c	Wed Aug 23 00:19:52 2000
+++ linux/drivers/usb/usbkbd.c	Thu Oct 26 23:11:19 2000
@@ -59,6 +59,7 @@
 
 struct usb_kbd {
 	struct input_dev dev;
+	struct usb_device *usbdev;
 	unsigned char new[8];
 	unsigned char old[8];
 	struct urb irq, led;
@@ -116,6 +117,7 @@
 		return 0;
 
 	kbd->leds = kbd->newleds;
+	kbd->led.dev = kbd->usbdev;
 	if (usb_submit_urb(&kbd->led))
 		err("usb_submit_urb(leds) failed");
 
@@ -133,6 +135,7 @@
 		return;
 
 	kbd->leds = kbd->newleds;
+	kbd->led.dev = kbd->usbdev;
 	if (usb_submit_urb(&kbd->led))
 		err("usb_submit_urb(leds) failed");
 }
@@ -144,6 +147,7 @@
 	if (kbd->open++)
 		return 0;
 
+	kbd->irq.dev = kbd->usbdev;
 	if (usb_submit_urb(&kbd->irq))
 		return -EIO;
 
@@ -186,6 +190,8 @@
 
 	if (!(kbd = kmalloc(sizeof(struct usb_kbd), GFP_KERNEL))) return NULL;
 	memset(kbd, 0, sizeof(struct usb_kbd));
+
+	kbd->usbdev = dev;
 
 	kbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 	kbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL) | BIT(LED_COMPOSE) | BIT(LED_KANA);
diff -urN linux-test10-pre5-old/drivers/usb/usbmouse.c linux/drivers/usb/usbmouse.c
--- linux-test10-pre5-old/drivers/usb/usbmouse.c	Thu Oct 26 23:04:25 2000
+++ linux/drivers/usb/usbmouse.c	Thu Oct 26 23:10:38 2000
@@ -1,5 +1,5 @@
 /*
- * $Id: usbmouse.c,v 1.5 2000/05/29 09:01:52 vojtech Exp $
+ * $Id: usbmouse.c,v 1.6 2000/08/14 21:05:26 vojtech Exp $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
  *
@@ -41,9 +41,9 @@
 struct usb_mouse {
 	signed char data[8];
 	char name[128];
+	struct usb_device *usbdev;
 	struct input_dev dev;
 	struct urb irq;
-	struct usb_device *my_usb_device;	// for resubmitting my urb
 	int open;
 };
 
@@ -73,7 +73,7 @@
 	if (mouse->open++)
 		return 0;
 
-	mouse->irq.dev = mouse->my_usb_device;
+	mouse->irq.dev = mouse->usbdev;
 	if (usb_submit_urb(&mouse->irq))
 		return -EIO;
 
@@ -116,6 +116,8 @@
 	if (!(mouse = kmalloc(sizeof(struct usb_mouse), GFP_KERNEL))) return NULL;
 	memset(mouse, 0, sizeof(struct usb_mouse));
 
+	mouse->usbdev = dev;
+
 	mouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	mouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
 	mouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
@@ -150,7 +152,6 @@
 
 	kfree(buf);
 
-	mouse->my_usb_device = dev;
 	FILL_INT_URB(&mouse->irq, dev, pipe, mouse->data, maxp > 8 ? 8 : maxp,
 		usb_mouse_irq, mouse, endpoint->bInterval);
 
diff -urN linux-test10-pre5-old/drivers/usb/wacom.c linux/drivers/usb/wacom.c
--- linux-test10-pre5-old/drivers/usb/wacom.c	Thu Oct 26 23:04:25 2000
+++ linux/drivers/usb/wacom.c	Thu Oct 26 23:27:27 2000
@@ -1,10 +1,11 @@
 /*
- * $Id: wacom.c,v 1.9 2000/05/29 09:01:52 vojtech Exp $
+ * $Id: wacom.c,v 1.11 2000/10/18 12:12:26 vojtech Exp $
  *
  *  Copyright (c) 2000 Vojtech Pavlik		<vojtech@suse.cz>
  *  Copyright (c) 2000 Andreas Bach Aaen	<abach@stofanet.dk>
  *  Copyright (c) 2000 Clifford Wolf		<clifford@clifford.at>
  *  Copyright (c) 2000 Sam Mosel		<sam.mosel@computer.org>
+ *  Copyright (c) 2000 James E. Blair		<corvus@gnu.org>
  *
  *  USB Wacom Graphire and Wacom Intuos tablet support
  *
@@ -21,23 +22,25 @@
  *	v1.8 (vp)  - Submit URB only when operating, moved to CVS,
  *			use input_report_key instead of report_btn and
  *			other cleanups
+ *	v1.11 (vp) - Add URB ->dev setting for new kernels
+ *	v1.11 (jb) - Add support for the 4D Mouse & Lens
  */
 
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
  * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
@@ -70,17 +73,17 @@
  * byte 5: Y high bits
  * byte 6: pen pressure low bits / mouse wheel
  * byte 7: pen presure high bits / mouse distance
- * 
+ *
  * There are also two single-byte feature reports (2 and 3).
  *
  * Wacom Intuos status packet:
  *
  * byte 0: report ID (2)
- * byte 1: bit7		1 - sync bit 
+ * byte 1: bit7		1 - sync bit
  *	   bit6		pointer in range
  *	   bit5		pointer type report
  *	   bit4		0 ?
- *	   bit3		0 ?
+ *	   bit3		mouse packet type
  *	   bit2		pen button2
  *	   bit1		pen button1
  *	   bit0		0 ?
@@ -88,12 +91,38 @@
  * byte 3: X low bits
  * byte 4: Y high bits
  * byte 5: Y low bits
+ *
+ * Pen packet:
+ *
  * byte 6: bits 0-7: pressure	(bits 2-9)
  * byte 7: bits 6-7: pressure	(bits 0-1)
  * byte 7: bits 0-5: X tilt	(bits 1-6)
  * byte 8: bit    7: X tilt	(bit  0)
  * byte 8: bits 0-6: Y tilt	(bits 0-6)
  * byte 9: bits 4-7: distance
+ *
+ * Mouse packet type 0:
+ *
+ * byte 6: bits 0-7: wheel	(bits 2-9)
+ * byte 7: bits 6-7: wheel	(bits 0-1)
+ * byte 7: bits 0-5: 0
+ * byte 8: bits 6-7: 0
+ * byte 8: bit    5: left extra button
+ * byte 8: bit    4: right extra button
+ * byte 8: bit    3: wheel      (sign)
+ * byte 8: bit    2: right button
+ * byte 8: bit    1: middle button
+ * byte 8: bit    0: left button
+ * byte 9: bits 4-7: distance
+ *
+ * Mouse packet type 1:
+ *
+ * byte 6: bits 0-7: rotation	(bits 2-9)
+ * byte 7: bits 6-7: rotation	(bits 0-1)
+ * byte 7: bit    5: rotation	(sign)
+ * byte 7: bits 0-4: 0
+ * byte 8: bits 0-7: 0
+ * byte 9: bits 4-7: distance
  */
 
 #define USB_VENDOR_ID_WACOM	0x056a
@@ -192,7 +221,7 @@
 			case 0x0fa: wacom->tool = BTN_TOOL_RUBBER;	break;	/* Eraser */
 			case 0x112: wacom->tool = BTN_TOOL_AIRBRUSH;	break;	/* Airbrush */
 			default:    wacom->tool = BTN_TOOL_PEN;		break;	/* Unknown tool */
-		}			
+		}	
 		input_report_key(dev, wacom->tool, 1);
 		return;
 	}
@@ -205,31 +234,63 @@
 
 	input_report_abs(dev, ABS_X, ((__u32)data[2] << 8) | data[3]);
 	input_report_abs(dev, ABS_Y, ((__u32)data[4] << 8) | data[5]);
-	input_report_abs(dev, ABS_PRESSURE, t = ((__u32)data[6] << 2) | ((data[7] >> 6) & 3));
 	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);
-	input_report_abs(dev, ABS_TILT_X, ((data[7] << 1) & 0x7e) | (data[8] >> 7));
-	input_report_abs(dev, ABS_TILT_Y, data[8] & 0x7f);
 
-	input_report_key(dev, BTN_STYLUS, data[1] & 2);
-	input_report_key(dev, BTN_STYLUS2, data[1] & 4);
-	input_report_key(dev, BTN_TOUCH, t > 10);
+	switch (wacom->tool) {
+
+		case BTN_TOOL_PENCIL:
+		case BTN_TOOL_PEN:
+		case BTN_TOOL_BRUSH:
+		case BTN_TOOL_RUBBER:
+		case BTN_TOOL_AIRBRUSH:
+
+			input_report_abs(dev, ABS_PRESSURE, t = ((__u32)data[6] << 2) | ((data[7] >> 6) & 3));
+			input_report_abs(dev, ABS_TILT_X, ((data[7] << 1) & 0x7e) | (data[8] >> 7));
+			input_report_abs(dev, ABS_TILT_Y, data[8] & 0x7f);
+			input_report_key(dev, BTN_STYLUS, data[1] & 2);
+			input_report_key(dev, BTN_STYLUS2, data[1] & 4);
+			input_report_key(dev, BTN_TOUCH, t > 10);
+			break;
+
+		case BTN_TOOL_MOUSE:
+		case BTN_TOOL_LENS:
+
+			if (data[1] & 0x02) {			/* Rotation packet */
+				input_report_abs(dev, ABS_RZ, (data[7] & 0x20) ?
+					((__u32)data[6] << 2) | ((data[7] >> 6) & 3):
+					(-(((__u32)data[6] << 2) | ((data[7] >> 6) & 3))) - 1);
+				break;
+			}
+
+			input_report_key(dev, BTN_LEFT,   data[8] & 0x01);
+			input_report_key(dev, BTN_MIDDLE, data[8] & 0x02);
+			input_report_key(dev, BTN_RIGHT,  data[8] & 0x04);
+			input_report_key(dev, BTN_SIDE,   data[8] & 0x20);
+			input_report_key(dev, BTN_EXTRA,  data[8] & 0x10);
+			input_report_abs(dev, ABS_THROTTLE,  (data[8] & 0x08) ?
+				((__u32)data[6] << 2) | ((data[7] >> 6) & 3) :
+				-((__u32)data[6] << 2) | ((data[7] >> 6) & 3));
+			break;
+	  }
 }
 
 #define WACOM_INTUOS_TOOLS	(BIT(BTN_TOOL_BRUSH) | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | BIT(BTN_TOOL_LENS))
+#define WACOM_INTUOS_BUTTONS	(BIT(BTN_SIDE) | BIT(BTN_EXTRA))
+#define WACOM_INTUOS_ABS	(BIT(ABS_TILT_X) | BIT(ABS_TILT_Y) | BIT(ABS_RZ) | BIT(ABS_THROTTLE))
 
 struct wacom_features wacom_features[] = {
 	{ "Wacom Graphire",     0x10,  8, 10206,  7422,  511, 32, wacom_graphire_irq,
-		BIT(EV_REL), 0, BIT(REL_WHEEL), BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE), 0 },
+		BIT(EV_REL), 0, 0, 0 },
 	{ "Wacom Intuos 4x5",   0x20, 10, 12700, 10360, 1023, 15, wacom_intuos_irq,
-		0, BIT(ABS_TILT_X) | BIT(ABS_TILT_Y), 0, 0, WACOM_INTUOS_TOOLS },
+		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
 	{ "Wacom Intuos 6x8",   0x21, 10, 20320, 15040, 1023, 15, wacom_intuos_irq,
-		0, BIT(ABS_TILT_X) | BIT(ABS_TILT_Y), 0, 0, WACOM_INTUOS_TOOLS },
+		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
 	{ "Wacom Intuos 9x12",  0x22, 10, 30480, 23060, 1023, 15, wacom_intuos_irq,
-		0, BIT(ABS_TILT_X) | BIT(ABS_TILT_Y), 0, 0, WACOM_INTUOS_TOOLS },
+		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
 	{ "Wacom Intuos 12x12", 0x23, 10, 30480, 30480, 1023, 15, wacom_intuos_irq,
-		0, BIT(ABS_TILT_X) | BIT(ABS_TILT_Y), 0, 0, WACOM_INTUOS_TOOLS },
+		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
 	{ "Wacom Intuos 12x18", 0x24, 10, 47720, 30480, 1023, 15, wacom_intuos_irq,
-		0, BIT(ABS_TILT_X) | BIT(ABS_TILT_Y), 0, 0, WACOM_INTUOS_TOOLS },
+		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
 	{ NULL , 0 }
 };
 
@@ -275,7 +336,7 @@
 	wacom->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | wacom->features->evbit;
 	wacom->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) | BIT(ABS_DISTANCE) | wacom->features->absbit;
 	wacom->dev.relbit[0] |= wacom->features->relbit;
-	wacom->dev.keybit[LONG(BTN_LEFT)] |= wacom->features->btnbit;
+	wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE) | wacom->features->btnbit;
 	wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE) |
 		BIT(BTN_TOUCH) | BIT(BTN_STYLUS) | BIT(BTN_STYLUS2) | wacom->features->digibit;
 
@@ -285,6 +346,14 @@
 	wacom->dev.absmax[ABS_DISTANCE] = wacom->features->distance_max;
 	wacom->dev.absmax[ABS_TILT_X] = 127;
 	wacom->dev.absmax[ABS_TILT_Y] = 127;
+
+	wacom->dev.absmin[ABS_RZ] = -900;
+	wacom->dev.absmax[ABS_RZ] = 899;
+	wacom->dev.absmin[ABS_THROTTLE] = -1023;
+	wacom->dev.absmax[ABS_THROTTLE] = 1023;
+
+	wacom->dev.absfuzz[ABS_X] = 4;
+	wacom->dev.absfuzz[ABS_Y] = 4;
 
 	wacom->dev.private = wacom;
 	wacom->dev.open = wacom_open;

--J/dobhs11T7y2rNN--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
