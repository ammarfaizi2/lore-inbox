Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272131AbTG2VKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2VKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:10:40 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:7334 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S272148AbTG2VHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:07:02 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.0-test2 generic HDLC updates
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 29 Jul 2003 22:47:16 +0200
Message-ID: <m3oezdnjqj.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The following patch upgrades generic HDLC to support "new" protocol
handlers.

Please apply.
Thanks.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-2.6.0-test2-1.16.patch

--- linux-2.6.orig/include/linux/hdlc.h	2003-07-29 19:18:57.000000000 +0200
+++ linux-2.6/include/linux/hdlc.h	2003-07-29 21:43:40.000000000 +0200
@@ -118,7 +118,7 @@
 		void (*stop)(struct hdlc_device_struct *hdlc);
 
 		void (*detach)(struct hdlc_device_struct *hdlc);
-		void (*netif_rx)(struct sk_buff *skb);
+		int (*netif_rx)(struct sk_buff *skb);
 		unsigned short (*type_trans)(struct sk_buff *skb,
 					     struct net_device *dev);
 		int id;		/* IF_PROTO_HDLC/CISCO/FR/etc. */
--- linux-2.6.orig/drivers/net/wan/hdlc_cisco.c	2003-07-29 19:18:51.000000000 +0200
+++ linux-2.6/drivers/net/wan/hdlc_cisco.c	2003-07-29 21:59:17.000000000 +0200
@@ -116,7 +116,7 @@
 }
 
 
-static void cisco_rx(struct sk_buff *skb)
+static int cisco_rx(struct sk_buff *skb)
 {
 	hdlc_device *hdlc = dev_to_hdlc(skb->dev);
 	hdlc_header *data = (hdlc_header*)skb->data;
@@ -131,24 +131,22 @@
 	    data->address != CISCO_UNICAST)
 		goto rx_error;
 
-	skb_pull(skb, sizeof(hdlc_header));
-
 	switch(ntohs(data->protocol)) {
 	case CISCO_SYS_INFO:
 		/* Packet is not needed, drop it. */
 		dev_kfree_skb_any(skb);
-		return;
+		return NET_RX_SUCCESS;
 
 	case CISCO_KEEPALIVE:
-		if (skb->len != CISCO_PACKET_LEN &&
-		    skb->len != CISCO_BIG_PACKET_LEN) {
+		if (skb->len != sizeof(hdlc_header) + CISCO_PACKET_LEN &&
+		    skb->len != sizeof(hdlc_header) + CISCO_BIG_PACKET_LEN) {
 			printk(KERN_INFO "%s: Invalid length of Cisco "
 			       "control packet (%d bytes)\n",
 			       hdlc_to_name(hdlc), skb->len);
 			goto rx_error;
 		}
 
-		cisco_data = (cisco_packet*)skb->data;
+		cisco_data = (cisco_packet*)(skb->data + sizeof(hdlc_header));
 
 		switch(ntohl (cisco_data->type)) {
 		case CISCO_ADDR_REQ: /* Stolen from syncppp.c :-) */
@@ -173,7 +171,7 @@
 						     addr, mask);
 			}
 			dev_kfree_skb_any(skb);
-			return;
+			return NET_RX_SUCCESS;
 
 		case CISCO_ADDR_REPLY:
 			printk(KERN_INFO "%s: Unexpected Cisco IP address "
@@ -199,18 +197,19 @@
 			}
 
 			dev_kfree_skb_any(skb);
-			return;
+			return NET_RX_SUCCESS;
 		} /* switch(keepalive type) */
 	} /* switch(protocol) */
 
 	printk(KERN_INFO "%s: Unsupported protocol %x\n", hdlc_to_name(hdlc),
 	       data->protocol);
 	dev_kfree_skb_any(skb);
-	return;
+	return NET_RX_DROP;
 
  rx_error:
 	hdlc->stats.rx_errors++; /* Mark error */
 	dev_kfree_skb_any(skb);
+	return NET_RX_DROP;
 }
 
 
--- linux-2.6.orig/drivers/net/wan/hdlc_fr.c	2003-07-29 19:18:51.000000000 +0200
+++ linux-2.6/drivers/net/wan/hdlc_fr.c	2003-07-29 22:06:19.000000000 +0200
@@ -800,7 +800,7 @@
 
 
 
-static void fr_rx(struct sk_buff *skb)
+static int fr_rx(struct sk_buff *skb)
 {
 	hdlc_device *hdlc = dev_to_hdlc(skb->dev);
 	fr_hdr *fh = (fr_hdr*)skb->data;
@@ -826,7 +826,7 @@
 				hdlc->state.fr.request = 0;
 				hdlc->state.fr.last_poll = jiffies;
 				dev_kfree_skb_any(skb);
-				return;
+				return NET_RX_SUCCESS;
 			}
 		}
 
@@ -842,7 +842,7 @@
 		       hdlc_to_name(hdlc), dlci);
 #endif
 		dev_kfree_skb_any(skb);
-		return;
+		return NET_RX_DROP;
 	}
 
 	if (pvc->state.fecn != fh->fecn) {
@@ -862,6 +862,11 @@
 	}
 
 
+	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
+		hdlc->stats.rx_dropped++;
+		return NET_RX_DROP;
+	}
+
 	if (data[3] == NLPID_IP) {
 		skb_pull(skb, 4); /* Remove 4-byte header (hdr, UI, NLPID) */
 		dev = pvc->main;
@@ -896,13 +901,13 @@
 			printk(KERN_INFO "%s: Unsupported protocol, OUI=%x "
 			       "PID=%x\n", hdlc_to_name(hdlc), oui, pid);
 			dev_kfree_skb_any(skb);
-			return;
+			return NET_RX_DROP;
 		}
 	} else {
 		printk(KERN_INFO "%s: Unsupported protocol, NLPID=%x "
 		       "length = %i\n", hdlc_to_name(hdlc), data[3], skb->len);
 		dev_kfree_skb_any(skb);
-		return;
+		return NET_RX_DROP;
 	}
 
 	if (dev) {
@@ -913,14 +918,16 @@
 			stats->rx_compressed++;
 		skb->dev = dev;
 		netif_rx(skb);
-	} else
+		return NET_RX_SUCCESS;
+	} else {
 		dev_kfree_skb_any(skb);
-
-	return;
+		return NET_RX_DROP;
+	}
 
  rx_error:
 	hdlc->stats.rx_errors++; /* Mark error */
 	dev_kfree_skb_any(skb);
+	return NET_RX_DROP;
 }
 
 
--- linux-2.6.orig/drivers/net/wan/hdlc_generic.c	2003-07-29 19:18:51.000000000 +0200
+++ linux-2.6/drivers/net/wan/hdlc_generic.c	2003-07-29 22:26:48.000000000 +0200
@@ -33,7 +33,7 @@
 #include <linux/hdlc.h>
 
 
-static const char* version = "HDLC support module revision 1.15";
+static const char* version = "HDLC support module revision 1.16";
 
 #undef DEBUG_LINK
 
@@ -60,12 +60,11 @@
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	if (hdlc->proto.netif_rx)
-		hdlc->proto.netif_rx(skb);
-	else {
-		hdlc->stats.rx_dropped++; /* Shouldn't happen */
-		dev_kfree_skb(skb);
-	}
-	return 0;
+		return hdlc->proto.netif_rx(skb);
+
+	hdlc->stats.rx_dropped++; /* Shouldn't happen */
+	dev_kfree_skb(skb);
+	return NET_RX_DROP;
 }
 
 
@@ -280,10 +279,11 @@
 EXPORT_SYMBOL(register_hdlc_device);
 EXPORT_SYMBOL(unregister_hdlc_device);
 
-struct packet_type hdlc_packet_type=
+static struct packet_type hdlc_packet_type =
 {
 	.type = __constant_htons(ETH_P_HDLC),
 	.func = hdlc_rcv,
+	.data = (void *)1,
 };
 
 
--- linux-2.6.orig/drivers/net/wan/hdlc_x25.c	2003-07-29 19:18:51.000000000 +0200
+++ linux-2.6/drivers/net/wan/hdlc_x25.c	2003-07-29 21:45:50.000000000 +0200
@@ -164,14 +164,21 @@
 
 
 
-static void x25_rx(struct sk_buff *skb)
+static int x25_rx(struct sk_buff *skb)
 {
 	hdlc_device *hdlc = dev_to_hdlc(skb->dev);
 
+	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
+		hdlc->stats.rx_dropped++;
+		return NET_RX_DROP;
+	}
+
 	if (lapb_data_received(hdlc, skb) == LAPB_OK)
-		return;
+		return NET_RX_SUCCESS;
+
 	hdlc->stats.rx_errors++;
 	dev_kfree_skb_any(skb);
+	return NET_RX_DROP;
 }
 
 

--=-=-=--
