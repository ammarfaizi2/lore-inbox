Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTDXXlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTDXXgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:36:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15300 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264496AbTDXXeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280542604@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280533913@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.19, 2003/04/24 14:54:09-07:00, greg@kroah.com

[PATCH] USB: add error reporting functionality to the pl2303 driver.


 drivers/usb/serial/pl2303.c |   79 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 65 insertions(+), 14 deletions(-)


diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Thu Apr 24 16:19:46 2003
+++ b/drivers/usb/serial/pl2303.c	Thu Apr 24 16:19:46 2003
@@ -1,7 +1,8 @@
 /*
  * Prolific PL2303 USB to serial adaptor driver
  *
- * Copyright (C) 2001-2002 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001-2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2003 IBM Corp.
  *
  * Original driver for 2.2.x by anonymous
  *
@@ -111,6 +112,16 @@
 #define VENDOR_READ_REQUEST_TYPE	0xc0
 #define VENDOR_READ_REQUEST		0x01
 
+#define UART_STATE			0x08
+#define UART_DCD			0x01
+#define UART_DSR			0x02
+#define UART_BREAK_ERROR		0x04
+#define UART_RING			0x08
+#define UART_FRAME_ERROR		0x10
+#define UART_PARITY_ERROR		0x20
+#define UART_OVERRUN_ERROR		0x40
+#define UART_CTS			0x80
+
 /* function prototypes for a PL2303 serial converter */
 static int pl2303_open (struct usb_serial_port *port, struct file *filp);
 static void pl2303_close (struct usb_serial_port *port, struct file *filp);
@@ -158,6 +169,7 @@
 struct pl2303_private {
 	spinlock_t lock;
 	u8 line_control;
+	u8 line_status;
 	u8 termios_initialized;
 };
 
@@ -227,6 +239,7 @@
 {
 	struct usb_serial *serial = port->serial;
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 	unsigned int cflag;
 	unsigned char *buf;
 	int baud;
@@ -239,13 +252,13 @@
 		return;
 	}
 
-	spin_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, flags);
 	if (!priv->termios_initialized) {
 		*(port->tty->termios) = tty_std_termios;
 		port->tty->termios->c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 		priv->termios_initialized = 1;
 	}
-	spin_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	cflag = port->tty->termios->c_cflag;
 	/* check that they really want us to change something */
@@ -355,13 +368,13 @@
 	if (cflag && CBAUD) {
 		u8 control;
 
-		spin_lock (&priv->lock);
+		spin_lock_irqsave(&priv->lock, flags);
 		if ((cflag && CBAUD) == B0)
 			priv->line_control &= ~(CONTROL_DTR | CONTROL_RTS);
 		else
 			priv->line_control |= (CONTROL_DTR | CONTROL_RTS);
 		control = priv->line_control;
-		spin_unlock (&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, flags);
 		set_control_lines (serial->dev, control);
 	}
 	
@@ -450,6 +463,7 @@
 {
 	struct usb_serial *serial;
 	struct pl2303_private *priv;
+	unsigned long flags;
 	unsigned int c_cflag;
 	int result;
 
@@ -486,9 +500,9 @@
 		if (c_cflag & HUPCL) {
 			/* drop DTR and RTS */
 			priv = usb_get_serial_port_data(port);
-			spin_lock (&priv->lock);
+			spin_lock_irqsave(&priv->lock, flags);
 			priv->line_control = 0;
-			spin_unlock (&priv->lock);
+			spin_unlock_irqrestore (&priv->lock, flags);
 			set_control_lines (port->serial->dev, 0);
 		}
 	}
@@ -499,9 +513,10 @@
 			    unsigned int set, unsigned int clear)
 {
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 	u8 control;
 
-	spin_lock (&priv->lock);
+	spin_lock_irqsave (&priv->lock, flags);
 	if (set & TIOCM_RTS)
 		priv->line_control |= CONTROL_RTS;
 	if (set & TIOCM_DTR)
@@ -511,7 +526,7 @@
 	if (clear & TIOCM_DTR)
 		priv->line_control &= ~CONTROL_DTR;
 	control = priv->line_control;
-	spin_unlock (&priv->lock);
+	spin_unlock_irqrestore (&priv->lock, flags);
 
 	return set_control_lines (port->serial->dev, control);
 }
@@ -519,14 +534,15 @@
 static int pl2303_tiocmget (struct usb_serial_port *port, struct file *file)
 {
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 	unsigned int mcr;
 	unsigned int result;
 
 	dbg("%s (%d)", __FUNCTION__, port->number);
 
-	spin_lock (&priv->lock);
+	spin_lock_irqsave (&priv->lock, flags);
 	mcr = priv->line_control;
-	spin_unlock (&priv->lock);
+	spin_unlock_irqrestore (&priv->lock, flags);
 
 	result = ((mcr & CONTROL_DTR)		? TIOCM_DTR : 0)
 		  | ((mcr & CONTROL_RTS)	? TIOCM_RTS : 0);
@@ -588,9 +604,13 @@
 {
 	struct usb_serial_port *port = (struct usb_serial_port *) urb->context;
 	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
-	//unsigned char *data = urb->transfer_buffer;
+	struct pl2303_private *priv = usb_get_serial_port_data(port);
+	unsigned char *data = urb->transfer_buffer;
+	unsigned long flags;
 	int status;
 
+	dbg("%s (%d)", __FUNCTION__, port->number);
+
 	switch (urb->status) {
 	case 0:
 		/* success */
@@ -612,8 +632,14 @@
 
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, urb->transfer_buffer);
 
-	//FIXME need to update state of terminal lines variable
+	if (urb->actual_length > UART_STATE)
+		goto exit;
 
+	/* Save off the uart status for others to look at */
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->line_status = data[UART_STATE];
+	spin_unlock_irqrestore(&priv->lock, flags);
+		
 exit:
 	status = usb_submit_urb (urb, GFP_ATOMIC);
 	if (status)
@@ -626,10 +652,14 @@
 {
 	struct usb_serial_port *port = (struct usb_serial_port *) urb->context;
 	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+	struct pl2303_private *priv = usb_get_serial_port_data(port);
 	struct tty_struct *tty;
 	unsigned char *data = urb->transfer_buffer;
+	unsigned long flags;
 	int i;
 	int result;
+	u8 status;
+	char tty_flag;
 
 	if (port_paranoia_check (port, __FUNCTION__))
 		return;
@@ -663,13 +693,34 @@
 
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
+	/* get tty_flag from status */
+	tty_flag = TTY_NORMAL;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	status = priv->line_status;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	/* break takes precedence over parity, */
+	/* which takes precedence over framing errors */
+	if (status & UART_BREAK_ERROR )
+		tty_flag = TTY_BREAK;
+	else if (status & UART_PARITY_ERROR)
+		tty_flag = TTY_PARITY;
+	else if (status & UART_FRAME_ERROR)
+		tty_flag = TTY_FRAME;
+	dbg("%s - tty_flag = %d", __FUNCTION__, tty_flag);
+
 	tty = port->tty;
 	if (tty && urb->actual_length) {
+		/* overrun is special, not associated with a char */
+		if (status & UART_OVERRUN_ERROR)
+			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+
 		for (i = 0; i < urb->actual_length; ++i) {
 			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
 				tty_flip_buffer_push(tty);
 			}
-			tty_insert_flip_char (tty, data[i], 0);
+			tty_insert_flip_char (tty, data[i], tty_flag);
 		}
 		tty_flip_buffer_push (tty);
 	}

