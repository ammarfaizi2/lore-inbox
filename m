Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWELBbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWELBbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 21:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWELBbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 21:31:41 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:24212 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750775AbWELBbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 21:31:40 -0400
Date: Thu, 11 May 2006 22:34:24 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2/2] usbserial: Fixes leak in serial_open() error path.
Message-ID: <20060511223424.7e7df2fc@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 If serial_open() fails at the port assignment or mutex_lock_interruptible()
is interrupted, the 'serial' object will never be freed.

 We should call kref_put() when those errors happens.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

---

 drivers/usb/serial/usb-serial.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

56bff699ffd5616ed10c5945faa8721520e7a902
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index d9dceb4..9c36f0e 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -189,11 +189,15 @@ static int serial_open (struct tty_struc
 
 	portNumber = tty->index - serial->minor;
 	port = serial->port[portNumber];
-	if (!port)
-		return -ENODEV;
+	if (!port) {
+		retval = -ENODEV;
+		goto bailout_kref_put;
+	}
 
-	if (mutex_lock_interruptible(&port->mutex))
-		return -ERESTARTSYS;
+	if (mutex_lock_interruptible(&port->mutex)) {
+		retval = -ERESTARTSYS;
+		goto bailout_kref_put;
+	}
 	 
 	++port->open_count;
 
@@ -209,7 +213,7 @@ static int serial_open (struct tty_struc
 		 * safe because we are called with BKL held */
 		if (!try_module_get(serial->type->driver.owner)) {
 			retval = -ENODEV;
-			goto bailout_kref_put;
+			goto bailout_mutex_unlock;
 		}
 
 		/* only call the device specific open if this 
@@ -224,9 +228,10 @@ static int serial_open (struct tty_struc
 
 bailout_module_put:
 	module_put(serial->type->driver.owner);
-bailout_kref_put:
+bailout_mutex_unlock:
 	port->open_count = 0;
 	mutex_unlock(&port->mutex);
+bailout_kref_put:
 	kref_put(&serial->kref, destroy_serial);
 	return retval;
 }
-- 
1.3.1.ge5de



-- 
Luiz Fernando N. Capitulino
