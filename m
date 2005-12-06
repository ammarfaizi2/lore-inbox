Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVLFMQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVLFMQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVLFMPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:21 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:30340 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964965AbVLFMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:10 -0500
Date: Tue, 6 Dec 2005 10:01:45 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 07/10] usb-serial: omninet driver port.
Message-Id: <20051206100145.690230ef.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Ports the omninet driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/omninet.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/omninet.c a~/drivers/usb/serial/omninet.c
--- a/drivers/usb/serial/omninet.c	2005-12-04 01:44:19.000000000 -0200
+++ a~/drivers/usb/serial/omninet.c	2005-12-04 15:08:27.000000000 -0200
@@ -257,14 +257,10 @@ static int omninet_write (struct usb_ser
 		return (0);
 	}
 
-	spin_lock(&port->lock);
-	if (port->write_urb_busy) {
-		spin_unlock(&port->lock);
+	if (usb_serial_write_urb_lock(port)) {
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
-	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
 
 	count = (count > OMNINET_BULKOUTSIZE) ? OMNINET_BULKOUTSIZE : count;
 
@@ -283,7 +279,7 @@ static int omninet_write (struct usb_ser
 	wport->write_urb->dev = serial->dev;
 	result = usb_submit_urb(wport->write_urb, GFP_ATOMIC);
 	if (result) {
-		port->write_urb_busy = 0;
+		usb_serial_write_urb_unlock(port);
 		err("%s - failed submitting write urb, error %d", __FUNCTION__, result);
 	} else
 		result = count;
@@ -299,7 +295,7 @@ static int omninet_write_room (struct us
 
 	int room = 0; // Default: no room
 
-	if (wport->write_urb_busy)
+	if (usb_serial_write_urb_locked(wport))
 		room = wport->bulk_out_size - OMNINET_HEADERLEN;
 
 //	dbg("omninet_write_room returns %d", room);
@@ -314,7 +310,7 @@ static void omninet_write_bulk_callback 
 
 //	dbg("omninet_write_bulk_callback, port %0x\n", port);
 
-	port->write_urb_busy = 0;
+	usb_serial_write_urb_unlock(port);
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
 		return;


-- 
Luiz Fernando N. Capitulino
