Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUH3PIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUH3PIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUH3PIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:08:32 -0400
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:42825 "HELO
	boetes.org") by vger.kernel.org with SMTP id S268138AbUH3PHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:07:00 -0400
Date: Mon, 30 Aug 2004 17:06:55 +0159
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add a sysctl to control the refreshrate of USB-mice
Message-ID: <20040830150717.GC15605@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this patch which adds a sysctl that controls the refreshrate of
USB-mice.

I am not the author, I contacted him and he thought it was messy and
since he is busy he doesn't want to maintain it any longer. But since he
only posted a URL to the patch and the original site is no longer active
this patch was nearly lost.

Increasing the refreshrate is not compliant with the USB specifications
but it is possible and the higher precision of the mice benefits:

- Graphical artists who use the gimp for example.
- Gamers. Quake 3 players for example.


So even if this patch won't make it into the kernel it's at least
properly archived.



diff -ruNp a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2003-09-25 15:07:12.000000000 -0700
+++ b/drivers/usb/input/hid-core.c	2003-10-08 19:08:13.000000000 -0700
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/sysctl.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
 #include <linux/input.h>
@@ -42,9 +43,42 @@
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
 
+static unsigned hid_mouse_poll_interval = 2; /* 10 is default for HID mice, rounded off to 8 by root hub */
+
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+/*
+ * sysctl-tuning infrastructure.
+ */
+static ctl_table hid_table[] = {
+	{ 1, "hid_mouse_poll_interval", &hid_mouse_poll_interval, sizeof(int), 0644, NULL,
+	  &proc_dointvec, NULL, },
+	{ 0, }
+};
+
+static ctl_table hid_root[] = {
+	{ 1, "hid", NULL, 0, 0555, hid_table, },
+	{ 0, }
+};
+
+static ctl_table dev_root[] = {
+	{ CTL_DEV, "dev", NULL, 0, 0555, hid_root, },
+	{ 0, }
+};
 
+static struct ctl_table_header *sysctl_header;
+
+static int __init init_sysctl(void)
+{
+	sysctl_header = register_sysctl_table(dev_root, 0);
+	return 0;
+}
+
+static void __exit cleanup_sysctl(void)
+{
+	unregister_sysctl_table(sysctl_header);
+}
+
 /*
  * Register a new report for a device.
  */
@@ -1511,6 +1545,15 @@ static struct hid_device *usb_hid_config
 				continue;
 			if (!(hid->urbin = usb_alloc_urb(0, GFP_KERNEL)))
 				goto fail;
+
+			/* if (dev->descriptor.idVendor == 0x046d) { */
+			if (hid->collection[0].usage == 0x10002) {
+				endpoint->bInterval = hid_mouse_poll_interval;
+				printk("HID Mouse 0x%x forced to %d ms polling\n",
+					dev->descriptor.idProduct,
+					endpoint->bInterval);
+			}
+
 			pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 			usb_fill_int_urb(hid->urbin, dev, pipe, hid->inbuf, 0,
 					 hid_irq_in, hid, endpoint->bInterval);
@@ -1694,6 +1737,7 @@ static struct usb_driver hid_driver = {
 static int __init hid_init(void)
 {
 	int retval;
+	init_sysctl();
 	retval = hiddev_init();
 	if (retval)
 		goto hiddev_init_fail;
@@ -1711,6 +1755,7 @@ hiddev_init_fail:
 
 static void __exit hid_exit(void)
 {
+	cleanup_sysctl();
 	hiddev_exit();
 	usb_deregister(&hid_driver);
 }



# Han
