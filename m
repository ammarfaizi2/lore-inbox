Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVG3Aui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVG3Aui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVG2TSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:20399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262759AbVG2TRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:02 -0400
Date: Fri, 29 Jul 2005 12:16:41 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: [patch 18/29] USB: ftdi_sio: Update RTS and DTR simultaneously
Message-ID: <20050729191641.GT5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ftdi_sio-rts-dtr.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

ftdi_sio: Update RTS and DTR simultaneously, using a single control URB
instead of separate control URBs for RTS and DTR.  Reinhard Bergmann
observed time differences of up to 680 ms with his application on a
2.4.22 kernel when RTS and DTR were updated using separate control
URBs, which is unacceptable.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/ftdi_sio.c |  138 +++++++++++++-----------------------------
 1 files changed, 43 insertions(+), 95 deletions(-)

--- gregkh-2.6.orig/drivers/usb/serial/ftdi_sio.c	2005-07-29 11:36:25.000000000 -0700
+++ gregkh-2.6/drivers/usb/serial/ftdi_sio.c	2005-07-29 11:36:26.000000000 -0700
@@ -596,62 +596,59 @@
 	 return(ftdi_232bm_baud_base_to_divisor(baud, 48000000));
 }
 
-static int set_rts(struct usb_serial_port *port, int high_or_low)
+#define set_mctrl(port, set)		update_mctrl((port), (set), 0)
+#define clear_mctrl(port, clear)	update_mctrl((port), 0, (clear))
+
+static int update_mctrl(struct usb_serial_port *port, unsigned int set, unsigned int clear)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	char *buf;
-	unsigned ftdi_high_or_low;
+	unsigned urb_value;
 	int rv;
-	
-	buf = kmalloc(1, GFP_NOIO);
-	if (!buf)
-		return -ENOMEM;
-	
-	if (high_or_low) {
-		ftdi_high_or_low = FTDI_SIO_SET_RTS_HIGH;
-		priv->last_dtr_rts |= TIOCM_RTS;
-	} else {
-		ftdi_high_or_low = FTDI_SIO_SET_RTS_LOW;
-		priv->last_dtr_rts &= ~TIOCM_RTS;
-	}
-	rv = usb_control_msg(port->serial->dev,
-			       usb_sndctrlpipe(port->serial->dev, 0),
-			       FTDI_SIO_SET_MODEM_CTRL_REQUEST, 
-			       FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
-			       ftdi_high_or_low, priv->interface, 
-			       buf, 0, WDR_TIMEOUT);
-
-	kfree(buf);
-	return rv;
-}
 
+	if (((set | clear) & (TIOCM_DTR | TIOCM_RTS)) == 0) {
+		dbg("%s - DTR|RTS not being set|cleared", __FUNCTION__);
+		return 0;	/* no change */
+	}
 
-static int set_dtr(struct usb_serial_port *port, int high_or_low)
-{
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	char *buf;
-	unsigned ftdi_high_or_low;
-	int rv;
-	
 	buf = kmalloc(1, GFP_NOIO);
-	if (!buf)
+	if (!buf) {
 		return -ENOMEM;
-
-	if (high_or_low) {
-		ftdi_high_or_low = FTDI_SIO_SET_DTR_HIGH;
-		priv->last_dtr_rts |= TIOCM_DTR;
-	} else {
-		ftdi_high_or_low = FTDI_SIO_SET_DTR_LOW;
-		priv->last_dtr_rts &= ~TIOCM_DTR;
 	}
+
+	clear &= ~set;	/* 'set' takes precedence over 'clear' */
+	urb_value = 0;
+	if (clear & TIOCM_DTR)
+		urb_value |= FTDI_SIO_SET_DTR_LOW;
+	if (clear & TIOCM_RTS)
+		urb_value |= FTDI_SIO_SET_RTS_LOW;
+	if (set & TIOCM_DTR)
+		urb_value |= FTDI_SIO_SET_DTR_HIGH;
+	if (set & TIOCM_RTS)
+		urb_value |= FTDI_SIO_SET_RTS_HIGH;
 	rv = usb_control_msg(port->serial->dev,
 			       usb_sndctrlpipe(port->serial->dev, 0),
 			       FTDI_SIO_SET_MODEM_CTRL_REQUEST, 
 			       FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
-			       ftdi_high_or_low, priv->interface, 
+			       urb_value, priv->interface,
 			       buf, 0, WDR_TIMEOUT);
 
 	kfree(buf);
+	if (rv < 0) {
+		err("%s Error from MODEM_CTRL urb: DTR %s, RTS %s",
+				__FUNCTION__,
+				(set & TIOCM_DTR) ? "HIGH" :
+				(clear & TIOCM_DTR) ? "LOW" : "unchanged",
+				(set & TIOCM_RTS) ? "HIGH" :
+				(clear & TIOCM_RTS) ? "LOW" : "unchanged");
+	} else {
+		dbg("%s - DTR %s, RTS %s", __FUNCTION__,
+				(set & TIOCM_DTR) ? "HIGH" :
+				(clear & TIOCM_DTR) ? "LOW" : "unchanged",
+				(set & TIOCM_RTS) ? "HIGH" :
+				(clear & TIOCM_RTS) ? "LOW" : "unchanged");
+		priv->last_dtr_rts = (priv->last_dtr_rts & ~clear) | set;
+	}
 	return rv;
 }
 
@@ -1222,12 +1219,7 @@
 	/* FIXME: Flow control might be enabled, so it should be checked -
 	   we have no control of defaults! */
 	/* Turn on RTS and DTR since we are not flow controlling by default */
-	if (set_dtr(port, HIGH) < 0) {
-		err("%s Error from DTR HIGH urb", __FUNCTION__);
-	}
-	if (set_rts(port, HIGH) < 0){
-		err("%s Error from RTS HIGH urb", __FUNCTION__);
-	}
+	set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 
 	/* Not throttled */
 	spin_lock_irqsave(&priv->rx_lock, flags);
@@ -1277,14 +1269,8 @@
 			err("error from flowcontrol urb");
 		}	    
 
-		/* drop DTR */
-		if (set_dtr(port, LOW) < 0){
-			err("Error from DTR LOW urb");
-		}
-		/* drop RTS */
-		if (set_rts(port, LOW) < 0) {
-			err("Error from RTS LOW urb");
-		}
+		/* drop RTS and DTR */
+		clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	} /* Note change no line if hupcl is off */
 
 	/* cancel any scheduled reading */
@@ -1815,25 +1801,14 @@
 			err("%s error from disable flowcontrol urb", __FUNCTION__);
 		}	    
 		/* Drop RTS and DTR */
-		if (set_dtr(port, LOW) < 0){
-			err("%s Error from DTR LOW urb", __FUNCTION__);
-		}
-		if (set_rts(port, LOW) < 0){
-			err("%s Error from RTS LOW urb", __FUNCTION__);
-		}	
-		
+		clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	} else {
 		/* set the baudrate determined before */
 		if (change_speed(port)) {
 			err("%s urb failed to set baurdrate", __FUNCTION__);
 		}
 		/* Ensure  RTS and DTR are raised */
-		else if (set_dtr(port, HIGH) < 0){
-			err("%s Error from DTR HIGH urb", __FUNCTION__);
-		}
-		else if (set_rts(port, HIGH) < 0){
-			err("%s Error from RTS HIGH urb", __FUNCTION__);
-		}	
+		set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	}
 
 	/* Set flow control */
@@ -1945,35 +1920,8 @@
 
 static int ftdi_tiocmset(struct usb_serial_port *port, struct file * file, unsigned int set, unsigned int clear)
 {
-	int ret;
-	
 	dbg("%s TIOCMSET", __FUNCTION__);
-	if (set & TIOCM_DTR){
-		if ((ret = set_dtr(port, HIGH)) < 0) {
-			err("Urb to set DTR failed");
-			return(ret);
-		}
-	}
-	if (set & TIOCM_RTS) {
-		if ((ret = set_rts(port, HIGH)) < 0){
-			err("Urb to set RTS failed");
-			return(ret);
-		}
-	}
-	
-	if (clear & TIOCM_DTR){
-		if ((ret = set_dtr(port, LOW)) < 0){
-			err("Urb to unset DTR failed");
-			return(ret);
-		}
-	}	
-	if (clear & TIOCM_RTS) {
-		if ((ret = set_rts(port, LOW)) < 0){
-			err("Urb to unset RTS failed");
-			return(ret);
-		}
-	}
-	return(0);
+	return update_mctrl(port, set, clear);
 }
 
 

--
