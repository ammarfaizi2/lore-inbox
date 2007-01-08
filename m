Return-Path: <linux-kernel-owner+w=401wt.eu-S1751581AbXAHPM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXAHPM6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbXAHPM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:12:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41692 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751580AbXAHPM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:12:57 -0500
Date: Mon, 8 Jan 2007 15:23:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] z85230: spinlock logic
Message-ID: <20070108152343.40f1ee97@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point someone added a spin_lock(&dev->lock) to the IRQ handler
for the Z85230 driver. This actually correctly fixes a bug but the
neccessary changes to remove the chan->lock calls in the event handlers
were not made (c->lock is the same lock).

Simona Dascenzo reported the problem with the driver and this patch should
fix the problem he found.



--- linux.vanilla-2.6.20-rc4/drivers/net/wan/z85230.c	2007-01-01 21:41:27.000000000 +0000
+++ linux-2.6.20-rc4/drivers/net/wan/z85230.c	2007-01-08 14:50:15.860939112 +0000
@@ -331,8 +331,7 @@
 static void z8530_rx(struct z8530_channel *c)
 {
 	u8 ch,stat;
-	spin_lock(c->lock);
- 
+
 	while(1)
 	{
 		/* FIFO empty ? */
@@ -390,7 +389,6 @@
 	 */
 	write_zsctrl(c, ERR_RES);
 	write_zsctrl(c, RES_H_IUS);
-	spin_unlock(c->lock);
 }
 
 
@@ -406,7 +404,6 @@
  
 static void z8530_tx(struct z8530_channel *c)
 {
-	spin_lock(c->lock);
 	while(c->txcount) {
 		/* FIFO full ? */
 		if(!(read_zsreg(c, R0)&4))
@@ -434,7 +431,6 @@
 
 	z8530_tx_done(c);	 
 	write_zsctrl(c, RES_H_IUS);
-	spin_unlock(c->lock);
 }
 
 /**
@@ -452,7 +448,6 @@
 {
 	u8 status, altered;
 
-	spin_lock(chan->lock);
 	status=read_zsreg(chan, R0);
 	altered=chan->status^status;
 	
@@ -487,7 +482,6 @@
 	}	
 	write_zsctrl(chan, RES_EXT_INT);
 	write_zsctrl(chan, RES_H_IUS);
-	spin_unlock(chan->lock);
 }
 
 struct z8530_irqhandler z8530_sync=
@@ -511,7 +505,6 @@
  
 static void z8530_dma_rx(struct z8530_channel *chan)
 {
-	spin_lock(chan->lock);
 	if(chan->rxdma_on)
 	{
 		/* Special condition check only */
@@ -534,7 +527,6 @@
 		/* DMA is off right now, drain the slow way */
 		z8530_rx(chan);
 	}	
-	spin_unlock(chan->lock);
 }
 
 /**
@@ -547,7 +539,6 @@
  
 static void z8530_dma_tx(struct z8530_channel *chan)
 {
-	spin_lock(chan->lock);
 	if(!chan->dma_tx)
 	{
 		printk(KERN_WARNING "Hey who turned the DMA off?\n");
@@ -557,7 +548,6 @@
 	/* This shouldnt occur in DMA mode */
 	printk(KERN_ERR "DMA tx - bogus event!\n");
 	z8530_tx(chan);
-	spin_unlock(chan->lock);
 }
 
 /**
@@ -596,7 +586,6 @@
 		}
 	}
 
-	spin_lock(chan->lock);
 	if(altered&chan->dcdcheck)
 	{
 		if(status&chan->dcdcheck)
@@ -618,7 +607,6 @@
 
 	write_zsctrl(chan, RES_EXT_INT);
 	write_zsctrl(chan, RES_H_IUS);
-	spin_unlock(chan->lock);
 }
 
 struct z8530_irqhandler z8530_dma_sync=
 
