Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUF1Q4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUF1Q4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUF1Q4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:56:36 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:25488 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S265088AbUF1Q4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:56:07 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Add PCDP console detection support
Date: Mon, 28 Jun 2004 10:55:55 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Matt Tolentino <matthew.e.tolentino@intel.com>,
       David Mosberger <davidm@hpl.hp.com>
References: <200406251504.50579.bjorn.helgaas@hp.com> <20040626111527.B21799@flint.arm.linux.org.uk>
In-Reply-To: <20040626111527.B21799@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406281055.55226.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 June 2004 4:15 am, Russell King wrote:
> On Fri, Jun 25, 2004 at 03:04:50PM -0600, Bjorn Helgaas wrote:
> > This moves the code from drivers/serial/8250_hcdp.[ch] to
> > drivers/firmware/pcdp.[ch], since it's no longer 8250-specific.
> > It also obsoletes CONFIG_SERIAL_8250_HCDP, replacing it with
> > CONFIG_EFI_PCDP (which defaults to Y for ia64).
> 
> I'm happy with this.  The only thing I spotted on a quick read through
> was:
> ...
> What if ioremap fails (can it fail here?)
> ...
> Should be UPIO_MEM please.  Seems I missed this in the HCDP code...
> ...
> Likewise should be UPIO_PORT please.

OK, Andrew, can you apply the following additional patch to address
the things Russell found (thanks, Russell)?

Check for ioremap failure and use correct UPIO_{MEM,PORT} constants.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/firmware/pcdp.c 1.1 vs edited =====
--- 1.1/drivers/firmware/pcdp.c	2004-06-27 11:52:01 -06:00
+++ edited/drivers/firmware/pcdp.c	2004-06-28 10:46:25 -06:00
@@ -56,6 +56,7 @@
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	struct uart_port port;
 	static char options[16];
+	int mapsize = 64;
 
 	memset(&port, 0, sizeof(port));
 	port.uartclk = uart->clock_rate;
@@ -64,11 +65,16 @@
 
 	if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 		port.mapbase = uart->addr.address;
-		port.membase = ioremap(port.mapbase, 64);
-		port.iotype = SERIAL_IO_MEM;
+		port.membase = ioremap(port.mapbase, mapsize);
+		if (!port.membase) {
+			printk(KERN_ERR "%s: couldn't ioremap 0x%lx-0x%lx\n",
+				__FUNCTION__, port.mapbase, port.mapbase + mapsize);
+			return;
+		}
+		port.iotype = UPIO_MEM;
 	} else if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		port.iobase = uart->addr.address;
-		port.iotype = SERIAL_IO_PORT;
+		port.iotype = UPIO_PORT;
 	} else
 		return;
 
@@ -102,7 +108,7 @@
 	add_preferred_console("ttyS", port.line, options);
 
 	printk(KERN_INFO "PCDP: serial console at %s 0x%lx (ttyS%d, options %s)\n",
-		port.iotype == SERIAL_IO_MEM ? "MMIO" : "I/O",
+		port.iotype == UPIO_MEM ? "MMIO" : "I/O",
 		uart->addr.address, port.line, options);
 #endif
 }
