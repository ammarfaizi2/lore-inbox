Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVKEDr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVKEDr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 22:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKEDr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 22:47:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:55996 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751188AbVKEDrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 22:47:25 -0500
Message-ID: <436C2B47.3030505@pobox.com>
Date: Fri, 04 Nov 2005 22:47:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill 8139too kernel thread (sorta)
References: <20051031130255.GA26626@havoc.gtf.org> <E1EWgcG-0001dZ-00@gondolin.me.apana.org.au> <20051031211143.GA6409@gondor.apana.org.au>
In-Reply-To: <20051031211143.GA6409@gondor.apana.org.au>
Content-Type: multipart/mixed;
 boundary="------------060403050309090505040809"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403050309090505040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a better version, that uses cancel_rearming_...

	Jeff




--------------060403050309090505040809
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index 30bee11..120baaa 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -586,16 +586,16 @@ struct rtl8139_private {
 	dma_addr_t tx_bufs_dma;
 	signed char phys[4];		/* MII device addresses. */
 	char twistie, twist_row, twist_col;	/* Twister tune state. */
-	unsigned int default_port:4;	/* Last dev->if_port value. */
+	unsigned int default_port : 4;	/* Last dev->if_port value. */
+	unsigned int have_thread : 1;
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
@@ -1594,55 +1594,37 @@ static inline void rtl8139_thread_iter (
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
-
-		if (signal_pending (current)) {
-			flush_signals(current);
-		}
-
-		if (tp->time_to_die)
-			break;
 
-		if (rtnl_lock_interruptible ())
-			break;
+	if (rtnl_shlock_nowait() == 0) {
 		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
 		rtnl_unlock ();
 	}
 
-	complete_and_exit (&tp->thr_exited, 0);
+	schedule_delayed_work(&tp->thread, next_tick);
 }
 
-static void rtl8139_start_thread(struct net_device *dev)
+static void rtl8139_start_thread(struct rtl8139_private *tp)
 {
-	struct rtl8139_private *tp = netdev_priv(dev);
-
-	tp->thr_pid = -1;
 	tp->twistie = 0;
-	tp->time_to_die = 0;
 	if (tp->chipset == CH_8139_K)
 		tp->twistie = 1;
 	else if (tp->drv_flags & HAS_LNK_CHNG)
 		return;
 
-	tp->thr_pid = kernel_thread(rtl8139_thread, dev, CLONE_FS|CLONE_FILES);
-	if (tp->thr_pid < 0) {
-		printk (KERN_WARNING "%s: unable to start kernel thread\n",
-			dev->name);
+	tp->have_thread = 1;
+
+	schedule_delayed_work(&tp->thread, next_tick);
+}
+
+static void rtl8139_stop_thread(struct rtl8139_private *tp)
+{
+	if (tp->have_thread) {
+		cancel_rearming_delayed_work(&tp->thread);
+		tp->have_thread = 0;
 	}
 }
 
@@ -2224,22 +2206,12 @@ static int rtl8139_close (struct net_dev
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

--------------060403050309090505040809--
