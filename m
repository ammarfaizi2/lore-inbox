Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbTGOMIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbTGOMIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:08:20 -0400
Received: from mail.convergence.de ([212.84.236.4]:33184 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267381AbTGOMGG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:06 -0400
Subject: [PATCH 3/17] Major dvb net code cleanup, many fixes
In-Reply-To: <10582716533707@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:54 +0200
Message-Id: <10582716541717@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - code review and fix the old race condition in dev->set_multicast_list
[DVB] - use tq_schedule instead of tq_immediate
[DVB] - remove card_num and dev_num from struct dvb_net (now obsolete)
[DVB] - prevent interface from being removed while it is in use
[DVB] - allow add/remove only for the superuser
[DVB] - set check-CRC flag on section filter to drop broken packets
[DVB] - some more debug printfs in filter handling code
[DVB] - cleaned up and commented packet reception handler
[DVB] - fix formatting
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_net.c linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_net.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_net.c	2003-06-25 09:50:42.000000000 +0200
@@ -24,22 +24,25 @@
  * 
  */
 
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/ioctl.h>
-#include <linux/slab.h>
-#include <asm/uaccess.h>
-
 #include <linux/dvb/net.h>
+#include <asm/uaccess.h>
 
 #include "dvb_demux.h"
 #include "dvb_net.h"
 #include "dvb_functions.h"
 
+
+#if 1
+#define dprintk(x...) printk(x)
+#else
+#define dprintk(x...)
+#endif
+
+
 #define DVB_NET_MULTICAST_MAX 10
 
 struct dvb_net_priv {
+	int in_use;
         struct net_device_stats stats;
         char name[6];
 	u16 pid;
@@ -49,10 +52,16 @@
 	int multi_num;
 	struct dmx_section_filter *multi_secfilter[DVB_NET_MULTICAST_MAX];
 	unsigned char multi_macs[DVB_NET_MULTICAST_MAX][6];
-	int mode;
+	int rx_mode;
+#define RX_MODE_UNI 0
+#define RX_MODE_MULTI 1
+#define RX_MODE_ALL_MULTI 2
+#define RX_MODE_PROMISC 3
+	struct work_struct wq;
 };
 
-/*
+
+/**
  *	Determine the packet's protocol ID. The rule here is that we 
  *	assume 802.3 if the type field is short enough to be a length.
  *	This is normal practice and works for any 'now in use' protocol.
@@ -60,8 +69,8 @@
  *  stolen from eth.c out of the linux kernel, hacked for dvb-device
  *  by Michael Holzt <kju@debian.org>
  */
- 
-unsigned short my_eth_type_trans(struct sk_buff *skb, struct net_device *dev)
+static unsigned short dvb_net_eth_type_trans(struct sk_buff *skb,
+				      struct net_device *dev)
 {
 	struct ethhdr *eth;
 	unsigned char *rawp;
@@ -70,8 +79,7 @@
 	skb_pull(skb,dev->hard_header_len);
 	eth= skb->mac.ethernet;
 	
-	if(*eth->h_dest&1)
-	{
+	if (*eth->h_dest & 1) {
 		if(memcmp(eth->h_dest,dev->broadcast, ETH_ALEN)==0)
 			skb->pkt_type=PACKET_BROADCAST;
 		else
@@ -83,7 +91,7 @@
 		
 	rawp = skb->data;
 	
-	/*
+	/**
 	 *	This is a magic hack to spot IPX packets. Older Novell breaks
 	 *	the protocol design and runs IPX over 802.3 without an 802.2 LLC
 	 *	layer. We look for FFFF which isn't a used 802.2 SSAP/DSAP. This
@@ -92,31 +100,60 @@
 	if (*(unsigned short *)rawp == 0xFFFF)
 		return htons(ETH_P_802_3);
 		
-	/*
+	/**
 	 *	Real 802.2 LLC
 	 */
 	return htons(ETH_P_802_2);
 }
 
-static void dvb_net_sec(struct net_device *dev, const u8 *pkt, int pkt_len)
+
+static void dvb_net_sec(struct net_device *dev, u8 *pkt, int pkt_len)
 {
         u8 *eth;
         struct sk_buff *skb;
 
-        if (pkt_len<13) {
-                printk("%s: IP/MPE packet length = %d too small.\n", dev->name, pkt_len);
+	/* note: pkt_len includes a 32bit checksum */
+	if (pkt_len < 16) {
+		printk("%s: IP/MPE packet length = %d too small.\n",
+			dev->name, pkt_len);
+		((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+		((struct dvb_net_priv *) dev->priv)->stats.rx_length_errors++;
+		return;
+	}
+	if ((pkt[5] & 0xfd) != 0xc1) {
+		/* drop scrambled or broken packets */
+		((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+		((struct dvb_net_priv *) dev->priv)->stats.rx_crc_errors++;
 		return;
 	}
-        skb = dev_alloc_skb(pkt_len+2);
-        if (skb == NULL) {
-                printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n",
-                       dev->name);
+	if (pkt[5] & 0x02) {
+		//FIXME: handle LLC/SNAP
                 ((struct dvb_net_priv *)dev->priv)->stats.rx_dropped++;
                 return;
         }
-        eth=(u8 *) skb_put(skb, pkt_len+2);
-        memcpy(eth+14, (void*)pkt+12, pkt_len-12);
+	if (pkt[7]) {
+		/* FIXME: assemble datagram from multiple sections */
+		((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+		((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+		return;
+	}
+
+	/* we have 14 byte ethernet header (ip header follows);
+	 * 12 byte MPE header; 4 byte checksum; + 2 byte alignment
+	 */
+	if (!(skb = dev_alloc_skb(pkt_len - 4 - 12 + 14 + 2))) {
+		//printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n", dev->name);
+		((struct dvb_net_priv *) dev->priv)->stats.rx_dropped++;
+		return;
+	}
+	skb_reserve(skb, 2);    /* longword align L3 header */
+	skb->dev = dev;
+
+	/* copy L3 payload */
+	eth = (u8 *) skb_put(skb, pkt_len - 12 - 4 + 14);
+	memcpy(eth + 14, pkt + 12, pkt_len - 12 - 4);
 
+	/* create ethernet header: */
         eth[0]=pkt[0x0b];
         eth[1]=pkt[0x0a];
         eth[2]=pkt[0x09];
@@ -123,11 +160,13 @@
         eth[3]=pkt[0x08];
         eth[4]=pkt[0x04];
         eth[5]=pkt[0x03];
+
         eth[6]=eth[7]=eth[8]=eth[9]=eth[10]=eth[11]=0;
-        eth[12]=0x08; eth[13]=0x00;
 
-	skb->protocol=my_eth_type_trans(skb,dev);
-        skb->dev=dev;
+	eth[12] = 0x08;	/* ETH_P_IP */
+	eth[13] = 0x00;
+
+	skb->protocol = dvb_net_eth_type_trans(skb, dev);
         
         ((struct dvb_net_priv *)dev->priv)->stats.rx_packets++;
         ((struct dvb_net_priv *)dev->priv)->stats.rx_bytes+=skb->len;
@@ -141,9 +180,11 @@
 {
         struct net_device *dev=(struct net_device *) filter->priv;
 
-	/* FIXME: this only works if exactly one complete section is
-	          delivered in buffer1 only */
-	dvb_net_sec(dev, buffer1, buffer1_len);
+	/**
+	 * we rely on the DVB API definition where exactly one complete
+	 * section is delivered in buffer1
+	 */
+	dvb_net_sec (dev, (u8*) buffer1, buffer1_len);
 	return 0;
 }
 
@@ -178,24 +223,27 @@
 	memset((*secfilter)->filter_mode,  0xff, DMX_MAX_FILTER_SIZE);
 
 	(*secfilter)->filter_value[0]=0x3e;
-	(*secfilter)->filter_mask[0]=0xff;
-
 	(*secfilter)->filter_value[3]=mac[5];
-	(*secfilter)->filter_mask[3]=mac_mask[5];
 	(*secfilter)->filter_value[4]=mac[4];
-	(*secfilter)->filter_mask[4]=mac_mask[4];
 	(*secfilter)->filter_value[8]=mac[3];
-	(*secfilter)->filter_mask[8]=mac_mask[3];
 	(*secfilter)->filter_value[9]=mac[2];
-	(*secfilter)->filter_mask[9]=mac_mask[2];
-
 	(*secfilter)->filter_value[10]=mac[1];
-	(*secfilter)->filter_mask[10]=mac_mask[1];
 	(*secfilter)->filter_value[11]=mac[0];
+
+	(*secfilter)->filter_mask[0] = 0xff;
+	(*secfilter)->filter_mask[3] = mac_mask[5];
+	(*secfilter)->filter_mask[4] = mac_mask[4];
+	(*secfilter)->filter_mask[8] = mac_mask[3];
+	(*secfilter)->filter_mask[9] = mac_mask[2];
+	(*secfilter)->filter_mask[10] = mac_mask[1];
 	(*secfilter)->filter_mask[11]=mac_mask[0];
 
-	printk("%s: filter mac=%02x %02x %02x %02x %02x %02x\n", 
+	dprintk("%s: filter mac=%02x %02x %02x %02x %02x %02x\n",
 	       dev->name, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	dprintk("%s: filter mask=%02x %02x %02x %02x %02x %02x\n",
+	       dev->name, mac_mask[0], mac_mask[1], mac_mask[2],
+	       mac_mask[3], mac_mask[4], mac_mask[5]);
+
 	return 0;
 }
 
@@ -206,46 +254,57 @@
         struct dmx_demux *demux = priv->demux;
         unsigned char *mac = (unsigned char *) dev->dev_addr;
 		
+	dprintk("%s: rx_mode %i\n", __FUNCTION__, priv->rx_mode);
+	if (priv->secfeed || priv->secfilter || priv->multi_secfilter[0])
+		printk("%s: BUG %d\n", __FUNCTION__, __LINE__);
+
 	priv->secfeed=0;
 	priv->secfilter=0;
 
+	dprintk("%s: alloc secfeed\n", __FUNCTION__);
 	ret=demux->allocate_section_feed(demux, &priv->secfeed, 
 					 dvb_net_callback);
 	if (ret<0) {
-		printk("%s: could not get section feed\n", dev->name);
+		printk("%s: could not allocate section feed\n", dev->name);
 		return ret;
 	}
 
-	ret=priv->secfeed->set(priv->secfeed, priv->pid, 32768, 0, 0);
+	ret = priv->secfeed->set(priv->secfeed, priv->pid, 32768, 0, 1);
+
 	if (ret<0) {
 		printk("%s: could not set section feed\n", dev->name);
-		priv->demux->
-		        release_section_feed(priv->demux, priv->secfeed);
+		priv->demux->release_section_feed(priv->demux, priv->secfeed);
 		priv->secfeed=0;
 		return ret;
 	}
-	/* fixme: is this correct? */
-	try_module_get(THIS_MODULE);
 
-	if (priv->mode<3) 
+	if (priv->rx_mode != RX_MODE_PROMISC) {
+		dprintk("%s: set secfilter\n", __FUNCTION__);
 		dvb_net_filter_set(dev, &priv->secfilter, mac, mask_normal);
+	}
 
-	switch (priv->mode) {
-	case 1:
-		for (i=0; i<priv->multi_num; i++) 
+	switch (priv->rx_mode) {
+	case RX_MODE_MULTI:
+		for (i = 0; i < priv->multi_num; i++) {
+			dprintk("%s: set multi_secfilter[%d]\n", __FUNCTION__, i);
 			dvb_net_filter_set(dev, &priv->multi_secfilter[i],
 					   priv->multi_macs[i], mask_normal);
+		}
 		break;
-	case 2:
+	case RX_MODE_ALL_MULTI:
 		priv->multi_num=1;
-		dvb_net_filter_set(dev, &priv->multi_secfilter[0], mac_allmulti, mask_allmulti);
+		dprintk("%s: set multi_secfilter[0]\n", __FUNCTION__);
+		dvb_net_filter_set(dev, &priv->multi_secfilter[0],
+				   mac_allmulti, mask_allmulti);
 		break;
-	case 3:
+	case RX_MODE_PROMISC:
 		priv->multi_num=0;
+		dprintk("%s: set secfilter\n", __FUNCTION__);
 		dvb_net_filter_set(dev, &priv->secfilter, mac, mask_promisc);
 		break;
 	}
 	
+	dprintk("%s: start filtering\n", __FUNCTION__);
 	priv->secfeed->start_filtering(priv->secfeed);
 	return 0;
 }
@@ -255,89 +315,93 @@
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
 	int i;
 
+	dprintk("%s\n", __FUNCTION__);
         if (priv->secfeed) {
-	        if (priv->secfeed->is_filtering)
+		if (priv->secfeed->is_filtering) {
+			dprintk("%s: stop secfeed\n", __FUNCTION__);
 		        priv->secfeed->stop_filtering(priv->secfeed);
-	        if (priv->secfilter)
-		        priv->secfeed->
-			        release_filter(priv->secfeed, 
+		}
+
+		if (priv->secfilter) {
+			dprintk("%s: release secfilter\n", __FUNCTION__);
+			priv->secfeed->release_filter(priv->secfeed,
 					       priv->secfilter);
 		priv->secfilter=0;
+		}
 
 		for (i=0; i<priv->multi_num; i++) {
-			if (priv->multi_secfilter[i])
-				priv->secfeed->
-					release_filter(priv->secfeed, 
+			if (priv->multi_secfilter[i]) {
+				dprintk("%s: release multi_filter[%d]\n", __FUNCTION__, i);
+				priv->secfeed->release_filter(priv->secfeed,
 						       priv->multi_secfilter[i]);
 			priv->multi_secfilter[i]=0;
 		}
-		priv->demux->
-		        release_section_feed(priv->demux, priv->secfeed);
+		}
+
+		priv->demux->release_section_feed(priv->demux, priv->secfeed);
 		priv->secfeed=0;
-		/* fixme: is this correct? */
-		module_put(THIS_MODULE);
 	} else
 		printk("%s: no feed to stop\n", dev->name);
 }
 
-static int dvb_add_mc_filter(struct net_device *dev, struct dev_mc_list *mc)
+
+static int dvb_set_mc_filter (struct net_device *dev, struct dev_mc_list *mc)
 {
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
-	int ret;
 
-	if (priv->multi_num >= DVB_NET_MULTICAST_MAX)
+	if (priv->multi_num == DVB_NET_MULTICAST_MAX)
 		return -ENOMEM;
 
-	ret = memcmp(priv->multi_macs[priv->multi_num], mc->dmi_addr, 6);
 	memcpy(priv->multi_macs[priv->multi_num], mc->dmi_addr, 6);
 
 	priv->multi_num++;
-
-	return ret;
+	return 0;
 }
 
-static void dvb_net_set_multi(struct net_device *dev)
+
+static void tq_set_multicast_list (void *data)
 {
+	struct net_device *dev = data;
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
-	struct dev_mc_list *mc;
-	int mci;
-	int update = 0;
+
+	dvb_net_feed_stop(dev);
+
+	priv->rx_mode = RX_MODE_UNI;
 	
 	if(dev->flags & IFF_PROMISC) {
-//	printk("%s: promiscuous mode\n", dev->name);
-		if(priv->mode != 3)
-			update = 1;
-		priv->mode = 3;
-	} else if(dev->flags & IFF_ALLMULTI) {
-//	printk("%s: allmulti mode\n", dev->name);
-		if(priv->mode != 2)
-			update = 1;
-		priv->mode = 2;
-	} else if(dev->mc_count > 0) {
-//	printk("%s: set_mc_list, %d entries\n", 
-//	       dev->name, dev->mc_count);
-		if(priv->mode != 1)
-			update = 1;
-		priv->mode = 1;
+		dprintk("%s: promiscuous mode\n", dev->name);
+		priv->rx_mode = RX_MODE_PROMISC;
+	} else if ((dev->flags & IFF_ALLMULTI)) {
+		dprintk("%s: allmulti mode\n", dev->name);
+		priv->rx_mode = RX_MODE_ALL_MULTI;
+	} else if (dev->mc_count) {
+		int mci;
+		struct dev_mc_list *mc;
+
+		dprintk("%s: set_mc_list, %d entries\n",
+			dev->name, dev->mc_count);
+
+		priv->rx_mode = RX_MODE_MULTI;
 		priv->multi_num = 0;
+
 		for (mci = 0, mc=dev->mc_list; 
 		     mci < dev->mc_count;
-		     mc=mc->next, mci++)
-			if(dvb_add_mc_filter(dev, mc) != 0)
-				update = 1;
-	} else {
-		if(priv->mode != 0)
-			update = 1;
-		priv->mode = 0;
+		     mc = mc->next, mci++) {
+			dvb_set_mc_filter(dev, mc);
+		}
 	}
 
-	if(netif_running(dev) != 0 && update > 0)
-	{
-		dvb_net_feed_stop(dev);
 		dvb_net_feed_start(dev);
 	}
+
+
+static void dvb_net_set_multicast_list (struct net_device *dev)
+{
+	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	schedule_work(&priv->wq);
 }
 
+
 static int dvb_net_set_config(struct net_device *dev, struct ifmap *map)
 {
 	if (netif_running(dev))
@@ -348,11 +413,10 @@
 static int dvb_net_set_mac(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr=p;
-	int update;
 
-	update = memcmp(dev->dev_addr, addr->sa_data, dev->addr_len);
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
-	if (netif_running(dev) != 0 && update > 0) {
+
+	if (netif_running(dev)) {
 		dvb_net_feed_stop(dev);
 		dvb_net_feed_start(dev);
 	}
@@ -362,6 +427,9 @@
 
 static int dvb_net_open(struct net_device *dev)
 {
+	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+
+	priv->in_use++;
 	dvb_net_feed_start(dev);
 	return 0;
 }
@@ -366,8 +434,12 @@
 	return 0;
 }
 
+
 static int dvb_net_stop(struct net_device *dev)
 {
+	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+
+	priv->in_use--;
         dvb_net_feed_stop(dev);
 	return 0;
 }
@@ -386,16 +459,14 @@
 	dev->stop		= dvb_net_stop;
 	dev->hard_start_xmit	= dvb_net_tx;
 	dev->get_stats		= dvb_net_get_stats;
-	dev->set_multicast_list = dvb_net_set_multi;
+	dev->set_multicast_list = dvb_net_set_multicast_list;
 	dev->set_config         = dvb_net_set_config;
 	dev->set_mac_address    = dvb_net_set_mac;
 	dev->mtu		= 4096;
 	dev->mc_count           = 0;
-
-	dev->flags             |= IFF_NOARP;
 	dev->hard_header_cache  = NULL;
 
-	//SET_MODULE_OWNER(dev);
+	dev->flags |= IFF_NOARP;
 	
 	return 0;
 }
@@ -404,11 +476,13 @@
 {
 	int i;
 
-	for (i=0; i<dvbnet->dev_num; i++) 
+	for (i=0; i<DVB_NET_DEVICES_MAX; i++)
 		if (!dvbnet->state[i])
 			break;
-	if (i==dvbnet->dev_num)
+
+	if (i == DVB_NET_DEVICES_MAX)
 		return -1;
+
 	dvbnet->state[i]=1;
 	return i;
 }
@@ -414,8 +488,7 @@
 }
 
 
-int 
-dvb_net_add_if(struct dvb_net *dvbnet, u16 pid)
+static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid)
 {
         struct net_device *net;
 	struct dmx_demux *demux;
@@ -423,8 +496,7 @@
 	int result;
 	int if_num;
  
-	if_num=get_if(dvbnet);
-	if (if_num<0)
+	if ((if_num = get_if(dvbnet)) < 0)
 		return -EINVAL;
 
 	net=&dvbnet->device[if_num];
@@ -435,47 +507,52 @@
 	net->dma       = 0;
 	net->mem_start = 0;
         memcpy(net->name, "dvb0_0", 7);
-        net->name[3]=dvbnet->card_num+0x30;
-        net->name[5]=if_num+0x30;
+	net->name[3]   = dvbnet->dvbdev->adapter->num + '0';
+	net->name[5]   = if_num + '0';
+	net->addr_len  = 6;
+	memcpy(net->dev_addr, dvbnet->dvbdev->adapter->proposed_mac, 6);
         net->next      = NULL;
         net->init      = dvb_net_init_dev;
-        net->priv      = kmalloc(sizeof(struct dvb_net_priv), GFP_KERNEL);
-	if (net->priv == NULL)
+
+	if (!(net->priv = kmalloc(sizeof(struct dvb_net_priv), GFP_KERNEL)))
 			return -ENOMEM;
 
 	priv = net->priv;
 	memset(priv, 0, sizeof(struct dvb_net_priv));
         priv->demux = demux;
         priv->pid = pid;
-	priv->mode = 0;
+	priv->rx_mode = RX_MODE_UNI;
+
+	INIT_WORK(&priv->wq, tq_set_multicast_list, net);
 
         net->base_addr = pid;
                 
 	if ((result = register_netdev(net)) < 0) {
 		return result;
 	}
-	/* fixme: is this correct? */
-	try_module_get(THIS_MODULE);
 
         return if_num;
 }
 
-int 
-dvb_net_remove_if(struct dvb_net *dvbnet, int num)
+
+static int dvb_net_remove_if(struct dvb_net *dvbnet, int num)
 {
+	struct dvb_net_priv *priv = dvbnet->device[num].priv;
+
 	if (!dvbnet->state[num])
 		return -EINVAL;
+	if (priv->in_use)
+		return -EBUSY;
+
 	dvb_net_stop(&dvbnet->device[num]);
-        kfree(dvbnet->device[num].priv);
+	kfree(priv);
         unregister_netdev(&dvbnet->device[num]);
 	dvbnet->state[num]=0;
-	/* fixme: is this correct? */
-	module_put(THIS_MODULE);
-
 	return 0;
 }
 
-int dvb_net_do_ioctl(struct inode *inode, struct file *file, 
+
+static int dvb_net_do_ioctl(struct inode *inode, struct file *file,
 		  unsigned int cmd, void *parg)
 {
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
@@ -490,6 +567,8 @@
 		struct dvb_net_if *dvbnetif=(struct dvb_net_if *)parg;
 		int result;
 		
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
 		result=dvb_net_add_if(dvbnet, dvbnetif->pid);
 		if (result<0)
 			return result;
@@ -502,7 +581,7 @@
 		struct dvb_net_priv *priv_data;
 		struct dvb_net_if *dvbnetif=(struct dvb_net_if *)parg;
 
-		if (dvbnetif->if_num >= dvbnet->dev_num ||
+		if (dvbnetif->if_num >= DVB_NET_DEVICES_MAX ||
 		    !dvbnet->state[dvbnetif->if_num])
 			return -EFAULT;
 
@@ -512,7 +591,9 @@
 		break;
 	}
 	case NET_REMOVE_IF:
-		return dvb_net_remove_if(dvbnet, (long) parg);
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		return dvb_net_remove_if(dvbnet, (int) parg);
 	default:
 		return -EINVAL;
 	}
@@ -542,28 +627,29 @@
         .fops = &dvb_net_fops,
 };
 
-void
-dvb_net_release(struct dvb_net *dvbnet)
+
+void dvb_net_release (struct dvb_net *dvbnet)
 {
 	int i;
 
 	dvb_unregister_device(dvbnet->dvbdev);
-	for (i=0; i<dvbnet->dev_num; i++) {
+
+	for (i=0; i<DVB_NET_DEVICES_MAX; i++) {
 		if (!dvbnet->state[i])
 			continue;
 		dvb_net_remove_if(dvbnet, i);
 	}
 }
 
-int
-dvb_net_init(struct dvb_adapter *adap, struct dvb_net *dvbnet, struct dmx_demux *dmx)
+
+int dvb_net_init (struct dvb_adapter *adap, struct dvb_net *dvbnet,
+		  struct dmx_demux *dmx)
 {
 	int i;
 		
 	dvbnet->demux = dmx;
-	dvbnet->dev_num = DVB_NET_DEVICES_MAX;
 
-	for (i=0; i<dvbnet->dev_num; i++) 
+	for (i=0; i<DVB_NET_DEVICES_MAX; i++)
 		dvbnet->state[i] = 0;
 
 	dvb_register_device (adap, &dvbnet->dvbdev, &dvbdev_net,
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_net.h linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_net.h
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_net.h	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_net.h	2003-06-23 12:40:49.000000000 +0200
@@ -35,8 +35,6 @@
 
 struct dvb_net {
 	struct dvb_device *dvbdev;
-	int card_num;
-	int dev_num;
 	struct net_device device[DVB_NET_DEVICES_MAX];
 	int state[DVB_NET_DEVICES_MAX];
 	struct dmx_demux *demux;

