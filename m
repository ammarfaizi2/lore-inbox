Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWAVMEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWAVMEn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 07:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWAVMEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 07:04:42 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24229 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932424AbWAVMEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 07:04:42 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt
Date: Sun, 22 Jan 2006 13:59:31 +0200
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com>
In-Reply-To: <20060118200616.GC6583@tuxdriver.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jO30DDAekfRjnnw"
Message-Id: <200601221359.31482.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_jO30DDAekfRjnnw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

bcm43xx_rx() contains code to filter out packets from
foreign BSSes and decide whether to call ieee80211_rx
or ieee80211_rx_mgt. This is not bcm specific.

Patch adapts that code and adds it to softmac
as ieee80211_rx_any() function.

Diffed against wireless-2.6.git

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_jO30DDAekfRjnnw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rx.patch"

bcm43xx_rx() contains code to filter out packets from
foreign BSSes and decide whether to call ieee80211_rx
or ieee80211_rx_mgt. This is not bcm specific.

Patch adapts that code and adds it to softmac.

diff -urpN softmac-snapshot/net/ieee80211/ieee80211_rx.c softmac-snapshot.1/net/ieee80211/ieee80211_rx.c
--- softmac-snapshot/net/ieee80211/ieee80211_rx.c	Wed Jan 18 07:27:03 2006
+++ softmac-snapshot.1/net/ieee80211/ieee80211_rx.c	Sun Jan 22 13:12:30 2006
@@ -758,6 +758,79 @@ int ieee80211_rx(struct ieee80211_device
 	/* Returning 0 indicates to caller that we have not handled the SKB--
 	 * so it is still allocated and can be used again by underlying
 	 * hardware as a DMA target */
+	return 0;
+}
+
+/* Kernel doesn't have it, why? */
+static inline int is_mcast_or_bcast_ether_addr(const u8 *addr)
+{
+        return (0x01 & addr[0]);
+}
+
+/* Filter out unrelated packets, call ieee80211_rx[_mgt] */
+int ieee80211_rx_any(struct ieee80211_device *ieee,
+		     struct sk_buff *skb, struct ieee80211_rx_stats *stats)
+{
+	struct ieee80211_hdr_4addr *hdr;
+	int is_packet_for_us;
+	u16 fc;
+
+	if (ieee->iw_mode == IW_MODE_MONITOR)
+		return ieee80211_rx(ieee, skb, stats) ? 0 : -EINVAL;
+
+	hdr = (struct ieee80211_hdr_4addr *)skb->data;
+	fc = le16_to_cpu(hdr->frame_ctl);
+
+	switch (fc & IEEE80211_FCTL_FTYPE) {
+	case IEEE80211_FTYPE_MGMT:
+		return ieee80211_rx_mgt(ieee, hdr, stats);
+	case IEEE80211_FTYPE_DATA:
+		break;
+	case IEEE80211_FTYPE_CTL:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	is_packet_for_us = 0;
+	switch (ieee->iw_mode) {
+	case IW_MODE_ADHOC:
+		/* promisc: get all */
+		if (ieee->dev->flags & IFF_PROMISC)
+			is_packet_for_us = 1;
+		/* our BSS */
+		else if (memcmp(hdr->addr3, ieee->bssid, ETH_ALEN) == 0) {
+			/* to us */
+			if (memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN) == 0)
+				is_packet_for_us = 1;
+			/* mcast */
+			else if (is_mcast_or_bcast_ether_addr(hdr->addr1))
+				is_packet_for_us = 1;
+		}
+		break;
+	case IW_MODE_INFRA:
+		/* promisc: get all */
+		if (ieee->dev->flags & IFF_PROMISC)
+			is_packet_for_us = 1;
+		/* our BSS (== from our AP) */
+		else if (memcmp(hdr->addr2, ieee->bssid, ETH_ALEN) == 0) {
+			/* to us */
+			if (memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN) == 0)
+				is_packet_for_us = 1;
+			/* mcast */
+			else if (is_mcast_or_bcast_ether_addr(hdr->addr1))
+				/* not our own packet bcasted from AP */
+				if (memcmp(hdr->addr3, ieee->dev->dev_addr, ETH_ALEN))
+					is_packet_for_us = 1;
+		}
+		break;
+	default:
+		/* ? */
+		break;
+	}
+
+	if (is_packet_for_us)
+		return (ieee80211_rx(ieee, skb, stats) ? 0 : -EINVAL);
 	return 0;
 }
 

--Boundary-00=_jO30DDAekfRjnnw--
