Return-Path: <linux-kernel-owner+w=401wt.eu-S1161160AbXAEROS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbXAEROS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbXAEROS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:14:18 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:42402 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161160AbXAEROR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:14:17 -0500
X-Greylist: delayed 2357 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 12:14:17 EST
Date: Fri, 5 Jan 2007 16:51:44 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-kernel@vger.kernel.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: ARM i.MX serial: fix tx buffer overflows
Message-ID: <20070105155144.GD5838@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes occasional tx buffer overflows in the i.MX serial
driver which came from the fact that space in the buffer was checked
after sending the first byte. Also, fifosize is 32 bytes, not 8.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de

---
 drivers/serial/imx.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-2.6.20-rc3/drivers/serial/imx.c
===================================================================
--- linux-2.6.20-rc3.orig/drivers/serial/imx.c
+++ linux-2.6.20-rc3/drivers/serial/imx.c
@@ -154,7 +154,7 @@ static inline void imx_transmit_buffer(s
 {
 	struct circ_buf *xmit = &sport->port.info->xmit;
 
-	do {
+	while (!(UTS((u32)sport->port.membase) & UTS_TXFULL)) {
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
 		URTX0((u32)sport->port.membase) = xmit->buf[xmit->tail];
@@ -163,7 +163,7 @@ static inline void imx_transmit_buffer(s
 		sport->port.icount.tx++;
 		if (uart_circ_empty(xmit))
 			break;
-	} while (!(UTS((u32)sport->port.membase) & UTS_TXFULL));
+	}
 
 	if (uart_circ_empty(xmit))
 		imx_stop_tx(&sport->port);
@@ -178,8 +178,7 @@ static void imx_start_tx(struct uart_por
 
 	UCR1((u32)sport->port.membase) |= UCR1_TXMPTYEN;
 
-	if(UTS((u32)sport->port.membase) & UTS_TXEMPTY)
-		imx_transmit_buffer(sport);
+	imx_transmit_buffer(sport);
 }
 
 static irqreturn_t imx_rtsint(int irq, void *dev_id)
@@ -678,7 +677,7 @@ static struct imx_port imx_ports[] = {
 		.mapbase	= IMX_UART1_BASE, /* FIXME */
 		.irq		= UART1_MINT_RX,
 		.uartclk	= 16000000,
-		.fifosize	= 8,
+		.fifosize	= 32,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.ops		= &imx_pops,
 		.line		= 0,
@@ -694,7 +693,7 @@ static struct imx_port imx_ports[] = {
 		.mapbase	= IMX_UART2_BASE, /* FIXME */
 		.irq		= UART2_MINT_RX,
 		.uartclk	= 16000000,
-		.fifosize	= 8,
+		.fifosize	= 32,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.ops		= &imx_pops,
 		.line		= 1,

