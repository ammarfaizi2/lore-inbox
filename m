Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTFJPFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTFJPFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:05:55 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:58889 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262955AbTFJPFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:05:48 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH 1/2] xirc2ps_cs update
Date: Tue, 10 Jun 2003 15:17:17 -0400
User-Agent: KMail/1.5.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-net" <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306101517.17011.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

this patch does:
- net_device is no longer allocated as part of the driver's private structure,
  instead it's allocated via alloc_netdev
- xirc2ps_detach calls xirc2ps_release if necessary (like the other drivers)

against 2.5.70-bk.

rgds
-daniel


===== drivers/net/pcmcia/xirc2ps_cs.c 1.19 vs edited =====
--- 1.19/drivers/net/pcmcia/xirc2ps_cs.c	Sun May 25 17:07:51 2003
+++ edited/drivers/net/pcmcia/xirc2ps_cs.c	Mon Jun  9 15:27:53 2003
@@ -358,7 +358,6 @@
 
 typedef struct local_info_t {
     dev_link_t link;
-    struct net_device dev;
     dev_node_t node;
     struct net_device_stats stats;
     int card_type;
@@ -619,11 +618,12 @@
     flush_stale_links();
 
     /* Allocate the device structure */
-    local = kmalloc(sizeof(*local), GFP_KERNEL);
-    if (!local) return NULL;
-    memset(local, 0, sizeof(*local));
-    link = &local->link; dev = &local->dev;
-    link->priv = dev->priv = local;
+    dev = alloc_etherdev(sizeof(local_info_t));
+    if (!dev)
+	    return NULL;
+    local = dev->priv;
+    link = &local->link;
+    link->priv = dev;
 
     init_timer(&link->release);
     link->release.function = &xirc2ps_release;
@@ -645,7 +645,6 @@
     dev->get_stats = &do_get_stats;
     dev->do_ioctl = &do_ioctl;
     dev->set_multicast_list = &set_multicast_list;
-    ether_setup(dev);
     dev->open = &do_open;
     dev->stop = &do_stop;
 #ifdef HAVE_TX_TIMEOUT
@@ -684,7 +683,7 @@
 static void
 xirc2ps_detach(dev_link_t * link)
 {
-    local_info_t *local = link->priv;
+    struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
     DEBUG(0, "detach(0x%p)\n", link);
@@ -706,10 +705,11 @@
      */
     del_timer(&link->release);
     if (link->state & DEV_CONFIG) {
-	DEBUG(0, "detach postponed, '%s' still locked\n",
-	      link->dev->dev_name);
-	link->state |= DEV_STALE_LINK;
-	return;
+	xirc2ps_release((unsigned long)link);
+	if (link->state & DEV_STALE_CONFIG) {
+		link->state |= DEV_STALE_LINK;
+		return;
+	}
     }
 
     /* Break the link with Card Services */
@@ -719,8 +719,8 @@
     /* Unlink device structure, free it */
     *linkp = link->next;
     if (link->dev)
-	unregister_netdev(&local->dev);
-    kfree(local);
+	unregister_netdev(dev);
+    kfree(dev);
 
 } /* xirc2ps_detach */
 
@@ -745,7 +745,8 @@
 static int
 set_card_type(dev_link_t *link, const void *s)
 {
-    local_info_t *local = link->priv;
+    struct net_device *dev = link->priv;
+    local_info_t *local = dev->priv;
   #ifdef PCMCIA_DEBUG
     unsigned cisrev = ((const unsigned char *)s)[2];
   #endif
@@ -839,8 +840,8 @@
 xirc2ps_config(dev_link_t * link)
 {
     client_handle_t handle = link->handle;
-    local_info_t *local = link->priv;
-    struct net_device *dev = &local->dev;
+    struct net_device *dev = link->priv;
+    local_info_t *local = dev->priv;
     tuple_t tuple;
     cisparse_t parse;
     ioaddr_t ioaddr;
@@ -1195,11 +1196,10 @@
 xirc2ps_release(u_long arg)
 {
     dev_link_t *link = (dev_link_t *) arg;
-    local_info_t *local = link->priv;
-    struct net_device *dev = &local->dev;
 
     DEBUG(0, "release(0x%p)\n", link);
 
+#if 0
     /*
      * If the device is currently in use, we won't release until it
      * is actually closed.
@@ -1210,8 +1210,10 @@
 	link->state |= DEV_STALE_CONFIG;
 	return;
     }
+#endif
 
     if (link->win) {
+	struct net_device *dev = link->priv;
 	local_info_t *local = dev->priv;
 	if (local->dingo)
 	    iounmap(local->dingo_ccr - 0x0800);
@@ -1243,8 +1245,7 @@
 	      event_callback_args_t * args)
 {
     dev_link_t *link = args->client_data;
-    local_info_t *lp = link->priv;
-    struct net_device *dev = &lp->dev;
+    struct net_device *dev = link->priv;
 
     DEBUG(0, "event(%d)\n", (int)event);
 
@@ -2083,12 +2084,8 @@
 {
 	pcmcia_unregister_driver(&xirc2ps_cs_driver);
 
-	while (dev_list) {
-		if (dev_list->state & DEV_CONFIG)
-			xirc2ps_release((u_long)dev_list);
-		if (dev_list)	/* xirc2ps_release() might already have detached... */
-			xirc2ps_detach(dev_list);
-	}
+	while (dev_list)
+		xirc2ps_detach(dev_list);
 }
 
 module_init(init_xirc2ps_cs);

