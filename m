Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVLFMSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVLFMSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVLFMPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:14 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:25732 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964960AbVLFMPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:09 -0500
Date: Tue, 6 Dec 2005 09:58:16 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 02/10] usb-serial: generic driver port.
Message-Id: <20051206095816.1c41bd4f.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Ports the generic driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/generic.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/generic.c a~/drivers/usb/serial/generic.c
--- a/drivers/usb/serial/generic.c	2005-12-04 01:44:18.000000000 -0200
+++ a~/drivers/usb/serial/generic.c	2005-12-04 14:05:26.000000000 -0200
@@ -175,14 +175,10 @@ int usb_serial_generic_write(struct usb_
 
 	/* only do something if we have a bulk out endpoint */
 	if (serial->num_bulk_out) {
-		spin_lock(&port->lock);
-		if (port->write_urb_busy) {
-			spin_unlock(&port->lock);
+		if (usb_serial_write_urb_lock(port)) {
 			dbg("%s - already writing", __FUNCTION__);
 			return 0;
 		}
-		port->write_urb_busy = 1;
-		spin_unlock(&port->lock);
 
 		count = (count > port->bulk_out_size) ? port->bulk_out_size : count;
 
@@ -200,12 +196,12 @@ int usb_serial_generic_write(struct usb_
 				     usb_serial_generic_write_bulk_callback), port);
 
 		/* send the data out the bulk port */
-		port->write_urb_busy = 1;
+		usb_serial_write_urb_lock(port);
 		result = usb_submit_urb(port->write_urb, GFP_ATOMIC);
 		if (result) {
 			dev_err(&port->dev, "%s - failed submitting write urb, error %d\n", __FUNCTION__, result);
 			/* don't have to grab the lock here, as we will retry if != 0 */
-			port->write_urb_busy = 0;
+			usb_serial_write_urb_unlock(port);
 		} else
 			result = count;
 
@@ -224,7 +220,7 @@ int usb_serial_generic_write_room (struc
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (serial->num_bulk_out) {
-		if (!(port->write_urb_busy))
+		if (!(usb_serial_write_urb_locked(port)))
 			room = port->bulk_out_size;
 	}
 
@@ -240,7 +236,7 @@ int usb_serial_generic_chars_in_buffer (
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (serial->num_bulk_out) {
-		if (port->write_urb_busy)
+		if (usb_serial_write_urb_locked(port))
 			chars = port->write_urb->transfer_buffer_length;
 	}
 
@@ -299,7 +295,7 @@ void usb_serial_generic_write_bulk_callb
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	port->write_urb_busy = 0;
+	usb_serial_write_urb_unlock(port);
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
 		return;


-- 
Luiz Fernando N. Capitulino
