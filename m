Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUESPKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUESPKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUESPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:10:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18363 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264236AbUESPKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:10:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] implement TIOCGSERIAL in sn_serial.c
Date: Wed, 19 May 2004 11:09:51 -0400
User-Agent: KMail/1.6.2
Cc: pfg@sgi.com, Erik Jacobson <erikj@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/i3qA+BHQMG2njU"
Message-Id: <200405191109.51751.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/i3qA+BHQMG2njU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The sn2 console driver behaves something like a serial port, but was missing 
some of the ioctls that userland apps expected.  This patch implements the 
TIOCGSERIAL ioctl, which allows applications to identify the console as a 
serial port.

Jesse

--Boundary-00=_/i3qA+BHQMG2njU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sn-serial-ioctl-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sn-serial-ioctl-3.patch"

--- linux-2.6.6.orig/drivers/char/sn_serial.c	2004-05-09 22:33:21.000000000 -0400
+++ linux-2.6.6/drivers/char/sn_serial.c	2004-05-19 10:59:20.000000000 -0400
@@ -21,6 +21,7 @@
 #include <linux/sysrq.h>
 #include <linux/circ_buf.h>
 #include <linux/serial_reg.h>
+#include <linux/serial_core.h>
 #include <asm/uaccess.h>
 #include <asm/sn/sgi.h>
 #include <asm/sn/sn_sal.h>
@@ -38,7 +39,7 @@ static unsigned long sysrq_requested;
 #define SN_SAL_MINOR 64
 
 /* number of characters left in xmit buffer before we ask for more */
-#define WAKEUP_CHARS 128
+#define SN_WAKEUP_CHARS 128
 
 /* number of characters we can transmit to the SAL console at a time */
 #define SN_SAL_MAX_CHARS 120
@@ -411,7 +412,7 @@ sn_poll_transmit_chars(void)
 	 * that we could stand for the upper layer to send us some
 	 * more, ask for it. */
 	if (sn_sal_tty)
-		if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) < WAKEUP_CHARS)
+		if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) < SN_WAKEUP_CHARS)
 			sn_sal_sched_event(SN_SAL_EVENT_WRITE_WAKEUP);
 }
 
@@ -466,7 +467,7 @@ sn_intr_transmit_chars(void)
 	 * that we could stand for the upper layer to send us some
 	 * more, ask for it. */
 	if (sn_sal_tty)
-		if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) < WAKEUP_CHARS)
+		if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) < SN_WAKEUP_CHARS)
 			sn_sal_sched_event(SN_SAL_EVENT_WRITE_WAKEUP);
 }
 
@@ -784,6 +785,29 @@ sn_sal_read_proc(char *page, char **star
 	return count < begin+len-off ? count : begin+len-off;
 }
 
+/*
+ * sn_sal_ioctl - we only support a very limited TIOCGSERIAL
+ */
+static int
+sn_sal_ioctl(struct tty_struct *tty, struct file *filp, unsigned int cmd,
+	     unsigned long arg)
+{
+	struct serial_struct tmp_serial;
+	struct serial_struct *force_cast_serial;
+
+	force_cast_serial = (struct serial_struct *)arg;
+
+	memset(&tmp_serial, 0, sizeof(tmp_serial));
+	tmp_serial.irq = sn_sal_irq;
+	tmp_serial.xmit_fifo_size = SN_SAL_UART_FIFO_DEPTH;
+
+	if (cmd == TIOCGSERIAL) {
+		if (copy_to_user(force_cast_serial, &tmp_serial, sizeof(*force_cast_serial)))
+			return -EFAULT;
+		return 0;
+	}
+	return -ENOIOCTLCMD;
+}
 
 static struct tty_operations sn_sal_driver_ops = {
 	.open		 = sn_sal_open,
@@ -796,6 +820,7 @@ static struct tty_operations sn_sal_driv
 	.hangup		 = sn_sal_hangup,
 	.wait_until_sent = sn_sal_wait_until_sent,
 	.read_proc	 = sn_sal_read_proc,
+	.ioctl		 = sn_sal_ioctl,
 };
 static struct tty_driver *sn_sal_driver;
 

--Boundary-00=_/i3qA+BHQMG2njU--
