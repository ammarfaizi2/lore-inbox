Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVEXNUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVEXNUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVEXNUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:20:39 -0400
Received: from styx.suse.cz ([82.119.242.94]:15291 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262061AbVEXNM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:12:56 -0400
Date: Tue, 24 May 2005 15:12:55 +0200
From: Jiri Benc <jbenc@suse.cz>
To: NetDev <netdev@oss.sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, pavel@suse.cz
Subject: [4/5] ieee80211: ethernet independency
Message-ID: <20050524151255.6454a8c6@griffin.suse.cz>
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
References: <20050524150711.01632672@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes the 802.11 layer independent of ethernet. (The previous implementation
had the ethernet headers built by the ethernet layer and then parsed them and
rebuilt them into 802.11 headers.)


Signed-off-by: Jiri Benc <jbenc@suse.cz>
Signed-off-by: Jirka Bohac <jbohac@suse.cz>

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -83,13 +83,18 @@
  *	used.
  */
  
-#if !defined(CONFIG_AX25) && !defined(CONFIG_AX25_MODULE) && !defined(CONFIG_TR)
+#if !defined(CONFIG_AX25) && !defined(CONFIG_AX25_MODULE) && !defined(CONFIG_TR) \
+	&& !defined(CONFIG_IEEE80211)
 #define LL_MAX_HEADER	32
 #else
 #if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
 #define LL_MAX_HEADER	96
 #else
+#if defined(CONFIG_TR)
 #define LL_MAX_HEADER	48
+#else
+#define LL_MAX_HEADER	38
+#endif
 #endif
 #endif
 
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -20,7 +20,6 @@
  */
 #ifndef IEEE80211_H
 #define IEEE80211_H
-#include <linux/if_ether.h> /* ETH_ALEN */
 #include <linux/kernel.h>   /* ARRAY_SIZE */
 
 #if WIRELESS_EXT < 17
@@ -42,25 +41,26 @@
    WEP IV and ICV. (this interpretation suggested by Ramiro Barreiro) */
 
 
+#define IEEE80211_ALEN			6
 #define IEEE80211_HLEN			30
 #define IEEE80211_FRAME_LEN		(IEEE80211_DATA_LEN + IEEE80211_HLEN)
 
 struct ieee80211_hdr {
 	u16 frame_ctl;
 	u16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
+	u8 addr1[IEEE80211_ALEN];
+	u8 addr2[IEEE80211_ALEN];
+	u8 addr3[IEEE80211_ALEN];
 	u16 seq_ctl;
-	u8 addr4[ETH_ALEN];
+	u8 addr4[IEEE80211_ALEN];
 } __attribute__ ((packed));
 
 struct ieee80211_hdr_3addr {
 	u16 frame_ctl;
 	u16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
+	u8 addr1[IEEE80211_ALEN];
+	u8 addr2[IEEE80211_ALEN];
+	u8 addr3[IEEE80211_ALEN];
 	u16 seq_ctl;
 } __attribute__ ((packed));
 
@@ -233,7 +233,7 @@
 #define ETH_P_PREAUTH 0x88C7 /* IEEE 802.11i pre-authentication */
 
 #ifndef ETH_P_80211_RAW
-#define ETH_P_80211_RAW (ETH_P_ECONET + 1)
+#define ETH_P_80211_RAW 0x0003
 #endif
 
 /* IEEE 802.11 defines */
@@ -246,11 +246,29 @@
         u8    ssap;   /* always 0xAA */
         u8    ctrl;   /* always 0x03 */
         u8    oui[P80211_OUI_LEN];    /* organizational universal id */
+	u16   type;   /* packet type ID field */
 
 } __attribute__ ((packed));
 
 #define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
 
+#define IEEE80211_SNAP_IS_RFC1042(snap) \
+		((snap)->oui[0] == 0 && (snap)->oui[1] == 0 && (snap)->oui[2] == 0)
+#define IEEE80211_SNAP_IS_BRIDGE_TUNNEL(snap) \
+		((snap)->oui[0] == 0 && (snap)->oui[1] == 0 && (snap)->oui[2] == 0xf8)
+
+#define IEEE80211_FC_GET_TODS(hdr) \
+		((hdr)->frame_ctl & __constant_cpu_to_le16(IEEE80211_FCTL_TODS))
+#define IEEE80211_FC_GET_FROMDS(hdr) \
+		((hdr)->frame_ctl & __constant_cpu_to_le16(IEEE80211_FCTL_FROMDS))
+#define IEEE80211_GET_DADDR(hdr) \
+		(IEEE80211_FC_GET_TODS(hdr) ? (hdr)->addr3 : (hdr)->addr1)
+#define IEEE80211_GET_SADDR(hdr) \
+		(IEEE80211_FC_GET_FROMDS(hdr) ? \
+			(IEEE80211_FC_GET_TODS(hdr) ? (hdr)->addr4 : (hdr)->addr3) \
+			: (hdr)->addr2)
+/* IEEE80211_GET_xADDR do not work when both TODS and FROMDS are set. */
+
 #define WLAN_FC_GET_TYPE(fc) ((fc) & IEEE80211_FCTL_FTYPE)
 #define WLAN_FC_GET_STYPE(fc) ((fc) & IEEE80211_FCTL_STYPE)
 
@@ -395,8 +413,8 @@
 	unsigned int seq;
 	unsigned int last_frag;
 	struct sk_buff *skb;
-	u8 src_addr[ETH_ALEN];
-	u8 dst_addr[ETH_ALEN];
+	u8 src_addr[IEEE80211_ALEN];
+	u8 dst_addr[IEEE80211_ALEN];
 };
 
 struct ieee80211_stats {
@@ -507,7 +525,7 @@
 	u16 auth_sequence;
 	u16 beacon_interval;
 	u16 capability;
-	u8 current_ap[ETH_ALEN];
+	u8 current_ap[IEEE80211_ALEN];
 	u16 listen_interval;
 	struct {
 		u16 association_id:14, reserved:2;
@@ -537,7 +555,7 @@
 struct ieee80211_assoc_request_frame {
 	u16 capability;
 	u16 listen_interval;
-	u8 current_ap[ETH_ALEN];
+	u8 current_ap[IEEE80211_ALEN];
 	struct ieee80211_info_element info_element;
 } __attribute__ ((packed));
 
@@ -581,7 +599,7 @@
 
 struct ieee80211_network {
 	/* These entries are used to identify a unique network */
-	u8 bssid[ETH_ALEN];
+	u8 bssid[IEEE80211_ALEN];
 	u8 channel;
 	/* Ensure null-terminated for any debug msgs */
 	u8 ssid[IW_ESSID_MAX_SIZE + 1];
@@ -625,12 +643,12 @@
 #define MAC_ARG(x) ((u8*)(x))[0],((u8*)(x))[1],((u8*)(x))[2],((u8*)(x))[3],((u8*)(x))[4],((u8*)(x))[5]
 
 
-extern inline int is_multicast_ether_addr(const u8 *addr)
+extern inline int is_multicast_ieee80211_addr(const u8 *addr)
 {
 	return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
-extern inline int is_broadcast_ether_addr(const u8 *addr)
+extern inline int is_broadcast_ieee80211_addr(const u8 *addr)
 {
 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
@@ -694,7 +712,7 @@
 	u16 fts; /* Fragmentation Threshold */
 
 	/* Association info */
-	u8 bssid[ETH_ALEN];
+	u8 bssid[IEEE80211_ALEN];
 
 	enum ieee80211_state state;
 
@@ -774,7 +792,7 @@
 	return 0;
 }
 
-extern inline int ieee80211_get_hdrlen(u16 fc)
+extern inline int __ieee80211_get_hdrlen(u16 fc)
 {
 	int hdrlen = IEEE80211_3ADDR_LEN;
 
@@ -798,12 +816,29 @@
 
 	return hdrlen;
 }
+#define ieee80211_get_hdrlen(hdr) __ieee80211_get_hdrlen(le16_to_cpu((hdr)->frame_ctl))
+
+#define IEEE80211_GET_DATA_HDR_LEN(hdr) \
+		((((hdr)->frame_ctl & \
+			__constant_cpu_to_le16(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) \
+		 == __constant_cpu_to_le16(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) \
+		 ? IEEE80211_4ADDR_LEN : IEEE80211_3ADDR_LEN)
+#define IEEE80211_GET_SNAP(hdr) \
+		((struct ieee80211_snap_hdr *) \
+		((u8 *)(hdr) + IEEE80211_GET_DATA_HDR_LEN(hdr)))
 
+extern inline int ieee80211_get_proto(struct ieee80211_hdr *header)
+{
+	struct ieee80211_snap_hdr *snap = IEEE80211_GET_SNAP(header);
+	return (snap->dsap == 0xaa && snap->ssap == 0xaa ?
+		ntohs(snap->type) : ETH_P_802_2);
+}
 
 
 /* ieee80211.c */
 extern void free_ieee80211(struct ieee80211_device *ieee);
 extern struct ieee80211_device *alloc_ieee80211(int sizeof_priv);
+extern void ieee80211_setup(struct net_device *dev);
 
 extern int ieee80211_set_encryption(struct ieee80211_device *ieee);
 
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -42,11 +42,10 @@
 					struct ieee80211_rx_stats *rx_stats)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
 
 	skb->dev = ieee->dev;
 	skb->mac.raw = skb->data;
-	skb_pull(skb, ieee80211_get_hdrlen(fc));
+	skb_pull(skb, ieee80211_get_hdrlen(hdr));
 	skb->pkt_type = PACKET_OTHERHOST;
 	skb->protocol = __constant_htons(ETH_P_80211_RAW);
 	memset(skb->cb, 0, sizeof(skb->cb));
@@ -76,8 +75,8 @@
 
 		if (entry->skb != NULL && entry->seq == seq &&
 		    (entry->last_frag + 1 == frag || frag == -1) &&
-		    memcmp(entry->src_addr, src, ETH_ALEN) == 0 &&
-		    memcmp(entry->dst_addr, dst, ETH_ALEN) == 0)
+		    memcmp(entry->src_addr, src, IEEE80211_ALEN) == 0 &&
+		    memcmp(entry->dst_addr, dst, IEEE80211_ALEN) == 0)
 			return entry;
 	}
 
@@ -104,7 +103,7 @@
 				    sizeof(struct ieee80211_hdr) +
 				    8 /* LLC */ +
 				    2 /* alignment */ +
-				    8 /* WEP */ + ETH_ALEN /* WDS */);
+				    8 /* WEP */ + IEEE80211_ALEN /* WDS */);
 		if (skb == NULL)
 			return NULL;
 
@@ -120,8 +119,8 @@
 		entry->seq = seq;
 		entry->last_frag = frag;
 		entry->skb = skb;
-		memcpy(entry->src_addr, hdr->addr2, ETH_ALEN);
-		memcpy(entry->dst_addr, hdr->addr1, ETH_ALEN);
+		memcpy(entry->src_addr, hdr->addr2, IEEE80211_ALEN);
+		memcpy(entry->dst_addr, hdr->addr1, IEEE80211_ALEN);
 	} else {
 		/* received a fragment of a frame for which the head fragment
 		 * should have already been received */
@@ -221,15 +220,6 @@
 #endif
 
 
-/* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
-/* Ethernet-II snap header (RFC1042 for most EtherTypes) */
-static unsigned char rfc1042_header[] =
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
-/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-static unsigned char bridge_tunnel_header[] =
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
-/* No encapsulation header if EtherType < 0x600 (=length) */
-
 /* Called by ieee80211_rx_frame_decrypt */
 static int ieee80211_is_eapol_frame(struct ieee80211_device *ieee,
 				    struct sk_buff *skb)
@@ -237,7 +227,6 @@
 	struct net_device *dev = ieee80211_dev(ieee);
 	u16 fc, ethertype;
 	struct ieee80211_hdr *hdr;
-	u8 *pos;
 
 	if (skb->len < 24)
 		return 0;
@@ -248,12 +237,12 @@
 	/* check that the frame is unicast frame to us */
 	if ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
 	    IEEE80211_FCTL_TODS &&
-	    memcmp(hdr->addr1, dev->dev_addr, ETH_ALEN) == 0 &&
-	    memcmp(hdr->addr3, dev->dev_addr, ETH_ALEN) == 0) {
+	    memcmp(hdr->addr1, dev->dev_addr, IEEE80211_ALEN) == 0 &&
+	    memcmp(hdr->addr3, dev->dev_addr, IEEE80211_ALEN) == 0) {
 		/* ToDS frame with own addr BSSID and DA */
 	} else if ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
 		   IEEE80211_FCTL_FROMDS &&
-		   memcmp(hdr->addr1, dev->dev_addr, ETH_ALEN) == 0) {
+		   memcmp(hdr->addr1, dev->dev_addr, IEEE80211_ALEN) == 0) {
 		/* FromDS frame with own addr as DA */
 	} else
 		return 0;
@@ -262,8 +251,7 @@
 		return 0;
 
 	/* check for port access entity Ethernet type */
-	pos = skb->data + 24;
-	ethertype = (pos[6] << 8) | pos[7];
+	ethertype = ieee80211_get_proto(hdr);
 	if (ethertype == ETH_P_PAE)
 		return 1;
 
@@ -282,7 +270,7 @@
 		return 0;
 
 	hdr = (struct ieee80211_hdr *) skb->data;
-	hdrlen = ieee80211_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
+	hdrlen = ieee80211_get_hdrlen(hdr);
 
 #ifdef CONFIG_IEEE80211_CRYPT_TKIP
 	if (ieee->tkip_countermeasures &&
@@ -327,7 +315,7 @@
 		return 0;
 
 	hdr = (struct ieee80211_hdr *) skb->data;
-	hdrlen = ieee80211_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
+	hdrlen = ieee80211_get_hdrlen(hdr);
 
 	atomic_inc(&crypt->refcnt);
 	res = crypt->ops->decrypt_msdu(skb, keyidx, hdrlen, crypt->priv);
@@ -343,6 +331,44 @@
 }
 
 
+unsigned short ieee80211_type_trans(struct sk_buff *skb,
+		struct ieee80211_device *ieee)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_snap_hdr *snap;
+	int hdrlen;
+	u8 *daddr = IEEE80211_GET_DADDR(hdr);
+	unsigned short type;
+
+	skb->mac.raw = skb->data;
+
+	hdrlen = ieee80211_get_hdrlen(hdr);
+	snap = (struct ieee80211_snap_hdr *)(skb->data + hdrlen);
+	if (snap->dsap == 0xaa && snap->ssap == 0xaa &&
+			((IEEE80211_SNAP_IS_RFC1042(snap) &&
+			  snap->type != __constant_htons(ETH_P_AARP) &&
+			  snap->type != __constant_htons(ETH_P_IPX)) ||
+			 IEEE80211_SNAP_IS_BRIDGE_TUNNEL(snap))) {
+		type = snap->type;
+		skb_pull(skb, hdrlen + SNAP_SIZE);
+	}
+	else {
+		type = __constant_htons(ETH_P_802_2);
+		skb_pull(skb, hdrlen);
+	}
+
+	skb->input_dev = ieee->dev;
+	if (is_broadcast_ieee80211_addr(daddr))
+		skb->pkt_type = PACKET_BROADCAST;
+	else if (is_multicast_ieee80211_addr(daddr))
+		skb->pkt_type = PACKET_MULTICAST;
+	else if (memcmp(daddr, ieee->dev->dev_addr, IEEE80211_ALEN))
+		skb->pkt_type = PACKET_OTHERHOST;
+
+	return type;
+}
+
+
 /* All received frames are sent to this function. @skb contains the frame in
  * IEEE 802.11 format, i.e., in the format it was sent over air.
  * This function is called only as a tasklet (software IRQ). */
@@ -355,8 +381,6 @@
 	u16 fc, type, stype, sc;
 	struct net_device_stats *stats;
 	unsigned int frag;
-	u8 *payload;
-	u16 ethertype;
 #ifdef NOT_YET
 	struct net_device *wds = NULL;
 	struct sk_buff *skb2 = NULL;
@@ -365,8 +389,8 @@
 	int from_assoc_ap = 0;
 	void *sta = NULL;
 #endif
-	u8 dst[ETH_ALEN];
-	u8 src[ETH_ALEN];
+	u8 dst[IEEE80211_ALEN];
+	u8 src[IEEE80211_ALEN];
 	struct ieee80211_crypt_data *crypt = NULL;
 	int keyidx = 0;
 
@@ -384,7 +408,7 @@
 	stype = WLAN_FC_GET_STYPE(fc);
 	sc = le16_to_cpu(hdr->seq_ctl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
-	hdrlen = ieee80211_get_hdrlen(fc);
+	hdrlen = __ieee80211_get_hdrlen(fc);
 
 #ifdef NOT_YET
 #if WIRELESS_EXT > 15
@@ -480,22 +504,23 @@
 
 	switch (fc & (IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
 	case IEEE80211_FCTL_FROMDS:
-		memcpy(dst, hdr->addr1, ETH_ALEN);
-		memcpy(src, hdr->addr3, ETH_ALEN);
+		memcpy(dst, hdr->addr1, IEEE80211_ALEN);
+		memcpy(src, hdr->addr3, IEEE80211_ALEN);
 		break;
 	case IEEE80211_FCTL_TODS:
-		memcpy(dst, hdr->addr3, ETH_ALEN);
-		memcpy(src, hdr->addr2, ETH_ALEN);
+		memcpy(dst, hdr->addr3, IEEE80211_ALEN);
+		memcpy(src, hdr->addr2, IEEE80211_ALEN);
 		break;
 	case IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS:
 		if (skb->len < IEEE80211_4ADDR_LEN)
 			goto rx_dropped;
-		memcpy(dst, hdr->addr3, ETH_ALEN);
-		memcpy(src, hdr->addr4, ETH_ALEN);
+		memcpy(dst, hdr->addr3, IEEE80211_ALEN);
+		memcpy(src, hdr->addr4, IEEE80211_ALEN);
+		/* FIXME: this is wrong */
 		break;
 	case 0:
-		memcpy(dst, hdr->addr1, ETH_ALEN);
-		memcpy(src, hdr->addr2, ETH_ALEN);
+		memcpy(dst, hdr->addr1, IEEE80211_ALEN);
+		memcpy(src, hdr->addr2, IEEE80211_ALEN);
 		break;
 	}
 
@@ -510,7 +535,7 @@
 	if (ieee->iw_mode == IW_MODE_MASTER && !wds &&
 	    (fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS &&
 	    ieee->stadev &&
-	    memcmp(hdr->addr2, ieee->assoc_ap_addr, ETH_ALEN) == 0) {
+	    memcmp(hdr->addr2, ieee->assoc_ap_addr, IEEE80211_ALEN) == 0) {
 		/* Frame from BSSID of the AP for which we are a client */
 		skb->dev = dev = ieee->stadev;
 		stats = hostap_get_stats(dev);
@@ -668,9 +693,6 @@
 
 	/* skb: hdr + (possible reassembled) full plaintext payload */
 
-	payload = skb->data + hdrlen;
-	ethertype = (payload[6] << 8) | payload[7];
-
 #ifdef NOT_YET
 	/* If IEEE 802.1X is used, check whether the port is authorized to send
 	 * the received frame. */
@@ -697,38 +719,6 @@
 	}
 #endif
 
-	/* convert hdr + possible LLC headers into Ethernet header */
-	if (skb->len - hdrlen >= 8 &&
-	    ((memcmp(payload, rfc1042_header, SNAP_SIZE) == 0 &&
-	      ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
-	     memcmp(payload, bridge_tunnel_header, SNAP_SIZE) == 0)) {
-		/* remove RFC1042 or Bridge-Tunnel encapsulation and
-		 * replace EtherType */
-		skb_pull(skb, hdrlen + SNAP_SIZE);
-		memcpy(skb_push(skb, ETH_ALEN), src, ETH_ALEN);
-		memcpy(skb_push(skb, ETH_ALEN), dst, ETH_ALEN);
-	} else {
-		u16 len;
-		/* Leave Ethernet header part of hdr and full payload */
-		skb_pull(skb, hdrlen);
-		len = htons(skb->len);
-		memcpy(skb_push(skb, 2), &len, 2);
-		memcpy(skb_push(skb, ETH_ALEN), src, ETH_ALEN);
-		memcpy(skb_push(skb, ETH_ALEN), dst, ETH_ALEN);
-	}
-
-#ifdef NOT_YET
-	if (wds && ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
-		    IEEE80211_FCTL_TODS) &&
-	    skb->len >= ETH_HLEN + ETH_ALEN) {
-		/* Non-standard frame: get addr4 from its bogus location after
-		 * the payload */
-		memcpy(skb->data + ETH_ALEN,
-		       skb->data + skb->len - ETH_ALEN, ETH_ALEN);
-		skb_trim(skb, skb->len - ETH_ALEN);
-	}
-#endif
-
 	stats->rx_packets++;
 	stats->rx_bytes += skb->len;
 
@@ -754,7 +744,7 @@
 
 	if (skb2 != NULL) {
 		/* send to wireless media */
-		skb2->protocol = __constant_htons(ETH_P_802_3);
+		skb2->protocol = ieee80211_type_trans(skb2, ieee);
 		skb2->mac.raw = skb2->nh.raw = skb2->data;
 		/* skb2->nh.raw = skb2->data + ETH_HLEN; */
 		skb2->dev = dev;
@@ -764,7 +754,7 @@
 #endif
 
 	if (skb) {
-		skb->protocol = eth_type_trans(skb, dev);
+		skb->protocol = ieee80211_type_trans(skb, ieee);
 		memset(skb->cb, 0, sizeof(skb->cb));
 		skb->dev = dev;
 		skb->ip_summed = CHECKSUM_NONE; /* 802.11 crc not sufficient */
@@ -821,7 +811,7 @@
 	u8 i;
 
 	/* Pull out fixed field data */
-	memcpy(network->bssid, beacon->header.addr3, ETH_ALEN);
+	memcpy(network->bssid, beacon->header.addr3, IEEE80211_ALEN);
 	network->capability = beacon->capability;
 	network->last_scanned = jiffies;
 	network->time_stamp[0] = beacon->time_stamp[0];
@@ -849,7 +839,7 @@
 	while (left >= sizeof(struct ieee80211_info_element_hdr)) {
 		if (sizeof(struct ieee80211_info_element_hdr) + info_element->len > left) {
 			IEEE80211_DEBUG_SCAN("SCAN: parse failed: info_element->len + 2 > left : info_element->len+2=%d left=%d.\n",
-					     info_element->len + sizeof(struct ieee80211_info_element),
+					     info_element->len + (int)sizeof(struct ieee80211_info_element),
 					     left);
 			return 1;
                	}
@@ -1017,7 +1007,7 @@
 	 * as one network */
 	return ((src->ssid_len == dst->ssid_len) &&
 		(src->channel == dst->channel) &&
-		!memcmp(src->bssid, dst->bssid, ETH_ALEN) &&
+		!memcmp(src->bssid, dst->bssid, IEEE80211_ALEN) &&
 		!memcmp(src->ssid, dst->ssid, src->ssid_len));
 }
 
--- a/net/ieee80211/ieee80211_module.c
+++ b/net/ieee80211/ieee80211_module.c
@@ -48,7 +48,6 @@
 #include <linux/types.h>
 #include <linux/version.h>
 #include <linux/wireless.h>
-#include <linux/etherdevice.h>
 #include <asm/uaccess.h>
 #include <net/arp.h>
 
@@ -99,28 +98,230 @@
 }
 
 
+static int ieee80211_change_mtu(struct net_device *dev, int new_mtu)
+{
+	if ((new_mtu < 68) || (new_mtu > IEEE80211_DATA_LEN - 8 - SNAP_SIZE))
+		return -EINVAL;
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+
+static u8 P802_1H_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0xf8 };
+static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
+
+static inline int __ieee80211_put_snap(u8 *data, u16 h_proto)
+{
+	struct ieee80211_snap_hdr *snap;
+	u8 *oui;
+
+	snap = (struct ieee80211_snap_hdr *)data;
+	snap->dsap = 0xaa;
+	snap->ssap = 0xaa;
+	snap->ctrl = 0x03;
+
+	if (h_proto == __constant_htons(ETH_P_IPX) ||
+			h_proto == __constant_htons(ETH_P_AARP))
+		oui = P802_1H_OUI;
+	else
+		oui = RFC1042_OUI;
+	snap->oui[0] = oui[0];
+	snap->oui[1] = oui[1];
+	snap->oui[2] = oui[2];
+
+	snap->type = h_proto;
+
+	return SNAP_SIZE;
+}
+
+static inline int ieee80211_put_snap(u8 *data, u16 h_proto)
+{
+	return __ieee80211_put_snap(data, htons(h_proto));
+}
+
+/*
+ *       Create the IEEE 802.11 MAC header for an arbitrary protocol layer
+ *
+ *      saddr=NULL      means use device source address
+ *      daddr=NULL      means leave destination address (eg unresolved arp)
+ */
+static int ieee80211_header(struct sk_buff *skb, struct net_device *dev,
+		unsigned short type, void *daddr, void *saddr, unsigned len)
+{
+	struct ieee80211_device *ieee = netdev_priv(dev);
+	struct ieee80211_hdr *header;
+	int fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA;
+	int hdr_len = IEEE80211_3ADDR_LEN;
+	
+	if (type != ETH_P_802_3 && type != ETH_P_802_2) {
+		ieee80211_put_snap(skb_push(skb, SNAP_SIZE), type);
+		hdr_len += SNAP_SIZE;
+	}
+
+	if (!saddr) saddr = dev->dev_addr;
+	header = (struct ieee80211_hdr *)skb_push(skb, IEEE80211_3ADDR_LEN);
+	header->duration_id = header->seq_ctl = 0;
+	if (ieee->iw_mode == IW_MODE_INFRA) {
+		fc |= IEEE80211_FCTL_TODS;
+		/* To DS: Addr1 = BSSID, Addr2 = SA,
+		   Addr3 = DA */
+		memcpy(header->addr1, ieee->bssid, IEEE80211_ALEN);
+		memcpy(header->addr2, saddr, IEEE80211_ALEN);
+		if (daddr)
+			memcpy(header->addr3, daddr, IEEE80211_ALEN);
+		else
+			memset(header->addr3, 0, IEEE80211_ALEN);
+	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
+		/* not From/To DS: Addr1 = DA, Addr2 = SA,
+		   Addr3 = BSSID */
+		if (daddr)
+			memcpy(header->addr1, daddr, IEEE80211_ALEN);
+		else
+			memset(header->addr1, 0, IEEE80211_ALEN);
+		memcpy(header->addr2, saddr, IEEE80211_ALEN);
+		memcpy(header->addr3, ieee->bssid, IEEE80211_ALEN);
+	}
+	header->frame_ctl = cpu_to_le16(fc);
+
+	if (!daddr || (dev->flags & (IFF_LOOPBACK | IFF_NOARP)))
+		return -hdr_len;
+	return hdr_len;
+}
+
+static int ieee80211_rebuild_header(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *header = (struct ieee80211_hdr *)skb->data;
+	struct net_device *dev = skb->dev;
+	unsigned short type;
+
+	type = ieee80211_get_proto(header);
+
+	switch (type) {
+#ifdef CONFIG_INET
+	case ETH_P_IP:
+		return arp_find(IEEE80211_GET_DADDR(header), skb);
+#endif
+	default:
+		printk(KERN_DEBUG
+			"%s: unable to resolve type %X addresses.\n",
+			dev->name, type);
+		break;
+	}
+	
+	return 0;
+}
+
+static int ieee80211_mac_addr(struct net_device *dev, void *p)
+{
+	struct sockaddr *addr = p;
+
+	if (netif_running(dev))
+		return -EBUSY;
+	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+	return 0;
+}
+
+static int ieee80211_header_cache(struct neighbour *neigh, struct hh_cache *hh)
+{
+	struct net_device *dev = neigh->dev;
+	struct ieee80211_device *ieee = netdev_priv(dev);
+	unsigned short type = hh->hh_type;
+	struct ieee80211_hdr *header;
+	int fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA;
+
+	if (type == __constant_htons(ETH_P_802_3) ||
+			type == __constant_htons(ETH_P_802_2))
+		return -1;
+
+	header = (struct ieee80211_hdr *)
+		(((u8 *)hh->hh_data) +
+			(HH_DATA_OFF(IEEE80211_3ADDR_LEN + SNAP_SIZE)));
+	__ieee80211_put_snap((u8 *)header + IEEE80211_3ADDR_LEN, type);
+	
+	header->duration_id = header->seq_ctl = 0;
+	if (ieee->iw_mode == IW_MODE_INFRA) {
+		fc |= IEEE80211_FCTL_TODS;
+		/* To DS: Addr1 = BSSID, Addr2 = SA,
+		   Addr3 = DA */
+		memcpy(header->addr1, ieee->bssid, IEEE80211_ALEN);
+		memcpy(header->addr2, dev->dev_addr, IEEE80211_ALEN);
+		memcpy(header->addr3, neigh->ha, IEEE80211_ALEN);
+	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
+		/* not From/To DS: Addr1 = DA, Addr2 = SA,
+		   Addr3 = BSSID */
+		memcpy(header->addr1, neigh->ha, IEEE80211_ALEN);
+		memcpy(header->addr2, dev->dev_addr, IEEE80211_ALEN);
+		memcpy(header->addr3, ieee->bssid, IEEE80211_ALEN);
+	}
+	header->frame_ctl = cpu_to_le16(fc);
+
+	hh->hh_len = IEEE80211_3ADDR_LEN + SNAP_SIZE;
+	return 0;
+}
+
+static void ieee80211_header_cache_update(struct hh_cache *hh,
+		struct net_device *dev, unsigned char *haddr)
+{
+	struct ieee80211_hdr *header;
+
+	header = (struct ieee80211_hdr *)
+		(((u8 *)hh->hh_data) +
+			(HH_DATA_OFF(IEEE80211_3ADDR_LEN + SNAP_SIZE)));
+	memcpy(IEEE80211_GET_DADDR(header), haddr, dev->addr_len);
+}
+
+static int ieee80211_header_parse(struct sk_buff *skb, unsigned char *haddr)
+{
+	struct ieee80211_hdr *header = (struct ieee80211_hdr *)skb->data;
+
+	memcpy(haddr, IEEE80211_GET_SADDR(header), IEEE80211_ALEN);
+	return IEEE80211_ALEN;
+}
+
+
+void ieee80211_setup(struct net_device *dev)
+{
+	dev->change_mtu		 = ieee80211_change_mtu;
+	dev->hard_header	 = ieee80211_header;
+	dev->rebuild_header	 = ieee80211_rebuild_header;
+	dev->set_mac_address	 = ieee80211_mac_addr;
+	dev->hard_header_cache	 = ieee80211_header_cache;
+	dev->header_cache_update = ieee80211_header_cache_update;
+	dev->hard_header_parse	 = ieee80211_header_parse;
+
+	dev->hard_start_xmit     = ieee80211_xmit;
+
+	dev->type		 = ARPHRD_ETHER;
+	dev->hard_header_len	 = IEEE80211_3ADDR_LEN + SNAP_SIZE;
+	dev->mtu		 = IEEE80211_DATA_LEN - 8 - SNAP_SIZE;
+	dev->addr_len		 = IEEE80211_ALEN;
+	dev->tx_queue_len	 = 1000;
+	dev->flags		 = IFF_BROADCAST | IFF_MULTICAST;
+	
+	memset(dev->broadcast, 0xFF, IEEE80211_ALEN);
+}
+
+
 struct ieee80211_device *alloc_ieee80211(int sizeof_priv)
 {
 	struct ieee80211_device *ieee;
 	struct net_device *dev;
-	int alloc_size;
+ 	int alloc_size;
 	int err;
 
 	IEEE80211_DEBUG_INFO("Initializing...\n");
 
-	alloc_size = ((sizeof(struct ieee80211_device) + NETDEV_ALIGN_CONST) 
-			& ~NETDEV_ALIGN_CONST) 
-			+ sizeof_priv;
-	dev = alloc_etherdev(alloc_size);
+ 	alloc_size = ((sizeof(struct ieee80211_device) + NETDEV_ALIGN_CONST) 
+ 			& ~NETDEV_ALIGN_CONST) 
+ 			+ sizeof_priv;
+	dev = alloc_netdev(alloc_size, "wlan%d", ieee80211_setup);
 	if (!dev) {
-		IEEE80211_ERROR("Unable to network device.\n");
+		IEEE80211_ERROR("Unable to allocate network device.\n");
 		goto failed;
 	}
 	ieee = netdev_priv(dev);
 	ieee->dev = dev;
 	ieee->priv = ieee80211_priv(ieee);
-	
-	dev->hard_start_xmit = ieee80211_xmit;
 
 	err = ieee80211_networks_allocate(ieee);
 	if (err) {
@@ -201,7 +402,7 @@
 			     unsigned long count, void *data)
 {
 	char buf[] = "0x00000000";
-	unsigned long len = min(sizeof(buf) - 1, (u32)count);
+	unsigned long len = min((unsigned long)sizeof(buf) - 1, count);
 	char *p = (char *)buf;
 	unsigned long val;
 
@@ -268,4 +469,5 @@
 #endif
 
+EXPORT_SYMBOL(ieee80211_setup);
 EXPORT_SYMBOL(alloc_ieee80211);
 EXPORT_SYMBOL(free_ieee80211);
--- a/net/ieee80211/ieee80211_tx.c
+++ b/net/ieee80211/ieee80211_tx.c
@@ -84,16 +84,6 @@
 Total: 8 non-data bytes
 
 
-802.3 Ethernet Data Frame
-
-      ,-----------------------------------------.
-Bytes |   6   |   6   |  2   |  Variable |   4  |
-      |-------|-------|------|-----------|------|
-Desc. | Dest. | Source| Type | IP Packet |  fcs |
-      |  MAC  |  MAC  |      |           |      |
-      `-----------------------------------------'
-Total: 18 non-data bytes
-
 In the event that fragmentation is required, the incoming payload is split into
 N parts of size ieee->fts.  The first fragment contains the SNAP header and the
 remaining packets are just data.
@@ -104,56 +94,8 @@
 encryption it will take 3 frames.  With WEP it will take 4 frames as the
 payload of each frame is reduced to 492 bytes.
 
-* SKB visualization
-*
-*  ,- skb->data
-* |
-* |    ETHERNET HEADER        ,-<-- PAYLOAD
-* |                           |     14 bytes from skb->data
-* |  2 bytes for Type --> ,T. |     (sizeof ethhdr)
-* |                       | | |
-* |,-Dest.--. ,--Src.---. | | |
-* |  6 bytes| | 6 bytes | | | |
-* v         | |         | | | |
-* 0         | v       1 | v | v           2
-* 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
-*     ^     | ^         | ^ |
-*     |     | |         | | |
-*     |     | |         | `T' <---- 2 bytes for Type
-*     |     | |         |
-*     |     | '---SNAP--' <-------- 6 bytes for SNAP
-*     |     |
-*     `-IV--' <-------------------- 4 bytes for IV (WEP)
-*
-*      SNAP HEADER
-*
 */
 
-static u8 P802_1H_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0xf8 };
-static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
-
-static inline int ieee80211_put_snap(u8 *data, u16 h_proto)
-{
-	struct ieee80211_snap_hdr *snap;
-	u8 *oui;
-
-	snap = (struct ieee80211_snap_hdr *)data;
-	snap->dsap = 0xaa;
-	snap->ssap = 0xaa;
-	snap->ctrl = 0x03;
-
-	if (h_proto == 0x8137 || h_proto == 0x80f3)
-		oui = P802_1H_OUI;
-	else
-		oui = RFC1042_OUI;
-	snap->oui[0] = oui[0];
-	snap->oui[1] = oui[1];
-	snap->oui[2] = oui[2];
-
-	*(u16 *)(data + SNAP_SIZE) = htons(h_proto);
-
-	return SNAP_SIZE + sizeof(u16);
-}
 
 static inline int ieee80211_encrypt_fragment(
 	struct ieee80211_device *ieee,
@@ -248,19 +190,16 @@
 		   struct net_device *dev)
 {
 	struct ieee80211_device *ieee = netdev_priv(dev);
+	struct ieee80211_hdr *header = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_txb *txb = NULL;
 	struct ieee80211_hdr *frag_hdr;
 	int i, bytes_per_frag, nr_frags, bytes_last_frag, frag_size;
 	unsigned long flags;
 	struct net_device_stats *stats = &ieee->stats;
-	int ether_type, encrypt;
+	int type, encrypt;
 	int bytes, fc, hdr_len;
 	struct sk_buff *skb_frag;
-	struct ieee80211_hdr header = { /* Ensure zero initialized */
-		.duration_id = 0,
-		.seq_ctl = 0
-	};
-	u8 dest[ETH_ALEN], src[ETH_ALEN];
+	u8 *dest;
 
 	struct ieee80211_crypt_data* crypt;
 
@@ -269,76 +208,48 @@
 	/* If there is no driver handler to take the TXB, dont' bother
 	 * creating it... */
 	if (!ieee->hard_start_xmit) {
-		printk(KERN_WARNING "%s: No xmit handler.\n",
-		       dev->name);
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: No xmit handler.\n",
+				dev->name);
 		goto success;
 	}
 
-	if (unlikely(skb->len < SNAP_SIZE + sizeof(u16))) {
-		printk(KERN_WARNING "%s: skb too small (%d).\n",
-		       dev->name, skb->len);
-		goto success;
-	}
-
-	ether_type = ntohs(((struct ethhdr *)skb->data)->h_proto);
+	type = ieee80211_get_proto(header);
+	dest = IEEE80211_GET_DADDR(header);
+	hdr_len = ieee80211_get_hdrlen(header);
 
 	crypt = ieee->crypt[ieee->tx_keyidx];
 
-	encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) &&
+	encrypt = !(type == ETH_P_PAE && ieee->ieee802_1x) &&
 		ieee->host_encrypt && crypt && crypt->ops;
 
 	if (!encrypt && ieee->ieee802_1x &&
-	    ieee->drop_unencrypted && ether_type != ETH_P_PAE) {
+	    ieee->drop_unencrypted && type != ETH_P_PAE) {
 		stats->tx_dropped++;
 		goto success;
 	}
 
 #ifdef CONFIG_IEEE80211_DEBUG
-	if (crypt && !encrypt && ether_type == ETH_P_PAE) {
-		struct eapol *eap = (struct eapol *)(skb->data +
-			sizeof(struct ethhdr) - SNAP_SIZE - sizeof(u16));
+	if (crypt && !encrypt && type == ETH_P_PAE) {
+		struct eapol *eap = (struct eapol *)(skb->data + hdr_len);
 		IEEE80211_DEBUG_EAP("TX: IEEE 802.11 EAPOL frame: %s\n",
 			eap_get_type(eap->type));
 	}
 #endif
 
-	/* Save source and destination addresses */
-	memcpy(&dest, skb->data, ETH_ALEN);
-	memcpy(&src, skb->data+ETH_ALEN, ETH_ALEN);
-
-	/* Advance the SKB to the start of the payload */
-	skb_pull(skb, sizeof(struct ethhdr));
-
 	/* Determine total amount of storage required for TXB packets */
-	bytes = skb->len + SNAP_SIZE + sizeof(u16);
+	bytes = skb->len - hdr_len;
 
+	fc = le16_to_cpu(header->frame_ctl);
 	if (encrypt)
-		fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA |
-			IEEE80211_FCTL_WEP;
-	else
-		fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA;
+		fc |= IEEE80211_FCTL_WEP;
 
-	if (ieee->iw_mode == IW_MODE_INFRA) {
-		fc |= IEEE80211_FCTL_TODS;
-		/* To DS: Addr1 = BSSID, Addr2 = SA,
-		   Addr3 = DA */
-		memcpy(&header.addr1, ieee->bssid, ETH_ALEN);
-		memcpy(&header.addr2, &src, ETH_ALEN);
-		memcpy(&header.addr3, &dest, ETH_ALEN);
-	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
-		/* not From/To DS: Addr1 = DA, Addr2 = SA,
-		   Addr3 = BSSID */
-		memcpy(&header.addr1, dest, ETH_ALEN);
-		memcpy(&header.addr2, src, ETH_ALEN);
-		memcpy(&header.addr3, ieee->bssid, ETH_ALEN);
-	}
-	header.frame_ctl = cpu_to_le16(fc);
-	hdr_len = IEEE80211_3ADDR_LEN;
+	header->frame_ctl = cpu_to_le16(fc);
 
 	/* Determine fragmentation size based on destination (multicast
 	 * and broadcast are not fragmented) */
-	if (is_multicast_ether_addr(dest) ||
-	    is_broadcast_ether_addr(dest))
+	if (is_multicast_ieee80211_addr(dest) ||
+	    is_broadcast_ieee80211_addr(dest))
 		frag_size = MAX_FRAG_THRESHOLD;
 	else
 		frag_size = ieee->fts;
@@ -347,7 +258,7 @@
 	 * this stack is providing the full 802.11 header, one will
 	 * eventually be affixed to this fragment -- so we must account for
 	 * it when determining the amount of payload space. */
-	bytes_per_frag = frag_size - IEEE80211_3ADDR_LEN;
+	bytes_per_frag = frag_size - hdr_len;
 	if (ieee->config &
 	    (CFG_IEEE80211_COMPUTE_FCS | CFG_IEEE80211_RESERVE_FCS))
 		bytes_per_frag -= IEEE80211_FCS_LEN;
@@ -378,6 +289,8 @@
 	txb->encrypted = encrypt;
 	txb->payload_size = bytes;
 
+	skb_pull(skb, hdr_len);
+
 	for (i = 0; i < nr_frags; i++) {
 		skb_frag = txb->fragments[i];
 
@@ -385,7 +298,7 @@
 			skb_reserve(skb_frag, crypt->ops->extra_prefix_len);
 
 		frag_hdr = (struct ieee80211_hdr *)skb_put(skb_frag, hdr_len);
-		memcpy(frag_hdr, &header, hdr_len);
+		memcpy(frag_hdr, header, hdr_len);
 
 		/* If this is not the last fragment, then add the MOREFRAGS
 		 * bit to the frame control */
@@ -398,14 +311,6 @@
 			bytes = bytes_last_frag;
 		}
 
-	       	/* Put a SNAP header on the first fragment */
-		if (i == 0) {
-			ieee80211_put_snap(
-				skb_put(skb_frag, SNAP_SIZE + sizeof(u16)),
-				ether_type);
-			bytes -= SNAP_SIZE + sizeof(u16);
-		}
-
 		memcpy(skb_put(skb_frag, bytes), skb->data, bytes);
 
 		/* Advance the SKB... */
--- a/net/ieee80211/ieee80211_wx.c
+++ b/net/ieee80211/ieee80211_wx.c
@@ -53,7 +53,7 @@
 	/* First entry *MUST* be the AP MAC address */
 	iwe.cmd = SIOCGIWAP;
 	iwe.u.ap_addr.sa_family = ARPHRD_ETHER;
-	memcpy(iwe.u.ap_addr.sa_data, network->bssid, ETH_ALEN);
+	memcpy(iwe.u.ap_addr.sa_data, network->bssid, IEEE80211_ALEN);
 	start = iwe_stream_add_event(start, stop, &iwe, IW_EV_ADDR_LEN);
 
 	/* Remaining entries will be displayed in the order we provide them */
--- a/net/ieee80211/ieee80211_crypt_ccmp.c
+++ b/net/ieee80211/ieee80211_crypt_ccmp.c
@@ -17,7 +17,6 @@
 #include <linux/random.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <asm/string.h>
 #include <linux/wireless.h>
@@ -156,7 +155,7 @@
 	 * Dlen */
 	b0[0] = 0x59;
 	b0[1] = qc;
-	memcpy(b0 + 2, hdr->addr2, ETH_ALEN);
+	memcpy(b0 + 2, hdr->addr2, IEEE80211_ALEN);
 	memcpy(b0 + 8, pn, CCMP_PN_LEN);
 	b0[14] = (dlen >> 8) & 0xff;
 	b0[15] = dlen & 0xff;
@@ -173,13 +172,13 @@
 	aad[1] = aad_len & 0xff;
 	aad[2] = pos[0] & 0x8f;
 	aad[3] = pos[1] & 0xc7;
-	memcpy(aad + 4, hdr->addr1, 3 * ETH_ALEN);
+	memcpy(aad + 4, hdr->addr1, 3 * IEEE80211_ALEN);
 	pos = (u8 *) &hdr->seq_ctl;
 	aad[22] = pos[0] & 0x0f;
 	aad[23] = 0; /* all bits masked */
 	memset(aad + 24, 0, 8);
 	if (a4_included)
-		memcpy(aad + 24, hdr->addr4, ETH_ALEN);
+		memcpy(aad + 24, hdr->addr4, IEEE80211_ALEN);
 	if (qc_included) {
 		aad[a4_included ? 30 : 24] = qc;
 		/* rest of QC masked */
--- a/net/ieee80211/ieee80211_crypt_tkip.c
+++ b/net/ieee80211/ieee80211_crypt_tkip.c
@@ -17,7 +17,6 @@
 #include <linux/random.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <asm/string.h>
 
@@ -461,20 +460,20 @@
 	switch (le16_to_cpu(hdr11->frame_ctl) &
 		(IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
 	case IEEE80211_FCTL_TODS:
-		memcpy(hdr, hdr11->addr3, ETH_ALEN); /* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr2, ETH_ALEN); /* SA */
+		memcpy(hdr, hdr11->addr3, IEEE80211_ALEN); /* DA */
+		memcpy(hdr + IEEE80211_ALEN, hdr11->addr2, IEEE80211_ALEN); /* SA */
 		break;
 	case IEEE80211_FCTL_FROMDS:
-		memcpy(hdr, hdr11->addr1, ETH_ALEN); /* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr3, ETH_ALEN); /* SA */
+		memcpy(hdr, hdr11->addr1, IEEE80211_ALEN); /* DA */
+		memcpy(hdr + IEEE80211_ALEN, hdr11->addr3, IEEE80211_ALEN); /* SA */
 		break;
 	case IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS:
-		memcpy(hdr, hdr11->addr3, ETH_ALEN); /* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr4, ETH_ALEN); /* SA */
+		memcpy(hdr, hdr11->addr3, IEEE80211_ALEN); /* DA */
+		memcpy(hdr + IEEE80211_ALEN, hdr11->addr4, IEEE80211_ALEN); /* SA */
 		break;
 	case 0:
-		memcpy(hdr, hdr11->addr1, ETH_ALEN); /* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr2, ETH_ALEN); /* SA */
+		memcpy(hdr, hdr11->addr1, IEEE80211_ALEN); /* DA */
+		memcpy(hdr + IEEE80211_ALEN, hdr11->addr2, IEEE80211_ALEN); /* SA */
 		break;
 	}
 
@@ -521,7 +520,7 @@
 	else
 		ev.flags |= IW_MICFAILURE_PAIRWISE;
 	ev.src_addr.sa_family = ARPHRD_ETHER;
-	memcpy(ev.src_addr.sa_data, hdr->addr2, ETH_ALEN);
+	memcpy(ev.src_addr.sa_data, hdr->addr2, IEEE80211_ALEN);
 	memset(&wrqu, 0, sizeof(wrqu));
 	wrqu.data.length = sizeof(ev);
 	wireless_send_event(dev, IWEVMICHAELMICFAILURE, &wrqu, (char *) &ev);


--
Jiri Benc
SUSE Labs
