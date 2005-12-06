Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVLFMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVLFMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVLFMPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:17 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:28292 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964964AbVLFMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:10 -0500
Date: Tue, 6 Dec 2005 09:59:44 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 04/10] usb-serial: ipw driver port.
Message-Id: <20051206095944.6e69210c.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Ports the ipw driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/ipw.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/ipw.c a~/drivers/usb/serial/ipw.c
--- a/drivers/usb/serial/ipw.c	2005-12-04 01:44:17.000000000 -0200
+++ a~/drivers/usb/serial/ipw.c	2005-12-04 14:35:49.000000000 -0200
@@ -44,7 +44,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
 #include <linux/usb.h>
 #include <asm/uaccess.h>
 #include "usb-serial.h"
@@ -399,14 +398,10 @@ static int ipw_write(struct usb_serial_p
 		return 0;
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
 
 	count = min(count, port->bulk_out_size);
 	memcpy(port->bulk_out_buffer, buf, count);
@@ -422,7 +417,7 @@ static int ipw_write(struct usb_serial_p
 
 	ret = usb_submit_urb(port->write_urb, GFP_ATOMIC);
 	if (ret != 0) {
-		port->write_urb_busy = 0;
+		usb_serial_write_urb_unlock(port);
 		dbg("%s - usb_submit_urb(write bulk) failed with error = %d", __FUNCTION__, ret);
 		return ret;
 	}


-- 
Luiz Fernando N. Capitulino
