Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTFXVXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFXVXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:23:09 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:14596 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262543AbTFXVWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:22:41 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 2/5] alloc_etherdev for 3c589_cs
Date: Tue, 24 Jun 2003 23:27:55 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030624213658.171254FF8F@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net_device is no longer allocated as part of the driver's private structure,
instead it's allocated via alloc_netdev. compile tested only since no hardware
against 2.5.73-bk


-daniel

===== drivers/net/pcmcia/3c589_cs.c 1.17 vs edited =====
--- 1.17/drivers/net/pcmcia/3c589_cs.c	Sun May  4 23:20:34 2003
+++ edited/drivers/net/pcmcia/3c589_cs.c	Mon Jun 23 23:24:48 2003
@@ -106,7 +106,6 @@
 
 struct el3_private {
     dev_link_t		link;
-    struct net_device	dev;
     dev_node_t 		node;
     struct net_device_stats stats;
     /* For transceiver monitoring */
@@ -213,14 +212,14 @@
     flush_stale_links();
     
     /* Create new ethernet device */
-    lp = kmalloc(sizeof(*lp), GFP_KERNEL);
-    if (!lp) return NULL;
-    memset(lp, 0, sizeof(*lp));
+    dev = alloc_etherdev(sizeof(struct el3_private));
+    if (!dev)
+	 return NULL;
+    lp = dev->priv;
+    link = &lp->link;
+    link->priv = dev;
+
     spin_lock_init(&lp->lock);
-    
-    link = &lp->link; dev = &lp->dev;
-    link->priv = dev->priv = link->irq.Instance = lp;
-    
     init_timer(&link->release);
     link->release.function = &tc589_release;
     link->release.data = (unsigned long)link;
@@ -234,6 +233,7 @@
 	for (i = 0; i < 4; i++)
 	    link->irq.IRQInfo2 |= 1 << irq_list[i];
     link->irq.Handler = &el3_interrupt;
+    link->irq.Instance = dev;
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
@@ -246,7 +246,6 @@
     dev->set_config = &el3_config;
     dev->get_stats = &el3_get_stats;
     dev->set_multicast_list = &set_multicast_list;
-    ether_setup(dev);
     dev->open = &el3_open;
     dev->stop = &el3_close;
 #ifdef HAVE_TX_TIMEOUT
@@ -288,7 +287,7 @@
 
 static void tc589_detach(dev_link_t *link)
 {
-    struct el3_private *lp = link->priv;
+    struct net_device *dev = link->priv;
     dev_link_t **linkp;
     
     DEBUG(0, "3c589_detach(0x%p)\n", link);
@@ -314,8 +313,8 @@
     /* Unlink device structure, free bits */
     *linkp = link->next;
     if (link->dev)
-	unregister_netdev(&lp->dev);
-    kfree(lp);
+	unregister_netdev(dev);
+    kfree(dev);
     
 } /* tc589_detach */
 
@@ -333,8 +332,8 @@
 static void tc589_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
-    struct el3_private *lp = link->priv;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = link->priv;
+    struct el3_private *lp = dev->priv;
     tuple_t tuple;
     cisparse_t parse;
     u16 buf[32], *phys_addr;
@@ -487,8 +486,7 @@
 		       event_callback_args_t *args)
 {
     dev_link_t *link = args->client_data;
-    struct el3_private *lp = link->priv;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = link->priv;
     
     DEBUG(1, "3c589_event(0x%06x)\n", event);
     
@@ -738,7 +736,7 @@
     tc589_reset(dev);
     init_timer(&lp->media);
     lp->media.function = &media_check;
-    lp->media.data = (unsigned long)lp;
+    lp->media.data = (unsigned long) dev;
     lp->media.expires = jiffies + HZ;
     add_timer(&lp->media);
 
@@ -818,8 +816,8 @@
 /* The EL3 interrupt handler. */
 static irqreturn_t el3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-    struct el3_private *lp = dev_id;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = (struct net_device *) dev_id;
+    struct el3_private *lp = dev->priv;
     ioaddr_t ioaddr, status;
     int i = 0, handled = 1;
     
@@ -903,8 +901,8 @@
 
 static void media_check(unsigned long arg)
 {
-    struct el3_private *lp = (struct el3_private *)(arg);
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = (struct net_device *)(arg);
+    struct el3_private *lp = dev->priv;
     ioaddr_t ioaddr = dev->base_addr;
     u16 media, errs;
     unsigned long flags;

