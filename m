Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUHPM5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUHPM5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267608AbUHPM5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:57:22 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:64519
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267598AbUHPM5F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:57:05 -0400
Date: Mon, 16 Aug 2004 05:57:03 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Subject: [PATCH 1/2]: Serial 8250 optionally skip autodetection
Message-ID: <20040816125702.GE11621@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

Following patch allows 8250 compatible serial drivers to optionally
define the port type to allow skipping the serial port autodetection.

This is needed for OMAP serial port, which is 8250 compatible, but
requires extra FIFO settings, and does not reliably work with the
autodetection. The OMAP serial port support is in patch 2/2.

Regards,

Tony

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.8.1-8250-serial-optional-skip-autodetect"

diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2004-08-16 05:15:19 -07:00
+++ b/drivers/serial/8250.c	2004-08-16 05:15:19 -07:00
@@ -2056,6 +2056,7 @@
 {
 	struct uart_port port;
 
+	port.type     = req->type;
 	port.iobase   = req->port;
 	port.membase  = req->iomem_base;
 	port.irq      = req->irq;
@@ -2063,9 +2064,12 @@
 	port.fifosize = req->xmit_fifo_size;
 	port.regshift = req->iomem_reg_shift;
 	port.iotype   = req->io_type;
-	port.flags    = req->flags | UPF_BOOT_AUTOCONF;
+	port.flags    = req->flags;
 	port.mapbase  = req->iomap_base;
 	port.line     = line;
+
+	if (req->type != PORT_OMAP)
+		req->flags |= UPF_BOOT_AUTOCONF;
 
 	if (share_irqs)
 		port.flags |= UPF_SHARE_IRQ;
diff -Nru a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c	2004-08-16 05:15:19 -07:00
+++ b/drivers/serial/serial_core.c	2004-08-16 05:15:19 -07:00
@@ -2375,6 +2375,7 @@
 		 * If the port is already initialised, don't touch it.
 		 */
 		if (state->port->type == PORT_UNKNOWN) {
+			state->port->type     = port->type;
 			state->port->iobase   = port->iobase;
 			state->port->membase  = port->membase;
 			state->port->irq      = port->irq;

--VbJkn9YxBvnuCH5J--
