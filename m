Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTDXXeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTDXXeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:34:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15081 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263717AbTDXXd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:33:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280531918@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280533869@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.16, 2003/04/23 17:48:28-07:00, greg@kroah.com

[PATCH] USB: mct_u232: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/mct_u232.c |   82 ++++++++++++++++++++++--------------------
 1 files changed, 43 insertions(+), 39 deletions(-)


diff -Nru a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
--- a/drivers/usb/serial/mct_u232.c	Thu Apr 24 16:21:10 2003
+++ b/drivers/usb/serial/mct_u232.c	Thu Apr 24 16:21:10 2003
@@ -125,7 +125,11 @@
 					  unsigned long arg);
 static void mct_u232_break_ctl	         (struct usb_serial_port *port,
 					  int break_state );
-
+static int  mct_u232_tiocmget		 (struct usb_serial_port *port,
+					  struct file *file);
+static int  mct_u232_tiocmset		 (struct usb_serial_port *port,
+					  struct file *file, unsigned int set,
+					  unsigned int clear);
 /*
  * All of the device info needed for the MCT USB-RS232 converter.
  */
@@ -165,6 +169,8 @@
 	.ioctl =	     mct_u232_ioctl,
 	.set_termios =	     mct_u232_set_termios,
 	.break_ctl =	     mct_u232_break_ctl,
+	.tiocmget =	     mct_u232_tiocmget,
+	.tiocmset =	     mct_u232_tiocmset,
 	.attach =	     mct_u232_startup,
 	.shutdown =	     mct_u232_shutdown,
 };
@@ -773,57 +779,55 @@
 } /* mct_u232_break_ctl */
 
 
-static int mct_u232_ioctl (struct usb_serial_port *port, struct file * file,
-			   unsigned int cmd, unsigned long arg)
+static int mct_u232_tiocmget (struct usb_serial_port *port, struct file *file)
+{
+	struct mct_u232_private *priv = usb_get_serial_port_data(port);
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
+static int mct_u232_tiocmset (struct usb_serial_port *port, struct file *file,
+			      unsigned int set, unsigned int clear)
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
-	int mask;
 	unsigned long control_state;
 	unsigned long flags;
 	
-	dbg("%scmd=0x%x", __FUNCTION__, cmd);
+	dbg("%s", __FUNCTION__);
 
 	spin_lock_irqsave(&priv->lock, flags);
 	control_state = priv->control_state;
+
+	if (set & TIOCM_RTS)
+		control_state |= TIOCM_RTS;
+	if (set & TIOCM_DTR)
+		control_state |= TIOCM_DTR;
+	if (clear & TIOCM_RTS)
+		control_state &= ~TIOCM_RTS;
+	if (clear & TIOCM_DTR)
+		control_state &= ~TIOCM_DTR;
+
+	priv->control_state = control_state;
 	spin_unlock_irqrestore(&priv->lock, flags);
+	return mct_u232_set_modem_ctrl(serial, control_state);
+}
+
+static int mct_u232_ioctl (struct usb_serial_port *port, struct file * file,
+			   unsigned int cmd, unsigned long arg)
+{
+	dbg("%scmd=0x%x", __FUNCTION__, cmd);
 
 	/* Based on code from acm.c and others */
 	switch (cmd) {
-	case TIOCMGET:
-		return put_user(control_state, (unsigned long *) arg);
-		break;
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
-				control_state |=  TIOCM_RTS;
-			else
-				control_state &= ~TIOCM_RTS;
-		}
-
-		if ((cmd == TIOCMSET) || (mask & TIOCM_DTR)) {
-			/* DTR needs set */
-			if( ((cmd == TIOCMSET) && (mask & TIOCM_DTR)) ||
-			    (cmd == TIOCMBIS) )
-				control_state |=  TIOCM_DTR;
-			else
-				control_state &= ~TIOCM_DTR;
-		}
-		mct_u232_set_modem_ctrl(serial, control_state);
-
-		spin_lock_irqsave(&priv->lock, flags);
-		priv->control_state = control_state;
-		spin_unlock_irqrestore(&priv->lock, flags);
-		break;
-					
 	case TIOCMIWAIT:
 		/* wait for any of the 4 modem inputs (DCD,RI,DSR,CTS)*/
 		/* TODO */

