Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUF1SEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUF1SEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUF1SEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:04:44 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:23054 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S265108AbUF1SEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:04:37 -0400
Message-ID: <40E05EF1.2070505@hp.com>
Date: Mon, 28 Jun 2004 14:09:53 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64 kgdb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew:

This fixes the broken kgdb patch.

thanks,

Bob

Signed-off-by: Bob Picco at Robert.Picco@hp.com

diff -ruN -X /home/picco/losl/dontdiff linux-2.6.7-mm3-orig/drivers/firmware/pcdp.c linux-2.6.7-mm3-kgdb/drivers/firmware/pcdp.c
--- linux-2.6.7-mm3-orig/drivers/firmware/pcdp.c	2004-06-27 13:32:37.000000000 -0400
+++ linux-2.6.7-mm3-kgdb/drivers/firmware/pcdp.c	2004-06-28 10:16:15.000000000 -0400
@@ -51,13 +51,20 @@
 }
 
 static void __init
+#ifndef	CONFIG_KGDB_EARLY
 setup_serial_console(int rev, struct pcdp_uart *uart)
+#else
+setup_serial_console(int rev, struct pcdp_uart *uart, int line)
+#endif
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	struct uart_port port;
 	static char options[16];
 
 	memset(&port, 0, sizeof(port));
+#ifdef	CONFIG_KGDB_EARLY
+	port.line = line;
+#endif
 	port.uartclk = uart->clock_rate;
 	if (!port.uartclk)	/* some FW doesn't supply this */
 		port.uartclk = BASE_BAUD * 16;
@@ -99,6 +106,9 @@
 
 	snprintf(options, sizeof(options), "%lun%d", uart->baud,
 		uart->bits ? uart->bits : 8);
+#ifdef	CONFIG_KGDB_EARLY
+	if (!line)
+#endif
 	add_preferred_console("ttyS", port.line, options);
 
 	printk(KERN_INFO "PCDP: serial console at %s 0x%lx (ttyS%d, options %s)\n",
@@ -145,10 +155,19 @@
 	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
 		if (uart->flags & PCDP_UART_PRIMARY_CONSOLE || serial) {
 			if (uart->type == PCDP_CONSOLE_UART) {
+#ifndef	CONFIG_KGDB_EARLY
 				setup_serial_console(pcdp->rev, uart);
 				return;
+#else
+				setup_serial_console(pcdp->rev, uart, 0);
+				serial = 0;
+#endif
 			}
 		}
+#ifdef	CONFIG_KGDB_EARLY
+		else if (uart->type == PCDP_DEBUG_UART)
+				setup_serial_console(pcdp->rev, uart, 1);
+#endif
 	}
 
 	end = (struct pcdp_device *) ((u8 *) pcdp + pcdp->length);





