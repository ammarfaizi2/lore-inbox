Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTFXVYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTFXVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:24:27 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:15620 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262687AbTFXVWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:22:54 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 4/5] alloc_etherdev for nmclan_cs
Date: Tue, 24 Jun 2003 23:30:20 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030624213659.64F3F4FF91@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net_device is no longer allocated as part of the driver's private structure,
instead it's allocated via alloc_netdev. compile tested only since no hardware
against 2.5.73-bk


-daniel

===== nmclan_cs.c 1.14 vs edited =====
--- 1.14/drivers/net/pcmcia/nmclan_cs.c	Sun May  4 23:20:34 2003
+++ edited/nmclan_cs.c	Tue Jun 24 21:35:26 2003
@@ -359,7 +359,6 @@
 
 typedef struct _mace_private {
     dev_link_t link;
-    struct net_device dev;
     dev_node_t node;
     struct net_device_stats linux_stats; /* Linux statistics counters */
     mace_statistics mace_stats; /* MACE chip statistics counters */
@@ -476,12 +475,13 @@
     flush_stale_links();
 
     /* Create new ethernet device */
-    lp = kmalloc(sizeof(*lp), GFP_KERNEL);
-    if (!lp) return NULL;
-    memset(lp, 0, sizeof(*lp));
-    link = &lp->link; dev = &lp->dev;
-    link->priv = dev->priv = link->irq.Instance = lp;
-
+    dev = alloc_etherdev(sizeof(mace_private));
+    if (!dev)
+	return NULL;
+    lp = dev->priv;
+    link = &lp->link;
+    link->priv = dev;
+    
     init_timer(&link->release);
     link->release.function = &nmclan_release;
     link->release.data = (u_long)link;
@@ -496,6 +496,7 @@
 	for (i = 0; i < 4; i++)
 	    link->irq.IRQInfo2 |= 1 << irq_list[i];
     link->irq.Handler = &mace_interrupt;
+    link->irq.Instance = dev;
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
@@ -510,7 +511,6 @@
     dev->get_stats = &mace_get_stats;
     dev->set_multicast_list = &set_multicast_list;
     dev->do_ioctl = &mace_ioctl;
-    ether_setup(dev);
     dev->open = &mace_open;
     dev->stop = &mace_close;
 #ifdef HAVE_TX_TIMEOUT
@@ -550,7 +550,7 @@
 
 static void nmclan_detach(dev_link_t *link)
 {
-    mace_private *lp = link->priv;
+    struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
     DEBUG(0, "nmclan_detach(0x%p)\n", link);
@@ -576,8 +576,8 @@
     /* Unlink device structure, free bits */
     *linkp = link->next;
     if (link->dev)
-	unregister_netdev(&lp->dev);
-    kfree(lp);
+	unregister_netdev(dev);
+    kfree(dev);
 
 } /* nmclan_detach */
 
@@ -710,8 +710,8 @@
 static void nmclan_config(dev_link_t *link)
 {
   client_handle_t handle = link->handle;
-  mace_private *lp = link->priv;
-  struct net_device *dev = &lp->dev;
+  struct net_device *dev = link->priv;;
+  mace_private *lp = dev->priv;
   tuple_t tuple;
   cisparse_t parse;
   u_char buf[64];
@@ -836,8 +836,7 @@
 		       event_callback_args_t *args)
 {
   dev_link_t *link = args->client_data;
-  mace_private *lp = link->priv;
-  struct net_device *dev = &lp->dev;
+  struct net_device *dev = link->priv;
 
   DEBUG(1, "nmclan_event(0x%06x)\n", event);
 
@@ -1145,8 +1144,8 @@
 ---------------------------------------------------------------------------- */
 static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-  mace_private *lp = (mace_private *)dev_id;
-  struct net_device *dev = &lp->dev;
+  struct net_device *dev = (struct net_device *) dev_id;
+  mace_private *lp = dev->priv;
   ioaddr_t ioaddr = dev->base_addr;
   int status;
   int IntrCnt = MACE_MAX_IR_ITERATIONS;

