Return-Path: <linux-kernel-owner+w=401wt.eu-S936687AbWLKPpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936687AbWLKPpl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936686AbWLKPpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:45:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:57214 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936577AbWLKPph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:45:37 -0500
Date: Mon, 11 Dec 2006 10:45:31 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver updates
Message-ID: <20061211154531.GA23909@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/Kconfig             |    8 +
 drivers/net/chelsio/cxgb2.c     |   23 +-
 drivers/net/chelsio/sge.c       |  115 ++++-----
 drivers/net/chelsio/sge.h       |    4 
 drivers/net/macb.c              |    8 -
 drivers/net/macb.h              |    6 
 drivers/net/myri10ge/myri10ge.c |  498 ++++++++++++++++++++-------------------
 drivers/net/smc91x.h            |   90 -------
 drivers/net/ucc_geth.c          |   12 +
 9 files changed, 334 insertions(+), 430 deletions(-)

Brice Goglin:
      myri10ge: indentation cleanups
      myri10ge: add page-based skb routines
      myri10ge: switch to page-based skb
      myri10ge: drop contiguous skb routines
      myri10ge: Full vlan frame in small_bytes
      myri10ge: fix big_bytes in case of vlan frames
      myri10ge: update driver version to 1.1.0

Haavard Skinnemoen:
      MACB: Use struct delayed_work instead of struct work_struct
      MACB: Use __raw register access

Paul Mundt:
      smc91x: Kill off excessive versatile hooks.

Scott Wood:
      ucc_geth: compilation error fixes
      ucc_geth: Initialize mdio_lock.

Stephen Hemminger:
      chelsio: working NAPI

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9de0eed..8aa8dd0 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2384,6 +2384,14 @@ config CHELSIO_T1_1G
           Enables support for Chelsio's gigabit Ethernet PCI cards.  If you
           are using only 10G cards say 'N' here.
 
+config CHELSIO_T1_NAPI
+	bool "Use Rx Polling (NAPI)"
+	depends on CHELSIO_T1
+	default y
+	help
+	  NAPI is a driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card.
+
 config EHEA
 	tristate "eHEA Ethernet support"
 	depends on IBMEBUS
diff --git a/drivers/net/chelsio/cxgb2.c b/drivers/net/chelsio/cxgb2.c
index de48ead..fd5d821 100644
--- a/drivers/net/chelsio/cxgb2.c
+++ b/drivers/net/chelsio/cxgb2.c
@@ -220,9 +220,8 @@ static int cxgb_up(struct adapter *adapt
 
 	t1_interrupts_clear(adapter);
 
-	adapter->params.has_msi = !disable_msi && pci_enable_msi(adapter->pdev) == 0;
-	err = request_irq(adapter->pdev->irq,
-			  t1_select_intr_handler(adapter),
+	adapter->params.has_msi = !disable_msi && !pci_enable_msi(adapter->pdev);
+	err = request_irq(adapter->pdev->irq, t1_interrupt,
 			  adapter->params.has_msi ? 0 : IRQF_SHARED,
 			  adapter->name, adapter);
 	if (err) {
@@ -764,18 +763,7 @@ static int set_coalesce(struct net_devic
 {
 	struct adapter *adapter = dev->priv;
 
-	/*
-	 * If RX coalescing is requested we use NAPI, otherwise interrupts.
-	 * This choice can be made only when all ports and the TOE are off.
-	 */
-	if (adapter->open_device_map == 0)
-		adapter->params.sge.polling = c->use_adaptive_rx_coalesce;
-
-	if (adapter->params.sge.polling) {
-		adapter->params.sge.rx_coalesce_usecs = 0;
-	} else {
-		adapter->params.sge.rx_coalesce_usecs = c->rx_coalesce_usecs;
-	}
+	adapter->params.sge.rx_coalesce_usecs = c->rx_coalesce_usecs;
  	adapter->params.sge.coalesce_enable = c->use_adaptive_rx_coalesce;
 	adapter->params.sge.sample_interval_usecs = c->rate_sample_interval;
 	t1_sge_set_coalesce_params(adapter->sge, &adapter->params.sge);
@@ -944,7 +932,7 @@ static void t1_netpoll(struct net_device
 	struct adapter *adapter = dev->priv;
 
 	local_irq_save(flags);
-	t1_select_intr_handler(adapter)(adapter->pdev->irq, adapter);
+	t1_interrupt(adapter->pdev->irq, adapter);
 	local_irq_restore(flags);
 }
 #endif
@@ -1165,7 +1153,10 @@ #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 		netdev->poll_controller = t1_netpoll;
 #endif
+#ifdef CONFIG_CHELSIO_T1_NAPI
 		netdev->weight = 64;
+		netdev->poll = t1_poll;
+#endif
 
 		SET_ETHTOOL_OPS(netdev, &t1_ethtool_ops);
 	}
diff --git a/drivers/net/chelsio/sge.c b/drivers/net/chelsio/sge.c
index 0ca8d87..659cb22 100644
--- a/drivers/net/chelsio/sge.c
+++ b/drivers/net/chelsio/sge.c
@@ -1413,16 +1413,20 @@ static int sge_rx(struct sge *sge, struc
 
 	if (unlikely(adapter->vlan_grp && p->vlan_valid)) {
 		st->vlan_xtract++;
-		if (adapter->params.sge.polling)
+#ifdef CONFIG_CHELSIO_T1_NAPI
 			vlan_hwaccel_receive_skb(skb, adapter->vlan_grp,
 						 ntohs(p->vlan));
-		else
+#else
 			vlan_hwaccel_rx(skb, adapter->vlan_grp,
 					ntohs(p->vlan));
-	} else if (adapter->params.sge.polling)
+#endif
+	} else {
+#ifdef CONFIG_CHELSIO_T1_NAPI
 		netif_receive_skb(skb);
-	else
+#else
 		netif_rx(skb);
+#endif
+	}
 	return 0;
 }
 
@@ -1572,6 +1576,7 @@ static int process_responses(struct adap
 	return budget;
 }
 
+#ifdef CONFIG_CHELSIO_T1_NAPI
 /*
  * A simpler version of process_responses() that handles only pure (i.e.,
  * non data-carrying) responses.  Such respones are too light-weight to justify
@@ -1619,92 +1624,76 @@ static int process_pure_responses(struct
  * or protection from interrupts as data interrupts are off at this point and
  * other adapter interrupts do not interfere.
  */
-static int t1_poll(struct net_device *dev, int *budget)
+int t1_poll(struct net_device *dev, int *budget)
 {
 	struct adapter *adapter = dev->priv;
 	int effective_budget = min(*budget, dev->quota);
-
 	int work_done = process_responses(adapter, effective_budget);
+
 	*budget -= work_done;
 	dev->quota -= work_done;
 
 	if (work_done >= effective_budget)
 		return 1;
 
+ 	spin_lock_irq(&adapter->async_lock);
 	__netif_rx_complete(dev);
-
-	/*
-	 * Because we don't atomically flush the following write it is
-	 * possible that in very rare cases it can reach the device in a way
-	 * that races with a new response being written plus an error interrupt
-	 * causing the NAPI interrupt handler below to return unhandled status
-	 * to the OS.  To protect against this would require flushing the write
-	 * and doing both the write and the flush with interrupts off.  Way too
-	 * expensive and unjustifiable given the rarity of the race.
-	 */
 	writel(adapter->sge->respQ.cidx, adapter->regs + A_SG_SLEEPING);
-	return 0;
-}
+	writel(adapter->slow_intr_mask | F_PL_INTR_SGE_DATA,
+	       adapter->regs + A_PL_ENABLE);
+ 	spin_unlock_irq(&adapter->async_lock);
 
-/*
- * Returns true if the device is already scheduled for polling.
- */
-static inline int napi_is_scheduled(struct net_device *dev)
-{
-	return test_bit(__LINK_STATE_RX_SCHED, &dev->state);
+	return 0;
 }
 
 /*
  * NAPI version of the main interrupt handler.
  */
-static irqreturn_t t1_interrupt_napi(int irq, void *data)
+irqreturn_t t1_interrupt(int irq, void *data)
 {
-	int handled;
 	struct adapter *adapter = data;
+ 	struct net_device *dev = adapter->sge->netdev;
 	struct sge *sge = adapter->sge;
-	struct respQ *q = &adapter->sge->respQ;
+ 	u32 cause;
+	int handled = 0;
 
-	/*
-	 * Clear the SGE_DATA interrupt first thing.  Normally the NAPI
-	 * handler has control of the response queue and the interrupt handler
-	 * can look at the queue reliably only once it knows NAPI is off.
-	 * We can't wait that long to clear the SGE_DATA interrupt because we
-	 * could race with t1_poll rearming the SGE interrupt, so we need to
-	 * clear the interrupt speculatively and really early on.
-	 */
-	writel(F_PL_INTR_SGE_DATA, adapter->regs + A_PL_CAUSE);
+	cause = readl(adapter->regs + A_PL_CAUSE);
+	if (cause == 0 || cause == ~0)
+		return IRQ_NONE;
 
 	spin_lock(&adapter->async_lock);
-	if (!napi_is_scheduled(sge->netdev)) {
+ 	if (cause & F_PL_INTR_SGE_DATA) {
+		struct respQ *q = &adapter->sge->respQ;
 		struct respQ_e *e = &q->entries[q->cidx];
 
-		if (e->GenerationBit == q->genbit) {
-			if (e->DataValid ||
-			    process_pure_responses(adapter, e)) {
-				if (likely(__netif_rx_schedule_prep(sge->netdev)))
-					__netif_rx_schedule(sge->netdev);
-				else if (net_ratelimit())
-					printk(KERN_INFO
-					       "NAPI schedule failure!\n");
-			} else
-				writel(q->cidx, adapter->regs + A_SG_SLEEPING);
-
-			handled = 1;
-			goto unlock;
-		} else
-			writel(q->cidx, adapter->regs + A_SG_SLEEPING);
-	}  else if (readl(adapter->regs + A_PL_CAUSE) & F_PL_INTR_SGE_DATA) {
-	        printk(KERN_ERR "data interrupt while NAPI running\n");
-	}
-	
-	handled = t1_slow_intr_handler(adapter);
+ 		handled = 1;
+ 		writel(F_PL_INTR_SGE_DATA, adapter->regs + A_PL_CAUSE);
+
+		if (e->GenerationBit == q->genbit &&
+		    __netif_rx_schedule_prep(dev)) {
+			if (e->DataValid || process_pure_responses(adapter, e)) {
+				/* mask off data IRQ */
+				writel(adapter->slow_intr_mask,
+				       adapter->regs + A_PL_ENABLE);
+				__netif_rx_schedule(sge->netdev);
+				goto unlock;
+			}
+			/* no data, no NAPI needed */
+			netif_poll_enable(dev);
+
+		}
+		writel(q->cidx, adapter->regs + A_SG_SLEEPING);
+	} else
+		handled = t1_slow_intr_handler(adapter);
+
 	if (!handled)
 		sge->stats.unhandled_irqs++;
- unlock:
+unlock:
 	spin_unlock(&adapter->async_lock);
 	return IRQ_RETVAL(handled != 0);
 }
 
+#else
 /*
  * Main interrupt handler, optimized assuming that we took a 'DATA'
  * interrupt.
@@ -1720,7 +1709,7 @@ static irqreturn_t t1_interrupt_napi(int
  * 5. If we took an interrupt, but no valid respQ descriptors was found we
  *      let the slow_intr_handler run and do error handling.
  */
-static irqreturn_t t1_interrupt(int irq, void *cookie)
+irqreturn_t t1_interrupt(int irq, void *cookie)
 {
 	int work_done;
 	struct respQ_e *e;
@@ -1752,11 +1741,7 @@ static irqreturn_t t1_interrupt(int irq,
 	spin_unlock(&adapter->async_lock);
 	return IRQ_RETVAL(work_done != 0);
 }
-
-irq_handler_t t1_select_intr_handler(adapter_t *adapter)
-{
-	return adapter->params.sge.polling ? t1_interrupt_napi : t1_interrupt;
-}
+#endif
 
 /*
  * Enqueues the sk_buff onto the cmdQ[qid] and has hardware fetch it.
@@ -2033,7 +2018,6 @@ static void sge_tx_reclaim_cb(unsigned l
  */
 int t1_sge_set_coalesce_params(struct sge *sge, struct sge_params *p)
 {
-	sge->netdev->poll = t1_poll;
 	sge->fixed_intrtimer = p->rx_coalesce_usecs *
 		core_ticks_per_usec(sge->adapter);
 	writel(sge->fixed_intrtimer, sge->adapter->regs + A_SG_INTRTIMER);
@@ -2234,7 +2218,6 @@ struct sge * __devinit t1_sge_create(str
 
 	p->coalesce_enable = 0;
 	p->sample_interval_usecs = 0;
-	p->polling = 0;
 
 	return sge;
 nomem_port:
diff --git a/drivers/net/chelsio/sge.h b/drivers/net/chelsio/sge.h
index 7ceb011..d132a0e 100644
--- a/drivers/net/chelsio/sge.h
+++ b/drivers/net/chelsio/sge.h
@@ -76,7 +76,9 @@ struct sge *t1_sge_create(struct adapter
 int t1_sge_configure(struct sge *, struct sge_params *);
 int t1_sge_set_coalesce_params(struct sge *, struct sge_params *);
 void t1_sge_destroy(struct sge *);
-irq_handler_t t1_select_intr_handler(adapter_t *adapter);
+irqreturn_t t1_interrupt(int irq, void *cookie);
+int t1_poll(struct net_device *, int *);
+
 int t1_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void t1_set_vlan_accel(struct adapter *adapter, int on_off);
 void t1_sge_start(struct sge *);
diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index bd0ce98..25b559b 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -264,12 +264,12 @@ static void macb_update_stats(struct mac
 	WARN_ON((unsigned long)(end - p - 1) != (MACB_TPF - MACB_PFR) / 4);
 
 	for(; p < end; p++, reg++)
-		*p += readl(reg);
+		*p += __raw_readl(reg);
 }
 
-static void macb_periodic_task(void *arg)
+static void macb_periodic_task(struct work_struct *work)
 {
-	struct macb *bp = arg;
+	struct macb *bp = container_of(work, struct macb, periodic_task.work);
 
 	macb_update_stats(bp);
 	macb_check_media(bp, 1, 0);
@@ -1088,7 +1088,7 @@ static int __devinit macb_probe(struct p
 
 	dev->base_addr = regs->start;
 
-	INIT_WORK(&bp->periodic_task, macb_periodic_task, bp);
+	INIT_DELAYED_WORK(&bp->periodic_task, macb_periodic_task);
 	mutex_init(&bp->mdio_mutex);
 	init_completion(&bp->mdio_complete);
 
diff --git a/drivers/net/macb.h b/drivers/net/macb.h
index 8c253db..27bf0ae 100644
--- a/drivers/net/macb.h
+++ b/drivers/net/macb.h
@@ -250,9 +250,9 @@ #define MACB_BFINS(name,value,old)			\
 
 /* Register access macros */
 #define macb_readl(port,reg)				\
-	readl((port)->regs + MACB_##reg)
+	__raw_readl((port)->regs + MACB_##reg)
 #define macb_writel(port,reg,value)			\
-	writel((value), (port)->regs + MACB_##reg)
+	__raw_writel((value), (port)->regs + MACB_##reg)
 
 struct dma_desc {
 	u32	addr;
@@ -377,7 +377,7 @@ struct macb {
 
 	unsigned int		rx_pending, tx_pending;
 
-	struct work_struct	periodic_task;
+	struct delayed_work	periodic_task;
 
 	struct mutex		mdio_mutex;
 	struct completion	mdio_complete;
diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index 81f127a..94ac168 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -71,7 +71,7 @@ #endif
 #include "myri10ge_mcp.h"
 #include "myri10ge_mcp_gen_header.h"
 
-#define MYRI10GE_VERSION_STR "1.0.0"
+#define MYRI10GE_VERSION_STR "1.1.0"
 
 MODULE_DESCRIPTION("Myricom 10G driver (10GbE)");
 MODULE_AUTHOR("Maintainer: help@myri.com");
@@ -92,8 +92,13 @@ #define MYRI10GE_MAX_SEND_DESC_TSO ((655
 #define MYRI10GE_NO_CONFIRM_DATA htonl(0xffffffff)
 #define MYRI10GE_NO_RESPONSE_RESULT 0xffffffff
 
+#define MYRI10GE_ALLOC_ORDER 0
+#define MYRI10GE_ALLOC_SIZE ((1 << MYRI10GE_ALLOC_ORDER) * PAGE_SIZE)
+#define MYRI10GE_MAX_FRAGS_PER_FRAME (MYRI10GE_MAX_ETHER_MTU/MYRI10GE_ALLOC_SIZE + 1)
+
 struct myri10ge_rx_buffer_state {
-	struct sk_buff *skb;
+	struct page *page;
+	int page_offset;
 	 DECLARE_PCI_UNMAP_ADDR(bus)
 	 DECLARE_PCI_UNMAP_LEN(len)
 };
@@ -116,9 +121,14 @@ struct myri10ge_rx_buf {
 	u8 __iomem *wc_fifo;	/* w/c rx dma addr fifo address */
 	struct mcp_kreq_ether_recv *shadow;	/* host shadow of recv ring */
 	struct myri10ge_rx_buffer_state *info;
+	struct page *page;
+	dma_addr_t bus;
+	int page_offset;
 	int cnt;
+	int fill_cnt;
 	int alloc_fail;
 	int mask;		/* number of rx slots -1 */
+	int watchdog_needed;
 };
 
 struct myri10ge_tx_buf {
@@ -150,6 +160,7 @@ struct myri10ge_priv {
 	struct myri10ge_rx_buf rx_big;
 	struct myri10ge_rx_done rx_done;
 	int small_bytes;
+	int big_bytes;
 	struct net_device *dev;
 	struct net_device_stats stats;
 	u8 __iomem *sram;
@@ -238,11 +249,6 @@ module_param(myri10ge_force_firmware, in
 MODULE_PARM_DESC(myri10ge_force_firmware,
 		 "Force firmware to assume aligned completions\n");
 
-static int myri10ge_skb_cross_4k = 0;
-module_param(myri10ge_skb_cross_4k, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(myri10ge_skb_cross_4k,
-		 "Can a small skb cross a 4KB boundary?\n");
-
 static int myri10ge_initial_mtu = MYRI10GE_MAX_ETHER_MTU - ETH_HLEN;
 module_param(myri10ge_initial_mtu, int, S_IRUGO);
 MODULE_PARM_DESC(myri10ge_initial_mtu, "Initial MTU\n");
@@ -266,6 +272,10 @@ static int myri10ge_debug = -1;	/* defau
 module_param(myri10ge_debug, int, 0);
 MODULE_PARM_DESC(myri10ge_debug, "Debug level (0=none,...,16=all)");
 
+static int myri10ge_fill_thresh = 256;
+module_param(myri10ge_fill_thresh, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(myri10ge_fill_thresh, "Number of empty rx slots allowed\n");
+
 #define MYRI10GE_FW_OFFSET 1024*1024
 #define MYRI10GE_HIGHPART_TO_U32(X) \
 (sizeof (X) == 8) ? ((u32)((u64)(X) >> 32)) : (0)
@@ -273,9 +283,9 @@ #define MYRI10GE_LOWPART_TO_U32(X) ((u32
 
 #define myri10ge_pio_copy(to,from,size) __iowrite64_copy(to,from,size/8)
 
-static inline void put_be32(__be32 val, __be32 __iomem *p)
+static inline void put_be32(__be32 val, __be32 __iomem * p)
 {
-	__raw_writel((__force __u32)val, (__force void __iomem *)p);
+	__raw_writel((__force __u32) val, (__force void __iomem *)p);
 }
 
 static int
@@ -804,194 +814,179 @@ myri10ge_submit_8rx(struct mcp_kreq_ethe
 	mb();
 }
 
-/*
- * Set of routines to get a new receive buffer.  Any buffer which
- * crosses a 4KB boundary must start on a 4KB boundary due to PCIe
- * wdma restrictions. We also try to align any smaller allocation to
- * at least a 16 byte boundary for efficiency.  We assume the linux
- * memory allocator works by powers of 2, and will not return memory
- * smaller than 2KB which crosses a 4KB boundary.  If it does, we fall
- * back to allocating 2x as much space as required.
- *
- * We intend to replace large (>4KB) skb allocations by using
- * pages directly and building a fraglist in the near future.
- */
-
-static inline struct sk_buff *myri10ge_alloc_big(struct net_device *dev,
-						 int bytes)
-{
-	struct sk_buff *skb;
-	unsigned long data, roundup;
-
-	skb = netdev_alloc_skb(dev, bytes + 4096 + MXGEFW_PAD);
-	if (skb == NULL)
-		return NULL;
-
-	/* Correct skb->truesize so that socket buffer
-	 * accounting is not confused the rounding we must
-	 * do to satisfy alignment constraints.
-	 */
-	skb->truesize -= 4096;
-
-	data = (unsigned long)(skb->data);
-	roundup = (-data) & (4095);
-	skb_reserve(skb, roundup);
-	return skb;
-}
-
-/* Allocate 2x as much space as required and use whichever portion
- * does not cross a 4KB boundary */
-static inline struct sk_buff *myri10ge_alloc_small_safe(struct net_device *dev,
-							unsigned int bytes)
+static inline void myri10ge_vlan_ip_csum(struct sk_buff *skb, __wsum hw_csum)
 {
-	struct sk_buff *skb;
-	unsigned long data, boundary;
-
-	skb = netdev_alloc_skb(dev, 2 * (bytes + MXGEFW_PAD) - 1);
-	if (unlikely(skb == NULL))
-		return NULL;
-
-	/* Correct skb->truesize so that socket buffer
-	 * accounting is not confused the rounding we must
-	 * do to satisfy alignment constraints.
-	 */
-	skb->truesize -= bytes + MXGEFW_PAD;
-
-	data = (unsigned long)(skb->data);
-	boundary = (data + 4095UL) & ~4095UL;
-	if ((boundary - data) >= (bytes + MXGEFW_PAD))
-		return skb;
+	struct vlan_hdr *vh = (struct vlan_hdr *)(skb->data);
 
-	skb_reserve(skb, boundary - data);
-	return skb;
+	if ((skb->protocol == htons(ETH_P_8021Q)) &&
+	    (vh->h_vlan_encapsulated_proto == htons(ETH_P_IP) ||
+	     vh->h_vlan_encapsulated_proto == htons(ETH_P_IPV6))) {
+		skb->csum = hw_csum;
+		skb->ip_summed = CHECKSUM_COMPLETE;
+	}
 }
 
-/* Allocate just enough space, and verify that the allocated
- * space does not cross a 4KB boundary */
-static inline struct sk_buff *myri10ge_alloc_small(struct net_device *dev,
-						   int bytes)
+static inline void
+myri10ge_rx_skb_build(struct sk_buff *skb, u8 * va,
+		      struct skb_frag_struct *rx_frags, int len, int hlen)
 {
-	struct sk_buff *skb;
-	unsigned long roundup, data, end;
-
-	skb = netdev_alloc_skb(dev, bytes + 16 + MXGEFW_PAD);
-	if (unlikely(skb == NULL))
-		return NULL;
-
-	/* Round allocated buffer to 16 byte boundary */
-	data = (unsigned long)(skb->data);
-	roundup = (-data) & 15UL;
-	skb_reserve(skb, roundup);
-	/* Verify that the data buffer does not cross a page boundary */
-	data = (unsigned long)(skb->data);
-	end = data + bytes + MXGEFW_PAD - 1;
-	if (unlikely(((end >> 12) != (data >> 12)) && (data & 4095UL))) {
-		printk(KERN_NOTICE
-		       "myri10ge_alloc_small: small skb crossed 4KB boundary\n");
-		myri10ge_skb_cross_4k = 1;
-		dev_kfree_skb_any(skb);
-		skb = myri10ge_alloc_small_safe(dev, bytes);
-	}
-	return skb;
+	struct skb_frag_struct *skb_frags;
+
+	skb->len = skb->data_len = len;
+	skb->truesize = len + sizeof(struct sk_buff);
+	/* attach the page(s) */
+
+	skb_frags = skb_shinfo(skb)->frags;
+	while (len > 0) {
+		memcpy(skb_frags, rx_frags, sizeof(*skb_frags));
+		len -= rx_frags->size;
+		skb_frags++;
+		rx_frags++;
+		skb_shinfo(skb)->nr_frags++;
+	}
+
+	/* pskb_may_pull is not available in irq context, but
+	 * skb_pull() (for ether_pad and eth_type_trans()) requires
+	 * the beginning of the packet in skb_headlen(), move it
+	 * manually */
+	memcpy(skb->data, va, hlen);
+	skb_shinfo(skb)->frags[0].page_offset += hlen;
+	skb_shinfo(skb)->frags[0].size -= hlen;
+	skb->data_len -= hlen;
+	skb->tail += hlen;
+	skb_pull(skb, MXGEFW_PAD);
 }
 
-static inline int
-myri10ge_getbuf(struct myri10ge_rx_buf *rx, struct myri10ge_priv *mgp,
-		int bytes, int idx)
+static void
+myri10ge_alloc_rx_pages(struct myri10ge_priv *mgp, struct myri10ge_rx_buf *rx,
+			int bytes, int watchdog)
 {
-	struct net_device *dev = mgp->dev;
-	struct pci_dev *pdev = mgp->pdev;
-	struct sk_buff *skb;
-	dma_addr_t bus;
-	int len, retval = 0;
+	struct page *page;
+	int idx;
 
-	bytes += VLAN_HLEN;	/* account for 802.1q vlan tag */
+	if (unlikely(rx->watchdog_needed && !watchdog))
+		return;
 
-	if ((bytes + MXGEFW_PAD) > (4096 - 16) /* linux overhead */ )
-		skb = myri10ge_alloc_big(dev, bytes);
-	else if (myri10ge_skb_cross_4k)
-		skb = myri10ge_alloc_small_safe(dev, bytes);
-	else
-		skb = myri10ge_alloc_small(dev, bytes);
+	/* try to refill entire ring */
+	while (rx->fill_cnt != (rx->cnt + rx->mask + 1)) {
+		idx = rx->fill_cnt & rx->mask;
 
-	if (unlikely(skb == NULL)) {
-		rx->alloc_fail++;
-		retval = -ENOBUFS;
-		goto done;
-	}
-
-	/* set len so that it only covers the area we
-	 * need mapped for DMA */
-	len = bytes + MXGEFW_PAD;
-
-	bus = pci_map_single(pdev, skb->data, len, PCI_DMA_FROMDEVICE);
-	rx->info[idx].skb = skb;
-	pci_unmap_addr_set(&rx->info[idx], bus, bus);
-	pci_unmap_len_set(&rx->info[idx], len, len);
-	rx->shadow[idx].addr_low = htonl(MYRI10GE_LOWPART_TO_U32(bus));
-	rx->shadow[idx].addr_high = htonl(MYRI10GE_HIGHPART_TO_U32(bus));
-
-done:
-	/* copy 8 descriptors (64-bytes) to the mcp at a time */
-	if ((idx & 7) == 7) {
-		if (rx->wc_fifo == NULL)
-			myri10ge_submit_8rx(&rx->lanai[idx - 7],
-					    &rx->shadow[idx - 7]);
-		else {
-			mb();
-			myri10ge_pio_copy(rx->wc_fifo,
-					  &rx->shadow[idx - 7], 64);
+		if ((bytes < MYRI10GE_ALLOC_SIZE / 2) &&
+		    (rx->page_offset + bytes <= MYRI10GE_ALLOC_SIZE)) {
+			/* we can use part of previous page */
+			get_page(rx->page);
+		} else {
+			/* we need a new page */
+			page =
+			    alloc_pages(GFP_ATOMIC | __GFP_COMP,
+					MYRI10GE_ALLOC_ORDER);
+			if (unlikely(page == NULL)) {
+				if (rx->fill_cnt - rx->cnt < 16)
+					rx->watchdog_needed = 1;
+				return;
+			}
+			rx->page = page;
+			rx->page_offset = 0;
+			rx->bus = pci_map_page(mgp->pdev, page, 0,
+					       MYRI10GE_ALLOC_SIZE,
+					       PCI_DMA_FROMDEVICE);
+		}
+		rx->info[idx].page = rx->page;
+		rx->info[idx].page_offset = rx->page_offset;
+		/* note that this is the address of the start of the
+		 * page */
+		pci_unmap_addr_set(&rx->info[idx], bus, rx->bus);
+		rx->shadow[idx].addr_low =
+		    htonl(MYRI10GE_LOWPART_TO_U32(rx->bus) + rx->page_offset);
+		rx->shadow[idx].addr_high =
+		    htonl(MYRI10GE_HIGHPART_TO_U32(rx->bus));
+
+		/* start next packet on a cacheline boundary */
+		rx->page_offset += SKB_DATA_ALIGN(bytes);
+		rx->fill_cnt++;
+
+		/* copy 8 descriptors to the firmware at a time */
+		if ((idx & 7) == 7) {
+			if (rx->wc_fifo == NULL)
+				myri10ge_submit_8rx(&rx->lanai[idx - 7],
+						    &rx->shadow[idx - 7]);
+			else {
+				mb();
+				myri10ge_pio_copy(rx->wc_fifo,
+						  &rx->shadow[idx - 7], 64);
+			}
 		}
 	}
-	return retval;
 }
 
-static inline void myri10ge_vlan_ip_csum(struct sk_buff *skb, __wsum hw_csum)
+static inline void
+myri10ge_unmap_rx_page(struct pci_dev *pdev,
+		       struct myri10ge_rx_buffer_state *info, int bytes)
 {
-	struct vlan_hdr *vh = (struct vlan_hdr *)(skb->data);
-
-	if ((skb->protocol == htons(ETH_P_8021Q)) &&
-	    (vh->h_vlan_encapsulated_proto == htons(ETH_P_IP) ||
-	     vh->h_vlan_encapsulated_proto == htons(ETH_P_IPV6))) {
-		skb->csum = hw_csum;
-		skb->ip_summed = CHECKSUM_COMPLETE;
+	/* unmap the recvd page if we're the only or last user of it */
+	if (bytes >= MYRI10GE_ALLOC_SIZE / 2 ||
+	    (info->page_offset + 2 * bytes) > MYRI10GE_ALLOC_SIZE) {
+		pci_unmap_page(pdev, (pci_unmap_addr(info, bus)
+				      & ~(MYRI10GE_ALLOC_SIZE - 1)),
+			       MYRI10GE_ALLOC_SIZE, PCI_DMA_FROMDEVICE);
 	}
 }
 
-static inline unsigned long
+#define MYRI10GE_HLEN 64	/* The number of bytes to copy from a
+				 * page into an skb */
+
+static inline int
 myri10ge_rx_done(struct myri10ge_priv *mgp, struct myri10ge_rx_buf *rx,
 		 int bytes, int len, __wsum csum)
 {
-	dma_addr_t bus;
 	struct sk_buff *skb;
-	int idx, unmap_len;
+	struct skb_frag_struct rx_frags[MYRI10GE_MAX_FRAGS_PER_FRAME];
+	int i, idx, hlen, remainder;
+	struct pci_dev *pdev = mgp->pdev;
+	struct net_device *dev = mgp->dev;
+	u8 *va;
 
+	len += MXGEFW_PAD;
 	idx = rx->cnt & rx->mask;
-	rx->cnt++;
+	va = page_address(rx->info[idx].page) + rx->info[idx].page_offset;
+	prefetch(va);
+	/* Fill skb_frag_struct(s) with data from our receive */
+	for (i = 0, remainder = len; remainder > 0; i++) {
+		myri10ge_unmap_rx_page(pdev, &rx->info[idx], bytes);
+		rx_frags[i].page = rx->info[idx].page;
+		rx_frags[i].page_offset = rx->info[idx].page_offset;
+		if (remainder < MYRI10GE_ALLOC_SIZE)
+			rx_frags[i].size = remainder;
+		else
+			rx_frags[i].size = MYRI10GE_ALLOC_SIZE;
+		rx->cnt++;
+		idx = rx->cnt & rx->mask;
+		remainder -= MYRI10GE_ALLOC_SIZE;
+	}
+
+	hlen = MYRI10GE_HLEN > len ? len : MYRI10GE_HLEN;
 
-	/* save a pointer to the received skb */
-	skb = rx->info[idx].skb;
-	bus = pci_unmap_addr(&rx->info[idx], bus);
-	unmap_len = pci_unmap_len(&rx->info[idx], len);
+	/* allocate an skb to attach the page(s) to. */
 
-	/* try to replace the received skb */
-	if (myri10ge_getbuf(rx, mgp, bytes, idx)) {
-		/* drop the frame -- the old skbuf is re-cycled */
-		mgp->stats.rx_dropped += 1;
+	skb = netdev_alloc_skb(dev, MYRI10GE_HLEN + 16);
+	if (unlikely(skb == NULL)) {
+		mgp->stats.rx_dropped++;
+		do {
+			i--;
+			put_page(rx_frags[i].page);
+		} while (i != 0);
 		return 0;
 	}
 
-	/* unmap the recvd skb */
-	pci_unmap_single(mgp->pdev, bus, unmap_len, PCI_DMA_FROMDEVICE);
-
-	/* mcp implicitly skips 1st bytes so that packet is properly
-	 * aligned */
-	skb_reserve(skb, MXGEFW_PAD);
-
-	/* set the length of the frame */
-	skb_put(skb, len);
+	/* Attach the pages to the skb, and trim off any padding */
+	myri10ge_rx_skb_build(skb, va, rx_frags, len, hlen);
+	if (skb_shinfo(skb)->frags[0].size <= 0) {
+		put_page(skb_shinfo(skb)->frags[0].page);
+		skb_shinfo(skb)->nr_frags = 0;
+	}
+	skb->protocol = eth_type_trans(skb, dev);
+	skb->dev = dev;
 
-	skb->protocol = eth_type_trans(skb, mgp->dev);
 	if (mgp->csum_flag) {
 		if ((skb->protocol == htons(ETH_P_IP)) ||
 		    (skb->protocol == htons(ETH_P_IPV6))) {
@@ -1000,9 +995,8 @@ myri10ge_rx_done(struct myri10ge_priv *m
 		} else
 			myri10ge_vlan_ip_csum(skb, csum);
 	}
-
 	netif_receive_skb(skb);
-	mgp->dev->last_rx = jiffies;
+	dev->last_rx = jiffies;
 	return 1;
 }
 
@@ -1079,7 +1073,7 @@ static inline void myri10ge_clean_rx_don
 						 length, checksum);
 		else
 			rx_ok = myri10ge_rx_done(mgp, &mgp->rx_big,
-						 mgp->dev->mtu + ETH_HLEN,
+						 mgp->big_bytes,
 						 length, checksum);
 		rx_packets += rx_ok;
 		rx_bytes += rx_ok * (unsigned long)length;
@@ -1094,6 +1088,14 @@ static inline void myri10ge_clean_rx_don
 	rx_done->cnt = cnt;
 	mgp->stats.rx_packets += rx_packets;
 	mgp->stats.rx_bytes += rx_bytes;
+
+	/* restock receive rings if needed */
+	if (mgp->rx_small.fill_cnt - mgp->rx_small.cnt < myri10ge_fill_thresh)
+		myri10ge_alloc_rx_pages(mgp, &mgp->rx_small,
+					mgp->small_bytes + MXGEFW_PAD, 0);
+	if (mgp->rx_big.fill_cnt - mgp->rx_big.cnt < myri10ge_fill_thresh)
+		myri10ge_alloc_rx_pages(mgp, &mgp->rx_big, mgp->big_bytes, 0);
+
 }
 
 static inline void myri10ge_check_statblock(struct myri10ge_priv *mgp)
@@ -1484,56 +1486,48 @@ static int myri10ge_allocate_rings(struc
 		goto abort_with_rx_small_info;
 
 	/* Fill the receive rings */
+	mgp->rx_big.cnt = 0;
+	mgp->rx_small.cnt = 0;
+	mgp->rx_big.fill_cnt = 0;
+	mgp->rx_small.fill_cnt = 0;
+	mgp->rx_small.page_offset = MYRI10GE_ALLOC_SIZE;
+	mgp->rx_big.page_offset = MYRI10GE_ALLOC_SIZE;
+	mgp->rx_small.watchdog_needed = 0;
+	mgp->rx_big.watchdog_needed = 0;
+	myri10ge_alloc_rx_pages(mgp, &mgp->rx_small,
+				mgp->small_bytes + MXGEFW_PAD, 0);
 
-	for (i = 0; i <= mgp->rx_small.mask; i++) {
-		status = myri10ge_getbuf(&mgp->rx_small, mgp,
-					 mgp->small_bytes, i);
-		if (status) {
-			printk(KERN_ERR
-			       "myri10ge: %s: alloced only %d small bufs\n",
-			       dev->name, i);
-			goto abort_with_rx_small_ring;
-		}
+	if (mgp->rx_small.fill_cnt < mgp->rx_small.mask + 1) {
+		printk(KERN_ERR "myri10ge: %s: alloced only %d small bufs\n",
+		       dev->name, mgp->rx_small.fill_cnt);
+		goto abort_with_rx_small_ring;
 	}
 
-	for (i = 0; i <= mgp->rx_big.mask; i++) {
-		status =
-		    myri10ge_getbuf(&mgp->rx_big, mgp, dev->mtu + ETH_HLEN, i);
-		if (status) {
-			printk(KERN_ERR
-			       "myri10ge: %s: alloced only %d big bufs\n",
-			       dev->name, i);
-			goto abort_with_rx_big_ring;
-		}
+	myri10ge_alloc_rx_pages(mgp, &mgp->rx_big, mgp->big_bytes, 0);
+	if (mgp->rx_big.fill_cnt < mgp->rx_big.mask + 1) {
+		printk(KERN_ERR "myri10ge: %s: alloced only %d big bufs\n",
+		       dev->name, mgp->rx_big.fill_cnt);
+		goto abort_with_rx_big_ring;
 	}
 
 	return 0;
 
 abort_with_rx_big_ring:
-	for (i = 0; i <= mgp->rx_big.mask; i++) {
-		if (mgp->rx_big.info[i].skb != NULL)
-			dev_kfree_skb_any(mgp->rx_big.info[i].skb);
-		if (pci_unmap_len(&mgp->rx_big.info[i], len))
-			pci_unmap_single(mgp->pdev,
-					 pci_unmap_addr(&mgp->rx_big.info[i],
-							bus),
-					 pci_unmap_len(&mgp->rx_big.info[i],
-						       len),
-					 PCI_DMA_FROMDEVICE);
+	for (i = mgp->rx_big.cnt; i < mgp->rx_big.fill_cnt; i++) {
+		int idx = i & mgp->rx_big.mask;
+		myri10ge_unmap_rx_page(mgp->pdev, &mgp->rx_big.info[idx],
+				       mgp->big_bytes);
+		put_page(mgp->rx_big.info[idx].page);
 	}
 
 abort_with_rx_small_ring:
-	for (i = 0; i <= mgp->rx_small.mask; i++) {
-		if (mgp->rx_small.info[i].skb != NULL)
-			dev_kfree_skb_any(mgp->rx_small.info[i].skb);
-		if (pci_unmap_len(&mgp->rx_small.info[i], len))
-			pci_unmap_single(mgp->pdev,
-					 pci_unmap_addr(&mgp->rx_small.info[i],
-							bus),
-					 pci_unmap_len(&mgp->rx_small.info[i],
-						       len),
-					 PCI_DMA_FROMDEVICE);
+	for (i = mgp->rx_small.cnt; i < mgp->rx_small.fill_cnt; i++) {
+		int idx = i & mgp->rx_small.mask;
+		myri10ge_unmap_rx_page(mgp->pdev, &mgp->rx_small.info[idx],
+				       mgp->small_bytes + MXGEFW_PAD);
+		put_page(mgp->rx_small.info[idx].page);
 	}
+
 	kfree(mgp->rx_big.info);
 
 abort_with_rx_small_info:
@@ -1566,30 +1560,24 @@ static void myri10ge_free_rings(struct n
 
 	mgp = netdev_priv(dev);
 
-	for (i = 0; i <= mgp->rx_big.mask; i++) {
-		if (mgp->rx_big.info[i].skb != NULL)
-			dev_kfree_skb_any(mgp->rx_big.info[i].skb);
-		if (pci_unmap_len(&mgp->rx_big.info[i], len))
-			pci_unmap_single(mgp->pdev,
-					 pci_unmap_addr(&mgp->rx_big.info[i],
-							bus),
-					 pci_unmap_len(&mgp->rx_big.info[i],
-						       len),
-					 PCI_DMA_FROMDEVICE);
-	}
-
-	for (i = 0; i <= mgp->rx_small.mask; i++) {
-		if (mgp->rx_small.info[i].skb != NULL)
-			dev_kfree_skb_any(mgp->rx_small.info[i].skb);
-		if (pci_unmap_len(&mgp->rx_small.info[i], len))
-			pci_unmap_single(mgp->pdev,
-					 pci_unmap_addr(&mgp->rx_small.info[i],
-							bus),
-					 pci_unmap_len(&mgp->rx_small.info[i],
-						       len),
-					 PCI_DMA_FROMDEVICE);
+	for (i = mgp->rx_big.cnt; i < mgp->rx_big.fill_cnt; i++) {
+		idx = i & mgp->rx_big.mask;
+		if (i == mgp->rx_big.fill_cnt - 1)
+			mgp->rx_big.info[idx].page_offset = MYRI10GE_ALLOC_SIZE;
+		myri10ge_unmap_rx_page(mgp->pdev, &mgp->rx_big.info[idx],
+				       mgp->big_bytes);
+		put_page(mgp->rx_big.info[idx].page);
 	}
 
+	for (i = mgp->rx_small.cnt; i < mgp->rx_small.fill_cnt; i++) {
+		idx = i & mgp->rx_small.mask;
+		if (i == mgp->rx_small.fill_cnt - 1)
+			mgp->rx_small.info[idx].page_offset =
+			    MYRI10GE_ALLOC_SIZE;
+		myri10ge_unmap_rx_page(mgp->pdev, &mgp->rx_small.info[idx],
+				       mgp->small_bytes + MXGEFW_PAD);
+		put_page(mgp->rx_small.info[idx].page);
+	}
 	tx = &mgp->tx;
 	while (tx->done != tx->req) {
 		idx = tx->done & tx->mask;
@@ -1657,19 +1645,18 @@ static int myri10ge_open(struct net_devi
 	 */
 
 	if (dev->mtu <= ETH_DATA_LEN)
-		mgp->small_bytes = 128;	/* enough for a TCP header */
+		/* enough for a TCP header */
+		mgp->small_bytes = (128 > SMP_CACHE_BYTES)
+		    ? (128 - MXGEFW_PAD)
+		    : (SMP_CACHE_BYTES - MXGEFW_PAD);
 	else
-		mgp->small_bytes = ETH_FRAME_LEN;	/* enough for an ETH_DATA_LEN frame */
+		/* enough for a vlan encapsulated ETH_DATA_LEN frame */
+		mgp->small_bytes = VLAN_ETH_FRAME_LEN;
 
 	/* Override the small buffer size? */
 	if (myri10ge_small_bytes > 0)
 		mgp->small_bytes = myri10ge_small_bytes;
 
-	/* If the user sets an obscenely small MTU, adjust the small
-	 * bytes down to nearly nothing */
-	if (mgp->small_bytes >= (dev->mtu + ETH_HLEN))
-		mgp->small_bytes = 64;
-
 	/* get the lanai pointers to the send and receive rings */
 
 	status |= myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_OFFSET, &cmd, 0);
@@ -1705,17 +1692,23 @@ static int myri10ge_open(struct net_devi
 		mgp->rx_big.wc_fifo = NULL;
 	}
 
-	status = myri10ge_allocate_rings(dev);
-	if (status != 0)
-		goto abort_with_nothing;
-
 	/* Firmware needs the big buff size as a power of 2.  Lie and
 	 * tell him the buffer is larger, because we only use 1
 	 * buffer/pkt, and the mtu will prevent overruns.
 	 */
-	big_pow2 = dev->mtu + ETH_HLEN + MXGEFW_PAD;
-	while ((big_pow2 & (big_pow2 - 1)) != 0)
-		big_pow2++;
+	big_pow2 = dev->mtu + ETH_HLEN + VLAN_HLEN + MXGEFW_PAD;
+	if (big_pow2 < MYRI10GE_ALLOC_SIZE / 2) {
+		while ((big_pow2 & (big_pow2 - 1)) != 0)
+			big_pow2++;
+		mgp->big_bytes = dev->mtu + ETH_HLEN + VLAN_HLEN + MXGEFW_PAD;
+	} else {
+		big_pow2 = MYRI10GE_ALLOC_SIZE;
+		mgp->big_bytes = big_pow2;
+	}
+
+	status = myri10ge_allocate_rings(dev);
+	if (status != 0)
+		goto abort_with_nothing;
 
 	/* now give firmware buffers sizes, and MTU */
 	cmd.data0 = dev->mtu + ETH_HLEN + VLAN_HLEN;
@@ -2206,7 +2199,7 @@ static void myri10ge_set_multicast_list(
 	struct myri10ge_cmd cmd;
 	struct myri10ge_priv *mgp;
 	struct dev_mc_list *mc_list;
-	__be32 data[2] = {0, 0};
+	__be32 data[2] = { 0, 0 };
 	int err;
 
 	mgp = netdev_priv(dev);
@@ -2625,7 +2618,7 @@ static u32 myri10ge_read_reboot(struct m
 static void myri10ge_watchdog(struct work_struct *work)
 {
 	struct myri10ge_priv *mgp =
-		container_of(work, struct myri10ge_priv, watchdog_work);
+	    container_of(work, struct myri10ge_priv, watchdog_work);
 	u32 reboot;
 	int status;
 	u16 cmd, vendor;
@@ -2698,6 +2691,21 @@ static void myri10ge_watchdog_timer(unsi
 	struct myri10ge_priv *mgp;
 
 	mgp = (struct myri10ge_priv *)arg;
+
+	if (mgp->rx_small.watchdog_needed) {
+		myri10ge_alloc_rx_pages(mgp, &mgp->rx_small,
+					mgp->small_bytes + MXGEFW_PAD, 1);
+		if (mgp->rx_small.fill_cnt - mgp->rx_small.cnt >=
+		    myri10ge_fill_thresh)
+			mgp->rx_small.watchdog_needed = 0;
+	}
+	if (mgp->rx_big.watchdog_needed) {
+		myri10ge_alloc_rx_pages(mgp, &mgp->rx_big, mgp->big_bytes, 1);
+		if (mgp->rx_big.fill_cnt - mgp->rx_big.cnt >=
+		    myri10ge_fill_thresh)
+			mgp->rx_big.watchdog_needed = 0;
+	}
+
 	if (mgp->tx.req != mgp->tx.done &&
 	    mgp->tx.done == mgp->watchdog_tx_done &&
 	    mgp->watchdog_tx_req != mgp->watchdog_tx_done)
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index 9367c57..d2767e6 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -362,96 +362,6 @@ #define SMC_outsl(a, r, p, l)	writesl((a
 
 #define SMC_IRQ_FLAGS		(0)
 
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
 #else
 
 #define SMC_CAN_USE_8BIT	1
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 1f05511..8243150 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -194,9 +194,9 @@ static void enqueue(struct list_head *no
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(ugeth_lock, flags);
+	spin_lock_irqsave(&ugeth_lock, flags);
 	list_add_tail(node, lh);
-	spin_unlock_irqrestore(ugeth_lock, flags);
+	spin_unlock_irqrestore(&ugeth_lock, flags);
 }
 #endif /* CONFIG_UGETH_FILTERING */
 
@@ -204,14 +204,14 @@ static struct list_head *dequeue(struct 
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(ugeth_lock, flags);
+	spin_lock_irqsave(&ugeth_lock, flags);
 	if (!list_empty(lh)) {
 		struct list_head *node = lh->next;
 		list_del(node);
-		spin_unlock_irqrestore(ugeth_lock, flags);
+		spin_unlock_irqrestore(&ugeth_lock, flags);
 		return node;
 	} else {
-		spin_unlock_irqrestore(ugeth_lock, flags);
+		spin_unlock_irqrestore(&ugeth_lock, flags);
 		return NULL;
 	}
 }
@@ -1852,6 +1852,8 @@ static int init_phy(struct net_device *d
 	mii_info->mdio_read = &read_phy_reg;
 	mii_info->mdio_write = &write_phy_reg;
 
+	spin_lock_init(&mii_info->mdio_lock);
+
 	ugeth->mii_info = mii_info;
 
 	spin_lock_irq(&ugeth->lock);
