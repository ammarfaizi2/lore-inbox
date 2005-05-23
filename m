Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVEWXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEWXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVEWXdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:33:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:32902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261220AbVEWX2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:28:31 -0400
Date: Mon, 23 May 2005 16:28:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 11/16] USB: fix bug in visor driver with throttle/unthrottle causing oopses.
Message-ID: <20050523232803.GW27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Mark Lord <mlord@pobox.com> for reporting this and helping with testing.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/visor.c |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

--- linux-2.6.11.10.orig/drivers/usb/serial/visor.c	2005-05-16 10:50:37.000000000 -0700
+++ linux-2.6.11.10/drivers/usb/serial/visor.c	2005-05-20 09:36:44.139463608 -0700
@@ -386,6 +386,7 @@
 	int bytes_in;
 	int bytes_out;
 	int outstanding_urbs;
+	int throttled;
 };
 
 /* number of outstanding urbs to prevent userspace DoS from happening */
@@ -415,6 +416,7 @@
 	priv->bytes_in = 0;
 	priv->bytes_out = 0;
 	priv->outstanding_urbs = 0;
+	priv->throttled = 0;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/*
@@ -602,6 +604,7 @@
 	struct tty_struct *tty;
 	unsigned long flags;
 	int i;
+	int throttled;
 	int result;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
@@ -627,18 +630,21 @@
 	}
 	spin_lock_irqsave(&priv->lock, flags);
 	priv->bytes_in += urb->actual_length;
+	throttled = priv->throttled;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Continue trying to always read  */
-	usb_fill_bulk_urb (port->read_urb, port->serial->dev,
-			   usb_rcvbulkpipe(port->serial->dev,
-					   port->bulk_in_endpointAddress),
-			   port->read_urb->transfer_buffer,
-			   port->read_urb->transfer_buffer_length,
-			   visor_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
-	if (result)
-		dev_err(&port->dev, "%s - failed resubmitting read urb, error %d\n", __FUNCTION__, result);
+	/* Continue trying to always read if we should */
+	if (!throttled) {
+		usb_fill_bulk_urb (port->read_urb, port->serial->dev,
+				   usb_rcvbulkpipe(port->serial->dev,
+						   port->bulk_in_endpointAddress),
+				   port->read_urb->transfer_buffer,
+				   port->read_urb->transfer_buffer_length,
+				   visor_read_bulk_callback, port);
+		result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
+		if (result)
+			dev_err(&port->dev, "%s - failed resubmitting read urb, error %d\n", __FUNCTION__, result);
+	}
 	return;
 }
 
@@ -683,16 +689,26 @@
 
 static void visor_throttle (struct usb_serial_port *port)
 {
+	struct visor_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
-	usb_kill_urb(port->read_urb);
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->throttled = 1;
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 
 static void visor_unthrottle (struct usb_serial_port *port)
 {
+	struct visor_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 	int result;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->throttled = 0;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	port->read_urb->dev = port->serial->dev;
 	result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
