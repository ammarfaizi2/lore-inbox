Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTFXVWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFXVWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:22:49 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:14340 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262525AbTFXVWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:22:39 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 1/5] alloc_etherdev for 3c574_cs
Date: Tue, 24 Jun 2003 23:26:15 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030624213657.1969F4FEFD@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net_device is no longer allocated as part of the driver's private structure,
instead it's allocated via alloc_netdev. compile tested only since no hardware
against 2.5.73-bk


-daniel


===== drivers/net/pcmcia/3c574_cs.c 1.17 vs edited =====
--- 1.17/drivers/net/pcmcia/3c574_cs.c	Wed Apr 30 00:46:18 2003
+++ edited/drivers/net/pcmcia/3c574_cs.c	Mon Jun 23 21:45:40 2003
@@ -211,7 +211,6 @@
 
 struct el3_private {
 	dev_link_t link;
-	struct net_device dev;
 	dev_node_t node;
 	struct net_device_stats stats;
 	u16 advertising, partner;		/* NWay media advertisement */
@@ -291,13 +290,12 @@
 	flush_stale_links();
 
 	/* Create the PC card device object. */
-	lp = kmalloc(sizeof(*lp), GFP_KERNEL);
-	if (!lp)
+	dev = alloc_etherdev(sizeof(struct el3_private));
+	if (!dev)
 		return NULL;
-		
-	memset(lp, 0, sizeof(*lp));
-	link = &lp->link; dev = &lp->dev;
-	link->priv = dev->priv = link->irq.Instance = lp;
+	lp = dev->priv;
+	link = &lp->link;
+	link->priv = dev;
 	
 	init_timer(&link->release);
 	link->release.function = &tc574_release;
@@ -312,6 +310,7 @@
 		for (i = 0; i < 4; i++)
 			link->irq.IRQInfo2 |= 1 << irq_list[i];
 	link->irq.Handler = &el3_interrupt;
+	link->irq.Instance = dev;
 	link->conf.Attributes = CONF_ENABLE_IRQ;
 	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
@@ -323,7 +322,6 @@
 	dev->get_stats = &el3_get_stats;
 	dev->do_ioctl = &el3_ioctl;
 	dev->set_multicast_list = &set_rx_mode;
-	ether_setup(dev);
 	dev->open = &el3_open;
 	dev->stop = &el3_close;
 #ifdef HAVE_TX_TIMEOUT
@@ -364,7 +362,7 @@
 
 static void tc574_detach(dev_link_t *link)
 {
-	struct el3_private *lp = link->priv;
+	struct net_device *dev = link->priv;
 	dev_link_t **linkp;
 
 	DEBUG(0, "3c574_detach(0x%p)\n", link);
@@ -390,8 +388,8 @@
 	/* Unlink device structure, free bits */
 	*linkp = link->next;
 	if (link->dev)
-		unregister_netdev(&lp->dev);
-	kfree(lp);
+		unregister_netdev(dev);
+	kfree(dev);
 
 } /* tc574_detach */
 
@@ -407,8 +405,8 @@
 static void tc574_config(dev_link_t *link)
 {
 	client_handle_t handle = link->handle;
-	struct el3_private *lp = link->priv;
-	struct net_device *dev = &lp->dev;
+	struct net_device *dev = link->priv;
+	struct el3_private *lp = dev->priv;
 	tuple_t tuple;
 	cisparse_t parse;
 	unsigned short buf[32];
@@ -599,8 +597,7 @@
 					   event_callback_args_t *args)
 {
 	dev_link_t *link = args->client_data;
-	struct el3_private *lp = link->priv;
-	struct net_device *dev = &lp->dev;
+	struct net_device *dev = link->priv;
 
 	DEBUG(1, "3c574_event(0x%06x)\n", event);
 
@@ -856,7 +853,7 @@
 	
 	tc574_reset(dev);
 	lp->media.function = &media_check;
-	lp->media.data = (unsigned long)lp;
+	lp->media.data = (unsigned long) dev;
 	lp->media.expires = jiffies + HZ;
 	add_timer(&lp->media);
 	
@@ -939,8 +936,8 @@
 /* The EL3 interrupt handler. */
 static irqreturn_t el3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct el3_private *lp = dev_id;
-	struct net_device *dev = &lp->dev;
+	struct net_device *dev = (struct net_device *) dev_id;
+	struct el3_private *lp = dev->priv;
 	ioaddr_t ioaddr, status;
 	int work_budget = max_interrupt_work;
 	int handled = 0;
@@ -1032,8 +1029,8 @@
 */
 static void media_check(unsigned long arg)
 {
-	struct el3_private *lp = (struct el3_private *)arg;
-	struct net_device *dev = &lp->dev;
+	struct net_device *dev = (struct net_device *) arg;
+	struct el3_private *lp = dev->priv;
 	ioaddr_t ioaddr = dev->base_addr;
 	unsigned long flags;
 	unsigned short /* cable, */ media, partner;

