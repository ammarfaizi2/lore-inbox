Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUK1SPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUK1SPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbUK1SPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:15:39 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:31093 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261546AbUK1SPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:15:24 -0500
Subject: Re: Little rework of usbserial in 2.4
From: Paul Fulghum <paulkf@microgate.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net, rwhite@casabyte.com,
       linux-kernel@vger.kernel.org, kingst@eecs.umich.edu,
       Oleksiy <Oleksiy@kharkiv.com.ua>, reg@dwf.com, clemens@dwf.com
In-Reply-To: <41A9DEB1.5000309@microgate.com>
References: <20041127173558.4011b177@lembas.zaitcev.lan>
	 <41A9DEB1.5000309@microgate.com>
Content-Type: text/plain
Date: Sun, 28 Nov 2004 12:14:24 -0600
Message-Id: <1101665664.3562.3.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 08:20 -0600, Paul Fulghum wrote:
> Pete Zaitcev wrote:
> > Not done #1: I asked Paul Fulghum to experiment with dropping a private
> > implementation of write callback from pl2303 and have Oleksy to test it.

Below is a patch that implements Pete's suggested fix for
the pl2303/ppp write problem.

Oleksiy, can you please test this to see if it works
as well as my first patch?

--
Paul Fulghum
paulkf@microgate.com

--- linux-2.4.28/drivers/usb/serial/pl2303.c	2004-08-07 18:26:05.000000000 -0500
+++ b/drivers/usb/serial/pl2303.c	2004-11-28 11:41:07.093134368 -0600
@@ -126,7 +126,6 @@ static int pl2303_ioctl (struct usb_seri
 			 unsigned int cmd, unsigned long arg);
 static void pl2303_read_int_callback (struct urb *urb);
 static void pl2303_read_bulk_callback (struct urb *urb);
-static void pl2303_write_bulk_callback (struct urb *urb);
 static int pl2303_write (struct usb_serial_port *port, int from_user,
 			 const unsigned char *buf, int count);
 static void pl2303_break_ctl(struct usb_serial_port *port,int break_state);
@@ -151,7 +150,6 @@ static struct usb_serial_device_type pl2
 	.set_termios =		pl2303_set_termios,
 	.read_bulk_callback =	pl2303_read_bulk_callback,
 	.read_int_callback =	pl2303_read_int_callback,
-	.write_bulk_callback =	pl2303_write_bulk_callback,
 	.startup =		pl2303_startup,
 	.shutdown =		pl2303_shutdown,
 };
@@ -814,41 +812,6 @@ static void pl2303_read_bulk_callback (s
 	return;
 }
 
-
-
-static void pl2303_write_bulk_callback (struct urb *urb)
-{
-	struct usb_serial_port *port = (struct usb_serial_port *) urb->context;
-	int result;
-
-	if (port_paranoia_check (port, __FUNCTION__))
-		return;
-	
-	dbg("%s - port %d", __FUNCTION__, port->number);
-	
-	if (urb->status) {
-		/* error in the urb, so we have to resubmit it */
-		if (serial_paranoia_check (port->serial, __FUNCTION__)) {
-			return;
-		}
-		dbg("%s - Overflow in write", __FUNCTION__);
-		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
-		port->write_urb->transfer_buffer_length = 1;
-		port->write_urb->dev = port->serial->dev;
-		result = usb_submit_urb (port->write_urb);
-		if (result)
-			err("%s - failed resubmitting write urb, error %d", __FUNCTION__, result);
-
-		return;
-	}
-
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
-}
-
-
 static int __init pl2303_init (void)
 {
 	int retval;


