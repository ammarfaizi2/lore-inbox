Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTDYAWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDXXeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:34:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16617 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264446AbTDXXd6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:33:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280533869@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280532458@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.15, 2003/04/23 17:48:10-07:00, greg@kroah.com

[PATCH] USB: kobil_sct: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/kobil_sct.c |  200 +++++++++++++++++++++++------------------
 1 files changed, 116 insertions(+), 84 deletions(-)


diff -Nru a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
--- a/drivers/usb/serial/kobil_sct.c	Thu Apr 24 16:21:37 2003
+++ b/drivers/usb/serial/kobil_sct.c	Thu Apr 24 16:21:37 2003
@@ -81,6 +81,9 @@
 static int  kobil_write_room(struct usb_serial_port *port);
 static int  kobil_ioctl(struct usb_serial_port *port, struct file *file,
 			unsigned int cmd, unsigned long arg);
+static int  kobil_tiocmget(struct usb_serial_port *port, struct file *file);
+static int  kobil_tiocmset(struct usb_serial_port *port, struct file *file,
+			   unsigned int set, unsigned int clear);
 static void kobil_read_int_callback( struct urb *urb, struct pt_regs *regs );
 static void kobil_write_callback( struct urb *purb, struct pt_regs *regs );
 
@@ -106,6 +109,8 @@
 	.attach =		kobil_startup,
 	.shutdown =		kobil_shutdown,
 	.ioctl =		kobil_ioctl,
+	.tiocmget =		kobil_tiocmget,
+	.tiocmset =		kobil_tiocmset,
 	.open =			kobil_open,
 	.close =		kobil_close,
 	.write =		kobil_write,
@@ -490,11 +495,120 @@
 }
 
 
+static int kobil_tiocmget(struct usb_serial_port *port, struct file *file)
+{
+	struct kobil_private * priv;
+	int result;
+	unsigned char *transfer_buffer;
+	int transfer_buffer_length = 8;
+
+	priv = usb_get_serial_port_data(port);
+	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID) {
+		// This device doesn't support ioctl calls
+		return -EINVAL;
+	}
+
+	// allocate memory for transfer buffer
+	transfer_buffer = (unsigned char *) kmalloc(transfer_buffer_length, GFP_KERNEL);  
+	if (!transfer_buffer) {
+		return -ENOMEM;
+	}
+	memset(transfer_buffer, 0, transfer_buffer_length);
+
+	result = usb_control_msg( port->serial->dev, 
+				  usb_rcvctrlpipe(port->serial->dev, 0 ), 
+				  SUSBCRequest_GetStatusLineState,
+				  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_IN,
+				  0,
+				  0,
+				  transfer_buffer,
+				  transfer_buffer_length,
+				  KOBIL_TIMEOUT);
+
+	dbg("%s - port %d Send get_status_line_state URB returns: %i. Statusline: %02x", 
+	    __FUNCTION__, port->number, result, transfer_buffer[0]);
+
+	if ((transfer_buffer[0] & SUSBCR_GSL_DSR) != 0) {
+		priv->line_state |= TIOCM_DSR;
+	} else {
+		priv->line_state &= ~TIOCM_DSR; 
+	}
+
+	kfree(transfer_buffer);
+	return priv->line_state;
+}
+
+static int  kobil_tiocmset(struct usb_serial_port *port, struct file *file,
+			   unsigned int set, unsigned int clear)
+{
+	struct kobil_private * priv;
+	int result;
+	int dtr = 0;
+	int rts = 0;
+	unsigned char *transfer_buffer;
+	int transfer_buffer_length = 8;
+
+	priv = usb_get_serial_port_data(port);
+	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID) {
+		// This device doesn't support ioctl calls
+		return -EINVAL;
+	}
+
+	// allocate memory for transfer buffer
+	transfer_buffer = (unsigned char *) kmalloc(transfer_buffer_length, GFP_KERNEL);
+	if (! transfer_buffer) {
+		return -ENOMEM;
+	}
+	memset(transfer_buffer, 0, transfer_buffer_length);
+
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+
+	if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
+		if (dtr != 0)
+			dbg("%s - port %d Setting DTR", __FUNCTION__, port->number);
+		else
+			dbg("%s - port %d Clearing DTR", __FUNCTION__, port->number);
+		result = usb_control_msg( port->serial->dev, 
+					  usb_rcvctrlpipe(port->serial->dev, 0 ), 
+					  SUSBCRequest_SetStatusLinesOrQueues,
+					  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+					  ((dtr != 0) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
+					  0,
+					  transfer_buffer,
+					  0,
+					  KOBIL_TIMEOUT);
+	} else {
+		if (rts != 0)
+			dbg("%s - port %d Setting RTS", __FUNCTION__, port->number);
+		else
+			dbg("%s - port %d Clearing RTS", __FUNCTION__, port->number);
+		result = usb_control_msg( port->serial->dev, 
+					  usb_rcvctrlpipe(port->serial->dev, 0 ), 
+					  SUSBCRequest_SetStatusLinesOrQueues,
+					  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+					  ((rts != 0) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
+					  0,
+					  transfer_buffer,
+					  0,
+					  KOBIL_TIMEOUT);
+	}
+	dbg("%s - port %d Send set_status_line URB returns: %i", __FUNCTION__, port->number, result);
+	kfree(transfer_buffer);
+	return (result < 0) ? result : 0;
+}
+
+
 static int  kobil_ioctl(struct usb_serial_port *port, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
 	struct kobil_private * priv;
-	int mask;
 	int result;
 	unsigned short urb_val = 0;
 	unsigned char *transfer_buffer;
@@ -605,90 +719,8 @@
 		kfree(transfer_buffer);
 		return ((result < 0) ? -EFAULT : 0);
 
-	case TIOCMGET: // 0x5415
-		// allocate memory for transfer buffer
-		transfer_buffer = (unsigned char *) kmalloc(transfer_buffer_length, GFP_KERNEL);  
-		if (! transfer_buffer) {
-			return -ENOBUFS;
-		} else {
-			memset(transfer_buffer, 0, transfer_buffer_length);
-		}
-
-		result = usb_control_msg( port->serial->dev, 
-					  usb_rcvctrlpipe(port->serial->dev, 0 ), 
-					  SUSBCRequest_GetStatusLineState,
-					  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_IN,
-					  0,
-					  0,
-					  transfer_buffer,
-					  transfer_buffer_length,
-					  KOBIL_TIMEOUT
-			);
-
-		dbg("%s - port %d Send get_status_line_state (TIOCMGET) URB returns: %i. Statusline: %02x", 
-		    __FUNCTION__, port->number, result, transfer_buffer[0]);
-
-		if ((transfer_buffer[0] & SUSBCR_GSL_DSR) != 0) {
-			priv->line_state |= TIOCM_DSR;
-		} else {
-			priv->line_state &= ~TIOCM_DSR; 
-		}
-
-		kfree(transfer_buffer);
-		return put_user(priv->line_state, (unsigned long *) arg);
-
-	case TIOCMSET: // 0x5418
-		if (get_user(mask, (unsigned long *) arg)){
-			return -EFAULT;
-		}
-		// allocate memory for transfer buffer
-		transfer_buffer = (unsigned char *) kmalloc(transfer_buffer_length, GFP_KERNEL);
-		if (! transfer_buffer) {
-			return -ENOBUFS;
-		} else {
-			memset(transfer_buffer, 0, transfer_buffer_length);
-		}
-
-		if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
-			if ((mask & TIOCM_DTR) != 0){
-				dbg("%s - port %d Setting DTR", __FUNCTION__, port->number);
-			} else {
-				dbg("%s - port %d Clearing DTR", __FUNCTION__, port->number);
-			} 
-			result = usb_control_msg( port->serial->dev, 
-						  usb_rcvctrlpipe(port->serial->dev, 0 ), 
-						  SUSBCRequest_SetStatusLinesOrQueues,
-						  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-						  ( ((mask & TIOCM_DTR) != 0) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
-						  0,
-						  transfer_buffer,
-						  0,
-						  KOBIL_TIMEOUT
-				);
-			
-		} else {
-			if ((mask & TIOCM_RTS) != 0){
-				dbg("%s - port %d Setting RTS", __FUNCTION__, port->number);
-			} else {
-				dbg("%s - port %d Clearing RTS", __FUNCTION__, port->number);
-			}
-			result = usb_control_msg( port->serial->dev, 
-						  usb_rcvctrlpipe(port->serial->dev, 0 ), 
-						  SUSBCRequest_SetStatusLinesOrQueues,
-						  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-						  (((mask & TIOCM_RTS) != 0) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
-						  0,
-						  transfer_buffer,
-						  0,
-						  KOBIL_TIMEOUT
-				);
-		}
-		dbg("%s - port %d Send set_status_line (TIOCMSET) URB returns: %i", __FUNCTION__, port->number, result);
-
-		kfree(transfer_buffer);
-		return ((result < 0) ? -EFAULT : 0);
 	}
-	return 0;
+	return -ENOIOCTLCMD;
 }
 
 

