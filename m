Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTDYAWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTDXXfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:03 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:65010 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264476AbTDXXd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:33:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280532458@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280533305@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.14, 2003/04/23 17:47:50-07:00, greg@kroah.com

[PATCH] USB: kl5kusb105: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/kl5kusb105.c |  112 +++++++++++++++++++++-------------------
 1 files changed, 59 insertions(+), 53 deletions(-)


diff -Nru a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
--- a/drivers/usb/serial/kl5kusb105.c	Thu Apr 24 16:22:03 2003
+++ b/drivers/usb/serial/kl5kusb105.c	Thu Apr 24 16:22:04 2003
@@ -105,6 +105,11 @@
 static void klsi_105_break_ctl	         (struct usb_serial_port *port,
 					  int break_state );
  */
+static int  klsi_105_tiocmget	         (struct usb_serial_port *port,
+					  struct file *file);
+static int  klsi_105_tiocmset	         (struct usb_serial_port *port,
+					  struct file *file, unsigned int set,
+					  unsigned int clear);
 
 /*
  * All of the device info needed for the KLSI converters.
@@ -143,6 +148,8 @@
 	.ioctl =	     klsi_105_ioctl,
 	.set_termios =	     klsi_105_set_termios,
 	/*.break_ctl =	     klsi_105_break_ctl,*/
+	.tiocmget =          klsi_105_tiocmget,
+	.tiocmset =          klsi_105_tiocmset,
 	.attach =	     klsi_105_startup,
 	.shutdown =	     klsi_105_shutdown,
 	.throttle =	     klsi_105_throttle,
@@ -879,68 +886,67 @@
 } /* mct_u232_break_ctl */
 #endif
 
-static int klsi_105_ioctl (struct usb_serial_port *port, struct file * file,
-			   unsigned int cmd, unsigned long arg)
+static int klsi_105_tiocmget (struct usb_serial_port *port, struct file *file)
 {
 	struct usb_serial *serial = port->serial;
 	struct klsi_105_private *priv = usb_get_serial_port_data(port);
-	int mask;
 	unsigned long flags;
+	int rc;
+	unsigned long line_state;
+	dbg("%s - request, just guessing", __FUNCTION__);
+
+	rc = klsi_105_get_line_state(serial, &line_state);
+	if (rc < 0) {
+		err("Reading line control failed (error = %d)", rc);
+		/* better return value? EAGAIN? */
+		return rc;
+	}
+
+	spin_lock_irqsave (&priv->lock, flags);
+	priv->line_state = line_state;
+	spin_unlock_irqrestore (&priv->lock, flags);
+	dbg("%s - read line state 0x%lx", __FUNCTION__, line_state);
+	return (int)line_state;
+}
+
+static int klsi_105_tiocmset (struct usb_serial_port *port, struct file *file,
+			      unsigned int set, unsigned int clear)
+{
+	int retval = -EINVAL;
+	
+	dbg("%s", __FUNCTION__);
+
+/* if this ever gets implemented, it should be done something like this:
+	struct usb_serial *serial = port->serial;
+	struct klsi_105_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
+	int control;
+
+	spin_lock_irqsave (&priv->lock, flags);
+	if (set & TIOCM_RTS)
+		priv->control_state |= TIOCM_RTS;
+	if (set & TIOCM_DTR)
+		priv->control_state |= TIOCM_DTR;
+	if (clear & TIOCM_RTS)
+		priv->control_state &= ~TIOCM_RTS;
+	if (clear & TIOCM_DTR)
+		priv->control_state &= ~TIOCM_DTR;
+	control = priv->control_state;
+	spin_unlock_irqrestore (&priv->lock, flags);
+	retval = mct_u232_set_modem_ctrl(serial, control);
+*/
+	return retval;
+}
+					
+static int klsi_105_ioctl (struct usb_serial_port *port, struct file * file,
+			   unsigned int cmd, unsigned long arg)
+{
+	struct klsi_105_private *priv = usb_get_serial_port_data(port);
 	
 	dbg("%scmd=0x%x", __FUNCTION__, cmd);
 
 	/* Based on code from acm.c and others */
 	switch (cmd) {
-	case TIOCMGET: {
-		int rc;
-		unsigned long line_state;
-		dbg("%s - TIOCMGET request, just guessing", __FUNCTION__);
-
-		rc = klsi_105_get_line_state(serial, &line_state);
-		if (rc < 0) {
-			err("Reading line control failed (error = %d)", rc);
-			/* better return value? EAGAIN? */
-			return -ENOIOCTLCMD;
-		}
-		spin_lock_irqsave (&priv->lock, flags);
-		priv->line_state = line_state;
-		spin_unlock_irqrestore (&priv->lock, flags);
-		dbg("%s - read line state 0x%lx", __FUNCTION__, line_state);
-		return put_user(line_state, (unsigned long *) arg); 
-	       };
-
-	case TIOCMSET: /* Turns on and off the lines as specified by the mask */
-	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
-	case TIOCMBIC: /* turns off (Clears) the lines as specified by the mask */
-		if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-
-		if ((cmd == TIOCMSET) || (mask & TIOCM_RTS)) {
-			/* RTS needs set */
-			if( ((cmd == TIOCMSET) && (mask & TIOCM_RTS)) ||
-			    (cmd == TIOCMBIS) )
-				dbg("%s - set RTS not handled", __FUNCTION__);
-				/* priv->control_state |=  TIOCM_RTS; */
-			else
-				dbg("%s - clear RTS not handled", __FUNCTION__);
-				/* priv->control_state &= ~TIOCM_RTS; */
-		}
-
-		if ((cmd == TIOCMSET) || (mask & TIOCM_DTR)) {
-			/* DTR needs set */
-			if( ((cmd == TIOCMSET) && (mask & TIOCM_DTR)) ||
-			    (cmd == TIOCMBIS) )
-				dbg("%s - set DTR not handled", __FUNCTION__);
-			/*	priv->control_state |=  TIOCM_DTR; */
-			else
-				dbg("%s - clear DTR not handled", __FUNCTION__);
-				/* priv->control_state &= ~TIOCM_DTR; */
-		}
-		/*
-		mct_u232_set_modem_ctrl(serial, priv->control_state);
-		*/
-		break;
-					
 	case TIOCMIWAIT:
 		/* wait for any of the 4 modem inputs (DCD,RI,DSR,CTS)*/
 		/* TODO */

