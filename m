Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268091AbTB1SsK>; Fri, 28 Feb 2003 13:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbTB1SsK>; Fri, 28 Feb 2003 13:48:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:26551 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268091AbTB1SsD>; Fri, 28 Feb 2003 13:48:03 -0500
Date: Fri, 28 Feb 2003 11:07:21 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: davem@redhat.com
cc: gregkh@us.ibm.com, greg@kroah.com, hannal@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.63] serial tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
Message-ID: <61540000.1046459241@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are the changes to drivers/serial to set .owner for tty_drivers
and remove MOD_INC/DEC_USE_COUNT. Dave, please review.  I have made 
changes to most the other tty drivers and am sending them to 
trivial@rustcorp.com.au. If you want me to include this one to rusty
I will, please let me know. I tested the core changes via 8250 following 
are the results:

Without patch:
[root@w-hlinder2 root]# lsmod
Module                  Size  Used by
8250                   26400  0
core                   21568  1 8250
[root@w-hlinder2 root]# cat /dev/ttyS0 &
[1] 4206
[root@w-hlinder2 root]# lsmod
Module                  Size  Used by
8250                   26400  1
core                   21568  1 8250
[root@w-hlinder2 root]# kill %1
[root@w-hlinder2 root]# lsmod
Module                  Size  Used by
8250                   26400  0
core                   21568  1 8250
[1]+  Terminated              cat /dev/ttyS0

with patch:

[root@w-hlinder2 serial]# lsmod
Module                  Size  Used by
8250                   26400  0
core                   21600  1 8250
[root@w-hlinder2 serial]# cat /dev/ttyS0 &
[1] 1124
[root@w-hlinder2 serial]# lsmod
Module                  Size  Used by
8250                   26400  1
core                   21600  2 8250
[root@w-hlinder2 serial]# kill %1
[root@w-hlinder2 serial]# lsmod
Module                  Size  Used by
8250                   26400  0
core                   21600  1 8250
[1]+  Terminated              cat /dev/ttyS0
[root@w-hlinder2 serial]#

Hanna
------
 68328serial.c |    1 +
 68360serial.c |    6 +-----
 core.c        |    1 +
 mcfserial.c   |    1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff -Nru -Xdontdiff linux-2.5.63/drivers/serial/68328serial.c linux-2.5.63-ttydrv/drivers/serial/68328serial.c
--- linux-2.5.63/drivers/serial/68328serial.c	Mon Feb 24 11:05:48 2003
+++ linux-2.5.63-ttydrv/drivers/serial/68328serial.c	Thu Feb 27 17:11:11 2003
@@ -1488,6 +1488,7 @@
 	
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
diff -Nru -Xdontdiff linux-2.5.63/drivers/serial/68360serial.c linux-2.5.63-ttydrv/drivers/serial/68360serial.c
--- linux-2.5.63/drivers/serial/68360serial.c	Mon Feb 24 11:05:46 2003
+++ linux-2.5.63-ttydrv/drivers/serial/68360serial.c	Thu Feb 27 17:11:11 2003
@@ -1717,7 +1717,6 @@
 	
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
 		local_irq_restore(flags);
 		return;
 	}
@@ -1744,7 +1743,6 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
 		local_irq_restore(flags);
 		return;
 	}
@@ -1808,7 +1806,6 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 	local_irq_restore(flags);
 }
 
@@ -2101,14 +2098,12 @@
 	if (retval)
 		return retval;
 
-	MOD_INC_USE_COUNT;
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
 #ifdef SERIAL_DEBUG_OPEN
 		printk("rs_open returning after block_til_ready with %d\n",
 		       retval);
 #endif
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 
@@ -2623,6 +2618,7 @@
 
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	/* serial_driver.driver_name = "serial"; */
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
diff -Nru -Xdontdiff linux-2.5.63/drivers/serial/core.c linux-2.5.63-ttydrv/drivers/serial/core.c
--- linux-2.5.63/drivers/serial/core.c	Mon Feb 24 11:05:12 2003
+++ linux-2.5.63-ttydrv/drivers/serial/core.c	Thu Feb 27 17:11:11 2003
@@ -2219,6 +2219,7 @@
 	drv->tty_driver = normal;
 
 	normal->magic		= TTY_DRIVER_MAGIC;
+	normal->owner		= THIS_MODULE;
 	normal->driver_name	= drv->driver_name;
 	normal->name		= drv->dev_name;
 	normal->major		= drv->major;
diff -Nru -Xdontdiff linux-2.5.63/drivers/serial/mcfserial.c linux-2.5.63-ttydrv/drivers/serial/mcfserial.c
--- linux-2.5.63/drivers/serial/mcfserial.c	Mon Feb 24 11:05:29 2003
+++ linux-2.5.63-ttydrv/drivers/serial/mcfserial.c	Thu Feb 27 17:11:11 2003
@@ -1616,6 +1616,7 @@
 	/* Initialize the tty_driver structure */
 	memset(&mcfrs_serial_driver, 0, sizeof(struct tty_driver));
 	mcfrs_serial_driver.magic = TTY_DRIVER_MAGIC;
+	mcfrs_serial_driver.owner = THIS_MODULE;
 	mcfrs_serial_driver.name = "ttyS";
 	mcfrs_serial_driver.major = TTY_MAJOR;
 	mcfrs_serial_driver.minor_start = 64;


