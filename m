Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262816AbSJEXmI>; Sat, 5 Oct 2002 19:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262818AbSJEXmI>; Sat, 5 Oct 2002 19:42:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56333 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262816AbSJEXmD>; Sat, 5 Oct 2002 19:42:03 -0400
Date: Sun, 6 Oct 2002 00:47:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.4] Serial updates
Message-ID: <20021006004737.E1682@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just asked Linus to integrate the following into his tree.  This
patch has appeared on lkml in the past (but this version fixes the
includes correctly.)

There are a couple of issues outstanding:

 - reduced performance (maybe)
 - OX16950 detection causing Oxford 950 port to be non-functional

 drivers/serial/8250.c       |   54 ++++++++++++++++++++++++++------------------
 drivers/serial/8250.h       |    5 +++-
 include/linux/serial_core.h |    2 +
 3 files changed, 39 insertions, 22 deletions

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.737   -> 1.739  
#	drivers/serial/8250.h	1.4     -> 1.5    
#	drivers/serial/8250.c	1.11    -> 1.13   
#	include/linux/serial_core.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/05	rmk@flint.arm.linux.org.uk	1.738
# [SERIAL] Allow PCMCIA serial cards to work again.
# The PCMCIA layer claims the IO or memory regions for all cards.  This
# means that any port registered via 8250_cs must not cause the 8250
# code to claim the resources itself.
# 
# We also add support for iomem-based ports at initialisation time for
# PPC.
# --------------------------------------------
# 02/10/06	rmk@flint.arm.linux.org.uk	1.739
# [SERIAL] Fix serial includes for modversions/modules.
# This fixes the build error that occurs if you have a certain selection
# of module/modversions settings.
# --------------------------------------------
#
diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	Sun Oct  6 00:22:07 2002
+++ b/drivers/serial/8250.c	Sun Oct  6 00:22:07 2002
@@ -32,6 +32,7 @@
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
 #include <linux/serialP.h>
+#include <linux/serial.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
@@ -1560,21 +1561,22 @@
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	struct resource *res = NULL, *res_rsa = NULL;
-	int ret = -EBUSY;
+	int ret = 0;
 
-	if (up->port.type == PORT_RSA) {
-		ret = serial8250_request_rsa_resource(up, &res_rsa);
-		if (ret)
-			return ret;
-	}
+	if (up->port.flags & UPF_RESOURCES) {
+		if (up->port.type == PORT_RSA) {
+			ret = serial8250_request_rsa_resource(up, &res_rsa);
+			if (ret)
+				return ret;
+		}
 
-	ret = serial8250_request_std_resource(up, &res);
+		ret = serial8250_request_std_resource(up, &res);
+	}
 
 	/*
 	 * If we have a mapbase, then request that as well.
 	 */
-	if (res != NULL && up->port.iotype == SERIAL_IO_MEM &&
-	    up->port.mapbase) {
+	if (ret == 0 && up->port.flags & UPF_IOREMAP) {
 		int size = res->end - res->start + 1;
 
 		up->port.membase = ioremap(up->port.mapbase, size);
@@ -1610,13 +1612,17 @@
 	 * Find the region that we can probe for.  This in turn
 	 * tells us whether we can probe for the type of port.
 	 */
-	ret = serial8250_request_std_resource(up, &res_std);
-	if (ret)
-		return;
+	if (up->port.flags & UPF_RESOURCES) {
+		ret = serial8250_request_std_resource(up, &res_std);
+		if (ret)
+			return;
 
-	ret = serial8250_request_rsa_resource(up, &res_rsa);
-	if (ret)
+		ret = serial8250_request_rsa_resource(up, &res_rsa);
+		if (ret)
+			probeflags &= ~PROBE_RSA;
+	} else {
 		probeflags &= ~PROBE_RSA;
+	}
 
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up, probeflags);
@@ -1678,6 +1684,7 @@
 
 static void __init serial8250_isa_init_ports(void)
 {
+	struct uart_8250_port *up;
 	static int first = 1;
 	int i;
 
@@ -1685,13 +1692,18 @@
 		return;
 	first = 0;
 
-	for (i = 0; i < ARRAY_SIZE(old_serial_port); i++) {
-		serial8250_ports[i].port.iobase  = old_serial_port[i].port;
-		serial8250_ports[i].port.irq     = irq_cannonicalize(old_serial_port[i].irq);
-		serial8250_ports[i].port.uartclk = old_serial_port[i].base_baud * 16;
-		serial8250_ports[i].port.flags   = old_serial_port[i].flags;
-		serial8250_ports[i].port.hub6    = old_serial_port[i].hub6;
-		serial8250_ports[i].port.ops     = &serial8250_pops;
+	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
+	     i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_cannonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base * 16;
+		up->port.flags    = old_serial_port[i].flags |
+				    UPF_RESOURCES;
+		up->port.hub6     = old_serial_port[i].hub6;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		up->port.ops      = &serial8250_pops;
 	}
 }
 
diff -Nru a/drivers/serial/8250.h b/drivers/serial/8250.h
--- a/drivers/serial/8250.h	Sun Oct  6 00:22:07 2002
+++ b/drivers/serial/8250.h	Sun Oct  6 00:22:07 2002
@@ -30,11 +30,14 @@
 
 struct old_serial_port {
 	unsigned int uart;
-	unsigned int base_baud;
+	unsigned int baud_base;
 	unsigned int port;
 	unsigned int irq;
 	unsigned int flags;
 	unsigned char hub6;
+	unsigned char io_type;
+	unsigned char *iomem_base;
+	unsigned short iomem_reg_shift;
 };
 
 #undef SERIAL_DEBUG_PCI
diff -Nru a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h	Sun Oct  6 00:22:07 2002
+++ b/include/linux/serial_core.h	Sun Oct  6 00:22:07 2002
@@ -168,6 +168,8 @@
 #define UPF_BUGGY_UART		(1 << 14)
 #define UPF_AUTOPROBE		(1 << 15)
 #define UPF_BOOT_AUTOCONF	(1 << 28)
+#define UPF_RESOURCES		(1 << 30)
+#define UPF_IOREMAP		(1 << 31)
 
 #define UPF_FLAGS		(0x7fff)
 #define UPF_USR_MASK		(UPF_SPD_MASK|UPF_LOW_LATENCY)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

