Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTDYASs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTDXXfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:33022 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264493AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1051228052666@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280521833@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.10, 2003/04/23 17:36:29-07:00, greg@kroah.com

[PATCH] USB: belkin_sa: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/belkin_sa.c |  110 +++++++++++++++++++++++------------------
 1 files changed, 63 insertions(+), 47 deletions(-)


diff -Nru a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
--- a/drivers/usb/serial/belkin_sa.c	Thu Apr 24 16:23:49 2003
+++ b/drivers/usb/serial/belkin_sa.c	Thu Apr 24 16:23:49 2003
@@ -101,6 +101,8 @@
 static void belkin_sa_set_termios	(struct usb_serial_port *port, struct termios * old);
 static int  belkin_sa_ioctl		(struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg);
 static void belkin_sa_break_ctl		(struct usb_serial_port *port, int break_state );
+static int  belkin_sa_tiocmget		(struct usb_serial_port *port, struct file *file);
+static int  belkin_sa_tiocmset		(struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear);
 
 
 static struct usb_device_id id_table_combined [] = {
@@ -138,6 +140,8 @@
 	.ioctl =		belkin_sa_ioctl,
 	.set_termios =		belkin_sa_set_termios,
 	.break_ctl =		belkin_sa_break_ctl,
+	.tiocmget =		belkin_sa_tiocmget,
+	.tiocmset =		belkin_sa_tiocmset,
 	.attach =		belkin_sa_startup,
 	.shutdown =		belkin_sa_shutdown,
 };
@@ -502,65 +506,77 @@
 }
 
 
-static int belkin_sa_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+static int belkin_sa_tiocmget (struct usb_serial_port *port, struct file *file)
+{
+	struct belkin_sa_private *priv = usb_get_serial_port_data(port);
+	unsigned long control_state;
+	unsigned long flags;
+	
+	dbg("%s", __FUNCTION__);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	control_state = priv->control_state;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return control_state;
+}
+
+
+static int belkin_sa_tiocmset (struct usb_serial_port *port, struct file *file,
+			       unsigned int set, unsigned int clear)
 {
 	struct usb_serial *serial = port->serial;
-	__u16 urb_value; /* Will hold the new flags */
 	struct belkin_sa_private *priv = usb_get_serial_port_data(port);
-	int ret = 0;
-	int mask;
 	unsigned long control_state;
 	unsigned long flags;
+	int retval;
+	int rts = 0;
+	int dtr = 0;
 	
+	dbg("%s", __FUNCTION__);
+
 	spin_lock_irqsave(&priv->lock, flags);
 	control_state = priv->control_state;
+
+	if (set & TIOCM_RTS) {
+		control_state |= TIOCM_RTS;
+		rts = 1;
+	}
+	if (set & TIOCM_DTR) {
+		control_state |= TIOCM_DTR;
+		dtr = 1;
+	}
+	if (clear & TIOCM_RTS) {
+		control_state &= ~TIOCM_RTS;
+		rts = 0;
+	}
+	if (clear & TIOCM_DTR) {
+		control_state &= ~TIOCM_DTR;
+		dtr = 0;
+	}
+
+	priv->control_state = control_state;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Based on code from acm.c and others */
-	switch (cmd) {
-	case TIOCMGET:
-		return put_user(control_state, (unsigned long *) arg);
-		break;
+	retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, rts);
+	if (retval < 0) {
+		err("Set RTS error %d", retval);
+		goto exit;
+	}
 
-	case TIOCMSET: /* Turns on and off the lines as specified by the mask */
-	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
-	case TIOCMBIC: /* turns off (Clears) the lines as specified by the mask */
-		if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-
-		if ((cmd == TIOCMSET) || (mask & TIOCM_RTS)) {
-			/* RTS needs set */
-			urb_value = ((cmd == TIOCMSET) && (mask & TIOCM_RTS)) || (cmd == TIOCMBIS) ? 1 : 0;
-			if (urb_value)
-				control_state |= TIOCM_RTS;
-			else
-				control_state &= ~TIOCM_RTS;
-
-			if ((ret = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, urb_value)) < 0) {
-				err("Set RTS error %d", ret);
-				goto cmerror;
-			}
-		}
+	retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, dtr);
+	if (retval < 0) {
+		err("Set DTR error %d", retval);
+		goto exit;
+	}
+exit:
+	return retval;
+}
 
-		if ((cmd == TIOCMSET) || (mask & TIOCM_DTR)) {
-			/* DTR needs set */
-			urb_value = ((cmd == TIOCMSET) && (mask & TIOCM_DTR)) || (cmd == TIOCMBIS) ? 1 : 0;
-			if (urb_value)
-				control_state |= TIOCM_DTR;
-			else
-				control_state &= ~TIOCM_DTR;
-			if ((ret = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, urb_value)) < 0) {
-				err("Set DTR error %d", ret);
-				goto cmerror;
-			}
-		}
-cmerror:
-		spin_lock_irqsave(&priv->lock, flags);
-		priv->control_state = control_state;
-		spin_unlock_irqrestore(&priv->lock, flags);
-		return ret;
-		break;
-					
+
+static int belkin_sa_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
 	case TIOCMIWAIT:
 		/* wait for any of the 4 modem inputs (DCD,RI,DSR,CTS)*/
 		/* TODO */

