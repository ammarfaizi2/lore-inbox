Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVLFMQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVLFMQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVLFMPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:20 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:29572 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964962AbVLFMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:10 -0500
Date: Tue, 6 Dec 2005 10:00:29 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 05/10] usb-serial: ir-usb driver port.
Message-Id: <20051206100029.6a2dbf6f.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Ports the ir-usb driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/ir-usb.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/ir-usb.c a~/drivers/usb/serial/ir-usb.c
--- a/drivers/usb/serial/ir-usb.c	2005-12-04 01:44:19.000000000 -0200
+++ a~/drivers/usb/serial/ir-usb.c	2005-12-04 14:43:39.000000000 -0200
@@ -55,7 +55,6 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
@@ -344,14 +343,10 @@ static int ir_write (struct usb_serial_p
 	if (count == 0)
 		return 0;
 
-	spin_lock(&port->lock);
-	if (port->write_urb_busy) {
-		spin_unlock(&port->lock);
+	if (usb_serial_write_urb_lock(port)) {
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
-	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
 
 	transfer_buffer = port->write_urb->transfer_buffer;
 	transfer_size = min(count, port->bulk_out_size - 1);
@@ -382,7 +377,7 @@ static int ir_write (struct usb_serial_p
 
 	result = usb_submit_urb (port->write_urb, GFP_ATOMIC);
 	if (result) {
-		port->write_urb_busy = 0;
+		usb_serial_write_urb_unlock(port);
 		dev_err(&port->dev, "%s - failed submitting write urb, error %d\n", __FUNCTION__, result);
 	} else
 		result = transfer_size;
@@ -396,7 +391,7 @@ static void ir_write_bulk_callback (stru
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	port->write_urb_busy = 0;
+	usb_serial_write_urb_unlock(port);
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
 		return;


-- 
Luiz Fernando N. Capitulino
