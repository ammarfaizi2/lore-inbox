Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTDYAWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDXXev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:34:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:64689 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264473AbTDXXd6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:33:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1051228053892@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280533216@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.12, 2003/04/23 17:38:41-07:00, greg@kroah.com

[PATCH] USB: ftdi_sio: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/ftdi_sio.c |  193 ++++++++++++++++++------------------------
 1 files changed, 87 insertions(+), 106 deletions(-)


diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	Thu Apr 24 16:23:00 2003
+++ b/drivers/usb/serial/ftdi_sio.c	Thu Apr 24 16:23:00 2003
@@ -175,6 +175,8 @@
 static void ftdi_sio_write_bulk_callback (struct urb *urb, struct pt_regs *regs);
 static void ftdi_sio_read_bulk_callback	(struct urb *urb, struct pt_regs *regs);
 static void ftdi_sio_set_termios	(struct usb_serial_port *port, struct termios * old);
+static int  ftdi_sio_tiocmget		(struct usb_serial_port *port, struct file *file);
+static int  ftdi_sio_tiocmset		(struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear);
 static int  ftdi_sio_ioctl		(struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg);
 static void ftdi_sio_break_ctl		(struct usb_serial_port *port, int break_state );
 
@@ -198,6 +200,8 @@
 	.ioctl =		ftdi_sio_ioctl,
 	.set_termios =		ftdi_sio_set_termios,
 	.break_ctl =		ftdi_sio_break_ctl,
+	.tiocmget =		ftdi_sio_tiocmget,
+	.tiocmset =		ftdi_sio_tiocmset,
 	.attach =		ftdi_sio_startup,
         .shutdown =             ftdi_sio_shutdown,
 };
@@ -219,6 +223,8 @@
 	.ioctl =		ftdi_sio_ioctl,
 	.set_termios =		ftdi_sio_set_termios,
 	.break_ctl =		ftdi_sio_break_ctl,
+	.tiocmget =		ftdi_sio_tiocmget,
+	.tiocmset =		ftdi_sio_tiocmset,
 	.attach =		ftdi_8U232AM_startup,
         .shutdown =             ftdi_sio_shutdown,
 };
@@ -823,125 +829,100 @@
 	return;
 } /* ftdi_sio_set_termios */
 
-static int ftdi_sio_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+static int ftdi_sio_tiocmget (struct usb_serial_port *port, struct file *file)
 {
 	struct usb_serial *serial = port->serial;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	__u16 urb_value=0; /* Will hold the new flags */
-	char buf[2];
-	int  ret, mask;
+	char *buf = NULL;
+	int ret = -EINVAL;
+	int size;
 	
-	dbg("%s cmd 0x%04x", __FUNCTION__, cmd);
+	dbg("%s", __FUNCTION__);
 
-	/* Based on code from acm.c and others */
-	switch (cmd) {
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		goto exit;
 
-	case TIOCMGET:
-		dbg("%s TIOCMGET", __FUNCTION__);
-		if (priv->ftdi_type == sio){
-			/* Request the status from the device */
-			if ((ret = usb_control_msg(serial->dev, 
-						   usb_rcvctrlpipe(serial->dev, 0),
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST, 
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
-						   0, 0, 
-						   buf, 1, WDR_TIMEOUT)) < 0 ) {
-				err("%s Could not get modem status of device - err: %d", __FUNCTION__,
-				    ret);
-				return(ret);
-			}
-		} else {
-			/* the 8U232AM returns a two byte value (the sio is a 1 byte value) - in the same 
-			   format as the data returned from the in point */
-			if ((ret = usb_control_msg(serial->dev, 
-						   usb_rcvctrlpipe(serial->dev, 0),
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST, 
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
-						   0, 0, 
-						   buf, 2, WDR_TIMEOUT)) < 0 ) {
-				err("%s Could not get modem status of device - err: %d", __FUNCTION__,
-				    ret);
-				return(ret);
-			}
-		}
+	if (priv->ftdi_type == sio) {
+		size = 1;
+	} else {
+		/* the 8U232AM returns a two byte value (the sio is a 1 byte value) - in the same 
+		   format as the data returned from the in point */
+		size = 2;
+	}
+	ret = usb_control_msg(serial->dev,
+			      usb_rcvctrlpipe(serial->dev, 0),
+			      FTDI_SIO_GET_MODEM_STATUS_REQUEST,
+			      FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
+			      0, 0, buf, size, WDR_TIMEOUT);
+	if (ret < 0) {
+		err("%s Could not get modem status of device - err: %d",
+		    __FUNCTION__, ret);
+		goto exit;
+	}
+
+	ret = (buf[0] & FTDI_SIO_DSR_MASK ? TIOCM_DSR : 0) |
+		(buf[0] & FTDI_SIO_CTS_MASK ? TIOCM_CTS : 0) |
+		(buf[0]  & FTDI_SIO_RI_MASK  ? TIOCM_RI  : 0) |
+		(buf[0]  & FTDI_SIO_RLSD_MASK ? TIOCM_CD  : 0);
+
+exit:
+	kfree(buf);
+	return ret;
+}
 
-		return put_user((buf[0] & FTDI_SIO_DSR_MASK ? TIOCM_DSR : 0) |
-				(buf[0] & FTDI_SIO_CTS_MASK ? TIOCM_CTS : 0) |
-				(buf[0]  & FTDI_SIO_RI_MASK  ? TIOCM_RI  : 0) |
-				(buf[0]  & FTDI_SIO_RLSD_MASK ? TIOCM_CD  : 0),
-				(unsigned long *) arg);
-		break;
-
-	case TIOCMSET: /* Turns on and off the lines as specified by the mask */
-		dbg("%s TIOCMSET", __FUNCTION__);
-		if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-		urb_value = ((mask & TIOCM_DTR) ? HIGH : LOW);
-		if (set_dtr(serial->dev, usb_sndctrlpipe(serial->dev, 0),urb_value) < 0){
-			err("Error from DTR set urb (TIOCMSET)");
-		}
-		urb_value = ((mask & TIOCM_RTS) ? HIGH : LOW);
-		if (set_rts(serial->dev, usb_sndctrlpipe(serial->dev, 0),urb_value) < 0){
-			err("Error from RTS set urb (TIOCMSET)");
-		}	
-		break;
-					
-	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
-		dbg("%s TIOCMBIS", __FUNCTION__);
- 	        if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-  	        if (mask & TIOCM_DTR){
-			if ((ret = set_dtr(serial->dev, 
-					   usb_sndctrlpipe(serial->dev, 0),
-					   HIGH)) < 0) {
-				err("Urb to set DTR failed");
-				return(ret);
-			}
-		}
-		if (mask & TIOCM_RTS) {
-			if ((ret = set_rts(serial->dev, 
-					   usb_sndctrlpipe(serial->dev, 0),
-					   HIGH)) < 0){
-				err("Urb to set RTS failed");
-				return(ret);
-			}
-		}
-					break;
+static int ftdi_sio_tiocmset (struct usb_serial_port *port, struct file *file,
+			      unsigned int set, unsigned int clear)
+{
+	struct usb_serial *serial = port->serial;
+	int ret = 0;
+	
+	dbg("%s", __FUNCTION__);
 
-	case TIOCMBIC: /* turns off (Clears) the lines as specified by the mask */
-		dbg("%s TIOCMBIC", __FUNCTION__);
- 	        if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-  	        if (mask & TIOCM_DTR){
-			if ((ret = set_dtr(serial->dev, 
-					   usb_sndctrlpipe(serial->dev, 0),
-					   LOW)) < 0){
-				err("Urb to unset DTR failed");
-				return(ret);
-			}
-		}	
-		if (mask & TIOCM_RTS) {
-			if ((ret = set_rts(serial->dev, 
-					   usb_sndctrlpipe(serial->dev, 0),
-					   LOW)) < 0){
-				err("Urb to unset RTS failed");
-				return(ret);
-			}
+	if (set & TIOCM_RTS)
+		if ((ret = set_rts(serial->dev, 
+				   usb_sndctrlpipe(serial->dev, 0),
+				   HIGH)) < 0) {
+			err("Urb to set RTS failed");
+			goto exit;
+		}
+
+	if (set & TIOCM_DTR)
+		if ((ret = set_dtr(serial->dev, 
+				   usb_sndctrlpipe(serial->dev, 0),
+				   HIGH)) < 0) {
+			err("Urb to set DTR failed");
+			goto exit;
+		}
+
+	if (clear & TIOCM_RTS)
+		if ((ret = set_rts(serial->dev, 
+				   usb_sndctrlpipe(serial->dev, 0),
+				   LOW)) < 0) {
+			err("Urb to unset RTS failed");
+			goto exit;
+		}
+
+	if (clear & TIOCM_DTR)
+		if ((ret = set_dtr(serial->dev, 
+				   usb_sndctrlpipe(serial->dev, 0),
+				   LOW)) < 0) {
+			err("Urb to unset DTR failed");
+			goto exit;
 		}
-		break;
 
-		/*
-		 * I had originally implemented TCSET{A,S}{,F,W} and
-		 * TCGET{A,S} here separately, however when testing I
-		 * found that the higher layers actually do the termios
-		 * conversions themselves and pass the call onto
-		 * ftdi_sio_set_termios. 
-		 *
-		 */
+exit:
+	return ret;
+}
 
+static int ftdi_sio_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+{
+	dbg("%s cmd 0x%04x", __FUNCTION__, cmd);
+
+	switch (cmd) {
 	default:
 	  /* This is not an error - turns out the higher layers will do 
-	   *  some ioctls itself (see comment above)
+	   *  some ioctls itself
  	   */
 		dbg("%s arg not supported - it was 0x%04x", __FUNCTION__,cmd);
 		return(-ENOIOCTLCMD);

