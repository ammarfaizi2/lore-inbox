Return-Path: <linux-kernel-owner+willy=40w.ods.org-S283282AbUKBE2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S283282AbUKBE2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S283047AbUKBE0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:26:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:54191 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S316600AbUKBER5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:17:57 -0500
Subject: Re: [PATCH] Serial updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041031175114.B17342@flint.arm.linux.org.uk>
References: <20041031175114.B17342@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 15:09:12 +1100
Message-Id: <1099368552.29693.434.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 17:51 +0000, Russell King wrote:
> Ok, here's a major serial update.  Items covered in this update:

Applied on top of current Linus bk, I get errors

 - PCI_DEVICE_ID_DELL_RACIII undefined (not in my pci_ids.h)

 - ALPHA_KLUDGE_MCR' undeclared  (nobody includes serialP.h from 8250.h)


plus a few warnings

drivers/serial/8250.c: In function `serial8250_exit':
drivers/serial/8250.c:2446: warning: unused variable `i'
drivers/serial/8250.c: In function `register_serial':
drivers/serial/8250.c:2525: warning: long unsigned int format, different type arg (arg 2)

(Line numbers are after adding #include <linux/serialP.h>

ppc64 seem to be happy with slight changes of your ppc64 patch you sent me by email,
here's the corrected version.

I suppose we may want to increase CONFIG_SERIAL_8250_NR_UARTS in the pSeries and
maple defconfigs, but I'll look into doing that separately. The default of 4 is
enough to give ppl a working console at least.

Ben.

--- linux-work.orig/arch/ppc64/kernel/setup.c	2004-10-27 13:05:41.000000000 +1000
+++ linux-work/arch/ppc64/kernel/setup.c	2004-11-02 14:58:17.219370352 +1100
@@ -31,7 +31,7 @@
 #include <linux/cpu.h>
 #include <linux/unistd.h>
 #include <linux/serial.h>
-#include <linux/8250.h>
+#include <linux/serial_8250.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -1123,8 +1123,8 @@
  */
 
 #define MAX_LEGACY_SERIAL_PORTS	8
-static struct old_serial_port	old_serial_ports[MAX_LEGACY_SERIAL_PORTS];
-static unsigned int		old_serial_count;
+static struct plat_serial8250_port serial_ports[MAX_LEGACY_SERIAL_PORTS+1];
+static unsigned int old_serial_count;
 
 void __init generic_find_legacy_serial_ports(unsigned int *default_speed)
 {
@@ -1202,13 +1202,13 @@
 			if (index >= old_serial_count)
 				old_serial_count = index + 1;
 			/* Check if there is a port who already claimed our slot */
-			if (old_serial_ports[index].port != 0) {
+			if (serial_ports[index].iobase != 0) {
 				/* if we still have some room, move it, else override */
 				if (old_serial_count < MAX_LEGACY_SERIAL_PORTS) {
 					DBG("Moved legacy port %d -> %d\n", index,
 					    old_serial_count);
-					old_serial_ports[old_serial_count++] =
-						old_serial_ports[index];
+					serial_ports[old_serial_count++] =
+						serial_ports[index];
 				} else {
 					DBG("Replacing legacy port %d\n", index);
 				}
@@ -1220,18 +1220,17 @@
 			old_serial_count = index + 1;
 
 		/* Now fill the entry */
-		memset(&old_serial_ports[index], 0, sizeof(struct old_serial_port));
-		old_serial_ports[index].uart = 0;
-		old_serial_ports[index].baud_base = clk ? (*clk / 16) : BASE_BAUD;
-		old_serial_ports[index].port = reg->address;
-		old_serial_ports[index].irq = interrupts ? interrupts[0] : 0;
-		old_serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
+		memset(&serial_ports[index], 0, sizeof(struct plat_serial8250_port));
+		serial_ports[index].uartclk = clk ? *clk : BASE_BAUD * 16;
+		serial_ports[index].iobase = reg->address;
+		serial_ports[index].irq = interrupts ? interrupts[0] : 0;
+		serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
 
 		DBG("Added legacy port, index: %d, port: %x, irq: %d, clk: %d\n",
 		    index,
-		    old_serial_ports[index].port,
-		    old_serial_ports[index].irq,
-		    old_serial_ports[index].baud_base * 16);
+		    serial_ports[index].iobase,
+		    serial_ports[index].irq,
+		    serial_ports[index].uartclk);
 
 		/* Get phys address of IO reg for port 1 */
 		if (index != 0)
@@ -1279,19 +1278,21 @@
 	DBG(" <- generic_find_legacy_serial_port()\n");
 }
 
-struct old_serial_port *get_legacy_serial_ports(unsigned int *count)
-{
-	*count = old_serial_count;
-	return old_serial_ports;
-}
-#else
-struct old_serial_port *get_legacy_serial_ports(unsigned int *count)
+static struct platform_device serial_device = {
+	.name	= "serial8250",
+	.id	= 0,
+	.dev	= {
+		.platform_data = serial_ports,
+	},
+};
+
+static int __init serial_dev_init(void)
 {
-	*count = 0;
-	return 0;
+	return platform_device_register(&serial_device);
 }
+arch_initcall(serial_dev_init);
+
 #endif /* CONFIG_PPC_ISERIES */
-EXPORT_SYMBOL(get_legacy_serial_ports);
 
 int check_legacy_ioport(unsigned long base_port)
 {
Index: linux-work/include/asm-ppc64/serial.h
===================================================================
--- linux-work.orig/include/asm-ppc64/serial.h	2004-10-26 08:30:21.000000000 +1000
+++ linux-work/include/asm-ppc64/serial.h	2004-11-02 14:51:17.486179496 +1100
@@ -4,8 +4,6 @@
 #ifndef _PPC64_SERIAL_H
 #define _PPC64_SERIAL_H
 
-#include <linux/config.h>
-
 /*
  * This assumes you have a 1.8432 MHz clock for your UART.
  *
@@ -22,9 +20,4 @@
 /* Default baud base if not found in device-tree */
 #define BASE_BAUD ( 1843200 / 16 )
 
-#define ARCH_HAS_GET_LEGACY_SERIAL_PORTS
-struct old_serial_port;
-extern struct old_serial_port *get_legacy_serial_ports(unsigned int *count);
-#define UART_NR	(8 + CONFIG_SERIAL_8250_NR_UARTS)
-
 #endif /* _PPC64_SERIAL_H */


