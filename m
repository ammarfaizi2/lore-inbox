Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292533AbSCDUHM>; Mon, 4 Mar 2002 15:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCDUHE>; Mon, 4 Mar 2002 15:07:04 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5598 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292533AbSCDUG5>;
	Mon, 4 Mar 2002 15:06:57 -0500
Date: Mon, 4 Mar 2002 12:06:50 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] Conversion of hp100 to new PCI interface
Message-ID: <20020304120650.A32203@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020226174657.A18197@bougret.hpl.hp.com> <20020226175353.B18197@bougret.hpl.hp.com> <3C7C4043.893429A9@mandrakesoft.com> <20020226182405.A18274@bougret.hpl.hp.com> <3C7D87AD.A9A25027@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D87AD.A9A25027@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 27, 2002 at 08:28:13PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2002 at 08:28:13PM -0500, Jeff Garzik wrote:
> If you just wanted to redo the patch storing the pci_alloc_mapping
> mapping values in struct hp100_private, the patch is otherwise ok...

	Sorry, was busy. Still need to go through my IrDA patches, but
here is the hp100 patch "the right way". Patch against 2.5.6-pre1,
tested on J2585B.
	Have fun...

	Jean

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hp100.vb2.diff"

diff -u -p linux/drivers/net/hp100_vb.c linux/drivers/net/hp100.c
--- linux/drivers/net/hp100_vb.c	Tue Feb 26 16:24:51 2002
+++ linux/drivers/net/hp100.c	Mon Mar  4 12:03:23 2002
@@ -83,8 +83,6 @@
 **
 */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #define HP100_DEFAULT_PRIORITY_TX 0
 
 #undef HP100_DEBUG
@@ -212,8 +210,8 @@ struct hp100_private {
 	hp100_ring_t rxring[MAX_RX_PDL];
 	hp100_ring_t txring[MAX_TX_PDL];
 
-	u_int *page_vaddr;	/* Virtual address of allocated page */
 	u_int *page_vaddr_algn;	/* Aligned virtual address of allocated page */
+	u_long whatever_offset;	/* Offset to bus/phys/dma address */
 	int rxrcommit;		/* # Rx PDLs commited to adapter */
 	int txrcommit;		/* # Tx PDLs commited to adapter */
 };
@@ -350,6 +348,18 @@ static void hp100_clean_txring(struct ne
 static void hp100_RegisterDump(struct net_device *dev);
 #endif
 
+/* Conversion to new PCI API :
+ * Convert an address in a kernel buffer to a bus/phys/dma address.
+ * This work *only* for memory fragments part of lp->page_vaddr,
+ * because it was properly DMA allocated via pci_alloc_consistent(),
+ * so we just need to "retreive" the original mapping to bus/phys/dma
+ * address - Jean II */
+static inline dma_addr_t virt_to_whatever(struct net_device *dev, u32 * ptr)
+{
+  return ((u_long) ptr) +
+    ((struct hp100_private *) (dev->priv))->whatever_offset;
+}
+
 /* TODO: This function should not really be needed in a good design... */
 static void wait(void)
 {
@@ -627,9 +637,20 @@ static int __init hp100_probe1(struct ne
 			local_mode = 3;
 		} else if (chip == HP100_CHIPID_LASSEN &&
 			   (lsw & (HP100_BM_WRITE | HP100_BM_READ)) == (HP100_BM_WRITE | HP100_BM_READ)) {
+			/* Conversion to new PCI API :
+			 * I don't have the doc, but I assume that the card
+			 * can map the full 32bit address space.
+			 * Also, we can have EISA Busmaster cards (not tested),
+			 * so beware !!! - Jean II */
+			if((bus == HP100_BUS_PCI) &&
+			   (pci_set_dma_mask(pci_dev, 0xffffffff))) {
+				/* Gracefully fallback to shared memory */
+				goto busmasterfail;
+			}
 			printk("hp100: %s: Busmaster mode enabled.\n", dev->name);
 			hp100_outw(HP100_MEM_EN | HP100_IO_EN | HP100_RESET_LB, OPTION_LSW);
 		} else {
+		busmasterfail:
 #ifdef HP100_DEBUG
 			printk("hp100: %s: Card not configured for BM or BM not supported with this card.\n", dev->name);
 			printk("hp100: %s: Trying shared memory mode.\n", dev->name);
@@ -772,11 +793,14 @@ static int __init hp100_probe1(struct ne
 	 * in the cards shared memory area. But currently, busmaster has been
 	 * implemented/tested only with the lassen chip anyway... */
 	if (lp->mode == 1) {	/* busmaster */
+		dma_addr_t page_baddr;
 		/* Get physically continous memory for TX & RX PDLs    */
-		if ((lp->page_vaddr = kmalloc(MAX_RINGSIZE + 0x0f, GFP_KERNEL)) == NULL)
+		/* Conversion to new PCI API :
+		 * Pages are always aligned and zeroed, no need to it ourself.
+		 * Doc says should be OK for EISA bus as well - Jean II */
+		if ((lp->page_vaddr_algn = pci_alloc_consistent(lp->pci_dev, MAX_RINGSIZE, &page_baddr)) == NULL)
 			return -ENOMEM;
-		lp->page_vaddr_algn = ((u_int *) (((u_int) (lp->page_vaddr) + 0x0f) & ~0x0f));
-		memset(lp->page_vaddr, 0, MAX_RINGSIZE + 0x0f);
+		lp->whatever_offset = ((u_long) page_baddr) - ((u_long) lp->page_vaddr_algn);
 
 #ifdef HP100_DEBUG_BM
 		printk("hp100: %s: Reserved DMA memory from 0x%x to 0x%x\n", dev->name, (u_int) lp->page_vaddr_algn, (u_int) lp->page_vaddr_algn + MAX_RINGSIZE);
@@ -1189,7 +1213,7 @@ static void hp100_init_pdls(struct net_d
 {
 	struct hp100_private *lp = (struct hp100_private *) dev->priv;
 	hp100_ring_t *ringptr;
-	u_int *pageptr;
+	u_int *pageptr;		/* Warning : increment by 4 - Jean II */
 	int i;
 
 #ifdef HP100_DEBUG_B
@@ -1246,7 +1270,7 @@ static int hp100_init_rxpdl(struct net_d
 		       dev->name, (unsigned) pdlptr);
 
 	ringptr->pdl = pdlptr + 1;
-	ringptr->pdl_paddr = virt_to_bus(pdlptr + 1);
+	ringptr->pdl_paddr = virt_to_whatever(dev, pdlptr + 1);
 	ringptr->skb = (void *) NULL;
 
 	/* 
@@ -1257,7 +1281,7 @@ static int hp100_init_rxpdl(struct net_d
 	 */
 	/* Note that pdlptr+1 and not pdlptr is the pointer to the PDH */
 
-	*(pdlptr + 2) = (u_int) virt_to_bus(pdlptr);	/* Address Frag 1 */
+	*(pdlptr + 2) = (u_int) virt_to_whatever(dev, pdlptr);	/* Address Frag 1 */
 	*(pdlptr + 3) = 4;	/* Length  Frag 1 */
 
 	return ((((MAX_RX_FRAG * 2 + 2) + 3) / 4) * 4);
@@ -1272,7 +1296,7 @@ static int hp100_init_txpdl(struct net_d
 		printk("hp100: %s: Init txpdl: Unaligned pdlptr 0x%x.\n", dev->name, (unsigned) pdlptr);
 
 	ringptr->pdl = pdlptr;	/* +1; */
-	ringptr->pdl_paddr = virt_to_bus(pdlptr);	/* +1 */
+	ringptr->pdl_paddr = virt_to_whatever(dev, pdlptr);	/* +1 */
 	ringptr->skb = (void *) NULL;
 
 	return ((((MAX_TX_FRAG * 2 + 2) + 3) / 4) * 4);
@@ -1331,8 +1355,10 @@ static int hp100_build_rx_pdl(hp100_ring
 				     (unsigned int) ringptr->skb->data);
 #endif
 
+		/* Conversion to new PCI API : map skbuf data to PCI bus.
+		 * Doc says it's OK for EISA as well - Jean II */
 		ringptr->pdl[0] = 0x00020000;	/* Write PDH */
-		ringptr->pdl[3] = ((u_int) virt_to_bus(ringptr->skb->data));
+		ringptr->pdl[3] = ((u_int) pci_map_single(((struct hp100_private *) (dev->priv))->pci_dev, ringptr->skb->data, MAX_ETHER_SIZE, PCI_DMA_FROMDEVICE));
 		ringptr->pdl[4] = MAX_ETHER_SIZE;	/* Length of Data */
 
 #ifdef HP100_DEBUG_BM
@@ -1585,7 +1611,6 @@ static int hp100_start_xmit_bm(struct sk
 
 	ringptr->skb = skb;
 	ringptr->pdl[0] = ((1 << 16) | i);	/* PDH: 1 Fragment & length */
-	ringptr->pdl[1] = (u32) virt_to_bus(skb->data);	/* 1st Frag: Adr. of data */
 	if (lp->chip == HP100_CHIPID_SHASTA) {
 		/* TODO:Could someone who has the EISA card please check if this works? */
 		ringptr->pdl[2] = i;
@@ -1593,6 +1618,9 @@ static int hp100_start_xmit_bm(struct sk
 		/* In the PDL, don't use the padded size but the real packet size: */
 		ringptr->pdl[2] = skb->len;	/* 1st Frag: Length of frag */
 	}
+	/* Conversion to new PCI API : map skbuf data to PCI bus.
+	 * Doc says it's OK for EISA as well - Jean II */
+	ringptr->pdl[1] = ((u32) pci_map_single(lp->pci_dev, skb->data, ringptr->pdl[2], PCI_DMA_TODEVICE));	/* 1st Frag: Adr. of data */
 
 	/* Hand this PDL to the card. */
 	hp100_outl(ringptr->pdl_paddr, TX_PDA_L);	/* Low Prio. Queue */
@@ -1641,6 +1669,8 @@ static void hp100_clean_txring(struct ne
 				dev->name, (u_int) lp->txrhead->skb->data,
 				lp->txrcommit, hp100_inb(TX_PDL), donecount);
 #endif
+		/* Conversion to new PCI API : NOP */
+		pci_unmap_single(lp->pci_dev, (dma_addr_t) lp->txrhead->pdl[1], lp->txrhead->pdl[2], PCI_DMA_TODEVICE);
 		dev_kfree_skb_any(lp->txrhead->skb);
 		lp->txrhead->skb = (void *) NULL;
 		lp->txrhead = lp->txrhead->next;
@@ -1950,6 +1980,9 @@ static void hp100_rx_bm(struct net_devic
 		header = *(ptr->pdl - 1);
 		pkt_len = (header & HP100_PKT_LEN_MASK);
 
+		/* Conversion to new PCI API : NOP */
+		pci_unmap_single(lp->pci_dev, (dma_addr_t) ptr->pdl[3], MAX_ETHER_SIZE, PCI_DMA_FROMDEVICE);
+
 #ifdef HP100_DEBUG_BM
 		printk("hp100: %s: rx_bm: header@0x%x=0x%x length=%d, errors=0x%x, dest=0x%x\n",
 				dev->name, (u_int) (ptr->pdl - 1), (u_int) header,
@@ -2910,7 +2943,7 @@ static void release_dev(int i)
 	release_region(d->base_addr, HP100_REGION_SIZE);
 
 	if (p->mode == 1)	/* busmaster */
-		kfree(p->page_vaddr);
+		pci_free_consistent(p->pci_dev, MAX_RINGSIZE + 0x0f, p->page_vaddr_algn, virt_to_whatever(d, p->page_vaddr_algn));
 	if (p->mem_ptr_virt)
 		iounmap(p->mem_ptr_virt);
 	kfree(d->priv);

--r5Pyd7+fXNt84Ff3--
