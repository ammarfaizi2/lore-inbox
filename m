Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVLFMR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVLFMR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVLFMPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:16 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:28804 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964963AbVLFMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:10 -0500
Date: Tue, 6 Dec 2005 10:01:03 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 06/10] usb-serial: keyspan_pda driver port.
Message-Id: <20051206100103.19a53a49.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Ports the keyspan_pda driver from write_urb_busy spin_lock to
usb_serial_write_urb_lock() functions.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/keyspan_pda.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/keyspan_pda.c a~/drivers/usb/serial/keyspan_pda.c
--- a/drivers/usb/serial/keyspan_pda.c	2005-12-04 01:44:19.000000000 -0200
+++ a~/drivers/usb/serial/keyspan_pda.c	2005-12-04 14:56:06.000000000 -0200
@@ -75,7 +75,6 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
@@ -520,13 +519,13 @@ static int keyspan_pda_write(struct usb_
 	   the TX urb is in-flight (wait until it completes)
 	   the device is full (wait until it says there is room)
 	*/
-	spin_lock(&port->lock);
-	if (port->write_urb_busy || priv->tx_throttled) {
-		spin_unlock(&port->lock);
+	if (usb_serial_write_urb_lock(port))
+		return 0;
+
+	if (priv->tx_throttled) {
+		usb_serial_write_urb_unlock(port);
 		return 0;
 	}
-	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
 
 	/* At this point the URB is in our control, nobody else can submit it
 	   again (the only sudden transition was the one from EINPROGRESS to
@@ -598,7 +597,7 @@ static int keyspan_pda_write(struct usb_
 	rc = count;
 exit:
 	if (rc < 0)
-		port->write_urb_busy = 0;
+		usb_serial_write_urb_unlock(port);
 	return rc;
 }
 
@@ -608,7 +607,7 @@ static void keyspan_pda_write_bulk_callb
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
 	struct keyspan_pda_private *priv;
 
-	port->write_urb_busy = 0;
+	usb_serial_write_urb_unlock(port);
 	priv = usb_get_serial_port_data(port);
 
 	/* queue up a wakeup at scheduler time */
@@ -638,7 +637,7 @@ static int keyspan_pda_chars_in_buffer (
 
 	/* when throttled, return at least WAKEUP_CHARS to tell select() (via
 	   n_tty.c:normal_poll() ) that we're not writeable. */
-	if (port->write_urb_busy || priv->tx_throttled)
+	if (usb_serial_write_urb_locked(port) || priv->tx_throttled)
 		return 256;
 	return 0;
 }


-- 
Luiz Fernando N. Capitulino
