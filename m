Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTFXVYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFXVYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:24:13 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:15876 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262577AbTFXVWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:22:48 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 5/5] alloc_etherdev for smc91c92_cs
Date: Tue, 24 Jun 2003 23:31:35 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030624213700.F12E74FF92@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net_device is no longer allocated as part of the driver's private structure,
instead it's allocated via alloc_netdev. compile tested only since no hardware
against 2.5.73-bk


-daniel

===== smc91c92_cs.c 1.18 vs edited =====
--- 1.18/drivers/net/pcmcia/smc91c92_cs.c	Sun May  4 23:20:34 2003
+++ edited/smc91c92_cs.c	Tue Jun 24 22:07:31 2003
@@ -113,7 +113,6 @@
 
 struct smc_private {
     dev_link_t			link;
-    struct net_device		dev;
     spinlock_t			lock;
     u_short			manfid;
     u_short			cardid;
@@ -344,10 +343,13 @@
     flush_stale_links();
 
     /* Create new ethernet device */
-    smc = kmalloc(sizeof(struct smc_private), GFP_KERNEL);
-    if (!smc) return NULL;
-    memset(smc, 0, sizeof(struct smc_private));
-    link = &smc->link; dev = &smc->dev;
+    dev = alloc_etherdev(sizeof(struct smc_private));
+    if (!dev)
+	return NULL;
+    smc = dev->priv;
+    link = &smc->link;
+    link->priv = dev;
+
     spin_lock_init(&smc->lock);
     init_timer(&link->release);
     link->release.function = &smc91c92_release;
@@ -363,6 +365,7 @@
 	for (i = 0; i < 4; i++)
 	    link->irq.IRQInfo2 |= 1 << irq_list[i];
     link->irq.Handler = &smc_interrupt;
+    link->irq.Instance = dev;
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.Vcc = 50;
     link->conf.IntType = INT_MEMORY_AND_IO;
@@ -373,7 +376,6 @@
     dev->get_stats = &smc_get_stats;
     dev->set_config = &s9k_config;
     dev->set_multicast_list = &set_rx_mode;
-    ether_setup(dev);
     dev->open = &smc_open;
     dev->stop = &smc_close;
     dev->do_ioctl = &smc_ioctl;
@@ -381,7 +383,6 @@
     dev->tx_timeout = smc_tx_timeout;
     dev->watchdog_timeo = TX_TIMEOUT;
 #endif
-    dev->priv = link->priv = link->irq.Instance = smc;
 
     smc->mii_if.dev = dev;
     smc->mii_if.mdio_read = mdio_read;
@@ -421,7 +422,7 @@
 
 static void smc91c92_detach(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
+    struct net_device *dev = link->priv;
     dev_link_t **linkp;
 
     DEBUG(0, "smc91c92_detach(0x%p)\n", link);
@@ -447,8 +448,8 @@
     /* Unlink device structure, free bits */
     *linkp = link->next;
     if (link->dev)
-	unregister_netdev(&smc->dev);
-    kfree(smc);
+	unregister_netdev(dev);
+    kfree(dev);
 
 } /* smc91c92_detach */
 
@@ -502,7 +503,8 @@
 
 static int mhz_3288_power(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
+    struct net_device *dev = link->priv;
+    struct smc_private *smc = dev->priv;
     u_char tmp;
 
     /* Read the ISR twice... */
@@ -523,8 +525,8 @@
 
 static int mhz_mfc_config(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
+    struct smc_private *smc = dev->priv;
     tuple_t tuple;
     cisparse_t parse;
     u_char buf[255];
@@ -590,8 +592,7 @@
 static int mhz_setup(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     tuple_t tuple;
     cisparse_t parse;
     u_char buf[255], *station_addr;
@@ -638,8 +639,8 @@
 
 static void mot_config(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
+    struct smc_private *smc = dev->priv;
     ioaddr_t ioaddr = dev->base_addr;
     ioaddr_t iouart = link->io.BasePort2;
 
@@ -659,8 +660,7 @@
 
 static int mot_setup(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     ioaddr_t ioaddr = dev->base_addr;
     int i, wait, loop;
     u_int addr;
@@ -694,8 +694,7 @@
 
 static int smc_config(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     tuple_t tuple;
     cisparse_t parse;
     u_char buf[255];
@@ -727,8 +726,7 @@
 static int smc_setup(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     tuple_t tuple;
     cisparse_t parse;
     cistpl_lan_node_id_t *node_id;
@@ -755,7 +753,6 @@
 	    return 0;
 	}
     }
-
     /* Try the third string in the Version 1 Version/ID tuple. */
     tuple.DesiredTuple = CISTPL_VERS_1;
     if (first_tuple(handle, &tuple, &parse) != CS_SUCCESS)
@@ -771,8 +768,7 @@
 
 static int osi_config(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     static ioaddr_t com[4] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8 };
     int i, j;
 
@@ -806,8 +802,7 @@
 static int osi_setup(dev_link_t *link, u_short manfid, u_short cardid)
 {
     client_handle_t handle = link->handle;
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     tuple_t tuple;
     u_char buf[255];
     int i;
@@ -862,8 +857,7 @@
 
 static int check_sig(dev_link_t *link)
 {
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
     ioaddr_t ioaddr = dev->base_addr;
     int width;
     u_short s;
@@ -921,8 +915,8 @@
 static void smc91c92_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
+    struct smc_private *smc = dev->priv;
     tuple_t tuple;
     cisparse_t parse;
     u_short buf[32];
@@ -1090,7 +1084,6 @@
 static void smc91c92_release(u_long arg)
 {
     dev_link_t *link = (dev_link_t *)arg;
-    struct smc_private *smc = link->priv;
 
     DEBUG(0, "smc91c92_release(0x%p)\n", link);
 
@@ -1105,6 +1098,8 @@
     CardServices(ReleaseIO, link->handle, &link->io);
     CardServices(ReleaseIRQ, link->handle, &link->irq);
     if (link->win) {
+	struct net_device *dev = link->priv;
+	struct smc_private *smc = dev->priv;
 	iounmap(smc->base);
 	CardServices(ReleaseWindow, link->win);
     }
@@ -1126,8 +1121,8 @@
 			  event_callback_args_t *args)
 {
     dev_link_t *link = args->client_data;
-    struct smc_private *smc = link->priv;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = link->priv;
+    struct smc_private *smc = dev->priv;
     int i;
 
     DEBUG(1, "smc91c92_event(0x%06x)\n", event);
@@ -1302,7 +1297,7 @@
     smc_reset(dev);
     init_timer(&smc->media);
     smc->media.function = &media_check;
-    smc->media.data = (u_long)smc;
+    smc->media.data = (u_long) dev;
     smc->media.expires = jiffies + HZ;
     add_timer(&smc->media);
 
@@ -1576,8 +1571,8 @@
 
 static irqreturn_t smc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-    struct smc_private *smc = dev_id;
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = dev_id;
+    struct smc_private *smc = dev->priv;
     ioaddr_t ioaddr;
     u_short saved_bank, saved_pointer, mask, status;
     unsigned int handled = 1;
@@ -1967,8 +1962,8 @@
 
 static void media_check(u_long arg)
 {
-    struct smc_private *smc = (struct smc_private *)(arg);
-    struct net_device *dev = &smc->dev;
+    struct net_device *dev = (struct net_device *) arg;
+    struct smc_private *smc = dev->priv;
     ioaddr_t ioaddr = dev->base_addr;
     u_short i, media, saved_bank;
     u_short link;

