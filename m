Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUEEXiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUEEXiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEEXiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:38:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63726 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264692AbUEEXh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:37:58 -0400
Date: Wed, 05 May 2004 16:35:58 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       roms@lpg.ticalc.org, jb@technologeek.org
Subject: Re: [PATCH 2.6.6-rc3] Add class support to drivers/usb/misc/tiglusb.c
Message-ID: <38560000.1083800158@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <20040505223510.GA30309@kroah.com>
References: <79660000.1083267538@dyn318071bld.beaverton.ibm.com> <20040502064915.GF3766@kroah.com> <36460000.1083795831@dyn318071bld.beaverton.ibm.com> <20040505223510.GA30309@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, May 05, 2004 03:35:10 PM -0700 Greg KH <greg@kroah.com> wrote:
> 
> Ick, don't destroy the whole class.  Not good.

3rd times the charm.... Only destroying the class when the module is removed.

Thanks.

Hanna

------
diff -Nrup -Xdontdiff linux-2.6.6-rc3/drivers/usb/misc/tiglusb.c linux-2.6.6-rc3p/drivers/usb/misc/tiglusb.c
--- linux-2.6.6-rc3/drivers/usb/misc/tiglusb.c	2004-04-27 18:34:59.000000000 -0700
+++ linux-2.6.6-rc3p/drivers/usb/misc/tiglusb.c	2004-05-05 15:40:27.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/usb.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <linux/ticable.h>
 #include "tiglusb.h"
@@ -49,6 +50,7 @@
 
 static tiglusb_t tiglusb[MAXTIGL];
 static int timeout = TIMAXTIME;	/* timeout in tenth of seconds     */
+static struct class_simple *tiglusb_class;
 
 /*---------- misc functions ------------------------------------------- */
 
@@ -336,7 +338,7 @@ tiglusb_probe (struct usb_interface *int
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	int minor = -1;
-	int i;
+	int i, err = 0;
 	ptiglusb_t s;
 
 	dbg ("probing vendor id 0x%x, device id 0x%x",
@@ -347,18 +349,23 @@ tiglusb_probe (struct usb_interface *int
 	 * the TIGL hardware, there's only 1 configuration.
 	 */
 
-	if (dev->descriptor.bNumConfigurations != 1)
-		return -ENODEV;
+	if (dev->descriptor.bNumConfigurations != 1) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	if ((dev->descriptor.idProduct != 0xe001)
-	    && (dev->descriptor.idVendor != 0x451))
-		return -ENODEV;
+	    && (dev->descriptor.idVendor != 0x451)) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	// NOTE:  it's already in this config, this shouldn't be needed.
 	// is this working around some hardware bug?
 	if (usb_reset_configuration (dev) < 0) {
 		err ("tiglusb_probe: reset_configuration failed");
-		return -ENODEV;
+		err = -ENODEV;
+		goto out;
 	}
 
 	/*
@@ -372,8 +379,10 @@ tiglusb_probe (struct usb_interface *int
 		}
 	}
 
-	if (minor == -1)
-		return -ENODEV;
+	if (minor == -1) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	s = &tiglusb[minor];
 
@@ -383,17 +392,28 @@ tiglusb_probe (struct usb_interface *int
 	up (&s->mutex);
 	dbg ("bound to interface");
 
-	devfs_mk_cdev(MKDEV(TIUSB_MAJOR, TIUSB_MINOR) + s->minor,
+	class_simple_device_add(tiglusb_class, MKDEV(TIUSB_MAJOR, TIUSB_MINOR + s->minor),
+			NULL, "usb%d", s->minor);
+	err = devfs_mk_cdev(MKDEV(TIUSB_MAJOR, TIUSB_MINOR) + s->minor,
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"ticables/usb/%d", s->minor);
 
+	if (err)
+		goto out_class;
+
 	/* Display firmware version */
 	info ("firmware revision %i.%02x",
 		dev->descriptor.bcdDevice >> 8,
 		dev->descriptor.bcdDevice & 0xff);
 
 	usb_set_intfdata (intf, s);
-	return 0;
+	err = 0;
+	goto out;
+
+out_class:
+	class_simple_device_remove(MKDEV(TIUSB_MAJOR, TIUSB_MINOR + s->minor));
+out:
+	return err;
 }
 
 static void
@@ -423,6 +443,7 @@ tiglusb_disconnect (struct usb_interface
 	s->dev = NULL;
 	s->opened = 0;
 
+	class_simple_device_remove(MKDEV(TIUSB_MAJOR, TIUSB_MINOR + s->minor));
 	devfs_remove("ticables/usb/%d", s->minor);
 
 	info ("device %d removed", s->minor);
@@ -473,7 +494,7 @@ static int __init
 tiglusb_init (void)
 {
 	unsigned u;
-	int result;
+	int result, err = 0;
 
 	/* initialize struct */
 	for (u = 0; u < MAXTIGL; u++) {
@@ -490,28 +511,41 @@ tiglusb_init (void)
 	/* register device */
 	if (register_chrdev (TIUSB_MAJOR, "tiglusb", &tiglusb_fops)) {
 		err ("unable to get major %d", TIUSB_MAJOR);
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
 
 	/* Use devfs, tree: /dev/ticables/usb/[0..3] */
 	devfs_mk_dir ("ticables/usb");
 
+	tiglusb_class = class_simple_create(THIS_MODULE, "tiglusb");
+	if (IS_ERR(tiglusb_class)) {
+		err = PTR_ERR(tiglusb_class);
+		goto out_chrdev;
+	}
 	/* register USB module */
 	result = usb_register (&tiglusb_driver);
 	if (result < 0) {
-		unregister_chrdev (TIUSB_MAJOR, "tiglusb");
-		return -1;
+		err = -1;
+		goto out_chrdev;
 	}
 
 	info (DRIVER_DESC ", version " DRIVER_VERSION);
 
-	return 0;
+	err = 0;
+	goto out;
+
+out_chrdev:
+	unregister_chrdev (TIUSB_MAJOR, "tiglusb");
+out:
+	return err;
 }
 
 static void __exit
 tiglusb_cleanup (void)
 {
 	usb_deregister (&tiglusb_driver);
+	class_simple_destroy(tiglusb_class);
 	devfs_remove("ticables/usb");
 	unregister_chrdev (TIUSB_MAJOR, "tiglusb");
 }

