Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTARTjD>; Sat, 18 Jan 2003 14:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbTARTjD>; Sat, 18 Jan 2003 14:39:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2279 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264992AbTARTi4>; Sat, 18 Jan 2003 14:38:56 -0500
Date: Sat, 18 Jan 2003 20:47:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove #if'd kernel 2.0 code from misc net drivers
Message-ID: <20030118194750.GL10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes #if'd kernel 2.0 code from misc net drivers.

I've tested the compilation with 2.5.59.

diffstat output:
 arlan.c   |   15 +--------------
 eth16i.c  |    2 --
 mac8390.c |    2 --
 sk_mca.c  |   15 +--------------
 4 files changed, 2 insertions(+), 32 deletions(-)


cu
Adrian

--- linux-2.5.59-full/drivers/net/eth16i.c.old	2003-01-18 20:35:02.000000000 +0100
+++ linux-2.5.59-full/drivers/net/eth16i.c	2003-01-18 20:35:52.000000000 +0100
@@ -1404,7 +1404,6 @@
 static char* mediatype[MAX_ETH16I_CARDS];
 static int debug = -1;
 
-#if (LINUX_VERSION_CODE >= 0x20115) 
 MODULE_AUTHOR("Mika Kuoppala <miku@iki.fi>");
 MODULE_DESCRIPTION("ICL EtherTeam 16i/32 driver");
 MODULE_LICENSE("GPL");
@@ -1423,7 +1422,6 @@
 
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "eth16i debug level (0-6)");
-#endif
 
 int init_module(void)
 {
--- linux-2.5.59-full/drivers/net/mac8390.c.old	2003-01-18 20:36:27.000000000 +0100
+++ linux-2.5.59-full/drivers/net/mac8390.c	2003-01-18 20:36:52.000000000 +0100
@@ -376,11 +376,9 @@
 }
 
 #ifdef MODULE
-#if LINUX_VERSION_CODE > 0x20118
 MODULE_AUTHOR("David Huggins-Daines <dhd@debian.org> and others");
 MODULE_DESCRIPTION("Macintosh NS8390-based Nubus Ethernet driver");
 MODUEL_LICENSE("GPL");
-#endif
 
 int init_module(void)
 {
--- linux-2.5.59-full/drivers/net/arlan.c.old	2003-01-18 20:37:21.000000000 +0100
+++ linux-2.5.59-full/drivers/net/arlan.c	2003-01-18 20:39:20.000000000 +0100
@@ -47,7 +47,6 @@
 static int mdebug;
 #endif
 
-#if LINUX_VERSION_CODE > 0x20100
 MODULE_PARM(irq, "i");
 MODULE_PARM(mem, "i");
 MODULE_PARM(probe, "i");
@@ -95,18 +94,6 @@
 EXPORT_SYMBOL(last_arlan);
 
 
-//        #warning kernel 2.1.110 tested
-#define myATOMIC_INIT(a,b) atomic_set(&(a),b)
-
-#else
-#define test_and_set_bit	set_bit
-#if LINUX_VERSION_CODE != 0x20024
- //        #warning kernel  2.0.36  tested
-#endif
-#define myATOMIC_INIT(a,b) a = b;
-
-#endif
-
 struct arlan_conf_stru arlan_conf[MAX_ARLANS];
 static int arlans_found;
 
@@ -1322,7 +1309,7 @@
 	netif_start_queue (dev);
 
 	init_MUTEX(&priv->card_lock);
-	myATOMIC_INIT(priv->card_users, 1);	/* damn 2.0.33 */
+	atomic_set(&(priv->card_users), 1);
 	priv->registrationLostCount = 0;
 	priv->registrationLastSeen = jiffies;
 	priv->txLast = 0;
--- linux-2.5.59-full/drivers/net/sk_mca.c.old	2003-01-18 20:40:13.000000000 +0100
+++ linux-2.5.59-full/drivers/net/sk_mca.c	2003-01-18 20:41:07.000000000 +0100
@@ -649,9 +649,7 @@
 				skb->protocol = eth_type_trans(skb, dev);
 				skb->ip_summed = CHECKSUM_NONE;
 				priv->stat.rx_packets++;
-#if LINUX_VERSION_CODE >= 0x020119	/* byte counters for >= 2.1.25 */
 				priv->stat.rx_bytes += descr.Len;
-#endif
 				netif_rx(skb);
 				dev->last_rx = jiffies;
 			}
@@ -709,9 +707,7 @@
 		/* update statistics */
 		if ((descr.Flags & TXDSCR_FLAGS_ERR) == 0) {
 			priv->stat.tx_packets++;
-#if LINUX_VERSION_CODE >= 0x020119	/* byte counters for >= 2.1.25 */
 			priv->stat.tx_bytes++;
-#endif
 		} else {
 			priv->stat.tx_errors++;
 			if ((descr.Status & TXDSCR_STATUS_UFLO) != 0) {
@@ -1001,13 +997,8 @@
 
       tx_done:
 
-	/* When did that change exactly ? */
-
-#if LINUX_VERSION_CODE >= 0x020200
 	dev_kfree_skb(skb);
-#else
-	dev_kfree_skb(skb, FREE_WRITE);
-#endif
+
 	return retval;
 }
 
@@ -1146,9 +1137,7 @@
 		mca_set_adapter_name(slot, "SKNET MC2+ Ethernet Adapter");
 	mca_set_adapter_procfn(slot, (MCA_ProcFn) skmca_getinfo, dev);
 
-#if LINUX_VERSION_CODE >= 0x020200
 	mca_mark_as_used(slot);
-#endif
 
 	/* announce success */
 	printk("%s: SKNet %s adapter found in slot %d\n", dev->name,
@@ -1283,9 +1272,7 @@
 				free_irq(dev->irq, dev);
 			dev->irq = 0;
 			unregister_netdev(dev);
-#if LINUX_VERSION_CODE >= 0x020200
 			mca_mark_as_unused(priv->slot);
-#endif
 			mca_set_adapter_procfn(priv->slot, NULL, NULL);
 			kfree(dev->priv);
 			dev->priv = NULL;
