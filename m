Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTLHAx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTLHAx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:53:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:28319 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264902AbTLHAxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:53:22 -0500
Date: Sun, 7 Dec 2003 16:46:55 -0800
From: Greg KH <greg@kroah.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 - fork, dup, dup2 oddities
Message-ID: <20031208004655.GA23644@kroah.com>
References: <20031207210305.GE13201@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207210305.GE13201@mail.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 10:03:05PM +0100, Lukas Hejtmanek wrote:
> Hello,
> 
> I have 2.6.0-test11 kernel. I try to run pppd with pppd call gprs. In gprs
> I have device /dev/ttyUSB0. It fails. I've found that it happened ONLY
> if I use detach option. 

The ttyUSB* nodes right now have a bug that prevents more than one
open() to work properly.  Well actually, the bug is on the close()
part...

Anyway, can you try the patch I posted here yesterday?  A copy of it is
below.  It should fix this bug.  Please let me know either way.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Fri Dec  5 17:37:16 2003
+++ b/drivers/usb/serial/usb-serial.c	Fri Dec  5 17:37:16 2003
@@ -493,12 +493,15 @@
 	return retval;
 }
 
-static void __serial_close(struct usb_serial_port *port, struct file *filp)
+static void serial_close(struct tty_struct *tty, struct file * filp)
 {
-	if (!port->open_count) {
-		dbg ("%s - port not opened", __FUNCTION__);
+	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
+	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+
+	if (!serial)
 		return;
-	}
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	--port->open_count;
 	if (port->open_count <= 0) {
@@ -506,30 +509,18 @@
 		 * port is being closed by the last owner */
 		port->serial->type->close(port, filp);
 		port->open_count = 0;
+
+		if (port->tty) {
+			if (port->tty->driver_data)
+				port->tty->driver_data = NULL;
+			port->tty = NULL;
+		}
 	}
 
 	module_put(port->serial->type->owner);
 	kobject_put(&port->serial->kobj);
 }
 
-static void serial_close(struct tty_struct *tty, struct file * filp)
-{
-	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
-	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
-
-	if (!serial)
-		return;
-
-	dbg("%s - port %d", __FUNCTION__, port->number);
-
-	/* if disconnect beat us to the punch here, there's nothing to do */
-	if (tty && tty->driver_data) {
-		__serial_close(port, filp);
-		tty->driver_data = NULL;
-	}
-	port->tty = NULL;
-}
-
 static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
@@ -848,19 +839,6 @@
 	dbg ("%s - %s", __FUNCTION__, kobj->name);
 
 	serial = to_usb_serial(kobj);
-
-	/* fail all future close/read/write/ioctl/etc calls */
-	for (i = 0; i < serial->num_ports; ++i) {
-		port = serial->port[i];
-		if (port->tty != NULL) {
-			port->tty->driver_data = NULL;
-			while (port->open_count > 0) {
-				__serial_close(port, NULL);
-			}
-			port->tty = NULL;
-		}
-	}
-
 	serial_shutdown (serial);
 
 	/* return the minor range that this device had */
@@ -1242,7 +1220,7 @@
 	/* register all of the individual ports with the driver core */
 	for (i = 0; i < num_ports; ++i) {
 		port = serial->port[i];
-		port->dev.parent = &serial->dev->dev;
+		port->dev.parent = &interface->dev;
 		port->dev.driver = NULL;
 		port->dev.bus = &usb_serial_bus_type;
 		port->dev.release = &port_release;
