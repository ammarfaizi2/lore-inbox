Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310425AbSCLFk7>; Tue, 12 Mar 2002 00:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCLFkx>; Tue, 12 Mar 2002 00:40:53 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35133 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S310425AbSCLFkq>; Tue, 12 Mar 2002 00:40:46 -0500
Date: Tue, 12 Mar 2002 00:40:36 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: whitney@math.berkeley.edu, rgooch@ras.ucalgary.ca,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: [patch] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
Message-ID: <20020312004036.A3441@redhat.com>
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <20020310.180456.91344522.davem@redhat.com> <20020310212210.A27870@redhat.com> <20020310.183033.67792009.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020310.183033.67792009.davem@redhat.com>; from davem@redhat.com on Sun, Mar 10, 2002 at 06:30:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 06:30:33PM -0800, David S. Miller wrote:
> Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
> without NAPI, there is no reason other cards cannot go full speed as
> well.
> 
> NAPI is really only going to help with high packet rates not with
> thinks like raw bandwidth tests.

A day's tweaking later, and I'm getting 810mbit/s with netperf between 
two Athlons with default settings (1500 byte packets).  What I've found 
is that increasing the size of the RX/TX rings or the max sizes of the 
tcp r/wmem backlogs really slows things down, so I'm not doing that 
anymore.  The pair of P3s shows 262mbit/s (up from 67).

Interrupt mitigation is now pretty stupid, but it helped: the irq 
handler disables the rx interrupt and then triggers a tasklet to run 
through the rx ring.  The tasklet later enables rx interrupts again.  
More tweaking tomorrow...

Marcelo, please apply the patch below to the next 2.4 prepatch: it 
also has a fix for a tx hang problem, and a few other nasties.  Thanks!

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."


--- kernels/2.4/v2.4.19-pre2/drivers/net/ns83820.c	Thu Mar  7 16:40:00 2002
+++ ns-2.4.19-pre2/drivers/net/ns83820.c	Tue Mar 12 00:09:32 2002
@@ -1,7 +1,7 @@
-#define _VERSION "0.15"
+#define _VERSION "0.17"
 /* ns83820.c by Benjamin LaHaise <bcrl@redhat.com> with contributions.
  *
- * $Revision: 1.34.2.12 $
+ * $Revision: 1.34.2.14 $
  *
  * Copyright 2001 Benjamin LaHaise.
  * Copyright 2001 Red Hat.
@@ -51,6 +51,8 @@
  *				suppress duplicate link status messages
  *	20011117 	0.14 - ethtool GDRVINFO, GLINK support from jgarzik
  *	20011204 	0.15	get ppc (big endian) working
+ *	20011218	0.16	various cleanups
+ *	20020310	0.17	speedups
  *
  * Driver Overview
  * ===============
@@ -93,8 +95,8 @@
 #include <linux/in.h>	/* for IPPROTO_... */
 #include <linux/eeprom.h>
 #include <linux/compiler.h>
+#include <linux/prefetch.h>
 #include <linux/ethtool.h>
-//#include <linux/skbrefill.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -154,10 +156,16 @@
 #endif
 
 /* tunables */
-#define RX_BUF_SIZE	6144	/* 8192 */
-#define NR_RX_DESC	256
+#define RX_BUF_SIZE	1500	/* 8192 */
 
-#define NR_TX_DESC	256
+/* Must not exceed ~65000. */
+#define NR_RX_DESC	64
+#define NR_TX_DESC	64
+
+/* not tunable */
+#define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14)	/* rx/tx mac addr + type */
+
+#define MIN_TX_DESC_FREE	8
 
 /* register defines */
 #define CFGCS		0x04
@@ -408,7 +416,8 @@
 
 	struct sk_buff	*skbs[NR_RX_DESC];
 
-	unsigned	next_rx, next_empty;
+	u32		*next_rx_desc;
+	u16		next_rx, next_empty;
 
 	u32		*descs;
 	dma_addr_t	phy_descs;
@@ -423,6 +432,7 @@
 	struct pci_dev		*pci_dev;
 
 	struct rx_info		rx_info;
+	struct tasklet_struct	rx_tasklet;
 
 	unsigned		ihr;
 	struct tq_struct	tq_refill;
@@ -441,10 +451,11 @@
 	spinlock_t	tx_lock;
 
 	long		tx_idle;
-	u32		tx_done_idx;
-	u32		tx_idx;
-	volatile u32	tx_free_idx;	/* idx of free desc chain */
-	u32		tx_intr_idx;
+
+	u16		tx_done_idx;
+	u16		tx_idx;
+	volatile u16	tx_free_idx;	/* idx of free desc chain */
+	u16		tx_intr_idx;
 
 	struct sk_buff	*tx_skbs[NR_TX_DESC];
 
@@ -455,7 +466,7 @@
 
 //free = (tx_done_idx + NR_TX_DESC-2 - free_idx) % NR_TX_DESC
 #define start_tx_okay(dev)	\
-	(((NR_TX_DESC-2 + dev->tx_done_idx - dev->tx_free_idx) % NR_TX_DESC) > NR_TX_DESC/2)
+	(((NR_TX_DESC-2 + dev->tx_done_idx - dev->tx_free_idx) % NR_TX_DESC) > MIN_TX_DESC_FREE)
 
 
 /* Packet Receiver
@@ -509,7 +520,7 @@
 	next_empty = dev->rx_info.next_empty;
 
 	/* don't overrun last rx marker */
-	if (nr_rx_empty(dev) <= 2) {
+	if (unlikely(nr_rx_empty(dev) <= 2)) {
 		kfree_skb(skb);
 		return 1;
 	}
@@ -523,34 +534,39 @@
 #endif
 
 	sg = dev->rx_info.descs + (next_empty * DESC_SIZE);
-	if (dev->rx_info.skbs[next_empty])
+	if (unlikely(NULL != dev->rx_info.skbs[next_empty]))
 		BUG();
 	dev->rx_info.skbs[next_empty] = skb;
 
 	dev->rx_info.next_empty = (next_empty + 1) % NR_RX_DESC;
-	cmdsts = RX_BUF_SIZE | CMDSTS_INTR;
-	buf = pci_map_single(dev->pci_dev, skb->tail, RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
+	cmdsts = REAL_RX_BUF_SIZE | CMDSTS_INTR;
+	buf = pci_map_single(dev->pci_dev, skb->tail,
+			     REAL_RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
 	build_rx_desc(dev, sg, 0, buf, cmdsts, 0);
 	/* update link of previous rx */
-	if (next_empty != dev->rx_info.next_rx)
+	if (likely(next_empty != dev->rx_info.next_rx))
 		dev->rx_info.descs[((NR_RX_DESC + next_empty - 1) % NR_RX_DESC) * DESC_SIZE] = cpu_to_le32(dev->rx_info.phy_descs + (next_empty * DESC_SIZE * 4));
 
 	return 0;
 }
 
-static int rx_refill(struct ns83820 *dev, int gfp)
+static inline int rx_refill(struct ns83820 *dev, int gfp)
 {
 	unsigned i;
 	long flags = 0;
 
+	if (unlikely(nr_rx_empty(dev) <= 2))
+		return 0;
+
 	dprintk("rx_refill(%p)\n", dev);
 	if (gfp == GFP_ATOMIC)
 		spin_lock_irqsave(&dev->rx_info.lock, flags);
 	for (i=0; i<NR_RX_DESC; i++) {
 		struct sk_buff *skb;
 		long res;
-		skb = __dev_alloc_skb(RX_BUF_SIZE+16, gfp);
-		if (!skb)
+		/* extra 16 bytes for alignment */
+		skb = __dev_alloc_skb(REAL_RX_BUF_SIZE+16, gfp);
+		if (unlikely(!skb))
 			break;
 
 		res = (long)skb->tail & 0xf;
@@ -575,6 +591,12 @@
 	return i ? 0 : -ENOMEM;
 }
 
+static void FASTCALL(rx_refill_atomic(struct ns83820 *dev));
+static void rx_refill_atomic(struct ns83820 *dev)
+{
+	rx_refill(dev, GFP_ATOMIC);
+}
+
 /* REFILL */
 static inline void queue_refill(void *_dev)
 {
@@ -590,6 +612,7 @@
 	build_rx_desc(dev, dev->rx_info.descs + (DESC_SIZE * i), 0, 0, CMDSTS_OWN, 0);
 }
 
+static void FASTCALL(phy_intr(struct ns83820 *dev));
 static void phy_intr(struct ns83820 *dev)
 {
 	static char *speeds[] = { "10", "100", "1000", "1000(?)", "1000F" };
@@ -600,7 +623,6 @@
 	cfg = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
 
 	if (dev->CFG_cache & CFG_TBI_EN) {
-
 		/* we have an optical transceiver */
 		tbisr = readl(dev->base + TBISR);
 		tanar = readl(dev->base + TANAR);
@@ -646,20 +668,24 @@
 		new_cfg = dev->CFG_cache & ~(CFG_SB | CFG_MODE_1000 | CFG_SPDSTS);
 
 		if (cfg & CFG_SPDSTS1)
-			new_cfg |= CFG_MODE_1000 | CFG_SB;
+			new_cfg |= CFG_MODE_1000;
 		else
-			new_cfg &= ~CFG_MODE_1000 | CFG_SB;
+			new_cfg &= ~CFG_MODE_1000;
 
-		if ((cfg & CFG_LNKSTS) && ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
+		speed = ((cfg / CFG_SPDSTS0) & 3);
+		fullduplex = (cfg & CFG_DUPSTS);
+
+		if (fullduplex)
+			new_cfg |= CFG_SB;
+
+		if ((cfg & CFG_LNKSTS) &&
+		    ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
 			writel(new_cfg, dev->base + CFG);
 			dev->CFG_cache = new_cfg;
 		}
 
 		dev->CFG_cache &= ~CFG_SPDSTS;
 		dev->CFG_cache |= cfg & CFG_SPDSTS;
-
-		speed = ((cfg / CFG_SPDSTS0) & 3);
-		fullduplex = (cfg & CFG_DUPSTS);
 	}
 
 	newlinkstate = (cfg & CFG_LNKSTS) ? LINK_UP : LINK_DOWN;
@@ -690,6 +716,7 @@
 
 	dev->rx_info.idle = 1;
 	dev->rx_info.next_rx = 0;
+	dev->rx_info.next_rx_desc = dev->rx_info.descs;
 	dev->rx_info.next_empty = 0;
 
 	for (i=0; i<NR_RX_DESC; i++)
@@ -724,7 +751,7 @@
 		dev->IMR_cache |= ISR_RXDESC;
 		dev->IMR_cache |= ISR_RXIDLE;
 		dev->IMR_cache |= ISR_TXDESC;
-		//dev->IMR_cache |= ISR_TXIDLE;
+		dev->IMR_cache |= ISR_TXIDLE;
 
 		writel(dev->IMR_cache, dev->base + IMR);
 		writel(1, dev->base + IER);
@@ -770,6 +797,41 @@
 	}
 }
 
+/* I hate the network stack sometimes */
+#ifdef __i386__
+#define skb_mangle_for_davem(skb,len)	(skb)
+#else
+static inline struct sk_buff *skb_mangle_for_davem(struct sk_buff *skb, int len)
+{
+	tmp = __dev_alloc_skb(len+2, GFP_ATOMIC);
+	if (!tmp)
+		goto done;
+	tmp->dev = &dev->net_dev;
+	skb_reserve(tmp, 2);
+	memcpy(skb_put(tmp, len), skb->data, len);
+	kfree_skb(skb);
+	return tmp;
+}
+#endif
+
+static void FASTCALL(ns83820_rx_kick(struct ns83820 *dev));
+static void ns83820_rx_kick(struct ns83820 *dev)
+{
+	/*if (nr_rx_empty(dev) >= NR_RX_DESC/4)*/ {
+		if (dev->rx_info.up) {
+			rx_refill_atomic(dev);
+			kick_rx(dev);
+		}
+	}
+
+	if (dev->rx_info.up && nr_rx_empty(dev) > NR_RX_DESC*3/4)
+		schedule_task(&dev->tq_refill);
+	else
+		kick_rx(dev);
+	if (dev->rx_info.idle)
+		Dprintk("BAD\n");
+}
+
 /* rx_irq
  *	
  */
@@ -785,10 +847,10 @@
 	dprintk("rx_irq(%p)\n", dev);
 	dprintk("rxdp: %08x, descs: %08lx next_rx[%d]: %p next_empty[%d]: %p\n",
 		readl(dev->base + RXDP),
-		(dev->rx_info.phy_descs),
-		dev->rx_info.next_rx,
+		(long)(dev->rx_info.phy_descs),
+		(int)dev->rx_info.next_rx,
 		(dev->rx_info.descs + (DESC_SIZE * dev->rx_info.next_rx)),
-		dev->rx_info.next_empty,
+		(int)dev->rx_info.next_empty,
 		(dev->rx_info.descs + (DESC_SIZE * dev->rx_info.next_empty))
 		);
 
@@ -798,7 +860,7 @@
 
 	dprintk("walking descs\n");
 	next_rx = info->next_rx;
-	desc = info->descs + (DESC_SIZE * next_rx);
+	desc = info->next_rx_desc;
 	while ((CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[CMDSTS]))) &&
 	       (cmdsts != CMDSTS_OWN)) {
 		struct sk_buff *skb;
@@ -813,29 +875,17 @@
 		info->skbs[next_rx] = NULL;
 		info->next_rx = (next_rx + 1) % NR_RX_DESC;
 
-		barrier();
+		mb();
 		clear_rx_desc(dev, next_rx);
 
 		pci_unmap_single(dev->pci_dev, bufptr,
 				 RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
-		if (CMDSTS_OK & cmdsts) {
-#if 0 //ndef __i386__
-			struct sk_buff *tmp;
-#endif
+		if (likely(CMDSTS_OK & cmdsts)) {
 			int len = cmdsts & 0xffff;
-			if (!skb)
-				BUG();
 			skb_put(skb, len);
-#if 0 //ndef __i386__	/* I hate the network stack sometimes */
-			tmp = __dev_alloc_skb(RX_BUF_SIZE+16, GFP_ATOMIC);
-			if (!tmp)
-				goto done;
-			tmp->dev = &dev->net_dev;
-			skb_reserve(tmp, 2);
-			memcpy(skb_put(tmp, len), skb->data, len);
-			kfree_skb(skb);
-			skb = tmp;
-#endif
+			skb = skb_mangle_for_davem(skb, len);
+			if (unlikely(!skb))
+				goto netdev_mangle_me_harder_failed;
 			if (cmdsts & CMDSTS_DEST_MULTI)
 				dev->stats.multicast ++;
 			dev->stats.rx_packets ++;
@@ -846,11 +896,10 @@
 				skb->ip_summed = CHECKSUM_NONE;
 			}
 			skb->protocol = eth_type_trans(skb, &dev->net_dev);
-			if (NET_RX_DROP == netif_rx(skb))
+			if (NET_RX_DROP == netif_rx(skb)) {
+netdev_mangle_me_harder_failed:
 				dev->stats.rx_dropped ++;
-#if 0 //ndef __i386__
-		done:;
-#endif
+			}
 		} else {
 			kfree_skb(skb);
 		}
@@ -860,6 +909,7 @@
 		desc = info->descs + (DESC_SIZE * next_rx);
 	}
 	info->next_rx = next_rx;
+	info->next_rx_desc = info->descs + (DESC_SIZE * next_rx);
 
 out:
 	if (0 && !nr) {
@@ -869,6 +919,15 @@
 	spin_unlock_irqrestore(&info->lock, flags);
 }
 
+static void rx_action(unsigned long _dev)
+{
+	struct ns83820 *dev = (void *)_dev;
+	rx_irq(dev);
+	writel(0x002, dev->base + IHR);
+	writel(dev->IMR_cache | ISR_RXDESC, dev->base + IMR);
+	rx_irq(dev);
+	ns83820_rx_kick(dev);
+}
 
 /* Packet Transmit code
  */
@@ -879,7 +938,9 @@
 	writel(CR_TXE, dev->base + CR);
 }
 
-/* no spinlock needed on the transmit irq path as the interrupt handler is serialized */
+/* No spinlock needed on the transmit irq path as the interrupt handler is
+ * serialized.
+ */
 static void do_tx_done(struct ns83820 *dev)
 {
 	u32 cmdsts, tx_done_idx, *desc;
@@ -917,7 +978,7 @@
 		tx_done_idx = (tx_done_idx + 1) % NR_TX_DESC;
 		dev->tx_done_idx = tx_done_idx;
 		desc[CMDSTS] = cpu_to_le32(0);
-		barrier();
+		mb();
 		desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
 	}
 
@@ -952,7 +1013,6 @@
  * while trying to track down a bug in either the zero copy code or
  * the tx fifo (hence the MAX_FRAG_LEN).
  */
-#define MAX_FRAG_LEN	8192	/* disabled for now */
 static int ns83820_hard_start_xmit(struct sk_buff *skb, struct net_device *_dev)
 {
 	struct ns83820 *dev = (struct ns83820 *)_dev;
@@ -970,9 +1030,9 @@
 
 	nr_frags =  skb_shinfo(skb)->nr_frags;
 again:
-	if (__builtin_expect(dev->CFG_cache & CFG_LNKSTS, 0)) {
+	if (unlikely(dev->CFG_cache & CFG_LNKSTS)) {
 		netif_stop_queue(&dev->net_dev);
-		if (__builtin_expect(dev->CFG_cache & CFG_LNKSTS, 0))
+		if (unlikely(dev->CFG_cache & CFG_LNKSTS))
 			return 1;
 		netif_start_queue(&dev->net_dev);
 	}
@@ -981,7 +1041,7 @@
 	tx_done_idx = dev->tx_done_idx;
 	nr_free = (tx_done_idx + NR_TX_DESC-2 - free_idx) % NR_TX_DESC;
 	nr_free -= 1;
-	if ((nr_free <= nr_frags) || (nr_free <= 8192 / MAX_FRAG_LEN)) {
+	if (nr_free <= nr_frags) {
 		dprintk("stop_queue - not enough(%p)\n", dev);
 		netif_stop_queue(&dev->net_dev);
 
@@ -996,11 +1056,11 @@
 
 	if (free_idx == dev->tx_intr_idx) {
 		do_intr = 1;
-		dev->tx_intr_idx = (dev->tx_intr_idx + NR_TX_DESC/2) % NR_TX_DESC;
+		dev->tx_intr_idx = (dev->tx_intr_idx + NR_TX_DESC/4) % NR_TX_DESC;
 	}
 
 	nr_free -= nr_frags;
-	if (nr_free < 1) {
+	if (nr_free < MIN_TX_DESC_FREE) {
 		dprintk("stop_queue - last entry(%p)\n", dev);
 		netif_stop_queue(&dev->net_dev);
 		stopped = 1;
@@ -1028,14 +1088,6 @@
 	for (;;) {
 		volatile u32 *desc = dev->tx_descs + (free_idx * DESC_SIZE);
 		u32 residue = 0;
-#if 0
-		if (len > MAX_FRAG_LEN) {
-			residue = len;
-			/* align the start address of the next fragment */
-			len = MAX_FRAG_LEN;
-			residue -= len;
-		}
-#endif
 
 		dprintk("frag[%3u]: %4u @ 0x%08Lx\n", free_idx, len,
 			(unsigned long long)buf);
@@ -1084,6 +1136,7 @@
 {
 	u8 *base = dev->base;
 
+	/* the DP83820 will freeze counters, so we need to read all of them */
 	dev->stats.rx_errors		+= readl(base + 0x60) & 0xffff;
 	dev->stats.rx_crc_errors	+= readl(base + 0x64) & 0xffff;
 	dev->stats.rx_missed_errors	+= readl(base + 0x68) & 0xffff;
@@ -1162,54 +1215,54 @@
 	}
 }
 
+static void ns83820_mib_isr(struct ns83820 *dev)
+{
+	spin_lock(&dev->misc_lock);
+	ns83820_update_stats(dev);
+	spin_unlock(&dev->misc_lock);
+}
+
 static void ns83820_irq(int foo, void *data, struct pt_regs *regs)
 {
 	struct ns83820 *dev = data;
-	int count = 0;
 	u32 isr;
 	dprintk("ns83820_irq(%p)\n", dev);
 
 	dev->ihr = 0;
 
-	while (count++ < 32 && (isr = readl(dev->base + ISR))) {
-		dprintk("irq: %08x\n", isr);
-
-		if (isr & ~(ISR_PHY | ISR_RXDESC | ISR_RXEARLY | ISR_RXOK | ISR_RXERR | ISR_TXIDLE | ISR_TXOK | ISR_TXDESC))
-			Dprintk("odd isr? 0x%08x\n", isr);
-
-	if ((ISR_RXEARLY | ISR_RXIDLE | ISR_RXORN | ISR_RXDESC | ISR_RXOK | ISR_RXERR) & isr) {
- 		if (ISR_RXIDLE & isr) {
-			dev->rx_info.idle = 1;
-			Dprintk("oh dear, we are idle\n");
-		}
+	isr = readl(dev->base + ISR);
+	dprintk("irq: %08x\n", isr);
 
-		if ((ISR_RXDESC) & isr) {
-			rx_irq(dev);
-			writel(4, dev->base + IHR);
-		}
-
-		if (nr_rx_empty(dev) >= NR_RX_DESC/4) {
-			if (dev->rx_info.up) {
-				rx_refill(dev, GFP_ATOMIC);
-				kick_rx(dev);
-			}
-		}
+#ifdef DEBUG
+	if (isr & ~(ISR_PHY | ISR_RXDESC | ISR_RXEARLY | ISR_RXOK | ISR_RXERR | ISR_TXIDLE | ISR_TXOK | ISR_TXDESC))
+		Dprintk("odd isr? 0x%08x\n", isr);
+#endif
 
-		if (dev->rx_info.up && nr_rx_empty(dev) > NR_RX_DESC*3/4)
-			schedule_task(&dev->tq_refill);
-		else
-			kick_rx(dev);
-		if (dev->rx_info.idle)
-			Dprintk("BAD\n");
+	if (ISR_RXIDLE & isr) {
+		dev->rx_info.idle = 1;
+		Dprintk("oh dear, we are idle\n");
+		ns83820_rx_kick(dev);
+	}
+
+	if ((ISR_RXDESC | ISR_RXOK) & isr) {
+		prefetch(dev->rx_info.next_rx_desc);
+		writel(dev->IMR_cache & ~(ISR_RXDESC | ISR_RXOK), dev->base + IMR);
+		tasklet_schedule(&dev->rx_tasklet);
+		//rx_irq(dev);
+		//writel(4, dev->base + IHR);
 	}
 
+	if ((ISR_RXIDLE | ISR_RXORN | ISR_RXDESC | ISR_RXOK | ISR_RXERR) & isr)
+		ns83820_rx_kick(dev);
+
 	if (unlikely(ISR_RXSOVR & isr)) {
-		Dprintk("overrun: rxsovr\n");
-		dev->stats.rx_over_errors ++;
+		//printk("overrun: rxsovr\n");
+		dev->stats.rx_fifo_errors ++;
 	}
+
 	if (unlikely(ISR_RXORN & isr)) {
-		Dprintk("overrun: rxorn\n");
-		dev->stats.rx_over_errors ++;
+		//printk("overrun: rxorn\n");
+		dev->stats.rx_fifo_errors ++;
 	}
 
 	if ((ISR_RXRCMP & isr) && dev->rx_info.up)
@@ -1241,15 +1294,11 @@
 	if ((ISR_TXDESC | ISR_TXIDLE) & isr)
 		do_tx_done(dev);
 
-	if (ISR_MIB & isr) {
-		spin_lock(&dev->misc_lock);
-		ns83820_update_stats(dev);
-		spin_unlock(&dev->misc_lock);
-	}
+	if (unlikely(ISR_MIB & isr))
+		ns83820_mib_isr(dev);
 
-	if (ISR_PHY & isr)
+	if (unlikely(ISR_PHY & isr))
 		phy_intr(dev);
-	}
 
 #if 0	/* Still working on the interrupt mitigation strategy */
 	if (dev->ihr)
@@ -1412,6 +1461,7 @@
 	dev->net_dev.owner = THIS_MODULE;
 
 	PREPARE_TQUEUE(&dev->tq_refill, queue_refill, dev);
+	tasklet_init(&dev->rx_tasklet, rx_action, (unsigned long)dev);
 
 	err = pci_enable_device(pci_dev);
 	if (err) {
@@ -1430,8 +1480,9 @@
 	if (!dev->base || !dev->tx_descs || !dev->rx_info.descs)
 		goto out_disable;
 
-	dprintk("%p: %08lx  %p: %08lx\n", dev->tx_descs, dev->tx_phy_descs,
-		dev->rx_info.descs, dev->rx_info.phy_descs);
+	dprintk("%p: %08lx  %p: %08lx\n",
+		dev->tx_descs, (long)dev->tx_phy_descs,
+		dev->rx_info.descs, (long)dev->rx_info.phy_descs);
 	/* disable interrupts */
 	writel(0, dev->base + IMR);
 	writel(0, dev->base + IER);
@@ -1484,14 +1535,14 @@
 	dev->CFG_cache = readl(dev->base + CFG);
 
 	if ((dev->CFG_cache & CFG_PCI64_DET)) {
-		printk("%s: enabling 64 bit PCI addressing.\n",
+		printk("%s: detected 64 bit PCI data bus.\n",
 			dev->net_dev.name);
-		dev->CFG_cache |= CFG_T64ADDR | CFG_DATA64_EN;
-#if defined(USE_64BIT_ADDR)
-		dev->net_dev.features |= NETIF_F_HIGHDMA;
-#endif
+		/*dev->CFG_cache |= CFG_DATA64_EN;*/
+		if (!(dev->CFG_cache & CFG_DATA64_EN))
+			printk("%s: EEPROM did not enable 64 bit bus.  Disabled.\n",
+				dev->net_dev.name);
 	} else
-		dev->CFG_cache &= ~(CFG_T64ADDR | CFG_DATA64_EN);
+		dev->CFG_cache &= ~(CFG_DATA64_EN);
 
 	dev->CFG_cache &= (CFG_TBI_EN  | CFG_MRM_DIS   | CFG_MWI_DIS |
 			   CFG_T64ADDR | CFG_DATA64_EN | CFG_EXT_125 |
@@ -1528,8 +1579,12 @@
 	writel(dev->CFG_cache, dev->base + CFG);
 	dprintk("CFG: %08x\n", dev->CFG_cache);
 
+#if 1	/* Huh?  This sets the PCI latency register.  Should be done via 
+	 * the PCI layer.  FIXME.
+	 */
 	if (readl(dev->base + SRR))
 		writel(readl(dev->base+0x20c) | 0xfe00, dev->base + 0x20c);
+#endif
 
 	/* Note!  The DMA burst size interacts with packet
 	 * transmission, such that the largest packet that
@@ -1543,13 +1598,15 @@
 	/* Flush the interrupt holdoff timer */
 	writel(0x000, dev->base + IHR);
 	writel(0x100, dev->base + IHR);
+	writel(0x000, dev->base + IHR);
 
 	/* Set Rx to full duplex, don't accept runt, errored, long or length
-	 * range errored packets.  Set MXDMA to 7 => 512 word burst
+	 * range errored packets.  Set MXDMA to 0 => 1024 word burst
 	 */
 	writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
+		| RXCFG_STRIPCRC
 		| RXCFG_ALP
-		| RXCFG_MXDMA | 0, dev->base + RXCFG);
+		| (RXCFG_MXDMA0 * 0) | 0, dev->base + RXCFG);
 
 	/* Disable priority queueing */
 	writel(0, dev->base + PQCR);
@@ -1576,7 +1633,11 @@
 	dev->net_dev.features |= NETIF_F_SG;
 	dev->net_dev.features |= NETIF_F_IP_CSUM;
 #if defined(USE_64BIT_ADDR) || defined(CONFIG_HIGHMEM4G)
-	dev->net_dev.features |= NETIF_F_HIGHDMA;
+	if ((dev->CFG_cache & CFG_T64ADDR)) {
+		printk(KERN_INFO "%s: using 64 bit addressing.\n",
+			dev->net_dev.name);
+		dev->net_dev.features |= NETIF_F_HIGHDMA;
+	}
 #endif
 
 	printk(KERN_INFO "%s: ns83820 v" VERSION ": DP83820 v%u.%u: %02x:%02x:%02x:%02x:%02x:%02x io=0x%08lx irq=%d f=%s\n",
@@ -1587,7 +1648,7 @@
 		dev->net_dev.dev_addr[2], dev->net_dev.dev_addr[3],
 		dev->net_dev.dev_addr[4], dev->net_dev.dev_addr[5],
 		addr, pci_dev->irq,
-		(dev->net_dev.features & NETIF_F_HIGHDMA) ? "sg" : "h,sg"
+		(dev->net_dev.features & NETIF_F_HIGHDMA) ? "h,sg" : "sg"
 		);
 
 	return 0;
