Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTDXXlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTDXXi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:38:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35490 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264503AbTDXXeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280533526@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280531918@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.17, 2003/04/23 17:48:48-07:00, greg@kroah.com

[PATCH] USB: pl2303: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/pl2303.c |   63 +++++++++++++-------------------------------
 1 files changed, 19 insertions(+), 44 deletions(-)


diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Thu Apr 24 16:20:41 2003
+++ b/drivers/usb/serial/pl2303.c	Thu Apr 24 16:20:41 2003
@@ -124,6 +124,9 @@
 static int pl2303_write (struct usb_serial_port *port, int from_user,
 			 const unsigned char *buf, int count);
 static void pl2303_break_ctl(struct usb_serial_port *port,int break_state);
+static int pl2303_tiocmget (struct usb_serial_port *port, struct file *file);
+static int pl2303_tiocmset (struct usb_serial_port *port, struct file *file,
+			    unsigned int set, unsigned int clear);
 static int pl2303_startup (struct usb_serial *serial);
 static void pl2303_shutdown (struct usb_serial *serial);
 
@@ -143,6 +146,8 @@
 	.ioctl =		pl2303_ioctl,
 	.break_ctl =		pl2303_break_ctl,
 	.set_termios =		pl2303_set_termios,
+	.tiocmget =		pl2303_tiocmget,
+	.tiocmset =		pl2303_tiocmset,
 	.read_bulk_callback =	pl2303_read_bulk_callback,
 	.read_int_callback =	pl2303_read_int_callback,
 	.write_bulk_callback =	pl2303_write_bulk_callback,
@@ -490,51 +495,35 @@
 
 }
 
-static int set_modem_info (struct usb_serial_port *port, unsigned int cmd, unsigned int *value)
+static int pl2303_tiocmset (struct usb_serial_port *port, struct file *file,
+			    unsigned int set, unsigned int clear)
 {
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
-	unsigned int arg;
 	u8 control;
 
-	if (copy_from_user(&arg, value, sizeof(int)))
-		return -EFAULT;
-
 	spin_lock (&priv->lock);
-	switch (cmd) {
-		case TIOCMBIS:
-			if (arg & TIOCM_RTS)
-				priv->line_control |= CONTROL_RTS;
-			if (arg & TIOCM_DTR)
-				priv->line_control |= CONTROL_DTR;
-			break;
-
-		case TIOCMBIC:
-			if (arg & TIOCM_RTS)
-				priv->line_control &= ~CONTROL_RTS;
-			if (arg & TIOCM_DTR)
-				priv->line_control &= ~CONTROL_DTR;
-			break;
-
-		case TIOCMSET:
-			/* turn off RTS and DTR and then only turn
-			   on what was asked to */
-			priv->line_control &= ~(CONTROL_RTS | CONTROL_DTR);
-			priv->line_control |= ((arg & TIOCM_RTS) ? CONTROL_RTS : 0);
-			priv->line_control |= ((arg & TIOCM_DTR) ? CONTROL_DTR : 0);
-			break;
-	}
+	if (set & TIOCM_RTS)
+		priv->line_control |= CONTROL_RTS;
+	if (set & TIOCM_DTR)
+		priv->line_control |= CONTROL_DTR;
+	if (clear & TIOCM_RTS)
+		priv->line_control &= ~CONTROL_RTS;
+	if (clear & TIOCM_DTR)
+		priv->line_control &= ~CONTROL_DTR;
 	control = priv->line_control;
 	spin_unlock (&priv->lock);
 
 	return set_control_lines (port->serial->dev, control);
 }
 
-static int get_modem_info (struct usb_serial_port *port, unsigned int *value)
+static int pl2303_tiocmget (struct usb_serial_port *port, struct file *file)
 {
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
 	unsigned int mcr;
 	unsigned int result;
 
+	dbg("%s (%d)", __FUNCTION__, port->number);
+
 	spin_lock (&priv->lock);
 	mcr = priv->line_control;
 	spin_unlock (&priv->lock);
@@ -544,9 +533,7 @@
 
 	dbg("%s - result = %x", __FUNCTION__, result);
 
-	if (copy_to_user(value, &result, sizeof(int)))
-		return -EFAULT;
-	return 0;
+	return result;
 }
 
 static int pl2303_ioctl (struct usb_serial_port *port, struct file *file, unsigned int cmd, unsigned long arg)
@@ -554,17 +541,6 @@
 	dbg("%s (%d) cmd = 0x%04x", __FUNCTION__, port->number, cmd);
 
 	switch (cmd) {
-		
-		case TIOCMGET:
-			dbg("%s (%d) TIOCMGET", __FUNCTION__, port->number);
-			return get_modem_info (port, (unsigned int *)arg);
-
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			dbg("%s (%d) TIOCMSET/TIOCMBIC/TIOCMSET", __FUNCTION__,  port->number);
-			return set_modem_info(port, cmd, (unsigned int *) arg);
-
 		default:
 			dbg("%s not supported = 0x%04x", __FUNCTION__, cmd);
 			break;
@@ -572,7 +548,6 @@
 
 	return -ENOIOCTLCMD;
 }
-
 
 static void pl2303_break_ctl (struct usb_serial_port *port, int break_state)
 {

