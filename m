Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWGMWOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWGMWOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWGMWOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:14:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15004 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030395AbWGMWOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:14:47 -0400
Date: Thu, 13 Jul 2006 15:10:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Ian Abbott <abbotti@mev.co.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 3/3] USB serial ftdi_sio: Prevent userspace DoS (CVE-2006-2936)
Message-ID: <20060713221046.GD13275@kroah.com>
References: <20060713220455.715461301@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="USB-serial-ftdi_sio-Prevent-userspace-DoS.patch"
In-Reply-To: <20060713221008.GA13275@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

This patch limits the amount of outstanding 'write' data that can be
queued up for the ftdi_sio driver, to prevent userspace DoS attacks (or
simple accidents) that use up all the system memory by writing lots of
data to the serial port.


Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/serial/ftdi_sio.c |   84 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 13 deletions(-)

--- linux-2.6.16.24.orig/drivers/usb/serial/ftdi_sio.c
+++ linux-2.6.16.24/drivers/usb/serial/ftdi_sio.c
@@ -545,6 +545,10 @@ struct ftdi_private {
 
 	int force_baud;		/* if non-zero, force the baud rate to this value */
 	int force_rtscts;	/* if non-zero, force RTS-CTS to always be enabled */
+
+	spinlock_t tx_lock;	/* spinlock for transmit state */
+	unsigned long tx_outstanding_bytes;
+	unsigned long tx_outstanding_urbs;
 };
 
 /* Used for TIOCMIWAIT */
@@ -618,6 +622,9 @@ static struct usb_serial_driver ftdi_sio
 #define HIGH 1
 #define LOW 0
 
+/* number of outstanding urbs to prevent userspace DoS from happening */
+#define URB_UPPER_LIMIT	42
+
 /*
  * ***************************************************************************
  * Utlity functions
@@ -1149,6 +1156,7 @@ static int ftdi_sio_attach (struct usb_s
 	memset(priv, 0, sizeof(*priv));
 
 	spin_lock_init(&priv->rx_lock);
+	spin_lock_init(&priv->tx_lock);
         init_waitqueue_head(&priv->delta_msr_wait);
 	/* This will push the characters through immediately rather
 	   than queue a task to deliver them */
@@ -1365,6 +1373,7 @@ static int ftdi_write (struct usb_serial
 	int data_offset ;       /* will be 1 for the SIO and 0 otherwise */
 	int status;
 	int transfer_size;
+	unsigned long flags;
 
 	dbg("%s port %d, %d bytes", __FUNCTION__, port->number, count);
 
@@ -1372,6 +1381,13 @@ static int ftdi_write (struct usb_serial
 		dbg("write request of 0 bytes");
 		return 0;
 	}
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (priv->tx_outstanding_urbs > URB_UPPER_LIMIT) {
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+		dbg("%s - write limit hit\n", __FUNCTION__);
+		return 0;
+	}
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 	
 	data_offset = priv->write_offset;
         dbg("data_offset set to %d",data_offset);
@@ -1438,6 +1454,11 @@ static int ftdi_write (struct usb_serial
 		err("%s - failed submitting write urb, error %d", __FUNCTION__, status);
 		count = status;
 		kfree (buffer);
+	} else {
+		spin_lock_irqsave(&priv->tx_lock, flags);
+		++priv->tx_outstanding_urbs;
+		priv->tx_outstanding_bytes += count;
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
 	}
 
 	/* we are done with this urb, so let the host driver
@@ -1453,7 +1474,11 @@ static int ftdi_write (struct usb_serial
 
 static void ftdi_write_bulk_callback (struct urb *urb, struct pt_regs *regs)
 {
+	unsigned long flags;
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
+	struct ftdi_private *priv;
+	int data_offset;       /* will be 1 for the SIO and 0 otherwise */
+	unsigned long countback;
 
 	/* free up the transfer buffer, as usb_free_urb() does not do this */
 	kfree (urb->transfer_buffer);
@@ -1465,34 +1490,67 @@ static void ftdi_write_bulk_callback (st
 		return;
 	}
 
+	priv = usb_get_serial_port_data(port);
+	if (!priv) {
+		dbg("%s - bad port private data pointer - exiting", __FUNCTION__);
+		return;
+	}
+	/* account for transferred data */
+	countback = urb->actual_length;
+	data_offset = priv->write_offset;
+	if (data_offset > 0) {
+		/* Subtract the control bytes */
+		countback -= (data_offset * ((countback + (PKTSZ - 1)) / PKTSZ));
+	}
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	--priv->tx_outstanding_urbs;
+	priv->tx_outstanding_bytes -= countback;
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 	schedule_work(&port->work);
 } /* ftdi_write_bulk_callback */
 
 
 static int ftdi_write_room( struct usb_serial_port *port )
 {
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int room;
+	unsigned long flags;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	/*
-	 * We really can take anything the user throws at us
-	 * but let's pick a nice big number to tell the tty
-	 * layer that we have lots of free space
-	 */
-	return 2048;
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	if (priv->tx_outstanding_urbs < URB_UPPER_LIMIT) {
+		/*
+		 * We really can take anything the user throws at us
+		 * but let's pick a nice big number to tell the tty
+		 * layer that we have lots of free space
+		 */
+		room = 2048;
+	} else {
+		room = 0;
+	}
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+	return room;
 } /* ftdi_write_room */
 
 
 static int ftdi_chars_in_buffer (struct usb_serial_port *port)
 { /* ftdi_chars_in_buffer */
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int buffered;
+	unsigned long flags;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	/* 
-	 * We can't really account for how much data we
-	 * have sent out, but hasn't made it through to the
-	 * device, so just tell the tty layer that everything
-	 * is flushed.
-	 */
-	return 0;
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	buffered = (int)priv->tx_outstanding_bytes;
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+	if (buffered < 0) {
+		err("%s outstanding tx bytes is negative!", __FUNCTION__);
+		buffered = 0;
+	}
+	return buffered;
 } /* ftdi_chars_in_buffer */
 
 

--
