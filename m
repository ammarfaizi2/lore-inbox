Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTFXVXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTFXVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:23:26 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:15108 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262568AbTFXVWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:22:44 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 3/5] alloc_etherdev for fmvj18x_cs
Date: Tue, 24 Jun 2003 23:29:12 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030624213659.F18A54FF90@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net_device is no longer allocated as part of the driver's private structure,
instead it's allocated via alloc_netdev. compile tested only since no hardware
against 2.5.73-bk


-daniel

===== fmvj18x_cs.c 1.21 vs edited =====
--- 1.21/drivers/net/pcmcia/fmvj18x_cs.c	Sat May 31 12:50:47 2003
+++ edited/fmvj18x_cs.c	Tue Jun 24 20:24:32 2003
@@ -130,7 +130,6 @@
 */
 typedef struct local_info_t {
     dev_link_t link;
-    struct net_device dev;
     dev_node_t node;
     struct net_device_stats stats;
     long open_time;
@@ -273,11 +272,12 @@
     flush_stale_links();
 
     /* Make up a FMVJ18x specific data structure */
-    lp = kmalloc(sizeof(*lp), GFP_KERNEL);
-    if (!lp) return NULL;
-    memset(lp, 0, sizeof(*lp));
-    link = &lp->link; dev = &lp->dev;
-    link->priv = dev->priv = link->irq.Instance = lp;
+    dev = alloc_etherdev(sizeof(local_info_t));
+    if (!dev)
+	return NULL;
+    lp = dev->priv;
+    link = &lp->link;
+    link->priv = dev;
 
     init_timer(&link->release);
     link->release.function = &fmvj18x_release;
@@ -297,6 +297,7 @@
 	for (i = 0; i < 4; i++)
 	    link->irq.IRQInfo2 |= 1 << irq_list[i];
     link->irq.Handler = &fjn_interrupt;
+    link->irq.Instance = dev;
     
     /* General socket configuration */
     link->conf.Attributes = CONF_ENABLE_IRQ;
@@ -309,7 +310,6 @@
     dev->set_config = &fjn_config;
     dev->get_stats = &fjn_get_stats;
     dev->set_multicast_list = &set_rx_mode;
-    ether_setup(dev);
     dev->open = &fjn_open;
     dev->stop = &fjn_close;
 #ifdef HAVE_TX_TIMEOUT
@@ -344,7 +344,7 @@
 
 static void fmvj18x_detach(dev_link_t *link)
 {
-    local_info_t *lp = link->priv;
+    struct net_device *dev = link->priv;
     dev_link_t **linkp;
     
     DEBUG(0, "fmvj18x_detach(0x%p)\n", link);
@@ -371,8 +371,8 @@
     /* Unlink device structure, free pieces */
     *linkp = link->next;
     if (link->dev)
-	unregister_netdev(&lp->dev);
-    kfree(lp);
+	unregister_netdev(dev);
+    kfree(dev);
     
 } /* fmvj18x_detach */
 
@@ -423,8 +423,8 @@
 static void fmvj18x_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
-    local_info_t *lp = link->priv;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = link->priv;
+    local_info_t *lp = dev->priv;
     tuple_t tuple;
     cisparse_t parse;
     u_short buf[32];
@@ -704,8 +704,7 @@
     memreq_t mem;
     u_char *base;
     int i, j;
-    local_info_t *lp = link->priv;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = link->priv;
     ioaddr_t ioaddr;
 
     /* Allocate a small memory window */
@@ -776,8 +775,7 @@
 			  event_callback_args_t *args)
 {
     dev_link_t *link = args->client_data;
-    local_info_t *lp = link->priv;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = link->priv;
 
     DEBUG(1, "fmvj18x_event(0x%06x)\n", event);
     
@@ -847,8 +845,8 @@
 
 static irqreturn_t fjn_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-    local_info_t *lp = dev_id;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = dev_id;
+    local_info_t *lp = dev->priv;
     ioaddr_t ioaddr;
     unsigned short tx_stat, rx_stat;
 

