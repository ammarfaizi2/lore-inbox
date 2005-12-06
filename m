Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVLFMPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVLFMPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVLFMPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:23 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:30852 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964966AbVLFMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:10 -0500
Date: Tue, 6 Dec 2005 10:02:30 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 08/10] usb-serial: safe_serial driver port.
Message-Id: <20051206100230.22640dd3.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Ports the safe_serial driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/safe_serial.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/safe_serial.c a~/drivers/usb/serial/safe_serial.c
--- a/drivers/usb/serial/safe_serial.c	2005-12-04 01:44:19.000000000 -0200
+++ a~/drivers/usb/serial/safe_serial.c	2005-12-04 15:14:04.000000000 -0200
@@ -69,7 +69,6 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
@@ -299,14 +298,10 @@ static int safe_write (struct usb_serial
 		dbg ("%s - write request of 0 bytes", __FUNCTION__);
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
 
 	packet_length = port->bulk_out_size;	// get max packetsize
 
@@ -358,7 +353,7 @@ static int safe_write (struct usb_serial
 #endif
 	port->write_urb->dev = port->serial->dev;
 	if ((result = usb_submit_urb (port->write_urb, GFP_KERNEL))) {
-		port->write_urb_busy = 0;
+		usb_serial_write_urb_unlock(port);
 		err ("%s - failed submitting write urb, error %d", __FUNCTION__, result);
 		return 0;
 	}
@@ -373,7 +368,7 @@ static int safe_write_room (struct usb_s
 
 	dbg ("%s", __FUNCTION__);
 
-	if (port->write_urb_busy)
+	if (usb_serial_write_urb_locked(port))
 		room = port->bulk_out_size - (safe ? 2 : 0);
 
 	if (room) {


-- 
Luiz Fernando N. Capitulino
