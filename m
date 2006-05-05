Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWEEQqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWEEQqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWEEQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:46:17 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:34948 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751649AbWEEQox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:53 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <8.420169009@selenic.com>
Subject: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Date: Fri, 05 May 2006 11:42:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SA_SAMPLE_RANDOM from network drivers

/dev/random wants entropy sources to be both unpredictable and
unobservable. Network devices are neither as they may be directly
observed and controlled by an attacker. Thus SA_SAMPLE_RANDOM is not
appropriate.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/net/3c523.c
===================================================================
--- 2.6.orig/drivers/net/3c523.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/3c523.c	2006-05-02 18:37:00.000000000 -0500
@@ -289,8 +289,7 @@ static int elmc_open(struct net_device *
 
 	elmc_id_attn586();	/* disable interrupts */
 
-	ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM,
-			  dev->name, dev);
+	ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ, dev->name, dev);
 	if (ret) {
 		printk(KERN_ERR "%s: couldn't get irq %d\n", dev->name, dev->irq);
 		elmc_id_reset586();
Index: 2.6/drivers/net/3c527.c
===================================================================
--- 2.6.orig/drivers/net/3c527.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/3c527.c	2006-05-02 18:37:00.000000000 -0500
@@ -435,7 +435,7 @@ static int __init mc32_probe1(struct net
 	 *	Grab the IRQ
 	 */
 
-	err = request_irq(dev->irq, &mc32_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM, DRV_NAME, dev);
+	err = request_irq(dev->irq, &mc32_interrupt, SA_SHIRQ, DRV_NAME, dev);
 	if (err) {
 		release_region(dev->base_addr, MC32_IO_EXTENT);
 		printk(KERN_ERR "%s: unable to get IRQ %d.\n", DRV_NAME, dev->irq);
Index: 2.6/drivers/net/ibmlana.c
===================================================================
--- 2.6.orig/drivers/net/ibmlana.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/ibmlana.c	2006-05-02 18:37:00.000000000 -0500
@@ -782,7 +782,8 @@ static int ibmlana_open(struct net_devic
 
 	/* register resources - only necessary for IRQ */
 
-	result = request_irq(priv->realirq, irq_handler, SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+	result = request_irq(priv->realirq, irq_handler,
+			     SA_SHIRQ, dev->name, dev);
 	if (result != 0) {
 		printk(KERN_ERR "%s: failed to register irq %d\n", dev->name, dev->irq);
 		return result;
Index: 2.6/drivers/net/ixgb/ixgb_main.c
===================================================================
--- 2.6.orig/drivers/net/ixgb/ixgb_main.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/ixgb/ixgb_main.c	2006-05-02 18:37:00.000000000 -0500
@@ -258,8 +258,7 @@ ixgb_up(struct ixgb_adapter *adapter)
 
 #endif
 	if((err = request_irq(adapter->pdev->irq, &ixgb_intr,
-				  SA_SHIRQ | SA_SAMPLE_RANDOM,
-				  netdev->name, netdev)))
+			      SA_SHIRQ, netdev->name, netdev)))
 		return err;
 
 	/* disable interrupts and get the hardware into a known state */
Index: 2.6/drivers/net/mv643xx_eth.c
===================================================================
--- 2.6.orig/drivers/net/mv643xx_eth.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/mv643xx_eth.c	2006-05-02 18:37:00.000000000 -0500
@@ -778,7 +778,7 @@ static int mv643xx_eth_open(struct net_d
 	int err;
 
 	err = request_irq(dev->irq, mv643xx_eth_int_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+			SA_SHIRQ, dev->name, dev);
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
 								port_num);
Index: 2.6/drivers/net/sk_mca.c
===================================================================
--- 2.6.orig/drivers/net/sk_mca.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/sk_mca.c	2006-05-02 18:37:00.000000000 -0500
@@ -824,7 +824,7 @@ static int skmca_open(struct net_device 
 	/* register resources - only necessary for IRQ */
 	result =
 	    request_irq(priv->realirq, irq_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, "sk_mca", dev);
+			SA_SHIRQ, "sk_mca", dev);
 	if (result != 0) {
 		printk("%s: failed to register irq %d\n", dev->name,
 		       dev->irq);
Index: 2.6/drivers/net/tg3.c
===================================================================
--- 2.6.orig/drivers/net/tg3.c	2006-05-02 18:36:54.000000000 -0500
+++ 2.6/drivers/net/tg3.c	2006-05-02 18:37:00.000000000 -0500
@@ -6602,12 +6602,12 @@ static int tg3_request_irq(struct tg3 *t
 		fn = tg3_msi;
 		if (tp->tg3_flags2 & TG3_FLG2_1SHOT_MSI)
 			fn = tg3_msi_1shot;
-		flags = SA_SAMPLE_RANDOM;
+		flags = 0;
 	} else {
 		fn = tg3_interrupt;
 		if (tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)
 			fn = tg3_interrupt_tagged;
-		flags = SA_SHIRQ | SA_SAMPLE_RANDOM;
+		flags = SA_SHIRQ;
 	}
 	return (request_irq(tp->pdev->irq, fn, flags, dev->name, dev));
 }
@@ -6626,7 +6626,7 @@ static int tg3_test_interrupt(struct tg3
 	free_irq(tp->pdev->irq, dev);
 
 	err = request_irq(tp->pdev->irq, tg3_test_isr,
-			  SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
+			  SA_SHIRQ, dev->name, dev);
 	if (err)
 		return err;
 
Index: 2.6/drivers/net/cris/eth_v10.c
===================================================================
--- 2.6.orig/drivers/net/cris/eth_v10.c	2006-04-20 17:00:40.000000000 -0500
+++ 2.6/drivers/net/cris/eth_v10.c	2006-05-03 16:35:13.000000000 -0500
@@ -672,7 +672,7 @@ e100_open(struct net_device *dev)
 	/* allocate the irq corresponding to the receiving DMA */
 
 	if (request_irq(NETWORK_DMA_RX_IRQ_NBR, e100rxtx_interrupt,
-			SA_SAMPLE_RANDOM, cardname, (void *)dev)) {
+			0, cardname, dev)) {
 		goto grace_exit0;
 	}
 
Index: 2.6/drivers/net/e1000/e1000_main.c
===================================================================
--- 2.6.orig/drivers/net/e1000/e1000_main.c	2006-05-02 17:29:27.000000000 -0500
+++ 2.6/drivers/net/e1000/e1000_main.c	2006-05-03 16:34:33.000000000 -0500
@@ -463,8 +463,7 @@ e1000_up(struct e1000_adapter *adapter)
 	}
 #endif
 	if ((err = request_irq(adapter->pdev->irq, &e1000_intr,
-		              SA_SHIRQ | SA_SAMPLE_RANDOM,
-		              netdev->name, netdev))) {
+			       SA_SHIRQ, netdev->name, netdev))) {
 		DPRINTK(PROBE, ERR,
 		    "Unable to allocate interrupt Error: %d\n", err);
 		return err;
