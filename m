Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbSJBLAV>; Wed, 2 Oct 2002 07:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263046AbSJBLAV>; Wed, 2 Oct 2002 07:00:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263043AbSJBLAO>; Wed, 2 Oct 2002 07:00:14 -0400
Date: Wed, 2 Oct 2002 12:05:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.50 - 8250_cs does NOT work
Message-ID: <20021002120540.D24770@flint.arm.linux.org.uk>
References: <200210021257.43121.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210021257.43121.devilkin-lkml@blindguardian.org>; from devilkin-lkml@blindguardian.org on Wed, Oct 02, 2002 at 12:57:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 12:57:42PM +0200, DevilKin wrote:
> If i load the 8250_cs module, I get _nothing_ at all. No text in system logs, 
> nothing. Modem doesn't respond under the old /dev/ttyS1, I've tried all other 
> /dev/ttySx's to see if it hasn't been remapped. Unfortunately, no.
> 
> Is there anything else I can try? I really need my modem back...

Known problem.  I've sent a fix to someone else for it but iirc they
never came back.  The following patch is completely untested - I'm
still trying to get 2.5.40 to build at present.

diff -ur orig/drivers/serial/8250.c linux/drivers/serial/8250.c
--- orig/drivers/serial/8250.c	Fri Aug  2 21:13:31 2002
+++ linux/drivers/serial/8250.c	Sun Sep 29 10:37:49 2002
@@ -31,7 +31,8 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
-#include <linux/serialP.h>
+#include <linux/circ_buf.h>
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
 
@@ -1685,13 +1692,21 @@
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
+
+		if (up->port.iotype == SERIAL_IO_MEM && up->port.mapbase)
+			up->port.flags |= UPF_IOREMAP;
 	}
 }
 
diff -ur orig/drivers/serial/8250.h linux/drivers/serial/8250.h
--- orig/drivers/serial/8250.h	Sat Jul 27 13:55:21 2002
+++ linux/drivers/serial/8250.h	Sun Sep 29 10:37:32 2002
@@ -12,7 +12,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- *  $Id: 8250.h,v 1.8 2002/07/21 21:32:30 rmk Exp $
+ *  $Id: 8250.h,v 1.9 2002/07/27 12:42:16 rmk Exp $
  */
 
 #include <linux/config.h>
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
--- orig/include/linux/serial_core.h	Sun Aug 11 12:29:31 2002
+++ linux/include/linux/serial_core.h	Sun Sep 29 10:17:57 2002
@@ -17,7 +17,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
- *  $Id: serial_core.h,v 1.49 2002/07/20 18:06:32 rmk Exp $
+ *  $Id: serial_core.h,v 1.53 2002/08/02 12:55:08 rmk Exp $
  */
 
 /*
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

