Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbRCBRbp>; Fri, 2 Mar 2001 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbRCBRbg>; Fri, 2 Mar 2001 12:31:36 -0500
Received: from adsl-63-203-203-135.dsl.snfc21.pacbell.net ([63.203.203.135]:19080
	"EHLO slipknot.mediabolic.com") by vger.kernel.org with ESMTP
	id <S129350AbRCBRbY>; Fri, 2 Mar 2001 12:31:24 -0500
Date: Fri, 2 Mar 2001 09:46:14 -0800 (PST)
From: Keith Craigie <kcraigie@mediabolic.com>
To: <linux-kernel@vger.kernel.org>
Subject: NetGear fa311 driver update
Message-ID: <Pine.LNX.4.30.0103020937500.25459-100000@slipknot.mediabolic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I brought NetGear's fa311 driver up to compile under 2.4.2.  I put the
updated source here -

http://millweed.com/projects/fa311/fa311.c

Or you can apply the following patch to the source gotten from the
NetGear support site
(http://www.netgear-support.com/ts/downloads/fa31lx70.zip) -

--- /tmp/basdf/fa311.c	Fri Jan 19 14:20:50 2001
+++ fa311.c	Thu Mar  1 18:12:57 2001
@@ -174,23 +174,23 @@

 /* Device private data */
 struct fa311_priv {
-	struct device *         next;        /* Next fa311device */
+    struct net_device *       next;    /* Next fa311device */
     struct fa311_queue    tx_queue;    /* Transmit Descriptor Queue */
     struct fa311_queue    rx_queue;    /* Receive Descriptor Queue */
-    struct enet_statistics  stats;       /* MIB data */
+    struct net_device_stats  stats;    /* MIB data */
 };

-static struct device *    fa311_dev_list;        /* List of fa311devices */
+static struct net_device *    fa311_dev_list;      /* List of fa311devices */

 /* Linux Network Driver interface routines */
-extern int fa311_probe (struct device *dev);
-static int fa311_open (struct device *dev);
-static int fa311_close (struct device *dev);
-static int fa311_start_xmit (struct sk_buff *skb, struct device *dev);
-static void fa311_set_multicast_list (struct device *dev);
-static int fa311_ioctl (struct device *dev, struct ifreq *rq, int cmd);
+extern int fa311_probe (struct net_device *dev);
+static int fa311_open (struct net_device *dev);
+static int fa311_close (struct net_device *dev);
+static int fa311_start_xmit (struct sk_buff *skb, struct net_device *dev);
+static void fa311_set_multicast_list (struct net_device *dev);
+static int fa311_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
 static void fa311_interrupt (int irq, void *dev_id, struct pt_regs *regs);
-static struct enet_statistics *fa311_get_stats (struct device *dev);
+static struct net_device_stats *fa311_get_stats (struct net_device *dev);

 /* Support Functions */
 /*static u16 swap_16 (u16 us);*/
@@ -206,11 +206,11 @@
 static status fa311_dev_reset (u32 iobase);
 static status fa311_queue_create (struct fa311_queue *q, int count, int qtype);
 static status fa311_queue_delete (struct fa311_queue *q);
-static virt_addr fa311_tx_desc_get (struct device *dev);
-static virt_addr fa311_rx_desc_get (struct device *dev);
-static status fa311_phy_setup (struct device *dev);
+static virt_addr fa311_tx_desc_get (struct net_device *dev);
+static virt_addr fa311_rx_desc_get (struct net_device *dev);
+static status fa311_phy_setup (struct net_device *dev);
 static int fa311_crc (char * mc_addr);
-static void fa311_tx_skb_reclaim (struct device *dev, virt_addr desc_addr);
+static void fa311_tx_skb_reclaim (struct net_device *dev, virt_addr desc_addr);
 static void  ReadEEWord(u16 iobase,u32 wordOffset,u16* pEeData);


@@ -226,7 +226,7 @@
  * registers each FA311 device found.
  */
 int
-fa311_probe (struct device *dev)
+fa311_probe (struct net_device *dev)
 {
     int  dev_count;
     u8   bus;
@@ -353,7 +353,7 @@

 /* fa311_open - open and initialize a device */
 static int
-fa311_open (struct device *dev)
+fa311_open (struct net_device *dev)
 {
     u32     iobase = dev->base_addr;
     struct fa311_priv* priv   = dev->priv;
@@ -448,7 +448,7 @@

 /* fa311_close - close a device, and reclaim resources */
 static int
-fa311_close (struct device *dev)
+fa311_close (struct net_device *dev)
 {
     u32                     iobase = dev->base_addr;
     struct fa311_priv* priv   = dev->priv;
@@ -480,19 +480,19 @@
  * CMDSTS, and signals the chip
  */
 static int
-fa311_start_xmit (struct sk_buff *skb, struct device *dev)
+fa311_start_xmit (struct sk_buff *skb, struct net_device *dev)
 {
     u32        iobase = dev->base_addr;
 	u32        cmdsts;
     virt_addr  tx_desc;
-    struct enet_statistics *stats_p;
+    struct net_device_stats *stats_p;

     if (skb->len > ETH_MAX_PKT_SIZE)
         return ERROR;

 	tx_desc = fa311_tx_desc_get(dev);
     if (tx_desc == NULL) {
-        set_bit (0, &dev->tbusy);
+        netif_stop_queue(dev);
         DP_REG32_SET (DP_IMR, DP_IMR_TXOK | DP_IMR_TXIDLE);
         tx_desc = fa311_tx_desc_get (dev);
     }
@@ -553,7 +553,7 @@
  * size, and updates the BUFPTR and SKBPTR fields to the newly allocated SKB.
  */
 static int
-fa311_start_receive (struct device *dev)
+fa311_start_receive (struct net_device *dev)
 {
     u32         cmdsts;
 	int         len;
@@ -562,7 +562,7 @@
     struct sk_buff *cur_skb;
     struct sk_buff *new_skb;
 	struct sk_buff *rx_skb;
-    struct enet_statistics *stats_p;
+        struct net_device_stats *stats_p;

     stats_p = &((struct fa311_priv *)(dev->priv))->stats;

@@ -648,15 +648,15 @@
 }

 /* fa311_get_stats - get current device statistics */
-static struct enet_statistics *
-fa311_get_stats (struct device *dev)
+static struct net_device_stats *
+fa311_get_stats (struct net_device *dev)
 {
     return &((struct fa311_priv *)(dev->priv))->stats;
 }

 /* fa311_set_multicast_list - sets multicast, & promiscuous mode */
 static void
-fa311_set_multicast_list (struct device *dev)
+fa311_set_multicast_list (struct net_device *dev)
 {
     u32      iobase = dev->base_addr;
     u16   hash_table[32];
@@ -738,7 +738,7 @@

 /* fa311_interrupt - handle driver specific ioctls */
 static int
-fa311_ioctl (struct device *dev, struct ifreq *rq, int cmd)
+fa311_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
     return -EOPNOTSUPP;
 }
@@ -749,7 +749,7 @@
 static void
 fa311_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
-    struct device * dev = dev_id;
+    struct net_device * dev = dev_id;
     u16  iobase = dev->base_addr;
     u32  reg_isr;
     u32  CurrentLinkStatus;
@@ -784,8 +784,8 @@

     if (reg_isr & (DP_ISR_TXOK | DP_ISR_TXIDLE)) {
         DP_REG32_CLR (DP_IMR, (DP_IMR_TXOK|DP_IMR_TXIDLE));
-        clear_bit (0, &dev->tbusy);
-        mark_bh (NET_BH);
+        netif_start_queue(dev);
+        netif_wake_queue(dev);
     }
 }

@@ -979,7 +979,7 @@
  * the owner, else returns NULL
  */
 static virt_addr
-fa311_tx_desc_get (struct device *dev)
+fa311_tx_desc_get (struct net_device *dev)
 {
     struct fa311_queue *   q;
     virt_addr                desc_addr = NULL;
@@ -998,7 +998,7 @@

 /* fa311_tx_skb_reclaim - reclaim SKBs in transmitted descriptors */
 static void
-fa311_tx_skb_reclaim (struct device *dev, virt_addr desc_addr)
+fa311_tx_skb_reclaim (struct net_device *dev, virt_addr desc_addr)
 {
 	struct sk_buff *       skb;
 	struct fa311_queue * q;
@@ -1020,7 +1020,7 @@
  * the owner, else returns NULL
  */
 static virt_addr
-fa311_rx_desc_get (struct device *dev)
+fa311_rx_desc_get (struct net_device *dev)
 {
     struct fa311_queue *   q;
     virt_addr                desc_addr = NULL;
@@ -1038,7 +1038,7 @@

 /* fa311_phy_setup - reset and setup the PHY device */
 static status
-fa311_phy_setup (struct device *dev)
+fa311_phy_setup (struct net_device *dev)
 {
     u32  iobase = dev->base_addr;
     u32  dp_cfg_val;
@@ -1215,7 +1215,7 @@
 void
 cleanup_module (void)
 {
-    struct device *cur_dev;
+    struct net_device *cur_dev;

     cur_dev=fa311_dev_list;
     while (cur_dev) {


-- 
Keith Craigie
R&D
Mediabolic, Inc.
415-346-2270 x115

