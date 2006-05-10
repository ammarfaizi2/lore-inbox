Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWEJSIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEJSIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWEJSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:08:36 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:38732 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932440AbWEJSIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:08:35 -0400
Date: Wed, 10 May 2006 11:08:32 -0700
From: Dave Jiang <djiang@mvista.com>
To: linux-kernel@vger.kernel.org, mgreer@mvista.com, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] MPSC serial driver tx locking
Message-ID: <20060510180832.GA6920@blade.az.mvista.com>
References: <20060510003552.GB22447@blade.az.mvista.com> <20060510162708.GD32632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510162708.GD32632@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 05:27:08PM +0100, Russell King wrote:
> 
> Why not do the spinlock initialisation first?
> 

Patch repost per Russell's suggestion

---

The MPSC serial driver assumes that interrupt is always on to pick up the
DMA transmit ops that aren't submitted while the DMA engine is active. However
when irqs are off for a period of time such as operations under kernel crash
dump console messages do not show up due to additional DMA ops are being
dropped. This makes console writes to process through all the tx DMAs queued
up before submitting a new request.

Also, the current locking mechanism does not protect the hardware registers
and ring buffer when a printk is done during the serial write operations 
since console_write does not both with locking while mucking with the DMA 
regs and ring buffer. The additional per port transmit lock provides a 
finer granular locking and protects registers being clobbered while 
printks are nested within uart writes. 

Signed-off-by: Dave Jiang <djiang@mvista.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

diff -Naurp linux-2.6.17-rc3-mm1/drivers/serial/mpsc.c linux-2.6.17-rc3-mm1.mod/drivers/serial/mpsc.c
--- linux-2.6.17-rc3-mm1/drivers/serial/mpsc.c	2006-05-05 09:56:15.000000000 -0700
+++ linux-2.6.17-rc3-mm1.mod/drivers/serial/mpsc.c	2006-05-10 09:56:29.533084808 -0700
@@ -184,6 +184,7 @@ struct mpsc_port_info {
 	u8 *txb_p;		/* Phys addr of txb */
 	int txr_head;		/* Where new data goes */
 	int txr_tail;		/* Where sent data comes off */
+	spinlock_t tx_lock;	/* transmit lock */
 
 	/* Mirrored values of regs we can't read (if 'mirror_regs' set) */
 	u32 MPSC_MPCR_m;
@@ -1213,6 +1214,9 @@ mpsc_tx_intr(struct mpsc_port_info *pi)
 {
 	struct mpsc_tx_desc *txre;
 	int rc = 0;
+	unsigned long iflags;
+
+	spin_lock_irqsave(&pi->tx_lock, iflags);
 
 	if (!mpsc_sdma_tx_active(pi)) {
 		txre = (struct mpsc_tx_desc *)(pi->txr +
@@ -1249,6 +1253,7 @@ mpsc_tx_intr(struct mpsc_port_info *pi)
 		mpsc_sdma_start_tx(pi);	/* start next desc if ready */
 	}
 
+	spin_unlock_irqrestore(&pi->tx_lock, iflags);
 	return rc;
 }
 
@@ -1339,11 +1344,16 @@ static void
 mpsc_start_tx(struct uart_port *port)
 {
 	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	unsigned long iflags;
+
+	spin_lock_irqsave(&pi->tx_lock, iflags);
 
 	mpsc_unfreeze(pi);
 	mpsc_copy_tx_data(pi);
 	mpsc_sdma_start_tx(pi);
 
+	spin_unlock_irqrestore(&pi->tx_lock, iflags);
+
 	pr_debug("mpsc_start_tx[%d]\n", port->line);
 	return;
 }
@@ -1626,6 +1636,16 @@ mpsc_console_write(struct console *co, c
 	struct mpsc_port_info *pi = &mpsc_ports[co->index];
 	u8 *bp, *dp, add_cr = 0;
 	int i;
+	unsigned long iflags;
+
+	spin_lock_irqsave(&pi->tx_lock, iflags);
+
+	while (pi->txr_head != pi->txr_tail) {
+		while (mpsc_sdma_tx_active(pi))
+			udelay(100);
+		mpsc_sdma_intr_ack(pi);
+		mpsc_tx_intr(pi);
+	}
 
 	while (mpsc_sdma_tx_active(pi))
 		udelay(100);
@@ -1669,6 +1689,7 @@ mpsc_console_write(struct console *co, c
 		pi->txr_tail = (pi->txr_tail + 1) & (MPSC_TXR_ENTRIES - 1);
 	}
 
+	spin_unlock_irqrestore(&pi->tx_lock, iflags);
 	return;
 }
 
@@ -1994,15 +2015,15 @@ mpsc_drv_probe(struct platform_device *d
 		if (!(rc = mpsc_drv_map_regs(pi, dev))) {
 			mpsc_drv_get_platform_data(pi, dev, dev->id);
 
-			if (!(rc = mpsc_make_ready(pi)))
-				if (!(rc = uart_add_one_port(&mpsc_reg,
-					&pi->port)))
-					rc = 0;
-				else {
+			if (!(rc = mpsc_make_ready(pi))) {
+				spin_lock_init(&pi->tx_lock);
+				if (rc = uart_add_one_port(&mpsc_reg,
+					&pi->port)) {
 					mpsc_release_port(
 						(struct uart_port *)pi);
 					mpsc_drv_unmap_regs(pi);
 				}
+			}
 			else
 				mpsc_drv_unmap_regs(pi);
 		}
-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.    
http://www.mvista.com
------------------------------------------------------

