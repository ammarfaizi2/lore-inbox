Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUAJAlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbUAJAlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:41:31 -0500
Received: from fmr01.intel.com ([192.55.52.18]:60802 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264484AbUAJAlQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:41:16 -0500
Date: Fri, 9 Jan 2004 17:17:40 -0800 (PST)
From: "Feldman, Scott" <scott.feldman@intel.com>
X-X-Sender: scott.feldman@localhost.localdomain
Reply-To: "Feldman, Scott" <scott.feldman@intel.com>
To: Lennert Buytenhek <buytenh@gnu.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive
 load
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E01034D50AD@orsmsx402.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0401091715010.3118-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Lennert Buytenhek wrote:

> > Is NAPI enabled for this driver?  The interrupt behavior seems normal
> > for NAPI, but certainly the rest of the behavior does not...
> 
> Yes, NAPI was indeed enabled.
> 
> I 'went back' to 2.6.1-rc1 and that seems fine now.  Any patches you want
> me to try on top of 2.6.0-mm2?

Lennert, would you mind trying this patch to verify that problem is fixed?

The driver was indicating skbs to the stack before h/w was done with the 
DMA.  Not good.  That's what causes the corruption.  The stack free's the 
skb, and then h/w writes to it's data area.

-scott

-------------

--- net-drivers-2.5-exp/drivers/net/e100.c.orig	2004-01-09 16:41:42.000000000 -0800
+++ net-drivers-2.5-exp/drivers/net/e100.c	2004-01-09 16:44:59.000000000 -0800
@@ -143,7 +143,6 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/mii.h>
@@ -273,11 +272,13 @@
 };
 
 enum scb_stat_ack {
+	stat_ack_not_ours    = 0x00,
 	stat_ack_sw_gen      = 0x04,
 	stat_ack_rnr         = 0x10,
 	stat_ack_cu_idle     = 0x20,
 	stat_ack_frame_rx    = 0x40,
 	stat_ack_cu_cmd_done = 0x80,
+	stat_ack_not_present = 0xFF,
 	stat_ack_rx = (stat_ack_sw_gen | stat_ack_rnr | stat_ack_frame_rx),
 	stat_ack_tx = (stat_ack_cu_idle | stat_ack_cu_cmd_done),
 };
@@ -367,11 +368,10 @@
 	u16 size;
 };
 
-struct rx_list {
-	struct list_head list;
+struct rx {
+	struct rx *next, *prev;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
-	unsigned int length;
 };
 
 #if defined(__BIG_ENDIAN_BITFIELD)
@@ -492,11 +492,13 @@
 	u32 msg_enable				____cacheline_aligned;
 	struct net_device *netdev;
 	struct pci_dev *pdev;
-	
-	struct list_head rx_list_head		____cacheline_aligned;
-	struct rx_list *rx_list;
+
+	struct rx *rxs				____cacheline_aligned;
+	struct rx *rx_to_use;
+	struct rx *rx_to_clean;
 	struct rfd blank_rfd;
-	
+	int ru_running;
+
 	spinlock_t cb_lock			____cacheline_aligned;
 	spinlock_t cmd_lock;
 	struct csr *csr;
@@ -1350,57 +1352,46 @@
 
 static inline void e100_start_receiver(struct nic *nic)
 {
-	/* (Re)start RU if suspended or idle and RFA is fully allocated */
-	struct rx_list *curr =
-		list_entry(nic->rx_list_head.next, struct rx_list, list);
-	if(curr->skb) {
-		u8 status = readb(&nic->csr->scb.status);
-		if(unlikely((status & rus_mask) != rus_ready))
-			e100_exec_cmd(nic, ruc_start, curr->dma_addr);
+	/* (Re)start RU if suspended or idle and RFA is non-NULL */
+	if(!nic->ru_running && nic->rx_to_clean->skb) {
+		e100_exec_cmd(nic, ruc_start, nic->rx_to_clean->dma_addr);
+		nic->ru_running = 1;
 	}
 }
 
-static inline int e100_rx_alloc_skb(struct nic *nic, struct rx_list *curr)
+#define RFD_BUF_LEN (sizeof(struct rfd) + VLAN_ETH_FRAME_LEN)
+static inline int e100_rx_alloc_skb(struct nic *nic, struct rx *rx)
 {
 	unsigned int rx_offset = 2; /* u32 align protocol headers */
 
-	curr->dma_addr = 0;
-	curr->length = sizeof(struct rfd) + VLAN_ETH_FRAME_LEN;
-
-	if(!(curr->skb = dev_alloc_skb(curr->length + rx_offset)))
+	if(!(rx->skb = dev_alloc_skb(RFD_BUF_LEN + rx_offset)))
 		return -ENOMEM;
 
-	skb_reserve(curr->skb, rx_offset);
-	curr->skb->dev = nic->netdev;
-	curr->dma_addr = pci_map_single(nic->pdev, curr->skb->data,
-		curr->length, PCI_DMA_FROMDEVICE);
-
-	return 0;
-}
-
-static inline void e100_rx_rfa_add_tail(struct nic *nic, struct rx_list *curr)
-{
-	memcpy(curr->skb->data, &nic->blank_rfd, sizeof(struct rfd));
-	pci_dma_sync_single(nic->pdev, curr->dma_addr, 
-		sizeof(struct rfd), PCI_DMA_TODEVICE);
+	/* Align, init, and map the RFA. */
+	rx->skb->dev = nic->netdev;
+	skb_reserve(rx->skb, rx_offset);
+	memcpy(rx->skb->data, &nic->blank_rfd, sizeof(struct rfd));
+	rx->dma_addr = pci_map_single(nic->pdev, rx->skb->data,
+		RFD_BUF_LEN, PCI_DMA_FROMDEVICE);
 
-	if(likely(curr->list.prev != &nic->rx_list_head)) {
-		struct rx_list *prev = (struct rx_list *)curr->list.prev;
-		if(likely(prev->skb != NULL)) {
-			struct rfd *prev_rfd = (struct rfd *)prev->skb->data;
-			put_unaligned(cpu_to_le32(curr->dma_addr),
-				(u32 *)&prev_rfd->link);
-			prev_rfd->command = 0;
-			pci_dma_sync_single(nic->pdev, prev->dma_addr, 
-				sizeof(struct rfd), PCI_DMA_TODEVICE);
-		}
+	/* Link the RFD to end of RFA by linking previous RFD to
+	 * this one, and clearing EL bit of previous.  */
+	if(rx->prev->skb) {
+		struct rfd *prev_rfd = (struct rfd *)rx->prev->skb->data;
+		put_unaligned(cpu_to_le32(rx->dma_addr),
+			(u32 *)&prev_rfd->link);
+		prev_rfd->command &= ~cpu_to_le16(cb_el);
+		pci_dma_sync_single(nic->pdev, rx->prev->dma_addr,
+			sizeof(struct rfd), PCI_DMA_TODEVICE);
 	}
+
+	return 0;
 }
 
-static inline int e100_rx_indicate(struct nic *nic, struct rx_list *curr,
+static inline int e100_rx_indicate(struct nic *nic, struct rx *rx,
 	unsigned int *work_done, unsigned int work_to_do)
 {
-	struct sk_buff *skb = curr->skb;
+	struct sk_buff *skb = rx->skb;
 	struct rfd *rfd = (struct rfd *)skb->data;
 	u16 rfd_status, actual_size;
 
@@ -1408,7 +1399,7 @@
 		return -EAGAIN;
 
 	/* Need to sync before taking a peek at cb_complete bit */
-	pci_dma_sync_single(nic->pdev, curr->dma_addr,
+	pci_dma_sync_single(nic->pdev, rx->dma_addr,
 		sizeof(struct rfd), PCI_DMA_FROMDEVICE);
 	rfd_status = le16_to_cpu(rfd->status);
 
@@ -1420,15 +1411,15 @@
 
 	/* Get actual data size */
 	actual_size = le16_to_cpu(rfd->actual_size) & 0x3FFF;
-	if(unlikely(actual_size > curr->length - sizeof(struct rfd)))
-		actual_size = curr->length - sizeof(struct rfd);
+	if(unlikely(actual_size > RFD_BUF_LEN - sizeof(struct rfd)))
+		actual_size = RFD_BUF_LEN - sizeof(struct rfd);
 
 	/* Get data */
-	pci_dma_sync_single(nic->pdev, curr->dma_addr,
+	pci_dma_sync_single(nic->pdev, rx->dma_addr,
 		sizeof(struct rfd) + actual_size,
 		PCI_DMA_FROMDEVICE);
-	pci_unmap_single(nic->pdev, curr->dma_addr,
-		curr->length, PCI_DMA_FROMDEVICE);
+	pci_unmap_single(nic->pdev, rx->dma_addr,
+		RFD_BUF_LEN, PCI_DMA_FROMDEVICE);
 
 	/* Pull off the RFD and put the actual data (minus eth hdr) */
 	skb_reserve(skb, sizeof(struct rfd));
@@ -1452,37 +1443,26 @@
 			(*work_done)++;
 	}
 
-	curr->length = 0;
-	curr->dma_addr = 0;
-	curr->skb = NULL;
-	
+	rx->skb = NULL;
+
 	return 0;
 }
 
 static inline void e100_rx_clean(struct nic *nic, unsigned int *work_done,
 	unsigned int work_to_do)
 {
-	struct list_head *list, *tmp;
-	struct rx_list *curr;
+	struct rx *rx;
 
 	/* Indicate newly arrived packets */
-	list_for_each(list, &nic->rx_list_head) {
-		curr = list_entry(list, struct rx_list, list);
-		if(likely(curr->skb != NULL))
-			if(e100_rx_indicate(nic, curr, work_done, work_to_do))
-				break;
+	for(rx = nic->rx_to_clean; rx->skb; rx = nic->rx_to_clean = rx->next) {
+		if(e100_rx_indicate(nic, rx, work_done, work_to_do))
+			break; /* No more to clean */
 	}
 
 	/* Alloc new skbs to refill list */
-	list_for_each_safe(list, tmp, &nic->rx_list_head) {
-		curr = list_entry(list, struct rx_list, list);
-		if(unlikely(curr->skb != NULL))
-			break; /* List is full, done */
-		if(unlikely(e100_rx_alloc_skb(nic, curr)))
+	for(rx = nic->rx_to_use; !rx->skb; rx = nic->rx_to_use = rx->next) {
+		if(unlikely(e100_rx_alloc_skb(nic, rx)))
 			break; /* Better luck next time (see watchdog) */
-		list_del(&curr->list);
-		list_add_tail(&curr->list, &nic->rx_list_head);
-		e100_rx_rfa_add_tail(nic, curr);
 	}
 
 	e100_start_receiver(nic);
@@ -1490,44 +1470,47 @@
 
 static void e100_rx_clean_list(struct nic *nic)
 {
-	struct list_head *list;
-	
-	if(!nic->rx_list)
-		return;
+	struct rx *rx;
+	unsigned int i, count = nic->params.rfds.count;
 
-	list_for_each(list, &nic->rx_list_head) {
-		struct rx_list *curr = list_entry(list, 
-			struct rx_list, list);
-		if(curr->skb) {
-			pci_unmap_single(nic->pdev, curr->dma_addr,
-				curr->length, PCI_DMA_FROMDEVICE);
-			dev_kfree_skb(curr->skb);
+	if(nic->rxs) {
+		for(rx = nic->rxs, i = 0; i < count; rx++, i++) {
+			if(rx->skb) {
+				pci_unmap_single(nic->pdev, rx->dma_addr,
+					RFD_BUF_LEN, PCI_DMA_FROMDEVICE);
+				dev_kfree_skb(rx->skb);
+			}
 		}
+		kfree(nic->rxs);
+		nic->rxs = NULL;
 	}
 
-	kfree(nic->rx_list);
-	nic->rx_list = NULL;
+	nic->rx_to_use = nic->rx_to_clean = NULL;
+	nic->ru_running = 0;
 }
 
 static int e100_rx_alloc_list(struct nic *nic)
 {
-	struct rx_list *curr;
+	struct rx *rx;
 	unsigned int i, count = nic->params.rfds.count;
-	
-	INIT_LIST_HEAD(&nic->rx_list_head);
 
-	if(!(nic->rx_list = kmalloc(sizeof(struct rx_list)*count, GFP_ATOMIC)))
+	nic->rx_to_use = nic->rx_to_clean = NULL;
+
+	if(!(nic->rxs = kmalloc(sizeof(struct rx) * count, GFP_ATOMIC)))
 		return -ENOMEM;
+	memset(nic->rxs, 0, sizeof(struct rx) * count);
 
-	for(curr = nic->rx_list, i = 0; i < count; curr++, i++) {
-		if(e100_rx_alloc_skb(nic, curr)) {
+	for(rx = nic->rxs, i = 0; i < count; rx++, i++) {
+		rx->next = (i + 1 < count) ? rx + 1 : nic->rxs;
+		rx->prev = (i == 0) ? nic->rxs + count - 1 : rx - 1;
+		if(e100_rx_alloc_skb(nic, rx)) {
 			e100_rx_clean_list(nic);
 			return -ENOMEM;
 		}
-		list_add_tail(&curr->list, &nic->rx_list_head);
-		e100_rx_rfa_add_tail(nic, curr);
 	}
-	
+
+	nic->rx_to_use = nic->rx_to_clean = nic->rxs;
+
 	return 0;
 }
 
@@ -1539,13 +1522,16 @@
 
 	DPRINTK(INTR, DEBUG, "stat_ack = 0x%02X\n", stat_ack);
 
-	if(stat_ack == 0x00 ||	/* Not our interrupt */
-	   stat_ack == 0xFF)	/* Hardware is ejected (cardbus, hotswap)  */
+	if(stat_ack == stat_ack_not_ours ||	/* Not our interrupt */
+	   stat_ack == stat_ack_not_present)	/* Hardware is ejected */
 		return IRQ_NONE;
 
-	/* Ack interrupts */
+	/* Ack interrupt(s) */
 	writeb(stat_ack, &nic->csr->scb.stat_ack);
-	e100_write_flush(nic);
+
+	/* We hit Receive No Resource (RNR); restart RU after cleaning */
+	if(stat_ack & stat_ack_rnr)
+		nic->ru_running = 0;
 
 #ifdef CONFIG_E100_NAPI
 	e100_disable_irq(nic);
@@ -1664,7 +1650,7 @@
 
 static void e100_down(struct nic *nic)
 {
-	e100_disable_irq(nic);
+	e100_hw_reset(nic);
 	free_irq(nic->pdev->irq, nic->netdev);
 	del_timer_sync(&nic->watchdog);
 	netif_carrier_off(nic->netdev);
@@ -1687,7 +1673,6 @@
 {
 	int err;
 	struct sk_buff *skb;
-	struct rx_list *rx;
 
 	/* Use driver resources to perform internal MAC or PHY
 	 * loopback test.  A single packet is prepared and transmitted
@@ -1724,8 +1709,8 @@
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ / 100 + 1);
 
-	rx = list_entry(nic->rx_list_head.next, struct rx_list, list);
-	if(memcmp(rx->skb->data + sizeof(struct rfd), skb->data, ETH_DATA_LEN))
+	if(memcmp(nic->rx_to_clean->skb->data + sizeof(struct rfd),
+	   skb->data, ETH_DATA_LEN))
        		err = -EAGAIN;
 
 err_loopback_none:

