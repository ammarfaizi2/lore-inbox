Return-Path: <linux-kernel-owner+w=401wt.eu-S1751763AbWLMXqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWLMXqs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWLMXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:46:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58295 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbWLMXqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:46:45 -0500
Date: Wed, 13 Dec 2006 15:46:35 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Eugene Surovegin <ebs@ebshome.net>,
       linux-kernel@vger.kernel.org
Subject: [RFC] split NAPI from network device.
Message-ID: <20061213154635.1f284bf6@dxpl.pdx.osdl.net>
In-Reply-To: <1166042552.11914.188.camel@localhost.localdomain>
References: <1165901258.11914.32.camel@localhost.localdomain>
	<20061213113537.6baf410f@dxpl.pdx.osdl.net>
	<1166042552.11914.188.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split off NAPI part from network device, this patch is build tested
only! It breaks kernel API for network devices, and only three examples
are fixed (skge, sky2, and tg3).

1. Decomposition allows different NAPI <-> network device
   Some hardware has N devices for one IRQ, others like MSI-X
   want multiple receive's for one device.

2. Cleanup locking with netpoll

3. Change poll callback arguements and semantics

4. Make softnet_data static (only in dev.c)

Old:
	dev->poll(dev, &budget)
	returns 1 or 0
	requeu if returns 1

New:
	napi->poll(napi, quota)
	returns # of elements processed
	requeue based on status

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 drivers/net/skge.c        |   32 +++----
 drivers/net/sky2.c        |   40 ++------
 drivers/net/sky2.h        |    1 +
 drivers/net/tg3.c         |   28 ++----
 include/linux/netdevice.h |  167 +++++++++++++++++----------------
 include/linux/netpoll.h   |   50 ----------
 net/core/dev.c            |  233 ++++++++++++++++++++++++++++++---------------
 net/core/net-sysfs.c      |   12 ++-
 net/core/netpoll.c        |   61 ++++---------
 net/core/rtnetlink.c      |    4 +-
 10 files changed, 304 insertions(+), 324 deletions(-)

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index b60f045..65b9b65 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2914,13 +2914,13 @@ static void skge_tx_done(struct net_device *dev)
 	netif_tx_unlock(dev);
 }
 
-static int skge_poll(struct net_device *dev, int *budget)
+static int skge_poll(struct napi_struct *napi, int to_do)
 {
+	struct net_device *dev = container_of(napi, struct net_device, napi);
 	struct skge_port *skge = netdev_priv(dev);
 	struct skge_hw *hw = skge->hw;
 	struct skge_ring *ring = &skge->rx_ring;
 	struct skge_element *e;
-	int to_do = min(dev->quota, *budget);
 	int work_done = 0;
 
 	skge_tx_done(dev);
@@ -2950,21 +2950,17 @@ static int skge_poll(struct net_device *dev, int *budget)
 	/* restart receiver */
 	wmb();
 	skge_write8(hw, Q_ADDR(rxqaddr[skge->port], Q_CSR), CSR_START);
+	
+	if (work_done < to_do) {
+		spin_lock_irq(&hw->hw_lock);
+		__netif_rx_complete(dev);
+		hw->intr_mask |= irqmask[skge->port];
+		skge_write32(hw, B0_IMSK, hw->intr_mask);
+		skge_read32(hw, B0_IMSK);
+		spin_unlock_irq(&hw->hw_lock);
+	}
 
-	*budget -= work_done;
-	dev->quota -= work_done;
-
-	if (work_done >=  to_do)
-		return 1; /* not done */
-
-	spin_lock_irq(&hw->hw_lock);
-	__netif_rx_complete(dev);
-	hw->intr_mask |= irqmask[skge->port];
-  	skge_write32(hw, B0_IMSK, hw->intr_mask);
-	skge_read32(hw, B0_IMSK);
-	spin_unlock_irq(&hw->hw_lock);
-
-	return 0;
+	return work_done;
 }
 
 /* Parity errors seem to happen when Genesis is connected to a switch
@@ -3428,8 +3424,8 @@ static struct net_device *skge_devinit(struct skge_hw *hw, int port,
 	SET_ETHTOOL_OPS(dev, &skge_ethtool_ops);
 	dev->tx_timeout = skge_tx_timeout;
 	dev->watchdog_timeo = TX_WATCHDOG;
-	dev->poll = skge_poll;
-	dev->weight = NAPI_WEIGHT;
+	dev->napi.poll = skge_poll;
+	dev->napi.weight = NAPI_WEIGHT;
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller = skge_netpoll;
 #endif
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index fb1d2c3..3fd1a78 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -2305,19 +2305,16 @@ static inline void sky2_idle_start(struct sky2_hw *hw)
 static void sky2_idle(unsigned long arg)
 {
 	struct sky2_hw *hw = (struct sky2_hw *) arg;
-	struct net_device *dev = hw->dev[0];
-
-	if (__netif_rx_schedule_prep(dev))
-		__netif_rx_schedule(dev);
+	
+	napi_schedule(&hw->napi);
 
 	mod_timer(&hw->idle_timer, jiffies + msecs_to_jiffies(idle_timeout));
 }
 
 
-static int sky2_poll(struct net_device *dev0, int *budget)
+static int sky2_poll(struct napi_struct *napi, int work_limit)
 {
-	struct sky2_hw *hw = ((struct sky2_port *) netdev_priv(dev0))->hw;
-	int work_limit = min(dev0->quota, *budget);
+	struct sky2_hw *hw = container_of(napi, struct sky2_hw, napi);
 	int work_done = 0;
 	u32 status = sky2_read32(hw, B0_Y2_SP_EISR);
 
@@ -2350,21 +2347,16 @@ static int sky2_poll(struct net_device *dev0, int *budget)
 
 	work_done = sky2_status_intr(hw, work_limit);
 	if (work_done < work_limit) {
-		netif_rx_complete(dev0);
+		napi_complete(napi);
 
 		sky2_read32(hw, B0_Y2_SP_LISR);
-		return 0;
-	} else {
-		*budget -= work_done;
-		dev0->quota -= work_done;
-		return 1;
 	}
+	return work_done;
 }
 
 static irqreturn_t sky2_intr(int irq, void *dev_id)
 {
 	struct sky2_hw *hw = dev_id;
-	struct net_device *dev0 = hw->dev[0];
 	u32 status;
 
 	/* Reading this mask interrupts as side effect */
@@ -2373,8 +2365,8 @@ static irqreturn_t sky2_intr(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	prefetch(&hw->st_le[hw->st_idx]);
-	if (likely(__netif_rx_schedule_prep(dev0)))
-		__netif_rx_schedule(dev0);
+	
+	napi_schedule(&hw->napi);
 
 	return IRQ_HANDLED;
 }
@@ -2383,10 +2375,8 @@ static irqreturn_t sky2_intr(int irq, void *dev_id)
 static void sky2_netpoll(struct net_device *dev)
 {
 	struct sky2_port *sky2 = netdev_priv(dev);
-	struct net_device *dev0 = sky2->hw->dev[0];
 
-	if (netif_running(dev) && __netif_rx_schedule_prep(dev0))
-		__netif_rx_schedule(dev0);
+	napi_schedule(&sky2->hw->napi);
 }
 #endif
 
@@ -3237,16 +3227,6 @@ static __devinit struct net_device *sky2_init_netdev(struct sky2_hw *hw,
 	SET_ETHTOOL_OPS(dev, &sky2_ethtool_ops);
 	dev->tx_timeout = sky2_tx_timeout;
 	dev->watchdog_timeo = TX_WATCHDOG;
-	if (port == 0)
-		dev->poll = sky2_poll;
-	dev->weight = NAPI_WEIGHT;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	/* Network console (only works on port 0)
-	 * because netpoll makes assumptions about NAPI
-	 */
-	if (port == 0)
-		dev->poll_controller = sky2_netpoll;
-#endif
 
 	sky2 = netdev_priv(dev);
 	sky2->netdev = dev;
@@ -3423,6 +3403,8 @@ static int __devinit sky2_probe(struct pci_dev *pdev,
 	}
 
 	hw->pdev = pdev;
+	hw->napi.poll = sky2_poll;
+	hw->napi.weight = NAPI_WEIGHT;
 
 	hw->regs = ioremap_nocache(pci_resource_start(pdev, 0), 0x4000);
 	if (!hw->regs) {
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 6ed1d47..0fa2be6 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1885,6 +1885,7 @@ struct sky2_port {
 struct sky2_hw {
 	void __iomem  	     *regs;
 	struct pci_dev	     *pdev;
+	struct napi_struct   napi;
 	struct net_device    *dev[2];
 
 	int		     pm_cap;
diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index 571320a..a2358d1 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -3393,11 +3393,12 @@ next_pkt_nopost:
 	return received;
 }
 
-static int tg3_poll(struct net_device *netdev, int *budget)
+static int tg3_poll(struct napi_struct *napi, int budget)
 {
+	struct net_device *netdev = container_of(napi, struct net_device, napi);
 	struct tg3 *tp = netdev_priv(netdev);
 	struct tg3_hw_status *sblk = tp->hw_status;
-	int done;
+	int work_done = 0;
 
 	/* handle link change and other phy events */
 	if (!(tp->tg3_flags &
@@ -3426,18 +3427,8 @@ static int tg3_poll(struct net_device *netdev, int *budget)
 	 * All RX "locking" is done by ensuring outside
 	 * code synchronizes with dev->poll()
 	 */
-	if (sblk->idx[0].rx_producer != tp->rx_rcb_ptr) {
-		int orig_budget = *budget;
-		int work_done;
-
-		if (orig_budget > netdev->quota)
-			orig_budget = netdev->quota;
-
-		work_done = tg3_rx(tp, orig_budget);
-
-		*budget -= work_done;
-		netdev->quota -= work_done;
-	}
+	if (sblk->idx[0].rx_producer != tp->rx_rcb_ptr)
+		work_done = tg3_rx(tp, budget);
 
 	if (tp->tg3_flags & TG3_FLAG_TAGGED_STATUS) {
 		tp->last_tag = sblk->status_tag;
@@ -3446,13 +3437,12 @@ static int tg3_poll(struct net_device *netdev, int *budget)
 		sblk->status &= ~SD_STATUS_UPDATED;
 
 	/* if no more work, tell net stack and NIC we're done */
-	done = !tg3_has_work(tp);
-	if (done) {
+	if (!tg3_has_work(tp)) {
 		netif_rx_complete(netdev);
 		tg3_restart_ints(tp);
 	}
 
-	return (done ? 0 : 1);
+	return work_done;
 }
 
 static void tg3_irq_quiesce(struct tg3 *tp)
@@ -11777,9 +11767,9 @@ static int __devinit tg3_init_one(struct pci_dev *pdev,
 	dev->set_mac_address = tg3_set_mac_addr;
 	dev->do_ioctl = tg3_ioctl;
 	dev->tx_timeout = tg3_tx_timeout;
-	dev->poll = tg3_poll;
+	dev->napi.weight = 64;
+	dev->napi.poll = tg3_poll;
 	dev->ethtool_ops = &tg3_ethtool_ops;
-	dev->weight = 64;
 	dev->watchdog_timeo = TG3_TX_TIMEOUT;
 	dev->change_mtu = tg3_change_mtu;
 	dev->irq = pdev->irq;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c57088f..7844369 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -31,6 +31,7 @@
 
 #ifdef __KERNEL__
 #include <linux/timer.h>
+#include <linux/delay.h>
 #include <asm/atomic.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>
@@ -235,7 +236,6 @@ enum netdev_state_t
 	__LINK_STATE_PRESENT,
 	__LINK_STATE_SCHED,
 	__LINK_STATE_NOCARRIER,
-	__LINK_STATE_RX_SCHED,
 	__LINK_STATE_LINKWATCH_PENDING,
 	__LINK_STATE_DORMANT,
 	__LINK_STATE_QDISC_RUNNING,
@@ -255,6 +255,73 @@ struct netdev_boot_setup {
 extern int __init netdev_boot_setup(char *str);
 
 /*
+ * Structure for NAPI scheduling similar to tasklet but with weighting
+ */
+struct napi_struct {
+	struct list_head	poll_list;
+	unsigned long		state;
+	int			weight;
+	int			quota;
+	int			(*poll)(struct napi_struct *, int);
+};
+
+enum
+{
+	NAPI_STATE_SCHED,	/* Poll is scheduled */
+	NAPI_STATE_RUN,		/* Poll function is running (only NETPOLL)*/
+};
+
+/* If using netpoll it may "steal" entries that are already scheduled */
+#ifdef CONFIG_NETPOLL
+static inline int napi_trylock(struct napi_struct *n)
+{
+	return !test_and_set_bit(NAPI_STATE_RUN, &n->state);
+}
+
+static inline void napi_unlock(struct napi_struct *n)
+{
+	smp_mb__before_clear_bit();
+	clear_bit(NAPI_STATE_RUN, &n->state);
+}
+#else
+#define napi_trylock(t)	1
+#define napi_unlock(t) do { } while (0)
+#endif
+
+extern void FASTCALL(__napi_schedule(struct napi_struct *n));
+
+static inline int napi_schedule_prep(struct napi_struct *n)
+{
+	return !test_and_set_bit(NAPI_STATE_SCHED, &n->state);
+}
+
+static inline void napi_schedule(struct napi_struct *n)
+{
+	if (napi_schedule_prep(n))
+		__napi_schedule(n);
+}
+
+static inline void napi_complete(struct napi_struct *n)
+{
+	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
+	smp_mb__before_clear_bit();
+	clear_bit(NAPI_STATE_SCHED, &n->state);
+}
+
+static inline void napi_disable(struct napi_struct *n)
+{
+	while (test_and_set_bit(NAPI_STATE_SCHED, &n->state))
+		msleep_interruptible(1);
+}
+
+static inline void napi_enable(struct napi_struct *n)
+{
+	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
+	smp_mb__before_clear_bit();
+	clear_bit(NAPI_STATE_SCHED, &n->state);
+}
+
+/*
  *	The DEVICE structure.
  *	Actually, this whole structure is a big mistake.  It mixes I/O
  *	data with strictly "high-level" data, and it has to know about
@@ -395,12 +462,7 @@ struct net_device
 /*
  * Cache line mostly used on receive path (including eth_type_trans())
  */
-	struct list_head	poll_list ____cacheline_aligned_in_smp;
-					/* Link to poll list	*/
-
-	int			(*poll) (struct net_device *dev, int *quota);
-	int			quota;
-	int			weight;
+	struct napi_struct	napi ____cacheline_aligned_in_smp;
 	unsigned long		last_rx;	/* Time of last Rx	*/
 	/* Interface address info used in eth_type_trans() */
 	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address, (before bcast 
@@ -601,26 +663,6 @@ static inline int unregister_gifconf(unsigned int family)
 	return register_gifconf(family, NULL);
 }
 
-/*
- * Incoming packets are placed on per-cpu queues so that
- * no locking is needed.
- */
-
-struct softnet_data
-{
-	struct net_device	*output_queue;
-	struct sk_buff_head	input_pkt_queue;
-	struct list_head	poll_list;
-	struct sk_buff		*completion_queue;
-
-	struct net_device	backlog_dev;	/* Sorry. 8) */
-#ifdef CONFIG_NET_DMA
-	struct dma_chan		*net_dma;
-#endif
-};
-
-DECLARE_PER_CPU(struct softnet_data,softnet_data);
-
 #define HAVE_NETIF_QUEUE
 
 extern void __netif_schedule(struct net_device *dev);
@@ -669,20 +711,7 @@ static inline int netif_running(const struct net_device *dev)
 /* Use this variant when it is known for sure that it
  * is executing from interrupt context.
  */
-static inline void dev_kfree_skb_irq(struct sk_buff *skb)
-{
-	if (atomic_dec_and_test(&skb->users)) {
-		struct softnet_data *sd;
-		unsigned long flags;
-
-		local_irq_save(flags);
-		sd = &__get_cpu_var(softnet_data);
-		skb->next = sd->completion_queue;
-		sd->completion_queue = skb;
-		raise_softirq_irqoff(NET_TX_SOFTIRQ);
-		local_irq_restore(flags);
-	}
-}
+extern void dev_kfree_skb_irq(struct sk_buff *skb);
 
 /* Use this variant in places where it could be invoked
  * either from interrupt or non-interrupt context.
@@ -828,10 +857,11 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	return (1 << debug_value) - 1;
 }
 
+
 /* Test if receive needs to be scheduled */
 static inline int __netif_rx_schedule_prep(struct net_device *dev)
 {
-	return !test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state);
+	return napi_schedule_prep(&dev->napi);
 }
 
 /* Test if receive needs to be scheduled but only if up */
@@ -843,8 +873,11 @@ static inline int netif_rx_schedule_prep(struct net_device *dev)
 /* Add interface to tail of rx poll list. This assumes that _prep has
  * already been called and returned 1.
  */
-
-extern void __netif_rx_schedule(struct net_device *dev);
+static inline void __netif_rx_schedule(struct net_device *dev)
+{
+	dev_hold(dev);
+	__napi_schedule(&dev->napi);
+}
 
 /* Try to reschedule poll. Called by irq handler. */
 
@@ -854,63 +887,35 @@ static inline void netif_rx_schedule(struct net_device *dev)
 		__netif_rx_schedule(dev);
 }
 
-/* Try to reschedule poll. Called by dev->poll() after netif_rx_complete().
- * Do not inline this?
- */
-static inline int netif_rx_reschedule(struct net_device *dev, int undo)
-{
-	if (netif_rx_schedule_prep(dev)) {
-		unsigned long flags;
-
-		dev->quota += undo;
-
-		local_irq_save(flags);
-		list_add_tail(&dev->poll_list, &__get_cpu_var(softnet_data).poll_list);
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-		local_irq_restore(flags);
-		return 1;
-	}
-	return 0;
-}
 
 /* Remove interface from poll list: it must be in the poll list
  * on current cpu. This primitive is called by dev->poll(), when
  * it completes the work. The device cannot be out of poll list at this
  * moment, it is BUG().
  */
+static inline void __netif_rx_complete(struct net_device *dev)
+{
+	napi_complete(&dev->napi);
+	dev_put(dev);
+}
+
 static inline void netif_rx_complete(struct net_device *dev)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
-	list_del(&dev->poll_list);
-	smp_mb__before_clear_bit();
-	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
+	__netif_rx_complete(dev);
 	local_irq_restore(flags);
 }
 
 static inline void netif_poll_disable(struct net_device *dev)
 {
-	while (test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state))
-		/* No hurry. */
-		schedule_timeout_interruptible(1);
+	napi_disable(&dev->napi);
 }
 
 static inline void netif_poll_enable(struct net_device *dev)
 {
-	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
-}
-
-/* same as netif_rx_complete, except that local_irq_save(flags)
- * has already been issued
- */
-static inline void __netif_rx_complete(struct net_device *dev)
-{
-	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
-	list_del(&dev->poll_list);
-	smp_mb__before_clear_bit();
-	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
+	napi_enable(&dev->napi);
 }
 
 static inline void netif_tx_lock(struct net_device *dev)
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 29930b7..bbd31f7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -25,8 +25,6 @@ struct netpoll {
 
 struct netpoll_info {
 	atomic_t refcnt;
-	spinlock_t poll_lock;
-	int poll_owner;
 	int rx_flags;
 	spinlock_t rx_lock;
 	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
@@ -44,52 +42,4 @@ void netpoll_set_trap(int trap);
 void netpoll_cleanup(struct netpoll *np);
 int __netpoll_rx(struct sk_buff *skb);
 
-
-#ifdef CONFIG_NETPOLL
-static inline int netpoll_rx(struct sk_buff *skb)
-{
-	struct netpoll_info *npinfo = skb->dev->npinfo;
-	unsigned long flags;
-	int ret = 0;
-
-	if (!npinfo || (!npinfo->rx_np && !npinfo->rx_flags))
-		return 0;
-
-	spin_lock_irqsave(&npinfo->rx_lock, flags);
-	/* check rx_flags again with the lock held */
-	if (npinfo->rx_flags && __netpoll_rx(skb))
-		ret = 1;
-	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
-
-	return ret;
-}
-
-static inline void *netpoll_poll_lock(struct net_device *dev)
-{
-	rcu_read_lock(); /* deal with race on ->npinfo */
-	if (dev->npinfo) {
-		spin_lock(&dev->npinfo->poll_lock);
-		dev->npinfo->poll_owner = smp_processor_id();
-		return dev->npinfo;
-	}
-	return NULL;
-}
-
-static inline void netpoll_poll_unlock(void *have)
-{
-	struct netpoll_info *npi = have;
-
-	if (npi) {
-		npi->poll_owner = -1;
-		spin_unlock(&npi->poll_lock);
-	}
-	rcu_read_unlock();
-}
-
-#else
-#define netpoll_rx(a) 0
-#define netpoll_poll_lock(a) NULL
-#define netpoll_poll_unlock(a)
-#endif
-
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index e660cb5..fe48a5f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -206,7 +206,25 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
  *	Device drivers call our routines to queue packets here. We empty the
  *	queue in the local softnet handler.
  */
-DEFINE_PER_CPU(struct softnet_data, softnet_data) = { NULL };
+
+/*
+ * Incoming packets are placed on per-cpu queues so that
+ * no locking is needed.
+ */
+struct softnet_data
+{
+	struct net_device	*output_queue;
+	struct sk_buff_head	input_pkt_queue;
+	struct list_head	poll_list;
+	struct sk_buff		*completion_queue;
+
+	struct napi_struct	backlog;
+#ifdef CONFIG_NET_DMA
+	struct dma_chan		*net_dma;
+#endif
+};
+
+static DEFINE_PER_CPU(struct softnet_data, softnet_data);
 
 #ifdef CONFIG_SYSFS
 extern int netdev_sysfs_init(void);
@@ -919,10 +937,7 @@ int dev_close(struct net_device *dev)
 	 * engine, but this requires more changes in devices. */
 
 	smp_mb__after_clear_bit(); /* Commit netif_running(). */
-	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
-		/* No hurry. */
-		msleep(1);
-	}
+	netif_poll_disable(dev);
 
 	/*
 	 *	Call the device specific close. This cannot fail.
@@ -1116,21 +1131,21 @@ void __netif_schedule(struct net_device *dev)
 }
 EXPORT_SYMBOL(__netif_schedule);
 
-void __netif_rx_schedule(struct net_device *dev)
+void dev_kfree_skb_irq(struct sk_buff *skb)
 {
-	unsigned long flags;
+	if (atomic_dec_and_test(&skb->users)) {
+		struct softnet_data *sd;
+		unsigned long flags;
 
-	local_irq_save(flags);
-	dev_hold(dev);
-	list_add_tail(&dev->poll_list, &__get_cpu_var(softnet_data).poll_list);
-	if (dev->quota < 0)
-		dev->quota += dev->weight;
-	else
-		dev->quota = dev->weight;
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-	local_irq_restore(flags);
+		local_irq_save(flags);
+		sd = &__get_cpu_var(softnet_data);
+		skb->next = sd->completion_queue;
+		sd->completion_queue = skb;
+		raise_softirq_irqoff(NET_TX_SOFTIRQ);
+		local_irq_restore(flags);
+	}
 }
-EXPORT_SYMBOL(__netif_rx_schedule);
+EXPORT_SYMBOL(dev_kfree_skb_irq);
 
 void dev_kfree_skb_any(struct sk_buff *skb)
 {
@@ -1553,6 +1568,28 @@ int weight_p = 64;            /* old backlog weight */
 DEFINE_PER_CPU(struct netif_rx_stats, netdev_rx_stat) = { 0, };
 
 
+#ifdef CONFIG_NETPOLL
+static inline int netpoll_rx(struct sk_buff *skb)
+{
+	struct netpoll_info *npinfo = skb->dev->npinfo;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!npinfo || (!npinfo->rx_np && !npinfo->rx_flags))
+		return 0;
+
+	spin_lock_irqsave(&npinfo->rx_lock, flags);
+	/* check rx_flags again with the lock held */
+	if (npinfo->rx_flags && __netpoll_rx(skb))
+		ret = 1;
+	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+
+	return ret;
+}
+#else 
+#define netpoll_rx(skb)	(0)
+#endif
+
 /**
  *	netif_rx	-	post buffer to the network code
  *	@skb: buffer to post
@@ -1600,7 +1637,7 @@ enqueue:
 			return NET_RX_SUCCESS;
 		}
 
-		netif_rx_schedule(&queue->backlog_dev);
+		napi_schedule(&queue->backlog);
 		goto enqueue;
 	}
 
@@ -1641,6 +1678,38 @@ static inline struct net_device *skb_bond(struct sk_buff *skb)
 	return dev;
 }
 
+
+#ifdef CONFIG_NETPOLL
+/* Netpoll is out of skb's, try and do a quick reclaim on the ones pending
+ * to be cleaned up by softirq.
+ */
+void netpoll_zap_completion_queue(void)
+{
+	struct softnet_data *sd = &get_cpu_var(softnet_data);
+	unsigned long flags;
+
+	if (sd->completion_queue) {
+		struct sk_buff *clist;
+
+		local_irq_save(flags);
+		clist = sd->completion_queue;
+		sd->completion_queue = NULL;
+		local_irq_restore(flags);
+
+		while (clist != NULL) {
+			struct sk_buff *skb = clist;
+			clist = clist->next;
+			if (skb->destructor)
+				dev_kfree_skb_any(skb); /* put this one back */
+			else
+				__kfree_skb(skb);
+		}
+	}
+
+	put_cpu_var(softnet_data);
+}
+#endif
+
 static void net_tx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = &__get_cpu_var(softnet_data);
@@ -1769,7 +1838,7 @@ int netif_receive_skb(struct sk_buff *skb)
 	__be16 type;
 
 	/* if we've gotten here through NAPI, check netpoll */
-	if (skb->dev->poll && netpoll_rx(skb))
+	if (skb->dev->napi.poll && netpoll_rx(skb))
 		return NET_RX_DROP;
 
 	if (!skb->tstamp.off_sec)
@@ -1854,89 +1923,103 @@ out:
 	return ret;
 }
 
-static int process_backlog(struct net_device *backlog_dev, int *budget)
+static int process_backlog(struct napi_struct *napi, int quota)
 {
 	int work = 0;
-	int quota = min(backlog_dev->quota, *budget);
 	struct softnet_data *queue = &__get_cpu_var(softnet_data);
 	unsigned long start_time = jiffies;
 
-	backlog_dev->weight = weight_p;
-	for (;;) {
+	napi->weight = weight_p;
+	do {
 		struct sk_buff *skb;
 		struct net_device *dev;
 
 		local_irq_disable();
 		skb = __skb_dequeue(&queue->input_pkt_queue);
-		if (!skb)
-			goto job_done;
 		local_irq_enable();
-
+		if (!skb) {
+			napi_complete(napi);
+			break;
+		}
+	
 		dev = skb->dev;
 
 		netif_receive_skb(skb);
 
 		dev_put(dev);
+	} while (++work < quota && jiffies == start_time);
 
-		work++;
-
-		if (work >= quota || jiffies - start_time > 1)
-			break;
-
-	}
-
-	backlog_dev->quota -= work;
-	*budget -= work;
-	return -1;
+	return work;
+}
 
-job_done:
-	backlog_dev->quota -= work;
-	*budget -= work;
+/**
+ * __napi_schedule - schedule for receive
+ * @napi: entry to schedule
+ *
+ * The entry's receive function will be scheduled to run
+ */
+void fastcall __napi_schedule(struct napi_struct *n)
+{
+	unsigned long flags;
 
-	list_del(&backlog_dev->poll_list);
-	smp_mb__before_clear_bit();
-	netif_poll_enable(backlog_dev);
+	if (n->quota < 0)
+		n->quota += n->weight;
+	else
+		n->quota = n->weight;
 
-	local_irq_enable();
-	return 0;
+	local_irq_save(flags);
+	list_add_tail(&n->poll_list, &__get_cpu_var(softnet_data).poll_list);
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(__napi_schedule);
+
 
 static void net_rx_action(struct softirq_action *h)
 {
-	struct softnet_data *queue = &__get_cpu_var(softnet_data);
+	struct list_head list;
 	unsigned long start_time = jiffies;
 	int budget = netdev_budget;
-	void *have;
 
 	local_irq_disable();
+	list_replace_init(&__get_cpu_var(softnet_data).poll_list, &list);
+	local_irq_enable();
 
-	while (!list_empty(&queue->poll_list)) {
-		struct net_device *dev;
+	while (!list_empty(&list)) {
+		struct napi_struct *n;
 
-		if (budget <= 0 || jiffies - start_time > 1)
-			goto softnet_break;
+		/* if softirq window is exhuasted then punt */
+		if (unlikely(budget <= 0 || jiffies != start_time)) {
+			local_irq_disable();
+			list_splice(&list, &__get_cpu_var(softnet_data).poll_list);
+			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+			local_irq_enable();
+			break;
+		}
 
-		local_irq_enable();
+		n = list_entry(list.next, struct napi_struct, poll_list);
 
-		dev = list_entry(queue->poll_list.next,
-				 struct net_device, poll_list);
-		have = netpoll_poll_lock(dev);
+		/* if not racing with netpoll */
+		if (likely(napi_trylock(n))) {
+			list_del(&n->poll_list);
+
+			/* if quota not exhausted process work */
+			if (likely(n->quota > 0)) {
+				int work = n->poll(n, min(budget, n->quota));
+
+				budget -= work;
+				n->quota -= work;
+			}
+
+			/* if napi_complete not called, reschedule */
+			if (test_bit(NAPI_STATE_SCHED, &n->state))
+				__napi_schedule(n);
+
+			napi_unlock(n);
+		} 
 
-		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
-			netpoll_poll_unlock(have);
-			local_irq_disable();
-			list_move_tail(&dev->poll_list, &queue->poll_list);
-			if (dev->quota < 0)
-				dev->quota += dev->weight;
-			else
-				dev->quota = dev->weight;
-		} else {
-			netpoll_poll_unlock(have);
-			dev_put(dev);
-			local_irq_disable();
-		}
 	}
-out:
+
 #ifdef CONFIG_NET_DMA
 	/*
 	 * There may not be any more sk_buffs coming right now, so push
@@ -1950,13 +2033,6 @@ out:
 		rcu_read_unlock();
 	}
 #endif
-	local_irq_enable();
-	return;
-
-softnet_break:
-	__get_cpu_var(netdev_rx_stat).time_squeeze++;
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-	goto out;
 }
 
 static gifconf_func_t * gifconf_list [NPROTO];
@@ -3506,10 +3582,9 @@ static int __init net_dev_init(void)
 		skb_queue_head_init(&queue->input_pkt_queue);
 		queue->completion_queue = NULL;
 		INIT_LIST_HEAD(&queue->poll_list);
-		set_bit(__LINK_STATE_START, &queue->backlog_dev.state);
-		queue->backlog_dev.weight = weight_p;
-		queue->backlog_dev.poll = process_backlog;
-		atomic_set(&queue->backlog_dev.refcnt, 1);
+
+		queue->backlog.weight = weight_p;
+		queue->backlog.poll = process_backlog;
 	}
 
 	netdev_dma_register();
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f47f319..077d358 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -208,11 +208,19 @@ static ssize_t store_tx_queue_len(struct class_device *dev, const char *buf, siz
 	return netdev_store(dev, buf, len, change_tx_queue_len);
 }
 
-NETDEVICE_SHOW(weight, fmt_dec);
+static ssize_t format_weight(const struct net_device *net, char *buf)
+{
+	return sprintf(buf, fmt_dec, net->napi.weight);
+}
+
+static ssize_t show_weight(struct class_device *cd, char *buf)
+{
+	return netdev_show(cd, buf, format_weight);
+}
 
 static int change_weight(struct net_device *net, unsigned long new_weight)
 {
-	net->weight = new_weight;
+	net->napi.weight = new_weight;
 	return 0;
 }
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index b3c559b..da4f9a2 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -47,7 +47,6 @@ static atomic_t trapped;
 		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
 				sizeof(struct iphdr) + sizeof(struct ethhdr))
 
-static void zap_completion_queue(void);
 static void arp_reply(struct sk_buff *skb);
 
 static void queue_process(struct work_struct *work)
@@ -109,24 +108,26 @@ static __sum16 checksum_udp(struct sk_buff *skb, struct udphdr *uh,
  * In cases where there is bi-directional communications, reading only
  * one message at a time can lead to packets being dropped by the
  * network adapter, forcing superfluous retries and possibly timeouts.
- * Thus, we set our budget to greater than 1.
  */
 static void poll_napi(struct netpoll *np)
 {
-	struct netpoll_info *npinfo = np->dev->npinfo;
-	int budget = 16;
+	struct net_device *dev = np->dev;
+	struct netpoll_info *npinfo = dev->npinfo;
+	struct napi_struct *napi = &dev->napi;
 
-	if (test_bit(__LINK_STATE_RX_SCHED, &np->dev->state) &&
-	    npinfo->poll_owner != smp_processor_id() &&
-	    spin_trylock(&npinfo->poll_lock)) {
+	if (napi->poll && test_bit(NAPI_STATE_SCHED, &napi->state) && napi_trylock(napi)) {
 		npinfo->rx_flags |= NETPOLL_RX_DROP;
 		atomic_inc(&trapped);
 
-		np->dev->poll(np->dev, &budget);
+		list_del(&napi->poll_list);
+
+		napi->poll(napi, napi->quota);
+		if (test_bit(NAPI_STATE_SCHED, &napi->state))
+			__napi_schedule(napi);
 
 		atomic_dec(&trapped);
 		npinfo->rx_flags &= ~NETPOLL_RX_DROP;
-		spin_unlock(&npinfo->poll_lock);
+		napi_unlock(napi);
 	}
 }
 
@@ -145,6 +146,9 @@ static void service_arp_queue(struct netpoll_info *npi)
 	}
 }
 
+extern void netpoll_zap_completion_queue(void);
+
+
 void netpoll_poll(struct netpoll *np)
 {
 	if (!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
@@ -152,12 +156,11 @@ void netpoll_poll(struct netpoll *np)
 
 	/* Process pending work on NIC */
 	np->dev->poll_controller(np->dev);
-	if (np->dev->poll)
-		poll_napi(np);
+	poll_napi(np);
 
 	service_arp_queue(np->dev->npinfo);
 
-	zap_completion_queue();
+	netpoll_zap_completion_queue();
 }
 
 static void refill_skbs(void)
@@ -176,38 +179,12 @@ static void refill_skbs(void)
 	spin_unlock_irqrestore(&skb_pool.lock, flags);
 }
 
-static void zap_completion_queue(void)
-{
-	unsigned long flags;
-	struct softnet_data *sd = &get_cpu_var(softnet_data);
-
-	if (sd->completion_queue) {
-		struct sk_buff *clist;
-
-		local_irq_save(flags);
-		clist = sd->completion_queue;
-		sd->completion_queue = NULL;
-		local_irq_restore(flags);
-
-		while (clist != NULL) {
-			struct sk_buff *skb = clist;
-			clist = clist->next;
-			if (skb->destructor)
-				dev_kfree_skb_any(skb); /* put this one back */
-			else
-				__kfree_skb(skb);
-		}
-	}
-
-	put_cpu_var(softnet_data);
-}
-
 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
 	struct sk_buff *skb;
 
-	zap_completion_queue();
+	netpoll_zap_completion_queue();
 	refill_skbs();
 repeat:
 
@@ -241,9 +218,7 @@ static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
  	}
 
 	/* don't get messages out of order, and no recursion */
-	if (skb_queue_len(&npinfo->txq) == 0 &&
-	    npinfo->poll_owner != smp_processor_id() &&
-	    netif_tx_trylock(dev)) {
+	if (skb_queue_len(&npinfo->txq) == 0 && netif_tx_trylock(dev)) {
 		/* try until next clock tick */
 		for (tries = jiffies_to_usecs(1)/USEC_PER_POLL; tries > 0; --tries) {
 			if (!netif_queue_stopped(dev))
@@ -621,8 +596,6 @@ int netpoll_setup(struct netpoll *np)
 
 		npinfo->rx_flags = 0;
 		npinfo->rx_np = NULL;
-		spin_lock_init(&npinfo->poll_lock);
-		npinfo->poll_owner = -1;
 
 		spin_lock_init(&npinfo->rx_lock);
 		skb_queue_head_init(&npinfo->arp_tx);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e76539a..e60beb3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -332,7 +332,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb, struct net_device *dev,
 
 	NLA_PUT_STRING(skb, IFLA_IFNAME, dev->name);
 	NLA_PUT_U32(skb, IFLA_TXQLEN, dev->tx_queue_len);
-	NLA_PUT_U32(skb, IFLA_WEIGHT, dev->weight);
+	NLA_PUT_U32(skb, IFLA_WEIGHT, dev->napi.weight);
 	NLA_PUT_U8(skb, IFLA_OPERSTATE,
 		   netif_running(dev) ? dev->operstate : IF_OPER_DOWN);
 	NLA_PUT_U8(skb, IFLA_LINKMODE, dev->link_mode);
@@ -560,7 +560,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
 
 	if (tb[IFLA_WEIGHT])
-		dev->weight = nla_get_u32(tb[IFLA_WEIGHT]);
+		dev->napi.weight = nla_get_u32(tb[IFLA_WEIGHT]);
 
 	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
-- 
1.4.4.2

