Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVKVV7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVKVV7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVKVV7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:59:25 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:39577 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030188AbVKVV7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:59:23 -0500
Date: Tue, 22 Nov 2005 19:59:26 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org, ehabkost@mandriva.com
Subject: [PATCH 2/2] - usbserial: race-condition fix.
Message-Id: <20051122195926.18c3221c.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes open()/close() race-condition in the access of the port structure.

 When the race happens, the port in use becomes invalid, and the user must try
to get the next free port (repluging the device, for example).

 Described in more detail in this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113216151918308&w=2

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.c |   14 +++++++++++++-
 drivers/usb/serial/usb-serial.h |    2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2005-11-22 10:50:33.000000000 -0200
+++ a~/drivers/usb/serial/usb-serial.c	2005-11-22 11:31:46.000000000 -0200
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
 #include "pl2303.h"
@@ -190,6 +191,9 @@ static int serial_open (struct tty_struc
 	port = serial->port[portNumber];
 	if (!port)
 		return -ENODEV;
+
+	if (down_interruptible(&port->sem))
+		return -ERESTARTSYS;
 	 
 	++port->open_count;
 
@@ -215,6 +219,7 @@ static int serial_open (struct tty_struc
 			goto bailout_module_put;
 	}
 
+	up(&port->sem);
 	return 0;
 
 bailout_module_put:
@@ -222,6 +227,7 @@ bailout_module_put:
 bailout_kref_put:
 	kref_put(&serial->kref, destroy_serial);
 	port->open_count = 0;
+	up(&port->sem);
 	return retval;
 }
 
@@ -234,8 +240,10 @@ static void serial_close(struct tty_stru
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
+	down(&port->sem);
+
 	if (port->open_count == 0)
-		return;
+		goto out;
 
 	--port->open_count;
 	if (port->open_count == 0) {
@@ -253,6 +261,9 @@ static void serial_close(struct tty_stru
 	}
 
 	kref_put(&port->serial->kref, destroy_serial);
+
+out:
+	up(&port->sem);
 }
 
 static int serial_write (struct tty_struct * tty, const unsigned char *buf, int count)
@@ -774,6 +785,7 @@ int usb_serial_probe(struct usb_interfac
 		port->number = i + serial->minor;
 		port->serial = serial;
 		spin_lock_init(&port->lock);
+		sema_init(&port->sem, 1);
 		INIT_WORK(&port->work, usb_serial_port_softint, port);
 		serial->port[i] = port;
 	}
diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/usb-serial.h a~/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	2005-11-22 10:50:42.000000000 -0200
+++ a~/drivers/usb/serial/usb-serial.h	2005-11-22 11:31:46.000000000 -0200
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/kref.h>
+#include <asm/semaphore.h>
 
 #define SERIAL_TTY_MAJOR	188	/* Nice legal number now */
 #define SERIAL_TTY_MINORS	255	/* loads of devices :) */
@@ -60,6 +61,7 @@ struct usb_serial_port {
 	struct usb_serial *	serial;
 	struct tty_struct *	tty;
 	spinlock_t		lock;
+	struct semaphore        sem;
 	unsigned char		number;
 
 	unsigned char *		interrupt_in_buffer;


-- 
Luiz Fernando N. Capitulino
