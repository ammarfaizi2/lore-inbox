Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291517AbSBMK2D>; Wed, 13 Feb 2002 05:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291519AbSBMK1y>; Wed, 13 Feb 2002 05:27:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291517AbSBMK1n>;
	Wed, 13 Feb 2002 05:27:43 -0500
Message-ID: <3C6A3F66.75D57124@zip.com.au>
Date: Wed, 13 Feb 2002 02:26:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        ralf@uni-koblenz.de
Subject: Re: [patch] printk and dma_addr_t
In-Reply-To: <20020213.013557.74564240.davem@redhat.com> from "David S. Miller" at Feb 13, 2002 01:35:57 AM <E16awZq-0004s4-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> So how do they modify the printf format rules in gcc ?

Good question.  It'd be nice for NIPQUAD and such.

Here's an alternative fix.  Less vomitous?

Sorry about sticking a prototype in types.h.  It needs to be
somewhere where all dma_addr_t users will see it, and where
dma_addr_t is already in scope.  Maybe there's a better place?



--- linux-2.4.18-pre9/include/linux/types.h	Tue Oct 23 21:59:05 2001
+++ linux-akpm/include/linux/types.h	Wed Feb 13 02:03:55 2002
@@ -127,4 +127,8 @@ struct ustat {
 	char			f_fpack[6];
 };
 
+#ifdef __KERNEL__
+char *form_dma_addr_t(char *buf, dma_addr_t a);
+#endif
+
 #endif /* _LINUX_TYPES_H */
--- linux-2.4.18-pre9/lib/vsprintf.c	Thu Oct 11 11:17:22 2001
+++ linux-akpm/lib/vsprintf.c	Wed Feb 13 02:24:31 2002
@@ -709,3 +709,20 @@ int sscanf(const char * buf, const char 
 	va_end(args);
 	return i;
 }
+
+/*
+ * dma_addr_t's have different sizes on different platforms,
+ * so we use this helper when we want to pass one to printk.
+ */
+char *form_dma_addr_t(char *buf, dma_addr_t a)
+{
+	char *fmt;	/* Funny code to prevent a printf warning */
+
+	if (sizeof(dma_addr_t) == sizeof(long))
+		fmt = "%lx";
+	else
+		fmt = "%Lx";
+
+	sprintf(buf, fmt, a);
+	return buf;
+}
--- linux-2.4.18-pre9/kernel/ksyms.c	Thu Feb  7 13:04:22 2002
+++ linux-akpm/kernel/ksyms.c	Wed Feb 13 02:20:50 2002
@@ -458,6 +458,7 @@ EXPORT_SYMBOL(sscanf);
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(vsscanf);
+EXPORT_SYMBOL(form_dma_addr_t);
 EXPORT_SYMBOL(kdevname);
 EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(cdevname);
--- linux-2.4.18-pre9/drivers/atm/idt77252.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/atm/idt77252.c	Wed Feb 13 02:20:50 2002
@@ -641,6 +641,7 @@ static struct scq_info *
 alloc_scq(struct idt77252_dev *card, int class)
 {
 	struct scq_info *scq;
+	char da_buf[33];
 
 	scq = (struct scq_info *) kmalloc(sizeof(struct scq_info), GFP_KERNEL);
 	if (!scq)
@@ -665,8 +666,9 @@ alloc_scq(struct idt77252_dev *card, int
 	skb_queue_head_init(&scq->transmit);
 	skb_queue_head_init(&scq->pending);
 
-	TXPRINTK("idt77252: SCQ: base 0x%p, next 0x%p, last 0x%p, paddr %08x\n",
-		 scq->base, scq->next, scq->last, scq->paddr);
+	TXPRINTK("idt77252: SCQ: base 0x%p, next 0x%p, last 0x%p, paddr %s\n",
+		 scq->base, scq->next, scq->last,
+		form_dma_addr_t(da_buf, scq->paddr));
 
 	return scq;
 }
--- linux-2.4.18-pre9/drivers/message/fusion/mptbase.c	Sun Sep 30 12:26:06 2001
+++ linux-akpm/drivers/message/fusion/mptbase.c	Wed Feb 13 02:20:50 2002
@@ -3186,6 +3186,7 @@ mpt_print_ioc_facts(MPT_ADAPTER *ioc, ch
 {
 	char expVer[32];
 	char iocName[16];
+	char da_buf[33];
 	int sz;
 	int y;
 	int p;
@@ -3217,8 +3218,9 @@ mpt_print_ioc_facts(MPT_ADAPTER *ioc, ch
 	y += sprintf(buffer+len+y, "  MaxChainDepth = 0x%02x frames\n", ioc->facts.MaxChainDepth);
 	y += sprintf(buffer+len+y, "  MinBlockSize = 0x%02x bytes\n", 4*ioc->facts.BlockSize);
 
-	y += sprintf(buffer+len+y, "  RequestFrames @ 0x%p (Dma @ 0x%08x)\n",
-					ioc->req_alloc, ioc->req_alloc_dma);
+	y += sprintf(buffer+len+y, "  RequestFrames @ 0x%p (Dma @ 0x%s)\n",
+					ioc->req_alloc,
+					form_dma_addr_t(da_buf, ioc->req_alloc_dma));
 	/*
 	 *  Rounding UP to nearest 4-kB boundary here...
 	 */
@@ -3230,8 +3232,9 @@ mpt_print_ioc_facts(MPT_ADAPTER *ioc, ch
 					4*ioc->facts.RequestFrameSize,
 					ioc->facts.GlobalCredits);
 
-	y += sprintf(buffer+len+y, "  ReplyFrames   @ 0x%p (Dma @ 0x%08x)\n",
-					ioc->reply_alloc, ioc->reply_alloc_dma);
+	y += sprintf(buffer+len+y, "  ReplyFrames   @ 0x%p (Dma @ 0x%s)\n",
+					ioc->reply_alloc,
+					form_dma_addr_t(da_buf, ioc->reply_alloc_dma));
 	sz = (ioc->reply_sz * ioc->reply_depth) + 128;
 	y += sprintf(buffer+len+y, "    {CurRepSz=%d} x {CurRepDepth=%d} = %d bytes ^= 0x%x\n",
 					ioc->reply_sz, ioc->reply_depth, ioc->reply_sz*ioc->reply_depth, sz);
--- linux-2.4.18-pre9/drivers/net/tokenring/tms380tr.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/drivers/net/tokenring/tms380tr.c	Wed Feb 13 02:20:50 2002
@@ -1428,6 +1428,7 @@ static int tms380tr_bringup_diags(struct
 static int tms380tr_init_adapter(struct net_device *dev)
 {
 	struct net_local *tp = (struct net_local *)dev->priv;
+	char da_buf[33];
 
 	const unsigned char SCB_Test[6] = {0x00, 0x00, 0xC1, 0xE2, 0xD4, 0x8B};
 	const unsigned char SSB_Test[8] = {0xFF, 0xFF, 0xD1, 0xD7,
@@ -1446,7 +1447,8 @@ static int tms380tr_init_adapter(struct 
 	if(tms380tr_debug > 3)
 	{
 		printk(KERN_INFO "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-		printk(KERN_INFO "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+		printk(KERN_INFO "%s: buffer (virt): %s\n", dev->name,
+			form_dma_addr_t(da_buf, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer));
 		printk(KERN_INFO "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
 		printk(KERN_INFO "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
 	}
--- linux-2.4.18-pre9/drivers/net/pcnet32.c	Thu Feb  7 13:04:20 2002
+++ linux-akpm/drivers/net/pcnet32.c	Wed Feb 13 02:22:55 2002
@@ -529,6 +529,7 @@ pcnet32_probe1(unsigned long ioaddr, uns
     char *chipname;
     struct net_device *dev;
     struct pcnet32_access *a = NULL;
+    char da_buf[33];
 
     /* reset the chip */
     pcnet32_dwio_reset(ioaddr);
@@ -711,7 +712,8 @@ pcnet32_probe1(unsigned long ioaddr, uns
     memset(lp, 0, sizeof(*lp));
     lp->dma_addr = lp_dma_addr;
     lp->pci_dev = pdev;
-    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x", lp, lp_dma_addr);
+    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%s",
+		lp, form_dma_addr_t(da_buf, lp_dma_addr));
 
     spin_lock_init(&lp->lock);
     
--- linux-2.4.18-pre9/drivers/net/yellowfin.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/net/yellowfin.c	Wed Feb 13 02:20:50 2002
@@ -1273,7 +1273,10 @@ static int yellowfin_close(struct net_de
 
 #if defined(__i386__)
 	if (yellowfin_debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n", yp->tx_ring_dma);
+		char da_buf[33];
+
+		printk("\n"KERN_DEBUG"  Tx ring at %s:\n",
+				form_dma_addr_t(da_buf, yp->tx_ring_dma));
 		for (i = 0; i < TX_RING_SIZE*2; i++)
 			printk(" %c #%d desc. %8.8x %8.8x %8.8x %8.8x.\n",
 				   inl(ioaddr + TxPtr) == (long)&yp->tx_ring[i] ? '>' : ' ',
@@ -1285,7 +1288,8 @@ static int yellowfin_close(struct net_de
 				   i, yp->tx_status[i].tx_cnt, yp->tx_status[i].tx_errs,
 				   yp->tx_status[i].total_tx_cnt, yp->tx_status[i].paused);
 
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n", yp->rx_ring_dma);
+		printk("\n"KERN_DEBUG "  Rx ring %s:\n",
+				form_dma_addr_t(da_buf, yp->rx_ring_dma));
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " %c #%d desc. %8.8x %8.8x %8.8x\n",
 				   inl(ioaddr + RxPtr) == (long)&yp->rx_ring[i] ? '>' : ' ',
--- linux-2.4.18-pre9/drivers/net/starfire.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/net/starfire.c	Wed Feb 13 02:20:50 2002
@@ -1911,15 +1911,17 @@ static int netdev_close(struct net_devic
 
 #ifdef __i386__
 	if (debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   np->tx_ring_dma);
+		char da_buf[33];
+
+		printk("\n"KERN_DEBUG"  Tx ring at %s:\n",
+			   form_dma_addr_t(da_buf, np->tx_ring_dma));
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
 			       i, le32_to_cpu(np->tx_ring[i].status),
 			       le32_to_cpu(np->tx_ring[i].first_addr),
 			       le32_to_cpu(np->tx_done_q[i].status));
-		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
-		       np->rx_ring_dma, np->rx_done_q);
+		printk(KERN_DEBUG "  Rx ring at %s -> %p:\n",
+		       form_dma_addr_t(da_buf, np->rx_ring_dma), np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
 				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",


-
