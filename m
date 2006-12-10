Return-Path: <linux-kernel-owner+w=401wt.eu-S1762398AbWLJTZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762398AbWLJTZK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762465AbWLJTZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:25:10 -0500
Received: from deine-taler.de ([217.160.107.63]:60234 "EHLO
	p15091797.pureserver.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762423AbWLJTZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:25:08 -0500
Date: Sun, 10 Dec 2006 20:25:06 +0100
From: Ulrich Kunitz <kune@deine-taler.de>
To: Maxime Austruy <maxime@tralhalla.org>
Cc: zd1211-devs@lists.sourceforge.net,
       matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Daniel Drake <dsd@gentoo.org>
Subject: Re: 2.6.19 lot's of oops in  mmx_copy_page/ mmx_clear_page functions
Message-ID: <20061210192506.GF29871@p15091797.pureserver.info>
Mail-Followup-To: Maxime Austruy <maxime@tralhalla.org>,
	zd1211-devs@lists.sourceforge.net,
	matthieu castet <castet.matthieu@free.fr>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Daniel Drake <dsd@gentoo.org>
References: <457BF038.6080003@free.fr> <20061210190202.GA16992@tralhalla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210190202.GA16992@tralhalla.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-12-10 11:02 Maxime Austruy wrote:

> 
> Matthieu,
> 
> On Sun, Dec 10, 2006 at 12:32:08PM +0100, matthieu castet wrote:
> > Hi,
> > 
> > with 2.6.19 I got some random crash and I got kernel opps.
> > There all happens in  mmx_copy_page/ mmx_clear_page functions with 
> > differents process : Xorg, cat, mozilla, ...
> > 
> > 
> > What could be the cause of these crashes ?
> > What can I provide in order to debug this ?
> 
> FWIW, I've seen the same oops on my box. My instance was caused by a
> combination of:
>  . zd1211rw calling ieee80211_rx in irq context while it's supposed to
>    be called in softirq,
>  . crypto code only expecting to be called in softirq/user context but
>    not enforcing it.  Consequently, it ends up doing 
>       v = kmap_atomic(..., KM_USER0);
>    even when invoked by the zd1211rw driver in irq context, causing some
>    corruption.
> 
> Given that you have zd1211rw insmod'd, that could be it.  I have some
> hacks that work around this bug, but Ulrich has a patch ready that
> should fix this. Thanks,
> 
> Max

Here is the patch against vanilla 2.6.19.

For Linus' latest tree I have sent also patches on netdev.

Users of my out-of-kernel git tree, should look at the branch rx.

Uli

[PATCH] zd1211rw: Call ieee80211_rx in tasklet

The driver called ieee80211_rx in hardware irq context. This
caused a problem withe crypto libraries and was against the
documentation/intention of the ieee80211_rx function. This patch
fixes that.

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
---
 drivers/net/wireless/zd1211rw/zd_mac.c |   88 ++++++++++++++++++++++++--------
 drivers/net/wireless/zd1211rw/zd_mac.h |    6 ++
 drivers/net/wireless/zd1211rw/zd_usb.c |    4 +
 3 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/zd1211rw/zd_mac.c b/drivers/net/wireless/zd1211rw/zd_mac.c
index a7d29bd..f52dd3a 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
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
 
@@ -873,45 +885,75 @@ static int fill_rx_stats(struct ieee8021
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
+		dev_warn(zd_mac_dev(mac), "Packet with length %u to small.\n",
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
+	r = filter_rx(ieee, skb->data, skb->len, &stats);
+	if (r <= 0) {
+		if (r < 0)
+			dev_dbg_f(zd_mac_dev(mac), "Error in packet.\n");
+		goto free_skb;
+	}
 
-	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
-	if (!skb)
-		return -ENOMEM;
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
 	return 0;
 }
 
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.h b/drivers/net/wireless/zd1211rw/zd_mac.h
index b8ea3de..c1bea87 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.h
+++ b/drivers/net/wireless/zd1211rw/zd_mac.h
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
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index 3faaeb2..4a5f5d5 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
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
1.4.1

