Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUDNWZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUDNWXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:23:40 -0400
Received: from palrel10.hp.com ([156.153.255.245]:32995 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261920AbUDNWUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:20:20 -0400
Date: Wed, 14 Apr 2004 15:20:19 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irlan - irlan_eth cleanup
Message-ID: <20040414222019.GH5434@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir265_irlan_eth_cleanup-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Use IrTTP flow control to stop/wake netif
		<Patch from Stephen Hemminger>
	o [CORRECT] Change irlan_eth device initialization:
        *bug* address never set in DIRECT mode because access not set
              in alloc_netdev -> irlan_eth_setup path
        + make eth_XXX handles static and provide alloc_irlandev hook
        + use netdev_priv (and get rid of truly impossible ASSERT's)
        + use skb_queue_purge


diff -u -p linux/include/net/irda/irlan_eth.d0.h linux/include/net/irda/irlan_eth.h
--- linux/include/net/irda/irlan_eth.d0.h	Thu Apr  8 11:06:54 2004
+++ linux/include/net/irda/irlan_eth.h	Thu Apr  8 11:16:16 2004
@@ -25,16 +25,9 @@
 #ifndef IRLAN_ETH_H
 #define IRLAN_ETH_H
 
-void  irlan_eth_setup(struct net_device *dev);
-int  irlan_eth_open(struct net_device *dev);
-int  irlan_eth_close(struct net_device *dev);
+struct net_device *alloc_irlandev(const char *name);
 int  irlan_eth_receive(void *instance, void *sap, struct sk_buff *skb);
-int  irlan_eth_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void irlan_eth_flow_indication( void *instance, void *sap, LOCAL_FLOW flow);
 void irlan_eth_send_gratuitous_arp(struct net_device *dev);
-
-void irlan_eth_set_multicast_list( struct net_device *dev);
-struct net_device_stats *irlan_eth_get_stats(struct net_device *dev);
-
 #endif
diff -u -p linux/net/irda/irlan/irlan_common.d0.c linux/net/irda/irlan/irlan_common.c
--- linux/net/irda/irlan/irlan_common.d0.c	Thu Apr  8 11:06:08 2004
+++ linux/net/irda/irlan/irlan_common.c	Thu Apr  8 14:03:27 2004
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/random.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
@@ -120,7 +121,7 @@ static int __init irlan_init(void)
 	struct irlan_cb *new;
 	__u16 hints;
 
-	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
 #ifdef CONFIG_PROC_FS
 	{ struct proc_dir_entry *proc;
@@ -191,9 +192,7 @@ struct irlan_cb *irlan_open(__u32 saddr,
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
 	/* Create network device with irlan */
-	dev = alloc_netdev(sizeof(*self), 
-			   eth ? "eth%d" : "irlan%d", 
-			   irlan_eth_setup);
+	dev = alloc_irlandev(eth ? "eth%d" : "irlan%d");
 	if (!dev)
 		return NULL;
 
@@ -209,6 +208,19 @@ struct irlan_cb *irlan_open(__u32 saddr,
 
 	/* Provider access can only be PEER, DIRECT, or HOSTED */
 	self->provider.access_type = access;
+	if (access == ACCESS_DIRECT) {
+		/*  
+		 * Since we are emulating an IrLAN sever we will have to
+		 * give ourself an ethernet address!  
+		 */
+		dev->dev_addr[0] = 0x40;
+		dev->dev_addr[1] = 0x00;
+		dev->dev_addr[2] = 0x00;
+		dev->dev_addr[3] = 0x00;
+		get_random_bytes(dev->dev_addr+4, 1);
+		get_random_bytes(dev->dev_addr+5, 1);
+	}
+
 	self->media = MEDIA_802_3;
 	self->disconnect_reason = LM_USER_REQUEST;
 	init_timer(&self->watchdog_timer);
@@ -248,8 +260,8 @@ static void __irlan_close(struct irlan_c
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
 
-	del_timer(&self->watchdog_timer);
-	del_timer(&self->client.kick_timer);
+	del_timer_sync(&self->watchdog_timer);
+	del_timer_sync(&self->client.kick_timer);
 
 	/* Close all open connections and remove TSAPs */
 	irlan_close_tsaps(self);
@@ -300,7 +312,7 @@ void irlan_connect_indication(void *inst
 	self->max_sdu_size = max_sdu_size;
 	self->max_header_size = max_header_size;
 
-	IRDA_DEBUG(0, "IrLAN, We are now connected!\n");
+	IRDA_DEBUG(0, "%s: We are now connected!\n", __FUNCTION__);
 
 	del_timer(&self->watchdog_timer);
 
@@ -342,7 +354,7 @@ void irlan_connect_confirm(void *instanc
 
 	/* TODO: we could set the MTU depending on the max_sdu_size */
 
-	IRDA_DEBUG(2, "IrLAN, We are now connected!\n");
+	IRDA_DEBUG(0, "%s: We are now connected!\n", __FUNCTION__);
 	del_timer(&self->watchdog_timer);
 
 	/* 
@@ -448,7 +460,7 @@ void irlan_open_data_tsap(struct irlan_c
 	notify.udata_indication      = irlan_eth_receive;
 	notify.connect_indication    = irlan_connect_indication;
 	notify.connect_confirm       = irlan_connect_confirm;
- 	/*notify.flow_indication       = irlan_eth_flow_indication;*/
+ 	notify.flow_indication       = irlan_eth_flow_indication;
 	notify.disconnect_indication = irlan_disconnect_indication;
 	notify.instance              = self;
 	strlcpy(notify.name, "IrLAN data", sizeof(notify.name));
diff -u -p linux/net/irda/irlan/irlan_eth.d0.c linux/net/irda/irlan/irlan_eth.c
--- linux/net/irda/irlan/irlan_eth.d0.c	Thu Apr  8 11:06:17 2004
+++ linux/net/irda/irlan/irlan_eth.c	Thu Apr  8 14:47:54 2004
@@ -30,7 +30,6 @@
 #include <linux/etherdevice.h>
 #include <linux/inetdevice.h>
 #include <linux/if_arp.h>
-#include <linux/random.h>
 #include <linux/module.h>
 #include <net/arp.h>
 
@@ -41,20 +40,20 @@
 #include <net/irda/irlan_event.h>
 #include <net/irda/irlan_eth.h>
 
+static int  irlan_eth_open(struct net_device *dev);
+static int  irlan_eth_close(struct net_device *dev);
+static int  irlan_eth_xmit(struct sk_buff *skb, struct net_device *dev);
+static void irlan_eth_set_multicast_list( struct net_device *dev);
+static struct net_device_stats *irlan_eth_get_stats(struct net_device *dev);
+
 /*
- * Function irlan_eth_init (dev)
+ * Function irlan_eth_setup (dev)
  *
  *    The network device initialization function.
  *
  */
-void irlan_eth_setup(struct net_device *dev)
+static void irlan_eth_setup(struct net_device *dev)
 {
-	struct irlan_cb *self;
-
-	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
-
-	self = (struct irlan_cb *) dev->priv;
-
 	dev->open               = irlan_eth_open;
 	dev->stop               = irlan_eth_close;
 	dev->hard_start_xmit    = irlan_eth_xmit; 
@@ -71,20 +70,30 @@ void irlan_eth_setup(struct net_device *
 	 * Queueing here as well can introduce some strange latency
 	 * problems, which we will avoid by setting the queue size to 0.
 	 */
-	dev->tx_queue_len = 0;
+	/*
+	 * The bugs in IrTTP and IrLAN that created this latency issue
+	 * have now been fixed, and we can propagate flow control properly
+	 * to the network layer. However, this requires a minimal queue of
+	 * packets for the device.
+	 * Without flow control, the Tx Queue is 14 (ttp) + 0 (dev) = 14
+	 * With flow control, the Tx Queue is 7 (ttp) + 4 (dev) = 11
+	 * See irlan_eth_flow_indication()...
+	 * Note : this number was randomly selected and would need to
+	 * be adjusted.
+	 * Jean II */
+	dev->tx_queue_len = 4;
+}
 
-	if (self->provider.access_type == ACCESS_DIRECT) {
-		/*  
-		 * Since we are emulating an IrLAN sever we will have to
-		 * give ourself an ethernet address!  
-		 */
-		dev->dev_addr[0] = 0x40;
-		dev->dev_addr[1] = 0x00;
-		dev->dev_addr[2] = 0x00;
-		dev->dev_addr[3] = 0x00;
-		get_random_bytes(dev->dev_addr+4, 1);
-		get_random_bytes(dev->dev_addr+5, 1);
-	}
+/*
+ * Function alloc_irlandev
+ *
+ *    Allocate network device and control block
+ *
+ */
+struct net_device *alloc_irlandev(const char *name)
+{
+	return alloc_netdev(sizeof(struct irlan_cb), name,
+			    irlan_eth_setup);
 }
 
 /*
@@ -93,18 +102,12 @@ void irlan_eth_setup(struct net_device *
  *    Network device has been opened by user
  *
  */
-int irlan_eth_open(struct net_device *dev)
+static int irlan_eth_open(struct net_device *dev)
 {
-	struct irlan_cb *self;
+	struct irlan_cb *self = netdev_priv(dev);
 	
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
-	ASSERT(dev != NULL, return -1;);
-
-	self = (struct irlan_cb *) dev->priv;
-
-	ASSERT(self != NULL, return -1;);
-
 	/* Ready to play! */
  	netif_stop_queue(dev); /* Wait until data link is ready */
 
@@ -126,10 +129,9 @@ int irlan_eth_open(struct net_device *de
  *    close timer, so that the instance will be removed if we are unable
  *    to discover the remote device after the disconnect.
  */
-int irlan_eth_close(struct net_device *dev)
+static int irlan_eth_close(struct net_device *dev)
 {
-	struct irlan_cb *self = (struct irlan_cb *) dev->priv;
-	struct sk_buff *skb;
+	struct irlan_cb *self = netdev_priv(dev);
 	
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 	
@@ -143,8 +145,7 @@ int irlan_eth_close(struct net_device *d
 	irlan_do_provider_event(self, IRLAN_LMP_DISCONNECT, NULL);	
 	
 	/* Remove frames queued on the control channel */
-	while ((skb = skb_dequeue(&self->client.txq)))
-			dev_kfree_skb(skb);
+	skb_queue_purge(&self->client.txq);
 
 	self->client.tx_busy = 0;
 	
@@ -157,16 +158,11 @@ int irlan_eth_close(struct net_device *d
  *    Transmits ethernet frames over IrDA link.
  *
  */
-int irlan_eth_xmit(struct sk_buff *skb, struct net_device *dev)
+static int irlan_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct irlan_cb *self;
+	struct irlan_cb *self = netdev_priv(dev);
 	int ret;
 
-	self = (struct irlan_cb *) dev->priv;
-
-	ASSERT(self != NULL, return 0;);
-	ASSERT(self->magic == IRLAN_MAGIC, return 0;);
-
 	/* skb headroom large enough to contain all IrDA-headers? */
 	if ((skb_headroom(skb) < self->max_header_size) || (skb_shared(skb))) {
 		struct sk_buff *new_skb = 
@@ -220,9 +216,7 @@ int irlan_eth_xmit(struct sk_buff *skb, 
  */
 int irlan_eth_receive(void *instance, void *sap, struct sk_buff *skb)
 {
-	struct irlan_cb *self;
-
-	self = (struct irlan_cb *) instance;
+	struct irlan_cb *self = instance;
 
 	if (skb == NULL) {
 		++self->stats.rx_dropped; 
@@ -251,6 +245,14 @@ int irlan_eth_receive(void *instance, vo
  *
  *    Do flow control between IP/Ethernet and IrLAN/IrTTP. This is done by 
  *    controlling the queue stop/start.
+ *
+ * The IrDA link layer has the advantage to have flow control, and
+ * IrTTP now properly handles that. Flow controlling the higher layers
+ * prevent us to drop Tx packets in here (up to 15% for a TCP socket,
+ * more for UDP socket).
+ * Also, this allow us to reduce the overall transmit queue, which means
+ * less latency in case of mixed traffic.
+ * Jean II
  */
 void irlan_eth_flow_indication(void *instance, void *sap, LOCAL_FLOW flow)
 {
@@ -266,37 +268,25 @@ void irlan_eth_flow_indication(void *ins
 
 	ASSERT(dev != NULL, return;);
 	
+	IRDA_DEBUG(0, "%s() : flow %s ; running %d\n", __FUNCTION__,
+		   flow == FLOW_STOP ? "FLOW_STOP" : "FLOW_START",
+		   netif_running(dev));
+
 	switch (flow) {
 	case FLOW_STOP:
+		/* IrTTP is full, stop higher layers */
 		netif_stop_queue(dev);
 		break;
 	case FLOW_START:
 	default:
 		/* Tell upper layers that its time to transmit frames again */
 		/* Schedule network layer */
-		netif_start_queue(dev);
+		netif_wake_queue(dev);
 		break;
 	}
 }
 
 /*
- * Function irlan_eth_rebuild_header (buff, dev, dest, skb)
- *
- *    If we don't want to use ARP. Currently not used!!
- *
- */
-void irlan_eth_rebuild_header(void *buff, struct net_device *dev, 
-			      unsigned long dest, struct sk_buff *skb)
-{
-	struct ethhdr *eth = (struct ethhdr *) buff;
-
-	memcpy(eth->h_source, dev->dev_addr, dev->addr_len);
-	memcpy(eth->h_dest, dev->dev_addr, dev->addr_len);
-
-	/* return 0; */
-}
-
-/*
  * Function irlan_etc_send_gratuitous_arp (dev)
  *
  *    Send gratuitous ARP to announce that we have changed
@@ -336,17 +326,12 @@ void irlan_eth_send_gratuitous_arp(struc
  *
  */
 #define HW_MAX_ADDRS 4 /* Must query to get it! */
-void irlan_eth_set_multicast_list(struct net_device *dev) 
+static void irlan_eth_set_multicast_list(struct net_device *dev) 
 {
- 	struct irlan_cb *self;
-
- 	self = dev->priv; 
+ 	struct irlan_cb *self = netdev_priv(dev);
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
- 	ASSERT(self != NULL, return;); 
- 	ASSERT(self->magic == IRLAN_MAGIC, return;);
-
 	/* Check if data channel has been connected yet */
 	if (self->client.state != IRLAN_DATA) {
 		IRDA_DEBUG(1, "%s(), delaying!\n", __FUNCTION__ );
@@ -388,12 +373,9 @@ void irlan_eth_set_multicast_list(struct
  *    Get the current statistics for this device
  *
  */
-struct net_device_stats *irlan_eth_get_stats(struct net_device *dev) 
+static struct net_device_stats *irlan_eth_get_stats(struct net_device *dev) 
 {
-	struct irlan_cb *self = (struct irlan_cb *) dev->priv;
-
-	ASSERT(self != NULL, return NULL;);
-	ASSERT(self->magic == IRLAN_MAGIC, return NULL;);
+	struct irlan_cb *self = netdev_priv(dev);
 
 	return &self->stats;
 }
