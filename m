Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVK3LOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVK3LOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK3LOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:14:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:11496 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751158AbVK3LOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:14:23 -0500
Message-ID: <438D8A3A.9030400@in.ibm.com>
Date: Wed, 30 Nov 2005 16:47:14 +0530
From: Sachin Sant <sachinp@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: ssant@in.ibm.com
Subject: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Content-Type: multipart/mixed;
 boundary="------------030509040805090403010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030509040805090403010806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch will allow a user to use sysrq keys over a serial 
console using the ctrl-o key sequence. This is similar to functionality 
provided by the hvc console drivers on PPC boxes.



--------------030509040805090403010806
Content-Type: text/plain;
 name="8250-magic-sysrq-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250-magic-sysrq-support.patch"

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>

diff -Naurp linux-2.6.14.3/drivers/serial/8250.c linux-2.6.14.3-new/drivers/serial/8250.c
--- linux-2.6.14.3/drivers/serial/8250.c	2005-11-11 11:03:12.000000000 +0530
+++ linux-2.6.14.3-new/drivers/serial/8250.c	2005-11-17 15:12:42.000000000 +0530
@@ -1084,6 +1084,23 @@ receive_chars(struct uart_8250_port *up,
 			 */
 		}
 		ch = serial_inp(up, UART_RX);
+
+#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
+		/* Handle the SysRq ^O Hack */
+		if (ch == '\x0f') {
+			up->port.sysrq = jiffies + HZ*5;
+			goto ignore_char; 
+		}
+		if (up->port.sysrq) {
+			int swallow;
+			spin_unlock(&up->port.lock);
+			swallow = uart_handle_sysrq_char(&up->port, ch, regs);
+			spin_lock(&up->port.lock);
+			if (swallow)
+				goto ignore_char;
+		}
+#endif /* CONFIG_MAGIC_SYSRQ && CONFIG_SERIAL_CORE_CONSOLE */
+
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 

--------------030509040805090403010806--
