Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUKUW0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUKUW0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUKUW0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:26:47 -0500
Received: from navi.cs.colorado.edu ([128.138.207.240]:5007 "EHLO navi.cx")
	by vger.kernel.org with ESMTP id S261822AbUKUW0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:26:44 -0500
Date: Sun, 21 Nov 2004 15:37:49 -0700
From: Micah Dowty <micah@navi.cx>
To: sailer@ife.ee.ethz.ch
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Improved net device stats for hdlcdrv
Message-ID: <20041121223749.GA10208@navi.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tiny patch for hdlcdrv (a ham radio driver) that adds accounting
for transmitted/received bytes and receiver CRC errors. It's useful to have
these show up in ifconfig, and I need these stats in other kernel modules
cooperating with hdlcdrv.

If you apply this, please also apply my earlier patch that fixes the transmit
CRC problem- without that, hdlcdrv is completely useless.

Signed-off-by: Micah Dowty <micah@navi.cx>

--- linux-2.6.10-rc2-bk6/drivers/net/hamradio/hdlcdrv.c	2004-11-21 14:59:55.969119632 -0700
+++ linux-hdlcdrv-stats/drivers/net/hamradio/hdlcdrv.c	2004-11-21 15:15:05.955780632 -0700
@@ -166,8 +166,10 @@ static void hdlc_rx_flag(struct net_devi
 
 	if (s->hdlcrx.len < 4) 
 		return;
-	if (!check_crc_ccitt(s->hdlcrx.buffer, s->hdlcrx.len)) 
+	if (!check_crc_ccitt(s->hdlcrx.buffer, s->hdlcrx.len)) {
+		s->stats.rx_errors++;
 		return;
+	}
 	pkt_len = s->hdlcrx.len - 2 + 1; /* KISS kludge */
 	if (!(skb = dev_alloc_skb(pkt_len))) {
 		printk("%s: memory squeeze, dropping packet\n", dev->name);
@@ -183,6 +185,7 @@ static void hdlc_rx_flag(struct net_devi
 	netif_rx(skb);
 	dev->last_rx = jiffies;
 	s->stats.rx_packets++;
+	s->stats.rx_bytes += s->hdlcrx.len;
 }
 
 void hdlcdrv_receiver(struct net_device *dev, struct hdlcdrv_state *s)
@@ -345,6 +348,7 @@ void hdlcdrv_transmitter(struct net_devi
 			s->hdlctx.tx_state = 2;
 			s->hdlctx.bitstream = 0;
 			s->stats.tx_packets++;
+			s->stats.tx_bytes += s->hdlctx.len;
 			break;
 		case 2:
 			if (!s->hdlctx.len) {

-- 
Only you can prevent creeping featurism!
