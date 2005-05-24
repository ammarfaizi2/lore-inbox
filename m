Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVEXNNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVEXNNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVEXNNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:13:17 -0400
Received: from styx.suse.cz ([82.119.242.94]:187 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262054AbVEXNLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:11:22 -0400
Date: Tue, 24 May 2005 15:11:17 +0200
From: Jiri Benc <jbenc@suse.cz>
To: NetDev <netdev@oss.sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, pavel@suse.cz
Subject: [2/5] ieee80211: ieee80211_device alignment fix and cleanup
Message-ID: <20050524151117.5e059d1d@griffin.suse.cz>
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
References: <20050524150711.01632672@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to the ieee80211 layer:
- fixes a serious alignment problem of the driver's private data
- makes the drivers use the ieee80211_device instead of the net_device where
  appropriate (will ease further development of ieee80211 as a self-contained
  layer)


Signed-off-by: Jiri Benc <jbenc@suse.cz>
Signed-off-by: Jirka Bohac <jbohac@suse.cz>

--- linux-2.6.12-rc2-mm3.01/include/net/ieee80211.h	2005-05-18 10:49:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3.02.0/include/net/ieee80211.h	2005-05-18 12:02:03.000000000 +0200
@@ -704,15 +704,13 @@
 	int abg_ture;   /* ABG flag              */
 
 	/* Callback functions */
-	void (*set_security)(struct net_device *dev,
+	void (*set_security)(struct ieee80211_device *ieee,
 			     struct ieee80211_security *sec);
 	int (*hard_start_xmit)(struct ieee80211_txb *txb,
-			       struct net_device *dev);
-	int (*reset_port)(struct net_device *dev);
+			       struct ieee80211_device *ieee);
+	int (*reset_port)(struct ieee80211_device *ieee);
 
-	/* This must be the last item so that it points to the data
-	 * allocated beyond this structure by alloc_ieee80211 */
-	u8 priv[0];
+	void *priv;
 };
 
 #define IEEE_A            (1<<0)
@@ -720,9 +718,18 @@
 #define IEEE_G            (1<<2)
 #define IEEE_MODE_MASK    (IEEE_A|IEEE_B|IEEE_G)
 
-extern inline void *ieee80211_priv(struct net_device *dev)
+static inline void *ieee80211_priv(struct ieee80211_device *ieee)
 {
-	return ((struct ieee80211_device *)netdev_priv(dev))->priv;
+	 return (char *)ieee + 
+	 	((sizeof(struct ieee80211_device) + NETDEV_ALIGN_CONST)
+			& ~NETDEV_ALIGN_CONST);
+}
+
+static inline struct net_device *ieee80211_dev(struct ieee80211_device *ieee)
+{
+	 return (struct net_device *)((char *)ieee - 
+	 	((sizeof(struct net_device) + NETDEV_ALIGN_CONST)
+			& ~NETDEV_ALIGN_CONST));
 }
 
 extern inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
@@ -795,8 +802,8 @@
 
 
 /* ieee80211.c */
-extern void free_ieee80211(struct net_device *dev);
-extern struct net_device *alloc_ieee80211(int sizeof_priv);
+extern void free_ieee80211(struct ieee80211_device *ieee);
+extern struct ieee80211_device *alloc_ieee80211(int sizeof_priv);
 
 extern int ieee80211_set_encryption(struct ieee80211_device *ieee);
 
--- linux-2.6.12-rc2-mm3.01/net/ieee80211/ieee80211_module.c	2005-04-19 17:04:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3.02.0/net/ieee80211/ieee80211_module.c	2005-05-18 12:04:30.000000000 +0200
@@ -70,7 +70,7 @@
 		GFP_KERNEL);
 	if (!ieee->networks) {
 		printk(KERN_WARNING "%s: Out of memory allocating beacons\n",
-		       ieee->dev->name);
+		       ieee80211_dev(ieee)->name);
 		return -ENOMEM;
 	}
 
@@ -99,23 +99,28 @@
 }
 
 
-struct net_device *alloc_ieee80211(int sizeof_priv)
+struct ieee80211_device *alloc_ieee80211(int sizeof_priv)
 {
 	struct ieee80211_device *ieee;
 	struct net_device *dev;
+	int alloc_size;
 	int err;
 
 	IEEE80211_DEBUG_INFO("Initializing...\n");
 
-	dev = alloc_etherdev(sizeof(struct ieee80211_device) + sizeof_priv);
+	alloc_size = ((sizeof(struct ieee80211_device) + NETDEV_ALIGN_CONST) 
+			& ~NETDEV_ALIGN_CONST) 
+			+ sizeof_priv;
+	dev = alloc_etherdev(alloc_size);
 	if (!dev) {
 		IEEE80211_ERROR("Unable to network device.\n");
 		goto failed;
 	}
 	ieee = netdev_priv(dev);
-	dev->hard_start_xmit = ieee80211_xmit;
-
 	ieee->dev = dev;
+	ieee->priv = ieee80211_priv(ieee);
+	
+	dev->hard_start_xmit = ieee80211_xmit;
 
 	err = ieee80211_networks_allocate(ieee);
 	if (err) {
@@ -148,7 +153,7 @@
  	ieee->privacy_invoked = 0;
  	ieee->ieee802_1x = 1;
 
-	return dev;
+	return ieee;
 
  failed:
 	if (dev)
@@ -157,10 +162,8 @@
 }
 
 
-void free_ieee80211(struct net_device *dev)
+void free_ieee80211(struct ieee80211_device *ieee)
 {
-	struct ieee80211_device *ieee = netdev_priv(dev);
-
 	int i;
 
 	del_timer_sync(&ieee->crypt_deinit_timer);
@@ -179,7 +182,7 @@
 	}
 
 	ieee80211_networks_free(ieee);
-	free_netdev(dev);
+	free_netdev(ieee80211_dev(ieee));
 }
 
 #ifdef CONFIG_IEEE80211_DEBUG
--- linux-2.6.12-rc2-mm3.01/net/ieee80211/ieee80211_rx.c	2005-05-18 10:49:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3.02.0/net/ieee80211/ieee80211_rx.c	2005-05-18 12:24:18.000000000 +0200
@@ -100,7 +100,7 @@
 
 	if (frag == 0) {
 		/* Reserve enough space to fit maximum frame length */
-		skb = dev_alloc_skb(ieee->dev->mtu +
+		skb = dev_alloc_skb(ieee80211_dev(ieee)->mtu +
 				    sizeof(struct ieee80211_hdr) +
 				    8 /* LLC */ +
 				    2 /* alignment */ +
@@ -176,7 +176,7 @@
 {
 	if (ieee->iw_mode == IW_MODE_MASTER) {
 		printk(KERN_DEBUG "%s: Master mode not yet suppported.\n",
-		       ieee->dev->name);
+		       ieee80211_dev(ieee)->name);
 		return 0;
 /*
   hostap_update_sta_ps(ieee, (struct hostap_ieee80211_hdr *)
@@ -234,7 +234,7 @@
 static int ieee80211_is_eapol_frame(struct ieee80211_device *ieee,
 				    struct sk_buff *skb)
 {
-	struct net_device *dev = ieee->dev;
+	struct net_device *dev = ieee80211_dev(ieee);
 	u16 fc, ethertype;
 	struct ieee80211_hdr *hdr;
 	u8 *pos;
@@ -290,7 +290,7 @@
 		if (net_ratelimit()) {
 			printk(KERN_DEBUG "%s: TKIP countermeasures: dropped "
 			       "received packet from " MAC_FMT "\n",
-			       ieee->dev->name, MAC_ARG(hdr->addr2));
+			       ieee80211_dev(dev)->name, MAC_ARG(hdr->addr2));
 		}
 		return -1;
 	}
@@ -335,7 +335,7 @@
 	if (res < 0) {
 		printk(KERN_DEBUG "%s: MSDU decryption/MIC verification failed"
 		       " (SA=" MAC_FMT " keyidx=%d)\n",
-		       ieee->dev->name, MAC_ARG(hdr->addr2), keyidx);
+		       ieee80211_dev(ieee)->name, MAC_ARG(hdr->addr2), keyidx);
 		return -1;
 	}
 
@@ -349,7 +349,7 @@
 int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 		 struct ieee80211_rx_stats *rx_stats)
 {
-	struct net_device *dev = ieee->dev;
+	struct net_device *dev = ieee80211_dev(ieee);
 	struct ieee80211_hdr *hdr;
 	size_t hdrlen;
 	u16 fc, type, stype, sc;
@@ -1195,7 +1195,7 @@
 		IEEE80211_DEBUG_MGMT("received UNKNOWN (%d)\n",
 				     WLAN_FC_GET_STYPE(header->frame_ctl));
 		IEEE80211_WARNING("%s: Unknown management packet: %d\n",
-				  ieee->dev->name,
+				  ieee80211_dev(ieee)->name,
 				  WLAN_FC_GET_STYPE(header->frame_ctl));
 		break;
 	}
--- linux-2.6.12-rc2-mm3.01/net/ieee80211/ieee80211_tx.c	2005-04-19 17:04:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3.02.0/net/ieee80211/ieee80211_tx.c	2005-05-18 12:20:07.000000000 +0200
@@ -172,7 +172,7 @@
 		if (net_ratelimit()) {
 			printk(KERN_DEBUG "%s: TKIP countermeasures: dropped "
 			       "TX packet to " MAC_FMT "\n",
-			       ieee->dev->name, MAC_ARG(header->addr1));
+			       ieee80211_dev(ieee)->name, MAC_ARG(header->addr1));
 		}
 		return -1;
 	}
@@ -193,7 +193,7 @@
 	atomic_dec(&crypt->refcnt);
 	if (res < 0) {
 		printk(KERN_INFO "%s: Encryption failed: len=%d.\n",
-		       ieee->dev->name, frag->len);
+		       ieee80211_dev(ieee)->name, frag->len);
 		ieee->ieee_stats.tx_discards++;
 		return -1;
 	}
@@ -270,13 +270,13 @@
 	 * creating it... */
 	if (!ieee->hard_start_xmit) {
 		printk(KERN_WARNING "%s: No xmit handler.\n",
-		       ieee->dev->name);
+		       dev->name);
 		goto success;
 	}
 
 	if (unlikely(skb->len < SNAP_SIZE + sizeof(u16))) {
 		printk(KERN_WARNING "%s: skb too small (%d).\n",
-		       ieee->dev->name, skb->len);
+		       dev->name, skb->len);
 		goto success;
 	}
 
@@ -372,7 +372,7 @@
 	txb = ieee80211_alloc_txb(nr_frags, frag_size, GFP_ATOMIC);
 	if (unlikely(!txb)) {
 		printk(KERN_WARNING "%s: Could not allocate TXB\n",
-		       ieee->dev->name);
+		       dev->name);
 		goto failed;
 	}
 	txb->encrypted = encrypt;
@@ -427,7 +427,7 @@
 	dev_kfree_skb_any(skb);
 
 	if (txb) {
-		if ((*ieee->hard_start_xmit)(txb, dev) == 0) {
+		if ((*ieee->hard_start_xmit)(txb, ieee) == 0) {
 			stats->tx_packets++;
 			stats->tx_bytes += txb->payload_size;
 			return 0;
--- linux-2.6.12-rc2-mm3.01/net/ieee80211/ieee80211_wx.c	2005-04-19 17:04:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3.02.0/net/ieee80211/ieee80211_wx.c	2005-05-18 12:27:28.000000000 +0200
@@ -252,7 +252,7 @@
 			    union iwreq_data *wrqu, char *keybuf)
 {
 	struct iw_point *erq = &(wrqu->encoding);
-	struct net_device *dev = ieee->dev;
+	struct net_device *dev = ieee80211_dev(ieee);
 	struct ieee80211_security sec = {
 		.flags = 0
 	};
@@ -402,7 +402,7 @@
 	sec.level = SEC_LEVEL_1; /* 40 and 104 bit WEP */
 
 	if (ieee->set_security)
-		ieee->set_security(dev, &sec);
+		ieee->set_security(ieee, &sec);
 
 	/* Do not reset port if card is in Managed mode since resetting will
 	 * generate new IEEE 802.11 authentication which may end up in looping
@@ -411,7 +411,7 @@
 	 * the callbacks structures used to initialize the 802.11 stack. */
 	if (ieee->reset_on_keychange &&
 	    ieee->iw_mode != IW_MODE_INFRA &&
-	    ieee->reset_port && ieee->reset_port(dev)) {
+	    ieee->reset_port && ieee->reset_port(ieee)) {
 		printk(KERN_DEBUG "%s: reset_port failed\n", dev->name);
 		return -EINVAL;
 	}


--
Jiri Benc
SUSE Labs
