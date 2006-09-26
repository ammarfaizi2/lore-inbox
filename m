Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWIZVTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWIZVTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWIZVTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:19:10 -0400
Received: from khc.piap.pl ([195.187.100.11]:19372 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932417AbWIZVTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:19:03 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       PC300 Maintainer <pc300@cyclades.com>
Subject: [PATCH 1/2] Modularize generic HDLC
References: <m3odt21hs5.fsf@defiant.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 26 Sep 2006 23:18:53 +0200
In-Reply-To: <m3odt21hs5.fsf@defiant.localdomain> (Krzysztof Halasa's message of "Tue, 26 Sep 2006 22:42:34 +0200")
Message-ID: <m3k63q1g3m.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables building of individual WAN protocol support
routines (parts of generic HDLC) as separate modules.
All protocol-private definitions are moved from hdlc.h file
to protocol drivers. User-space interface and interface
between generic HDLC and underlying low-level HDLC drivers
are unchanged.

diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
index 54b8e49..58b7efb 100644
--- a/drivers/net/wan/Kconfig
+++ b/drivers/net/wan/Kconfig
@@ -154,7 +154,7 @@ config HDLC
 	  If unsure, say N.
 
 config HDLC_RAW
-	bool "Raw HDLC support"
+	tristate "Raw HDLC support"
 	depends on HDLC
 	help
 	  Generic HDLC driver supporting raw HDLC over WAN connections.
@@ -162,7 +162,7 @@ config HDLC_RAW
 	  If unsure, say N.
 
 config HDLC_RAW_ETH
-	bool "Raw HDLC Ethernet device support"
+	tristate "Raw HDLC Ethernet device support"
 	depends on HDLC
 	help
 	  Generic HDLC driver supporting raw HDLC Ethernet device emulation
@@ -173,7 +173,7 @@ config HDLC_RAW_ETH
 	  If unsure, say N.
 
 config HDLC_CISCO
-	bool "Cisco HDLC support"
+	tristate "Cisco HDLC support"
 	depends on HDLC
 	help
 	  Generic HDLC driver supporting Cisco HDLC over WAN connections.
@@ -181,7 +181,7 @@ config HDLC_CISCO
 	  If unsure, say N.
 
 config HDLC_FR
-	bool "Frame Relay support"
+	tristate "Frame Relay support"
 	depends on HDLC
 	help
 	  Generic HDLC driver supporting Frame Relay over WAN connections.
@@ -189,7 +189,7 @@ config HDLC_FR
 	  If unsure, say N.
 
 config HDLC_PPP
-	bool "Synchronous Point-to-Point Protocol (PPP) support"
+	tristate "Synchronous Point-to-Point Protocol (PPP) support"
 	depends on HDLC
 	help
 	  Generic HDLC driver supporting PPP over WAN connections.
@@ -197,7 +197,7 @@ config HDLC_PPP
 	  If unsure, say N.
 
 config HDLC_X25
-	bool "X.25 protocol support"
+	tristate "X.25 protocol support"
 	depends on HDLC && (LAPB=m && HDLC=m || LAPB=y)
 	help
 	  Generic HDLC driver supporting X.25 over WAN connections.
diff --git a/drivers/net/wan/Makefile b/drivers/net/wan/Makefile
index 316ca68..83ec2c8 100644
--- a/drivers/net/wan/Makefile
+++ b/drivers/net/wan/Makefile
@@ -9,14 +9,13 @@ cyclomx-y                       := cycx_
 cyclomx-$(CONFIG_CYCLOMX_X25)	+= cycx_x25.o
 cyclomx-objs			:= $(cyclomx-y)  
 
-hdlc-y				:= hdlc_generic.o
-hdlc-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
-hdlc-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
-hdlc-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
-hdlc-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
-hdlc-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o
-hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
-hdlc-objs			:= $(hdlc-y)
+obj-$(CONFIG_HDLC)		+= hdlc.o
+obj-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
+obj-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
+obj-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
+obj-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
+obj-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o	syncppp.o
+obj-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
 
 pc300-y				:= pc300_drv.o
 pc300-$(CONFIG_PC300_MLPPP)	+= pc300_tty.o
@@ -38,10 +37,6 @@ obj-$(CONFIG_CYCLADES_SYNC)	+= cycx_drv.
 obj-$(CONFIG_LAPBETHER)		+= lapbether.o
 obj-$(CONFIG_SBNI)		+= sbni.o
 obj-$(CONFIG_PC300)		+= pc300.o
-obj-$(CONFIG_HDLC)		+= hdlc.o
-ifeq ($(CONFIG_HDLC_PPP),y)
-  obj-$(CONFIG_HDLC)		+= syncppp.o
-endif
 obj-$(CONFIG_N2)		+= n2.o
 obj-$(CONFIG_C101)		+= c101.o
 obj-$(CONFIG_WANXL)		+= wanxl.o
diff --git a/drivers/net/wan/hdlc_generic.c b/drivers/net/wan/hdlc.c
similarity index 67%
rename from drivers/net/wan/hdlc_generic.c
rename to drivers/net/wan/hdlc.c
index 04ca1f7..846b39c 100644
--- a/drivers/net/wan/hdlc_generic.c
+++ b/drivers/net/wan/hdlc.c
@@ -1,7 +1,7 @@
 /*
  * Generic HDLC support routines for Linux
  *
- * Copyright (C) 1999 - 2005 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 1999 - 2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -17,9 +17,9 @@
  * Use sethdlc utility to set line parameters, protocol and PVCs
  *
  * How does it work:
- * - proto.open(), close(), start(), stop() calls are serialized.
+ * - proto->open(), close(), start(), stop() calls are serialized.
  *   The order is: open, [ start, stop ... ] close ...
- * - proto.start() and stop() are called with spin_lock_irq held.
+ * - proto->start() and stop() are called with spin_lock_irq held.
  */
 
 #include <linux/module.h>
@@ -38,10 +38,12 @@ #include <linux/notifier.h>
 #include <linux/hdlc.h>
 
 
-static const char* version = "HDLC support module revision 1.19";
+static const char* version = "HDLC support module revision 1.20";
 
 #undef DEBUG_LINK
 
+static struct hdlc_proto *first_proto = NULL;
+
 
 static int hdlc_change_mtu(struct net_device *dev, int new_mtu)
 {
@@ -63,11 +65,11 @@ static struct net_device_stats *hdlc_get
 static int hdlc_rcv(struct sk_buff *skb, struct net_device *dev,
 		    struct packet_type *p, struct net_device *orig_dev)
 {
-	hdlc_device *hdlc = dev_to_hdlc(dev);
-	if (hdlc->proto.netif_rx)
-		return hdlc->proto.netif_rx(skb);
+	struct hdlc_device_desc *desc = dev_to_desc(dev);
+	if (desc->netif_rx)
+		return desc->netif_rx(skb);
 
-	hdlc->stats.rx_dropped++; /* Shouldn't happen */
+	desc->stats.rx_dropped++; /* Shouldn't happen */
 	dev_kfree_skb(skb);
 	return NET_RX_DROP;
 }
@@ -77,8 +79,8 @@ static int hdlc_rcv(struct sk_buff *skb,
 static inline void hdlc_proto_start(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	if (hdlc->proto.start)
-		return hdlc->proto.start(dev);
+	if (hdlc->proto->start)
+		return hdlc->proto->start(dev);
 }
 
 
@@ -86,8 +88,8 @@ static inline void hdlc_proto_start(stru
 static inline void hdlc_proto_stop(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	if (hdlc->proto.stop)
-		return hdlc->proto.stop(dev);
+	if (hdlc->proto->stop)
+		return hdlc->proto->stop(dev);
 }
 
 
@@ -144,15 +146,15 @@ int hdlc_open(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 #ifdef DEBUG_LINK
-	printk(KERN_DEBUG "hdlc_open() carrier %i open %i\n",
+	printk(KERN_DEBUG "%s: hdlc_open() carrier %i open %i\n", dev->name,
 	       hdlc->carrier, hdlc->open);
 #endif
 
-	if (hdlc->proto.id == -1)
+	if (hdlc->proto == NULL)
 		return -ENOSYS;	/* no protocol attached */
 
-	if (hdlc->proto.open) {
-		int result = hdlc->proto.open(dev);
+	if (hdlc->proto->open) {
+		int result = hdlc->proto->open(dev);
 		if (result)
 			return result;
 	}
@@ -178,7 +180,7 @@ void hdlc_close(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 #ifdef DEBUG_LINK
-	printk(KERN_DEBUG "hdlc_close() carrier %i open %i\n",
+	printk(KERN_DEBUG "%s: hdlc_close() carrier %i open %i\n", dev->name,
 	       hdlc->carrier, hdlc->open);
 #endif
 
@@ -190,68 +192,34 @@ #endif
 
 	spin_unlock_irq(&hdlc->state_lock);
 
-	if (hdlc->proto.close)
-		hdlc->proto.close(dev);
+	if (hdlc->proto->close)
+		hdlc->proto->close(dev);
 }
 
 
 
-#ifndef CONFIG_HDLC_RAW
-#define hdlc_raw_ioctl(dev, ifr)	-ENOSYS
-#endif
-
-#ifndef CONFIG_HDLC_RAW_ETH
-#define hdlc_raw_eth_ioctl(dev, ifr)	-ENOSYS
-#endif
-
-#ifndef CONFIG_HDLC_PPP
-#define hdlc_ppp_ioctl(dev, ifr)	-ENOSYS
-#endif
-
-#ifndef CONFIG_HDLC_CISCO
-#define hdlc_cisco_ioctl(dev, ifr)	-ENOSYS
-#endif
-
-#ifndef CONFIG_HDLC_FR
-#define hdlc_fr_ioctl(dev, ifr)		-ENOSYS
-#endif
-
-#ifndef CONFIG_HDLC_X25
-#define hdlc_x25_ioctl(dev, ifr)	-ENOSYS
-#endif
-
-
 int hdlc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	hdlc_device *hdlc = dev_to_hdlc(dev);
-	unsigned int proto;
+	struct hdlc_proto *proto = first_proto;
+	int result;
 
 	if (cmd != SIOCWANDEV)
 		return -EINVAL;
 
-	switch(ifr->ifr_settings.type) {
-	case IF_PROTO_HDLC:
-	case IF_PROTO_HDLC_ETH:
-	case IF_PROTO_PPP:
-	case IF_PROTO_CISCO:
-	case IF_PROTO_FR:
-	case IF_PROTO_X25:
-		proto = ifr->ifr_settings.type;
-		break;
-
-	default:
-		proto = hdlc->proto.id;
+	if (dev_to_hdlc(dev)->proto) {
+		result = dev_to_hdlc(dev)->proto->ioctl(dev, ifr);
+		if (result != -EINVAL)
+			return result;
 	}
 
-	switch(proto) {
-	case IF_PROTO_HDLC:	return hdlc_raw_ioctl(dev, ifr);
-	case IF_PROTO_HDLC_ETH:	return hdlc_raw_eth_ioctl(dev, ifr);
-	case IF_PROTO_PPP:	return hdlc_ppp_ioctl(dev, ifr);
-	case IF_PROTO_CISCO:	return hdlc_cisco_ioctl(dev, ifr);
-	case IF_PROTO_FR:	return hdlc_fr_ioctl(dev, ifr);
-	case IF_PROTO_X25:	return hdlc_x25_ioctl(dev, ifr);
-	default:		return -EINVAL;
+	/* Not handled by currently attached protocol (if any) */
+
+	while (proto) {
+		if ((result = proto->ioctl(dev, ifr)) != -EINVAL)
+			return result;
+		proto = proto->next;
 	}
+	return -EINVAL;
 }
 
 void hdlc_setup(struct net_device *dev)
@@ -267,8 +235,6 @@ void hdlc_setup(struct net_device *dev)
 
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 
-	hdlc->proto.id = -1;
-	hdlc->proto.detach = NULL;
 	hdlc->carrier = 1;
 	hdlc->open = 0;
 	spin_lock_init(&hdlc->state_lock);
@@ -277,7 +243,8 @@ void hdlc_setup(struct net_device *dev)
 struct net_device *alloc_hdlcdev(void *priv)
 {
 	struct net_device *dev;
-	dev = alloc_netdev(sizeof(hdlc_device), "hdlc%d", hdlc_setup);
+	dev = alloc_netdev(sizeof(struct hdlc_device_desc) +
+			   sizeof(hdlc_device), "hdlc%d", hdlc_setup);
 	if (dev)
 		dev_to_hdlc(dev)->priv = priv;
 	return dev;
@@ -286,13 +253,71 @@ struct net_device *alloc_hdlcdev(void *p
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
-	hdlc_proto_detach(dev_to_hdlc(dev));
 	unregister_netdevice(dev);
+	detach_hdlc_protocol(dev);
 	rtnl_unlock();
 }
 
 
 
+int attach_hdlc_protocol(struct net_device *dev, struct hdlc_proto *proto,
+			 int (*rx)(struct sk_buff *skb), size_t size)
+{
+	detach_hdlc_protocol(dev);
+
+	if (!try_module_get(proto->module))
+		return -ENOSYS;
+
+	if (size)
+		if ((dev_to_hdlc(dev)->state = kmalloc(size,
+						       GFP_KERNEL)) == NULL) {
+			printk(KERN_WARNING "Memory squeeze on"
+			       " hdlc_proto_attach()\n");
+			module_put(proto->module);
+			return -ENOBUFS;
+		}
+	dev_to_hdlc(dev)->proto = proto;
+	dev_to_desc(dev)->netif_rx = rx;
+	return 0;
+}
+
+
+void detach_hdlc_protocol(struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+
+	if (hdlc->proto) {
+		if (hdlc->proto->detach)
+			hdlc->proto->detach(dev);
+		module_put(hdlc->proto->module);
+		hdlc->proto = NULL;
+	}
+	kfree(hdlc->state);
+	hdlc->state = NULL;
+}
+
+
+void register_hdlc_protocol(struct hdlc_proto *proto)
+{
+	proto->next = first_proto;
+	first_proto = proto;
+}
+
+
+void unregister_hdlc_protocol(struct hdlc_proto *proto)
+{
+	struct hdlc_proto **p = &first_proto;
+	while (*p) {
+		if (*p == proto) {
+			*p = proto->next;
+			return;
+		}
+		p = &((*p)->next);
+	}
+}
+
+
+
 MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
 MODULE_DESCRIPTION("HDLC support module");
 MODULE_LICENSE("GPL v2");
@@ -303,6 +328,10 @@ EXPORT_SYMBOL(hdlc_ioctl);
 EXPORT_SYMBOL(hdlc_setup);
 EXPORT_SYMBOL(alloc_hdlcdev);
 EXPORT_SYMBOL(unregister_hdlc_device);
+EXPORT_SYMBOL(register_hdlc_protocol);
+EXPORT_SYMBOL(unregister_hdlc_protocol);
+EXPORT_SYMBOL(attach_hdlc_protocol);
+EXPORT_SYMBOL(detach_hdlc_protocol);
 
 static struct packet_type hdlc_packet_type = {
 	.type = __constant_htons(ETH_P_HDLC),
diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index f289dab..7ec2b2f 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -2,7 +2,7 @@
  * Generic HDLC support routines for Linux
  * Cisco HDLC support
  *
- * Copyright (C) 2000 - 2003 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 2000 - 2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -34,17 +34,56 @@ #define CISCO_ADDR_REPLY	1	/* Cisco addr
 #define CISCO_KEEPALIVE_REQ	2	/* Cisco keepalive request */
 
 
+struct hdlc_header {
+	u8 address;
+	u8 control;
+	u16 protocol;
+}__attribute__ ((packed));
+
+
+struct cisco_packet {
+	u32 type;		/* code */
+	u32 par1;
+	u32 par2;
+	u16 rel;		/* reliability */
+	u32 time;
+}__attribute__ ((packed));
+#define	CISCO_PACKET_LEN	18
+#define	CISCO_BIG_PACKET_LEN	20
+
+
+struct cisco_state {
+	cisco_proto settings;
+
+	struct timer_list timer;
+	unsigned long last_poll;
+	int up;
+	int request_sent;
+	u32 txseq; /* TX sequence number */
+	u32 rxseq; /* RX sequence number */
+};
+
+
+static int cisco_ioctl(struct net_device *dev, struct ifreq *ifr);
+
+
+static inline struct cisco_state * state(hdlc_device *hdlc)
+{
+	return(struct cisco_state *)(hdlc->state);
+}
+
+
 static int cisco_hard_header(struct sk_buff *skb, struct net_device *dev,
 			     u16 type, void *daddr, void *saddr,
 			     unsigned int len)
 {
-	hdlc_header *data;
+	struct hdlc_header *data;
 #ifdef DEBUG_HARD_HEADER
 	printk(KERN_DEBUG "%s: cisco_hard_header called\n", dev->name);
 #endif
 
-	skb_push(skb, sizeof(hdlc_header));
-	data = (hdlc_header*)skb->data;
+	skb_push(skb, sizeof(struct hdlc_header));
+	data = (struct hdlc_header*)skb->data;
 	if (type == CISCO_KEEPALIVE)
 		data->address = CISCO_MULTICAST;
 	else
@@ -52,7 +91,7 @@ #endif
 	data->control = 0;
 	data->protocol = htons(type);
 
-	return sizeof(hdlc_header);
+	return sizeof(struct hdlc_header);
 }
 
 
@@ -61,9 +100,10 @@ static void cisco_keepalive_send(struct 
 				 u32 par1, u32 par2)
 {
 	struct sk_buff *skb;
-	cisco_packet *data;
+	struct cisco_packet *data;
 
-	skb = dev_alloc_skb(sizeof(hdlc_header) + sizeof(cisco_packet));
+	skb = dev_alloc_skb(sizeof(struct hdlc_header) +
+			    sizeof(struct cisco_packet));
 	if (!skb) {
 		printk(KERN_WARNING
 		       "%s: Memory squeeze on cisco_keepalive_send()\n",
@@ -72,7 +112,7 @@ static void cisco_keepalive_send(struct 
 	}
 	skb_reserve(skb, 4);
 	cisco_hard_header(skb, dev, CISCO_KEEPALIVE, NULL, NULL, 0);
-	data = (cisco_packet*)(skb->data + 4);
+	data = (struct cisco_packet*)(skb->data + 4);
 
 	data->type = htonl(type);
 	data->par1 = htonl(par1);
@@ -81,7 +121,7 @@ static void cisco_keepalive_send(struct 
 	/* we will need do_div here if 1000 % HZ != 0 */
 	data->time = htonl((jiffies - INITIAL_JIFFIES) * (1000 / HZ));
 
-	skb_put(skb, sizeof(cisco_packet));
+	skb_put(skb, sizeof(struct cisco_packet));
 	skb->priority = TC_PRIO_CONTROL;
 	skb->dev = dev;
 	skb->nh.raw = skb->data;
@@ -93,9 +133,9 @@ static void cisco_keepalive_send(struct 
 
 static __be16 cisco_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
-	hdlc_header *data = (hdlc_header*)skb->data;
+	struct hdlc_header *data = (struct hdlc_header*)skb->data;
 
-	if (skb->len < sizeof(hdlc_header))
+	if (skb->len < sizeof(struct hdlc_header))
 		return __constant_htons(ETH_P_HDLC);
 
 	if (data->address != CISCO_MULTICAST &&
@@ -106,7 +146,7 @@ static __be16 cisco_type_trans(struct sk
 	case __constant_htons(ETH_P_IP):
 	case __constant_htons(ETH_P_IPX):
 	case __constant_htons(ETH_P_IPV6):
-		skb_pull(skb, sizeof(hdlc_header));
+		skb_pull(skb, sizeof(struct hdlc_header));
 		return data->protocol;
 	default:
 		return __constant_htons(ETH_P_HDLC);
@@ -118,12 +158,12 @@ static int cisco_rx(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	hdlc_header *data = (hdlc_header*)skb->data;
-	cisco_packet *cisco_data;
+	struct hdlc_header *data = (struct hdlc_header*)skb->data;
+	struct cisco_packet *cisco_data;
 	struct in_device *in_dev;
 	u32 addr, mask;
 
-	if (skb->len < sizeof(hdlc_header))
+	if (skb->len < sizeof(struct hdlc_header))
 		goto rx_error;
 
 	if (data->address != CISCO_MULTICAST &&
@@ -137,15 +177,17 @@ static int cisco_rx(struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 
 	case CISCO_KEEPALIVE:
-		if (skb->len != sizeof(hdlc_header) + CISCO_PACKET_LEN &&
-		    skb->len != sizeof(hdlc_header) + CISCO_BIG_PACKET_LEN) {
-			printk(KERN_INFO "%s: Invalid length of Cisco "
-			       "control packet (%d bytes)\n",
-			       dev->name, skb->len);
+		if ((skb->len != sizeof(struct hdlc_header) +
+		     CISCO_PACKET_LEN) &&
+		    (skb->len != sizeof(struct hdlc_header) +
+		     CISCO_BIG_PACKET_LEN)) {
+			printk(KERN_INFO "%s: Invalid length of Cisco control"
+			       " packet (%d bytes)\n", dev->name, skb->len);
 			goto rx_error;
 		}
 
-		cisco_data = (cisco_packet*)(skb->data + sizeof(hdlc_header));
+		cisco_data = (struct cisco_packet*)(skb->data + sizeof
+						    (struct hdlc_header));
 
 		switch(ntohl (cisco_data->type)) {
 		case CISCO_ADDR_REQ: /* Stolen from syncppp.c :-) */
@@ -178,11 +220,11 @@ static int cisco_rx(struct sk_buff *skb)
 			goto rx_error;
 
 		case CISCO_KEEPALIVE_REQ:
-			hdlc->state.cisco.rxseq = ntohl(cisco_data->par1);
-			if (hdlc->state.cisco.request_sent &&
-			    ntohl(cisco_data->par2)==hdlc->state.cisco.txseq) {
-				hdlc->state.cisco.last_poll = jiffies;
-				if (!hdlc->state.cisco.up) {
+			state(hdlc)->rxseq = ntohl(cisco_data->par1);
+			if (state(hdlc)->request_sent &&
+			    ntohl(cisco_data->par2) == state(hdlc)->txseq) {
+				state(hdlc)->last_poll = jiffies;
+				if (!state(hdlc)->up) {
 					u32 sec, min, hrs, days;
 					sec = ntohl(cisco_data->time) / 1000;
 					min = sec / 60; sec -= min * 60;
@@ -193,7 +235,7 @@ static int cisco_rx(struct sk_buff *skb)
 					       dev->name, days, hrs,
 					       min, sec);
 					netif_dormant_off(dev);
-					hdlc->state.cisco.up = 1;
+					state(hdlc)->up = 1;
 				}
 			}
 
@@ -208,7 +250,7 @@ static int cisco_rx(struct sk_buff *skb)
 	return NET_RX_DROP;
 
  rx_error:
-	hdlc->stats.rx_errors++; /* Mark error */
+	dev_to_desc(dev)->stats.rx_errors++; /* Mark error */
 	dev_kfree_skb_any(skb);
 	return NET_RX_DROP;
 }
@@ -220,23 +262,22 @@ static void cisco_timer(unsigned long ar
 	struct net_device *dev = (struct net_device *)arg;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 
-	if (hdlc->state.cisco.up &&
-	    time_after(jiffies, hdlc->state.cisco.last_poll +
-		       hdlc->state.cisco.settings.timeout * HZ)) {
-		hdlc->state.cisco.up = 0;
+	if (state(hdlc)->up &&
+	    time_after(jiffies, state(hdlc)->last_poll +
+		       state(hdlc)->settings.timeout * HZ)) {
+		state(hdlc)->up = 0;
 		printk(KERN_INFO "%s: Link down\n", dev->name);
 		netif_dormant_on(dev);
 	}
 
-	cisco_keepalive_send(dev, CISCO_KEEPALIVE_REQ,
-			     ++hdlc->state.cisco.txseq,
-			     hdlc->state.cisco.rxseq);
-	hdlc->state.cisco.request_sent = 1;
-	hdlc->state.cisco.timer.expires = jiffies +
-		hdlc->state.cisco.settings.interval * HZ;
-	hdlc->state.cisco.timer.function = cisco_timer;
-	hdlc->state.cisco.timer.data = arg;
-	add_timer(&hdlc->state.cisco.timer);
+	cisco_keepalive_send(dev, CISCO_KEEPALIVE_REQ, ++state(hdlc)->txseq,
+			     state(hdlc)->rxseq);
+	state(hdlc)->request_sent = 1;
+	state(hdlc)->timer.expires = jiffies +
+		state(hdlc)->settings.interval * HZ;
+	state(hdlc)->timer.function = cisco_timer;
+	state(hdlc)->timer.data = arg;
+	add_timer(&state(hdlc)->timer);
 }
 
 
@@ -244,15 +285,15 @@ static void cisco_timer(unsigned long ar
 static void cisco_start(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	hdlc->state.cisco.up = 0;
-	hdlc->state.cisco.request_sent = 0;
-	hdlc->state.cisco.txseq = hdlc->state.cisco.rxseq = 0;
-
-	init_timer(&hdlc->state.cisco.timer);
-	hdlc->state.cisco.timer.expires = jiffies + HZ; /*First poll after 1s*/
-	hdlc->state.cisco.timer.function = cisco_timer;
-	hdlc->state.cisco.timer.data = (unsigned long)dev;
-	add_timer(&hdlc->state.cisco.timer);
+	state(hdlc)->up = 0;
+	state(hdlc)->request_sent = 0;
+	state(hdlc)->txseq = state(hdlc)->rxseq = 0;
+
+	init_timer(&state(hdlc)->timer);
+	state(hdlc)->timer.expires = jiffies + HZ; /*First poll after 1s*/
+	state(hdlc)->timer.function = cisco_timer;
+	state(hdlc)->timer.data = (unsigned long)dev;
+	add_timer(&state(hdlc)->timer);
 }
 
 
@@ -260,15 +301,24 @@ static void cisco_start(struct net_devic
 static void cisco_stop(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	del_timer_sync(&hdlc->state.cisco.timer);
+	del_timer_sync(&state(hdlc)->timer);
 	netif_dormant_on(dev);
-	hdlc->state.cisco.up = 0;
-	hdlc->state.cisco.request_sent = 0;
+	state(hdlc)->up = 0;
+	state(hdlc)->request_sent = 0;
 }
 
 
 
-int hdlc_cisco_ioctl(struct net_device *dev, struct ifreq *ifr)
+static struct hdlc_proto proto = {
+	.start		= cisco_start,
+	.stop		= cisco_stop,
+	.type_trans	= cisco_type_trans,
+	.ioctl		= cisco_ioctl,
+	.module		= THIS_MODULE,
+};
+ 
+ 
+static int cisco_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	cisco_proto __user *cisco_s = ifr->ifr_settings.ifs_ifsu.cisco;
 	const size_t size = sizeof(cisco_proto);
@@ -278,12 +328,14 @@ int hdlc_cisco_ioctl(struct net_device *
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
+		if (dev_to_hdlc(dev)->proto != &proto)
+			return -EINVAL;
 		ifr->ifr_settings.type = IF_PROTO_CISCO;
 		if (ifr->ifr_settings.size < size) {
 			ifr->ifr_settings.size = size; /* data size wanted */
 			return -ENOBUFS;
 		}
-		if (copy_to_user(cisco_s, &hdlc->state.cisco.settings, size))
+		if (copy_to_user(cisco_s, &state(hdlc)->settings, size))
 			return -EFAULT;
 		return 0;
 
@@ -302,19 +354,15 @@ int hdlc_cisco_ioctl(struct net_device *
 			return -EINVAL;
 
 		result=hdlc->attach(dev, ENCODING_NRZ,PARITY_CRC16_PR1_CCITT);
-
 		if (result)
 			return result;
 
-		hdlc_proto_detach(hdlc);
-		memcpy(&hdlc->state.cisco.settings, &new_settings, size);
-		memset(&hdlc->proto, 0, sizeof(hdlc->proto));
+		result = attach_hdlc_protocol(dev, &proto, cisco_rx,
+					      sizeof(struct cisco_state));
+		if (result)
+			return result;
 
-		hdlc->proto.start = cisco_start;
-		hdlc->proto.stop = cisco_stop;
-		hdlc->proto.netif_rx = cisco_rx;
-		hdlc->proto.type_trans = cisco_type_trans;
-		hdlc->proto.id = IF_PROTO_CISCO;
+		memcpy(&state(hdlc)->settings, &new_settings, size);
 		dev->hard_start_xmit = hdlc->xmit;
 		dev->hard_header = cisco_hard_header;
 		dev->hard_header_cache = NULL;
@@ -327,3 +375,25 @@ int hdlc_cisco_ioctl(struct net_device *
 
 	return -EINVAL;
 }
+
+
+static int __init mod_init(void)
+{
+	register_hdlc_protocol(&proto);
+	return 0;
+}
+
+
+
+static void __exit mod_exit(void)
+{
+	unregister_hdlc_protocol(&proto);
+}
+
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("Cisco HDLC protocol support for generic HDLC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 7bb737b..b45ab68 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -2,7 +2,7 @@
  * Generic HDLC support routines for Linux
  * Frame Relay support
  *
- * Copyright (C) 1999 - 2005 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 1999 - 2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -52,6 +52,8 @@ #include <linux/hdlc.h>
 #undef DEBUG_PKT
 #undef DEBUG_ECN
 #undef DEBUG_LINK
+#undef DEBUG_PROTO
+#undef DEBUG_PVC
 
 #define FR_UI			0x03
 #define FR_PAD			0x00
@@ -115,13 +117,53 @@ #endif
 }__attribute__ ((packed)) fr_hdr;
 
 
+typedef struct pvc_device_struct {
+	struct net_device *frad;
+	struct net_device *main;
+	struct net_device *ether;	/* bridged Ethernet interface	*/
+	struct pvc_device_struct *next;	/* Sorted in ascending DLCI order */
+	int dlci;
+	int open_count;
+
+	struct {
+		unsigned int new: 1;
+		unsigned int active: 1;
+		unsigned int exist: 1;
+		unsigned int deleted: 1;
+		unsigned int fecn: 1;
+		unsigned int becn: 1;
+		unsigned int bandwidth;	/* Cisco LMI reporting only */
+	}state;
+}pvc_device;
+
+
+struct frad_state {
+	fr_proto settings;
+	pvc_device *first_pvc;
+	int dce_pvc_count;
+
+	struct timer_list timer;
+	unsigned long last_poll;
+	int reliable;
+	int dce_changed;
+	int request;
+	int fullrep_sent;
+	u32 last_errors; /* last errors bit list */
+	u8 n391cnt;
+	u8 txseq; /* TX sequence number */
+	u8 rxseq; /* RX sequence number */
+};
+
+
+static int fr_ioctl(struct net_device *dev, struct ifreq *ifr);
+
+
 static inline u16 q922_to_dlci(u8 *hdr)
 {
 	return ((hdr[0] & 0xFC) << 2) | ((hdr[1] & 0xF0) >> 4);
 }
 
 
-
 static inline void dlci_to_q922(u8 *hdr, u16 dlci)
 {
 	hdr[0] = (dlci >> 2) & 0xFC;
@@ -129,10 +171,21 @@ static inline void dlci_to_q922(u8 *hdr,
 }
 
 
+static inline struct frad_state * state(hdlc_device *hdlc)
+{
+	return(struct frad_state *)(hdlc->state);
+}
+
+
+static __inline__ pvc_device* dev_to_pvc(struct net_device *dev)
+{
+	return dev->priv;
+}
+
 
 static inline pvc_device* find_pvc(hdlc_device *hdlc, u16 dlci)
 {
-	pvc_device *pvc = hdlc->state.fr.first_pvc;
+	pvc_device *pvc = state(hdlc)->first_pvc;
 
 	while (pvc) {
 		if (pvc->dlci == dlci)
@@ -146,10 +199,10 @@ static inline pvc_device* find_pvc(hdlc_
 }
 
 
-static inline pvc_device* add_pvc(struct net_device *dev, u16 dlci)
+static pvc_device* add_pvc(struct net_device *dev, u16 dlci)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	pvc_device *pvc, **pvc_p = &hdlc->state.fr.first_pvc;
+	pvc_device *pvc, **pvc_p = &state(hdlc)->first_pvc;
 
 	while (*pvc_p) {
 		if ((*pvc_p)->dlci == dlci)
@@ -160,12 +213,15 @@ static inline pvc_device* add_pvc(struct
 	}
 
 	pvc = kmalloc(sizeof(pvc_device), GFP_ATOMIC);
+#ifdef DEBUG_PVC
+	printk(KERN_DEBUG "add_pvc: allocated pvc %p, frad %p\n", pvc, dev);
+#endif
 	if (!pvc)
 		return NULL;
 
 	memset(pvc, 0, sizeof(pvc_device));
 	pvc->dlci = dlci;
-	pvc->master = dev;
+	pvc->frad = dev;
 	pvc->next = *pvc_p;	/* Put it in the chain */
 	*pvc_p = pvc;
 	return pvc;
@@ -174,7 +230,7 @@ static inline pvc_device* add_pvc(struct
 
 static inline int pvc_is_used(pvc_device *pvc)
 {
-	return pvc->main != NULL || pvc->ether != NULL;
+	return pvc->main || pvc->ether;
 }
 
 
@@ -200,11 +256,14 @@ static inline void pvc_carrier(int on, p
 
 static inline void delete_unused_pvcs(hdlc_device *hdlc)
 {
-	pvc_device **pvc_p = &hdlc->state.fr.first_pvc;
+	pvc_device **pvc_p = &state(hdlc)->first_pvc;
 
 	while (*pvc_p) {
 		if (!pvc_is_used(*pvc_p)) {
 			pvc_device *pvc = *pvc_p;
+#ifdef DEBUG_PVC
+			printk(KERN_DEBUG "freeing unused pvc: %p\n", pvc);
+#endif
 			*pvc_p = pvc->next;
 			kfree(pvc);
 			continue;
@@ -295,16 +354,16 @@ static int pvc_open(struct net_device *d
 {
 	pvc_device *pvc = dev_to_pvc(dev);
 
-	if ((pvc->master->flags & IFF_UP) == 0)
-		return -EIO;  /* Master must be UP in order to activate PVC */
+	if ((pvc->frad->flags & IFF_UP) == 0)
+		return -EIO;  /* Frad must be UP in order to activate PVC */
 
 	if (pvc->open_count++ == 0) {
-		hdlc_device *hdlc = dev_to_hdlc(pvc->master);
-		if (hdlc->state.fr.settings.lmi == LMI_NONE)
-			pvc->state.active = netif_carrier_ok(pvc->master);
+		hdlc_device *hdlc = dev_to_hdlc(pvc->frad);
+		if (state(hdlc)->settings.lmi == LMI_NONE)
+			pvc->state.active = netif_carrier_ok(pvc->frad);
 
 		pvc_carrier(pvc->state.active, pvc);
-		hdlc->state.fr.dce_changed = 1;
+		state(hdlc)->dce_changed = 1;
 	}
 	return 0;
 }
@@ -316,12 +375,12 @@ static int pvc_close(struct net_device *
 	pvc_device *pvc = dev_to_pvc(dev);
 
 	if (--pvc->open_count == 0) {
-		hdlc_device *hdlc = dev_to_hdlc(pvc->master);
-		if (hdlc->state.fr.settings.lmi == LMI_NONE)
+		hdlc_device *hdlc = dev_to_hdlc(pvc->frad);
+		if (state(hdlc)->settings.lmi == LMI_NONE)
 			pvc->state.active = 0;
 
-		if (hdlc->state.fr.settings.dce) {
-			hdlc->state.fr.dce_changed = 1;
+		if (state(hdlc)->settings.dce) {
+			state(hdlc)->dce_changed = 1;
 			pvc->state.active = 0;
 		}
 	}
@@ -348,7 +407,7 @@ static int pvc_ioctl(struct net_device *
 		}
 
 		info.dlci = pvc->dlci;
-		memcpy(info.master, pvc->master->name, IFNAMSIZ);
+		memcpy(info.master, pvc->frad->name, IFNAMSIZ);
 		if (copy_to_user(ifr->ifr_settings.ifs_ifsu.fr_pvc_info,
 				 &info, sizeof(info)))
 			return -EFAULT;
@@ -361,7 +420,7 @@ static int pvc_ioctl(struct net_device *
 
 static inline struct net_device_stats *pvc_get_stats(struct net_device *dev)
 {
-	return netdev_priv(dev);
+	return &dev_to_desc(dev)->stats;
 }
 
 
@@ -393,7 +452,7 @@ static int pvc_xmit(struct sk_buff *skb,
 			stats->tx_packets++;
 			if (pvc->state.fecn) /* TX Congestion counter */
 				stats->tx_compressed++;
-			skb->dev = pvc->master;
+			skb->dev = pvc->frad;
 			dev_queue_xmit(skb);
 			return 0;
 		}
@@ -419,7 +478,7 @@ static int pvc_change_mtu(struct net_dev
 static inline void fr_log_dlci_active(pvc_device *pvc)
 {
 	printk(KERN_INFO "%s: DLCI %d [%s%s%s]%s %s\n",
-	       pvc->master->name,
+	       pvc->frad->name,
 	       pvc->dlci,
 	       pvc->main ? pvc->main->name : "",
 	       pvc->main && pvc->ether ? " " : "",
@@ -438,21 +497,20 @@ static inline u8 fr_lmi_nextseq(u8 x)
 }
 
 
-
 static void fr_lmi_send(struct net_device *dev, int fullrep)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct sk_buff *skb;
-	pvc_device *pvc = hdlc->state.fr.first_pvc;
-	int lmi = hdlc->state.fr.settings.lmi;
-	int dce = hdlc->state.fr.settings.dce;
+	pvc_device *pvc = state(hdlc)->first_pvc;
+	int lmi = state(hdlc)->settings.lmi;
+	int dce = state(hdlc)->settings.dce;
 	int len = lmi == LMI_ANSI ? LMI_ANSI_LENGTH : LMI_CCITT_CISCO_LENGTH;
 	int stat_len = (lmi == LMI_CISCO) ? 6 : 3;
 	u8 *data;
 	int i = 0;
 
 	if (dce && fullrep) {
-		len += hdlc->state.fr.dce_pvc_count * (2 + stat_len);
+		len += state(hdlc)->dce_pvc_count * (2 + stat_len);
 		if (len > HDLC_MAX_MRU) {
 			printk(KERN_WARNING "%s: Too many PVCs while sending "
 			       "LMI full report\n", dev->name);
@@ -486,8 +544,9 @@ static void fr_lmi_send(struct net_devic
 	data[i++] = fullrep ? LMI_FULLREP : LMI_INTEGRITY;
 	data[i++] = lmi == LMI_CCITT ? LMI_CCITT_ALIVE : LMI_ANSI_CISCO_ALIVE;
 	data[i++] = LMI_INTEG_LEN;
-	data[i++] = hdlc->state.fr.txseq =fr_lmi_nextseq(hdlc->state.fr.txseq);
-	data[i++] = hdlc->state.fr.rxseq;
+	data[i++] = state(hdlc)->txseq =
+		fr_lmi_nextseq(state(hdlc)->txseq);
+	data[i++] = state(hdlc)->rxseq;
 
 	if (dce && fullrep) {
 		while (pvc) {
@@ -496,7 +555,7 @@ static void fr_lmi_send(struct net_devic
 			data[i++] = stat_len;
 
 			/* LMI start/restart */
-			if (hdlc->state.fr.reliable && !pvc->state.exist) {
+			if (state(hdlc)->reliable && !pvc->state.exist) {
 				pvc->state.exist = pvc->state.new = 1;
 				fr_log_dlci_active(pvc);
 			}
@@ -541,15 +600,15 @@ static void fr_lmi_send(struct net_devic
 static void fr_set_link_state(int reliable, struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	pvc_device *pvc = hdlc->state.fr.first_pvc;
+	pvc_device *pvc = state(hdlc)->first_pvc;
 
-	hdlc->state.fr.reliable = reliable;
+	state(hdlc)->reliable = reliable;
 	if (reliable) {
 		netif_dormant_off(dev);
-		hdlc->state.fr.n391cnt = 0; /* Request full status */
-		hdlc->state.fr.dce_changed = 1;
+		state(hdlc)->n391cnt = 0; /* Request full status */
+		state(hdlc)->dce_changed = 1;
 
-		if (hdlc->state.fr.settings.lmi == LMI_NONE) {
+		if (state(hdlc)->settings.lmi == LMI_NONE) {
 			while (pvc) {	/* Activate all PVCs */
 				pvc_carrier(1, pvc);
 				pvc->state.exist = pvc->state.active = 1;
@@ -563,7 +622,7 @@ static void fr_set_link_state(int reliab
 			pvc_carrier(0, pvc);
 			pvc->state.exist = pvc->state.active = 0;
 			pvc->state.new = 0;
-			if (!hdlc->state.fr.settings.dce)
+			if (!state(hdlc)->settings.dce)
 				pvc->state.bandwidth = 0;
 			pvc = pvc->next;
 		}
@@ -571,7 +630,6 @@ static void fr_set_link_state(int reliab
 }
 
 
-
 static void fr_timer(unsigned long arg)
 {
 	struct net_device *dev = (struct net_device *)arg;
@@ -579,62 +637,61 @@ static void fr_timer(unsigned long arg)
 	int i, cnt = 0, reliable;
 	u32 list;
 
-	if (hdlc->state.fr.settings.dce) {
-		reliable = hdlc->state.fr.request &&
-			time_before(jiffies, hdlc->state.fr.last_poll +
-				    hdlc->state.fr.settings.t392 * HZ);
-		hdlc->state.fr.request = 0;
+	if (state(hdlc)->settings.dce) {
+		reliable = state(hdlc)->request &&
+			time_before(jiffies, state(hdlc)->last_poll +
+				    state(hdlc)->settings.t392 * HZ);
+		state(hdlc)->request = 0;
 	} else {
-		hdlc->state.fr.last_errors <<= 1; /* Shift the list */
-		if (hdlc->state.fr.request) {
-			if (hdlc->state.fr.reliable)
+		state(hdlc)->last_errors <<= 1; /* Shift the list */
+		if (state(hdlc)->request) {
+			if (state(hdlc)->reliable)
 				printk(KERN_INFO "%s: No LMI status reply "
 				       "received\n", dev->name);
-			hdlc->state.fr.last_errors |= 1;
+			state(hdlc)->last_errors |= 1;
 		}
 
-		list = hdlc->state.fr.last_errors;
-		for (i = 0; i < hdlc->state.fr.settings.n393; i++, list >>= 1)
+		list = state(hdlc)->last_errors;
+		for (i = 0; i < state(hdlc)->settings.n393; i++, list >>= 1)
 			cnt += (list & 1);	/* errors count */
 
-		reliable = (cnt < hdlc->state.fr.settings.n392);
+		reliable = (cnt < state(hdlc)->settings.n392);
 	}
 
-	if (hdlc->state.fr.reliable != reliable) {
+	if (state(hdlc)->reliable != reliable) {
 		printk(KERN_INFO "%s: Link %sreliable\n", dev->name,
 		       reliable ? "" : "un");
 		fr_set_link_state(reliable, dev);
 	}
 
-	if (hdlc->state.fr.settings.dce)
-		hdlc->state.fr.timer.expires = jiffies +
-			hdlc->state.fr.settings.t392 * HZ;
+	if (state(hdlc)->settings.dce)
+		state(hdlc)->timer.expires = jiffies +
+			state(hdlc)->settings.t392 * HZ;
 	else {
-		if (hdlc->state.fr.n391cnt)
-			hdlc->state.fr.n391cnt--;
+		if (state(hdlc)->n391cnt)
+			state(hdlc)->n391cnt--;
 
-		fr_lmi_send(dev, hdlc->state.fr.n391cnt == 0);
+		fr_lmi_send(dev, state(hdlc)->n391cnt == 0);
 
-		hdlc->state.fr.last_poll = jiffies;
-		hdlc->state.fr.request = 1;
-		hdlc->state.fr.timer.expires = jiffies +
-			hdlc->state.fr.settings.t391 * HZ;
+		state(hdlc)->last_poll = jiffies;
+		state(hdlc)->request = 1;
+		state(hdlc)->timer.expires = jiffies +
+			state(hdlc)->settings.t391 * HZ;
 	}
 
-	hdlc->state.fr.timer.function = fr_timer;
-	hdlc->state.fr.timer.data = arg;
-	add_timer(&hdlc->state.fr.timer);
+	state(hdlc)->timer.function = fr_timer;
+	state(hdlc)->timer.data = arg;
+	add_timer(&state(hdlc)->timer);
 }
 
 
-
 static int fr_lmi_recv(struct net_device *dev, struct sk_buff *skb)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	pvc_device *pvc;
 	u8 rxseq, txseq;
-	int lmi = hdlc->state.fr.settings.lmi;
-	int dce = hdlc->state.fr.settings.dce;
+	int lmi = state(hdlc)->settings.lmi;
+	int dce = state(hdlc)->settings.dce;
 	int stat_len = (lmi == LMI_CISCO) ? 6 : 3, reptype, error, no_ram, i;
 
 	if (skb->len < (lmi == LMI_ANSI ? LMI_ANSI_LENGTH :
@@ -645,8 +702,8 @@ static int fr_lmi_recv(struct net_device
 
 	if (skb->data[3] != (lmi == LMI_CISCO ? NLPID_CISCO_LMI :
 			     NLPID_CCITT_ANSI_LMI)) {
-		printk(KERN_INFO "%s: Received non-LMI frame with LMI"
-		       " DLCI\n", dev->name);
+		printk(KERN_INFO "%s: Received non-LMI frame with LMI DLCI\n",
+		       dev->name);
 		return 1;
 	}
 
@@ -706,53 +763,53 @@ static int fr_lmi_recv(struct net_device
 	}
 	i++;
 
-	hdlc->state.fr.rxseq = skb->data[i++]; /* TX sequence from peer */
+	state(hdlc)->rxseq = skb->data[i++]; /* TX sequence from peer */
 	rxseq = skb->data[i++];	/* Should confirm our sequence */
 
-	txseq = hdlc->state.fr.txseq;
+	txseq = state(hdlc)->txseq;
 
 	if (dce)
-		hdlc->state.fr.last_poll = jiffies;
+		state(hdlc)->last_poll = jiffies;
 
 	error = 0;
-	if (!hdlc->state.fr.reliable)
+	if (!state(hdlc)->reliable)
 		error = 1;
 
-	if (rxseq == 0 || rxseq != txseq) {
-		hdlc->state.fr.n391cnt = 0; /* Ask for full report next time */
+	if (rxseq == 0 || rxseq != txseq) { /* Ask for full report next time */
+		state(hdlc)->n391cnt = 0;
 		error = 1;
 	}
 
 	if (dce) {
-		if (hdlc->state.fr.fullrep_sent && !error) {
+		if (state(hdlc)->fullrep_sent && !error) {
 /* Stop sending full report - the last one has been confirmed by DTE */
-			hdlc->state.fr.fullrep_sent = 0;
-			pvc = hdlc->state.fr.first_pvc;
+			state(hdlc)->fullrep_sent = 0;
+			pvc = state(hdlc)->first_pvc;
 			while (pvc) {
 				if (pvc->state.new) {
 					pvc->state.new = 0;
 
 /* Tell DTE that new PVC is now active */
-					hdlc->state.fr.dce_changed = 1;
+					state(hdlc)->dce_changed = 1;
 				}
 				pvc = pvc->next;
 			}
 		}
 
-		if (hdlc->state.fr.dce_changed) {
+		if (state(hdlc)->dce_changed) {
 			reptype = LMI_FULLREP;
-			hdlc->state.fr.fullrep_sent = 1;
-			hdlc->state.fr.dce_changed = 0;
+			state(hdlc)->fullrep_sent = 1;
+			state(hdlc)->dce_changed = 0;
 		}
 
-		hdlc->state.fr.request = 1; /* got request */
+		state(hdlc)->request = 1; /* got request */
 		fr_lmi_send(dev, reptype == LMI_FULLREP ? 1 : 0);
 		return 0;
 	}
 
 	/* DTE */
 
-	hdlc->state.fr.request = 0; /* got response, no request pending */
+	state(hdlc)->request = 0; /* got response, no request pending */
 
 	if (error)
 		return 0;
@@ -760,7 +817,7 @@ static int fr_lmi_recv(struct net_device
 	if (reptype != LMI_FULLREP)
 		return 0;
 
-	pvc = hdlc->state.fr.first_pvc;
+	pvc = state(hdlc)->first_pvc;
 
 	while (pvc) {
 		pvc->state.deleted = 1;
@@ -827,7 +884,7 @@ static int fr_lmi_recv(struct net_device
 		i += stat_len;
 	}
 
-	pvc = hdlc->state.fr.first_pvc;
+	pvc = state(hdlc)->first_pvc;
 
 	while (pvc) {
 		if (pvc->state.deleted && pvc->state.exist) {
@@ -841,17 +898,16 @@ static int fr_lmi_recv(struct net_device
 	}
 
 	/* Next full report after N391 polls */
-	hdlc->state.fr.n391cnt = hdlc->state.fr.settings.n391;
+	state(hdlc)->n391cnt = state(hdlc)->settings.n391;
 
 	return 0;
 }
 
 
-
 static int fr_rx(struct sk_buff *skb)
 {
-	struct net_device *ndev = skb->dev;
-	hdlc_device *hdlc = dev_to_hdlc(ndev);
+	struct net_device *frad = skb->dev;
+	hdlc_device *hdlc = dev_to_hdlc(frad);
 	fr_hdr *fh = (fr_hdr*)skb->data;
 	u8 *data = skb->data;
 	u16 dlci;
@@ -864,11 +920,11 @@ static int fr_rx(struct sk_buff *skb)
 	dlci = q922_to_dlci(skb->data);
 
 	if ((dlci == LMI_CCITT_ANSI_DLCI &&
-	     (hdlc->state.fr.settings.lmi == LMI_ANSI ||
-	      hdlc->state.fr.settings.lmi == LMI_CCITT)) ||
+	     (state(hdlc)->settings.lmi == LMI_ANSI ||
+	      state(hdlc)->settings.lmi == LMI_CCITT)) ||
 	    (dlci == LMI_CISCO_DLCI &&
-	     hdlc->state.fr.settings.lmi == LMI_CISCO)) {
-		if (fr_lmi_recv(ndev, skb))
+	     state(hdlc)->settings.lmi == LMI_CISCO)) {
+		if (fr_lmi_recv(frad, skb))
 			goto rx_error;
 		dev_kfree_skb_any(skb);
 		return NET_RX_SUCCESS;
@@ -878,7 +934,7 @@ static int fr_rx(struct sk_buff *skb)
 	if (!pvc) {
 #ifdef DEBUG_PKT
 		printk(KERN_INFO "%s: No PVC for received frame's DLCI %d\n",
-		       ndev->name, dlci);
+		       frad->name, dlci);
 #endif
 		dev_kfree_skb_any(skb);
 		return NET_RX_DROP;
@@ -886,7 +942,7 @@ #endif
 
 	if (pvc->state.fecn != fh->fecn) {
 #ifdef DEBUG_ECN
-		printk(KERN_DEBUG "%s: DLCI %d FECN O%s\n", ndev->name,
+		printk(KERN_DEBUG "%s: DLCI %d FECN O%s\n", frad->name,
 		       dlci, fh->fecn ? "N" : "FF");
 #endif
 		pvc->state.fecn ^= 1;
@@ -894,7 +950,7 @@ #endif
 
 	if (pvc->state.becn != fh->becn) {
 #ifdef DEBUG_ECN
-		printk(KERN_DEBUG "%s: DLCI %d BECN O%s\n", ndev->name,
+		printk(KERN_DEBUG "%s: DLCI %d BECN O%s\n", frad->name,
 		       dlci, fh->becn ? "N" : "FF");
 #endif
 		pvc->state.becn ^= 1;
@@ -902,7 +958,7 @@ #endif
 
 
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
-		hdlc->stats.rx_dropped++;
+		dev_to_desc(frad)->stats.rx_dropped++;
 		return NET_RX_DROP;
 	}
 
@@ -938,13 +994,13 @@ #endif
 
 		default:
 			printk(KERN_INFO "%s: Unsupported protocol, OUI=%x "
-			       "PID=%x\n", ndev->name, oui, pid);
+			       "PID=%x\n", frad->name, oui, pid);
 			dev_kfree_skb_any(skb);
 			return NET_RX_DROP;
 		}
 	} else {
 		printk(KERN_INFO "%s: Unsupported protocol, NLPID=%x "
-		       "length = %i\n", ndev->name, data[3], skb->len);
+		       "length = %i\n", frad->name, data[3], skb->len);
 		dev_kfree_skb_any(skb);
 		return NET_RX_DROP;
 	}
@@ -964,7 +1020,7 @@ #endif
 	}
 
  rx_error:
-	hdlc->stats.rx_errors++; /* Mark error */
+	dev_to_desc(frad)->stats.rx_errors++; /* Mark error */
 	dev_kfree_skb_any(skb);
 	return NET_RX_DROP;
 }
@@ -977,44 +1033,42 @@ static void fr_start(struct net_device *
 #ifdef DEBUG_LINK
 	printk(KERN_DEBUG "fr_start\n");
 #endif
-	if (hdlc->state.fr.settings.lmi != LMI_NONE) {
-		hdlc->state.fr.reliable = 0;
-		hdlc->state.fr.dce_changed = 1;
-		hdlc->state.fr.request = 0;
-		hdlc->state.fr.fullrep_sent = 0;
-		hdlc->state.fr.last_errors = 0xFFFFFFFF;
-		hdlc->state.fr.n391cnt = 0;
-		hdlc->state.fr.txseq = hdlc->state.fr.rxseq = 0;
-
-		init_timer(&hdlc->state.fr.timer);
+	if (state(hdlc)->settings.lmi != LMI_NONE) {
+		state(hdlc)->reliable = 0;
+		state(hdlc)->dce_changed = 1;
+		state(hdlc)->request = 0;
+		state(hdlc)->fullrep_sent = 0;
+		state(hdlc)->last_errors = 0xFFFFFFFF;
+		state(hdlc)->n391cnt = 0;
+		state(hdlc)->txseq = state(hdlc)->rxseq = 0;
+
+		init_timer(&state(hdlc)->timer);
 		/* First poll after 1 s */
-		hdlc->state.fr.timer.expires = jiffies + HZ;
-		hdlc->state.fr.timer.function = fr_timer;
-		hdlc->state.fr.timer.data = (unsigned long)dev;
-		add_timer(&hdlc->state.fr.timer);
+		state(hdlc)->timer.expires = jiffies + HZ;
+		state(hdlc)->timer.function = fr_timer;
+		state(hdlc)->timer.data = (unsigned long)dev;
+		add_timer(&state(hdlc)->timer);
 	} else
 		fr_set_link_state(1, dev);
 }
 
 
-
 static void fr_stop(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 #ifdef DEBUG_LINK
 	printk(KERN_DEBUG "fr_stop\n");
 #endif
-	if (hdlc->state.fr.settings.lmi != LMI_NONE)
-		del_timer_sync(&hdlc->state.fr.timer);
+	if (state(hdlc)->settings.lmi != LMI_NONE)
+		del_timer_sync(&state(hdlc)->timer);
 	fr_set_link_state(0, dev);
 }
 
 
-
 static void fr_close(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	pvc_device *pvc = hdlc->state.fr.first_pvc;
+	pvc_device *pvc = state(hdlc)->first_pvc;
 
 	while (pvc) {		/* Shutdown all PVCs for this FRAD */
 		if (pvc->main)
@@ -1025,7 +1079,8 @@ static void fr_close(struct net_device *
 	}
 }
 
-static void dlci_setup(struct net_device *dev)
+
+static void pvc_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_DLCI;
 	dev->flags = IFF_POINTOPOINT;
@@ -1033,9 +1088,9 @@ static void dlci_setup(struct net_device
 	dev->addr_len = 2;
 }
 
-static int fr_add_pvc(struct net_device *master, unsigned int dlci, int type)
+static int fr_add_pvc(struct net_device *frad, unsigned int dlci, int type)
 {
-	hdlc_device *hdlc = dev_to_hdlc(master);
+	hdlc_device *hdlc = dev_to_hdlc(frad);
 	pvc_device *pvc = NULL;
 	struct net_device *dev;
 	int result, used;
@@ -1044,9 +1099,9 @@ static int fr_add_pvc(struct net_device 
 	if (type == ARPHRD_ETHER)
 		prefix = "pvceth%d";
 
-	if ((pvc = add_pvc(master, dlci)) == NULL) {
+	if ((pvc = add_pvc(frad, dlci)) == NULL) {
 		printk(KERN_WARNING "%s: Memory squeeze on fr_add_pvc()\n",
-		       master->name);
+		       frad->name);
 		return -ENOBUFS;
 	}
 
@@ -1060,11 +1115,11 @@ static int fr_add_pvc(struct net_device 
 				   "pvceth%d", ether_setup);
 	else
 		dev = alloc_netdev(sizeof(struct net_device_stats),
-				   "pvc%d", dlci_setup);
+				   "pvc%d", pvc_setup);
 
 	if (!dev) {
 		printk(KERN_WARNING "%s: Memory squeeze on fr_pvc()\n",
-		       master->name);
+		       frad->name);
 		delete_unused_pvcs(hdlc);
 		return -ENOBUFS;
 	}
@@ -1102,8 +1157,8 @@ static int fr_add_pvc(struct net_device 
 	dev->destructor = free_netdev;
 	*get_dev_p(pvc, type) = dev;
 	if (!used) {
-		hdlc->state.fr.dce_changed = 1;
-		hdlc->state.fr.dce_pvc_count++;
+		state(hdlc)->dce_changed = 1;
+		state(hdlc)->dce_pvc_count++;
 	}
 	return 0;
 }
@@ -1128,8 +1183,8 @@ static int fr_del_pvc(hdlc_device *hdlc,
 	*get_dev_p(pvc, type) = NULL;
 
 	if (!pvc_is_used(pvc)) {
-		hdlc->state.fr.dce_pvc_count--;
-		hdlc->state.fr.dce_changed = 1;
+		state(hdlc)->dce_pvc_count--;
+		state(hdlc)->dce_changed = 1;
 	}
 	delete_unused_pvcs(hdlc);
 	return 0;
@@ -1137,14 +1192,13 @@ static int fr_del_pvc(hdlc_device *hdlc,
 
 
 
-static void fr_destroy(hdlc_device *hdlc)
+static void fr_destroy(struct net_device *frad)
 {
-	pvc_device *pvc;
-
-	pvc = hdlc->state.fr.first_pvc;
-	hdlc->state.fr.first_pvc = NULL; /* All PVCs destroyed */
-	hdlc->state.fr.dce_pvc_count = 0;
-	hdlc->state.fr.dce_changed = 1;
+	hdlc_device *hdlc = dev_to_hdlc(frad);
+	pvc_device *pvc = state(hdlc)->first_pvc;
+	state(hdlc)->first_pvc = NULL; /* All PVCs destroyed */
+	state(hdlc)->dce_pvc_count = 0;
+	state(hdlc)->dce_changed = 1;
 
 	while (pvc) {
 		pvc_device *next = pvc->next;
@@ -1161,8 +1215,17 @@ static void fr_destroy(hdlc_device *hdlc
 }
 
 
+static struct hdlc_proto proto = {
+	.close		= fr_close,
+	.start		= fr_start,
+	.stop		= fr_stop,
+	.detach		= fr_destroy,
+	.ioctl		= fr_ioctl,
+	.module		= THIS_MODULE,
+};
+
 
-int hdlc_fr_ioctl(struct net_device *dev, struct ifreq *ifr)
+static int fr_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	fr_proto __user *fr_s = ifr->ifr_settings.ifs_ifsu.fr;
 	const size_t size = sizeof(fr_proto);
@@ -1173,12 +1236,14 @@ int hdlc_fr_ioctl(struct net_device *dev
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
+		if (dev_to_hdlc(dev)->proto != &proto) /* Different proto */
+			return -EINVAL;
 		ifr->ifr_settings.type = IF_PROTO_FR;
 		if (ifr->ifr_settings.size < size) {
 			ifr->ifr_settings.size = size; /* data size wanted */
 			return -ENOBUFS;
 		}
-		if (copy_to_user(fr_s, &hdlc->state.fr.settings, size))
+		if (copy_to_user(fr_s, &state(hdlc)->settings, size))
 			return -EFAULT;
 		return 0;
 
@@ -1213,20 +1278,16 @@ int hdlc_fr_ioctl(struct net_device *dev
 		if (result)
 			return result;
 
-		if (hdlc->proto.id != IF_PROTO_FR) {
-			hdlc_proto_detach(hdlc);
-			hdlc->state.fr.first_pvc = NULL;
-			hdlc->state.fr.dce_pvc_count = 0;
+		if (dev_to_hdlc(dev)->proto != &proto) { /* Different proto */
+			result = attach_hdlc_protocol(dev, &proto, fr_rx,
+						      sizeof(struct frad_state));
+			if (result)
+				return result;
+			state(hdlc)->first_pvc = NULL;
+			state(hdlc)->dce_pvc_count = 0;
 		}
-		memcpy(&hdlc->state.fr.settings, &new_settings, size);
-		memset(&hdlc->proto, 0, sizeof(hdlc->proto));
-
-		hdlc->proto.close = fr_close;
-		hdlc->proto.start = fr_start;
-		hdlc->proto.stop = fr_stop;
-		hdlc->proto.detach = fr_destroy;
-		hdlc->proto.netif_rx = fr_rx;
-		hdlc->proto.id = IF_PROTO_FR;
+		memcpy(&state(hdlc)->settings, &new_settings, size);
+
 		dev->hard_start_xmit = hdlc->xmit;
 		dev->hard_header = NULL;
 		dev->type = ARPHRD_FRAD;
@@ -1238,6 +1299,9 @@ int hdlc_fr_ioctl(struct net_device *dev
 	case IF_PROTO_FR_DEL_PVC:
 	case IF_PROTO_FR_ADD_ETH_PVC:
 	case IF_PROTO_FR_DEL_ETH_PVC:
+		if (dev_to_hdlc(dev)->proto != &proto) /* Different proto */
+			return -EINVAL;
+
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
@@ -1263,3 +1327,24 @@ int hdlc_fr_ioctl(struct net_device *dev
 
 	return -EINVAL;
 }
+
+
+static int __init mod_init(void)
+{
+	register_hdlc_protocol(&proto);
+	return 0;
+}
+
+
+static void __exit mod_exit(void)
+{
+	unregister_hdlc_protocol(&proto);
+}
+
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("Frame-Relay protocol support for generic HDLC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index fbaab5b..e9f7170 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -2,7 +2,7 @@
  * Generic HDLC support routines for Linux
  * Point-to-point protocol support
  *
- * Copyright (C) 1999 - 2003 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 1999 - 2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -22,6 +22,21 @@ #include <linux/inetdevice.h>
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <net/syncppp.h>
+
+struct ppp_state {
+	struct ppp_device pppdev;
+	struct ppp_device *syncppp_ptr;
+	int (*old_change_mtu)(struct net_device *dev, int new_mtu);
+};
+
+static int ppp_ioctl(struct net_device *dev, struct ifreq *ifr);
+
+
+static inline struct ppp_state* state(hdlc_device *hdlc)
+{
+	return(struct ppp_state *)(hdlc->state);
+}
 
 
 static int ppp_open(struct net_device *dev)
@@ -30,16 +45,16 @@ static int ppp_open(struct net_device *d
 	void *old_ioctl;
 	int result;
 
-	dev->priv = &hdlc->state.ppp.syncppp_ptr;
-	hdlc->state.ppp.syncppp_ptr = &hdlc->state.ppp.pppdev;
-	hdlc->state.ppp.pppdev.dev = dev;
+	dev->priv = &state(hdlc)->syncppp_ptr;
+	state(hdlc)->syncppp_ptr = &state(hdlc)->pppdev;
+	state(hdlc)->pppdev.dev = dev;
 
 	old_ioctl = dev->do_ioctl;
-	hdlc->state.ppp.old_change_mtu = dev->change_mtu;
-	sppp_attach(&hdlc->state.ppp.pppdev);
+	state(hdlc)->old_change_mtu = dev->change_mtu;
+	sppp_attach(&state(hdlc)->pppdev);
 	/* sppp_attach nukes them. We don't need syncppp's ioctl */
 	dev->do_ioctl = old_ioctl;
-	hdlc->state.ppp.pppdev.sppp.pp_flags &= ~PP_CISCO;
+	state(hdlc)->pppdev.sppp.pp_flags &= ~PP_CISCO;
 	dev->type = ARPHRD_PPP;
 	result = sppp_open(dev);
 	if (result) {
@@ -59,7 +74,7 @@ static void ppp_close(struct net_device 
 	sppp_close(dev);
 	sppp_detach(dev);
 	dev->rebuild_header = NULL;
-	dev->change_mtu = hdlc->state.ppp.old_change_mtu;
+	dev->change_mtu = state(hdlc)->old_change_mtu;
 	dev->mtu = HDLC_MAX_MTU;
 	dev->hard_header_len = 16;
 }
@@ -73,13 +88,24 @@ static __be16 ppp_type_trans(struct sk_b
 
 
 
-int hdlc_ppp_ioctl(struct net_device *dev, struct ifreq *ifr)
+static struct hdlc_proto proto = {
+	.open		= ppp_open,
+	.close		= ppp_close,
+	.type_trans	= ppp_type_trans,
+	.ioctl		= ppp_ioctl,
+	.module		= THIS_MODULE,
+};
+
+
+static int ppp_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	int result;
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
+		if (dev_to_hdlc(dev)->proto != &proto)
+			return -EINVAL;
 		ifr->ifr_settings.type = IF_PROTO_PPP;
 		return 0; /* return protocol only, no settable parameters */
 
@@ -96,13 +122,10 @@ int hdlc_ppp_ioctl(struct net_device *de
 		if (result)
 			return result;
 
-		hdlc_proto_detach(hdlc);
-		memset(&hdlc->proto, 0, sizeof(hdlc->proto));
-
-		hdlc->proto.open = ppp_open;
-		hdlc->proto.close = ppp_close;
-		hdlc->proto.type_trans = ppp_type_trans;
-		hdlc->proto.id = IF_PROTO_PPP;
+		result = attach_hdlc_protocol(dev, &proto, NULL,
+					      sizeof(struct ppp_state));
+		if (result)
+			return result;
 		dev->hard_start_xmit = hdlc->xmit;
 		dev->hard_header = NULL;
 		dev->type = ARPHRD_PPP;
@@ -113,3 +136,25 @@ int hdlc_ppp_ioctl(struct net_device *de
 
 	return -EINVAL;
 }
+
+
+static int __init mod_init(void)
+{
+	register_hdlc_protocol(&proto);
+	return 0;
+}
+
+
+
+static void __exit mod_exit(void)
+{
+	unregister_hdlc_protocol(&proto);
+}
+
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("PPP protocol support for generic HDLC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wan/hdlc_raw.c b/drivers/net/wan/hdlc_raw.c
index f15aa6b..fe3cae5 100644
--- a/drivers/net/wan/hdlc_raw.c
+++ b/drivers/net/wan/hdlc_raw.c
@@ -2,7 +2,7 @@
  * Generic HDLC support routines for Linux
  * HDLC support
  *
- * Copyright (C) 1999 - 2003 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 1999 - 2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -24,6 +24,8 @@ #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
 
 
+static int raw_ioctl(struct net_device *dev, struct ifreq *ifr);
+
 static __be16 raw_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
 	return __constant_htons(ETH_P_IP);
@@ -31,7 +33,14 @@ static __be16 raw_type_trans(struct sk_b
 
 
 
-int hdlc_raw_ioctl(struct net_device *dev, struct ifreq *ifr)
+static struct hdlc_proto proto = {
+	.type_trans	= raw_type_trans,
+	.ioctl		= raw_ioctl,
+	.module		= THIS_MODULE,
+};
+
+
+static int raw_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	raw_hdlc_proto __user *raw_s = ifr->ifr_settings.ifs_ifsu.raw_hdlc;
 	const size_t size = sizeof(raw_hdlc_proto);
@@ -41,12 +50,14 @@ int hdlc_raw_ioctl(struct net_device *de
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
+		if (dev_to_hdlc(dev)->proto != &proto)
+			return -EINVAL;
 		ifr->ifr_settings.type = IF_PROTO_HDLC;
 		if (ifr->ifr_settings.size < size) {
 			ifr->ifr_settings.size = size; /* data size wanted */
 			return -ENOBUFS;
 		}
-		if (copy_to_user(raw_s, &hdlc->state.raw_hdlc.settings, size))
+		if (copy_to_user(raw_s, hdlc->state, size))
 			return -EFAULT;
 		return 0;
 
@@ -71,12 +82,11 @@ int hdlc_raw_ioctl(struct net_device *de
 		if (result)
 			return result;
 
-		hdlc_proto_detach(hdlc);
-		memcpy(&hdlc->state.raw_hdlc.settings, &new_settings, size);
-		memset(&hdlc->proto, 0, sizeof(hdlc->proto));
-
-		hdlc->proto.type_trans = raw_type_trans;
-		hdlc->proto.id = IF_PROTO_HDLC;
+		result = attach_hdlc_protocol(dev, &proto, NULL,
+					      sizeof(raw_hdlc_proto));
+		if (result)
+			return result;
+		memcpy(hdlc->state, &new_settings, size);
 		dev->hard_start_xmit = hdlc->xmit;
 		dev->hard_header = NULL;
 		dev->type = ARPHRD_RAWHDLC;
@@ -88,3 +98,25 @@ int hdlc_raw_ioctl(struct net_device *de
 
 	return -EINVAL;
 }
+
+
+static int __init mod_init(void)
+{
+	register_hdlc_protocol(&proto);
+	return 0;
+}
+
+
+
+static void __exit mod_exit(void)
+{
+	unregister_hdlc_protocol(&proto);
+}
+
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("Raw HDLC protocol support for generic HDLC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wan/hdlc_raw_eth.c b/drivers/net/wan/hdlc_raw_eth.c
index d188498..1a69a9a 100644
--- a/drivers/net/wan/hdlc_raw_eth.c
+++ b/drivers/net/wan/hdlc_raw_eth.c
@@ -2,7 +2,7 @@
  * Generic HDLC support routines for Linux
  * HDLC Ethernet emulation support
  *
- * Copyright (C) 2002-2003 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 2002-2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -25,6 +25,7 @@ #include <linux/rtnetlink.h>
 #include <linux/etherdevice.h>
 #include <linux/hdlc.h>
 
+static int raw_eth_ioctl(struct net_device *dev, struct ifreq *ifr);
 
 static int eth_tx(struct sk_buff *skb, struct net_device *dev)
 {
@@ -44,7 +45,14 @@ static int eth_tx(struct sk_buff *skb, s
 }
 
 
-int hdlc_raw_eth_ioctl(struct net_device *dev, struct ifreq *ifr)
+static struct hdlc_proto proto = {
+	.type_trans	= eth_type_trans,
+	.ioctl		= raw_eth_ioctl,
+	.module		= THIS_MODULE,
+};
+
+
+static int raw_eth_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	raw_hdlc_proto __user *raw_s = ifr->ifr_settings.ifs_ifsu.raw_hdlc;
 	const size_t size = sizeof(raw_hdlc_proto);
@@ -56,12 +64,14 @@ int hdlc_raw_eth_ioctl(struct net_device
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
+		if (dev_to_hdlc(dev)->proto != &proto)
+			return -EINVAL;
 		ifr->ifr_settings.type = IF_PROTO_HDLC_ETH;
 		if (ifr->ifr_settings.size < size) {
 			ifr->ifr_settings.size = size; /* data size wanted */
 			return -ENOBUFS;
 		}
-		if (copy_to_user(raw_s, &hdlc->state.raw_hdlc.settings, size))
+		if (copy_to_user(raw_s, hdlc->state, size))
 			return -EFAULT;
 		return 0;
 
@@ -86,12 +96,11 @@ int hdlc_raw_eth_ioctl(struct net_device
 		if (result)
 			return result;
 
-		hdlc_proto_detach(hdlc);
-		memcpy(&hdlc->state.raw_hdlc.settings, &new_settings, size);
-		memset(&hdlc->proto, 0, sizeof(hdlc->proto));
-
-		hdlc->proto.type_trans = eth_type_trans;
-		hdlc->proto.id = IF_PROTO_HDLC_ETH;
+		result = attach_hdlc_protocol(dev, &proto, NULL,
+					      sizeof(raw_hdlc_proto));
+		if (result)
+			return result;
+		memcpy(hdlc->state, &new_settings, size);
 		dev->hard_start_xmit = eth_tx;
 		old_ch_mtu = dev->change_mtu;
 		old_qlen = dev->tx_queue_len;
@@ -106,3 +115,25 @@ int hdlc_raw_eth_ioctl(struct net_device
 
 	return -EINVAL;
 }
+
+
+static int __init mod_init(void)
+{
+	register_hdlc_protocol(&proto);
+	return 0;
+}
+
+
+
+static void __exit mod_exit(void)
+{
+	unregister_hdlc_protocol(&proto);
+}
+
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("Ethernet encapsulation support for generic HDLC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
index a867fb4..e4bb9f8 100644
--- a/drivers/net/wan/hdlc_x25.c
+++ b/drivers/net/wan/hdlc_x25.c
@@ -2,7 +2,7 @@
  * Generic HDLC support routines for Linux
  * X.25 support
  *
- * Copyright (C) 1999 - 2003 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 1999 - 2006 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -25,6 +25,8 @@ #include <linux/hdlc.h>
 
 #include <net/x25device.h>
 
+static int x25_ioctl(struct net_device *dev, struct ifreq *ifr);
+
 /* These functions are callbacks called by LAPB layer */
 
 static void x25_connect_disconnect(struct net_device *dev, int reason, int code)
@@ -162,30 +164,39 @@ static void x25_close(struct net_device 
 
 static int x25_rx(struct sk_buff *skb)
 {
-	hdlc_device *hdlc = dev_to_hdlc(skb->dev);
+	struct hdlc_device_desc *desc = dev_to_desc(skb->dev);
 
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
-		hdlc->stats.rx_dropped++;
+		desc->stats.rx_dropped++;
 		return NET_RX_DROP;
 	}
 
 	if (lapb_data_received(skb->dev, skb) == LAPB_OK)
 		return NET_RX_SUCCESS;
 
-	hdlc->stats.rx_errors++;
+	desc->stats.rx_errors++;
 	dev_kfree_skb_any(skb);
 	return NET_RX_DROP;
 }
 
 
+static struct hdlc_proto proto = {
+	.open		= x25_open,
+	.close		= x25_close,
+	.ioctl		= x25_ioctl,
+	.module		= THIS_MODULE,
+};
+
 
-int hdlc_x25_ioctl(struct net_device *dev, struct ifreq *ifr)
+static int x25_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	int result;
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
+		if (dev_to_hdlc(dev)->proto != &proto)
+			return -EINVAL;
 		ifr->ifr_settings.type = IF_PROTO_X25;
 		return 0; /* return protocol only, no settable parameters */
 
@@ -200,14 +211,9 @@ int hdlc_x25_ioctl(struct net_device *de
 		if (result)
 			return result;
 
-		hdlc_proto_detach(hdlc);
-		memset(&hdlc->proto, 0, sizeof(hdlc->proto));
-
-		hdlc->proto.open = x25_open;
-		hdlc->proto.close = x25_close;
-		hdlc->proto.netif_rx = x25_rx;
-		hdlc->proto.type_trans = NULL;
-		hdlc->proto.id = IF_PROTO_X25;
+		if ((result = attach_hdlc_protocol(dev, &proto,
+						   x25_rx, 0)) != 0)
+			return result;
 		dev->hard_start_xmit = x25_xmit;
 		dev->hard_header = NULL;
 		dev->type = ARPHRD_X25;
@@ -218,3 +224,25 @@ int hdlc_x25_ioctl(struct net_device *de
 
 	return -EINVAL;
 }
+
+
+static int __init mod_init(void)
+{
+	register_hdlc_protocol(&proto);
+	return 0;
+}
+
+
+
+static void __exit mod_exit(void)
+{
+	unregister_hdlc_protocol(&proto);
+}
+
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("X.25 protocol support for generic HDLC");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/hdlc.h b/include/linux/hdlc.h
index d5ebbb2..d4b3339 100644
--- a/include/linux/hdlc.h
+++ b/include/linux/hdlc.h
@@ -11,95 +11,46 @@
 #ifndef __HDLC_H
 #define __HDLC_H
 
-#define GENERIC_HDLC_VERSION 4	/* For synchronization with sethdlc utility */
-
-#define CLOCK_DEFAULT   0	/* Default setting */
-#define CLOCK_EXT	1	/* External TX and RX clock - DTE */
-#define CLOCK_INT	2	/* Internal TX and RX clock - DCE */
-#define CLOCK_TXINT	3	/* Internal TX and external RX clock */
-#define CLOCK_TXFROMRX	4	/* TX clock derived from external RX clock */
-
-
-#define ENCODING_DEFAULT	0 /* Default setting */
-#define ENCODING_NRZ		1
-#define ENCODING_NRZI		2
-#define ENCODING_FM_MARK	3
-#define ENCODING_FM_SPACE	4
-#define ENCODING_MANCHESTER	5
-
-
-#define PARITY_DEFAULT		0 /* Default setting */
-#define PARITY_NONE		1 /* No parity */
-#define PARITY_CRC16_PR0	2 /* CRC16, initial value 0x0000 */
-#define PARITY_CRC16_PR1	3 /* CRC16, initial value 0xFFFF */
-#define PARITY_CRC16_PR0_CCITT	4 /* CRC16, initial 0x0000, ITU-T version */
-#define PARITY_CRC16_PR1_CCITT	5 /* CRC16, initial 0xFFFF, ITU-T version */
-#define PARITY_CRC32_PR0_CCITT	6 /* CRC32, initial value 0x00000000 */
-#define PARITY_CRC32_PR1_CCITT	7 /* CRC32, initial value 0xFFFFFFFF */
-
-#define LMI_DEFAULT		0 /* Default setting */
-#define LMI_NONE		1 /* No LMI, all PVCs are static */
-#define LMI_ANSI		2 /* ANSI Annex D */
-#define LMI_CCITT		3 /* ITU-T Annex A */
-#define LMI_CISCO		4 /* The "original" LMI, aka Gang of Four */
 
 #define HDLC_MAX_MTU 1500	/* Ethernet 1500 bytes */
+#if 0
 #define HDLC_MAX_MRU (HDLC_MAX_MTU + 10 + 14 + 4) /* for ETH+VLAN over FR */
+#else
+#define HDLC_MAX_MRU 1600 /* as required for FR network */
+#endif
 
 
 #ifdef __KERNEL__
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <net/syncppp.h>
 #include <linux/hdlc/ioctl.h>
 
 
-typedef struct {		/* Used in Cisco and PPP mode */
-	u8 address;
-	u8 control;
-	u16 protocol;
-}__attribute__ ((packed)) hdlc_header;
-
-
-
-typedef struct {
-	u32 type;		/* code */
-	u32 par1;
-	u32 par2;
-	u16 rel;		/* reliability */
-	u32 time;
-}__attribute__ ((packed)) cisco_packet;
-#define	CISCO_PACKET_LEN	18
-#define	CISCO_BIG_PACKET_LEN	20
-
-
-
-typedef struct pvc_device_struct {
-	struct net_device *master;
-	struct net_device *main;
-	struct net_device *ether; /* bridged Ethernet interface */
-	struct pvc_device_struct *next;	/* Sorted in ascending DLCI order */
-	int dlci;
-	int open_count;
-
-	struct {
-		unsigned int new: 1;
-		unsigned int active: 1;
-		unsigned int exist: 1;
-		unsigned int deleted: 1;
-		unsigned int fecn: 1;
-		unsigned int becn: 1;
-		unsigned int bandwidth;	/* Cisco LMI reporting only */
-	}state;
-}pvc_device;
-
-
-
-typedef struct hdlc_device_struct {
-	/* To be initialized by hardware driver */
+/* Used by all network devices here, pointed to by netdev_priv(dev) */
+struct hdlc_device_desc {
+	int (*netif_rx)(struct sk_buff *skb);
 	struct net_device_stats stats;
-
+};
+
+/* This structure is a private property of HDLC protocols.
+   Hardware drivers have no interest here */
+
+struct hdlc_proto {
+	int (*open)(struct net_device *dev);
+	void (*close)(struct net_device *dev);
+	void (*start)(struct net_device *dev); /* if open & DCD */
+	void (*stop)(struct net_device *dev); /* if open & !DCD */
+	void (*detach)(struct net_device *dev);
+	int (*ioctl)(struct net_device *dev, struct ifreq *ifr);
+	unsigned short (*type_trans)(struct sk_buff *skb,
+				     struct net_device *dev);
+	struct module *module;
+	struct hdlc_proto *next; /* next protocol in the list */
+};
+
+
+typedef struct hdlc_device {
 	/* used by HDLC layer to take control over HDLC device from hw driver*/
 	int (*attach)(struct net_device *dev,
 		      unsigned short encoding, unsigned short parity);
@@ -107,82 +58,18 @@ typedef struct hdlc_device_struct {
 	/* hardware driver must handle this instead of dev->hard_start_xmit */
 	int (*xmit)(struct sk_buff *skb, struct net_device *dev);
 
-
 	/* Things below are for HDLC layer internal use only */
-	struct {
-		int (*open)(struct net_device *dev);
-		void (*close)(struct net_device *dev);
-
-		/* if open & DCD */
-		void (*start)(struct net_device *dev);
-		/* if open & !DCD */
-		void (*stop)(struct net_device *dev);
-
-		void (*detach)(struct hdlc_device_struct *hdlc);
-		int (*netif_rx)(struct sk_buff *skb);
-		unsigned short (*type_trans)(struct sk_buff *skb,
-					     struct net_device *dev);
-		int id;		/* IF_PROTO_HDLC/CISCO/FR/etc. */
-	}proto;
-
+	const struct hdlc_proto *proto;
 	int carrier;
 	int open;
 	spinlock_t state_lock;
-
-	union {
-		struct {
-			fr_proto settings;
-			pvc_device *first_pvc;
-			int dce_pvc_count;
-
-			struct timer_list timer;
-			unsigned long last_poll;
-			int reliable;
-			int dce_changed;
-			int request;
-			int fullrep_sent;
-			u32 last_errors; /* last errors bit list */
-			u8 n391cnt;
-			u8 txseq; /* TX sequence number */
-			u8 rxseq; /* RX sequence number */
-		}fr;
-
-		struct {
-			cisco_proto settings;
-
-			struct timer_list timer;
-			unsigned long last_poll;
-			int up;
-			int request_sent;
-			u32 txseq; /* TX sequence number */
-			u32 rxseq; /* RX sequence number */
-		}cisco;
-
-		struct {
-			raw_hdlc_proto settings;
-		}raw_hdlc;
-
-		struct {
-			struct ppp_device pppdev;
-			struct ppp_device *syncppp_ptr;
-			int (*old_change_mtu)(struct net_device *dev,
-					      int new_mtu);
-		}ppp;
-	}state;
+	void *state;
 	void *priv;
 }hdlc_device;
 
 
 
-int hdlc_raw_ioctl(struct net_device *dev, struct ifreq *ifr);
-int hdlc_raw_eth_ioctl(struct net_device *dev, struct ifreq *ifr);
-int hdlc_cisco_ioctl(struct net_device *dev, struct ifreq *ifr);
-int hdlc_ppp_ioctl(struct net_device *dev, struct ifreq *ifr);
-int hdlc_fr_ioctl(struct net_device *dev, struct ifreq *ifr);
-int hdlc_x25_ioctl(struct net_device *dev, struct ifreq *ifr);
-
-
-/* Exported from hdlc.o */
+/* Exported from hdlc module */
 
 /* Called by hardware driver when a user requests HDLC service */
 int hdlc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
@@ -191,17 +78,21 @@ int hdlc_ioctl(struct net_device *dev, s
 #define register_hdlc_device(dev)	register_netdev(dev)
 void unregister_hdlc_device(struct net_device *dev);
 
+
+void register_hdlc_protocol(struct hdlc_proto *proto);
+void unregister_hdlc_protocol(struct hdlc_proto *proto);
+
 struct net_device *alloc_hdlcdev(void *priv);
 
-static __inline__ hdlc_device* dev_to_hdlc(struct net_device *dev)
+
+static __inline__ struct hdlc_device_desc* dev_to_desc(struct net_device *dev)
 {
 	return netdev_priv(dev);
 }
 
-
-static __inline__ pvc_device* dev_to_pvc(struct net_device *dev)
+static __inline__ hdlc_device* dev_to_hdlc(struct net_device *dev)
 {
-	return (pvc_device*)dev->priv;
+	return netdev_priv(dev) + sizeof(struct hdlc_device_desc);
 }
 
 
@@ -225,18 +116,14 @@ int hdlc_open(struct net_device *dev);
 /* Must be called by hardware driver when HDLC device is being closed */
 void hdlc_close(struct net_device *dev);
 
+int attach_hdlc_protocol(struct net_device *dev, struct hdlc_proto *proto,
+			 int (*rx)(struct sk_buff *skb), size_t size);
 /* May be used by hardware driver to gain control over HDLC device */
-static __inline__ void hdlc_proto_detach(hdlc_device *hdlc)
-{
-	if (hdlc->proto.detach)
-		hdlc->proto.detach(hdlc);
-	hdlc->proto.detach = NULL;
-}
-
+void detach_hdlc_protocol(struct net_device *dev);
 
 static __inline__ struct net_device_stats *hdlc_stats(struct net_device *dev)
 {
-	return &dev_to_hdlc(dev)->stats;
+	return &dev_to_desc(dev)->stats;
 }
 
 
@@ -248,8 +135,8 @@ static __inline__ __be16 hdlc_type_trans
 	skb->mac.raw  = skb->data;
 	skb->dev      = dev;
 
-	if (hdlc->proto.type_trans)
-		return hdlc->proto.type_trans(skb, dev);
+	if (hdlc->proto->type_trans)
+		return hdlc->proto->type_trans(skb, dev);
 	else
 		return htons(ETH_P_HDLC);
 }
diff --git a/include/linux/hdlc/ioctl.h b/include/linux/hdlc/ioctl.h
index 78430ba..5839723 100644
--- a/include/linux/hdlc/ioctl.h
+++ b/include/linux/hdlc/ioctl.h
@@ -1,6 +1,39 @@
 #ifndef __HDLC_IOCTL_H__
 #define __HDLC_IOCTL_H__
 
+
+#define GENERIC_HDLC_VERSION 4	/* For synchronization with sethdlc utility */
+
+#define CLOCK_DEFAULT   0	/* Default setting */
+#define CLOCK_EXT	1	/* External TX and RX clock - DTE */
+#define CLOCK_INT	2	/* Internal TX and RX clock - DCE */
+#define CLOCK_TXINT	3	/* Internal TX and external RX clock */
+#define CLOCK_TXFROMRX	4	/* TX clock derived from external RX clock */
+
+
+#define ENCODING_DEFAULT	0 /* Default setting */
+#define ENCODING_NRZ		1
+#define ENCODING_NRZI		2
+#define ENCODING_FM_MARK	3
+#define ENCODING_FM_SPACE	4
+#define ENCODING_MANCHESTER	5
+
+
+#define PARITY_DEFAULT		0 /* Default setting */
+#define PARITY_NONE		1 /* No parity */
+#define PARITY_CRC16_PR0	2 /* CRC16, initial value 0x0000 */
+#define PARITY_CRC16_PR1	3 /* CRC16, initial value 0xFFFF */
+#define PARITY_CRC16_PR0_CCITT	4 /* CRC16, initial 0x0000, ITU-T version */
+#define PARITY_CRC16_PR1_CCITT	5 /* CRC16, initial 0xFFFF, ITU-T version */
+#define PARITY_CRC32_PR0_CCITT	6 /* CRC32, initial value 0x00000000 */
+#define PARITY_CRC32_PR1_CCITT	7 /* CRC32, initial value 0xFFFFFFFF */
+
+#define LMI_DEFAULT		0 /* Default setting */
+#define LMI_NONE		1 /* No LMI, all PVCs are static */
+#define LMI_ANSI		2 /* ANSI Annex D */
+#define LMI_CCITT		3 /* ITU-T Annex A */
+#define LMI_CISCO		4 /* The "original" LMI, aka Gang of Four */
+
 typedef struct { 
 	unsigned int clock_rate; /* bits per second */
 	unsigned int clock_type; /* internal, external, TX-internal etc. */
