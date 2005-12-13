Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVLMFdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLMFdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVLMFdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:33:08 -0500
Received: from havoc.gtf.org ([69.61.125.42]:38377 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751292AbVLMFdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:33:06 -0500
Date: Tue, 13 Dec 2005 00:33:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] more net driver fixes
Message-ID: <20051213053305.GA26682@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/skge.c    |   10 ++++++----
 net/ieee80211/Kconfig |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

Olaf Hering:
      ieee80211_crypt_tkip depends on NET_RADIO

Stephen Hemminger:
      skge: get rid of warning on race

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 7164678..8b6e2a1 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2280,11 +2280,13 @@ static int skge_xmit_frame(struct sk_buf
  	}
 
 	if (unlikely(skge->tx_avail < skb_shinfo(skb)->nr_frags +1)) {
-		netif_stop_queue(dev);
-		spin_unlock_irqrestore(&skge->tx_lock, flags);
+		if (!netif_stopped(dev)) {
+			netif_stop_queue(dev);
 
-		printk(KERN_WARNING PFX "%s: ring full when queue awake!\n",
-		       dev->name);
+			printk(KERN_WARNING PFX "%s: ring full when queue awake!\n",
+			       dev->name);
+		}
+		spin_unlock_irqrestore(&skge->tx_lock, flags);
 		return NETDEV_TX_BUSY;
 	}
 
diff --git a/net/ieee80211/Kconfig b/net/ieee80211/Kconfig
index 91b16fb..d18ccba 100644
--- a/net/ieee80211/Kconfig
+++ b/net/ieee80211/Kconfig
@@ -55,7 +55,7 @@ config IEEE80211_CRYPT_CCMP
 
 config IEEE80211_CRYPT_TKIP
 	tristate "IEEE 802.11i TKIP encryption"
-	depends on IEEE80211
+	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	---help---
