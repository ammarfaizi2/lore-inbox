Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVLFMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVLFMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVLFMPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:19 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:27268 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964961AbVLFMPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:09 -0500
Date: Tue, 6 Dec 2005 09:58:55 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 03/10] usb-serial: cyberjack driver port.
Message-Id: <20051206095855.080df3db.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Ports the cyberjack driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/cyberjack.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/cyberjack.c a~/drivers/usb/serial/cyberjack.c
--- a/drivers/usb/serial/cyberjack.c	2005-12-04 19:19:57.000000000 -0200
+++ a~/drivers/usb/serial/cyberjack.c	2005-12-04 19:25:50.000000000 -0200
@@ -215,14 +215,10 @@ static int cyberjack_write (struct usb_s
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
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -230,7 +226,7 @@ static int cyberjack_write (struct usb_s
 		/* To much data for buffer. Reset buffer. */
 		priv->wrfilled=0;
 		spin_unlock_irqrestore(&priv->lock, flags);
-		port->write_urb_busy = 0;
+		usb_serial_write_urb_unlock(port);
 		return (0);
 	}
 
@@ -275,7 +271,7 @@ static int cyberjack_write (struct usb_s
 			priv->wrfilled=0;
 			priv->wrsent=0;
 			spin_unlock_irqrestore(&priv->lock, flags);
-			port->write_urb_busy = 0;
+			usb_serial_write_urb_unlock(port);
 			return 0;
 		}
 
@@ -421,7 +417,7 @@ static void cyberjack_write_bulk_callbac
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	port->write_urb_busy = 0;
+	usb_serial_write_urb_unlock(port);
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
 		return;


-- 
Luiz Fernando N. Capitulino
