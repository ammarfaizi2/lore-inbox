Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVJaNDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVJaNDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 08:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVJaNDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 08:03:00 -0500
Received: from havoc.gtf.org ([69.61.125.42]:51101 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964772AbVJaNC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 08:02:59 -0500
Date: Mon, 31 Oct 2005 08:02:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill 8139too kernel thread (sorta)
Message-ID: <20051031130255.GA26626@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just checked this into netdev-2.6.git, and will be appearing in -mm
soon for testing and review.


commit a15e0384dd22ee08f56d62761ce9d770488f6f4e
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Mon Oct 31 07:59:37 2005 -0500

    [netdrvr 8139too] replace hand-crafted kernel thread with workqueue
    
    Gone are the days when 8139too was a shining example of how to use
    kernel threads.  Delayed workqueues are easier, and map precisely to
    our task:  running code from a kernel thread, after a periodic sleep.


 drivers/net/8139too.c |   87 ++++++++++++++++++--------------------------------
 1 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index 30bee11..9de58e2 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -590,12 +590,12 @@ struct rtl8139_private {
 	spinlock_t lock;
 	spinlock_t rx_lock;
 	chip_t chipset;
-	pid_t thr_pid;
-	wait_queue_head_t thr_wait;
-	struct completion thr_exited;
 	u32 rx_config;
 	struct rtl_extra_stats xstats;
-	int time_to_die;
+
+	struct work_struct thread;
+	long time_to_die;	/* -1 no thr, 0 thr active, 1 thr cancel */
+
 	struct mii_if_info mii;
 	unsigned int regs_len;
 	unsigned long fifo_copy_timeout;
@@ -620,7 +620,7 @@ static int rtl8139_open (struct net_devi
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
 			int val);
-static void rtl8139_start_thread(struct net_device *dev);
+static void rtl8139_start_thread(struct rtl8139_private *tp);
 static void rtl8139_tx_timeout (struct net_device *dev);
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
@@ -637,6 +637,7 @@ static struct net_device_stats *rtl8139_
 static void rtl8139_set_rx_mode (struct net_device *dev);
 static void __set_rx_mode (struct net_device *dev);
 static void rtl8139_hw_start (struct net_device *dev);
+static void rtl8139_thread (void *_data);
 static struct ethtool_ops rtl8139_ethtool_ops;
 
 /* write MMIO register, with flush */
@@ -1007,8 +1008,7 @@ static int __devinit rtl8139_init_one (s
 		(debug < 0 ? RTL8139_DEF_MSG_ENABLE : ((1 << debug) - 1));
 	spin_lock_init (&tp->lock);
 	spin_lock_init (&tp->rx_lock);
-	init_waitqueue_head (&tp->thr_wait);
-	init_completion (&tp->thr_exited);
+	INIT_WORK(&tp->thread, rtl8139_thread, dev);
 	tp->mii.dev = dev;
 	tp->mii.mdio_read = mdio_read;
 	tp->mii.mdio_write = mdio_write;
@@ -1345,7 +1345,7 @@ static int rtl8139_open (struct net_devi
 			dev->irq, RTL_R8 (MediaStatus),
 			tp->mii.full_duplex ? "full" : "half");
 
-	rtl8139_start_thread(dev);
+	rtl8139_start_thread(tp);
 
 	return 0;
 }
@@ -1594,56 +1594,45 @@ static inline void rtl8139_thread_iter (
 		 RTL_R8 (Config1));
 }
 
-static int rtl8139_thread (void *data)
+static void rtl8139_thread (void *_data)
 {
-	struct net_device *dev = data;
+	struct net_device *dev = _data;
 	struct rtl8139_private *tp = netdev_priv(dev);
-	unsigned long timeout;
-
-	daemonize("%s", dev->name);
-	allow_signal(SIGTERM);
-
-	while (1) {
-		timeout = next_tick;
-		do {
-			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
-			/* make swsusp happy with our thread */
-			try_to_freeze();
-		} while (!signal_pending (current) && (timeout > 0));
 
-		if (signal_pending (current)) {
-			flush_signals(current);
-		}
-
-		if (tp->time_to_die)
-			break;
-
-		if (rtnl_lock_interruptible ())
-			break;
+	if ((tp->time_to_die == 0) &&
+	    (rtnl_lock_interruptible() == 0)) {
 		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
 		rtnl_unlock ();
 	}
 
-	complete_and_exit (&tp->thr_exited, 0);
+	if (tp->time_to_die == 0)
+		schedule_delayed_work(&tp->thread, next_tick);
 }
 
-static void rtl8139_start_thread(struct net_device *dev)
+static void rtl8139_start_thread(struct rtl8139_private *tp)
 {
-	struct rtl8139_private *tp = netdev_priv(dev);
-
-	tp->thr_pid = -1;
 	tp->twistie = 0;
-	tp->time_to_die = 0;
+	tp->time_to_die = -1;
 	if (tp->chipset == CH_8139_K)
 		tp->twistie = 1;
 	else if (tp->drv_flags & HAS_LNK_CHNG)
 		return;
 
-	tp->thr_pid = kernel_thread(rtl8139_thread, dev, CLONE_FS|CLONE_FILES);
-	if (tp->thr_pid < 0) {
-		printk (KERN_WARNING "%s: unable to start kernel thread\n",
-			dev->name);
-	}
+	tp->time_to_die = 0;
+
+	schedule_delayed_work(&tp->thread, next_tick);
+}
+
+static void rtl8139_stop_thread(struct rtl8139_private *tp)
+{
+	if (tp->time_to_die < 0)
+		return;
+
+	tp->time_to_die = 1;
+	wmb();
+
+	if (cancel_delayed_work(&tp->thread) == 0)
+		flush_scheduled_work();
 }
 
 static inline void rtl8139_tx_clear (struct rtl8139_private *tp)
@@ -2224,22 +2213,12 @@ static int rtl8139_close (struct net_dev
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->mmio_addr;
-	int ret = 0;
 	unsigned long flags;
 
 	netif_stop_queue (dev);
 
-	if (tp->thr_pid >= 0) {
-		tp->time_to_die = 1;
-		wmb();
-		ret = kill_proc (tp->thr_pid, SIGTERM, 1);
-		if (ret) {
-			printk (KERN_ERR "%s: unable to signal thread\n", dev->name);
-			return ret;
-		}
-		wait_for_completion (&tp->thr_exited);
-	}
-	
+	rtl8139_stop_thread(tp);
+
 	if (netif_msg_ifdown(tp))
 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was 0x%4.4x.\n",
 			dev->name, RTL_R16 (IntrStatus));
