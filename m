Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUCMIWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 03:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbUCMIWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 03:22:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:14025 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262790AbUCMIV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 03:21:58 -0500
Date: Sat, 13 Mar 2004 00:21:47 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] convert usb-serial core to use kref instead of kobject
Message-ID: <20040313082147.GB13084@kroah.com>
References: <20040313082003.GA13084@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313082003.GA13084@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll follow up with a patch that converts the usb-serial core from using
> kobjects to using krefs instead.

And here is that patch.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Sat Mar 13 00:04:44 2004
+++ b/drivers/usb/serial/usb-serial.c	Sat Mar 13 00:04:44 2004
@@ -391,7 +391,7 @@
 	struct usb_serial *serial = serial_table[index];
 
 	if (serial)
-		kobject_get (&serial->kobj);
+		kref_get(&serial->kref);
 	return serial;
 }
 
@@ -486,7 +486,7 @@
 		if (retval) {
 			port->open_count = 0;
 			module_put(serial->type->owner);
-			kobject_put(&serial->kobj);
+			kref_put(&serial->kref);
 		}
 	}
 bailout:
@@ -518,7 +518,7 @@
 	}
 
 	module_put(port->serial->type->owner);
-	kobject_put(&port->serial->kobj);
+	kref_put(&port->serial->kref);
 }
 
 static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
@@ -748,7 +748,7 @@
 			begin += length;
 			length = 0;
 		}
-		kobject_put(&serial->kobj);
+		kref_put(&serial->kref);
 	}
 	*eof = 1;
 done:
@@ -830,15 +830,15 @@
 	wake_up_interruptible(&tty->write_wait);
 }
 
-static void destroy_serial (struct kobject *kobj)
+static void destroy_serial(struct kref *kref)
 {
 	struct usb_serial *serial;
 	struct usb_serial_port *port;
 	int i;
 
-	dbg ("%s - %s", __FUNCTION__, kobj->name);
+	serial = to_usb_serial(kref);
 
-	serial = to_usb_serial(kobj);
+	dbg ("%s - %s", __FUNCTION__, serial->type->name);
 	serial_shutdown (serial);
 
 	/* return the minor range that this device had */
@@ -886,10 +886,6 @@
 	kfree (serial);
 }
 
-static struct kobj_type usb_serial_kobj_type = {
-	.release = destroy_serial,
-};
-
 static void port_release(struct device *dev)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
@@ -930,10 +926,7 @@
 	serial->interface = interface;
 	serial->vendor = dev->descriptor.idVendor;
 	serial->product = dev->descriptor.idProduct;
-
-	/* initialize the kobject portion of the usb_device */
-	kobject_init(&serial->kobj);
-	serial->kobj.ktype = &usb_serial_kobj_type;
+	kref_init(&serial->kref, destroy_serial);
 
 	return serial;
 }
@@ -1284,7 +1277,7 @@
 	if (serial) {
 		/* let the last holder of this object 
 		 * cause it to be cleaned up */
-		kobject_put (&serial->kobj);
+		kref_put(&serial->kref);
 	}
 	dev_info(dev, "device disconnected\n");
 }
diff -Nru a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	Sat Mar 13 00:04:33 2004
+++ b/drivers/usb/serial/usb-serial.h	Sat Mar 13 00:04:33 2004
@@ -55,6 +55,7 @@
 #define __LINUX_USB_SERIAL_H
 
 #include <linux/config.h>
+#include <linux/kref.h>
 
 #define SERIAL_TTY_MAJOR	188	/* Nice legal number now */
 #define SERIAL_TTY_MINORS	255	/* loads of devices :) */
@@ -163,10 +164,10 @@
 	__u16				vendor;
 	__u16				product;
 	struct usb_serial_port *	port[MAX_NUM_PORTS];
-	struct kobject			kobj;
+	struct kref			kref;
 	void *				private;
 };
-#define to_usb_serial(d) container_of(d, struct usb_serial, kobj)
+#define to_usb_serial(d) container_of(d, struct usb_serial, kref)
 
 #define NUM_DONT_CARE	(-1)
 
