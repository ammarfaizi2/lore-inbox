Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTFJTsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFJTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:48:38 -0400
Received: from palrel11.hp.com ([156.153.255.246]:5525 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262185AbTFJTrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:47:48 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.14617.25302.441894@napali.hpl.hp.com>
Date: Tue, 10 Jun 2003 13:01:29 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <20030607.001140.08328499.davem@redhat.com>
References: <200306062013.h56KDcLe026713@napali.hpl.hp.com>
	<20030606.234401.104035537.davem@redhat.com>
	<16097.36514.763047.738847@napali.hpl.hp.com>
	<20030607.001140.08328499.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 07 Jun 2003 00:11:40 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  >>    From: David Mosberger <davidm@napali.hpl.hp.com> Date: Sat, 7
  >> Jun 2003 00:05:06 -0700

  >>    Isn't the proper fix to (a) get a new buffer, (b) create a
  >> mapping for the new buffer, (c) destroy the mapping for the old
  >> buffer.  That should guarantee a different bus address, no matter
  >> what the DMA-mapping implementation.

  > I suppose this would work, fell free to code this up for the tg3
  > driver for me because I certainly lack the time to do this.

How about the attached patch?

The non-PCI_DMA_BUS_IS_PHYS code should work already, because it
creates the new mapping before destroying the old one(s).

The patch has been compiled-tested but not runtime-tested: I can't
trigger the bug on ia64, because there, the end of the 4GB space is
reserved for firmware purposes, so we'll never have available memory
near address 0xffffdcc0.

The performance impact should be negligible, as the probability of
hitting the bug case should be vanishingly small.

	--david

===== drivers/net/tg3.c 1.68 vs edited =====
--- 1.68/drivers/net/tg3.c	Wed Apr 23 20:02:11 2003
+++ edited/drivers/net/tg3.c	Tue Jun 10 12:53:15 2003
@@ -2234,73 +2234,17 @@
 	schedule_work(&tp->reset_task);
 }
 
-#if !PCI_DMA_BUS_IS_PHYS
-static void tg3_set_txd_addr(struct tg3 *tp, int entry, dma_addr_t mapping)
-{
-	if (tp->tg3_flags & TG3_FLAG_HOST_TXDS) {
-		struct tg3_tx_buffer_desc *txd = &tp->tx_ring[entry];
-
-		txd->addr_hi = ((u64) mapping >> 32);
-		txd->addr_lo = ((u64) mapping & 0xffffffff);
-	} else {
-		unsigned long txd;
-
-		txd = (tp->regs +
-		       NIC_SRAM_WIN_BASE +
-		       NIC_SRAM_TX_BUFFER_DESC);
-		txd += (entry * TXD_SIZE);
-
-		if (sizeof(dma_addr_t) != sizeof(u32))
-			writel(((u64) mapping >> 32),
-			       txd + TXD_ADDR + TG3_64BIT_REG_HIGH);
-
-		writel(((u64) mapping & 0xffffffff),
-		       txd + TXD_ADDR + TG3_64BIT_REG_LOW);
-	}
-}
-#endif
-
 static void tg3_set_txd(struct tg3 *, int, dma_addr_t, int, u32, u32);
 
 static int tigon3_4gb_hwbug_workaround(struct tg3 *tp, struct sk_buff *skb,
 				       u32 guilty_entry, int guilty_len,
 				       u32 last_plus_one, u32 *start, u32 mss)
 {
+	struct sk_buff *new_skb = skb_copy(skb, GFP_ATOMIC);
 	dma_addr_t new_addr;
 	u32 entry = *start;
 	int i;
 
-#if !PCI_DMA_BUS_IS_PHYS
-	/* IOMMU, just map the guilty area again which is guaranteed to
-	 * use different addresses.
-	 */
-
-	i = 0;
-	while (entry != guilty_entry) {
-		entry = NEXT_TX(entry);
-		i++;
-	}
-	if (i == 0) {
-		new_addr = pci_map_single(tp->pdev, skb->data, guilty_len,
-					  PCI_DMA_TODEVICE);
-	} else {
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
-
-		new_addr = pci_map_page(tp->pdev,
-					frag->page, frag->page_offset,
-					guilty_len, PCI_DMA_TODEVICE);
-	}
-	pci_unmap_single(tp->pdev, pci_unmap_addr(&tp->tx_buffers[guilty_entry],
-						  mapping),
-			 guilty_len, PCI_DMA_TODEVICE);
-	tg3_set_txd_addr(tp, guilty_entry, new_addr);
-	pci_unmap_addr_set(&tp->tx_buffers[guilty_entry], mapping,
-			   new_addr);
-	*start = last_plus_one;
-#else
-	/* Oh well, no IOMMU, have to allocate a whole new SKB. */
-	struct sk_buff *new_skb = skb_copy(skb, GFP_ATOMIC);
-
 	if (!new_skb) {
 		dev_kfree_skb(skb);
 		return -1;
@@ -2337,7 +2281,6 @@
 	}
 
 	dev_kfree_skb(skb);
-#endif
 
 	return 0;
 }
