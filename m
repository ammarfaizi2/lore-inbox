Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266094AbUF2VkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUF2VkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUF2VkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:40:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:29107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266094AbUF2Vjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:39:54 -0400
Date: Tue, 29 Jun 2004 14:37:56 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Harald Welte <laforge@gnumonks.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] fix different usb-serial oopses for 2.6.7
Message-ID: <20040629213756.GA21065@kroah.com>
References: <20040607215451.GA7531@kroah.com> <10866458194180@kroah.com> <20040616091710.GS12494@sunbeam.de.gnumonks.org> <20040616170409.GK12494@sunbeam.de.gnumonks.org> <20040616175800.GB13937@kroah.com> <20040616192503.GL12494@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com> <20040623161044.GA25681@kroah.com> <Pine.LNX.4.58.0406231216270.3273@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616192503.GL12494@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0406231216270.3273@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok, thanks to both of you posting bug reports that seemed quite
different, I think I've finally fixed both of your issues.  The patch
below is what I've just added to my trees and will send to Linus in a
bit, and should solve both problems.

Basically the issue was 2 things:
	- Zwane correctly found that we shouldn't have been calling the
	  usb_driver_release_interface() call on disconnect, but if you
	  didn't make this call, we leaked memory.  This was because of
	  the next piece...
	- Harald noticed that if you unloaded a usb-serial driver with
	  the device still plugged in, and then removed it, the kernel
	  oopsed.  He also noticed double calls to the disconnect
	  function.  This was because we were incorrectly binding the
	  device to the usb serial generic driver instead of the one
	  that was controlling it.

So, by fixing the usb-serial generic issue, that fixed the fact that we
shouldn't have been calling the release_interface() call, as it isn't
necessary (the usb core will take care of it.)

Thanks to everyone for helping out here, and if with this patch, you
still have problems, please let me know...

/me crosses his fingers

greg k-h


USB: fix bug where removing usb-serial modules or usb serial devices could oops
 
This fixes the issue where the Generic driver would bind to all usb-serial
devices, so the disconnect would not properly go to the real driver that
controlled the device.  This was very bad when unloading the module with
the device still connected.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
--- a/drivers/usb/serial/generic.c	2004-06-29 14:32:36 -07:00
+++ b/drivers/usb/serial/generic.c	2004-06-29 14:32:36 -07:00
@@ -53,6 +53,32 @@
 	.num_ports =		1,
 	.shutdown =		usb_serial_generic_shutdown,
 };
+
+/* we want to look at all devices, as the vendor/product id can change
+ * depending on the command line argument */
+static struct usb_device_id generic_serial_ids[] = {
+	{.driver_info = 42},
+	{}
+};
+
+static int generic_probe(struct usb_interface *interface,
+			       const struct usb_device_id *id)
+{
+	const struct usb_device_id *id_pattern;
+
+	id_pattern = usb_match_id(interface, generic_device_ids);
+	if (id_pattern != NULL)
+		return usb_serial_probe(interface, id);
+	return -ENODEV;
+}
+
+static struct usb_driver generic_driver = {
+	.owner =	THIS_MODULE,
+	.name =		"usbserial_generic",
+	.probe =	generic_probe,
+	.disconnect =	usb_serial_disconnect,
+	.id_table =	generic_serial_ids,
+};
 #endif
 
 int usb_serial_generic_register (int _debug)
@@ -67,6 +93,12 @@
 
 	/* register our generic driver with ourselves */
 	retval = usb_serial_register (&usb_serial_generic_device);
+	if (retval)
+		goto exit;
+	retval = usb_register(&generic_driver);
+	if (retval)
+		usb_serial_deregister(&usb_serial_generic_device);
+exit:
 #endif
 	return retval;
 }
@@ -75,6 +107,7 @@
 {
 #ifdef CONFIG_USB_SERIAL_GENERIC
 	/* remove our generic driver */
+	usb_deregister(&generic_driver);
 	usb_serial_deregister (&usb_serial_generic_device);
 #endif
 }
diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-06-29 14:32:36 -07:00
+++ b/drivers/usb/serial/usb-serial.c	2004-06-29 14:32:36 -07:00
@@ -355,25 +355,12 @@
 #define DRIVER_DESC "USB Serial Driver core"
 
 
-#ifdef CONFIG_USB_SERIAL_GENERIC
-/* we want to look at all devices, as the vendor/product id can change
- * depending on the command line argument */
-static struct usb_device_id generic_serial_ids[] = {
-	{.driver_info = 42},
-	{}
-};
-
-#endif /* CONFIG_USB_SERIAL_GENERIC */
-
 /* Driver structure we register with the USB core */
 static struct usb_driver usb_serial_driver = {
 	.owner =	THIS_MODULE,
 	.name =		"usbserial",
 	.probe =	usb_serial_probe,
 	.disconnect =	usb_serial_disconnect,
-#ifdef CONFIG_USB_SERIAL_GENERIC
-	.id_table =	generic_serial_ids,
-#endif
 };
 
 /* There is no MODULE_DEVICE_TABLE for usbserial.c.  Instead
@@ -1383,22 +1370,9 @@
 
 void usb_serial_deregister(struct usb_serial_device_type *device)
 {
-	struct usb_serial *serial;
-	int i;
-
 	info("USB Serial deregistering driver %s", device->name);
-
-	/* clear out the serial_table if the device is attached to a port */
-	for(i = 0; i < SERIAL_TTY_MINORS; ++i) {
-		serial = serial_table[i];
-		if ((serial != NULL) && (serial->type == device)) {
-			usb_driver_release_interface (&usb_serial_driver, serial->interface);
-			usb_serial_disconnect (serial->interface);
-		}
-	}
-
 	list_del(&device->driver_list);
-	usb_serial_bus_deregister (device);
+	usb_serial_bus_deregister(device);
 }
 
 
