Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTFZWiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTFZWh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:37:57 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:18180 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264052AbTFZWgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:36:08 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 2/3] alloc_etherdev for netwave_cs.c
Date: Fri, 27 Jun 2003 00:45:51 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030626225013.B5E824FF8F@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cleans up netwave_cs.c to use alloc_etherdev instead of allocating the device
out of the private data structure. compile tested only.
against 2.5.73-bk


--- 1.18/drivers/net/wireless/netwave_cs.c	Wed May 28 17:01:08 2003
+++ edited/netwave_cs.c	Thu Jun 26 22:05:04 2003
@@ -321,7 +321,6 @@
    
 typedef struct netwave_private {
     dev_link_t link;
-    struct net_device      dev;
     spinlock_t	spinlock;	/* Serialize access to the hardware (SMP) */
     dev_node_t node;
     u_char     *ramBase;
@@ -449,11 +448,13 @@
     netwave_flush_stale_links();
 
     /* Initialize the dev_link_t structure */
-    priv = kmalloc(sizeof(*priv), GFP_KERNEL);
-    if (!priv) return NULL;
-    memset(priv, 0, sizeof(*priv));
-    link = &priv->link; dev = &priv->dev;
-    link->priv = dev->priv = priv;
+    dev = alloc_etherdev(sizeof(struct el3_private));
+    if (!dev)
+	return NULL;
+    lp = dev->priv;
+    link = &lp->link;
+    link->priv = dev;
+
     init_timer(&link->release);
     link->release.function = &netwave_release;
     link->release.data = (u_long)link;
@@ -504,7 +505,6 @@
     dev->tx_timeout = &netwave_watchdog;
     dev->watchdog_timeo = TX_TIMEOUT;
 
-    ether_setup(dev);
     dev->open = &netwave_open;
     dev->stop = &netwave_close;
     link->irq.Instance = dev;
@@ -541,7 +541,7 @@
  */
 static void netwave_detach(dev_link_t *link)
 {
-    netwave_private *priv = link->priv;
+    struct net_dev *dev = link->priv;
     dev_link_t **linkp;
 
     DEBUG(0, "netwave_detach(0x%p)\n", link);
@@ -580,8 +580,8 @@
     /* Unlink device structure, free pieces */
     *linkp = link->next;
     if (link->dev)
-	unregister_netdev(&priv->dev);
-    kfree(priv);
+	unregister_netdev(dev);
+    kfree(dev);
     
 } /* netwave_detach */
 
@@ -1038,8 +1038,8 @@
 
 static void netwave_pcmcia_config(dev_link_t *link) {
     client_handle_t handle = link->handle;
-    netwave_private *priv = link->priv;
-    struct net_device *dev = &priv->dev;
+    struct net_device *dev = link->priv;
+    netwave_private *priv = dev->priv;
     tuple_t tuple;
     cisparse_t parse;
     int i, j, last_ret, last_fn;
@@ -1099,7 +1099,7 @@
      *  Allocate a 32K memory window.  Note that the dev_link_t
      *  structure provides space for one window handle -- if your
      *  device needs several windows, you'll need to keep track of
-     *  the handles in your private data structure, link->priv.
+     *  the handles in your private data structure, dev->priv.
      */
     DEBUG(1, "Setting mem speed of %d\n", mem_speed);
 
@@ -1161,7 +1161,8 @@
  */
 static void netwave_release(u_long arg) {
     dev_link_t *link = (dev_link_t *)arg;
-    netwave_private *priv = link->priv;
+    struct net_device *dev = link->priv;
+    netwave_private *priv = dev->priv;
 
     DEBUG(0, "netwave_release(0x%p)\n", link);
 
@@ -1206,8 +1207,7 @@
 static int netwave_event(event_t event, int priority,
 			 event_callback_args_t *args) {
     dev_link_t *link = args->client_data;
-    netwave_private *priv = link->priv;
-    struct net_device *dev = &priv->dev;
+    struct net_device *dev = link->priv;
 	
     DEBUG(1, "netwave_event(0x%06x)\n", event);
   

