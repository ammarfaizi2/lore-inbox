Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTLKBab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLKBaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:30:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:53967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264323AbTLKBaI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:08 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061482794@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <1071106147425@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:08 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1525, 2003/12/10 14:39:48-08:00, greg@kroah.com

[PATCH] USB: fix bug for multiple opens on ttyUSB devices.

This patch fixes the bug where running ppp over a ttyUSB device would fail.


 drivers/usb/serial/usb-serial.c |   48 ++++++++++------------------------------
 1 files changed, 13 insertions(+), 35 deletions(-)


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Wed Dec 10 16:46:53 2003
+++ b/drivers/usb/serial/usb-serial.c	Wed Dec 10 16:46:53 2003
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

