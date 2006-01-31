Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWAaSzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWAaSzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAaSzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:55:45 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:22244 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751344AbWAaSzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:55:44 -0500
Date: Tue, 31 Jan 2006 19:49:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, davem@redhat.com
Subject: Re: [PATCH] 8139too: fix a TX timeout watchdog thread against NAPI softirq race
Message-ID: <20060131184957.GA22660@elte.hu>
References: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au> <43D98915.6040004@pobox.com> <20060131002418.GA917@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20060131002418.GA917@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Francois Romieu <romieu@fr.zoreil.com> wrote:

> Ingo's stealth lock validator detected that both thread acquire
> dev->xmit_lock and tp->rx_lock in reverse order.
> 
> Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

i've ported this to -mm4 (see the attached patch), but i'm also getting 
a new deadlock message. Seems to be a separate issue, not introduced by 
your patch - but still needs fixing i guess.

	Ingo

=========================================
[ BUG: irq lock inversion bug detected! ]
-----------------------------------------
rcu_torture_rea/263 just changed the state of lock:
 (&mc->mca_lock){-+}, at: [<c04b4c0f>] mld_ifc_timer_expire+0x17f/0x2c0
but this lock took another, softirq-unsafe lock in the past:
 (&tp->lock){--}, at: [<c03406d2>] rtl8139_set_rx_mode+0x22/0x180

and interrupts could create an inverse lock dependency between them,
which could lead to deadlocks!

other info that might help us debug this:
no locks held by rcu_torture_rea/263.
-> (&tp->lock){--} {
   used       at: [<c03413da>] rtl8139_interrupt+0x2a/0x5e0
   softirq-on at: [<c044b5fa>] dev_mc_upload+0x2a/0x40
   hardirq-on at: [<c0160a28>] kmem_cache_alloc+0x98/0xd0
 }
 ... key      at: [<c033fffb>] rtl8139_init_one+0x2ab/0x960
 ... acquired at: [<c03406d2>] rtl8139_set_rx_mode+0x22/0x180


the first lock's dependencies:
-> (&mc->mca_lock){-+} {
   used       at: [<c04b3440>] igmp6_group_added+0x20/0x170
   in-softirq at: [<c04b4c0f>] mld_ifc_timer_expire+0x17f/0x2c0
   hardirq-on at: [<c04dcaa5>] _spin_unlock_irqrestore+0x25/0x30
 }
 ... key      at: [<c04b3edd>] ipv6_dev_mc_inc+0x17d/0x3c0
 ... acquired at: [<c04b4c0f>] mld_ifc_timer_expire+0x17f/0x2c0

  -> (&dev->xmit_lock){-.} {
     used       at: [<c044b5ec>] dev_mc_upload+0x1c/0x40
     hardirq-on at: [<c04dba6a>] __mutex_lock_slowpath+0x27a/0x4e0
   }
   ... key      at: [<c0449fdd>] register_netdevice+0x5d/0x3a0
   ... acquired at: [<c044b724>] dev_mc_add+0x34/0x140

    -> (&tp->lock){--} {
       used       at: [<c03413da>] rtl8139_interrupt+0x2a/0x5e0
       softirq-on at: [<c044b5fa>] dev_mc_upload+0x2a/0x40
       hardirq-on at: [<c0160a28>] kmem_cache_alloc+0x98/0xd0
     }
     ... key      at: [<c033fffb>] rtl8139_init_one+0x2ab/0x960
     ... acquired at: [<c03406d2>] rtl8139_set_rx_mode+0x22/0x180

    -> (&base->t_base.lock){++} {
       used       at: [<c0126df3>] lock_timer_base+0x23/0x50
       in-hardirq at: [<c0126df3>] lock_timer_base+0x23/0x50
       in-softirq at: [<c01277f2>] run_timer_softirq+0x42/0x1f0
     }
     ... key      at: [<c1fd2ef0>] 0xc1fd2ef0
     ... acquired at: [<c0126df3>] lock_timer_base+0x23/0x50


the second lock's dependencies:
-> (&tp->lock){--} {
   used       at: [<c03413da>] rtl8139_interrupt+0x2a/0x5e0
   softirq-on at: [<c044b5fa>] dev_mc_upload+0x2a/0x40
   hardirq-on at: [<c0160a28>] kmem_cache_alloc+0x98/0xd0
 }
 ... key      at: [<c033fffb>] rtl8139_init_one+0x2ab/0x960
 ... acquired at: [<c03406d2>] rtl8139_set_rx_mode+0x22/0x180


stack backtrace:
 [<c010437d>] show_trace+0xd/0x10
 [<c0104397>] dump_stack+0x17/0x20
 [<c0137db2>] print_irq_inversion_bug+0x142/0x1b0
 [<c0137f91>] check_usage_forwards+0x41/0x50
 [<c0139520>] mark_lock+0x180/0x350
 [<c0139b83>] debug_lock_chain+0x493/0x1090
 [<c013a7bd>] debug_lock_chain_spin+0x3d/0x60
 [<c026777d>] _raw_spin_lock+0x2d/0x90
 [<c04dc942>] _spin_lock_bh+0x12/0x20
 [<c04b4c0f>] mld_ifc_timer_expire+0x17f/0x2c0
 [<c01278a5>] run_timer_softirq+0xf5/0x1f0
 [<c01233a7>] __do_softirq+0x97/0x130
 [<c01054d9>] do_softirq+0x69/0x100
 =======================
 [<c0123065>] irq_exit+0x45/0x50
 [<c010f534>] smp_apic_timer_interrupt+0x54/0x60
 [<c010395b>] apic_timer_interrupt+0x27/0x2c
 [<c0265f0c>] __delay+0xc/0x10
 [<c0265f71>] __udelay+0x31/0x40
 [<c0143333>] rcu_torture_reader+0x83/0x140
 [<c0131dea>] kthread+0xca/0xd0
 [<c0100ef5>] kernel_thread_helper+0x5/0x10
eth0: no IPv6 routers present


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8139too-tx-deadlock-fix.patch"

Ingo's stealth lock validator detected that both thread acquire
dev->xmit_lock and tp->rx_lock in reverse order.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/net/8139too.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

Index: linux/drivers/net/8139too.c
===================================================================
--- linux.orig/drivers/net/8139too.c
+++ linux/drivers/net/8139too.c
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
@@ -1598,9 +1600,12 @@ static void rtl8139_thread (void *_data)
 {
 	struct net_device *dev = _data;
 	struct rtl8139_private *tp = netdev_priv(dev);
-	unsigned long thr_delay;
+	unsigned long thr_delay = next_tick;
 
-	if (rtnl_shlock_nowait() != 0) {
+	if (tp->watchdog_fired) {
+		tp->watchdog_fired = 0;
+		rtl8139_tx_timeout_task(_data);
+	} else if (rtnl_shlock_nowait() != 0) {
 		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
 		rtnl_unlock ();
 
@@ -1631,7 +1636,8 @@ static void rtl8139_stop_thread(struct r
 	if (tp->have_thread) {
 		cancel_rearming_delayed_work(&tp->thread);
 		tp->have_thread = 0;
-	}
+	} else
+		flush_scheduled_work();
 }
 
 static inline void rtl8139_tx_clear (struct rtl8139_private *tp)
@@ -1642,14 +1648,13 @@ static inline void rtl8139_tx_clear (str
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
@@ -1670,23 +1675,34 @@ static void rtl8139_tx_timeout (struct n
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

--k1lZvvs/B4yU6o8G--
