Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVCJWv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVCJWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbVCJWsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:48:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33808 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263408AbVCJWnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:43:49 -0500
Date: Thu, 10 Mar 2005 22:43:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Karol Kozimor <sziwan@hell.org.pl>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/serial/8250.c:1256!
Message-ID: <20050310224342.D1044@flint.arm.linux.org.uk>
Mail-Followup-To: Karol Kozimor <sziwan@hell.org.pl>,
	linux-kernel@vger.kernel.org
References: <20050301230946.GA30841@hell.org.pl> <20050301233720.B17470@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050301233720.B17470@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Mar 01, 2005 at 11:37:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 11:37:20PM +0000, Russell King wrote:
> On Wed, Mar 02, 2005 at 12:09:46AM +0100, Karol Kozimor wrote:
> > I've finally got around to test latest kernels and managed to find a bug in 
> > the serial subsystem, which happens during suspend.
> 
> Yes, serial_cs is claiming that we don't have a device associated with
> the port, so we're treating it as a legacy port.  However, serial_cs is
> implementing the suspend/resume methods.  This is wrong, since that
> means the port will be suspended twice, and hence causes this bug.

Ok, here's the patch.  Please test and let me know if it resolves your
problem.  Thanks.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/serial_cs.c linux/drivers/serial/serial_cs.c
--- orig/drivers/serial/serial_cs.c	Sun Feb  6 11:38:41 2005
+++ linux/drivers/serial/serial_cs.c	Sat Mar  5 14:09:53 2005
@@ -289,7 +289,8 @@ static void serial_detach(dev_link_t * l
 
 /*====================================================================*/
 
-static int setup_serial(struct serial_info * info, kio_addr_t iobase, int irq)
+static int setup_serial(client_handle_t handle, struct serial_info * info,
+			kio_addr_t iobase, int irq)
 {
 	struct uart_port port;
 	int line;
@@ -299,6 +300,7 @@ static int setup_serial(struct serial_in
 	port.irq = irq;
 	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
 	port.uartclk = 1843200;
+	port.dev = &handle_to_dev(handle);
 	if (buggy_uart)
 		port.flags |= UPF_BUGGY_UART;
 	line = serial8250_register_port(&port);
@@ -376,7 +378,7 @@ static int simple_config(dev_link_t *lin
 			info->slave = 1;
 		}
 		if (info->slave)
-			return setup_serial(info, port, config.AssignedIRQ);
+			return setup_serial(handle, info, port, config.AssignedIRQ);
 	}
 	link->conf.Vcc = config.Vcc;
 
@@ -451,7 +453,7 @@ next_entry:
 		return -1;
 	}
 
-	return setup_serial(info, link->io.BasePort1, link->irq.AssignedIRQ);
+	return setup_serial(handle, info, link->io.BasePort1, link->irq.AssignedIRQ);
 }
 
 static int multi_config(dev_link_t * link)
@@ -546,21 +548,21 @@ static int multi_config(dev_link_t * lin
 	   8 registers are for the UART, the others are extra registers */
 	if (info->manfid == MANFID_OXSEMI) {
 		if (cf->index == 1 || cf->index == 3) {
-			setup_serial(info, base2, link->irq.AssignedIRQ);
+			setup_serial(handle, info, base2, link->irq.AssignedIRQ);
 			outb(12, link->io.BasePort1 + 1);
 		} else {
-			setup_serial(info, link->io.BasePort1, link->irq.AssignedIRQ);
+			setup_serial(handle, info, link->io.BasePort1, link->irq.AssignedIRQ);
 			outb(12, base2 + 1);
 		}
 		return 0;
 	}
 
-	setup_serial(info, link->io.BasePort1, link->irq.AssignedIRQ);
+	setup_serial(handle, info, link->io.BasePort1, link->irq.AssignedIRQ);
 	/* The Nokia cards are not really multiport cards */
 	if (info->manfid == MANFID_NOKIA)
 		return 0;
 	for (i = 0; i < info->multi - 1; i++)
-		setup_serial(info, base2 + (8 * i), link->irq.AssignedIRQ);
+		setup_serial(handle, info, base2 + (8 * i), link->irq.AssignedIRQ);
 
 	return 0;
 }


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
