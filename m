Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVFKHur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVFKHur (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVFKHuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:50:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:63683 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261641AbVFKHsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:39 -0400
Subject: [PATCH] Rename TTY_DRIVER_NO_DEVFS to TTY_DRIVER_DYNAMIC_DEV
In-Reply-To: <11184761122236@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <1118476112352@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've always found this flag confusing.  Now that devfs is no longer around, it
has been renamed, and the documentation for when this flag should be used has
been updated.

Also fixes all drivers that use this flag.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/ppc/4xx_io/serial_sicc.c   |    2 +-
 drivers/char/ip2main.c          |    2 +-
 drivers/char/pty.c              |    4 ++--
 drivers/char/rocket.c           |    4 ++--
 drivers/char/tty_io.c           |    8 ++++----
 drivers/isdn/i4l/isdn_tty.c     |    2 +-
 drivers/s390/char/tty3270.c     |    2 +-
 drivers/serial/crisv10.c        |    2 +-
 drivers/serial/serial_core.c    |    2 +-
 drivers/tc/zs.c                 |    2 +-
 drivers/usb/class/bluetty.c     |    2 +-
 drivers/usb/class/cdc-acm.c     |    2 +-
 drivers/usb/gadget/serial.c     |    2 +-
 drivers/usb/serial/usb-serial.c |    2 +-
 include/linux/tty_driver.h      |   13 ++++++++++---
 net/bluetooth/rfcomm/tty.c      |    2 +-
 16 files changed, 30 insertions(+), 23 deletions(-)

--- gregkh-2.6.orig/drivers/char/tty_io.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/tty_io.c	2005-06-10 23:37:26.000000000 -0700
@@ -2664,8 +2664,8 @@
  *	tty device it can be set to NULL safely.
  *
  * This call is required to be made to register an individual tty device if
- * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If that
- * bit is not set, this function should not be called.
+ * the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If that
+ * bit is not set, this function should not be called by a tty driver.
  */
 void tty_register_device(struct tty_driver *driver, unsigned index,
 			 struct device *device)
@@ -2817,7 +2817,7 @@
 	
 	list_add(&driver->tty_drivers, &tty_drivers);
 	
-	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
+	if ( !(driver->flags & TTY_DRIVER_DYNAMIC_DEV) ) {
 		for(i = 0; i < driver->num; i++)
 		    tty_register_device(driver, i, NULL);
 	}
@@ -2860,7 +2860,7 @@
 			driver->termios_locked[i] = NULL;
 			kfree(tp);
 		}
-		if (!(driver->flags & TTY_DRIVER_NO_DEVFS))
+		if (!(driver->flags & TTY_DRIVER_DYNAMIC_DEV))
 			tty_unregister_device(driver, i);
 	}
 	p = driver->ttys;
--- gregkh-2.6.orig/include/linux/tty_driver.h	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/include/linux/tty_driver.h	2005-06-10 23:37:26.000000000 -0700
@@ -241,8 +241,15 @@
  * 	is also a promise, if the above case is true, not to signal
  * 	overruns, either.)
  *
- * TTY_DRIVER_NO_DEVFS --- if set, do not create devfs entries. This
- *	is only used by tty_register_driver().
+ * TTY_DRIVER_DYNAMIC_DEV --- if set, the individual tty devices need
+ *	to be registered with a call to tty_register_driver() when the
+ *	device is found in the system and unregistered with a call to
+ *	tty_unregister_device() so the devices will be show up
+ *	properly in sysfs.  If not set, driver->num entries will be
+ *	created by the tty core in sysfs when tty_register_driver() is
+ *	called.  This is to be used by drivers that have tty devices
+ *	that can appear and disappear while the main tty driver is
+ *	registered with the tty core.
  *
  * TTY_DRIVER_DEVPTS_MEM -- don't use the standard arrays, instead
  *	use dynamic memory keyed through the devpts filesystem.  This
@@ -251,7 +258,7 @@
 #define TTY_DRIVER_INSTALLED		0x0001
 #define TTY_DRIVER_RESET_TERMIOS	0x0002
 #define TTY_DRIVER_REAL_RAW		0x0004
-#define TTY_DRIVER_NO_DEVFS		0x0008
+#define TTY_DRIVER_DYNAMIC_DEV		0x0008
 #define TTY_DRIVER_DEVPTS_MEM		0x0010
 
 /* tty driver types */
--- gregkh-2.6.orig/drivers/char/ip2main.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/char/ip2main.c	2005-06-10 23:37:26.000000000 -0700
@@ -679,7 +679,7 @@
 	ip2_tty_driver->subtype              = SERIAL_TYPE_NORMAL;
 	ip2_tty_driver->init_termios         = tty_std_termios;
 	ip2_tty_driver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
-	ip2_tty_driver->flags                = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	ip2_tty_driver->flags                = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(ip2_tty_driver, &ip2_ops);
 
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, 3, 0 );
--- gregkh-2.6.orig/drivers/char/pty.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/char/pty.c	2005-06-10 23:37:26.000000000 -0700
@@ -369,7 +369,7 @@
 	ptm_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
 	ptm_driver->init_termios.c_lflag = 0;
 	ptm_driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW |
-		TTY_DRIVER_NO_DEVFS | TTY_DRIVER_DEVPTS_MEM;
+		TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_DEVPTS_MEM;
 	ptm_driver->other = pts_driver;
 	tty_set_operations(ptm_driver, &pty_ops);
 	ptm_driver->ioctl = pty_unix98_ioctl;
@@ -384,7 +384,7 @@
 	pts_driver->init_termios = tty_std_termios;
 	pts_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
 	pts_driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW |
-		TTY_DRIVER_NO_DEVFS | TTY_DRIVER_DEVPTS_MEM;
+		TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_DEVPTS_MEM;
 	pts_driver->other = ptm_driver;
 	tty_set_operations(pts_driver, &pty_ops);
 	
--- gregkh-2.6.orig/drivers/char/rocket.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/char/rocket.c	2005-06-10 23:37:26.000000000 -0700
@@ -2366,7 +2366,7 @@
 	 */
 
 	rocket_driver->owner = THIS_MODULE;
-	rocket_driver->flags = TTY_DRIVER_NO_DEVFS;
+	rocket_driver->flags = TTY_DRIVER_DYNAMIC_DEV;
 	rocket_driver->name = "ttyR";
 	rocket_driver->driver_name = "Comtrol RocketPort";
 	rocket_driver->major = TTY_ROCKET_MAJOR;
@@ -2377,7 +2377,7 @@
 	rocket_driver->init_termios.c_cflag =
 	    B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 #ifdef ROCKET_SOFT_FLOW
-	rocket_driver->flags |= TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	rocket_driver->flags |= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 #endif
 	tty_set_operations(rocket_driver, &rocket_ops);
 
--- gregkh-2.6.orig/drivers/serial/serial_core.c	2005-06-10 23:37:22.000000000 -0700
+++ gregkh-2.6/drivers/serial/serial_core.c	2005-06-10 23:37:33.000000000 -0700
@@ -2089,7 +2089,7 @@
 	normal->subtype		= SERIAL_TYPE_NORMAL;
 	normal->init_termios	= tty_std_termios;
 	normal->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	normal->flags		= TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	normal->flags		= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	normal->driver_state    = drv;
 	tty_set_operations(normal, &uart_ops);
 
--- gregkh-2.6.orig/arch/ppc/4xx_io/serial_sicc.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/arch/ppc/4xx_io/serial_sicc.c	2005-06-10 23:37:26.000000000 -0700
@@ -1764,7 +1764,7 @@
     siccnormal_driver->subtype = SERIAL_TYPE_NORMAL;
     siccnormal_driver->init_termios = tty_std_termios;
     siccnormal_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-    siccnormal_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+    siccnormal_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
     tty_set_operations(siccnormal_driver, &sicc_ops);
 
     if (tty_register_driver(siccnormal_driver))
--- gregkh-2.6.orig/drivers/isdn/i4l/isdn_tty.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/isdn/i4l/isdn_tty.c	2005-06-10 23:37:26.000000000 -0700
@@ -1907,7 +1907,7 @@
 	m->tty_modem->subtype = SERIAL_TYPE_NORMAL;
 	m->tty_modem->init_termios = tty_std_termios;
 	m->tty_modem->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	m->tty_modem->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	m->tty_modem->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	m->tty_modem->driver_name = "isdn_tty";
 	tty_set_operations(m->tty_modem, &modem_ops);
 	retval = tty_register_driver(m->tty_modem);
--- gregkh-2.6.orig/drivers/serial/crisv10.c	2005-06-10 23:28:56.000000000 -0700
+++ gregkh-2.6/drivers/serial/crisv10.c	2005-06-10 23:37:26.000000000 -0700
@@ -4917,7 +4917,7 @@
 	driver->init_termios = tty_std_termios;
 	driver->init_termios.c_cflag =
 		B115200 | CS8 | CREAD | HUPCL | CLOCAL; /* is normally B9600 default... */
-	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	driver->termios = serial_termios;
 	driver->termios_locked = serial_termios_locked;
 
--- gregkh-2.6.orig/drivers/tc/zs.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/tc/zs.c	2005-06-10 23:37:26.000000000 -0700
@@ -1793,7 +1793,7 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	serial_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	serial_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(serial_driver, &serial_ops);
 
 	if (tty_register_driver(serial_driver))
--- gregkh-2.6.orig/drivers/usb/class/bluetty.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/usb/class/bluetty.c	2005-06-10 23:37:26.000000000 -0700
@@ -1235,7 +1235,7 @@
 	bluetooth_tty_driver->minor_start = 0;
 	bluetooth_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	bluetooth_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	bluetooth_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	bluetooth_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	bluetooth_tty_driver->init_termios = tty_std_termios;
 	bluetooth_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty_set_operations(bluetooth_tty_driver, &bluetooth_ops);
--- gregkh-2.6.orig/drivers/usb/class/cdc-acm.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/usb/class/cdc-acm.c	2005-06-10 23:37:26.000000000 -0700
@@ -1044,7 +1044,7 @@
 	acm_tty_driver->minor_start = 0,
 	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
 	acm_tty_driver->subtype = SERIAL_TYPE_NORMAL,
-	acm_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS,
+	acm_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	acm_tty_driver->init_termios = tty_std_termios;
 	acm_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty_set_operations(acm_tty_driver, &acm_ops);
--- gregkh-2.6.orig/drivers/usb/gadget/serial.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/usb/gadget/serial.c	2005-06-10 23:37:26.000000000 -0700
@@ -667,7 +667,7 @@
 	gs_tty_driver->minor_start = GS_MINOR_START;
 	gs_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	gs_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gs_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	gs_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	gs_tty_driver->init_termios = tty_std_termios;
 	gs_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty_set_operations(gs_tty_driver, &gs_tty_ops);
--- gregkh-2.6.orig/drivers/usb/serial/usb-serial.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/usb/serial/usb-serial.c	2005-06-10 23:37:26.000000000 -0700
@@ -1305,7 +1305,7 @@
 	usb_serial_tty_driver->minor_start = 0;
 	usb_serial_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	usb_serial_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	usb_serial_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	usb_serial_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	usb_serial_tty_driver->init_termios = tty_std_termios;
 	usb_serial_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty_set_operations(usb_serial_tty_driver, &serial_ops);
--- gregkh-2.6.orig/net/bluetooth/rfcomm/tty.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/net/bluetooth/rfcomm/tty.c	2005-06-10 23:37:26.000000000 -0700
@@ -906,7 +906,7 @@
 	rfcomm_tty_driver->minor_start	= RFCOMM_TTY_MINOR;
 	rfcomm_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
 	rfcomm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
-	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	rfcomm_tty_driver->init_termios	= tty_std_termios;
 	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
--- gregkh-2.6.orig/drivers/s390/char/tty3270.c	2005-06-10 23:37:25.000000000 -0700
+++ gregkh-2.6/drivers/s390/char/tty3270.c	2005-06-10 23:37:26.000000000 -0700
@@ -1796,7 +1796,7 @@
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->subtype = SYSTEM_TYPE_TTY;
 	driver->init_termios = tty_std_termios;
-	driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_NO_DEVFS;
+	driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(driver, &tty3270_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {

