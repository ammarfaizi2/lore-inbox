Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWAaAcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWAaAcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWAaAcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:32:50 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24493 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030245AbWAaAct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:32:49 -0500
Date: Tue, 31 Jan 2006 01:24:18 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, davem@redhat.com
Subject: [PATCH] 8139too: fix a TX timeout watchdog thread against NAPI softirq race
Message-ID: <20060131002418.GA917@electric-eye.fr.zoreil.com>
References: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au> <43D98915.6040004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D98915.6040004@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo's stealth lock validator detected that both thread acquire
dev->xmit_lock and tp->rx_lock in reverse order.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

471819cf98a56751ae0387400542fe2997855327
diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index adfba44..2beac55 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -586,6 +586,7 @@ struct rtl8139_private {
 	dma_addr_t tx_bufs_dma;
 	signed char phys[4];		/* MII device addresses. */
 	char twistie, twist_row, twist_col;	/* Twister tune state. */
+	unsigned int watchdog_fired : 1;
 	unsigned int default_port : 4;	/* Last dev->if_port value. */
 	unsigned int have_thread : 1;
 	spinlock_t lock;
@@ -638,6 +639,7 @@ static void rtl8139_set_rx_mode (struct 
 static void __set_rx_mode (struct net_device *dev);
 static void rtl8139_hw_start (struct net_device *dev);
 static void rtl8139_thread (void *_data);
+static void rtl8139_tx_timeout_task(void *_data);
 static struct ethtool_ops rtl8139_ethtool_ops;
 
 /* write MMIO register, with flush */
@@ -1598,13 +1600,14 @@ static void rtl8139_thread (void *_data)
 {
 	struct net_device *dev = _data;
 	struct rtl8139_private *tp = netdev_priv(dev);
-	unsigned long thr_delay;
+	unsigned long thr_delay = next_tick;
 
-	if (rtnl_shlock_nowait() == 0) {
+	if (tp->watchdog_fired) {
+		tp->watchdog_fired = 0;
+		rtl8139_tx_timeout_task(_data);
+	} else if (rtnl_shlock_nowait() == 0) {
 		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
 		rtnl_unlock ();
-
-		thr_delay = next_tick;
 	} else {
 		/* unlikely race.  mitigate with fast poll. */
 		thr_delay = HZ / 2;
@@ -1631,7 +1634,8 @@ static void rtl8139_stop_thread(struct r
 	if (tp->have_thread) {
 		cancel_rearming_delayed_work(&tp->thread);
 		tp->have_thread = 0;
-	}
+	} else
+		flush_scheduled_work();
 }
 
 static inline void rtl8139_tx_clear (struct rtl8139_private *tp)
@@ -1642,14 +1646,13 @@ static inline void rtl8139_tx_clear (str
 	/* XXX account for unsent Tx packets in tp->stats.tx_dropped */
 }
 
-
-static void rtl8139_tx_timeout (struct net_device *dev)
+static void rtl8139_tx_timeout_task (void *_data)
 {
+	struct net_device *dev = _data;
 	struct rtl8139_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->mmio_addr;
 	int i;
 	u8 tmp8;
-	unsigned long flags;
 
 	printk (KERN_DEBUG "%s: Transmit timeout, status %2.2x %4.4x %4.4x "
 		"media %2.2x.\n", dev->name, RTL_R8 (ChipCmd),
@@ -1670,23 +1673,34 @@ static void rtl8139_tx_timeout (struct n
 	if (tmp8 & CmdTxEnb)
 		RTL_W8 (ChipCmd, CmdRxEnb);
 
-	spin_lock(&tp->rx_lock);
+	spin_lock_bh(&tp->rx_lock);
 	/* Disable interrupts by clearing the interrupt mask. */
 	RTL_W16 (IntrMask, 0x0000);
 
 	/* Stop a shared interrupt from scavenging while we are. */
-	spin_lock_irqsave (&tp->lock, flags);
+	spin_lock_irq(&tp->lock);
 	rtl8139_tx_clear (tp);
-	spin_unlock_irqrestore (&tp->lock, flags);
+	spin_unlock_irq(&tp->lock);
 
 	/* ...and finally, reset everything */
 	if (netif_running(dev)) {
 		rtl8139_hw_start (dev);
 		netif_wake_queue (dev);
 	}
-	spin_unlock(&tp->rx_lock);
+	spin_unlock_bh(&tp->rx_lock);
 }
 
+static void rtl8139_tx_timeout (struct net_device *dev)
+{
+	struct rtl8139_private *tp = netdev_priv(dev);
+
+	if (!tp->have_thread) {
+		INIT_WORK(&tp->thread, rtl8139_tx_timeout_task, dev);
+		schedule_delayed_work(&tp->thread, next_tick);
+	} else
+		tp->watchdog_fired = 1;
+
+}
 
 static int rtl8139_start_xmit (struct sk_buff *skb, struct net_device *dev)
 {
-- 
1.1.3
