Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVCXKIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVCXKIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVCXKIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:08:43 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:10165 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263078AbVCXKIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:08:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=mB1NdMhLVKXsJqPFmnj5mGEaCkc4GDjXibDj7PDQCulg5vlxq6UlDVJ7ATmMk1cRv1jpsB3zCooTrNPcqov8A5HJO3As5VbrQKE6JAFa30ZTWlQ01ubnGEs1m4nklb1pCLYooYHXwXiX0Se4RgdLiLcn354JPcReQhbiWu0kWGI=
Message-ID: <8eca059b05032402081abeb7a3@mail.gmail.com>
Date: Thu, 24 Mar 2005 18:08:14 +0800
From: Tao Liu <liutao1980@gmail.com>
Reply-To: Tao Liu <liutao1980@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc1] drivers/net/amd8111e.c: fix NAPI interrupt in poll
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the netif_rx_complete() and rx_interrupt_enable
atomic when exiting the poll() method, so to avoid interrupt in poll.
It also fixes the rx interrupt check logic in interrupt handler.

Signed-off-by: Liu Tao <liutao1980@gmail.com>

--- linux-2.6.12-rc1-orig/drivers/net/amd8111e.c	2005-03-23
17:18:04.000000000 +0800
+++ linux-2.6.12-rc1/drivers/net/amd8111e.c	2005-03-23 17:43:57.000000000 +0800
@@ -738,6 +738,7 @@
 	short vtag;
 #endif
 	int rx_pkt_limit = dev->quota;
+	unsigned long flags;
 	
 	do{   
 		/* process receive packets until we use the quota*/
@@ -841,18 +842,19 @@
 	/* Receive descriptor is empty now */
 	dev->quota -= num_rx_pkt;
 	*budget -= num_rx_pkt;
+
+	spin_lock_irqsave(&lp->lock, flags);
 	netif_rx_complete(dev);
-	/* enable receive interrupt */
 	writel(VAL0|RINTEN0, mmio + INTEN0);
 	writel(VAL2 | RDMD0, mmio + CMD0);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	return 0;
+
 rx_not_empty:
 	/* Do not call a netif_rx_complete */
 	dev->quota -= num_rx_pkt;	
 	*budget -= num_rx_pkt;
 	return 1;
-
-	
 }
 
 #else
@@ -1261,18 +1263,20 @@
 	struct net_device * dev = (struct net_device *) dev_id;
 	struct amd8111e_priv *lp = netdev_priv(dev);
 	void __iomem *mmio = lp->mmio;
-	unsigned int intr0;
+	unsigned int intr0, intren0;
 	unsigned int handled = 1;
 
-	if(dev == NULL)
+	if(unlikely(dev == NULL))
 		return IRQ_NONE;
 
-	if (regs) spin_lock (&lp->lock);
+	spin_lock(&lp->lock);
+
 	/* disabling interrupt */
 	writel(INTREN, mmio + CMD0);
 
 	/* Read interrupt status */
 	intr0 = readl(mmio + INT0);
+	intren0 = readl(mmio + INTEN0);
 
 	/* Process all the INT event until INTR bit is clear. */
 
@@ -1293,11 +1297,11 @@
 			/* Schedule a polling routine */
 			__netif_rx_schedule(dev);
 		}
-		else {
+		else if (intren0 & RINTEN0) {
 			printk("************Driver bug! \
 				interrupt while in poll\n");
-			/* Fix by disabling interrupts */
-			writel(RINT0, mmio + INT0);
+			/* Fix by disable receive interrupts */
+			writel(RINTEN0, mmio + INTEN0);
 		}
 	}
 #else
@@ -1321,7 +1325,7 @@
 err_no_interrupt:
 	writel( VAL0 | INTREN,mmio + CMD0);
 	
-	if (regs) spin_unlock(&lp->lock);
+	spin_unlock(&lp->lock);
 	
 	return IRQ_RETVAL(handled);
 }
