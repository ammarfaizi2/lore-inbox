Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWFIOy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWFIOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWFIOy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:54:59 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:21452 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S1030187AbWFIOy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:54:58 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: serial_core: verify_port() in wrong spot?
Date: Fri, 9 Jun 2006 10:52:31 -0400
Organization: Connect Tech Inc.
Message-ID: <090301c68bd4$560c92b0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Posted yesterday to linux-serial with no response.

The OX16PCI954 UART contains a 9bit mode. I'm developing support for
it. I thought it would be easy to shoehorn into the UPF_* flags:

diff -Naurp linux-2.6.11-5-titan485/include/linux/serial_core.h linux-2.6.11-6-9bit/include/linux/serial_core.h
--- linux-2.6.11-5-titan485/include/linux/serial_core.h	2006-06-02 13:59:07.000000000 -0400
+++ linux-2.6.11-6-9bit/include/linux/serial_core.h	2006-06-07 18:11:51.000000000 -0400
@@ -219,6 +219,7 @@ struct uart_port {
 #define UPF_SKIP_TEST		(1 << 6)
 #define UPF_AUTO_IRQ		(1 << 7)
 #define UPF_HARDPPS_CD		(1 << 11)
+#define UPF_9BIT		(1 << 12)
 #define UPF_LOW_LATENCY		(1 << 13)
 #define UPF_BUGGY_UART		(1 << 14)
 #define UPF_AUTOPROBE		(1 << 15)

However, in serial_core.c:set_uart_info(), there is a problem. The
flag should be within the purview of UPF_USR_MASK so that
non-privileged users can turn it on or off, and yet, I don't want the
mode to be enabled on UARTs that don't have it which requires
verification from the low-level driver. There is only one call to
ops->verify_port(), and it's not in the correct place for this to
happen.

So, I initially thought this patch would be best:

diff -Naurp linux-2.6.11-5-titan485/drivers/serial/serial_core.c linux-2.6.11-6-9bit/drivers/serial/serial_core.c
--- linux-2.6.11-5-titan485/drivers/serial/serial_core.c	2006-06-07 16:01:44.000000000 -0400
+++ linux-2.6.11-6-9bit/drivers/serial/serial_core.c	2006-06-08 11:08:00.000000000 -0400
@@ -647,6 +647,12 @@ static int uart_set_info(struct uart_sta
 	old_flags = port->flags;
 	old_custom_divisor = port->custom_divisor;
 
+	/*
+	 * Ask the low level driver to verify the settings.
+	 */
+	if (port->ops->verify_port)
+		retval = port->ops->verify_port(port, &new_serial);
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 	if (change_irq || change_port ||
@@ -662,12 +668,6 @@ static int uart_set_info(struct uart_sta
 		goto check_and_exit;
 	}

-	/*
-	 * Ask the low level driver to verify the settings.
-	 */
-	if (port->ops->verify_port)
-		retval = port->ops->verify_port(port, &new_serial);
-
 	if ((new_serial.irq >= NR_IRQS) || (new_serial.irq < 0) ||
 	    (new_serial.baud_base < 9600))
 		retval = -EINVAL;

but I'm not sure that's not a security hole of some sort; revealing
that the setting is valid or invalid before revealing whether the user
is allowed to set it. So perhaps this is better:

diff -Naurp linux-2.6.11-5-titan485/drivers/serial/serial_core.c linux-2.6.11-6-9bit/drivers/serial/serial_core.c
--- linux-2.6.11-5-titan485/drivers/serial/serial_core.c	2006-06-07 16:01:44.000000000 -0400
+++ linux-2.6.11-6-9bit/drivers/serial/serial_core.c	2006-06-08 11:45:16.000000000 -0400
@@ -656,6 +656,14 @@ static int uart_set_info(struct uart_sta
 		    (new_serial.xmit_fifo_size != port->fifosize) ||
 		    (((new_serial.flags ^ old_flags) & ~UPF_USR_MASK) != 0))
 			goto exit;
+		/*
+		 * Ask the low level driver to verify the settings.
+		 */
+		if (port->ops->verify_port) {
+			retval = port->ops->verify_port(port, &new_serial);
+			if (retval)
+				goto exit;
+		}
 		port->flags = ((port->flags & ~UPF_USR_MASK) |
 			       (new_serial.flags & UPF_USR_MASK));
 		port->custom_divisor = new_serial.custom_divisor;

but I don't like the duplication of code.

Any thoughts?

..Stu

