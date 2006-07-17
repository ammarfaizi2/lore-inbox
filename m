Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWGQOLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWGQOLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWGQOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:11:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:26340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750787AbWGQOLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:11:44 -0400
Date: Mon, 17 Jul 2006 07:10:22 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.16.27
Message-ID: <20060717141022.GC11675@kroah.com>
References: <20060717140852.GA11675@kroah.com> <20060717140945.GB11675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717140945.GB11675@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index bea535b..4c2e2bd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .26
+EXTRAVERSION = .27
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c145e1e..b64b9d3 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -545,6 +545,10 @@ struct ftdi_private {
 
 	int force_baud;		/* if non-zero, force the baud rate to this value */
 	int force_rtscts;	/* if non-zero, force RTS-CTS to always be enabled */
+
+	spinlock_t tx_lock;	/* spinlock for transmit state */
+	unsigned long tx_outstanding_bytes;
+	unsigned long tx_outstanding_urbs;
 };
 
 /* Used for TIOCMIWAIT */
@@ -618,6 +622,9 @@ #define WDR_SHORT_TIMEOUT 1000	/* shorte
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
 
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 19727d9..99e960c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -852,6 +852,8 @@ static int inline ipv6_saddr_label(const
   * 	2002::/16		2
   * 	::/96			3
   * 	::ffff:0:0/96		4
+  *	fc00::/7		5
+  * 	2001::/32		6
   */
 	if (type & IPV6_ADDR_LOOPBACK)
 		return 0;
@@ -859,8 +861,12 @@ static int inline ipv6_saddr_label(const
 		return 3;
 	else if (type & IPV6_ADDR_MAPPED)
 		return 4;
+	else if (addr->s6_addr32[0] == htonl(0x20010000))
+		return 6;
 	else if (addr->s6_addr16[0] == htons(0x2002))
 		return 2;
+	else if ((addr->s6_addr[0] & 0xfe) == 0xfc)
+		return 5;
 	return 1;
 }
 
@@ -1059,6 +1065,9 @@ #ifdef CONFIG_IPV6_PRIVACY
 				if (hiscore.attrs & IPV6_SADDR_SCORE_PRIVACY)
 					continue;
 			}
+#else
+			if (hiscore.rule < 7)
+				hiscore.rule++;
 #endif
 			/* Rule 8: Use longest matching prefix */
 			if (hiscore.rule < 8) {
