Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTBLK5d>; Wed, 12 Feb 2003 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbTBLK5U>; Wed, 12 Feb 2003 05:57:20 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:44681 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267070AbTBLK5A>;
	Wed, 12 Feb 2003 05:57:00 -0500
Date: Wed, 12 Feb 2003 12:06:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Resurrect usb_set_report for Aiptek and Wacom tablets [12/14]
Message-ID: <20030212120638.K1563@ucw.cz>
References: <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz> <20030212120427.G1563@ucw.cz> <20030212120454.H1563@ucw.cz> <20030212120530.I1563@ucw.cz> <20030212120605.J1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120605.J1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:06:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1015, 2003-02-12 11:07:29+01:00, vojtech@suse.cz
  input: Resurrect usb_set_report for Aiptek and Wacom tablets.


 aiptek.c |   29 +++++++++++++++++------------
 wacom.c  |   14 ++++++++++++--
 2 files changed, 29 insertions(+), 14 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/aiptek.c b/drivers/usb/input/aiptek.c
--- a/drivers/usb/input/aiptek.c	Wed Feb 12 11:56:32 2003
+++ b/drivers/usb/input/aiptek.c	Wed Feb 12 11:56:32 2003
@@ -224,13 +224,18 @@
 		usb_unlink_urb(aiptek->irq);
 }
 
-/* 
- * FIXME, either remove this call, or talk the maintainer into 
- * adding usb_set_report back into the core.
- */
-#if 0
+#define USB_REQ_SET_REPORT	0x09
+static int
+usb_set_report(struct usb_device *dev, struct usb_host_interface *inter, unsigned char type,
+		unsigned char id, void *buf, int size)
+{
+	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+		USB_REQ_SET_REPORT, USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+		(type << 8) + id, inter->desc.bInterfaceNumber, buf, size, HZ);
+}
+
 static void
-aiptek_command(struct usb_device *dev, unsigned int ifnum,
+aiptek_command(struct usb_device *dev, struct usb_host_interface *inter,
 	       unsigned char command, unsigned char data)
 {
 	__u8 buf[3];
@@ -239,17 +244,17 @@
 	buf[1] = command;
 	buf[2] = data;
 
-	if (usb_set_report(dev, ifnum, 3, 2, buf, 3) != 3) {
+	if (usb_set_report(dev, inter, 3, 2, buf, 3) != 3) {
 		dbg("aiptek_command: 0x%x 0x%x\n", command, data);
 	}
 }
-#endif
 
 static int 
 aiptek_probe(struct usb_interface *intf,
 	     const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev (intf);
+	struct usb_host_interface *interface = intf->altsetting + 0;
 	struct usb_endpoint_descriptor *endpoint;
 	struct aiptek *aiptek;
 
@@ -271,11 +276,11 @@
 		return -ENOMEM;
 	}
 
-	// Resolution500LPI
-//	aiptek_command(dev, ifnum, 0x18, 0x04);
+	/* Resolution500LPI */
+	aiptek_command(dev, interface, 0x18, 0x04);
 
-	// SwitchToTablet
-//	aiptek_command(dev, ifnum, 0x10, 0x01);
+	/* SwitchToTablet */
+	aiptek_command(dev, interface, 0x10, 0x01);
 
 	aiptek->features = aiptek_features + id->driver_info;
 
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Wed Feb 12 11:56:32 2003
+++ b/drivers/usb/input/wacom.c	Wed Feb 12 11:56:32 2003
@@ -102,6 +102,17 @@
 	char phys[32];
 };
 
+#define USB_REQ_SET_REPORT	0x09
+static int usb_set_report(struct usb_interface *intf, unsigned char type,
+				unsigned char id, void *buf, int size)
+{
+        return usb_control_msg(interface_to_usbdev(intf),
+		usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+                USB_REQ_SET_REPORT, USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+                (type << 8) + id, intf->altsetting[0].desc.bInterfaceNumber,
+		buf, size, HZ);
+}
+
 static void wacom_pl_irq(struct urb *urb, struct pt_regs *regs)
 {
 	struct wacom *wacom = urb->context;
@@ -488,6 +499,7 @@
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *endpoint;
+	char rep_data[2] = {0x02, 0x02};
 	struct wacom *wacom;
 	char path[64];
 
@@ -582,11 +594,9 @@
 
 	input_register_device(&wacom->dev);
 
-#if 0	/* Missing usb_set_report() */
 	usb_set_report(intf, 3, 2, rep_data, 2);
 	usb_set_report(intf, 3, 5, rep_data, 0);
 	usb_set_report(intf, 3, 6, rep_data, 0);
-#endif
 
 	printk(KERN_INFO "input: %s on %s\n", wacom->features->name, path);
 
