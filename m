Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291448AbSBMJYX>; Wed, 13 Feb 2002 04:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291453AbSBMJYO>; Wed, 13 Feb 2002 04:24:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34827 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291448AbSBMJYC>;
	Wed, 13 Feb 2002 04:24:02 -0500
Message-ID: <3C6A307B.E4E56D06@zip.com.au>
Date: Wed, 13 Feb 2002 01:23:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] printk and dma_addr_t, part 2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the files which require the DMA_ADDR_T_FMT treatment.

drivers/atm/idt77252.c
drivers/message/fusion/mptbase.c
drivers/net/tokenring/tms380tr.c
drivers/net/pcnet32.c
drivers/net/yellowfin.c
drivers/net/starfire.c


--- linux-2.4.18-pre9/drivers/atm/idt77252.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/atm/idt77252.c	Tue Feb 12 22:08:48 2002
@@ -665,8 +665,9 @@ alloc_scq(struct idt77252_dev *card, int
 	skb_queue_head_init(&scq->transmit);
 	skb_queue_head_init(&scq->pending);
 
-	TXPRINTK("idt77252: SCQ: base 0x%p, next 0x%p, last 0x%p, paddr %08x\n",
-		 scq->base, scq->next, scq->last, scq->paddr);
+	TXPRINTK("idt77252: SCQ: base 0x%p, next 0x%p, last 0x%p, paddr "
+			DMA_ADDR_T_FMT "\n",
+		scq->base, scq->next, scq->last, scq->paddr);
 
 	return scq;
 }
--- linux-2.4.18-pre9/drivers/message/fusion/mptbase.c	Sun Sep 30 12:26:06 2001
+++ linux-akpm/drivers/message/fusion/mptbase.c	Tue Feb 12 22:09:03 2002
@@ -3217,7 +3217,7 @@ mpt_print_ioc_facts(MPT_ADAPTER *ioc, ch
 	y += sprintf(buffer+len+y, "  MaxChainDepth = 0x%02x frames\n", ioc->facts.MaxChainDepth);
 	y += sprintf(buffer+len+y, "  MinBlockSize = 0x%02x bytes\n", 4*ioc->facts.BlockSize);
 
-	y += sprintf(buffer+len+y, "  RequestFrames @ 0x%p (Dma @ 0x%08x)\n",
+	y += sprintf(buffer+len+y, "  RequestFrames @ 0x%p (Dma @ 0x"DMA_ADDR_T_FMT")\n",
 					ioc->req_alloc, ioc->req_alloc_dma);
 	/*
 	 *  Rounding UP to nearest 4-kB boundary here...
@@ -3230,7 +3230,7 @@ mpt_print_ioc_facts(MPT_ADAPTER *ioc, ch
 					4*ioc->facts.RequestFrameSize,
 					ioc->facts.GlobalCredits);
 
-	y += sprintf(buffer+len+y, "  ReplyFrames   @ 0x%p (Dma @ 0x%08x)\n",
+	y += sprintf(buffer+len+y, "  ReplyFrames   @ 0x%p (Dma @ 0x"DMA_ADDR_T_FMT")\n",
 					ioc->reply_alloc, ioc->reply_alloc_dma);
 	sz = (ioc->reply_sz * ioc->reply_depth) + 128;
 	y += sprintf(buffer+len+y, "    {CurRepSz=%d} x {CurRepDepth=%d} = %d bytes ^= 0x%x\n",
--- linux-2.4.18-pre9/drivers/net/tokenring/tms380tr.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/drivers/net/tokenring/tms380tr.c	Tue Feb 12 22:09:13 2002
@@ -1446,7 +1446,9 @@ static int tms380tr_init_adapter(struct 
 	if(tms380tr_debug > 3)
 	{
 		printk(KERN_INFO "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-		printk(KERN_INFO "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+		printk(KERN_INFO "%s: buffer (virt): "DMA_ADDR_T_FMT"\n",
+			dev->name,
+			(long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
 		printk(KERN_INFO "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
 		printk(KERN_INFO "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
 	}
--- linux-2.4.18-pre9/drivers/net/pcnet32.c	Thu Feb  7 13:04:20 2002
+++ linux-akpm/drivers/net/pcnet32.c	Tue Feb 12 22:10:24 2002
@@ -711,7 +711,8 @@ pcnet32_probe1(unsigned long ioaddr, uns
     memset(lp, 0, sizeof(*lp));
     lp->dma_addr = lp_dma_addr;
     lp->pci_dev = pdev;
-    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x", lp, lp_dma_addr);
+    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr="DMA_ADDR_T_FMT,
+		lp, lp_dma_addr);
 
     spin_lock_init(&lp->lock);
     
--- linux-2.4.18-pre9/drivers/net/yellowfin.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/net/yellowfin.c	Tue Feb 12 22:11:16 2002
@@ -1273,7 +1273,8 @@ static int yellowfin_close(struct net_de
 
 #if defined(__i386__)
 	if (yellowfin_debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n", yp->tx_ring_dma);
+		printk("\n"KERN_DEBUG"  Tx ring at "DMA_ADDR_T_FMT":\n",
+				yp->tx_ring_dma);
 		for (i = 0; i < TX_RING_SIZE*2; i++)
 			printk(" %c #%d desc. %8.8x %8.8x %8.8x %8.8x.\n",
 				   inl(ioaddr + TxPtr) == (long)&yp->tx_ring[i] ? '>' : ' ',
@@ -1285,7 +1286,8 @@ static int yellowfin_close(struct net_de
 				   i, yp->tx_status[i].tx_cnt, yp->tx_status[i].tx_errs,
 				   yp->tx_status[i].total_tx_cnt, yp->tx_status[i].paused);
 
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n", yp->rx_ring_dma);
+		printk("\n"KERN_DEBUG "  Rx ring "DMA_ADDR_T_FMT":\n",
+				yp->rx_ring_dma);
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " %c #%d desc. %8.8x %8.8x %8.8x\n",
 				   inl(ioaddr + RxPtr) == (long)&yp->rx_ring[i] ? '>' : ' ',
--- linux-2.4.18-pre9/drivers/net/starfire.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/net/starfire.c	Tue Feb 12 22:12:47 2002
@@ -1911,19 +1911,20 @@ static int netdev_close(struct net_devic
 
 #ifdef __i386__
 	if (debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
+		printk("\n"KERN_DEBUG"  Tx ring at "DMA_ADDR_T_FMT":\n",
 			   np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
 			       i, le32_to_cpu(np->tx_ring[i].status),
 			       le32_to_cpu(np->tx_ring[i].first_addr),
 			       le32_to_cpu(np->tx_done_q[i].status));
-		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
+		printk(KERN_DEBUG "  Rx ring at "DMA_ADDR_T_FMT" -> %p:\n",
 		       np->rx_ring_dma, np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
 				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",
-				       i, le32_to_cpu(np->rx_ring[i].rxaddr), le32_to_cpu(np->rx_done_q[i].status));
+					i, le32_to_cpu(np->rx_ring[i].rxaddr),
+					le32_to_cpu(np->rx_done_q[i].status));
 		}
 	}
 #endif /* __i386__ debugging only */


-
