Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbSLXBPC>; Mon, 23 Dec 2002 20:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbSLXBPC>; Mon, 23 Dec 2002 20:15:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2831 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267025AbSLXBPA>;
	Mon, 23 Dec 2002 20:15:00 -0500
Date: Mon, 23 Dec 2002 17:19:32 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: [RFC] initial tty class support for 2.5.52
Message-ID: <20021224011931.GA32397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a small patch against 2.5.52 that adds the start of tty class
support to the kernel.  It also enables the usb-serial drivers to use
this class.  With this patch, the /sys/class/tty directory looks like
the following on my machine (with 1 4 port usb-to-serial device plugged
in):

/sys/class/tty/
|-- devices
|   |-- 12 -> ../../../devices/pci0/00:1e.0/01:0d.1/usb3/3-1/ttyUSB0
|   |-- 13 -> ../../../devices/pci0/00:1e.0/01:0d.1/usb3/3-1/ttyUSB1
|   |-- 14 -> ../../../devices/pci0/00:1e.0/01:0d.1/usb3/3-1/ttyUSB2
|   `-- 15 -> ../../../devices/pci0/00:1e.0/01:0d.1/usb3/3-1/ttyUSB3
`-- drivers
    |-- usb-serial:clie_3.5 -> ../../../bus/usb-serial/drivers/clie_3.5
    |-- usb-serial:edgeport_1 -> ../../../bus/usb-serial/drivers/edgeport_1
    |-- usb-serial:edgeport_2 -> ../../../bus/usb-serial/drivers/edgeport_2
    |-- usb-serial:edgeport_4 -> ../../../bus/usb-serial/drivers/edgeport_4
    |-- usb-serial:edgeport_8 -> ../../../bus/usb-serial/drivers/edgeport_8
    |-- usb-serial:generic -> ../../../bus/usb-serial/drivers/generic
    |-- usb-serial:visor -> ../../../bus/usb-serial/drivers/visor
    |-- usb-serial:whiteheat -> ../../../bus/usb-serial/drivers/whiteheat
    `-- usb-serial:whiteheatnofirm -> ../../../bus/usb-serial/drivers/whiteheatnofirm

If no one has any problems with the patch, I'll send it on to Linus in a
few days.

thanks,

greg k-h


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Dec 23 17:14:36 2002
+++ b/drivers/char/tty_io.c	Mon Dec 23 17:14:36 2002
@@ -90,6 +90,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -2261,12 +2262,19 @@
 extern int vty_init(void);
 #endif
 
+struct device_class tty_devclass = {
+	.name	= "tty",
+};
+EXPORT_SYMBOL(tty_devclass);
+
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
 void __init tty_init(void)
 {
+	devclass_register(&tty_devclass);
+
 	/*
 	 * dev_tty_driver and dev_console_driver are actually magic
 	 * devices which get redirected at open time.  Nevertheless,
diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	Mon Dec 23 17:14:36 2002
+++ b/drivers/usb/serial/bus.c	Mon Dec 23 17:14:36 2002
@@ -128,6 +128,7 @@
 	device->driver.bus = &usb_serial_bus_type;
 	device->driver.probe = usb_serial_device_probe;
 	device->driver.remove = usb_serial_device_remove;
+	device->driver.devclass = &tty_devclass;
 
 	retval = driver_register(&device->driver);
 
diff -Nru a/include/linux/tty_driver.h b/include/linux/tty_driver.h
--- a/include/linux/tty_driver.h	Mon Dec 23 17:14:36 2002
+++ b/include/linux/tty_driver.h	Mon Dec 23 17:14:36 2002
@@ -227,4 +227,6 @@
 #define SERIAL_TYPE_NORMAL	1
 #define SERIAL_TYPE_CALLOUT	2
 
+extern struct device_class tty_devclass;
+
 #endif /* #ifdef _LINUX_TTY_DRIVER_H */
