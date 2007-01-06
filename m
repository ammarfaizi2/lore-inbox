Return-Path: <linux-kernel-owner+w=401wt.eu-S1751126AbXAFCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXAFCbX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXAFCbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:19 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36646 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXAFCak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:40 -0500
Message-Id: <20070106023419.123591000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       Ulrich Kunitz <kune@deine-taler.de>,
       John W Linville <linville@tuxdriver.com>
Subject: [patch 29/50] zd1211rw: Call ieee80211_rx in tasklet
Content-Disposition: inline; filename=zd1211rw-call-ieee80211_rx-in-tasklet.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ulrich Kunitz <kune@deine-taler.de>

[PATCH] zd1211rw: Call ieee80211_rx in tasklet

The driver called ieee80211_rx in hardware interrupt context.  This has
been against the intention of the ieee80211_rx function.  It caused a bug
in the crypto routines used by WPA.  This patch calls ieee80211_rx in a
tasklet.

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Date: Sun, 10 Dec 2006 19:13:12 +0000 (-0800)
Subject: [patch 29/50] [PATCH] zd1211rw: Call ieee80211_rx in tasklet
X-Git-Tag: v2.6.20-rc2
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4d1feabcbf41f875447a392015acd0796f57baf6

 drivers/net/wireless/zd1211rw/zd_mac.c |   91 ++++++++++++++++++++++++---------
 drivers/net/wireless/zd1211rw/zd_mac.h |    6 +-
 drivers/net/wireless/zd1211rw/zd_usb.c |    4 -
 3 files changed, 75 insertions(+), 26 deletions(-)

--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_mac.c
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -37,6 +37,8 @@ static void housekeeping_init(struct zd_
 static void housekeeping_enable(struct zd_mac *mac);
 static void housekeeping_disable(struct zd_mac *mac);
 
+static void do_rx(unsigned long mac_ptr);
+
 int zd_mac_init(struct zd_mac *mac,
 	        struct net_device *netdev,
 	        struct usb_interface *intf)
@@ -47,6 +49,10 @@ int zd_mac_init(struct zd_mac *mac,
 	spin_lock_init(&mac->lock);
 	mac->netdev = netdev;
 
+	skb_queue_head_init(&mac->rx_queue);
+	tasklet_init(&mac->rx_tasklet, do_rx, (unsigned long)mac);
+	tasklet_disable(&mac->rx_tasklet);
+
 	ieee_init(ieee);
 	softmac_init(ieee80211_priv(netdev));
 	zd_chip_init(&mac->chip, netdev, intf);
@@ -132,6 +138,8 @@ out:
 
 void zd_mac_clear(struct zd_mac *mac)
 {
+	skb_queue_purge(&mac->rx_queue);
+	tasklet_kill(&mac->rx_tasklet);
 	zd_chip_clear(&mac->chip);
 	ZD_ASSERT(!spin_is_locked(&mac->lock));
 	ZD_MEMCLEAR(mac, sizeof(struct zd_mac));
@@ -160,6 +168,8 @@ int zd_mac_open(struct net_device *netde
 	struct zd_chip *chip = &mac->chip;
 	int r;
 
+	tasklet_enable(&mac->rx_tasklet);
+
 	r = zd_chip_enable_int(chip);
 	if (r < 0)
 		goto out;
@@ -210,6 +220,8 @@ int zd_mac_stop(struct net_device *netde
 	 */
 
 	zd_chip_disable_rx(chip);
+	skb_queue_purge(&mac->rx_queue);
+	tasklet_disable(&mac->rx_tasklet);
 	housekeeping_disable(mac);
 	ieee80211softmac_stop(netdev);
 
@@ -873,45 +885,78 @@ static int fill_rx_stats(struct ieee8021
 	return 0;
 }
 
-int zd_mac_rx(struct zd_mac *mac, const u8 *buffer, unsigned int length)
+static void zd_mac_rx(struct zd_mac *mac, struct sk_buff *skb)
 {
 	int r;
 	struct ieee80211_device *ieee = zd_mac_to_ieee80211(mac);
 	struct ieee80211_rx_stats stats;
 	const struct rx_status *status;
-	struct sk_buff *skb;
 
-	if (length < ZD_PLCP_HEADER_SIZE + IEEE80211_1ADDR_LEN +
-	             IEEE80211_FCS_LEN + sizeof(struct rx_status))
-		return -EINVAL;
+	if (skb->len < ZD_PLCP_HEADER_SIZE + IEEE80211_1ADDR_LEN +
+	               IEEE80211_FCS_LEN + sizeof(struct rx_status))
+	{
+		dev_dbg_f(zd_mac_dev(mac), "Packet with length %u to small.\n",
+			 skb->len);
+		goto free_skb;
+	}
 
-	r = fill_rx_stats(&stats, &status, mac, buffer, length);
-	if (r)
-		return r;
+	r = fill_rx_stats(&stats, &status, mac, skb->data, skb->len);
+	if (r) {
+		/* Only packets with rx errors are included here. */
+		goto free_skb;
+	}
 
-	length -= ZD_PLCP_HEADER_SIZE+IEEE80211_FCS_LEN+
-		  sizeof(struct rx_status);
-	buffer += ZD_PLCP_HEADER_SIZE;
+	__skb_pull(skb, ZD_PLCP_HEADER_SIZE);
+	__skb_trim(skb, skb->len -
+		        (IEEE80211_FCS_LEN + sizeof(struct rx_status)));
 
-	update_qual_rssi(mac, buffer, length, stats.signal, stats.rssi);
+	update_qual_rssi(mac, skb->data, skb->len, stats.signal,
+		         status->signal_strength);
 
-	r = filter_rx(ieee, buffer, length, &stats);
-	if (r <= 0)
-		return r;
 
-	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
-	if (!skb)
-		return -ENOMEM;
+	r = filter_rx(ieee, skb->data, skb->len, &stats);
+	if (r <= 0) {
+		if (r < 0)
+			dev_dbg_f(zd_mac_dev(mac), "Error in packet.\n");
+		goto free_skb;
+	}
+
 	if (ieee->iw_mode == IW_MODE_MONITOR)
-		fill_rt_header(skb_put(skb, sizeof(struct zd_rt_hdr)), mac,
+		fill_rt_header(skb_push(skb, sizeof(struct zd_rt_hdr)), mac,
 			       &stats, status);
-	memcpy(skb_put(skb, length), buffer, length);
 
 	r = ieee80211_rx(ieee, skb, &stats);
-	if (!r) {
-		ZD_ASSERT(in_irq());
-		dev_kfree_skb_irq(skb);
+	if (r)
+		return;
+
+free_skb:
+	/* We are always in a soft irq. */
+	dev_kfree_skb(skb);
+}
+
+static void do_rx(unsigned long mac_ptr)
+{
+	struct zd_mac *mac = (struct zd_mac *)mac_ptr;
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&mac->rx_queue)) != NULL)
+		zd_mac_rx(mac, skb);
+}
+
+int zd_mac_rx_irq(struct zd_mac *mac, const u8 *buffer, unsigned int length)
+{
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
+	if (!skb) {
+		dev_warn(zd_mac_dev(mac), "Could not allocate skb.\n");
+		return -ENOMEM;
 	}
+	skb_reserve(skb, sizeof(struct zd_rt_hdr));
+	memcpy(__skb_put(skb, length), buffer, length);
+	skb_queue_tail(&mac->rx_queue, skb);
+	tasklet_schedule(&mac->rx_tasklet);
+
 	return 0;
 }
 
--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_mac.h
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_mac.h
@@ -133,6 +133,10 @@ struct zd_mac {
 	/* Unlocked reading possible */
 	struct iw_statistics iw_stats;
 	struct housekeeping housekeeping;
+
+	struct tasklet_struct rx_tasklet;
+	struct sk_buff_head rx_queue;
+
 	unsigned int stats_count;
 	u8 qual_buffer[ZD_MAC_STATS_BUFFER_SIZE];
 	u8 rssi_buffer[ZD_MAC_STATS_BUFFER_SIZE];
@@ -174,7 +178,7 @@ int zd_mac_open(struct net_device *netde
 int zd_mac_stop(struct net_device *netdev);
 int zd_mac_set_mac_address(struct net_device *dev, void *p);
 
-int zd_mac_rx(struct zd_mac *mac, const u8 *buffer, unsigned int length);
+int zd_mac_rx_irq(struct zd_mac *mac, const u8 *buffer, unsigned int length);
 
 int zd_mac_set_regdomain(struct zd_mac *zd_mac, u8 regdomain);
 u8 zd_mac_get_regdomain(struct zd_mac *zd_mac);
--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_usb.c
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -599,13 +599,13 @@ static void handle_rx_packet(struct zd_u
 			n = l+k;
 			if (n > length)
 				return;
-			zd_mac_rx(mac, buffer+l, k);
+			zd_mac_rx_irq(mac, buffer+l, k);
 			if (i >= 2)
 				return;
 			l = (n+3) & ~3;
 		}
 	} else {
-		zd_mac_rx(mac, buffer, length);
+		zd_mac_rx_irq(mac, buffer, length);
 	}
 }
 

--
