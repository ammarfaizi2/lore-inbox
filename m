Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262475AbSJKOi7>; Fri, 11 Oct 2002 10:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262477AbSJKOi7>; Fri, 11 Oct 2002 10:38:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39684 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262475AbSJKOi5>; Fri, 11 Oct 2002 10:38:57 -0400
Date: Fri, 11 Oct 2002 15:44:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [SERIAL PATCH] updates
Message-ID: <20021011154442.D8823@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the stuff I've collected since 2.5.41; this will go to Linus in
the next day or so.  Can people please test this out.

(The serialP.h changes are especially important; my greps of the tree
show that this should be safe.  I plan to fix that up and coming
parport_serial problem with SIIG stuff without involving struct
pci_board.)

If people want to pull from me, I'm quite happy for folk to do so, but
please mail me first; the tree isn't guaranteed to have only serial
stuff in and can have stuff added at any time - it even changes use
between the times when Linus pulls from it.

Thanks.

===== include/linux/serialP.h 1.6 vs 1.7 =====
--- 1.6/include/linux/serialP.h	Tue Oct  1 09:54:49 2002
+++ 1.7/include/linux/serialP.h	Wed Oct  9 01:10:12 2002
@@ -131,6 +131,9 @@
  * Digital did something really horribly wrong with the OUT1 and OUT2
  * lines on at least some ALPHA's.  The failure mode is that if either
  * is cleared, the machine locks up with endless interrupts.
+ *
+ * This is still used by arch/mips/au1000/common/serial.c for some weird
+ * reason (mips != alpha!)
  */
 #define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
 #else
@@ -138,29 +141,8 @@
 #endif
 
 /*
- * Structures and definitions for PCI support
+ * Definitions for PCI support.
  */
-struct pci_dev;
-struct pci_board {
-	int flags;
-	int num_ports;
-	int base_baud;
-	int uart_offset;
-	int reg_shift;
-	int (*init_fn)(struct pci_dev *dev, struct pci_board *board,
-			int enable);
-	int first_uart_offset;
-};
-
-struct pci_board_inst {
-	struct pci_board	board;
-	struct pci_dev		*dev;
-};
-
-#ifndef PCI_ANY_ID
-#define PCI_ANY_ID (~0)
-#endif
-
 #define SPCI_FL_BASE_MASK	0x0007
 #define SPCI_FL_BASE0	0x0000
 #define SPCI_FL_BASE1	0x0001
===== drivers/serial/core.c 1.11 vs 1.12 =====
--- 1.11/drivers/serial/core.c	Mon Jul 29 15:52:42 2002
+++ 1.12/drivers/serial/core.c	Fri Oct 11 12:55:10 2002
@@ -1604,8 +1604,6 @@
 	return retval;
 }
 
-#ifdef CONFIG_PROC_FS
-
 static const char *uart_type(struct uart_port *port)
 {
 	const char *str = NULL;
@@ -1618,6 +1616,8 @@
 
 	return str;
 }
+
+#ifdef CONFIG_PROC_FS
 
 static int uart_line_info(char *buf, struct uart_driver *drv, int i)
 {
===== drivers/serial/8250_pci.c 1.8 vs 1.10 =====
--- 1.8/drivers/serial/8250_pci.c	Mon Jul 29 15:52:41 2002
+++ 1.10/drivers/serial/8250_pci.c	Fri Oct 11 13:00:37 2002
@@ -22,10 +22,7 @@
 #include <linux/slab.h>
 #include <linux/serial.h>
 
-/* 2.4.6 compatibility cruft - to be removed with the old serial.c code */
-#define pci_board __pci_board
 #include <linux/serialP.h>
-#undef pci_board
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
@@ -771,7 +768,8 @@
 		for (i = 0; i < priv->nr; i++)
 			unregister_serial(priv->line[i]);
 
-		priv->board->init_fn(dev, priv->board, 0);
+		if (priv->board->init_fn)
+			priv->board->init_fn(dev, priv->board, 0);
 
 		pci_disable_device(dev);
 
===== drivers/serial/8250.c 1.13 vs 1.14 =====
--- 1.13/drivers/serial/8250.c	Sun Oct  6 00:01:53 2002
+++ 1.14/drivers/serial/8250.c	Wed Oct  9 09:00:53 2002
@@ -31,8 +31,8 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
-#include <linux/serialP.h>
 #include <linux/serial.h>
+#include <linux/serialP.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
@@ -1635,7 +1635,7 @@
 	if (up->port.type != PORT_RSA && res_rsa)
 		release_resource(res_rsa);
 
-	if (up->port.type == PORT_UNKNOWN)
+	if (up->port.type == PORT_UNKNOWN && res_std)
 		release_resource(res_std);
 }
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

