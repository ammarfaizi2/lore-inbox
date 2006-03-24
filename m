Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWCXUMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWCXUMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCXUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:12:40 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:65170 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751378AbWCXUMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:12:39 -0500
Date: Fri, 24 Mar 2006 17:12:31 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB serial: Converts port semaphore to mutexes.
Message-Id: <20060324171231.6b45576a.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 The usbserial's port semaphore used to synchronize serial_open()
and serial_close() are strict mutexes, convert them to the mutex
implementation.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

---

 drivers/usb/serial/usb-serial.c |   16 ++++++++--------
 drivers/usb/serial/usb-serial.h |    6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

56a513093e0de2e058d1ddecb4c36ff05c1c4f1a
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 097f4e8..071f86a 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -27,10 +27,10 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
 #include "pl2303.h"
@@ -192,7 +192,7 @@ static int serial_open (struct tty_struc
 	if (!port)
 		return -ENODEV;
 
-	if (down_interruptible(&port->sem))
+	if (mutex_lock_interruptible(&port->mutex))
 		return -ERESTARTSYS;
 	 
 	++port->open_count;
@@ -219,7 +219,7 @@ static int serial_open (struct tty_struc
 			goto bailout_module_put;
 	}
 
-	up(&port->sem);
+	mutex_unlock(&port->mutex);
 	return 0;
 
 bailout_module_put:
@@ -227,7 +227,7 @@ bailout_module_put:
 bailout_kref_put:
 	kref_put(&serial->kref, destroy_serial);
 	port->open_count = 0;
-	up(&port->sem);
+	mutex_unlock(&port->mutex);
 	return retval;
 }
 
@@ -240,10 +240,10 @@ static void serial_close(struct tty_stru
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	down(&port->sem);
+	mutex_lock(&port->mutex);
 
 	if (port->open_count == 0) {
-		up(&port->sem);
+		mutex_unlock(&port->mutex);
 		return;
 	}
 
@@ -262,7 +262,7 @@ static void serial_close(struct tty_stru
 		module_put(port->serial->type->driver.owner);
 	}
 
-	up(&port->sem);
+	mutex_unlock(&port->mutex);
 	kref_put(&port->serial->kref, destroy_serial);
 }
 
@@ -783,7 +783,7 @@ int usb_serial_probe(struct usb_interfac
 		port->number = i + serial->minor;
 		port->serial = serial;
 		spin_lock_init(&port->lock);
-		sema_init(&port->sem, 1);
+		mutex_init(&port->mutex);
 		INIT_WORK(&port->work, usb_serial_port_softint, port);
 		serial->port[i] = port;
 	}
diff --git a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
index d7d27c3..dc89d87 100644
--- a/drivers/usb/serial/usb-serial.h
+++ b/drivers/usb/serial/usb-serial.h
@@ -16,7 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/kref.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #define SERIAL_TTY_MAJOR	188	/* Nice legal number now */
 #define SERIAL_TTY_MINORS	255	/* loads of devices :) */
@@ -31,7 +31,7 @@
  * @serial: pointer back to the struct usb_serial owner of this port.
  * @tty: pointer to the corresponding tty for this port.
  * @lock: spinlock to grab when updating portions of this structure.
- * @sem: semaphore used to synchronize serial_open() and serial_close()
+ * @mutex: mutex used to synchronize serial_open() and serial_close()
  *	access for this port.
  * @number: the number of the port (the minor number).
  * @interrupt_in_buffer: pointer to the interrupt in buffer for this port.
@@ -63,7 +63,7 @@ struct usb_serial_port {
 	struct usb_serial *	serial;
 	struct tty_struct *	tty;
 	spinlock_t		lock;
-	struct semaphore        sem;
+	struct mutex            mutex;
 	unsigned char		number;
 
 	unsigned char *		interrupt_in_buffer;
-- 
1.2.4



-- 
Luiz Fernando N. Capitulino
