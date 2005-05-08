Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVEHThz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVEHThz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVEHTOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:14:18 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:56726 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262828AbVEHTJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:35 -0400
Message-Id: <20050508184346.120434000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:37 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-core-dvb-net-ipv6-llcsnap.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 08/37] dvb_net: handle IPv6 and LLC/SNAP
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

handle IPv6 and LLC/SNAP (Bertrand Mazieres, Matthieu Castet, Johannes Stezenbach)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/dvb-core/dvb_net.c |   35 ++++++++++++++++++++++++++---------
 1 files changed, 26 insertions(+), 9 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_net.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvb_net.c	2005-05-08 16:10:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_net.c	2005-05-08 16:10:07.000000000 +0200
@@ -727,6 +727,7 @@ static void dvb_net_sec(struct net_devic
         u8 *eth;
         struct sk_buff *skb;
 	struct net_device_stats *stats = &(((struct dvb_net_priv *) dev->priv)->stats);
+	int snap = 0;
 
 	/* note: pkt_len includes a 32bit checksum */
 	if (pkt_len < 16) {
@@ -750,9 +751,12 @@ static void dvb_net_sec(struct net_devic
 		return;
 	}
 	if (pkt[5] & 0x02) {
-		//FIXME: handle LLC/SNAP
-                stats->rx_dropped++;
-                return;
+		/* handle LLC/SNAP, see rfc-1042 */
+		if (pkt_len < 24 || memcmp(&pkt[12], "\xaa\xaa\x03\0\0\0", 6)) {
+			stats->rx_dropped++;
+			return;
+		}
+		snap = 8;
         }
 	if (pkt[7]) {
 		/* FIXME: assemble datagram from multiple sections */
@@ -762,9 +766,9 @@ static void dvb_net_sec(struct net_devic
 	}
 
 	/* we have 14 byte ethernet header (ip header follows);
-	 * 12 byte MPE header; 4 byte checksum; + 2 byte alignment
+	 * 12 byte MPE header; 4 byte checksum; + 2 byte alignment, 8 byte LLC/SNAP
 	 */
-	if (!(skb = dev_alloc_skb(pkt_len - 4 - 12 + 14 + 2))) {
+	if (!(skb = dev_alloc_skb(pkt_len - 4 - 12 + 14 + 2 - snap))) {
 		//printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n", dev->name);
 		stats->rx_dropped++;
 		return;
@@ -773,8 +777,8 @@ static void dvb_net_sec(struct net_devic
 	skb->dev = dev;
 
 	/* copy L3 payload */
-	eth = (u8 *) skb_put(skb, pkt_len - 12 - 4 + 14);
-	memcpy(eth + 14, pkt + 12, pkt_len - 12 - 4);
+	eth = (u8 *) skb_put(skb, pkt_len - 12 - 4 + 14 - snap);
+	memcpy(eth + 14, pkt + 12 + snap, pkt_len - 12 - 4 - snap);
 
 	/* create ethernet header: */
         eth[0]=pkt[0x0b];
@@ -786,8 +790,21 @@ static void dvb_net_sec(struct net_devic
 
         eth[6]=eth[7]=eth[8]=eth[9]=eth[10]=eth[11]=0;
 
-	eth[12] = 0x08;	/* ETH_P_IP */
-	eth[13] = 0x00;
+	if (snap) {
+		eth[12] = pkt[18];
+		eth[13] = pkt[19];
+	} else {
+		/* protocol numbers are from rfc-1700 or
+		 * http://www.iana.org/assignments/ethernet-numbers
+		 */
+		if (pkt[12] >> 4 == 6) { /* version field from IP header */
+			eth[12] = 0x86;	/* IPv6 */
+			eth[13] = 0xdd;
+		} else {
+			eth[12] = 0x08;	/* IPv4 */
+			eth[13] = 0x00;
+		}
+	}
 
 	skb->protocol = dvb_net_eth_type_trans(skb, dev);
 

--

