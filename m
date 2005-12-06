Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVLFMPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVLFMPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVLFMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:13 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:24196 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964959AbVLFMPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:08 -0500
Date: Tue, 6 Dec 2005 09:57:22 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 01/10] usb-serial: URB write locking macros.
Message-Id: <20051206095722.45cf4a32.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Introduces URB write locking macros.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.h |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/usb-serial.h a~/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	2005-12-04 20:05:26.000000000 -0200
+++ a~/drivers/usb/serial/usb-serial.h	2005-12-04 20:06:53.000000000 -0200
@@ -17,6 +17,7 @@
 #include <linux/config.h>
 #include <linux/kref.h>
 #include <asm/semaphore.h>
+#include <asm/atomic.h>
 
 #define SERIAL_TTY_MAJOR	188	/* Nice legal number now */
 #define SERIAL_TTY_MINORS	255	/* loads of devices :) */
@@ -83,7 +84,7 @@ struct usb_serial_port {
 	unsigned char *		bulk_out_buffer;
 	int			bulk_out_size;
 	struct urb *		write_urb;
-	int			write_urb_busy;
+	atomic_t		write_urb_busy;
 	__u8			bulk_out_endpointAddress;
 
 	wait_queue_head_t	write_wait;
@@ -104,6 +105,40 @@ static inline void usb_set_serial_port_d
 	dev_set_drvdata(&port->dev, data);
 }
 
+/*
+ * usb_serial URB write access locking functions
+ *
+ * Protects 'write_urb_busy' member access, used to avoid two or more threads
+ * trying to write the same URB at the same time.
+ */
+
+/* Initialize the lock */
+static inline void usb_serial_write_urb_lock_init(struct usb_serial_port *port)
+{
+	atomic_set(&port->write_urb_busy, 0);
+}
+
+/*
+ * Lock function: returns zero if the lock was acquired,
+ * and non-zero otherwise
+ */
+static inline int usb_serial_write_urb_lock(struct usb_serial_port *port)
+{
+	return !atomic_add_unless(&port->write_urb_busy, 1, 1);
+}
+
+/* unlock function */
+static inline void usb_serial_write_urb_unlock(struct usb_serial_port *port)
+{
+	atomic_set(&port->write_urb_busy, 0);
+}
+
+/* Lock test: returns non-zero if the port is locked, and zero otherwise */
+static inline int usb_serial_write_urb_locked(struct usb_serial_port *port)
+{
+	return atomic_read(&port->write_urb_busy);
+}
+
 /**
  * usb_serial - structure used by the usb-serial core for a device
  * @dev: pointer to the struct usb_device for this device


-- 
Luiz Fernando N. Capitulino
