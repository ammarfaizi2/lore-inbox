Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSB0Byd>; Tue, 26 Feb 2002 20:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291406AbSB0ByP>; Tue, 26 Feb 2002 20:54:15 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:4560 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S291372AbSB0Bx5>;
	Tue, 26 Feb 2002 20:53:57 -0500
Date: Tue, 26 Feb 2002 17:53:53 -0800
To: Jaroslav Kysela <perex@suse.cz>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH 2.5.5] Conversion of hp100 to new PCI interface
Message-ID: <20020226175353.B18197@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020226174657.A18197@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020226174657.A18197@bougret.hpl.hp.com>; from jt on Tue, Feb 26, 2002 at 05:46:57PM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2002 at 05:46:57PM -0800, jt wrote:
> 	Hi,
> 
> 	I depend on hp100, so I had to fix it and replace all those
> virt_to_bus(). Only tested on a J2585B (PCI Busmaster). Other PCI and
> ISA cards are *not* busmaster, so should not be affected. Some EISA
> cards may be busmaster, but we would need to track down a tester...
> 	If the official maintainer doesn't have anything to
> add, it would be nice if it could find its way in the kernel...
> 	Have fun...
> 
> 	Jean

	As Jeff mention, probably better if I attach a patch !

	Jean

P.S. : Also : I've fixed basic IrDA in my tree...

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hp100.vb.diff"

diff -u -p linux/drivers/net/hp100_vb.c linux/drivers/net/hp100.c
--- linux/drivers/net/hp100_vb.c	Tue Feb 26 16:24:51 2002
+++ linux/drivers/net/hp100.c	Tue Feb 26 17:27:10 2002
@@ -83,8 +83,6 @@
 **
 */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #define HP100_DEFAULT_PRIORITY_TX 0
 
 #undef HP100_DEBUG
@@ -214,6 +212,7 @@ struct hp100_private {
 
 	u_int *page_vaddr;	/* Virtual address of allocated page */
 	u_int *page_vaddr_algn;	/* Aligned virtual address of allocated page */
+	dma_addr_t page_baddr;	/* Bus/Physical address of allocated page */
 	int rxrcommit;		/* # Rx PDLs commited to adapter */
 	int txrcommit;		/* # Tx PDLs commited to adapter */
 };
@@ -627,9 +626,20 @@ static int __init hp100_probe1(struct ne
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
@@ -773,10 +783,12 @@ static int __init hp100_probe1(struct ne
 	 * implemented/tested only with the lassen chip anyway... */
 	if (lp->mode == 1) {	/* busmaster */
 		/* Get physically continous memory for TX & RX PDLs    */
-		if ((lp->page_vaddr = kmalloc(MAX_RINGSIZE + 0x0f, GFP_KERNEL)) == NULL)
+		/* Conversion to new PCI API :
+		 * Pages are always aligned and zeroed, no need to it ourself.
+		 * Doc says should be OK for EISA bus as well - Jean II */
+		if ((lp->page_vaddr = pci_alloc_consistent(lp->pci_dev, MAX_RINGSIZE, &lp->page_baddr)) == NULL)
 			return -ENOMEM;
-		lp->page_vaddr_algn = ((u_int *) (((u_int) (lp->page_vaddr) + 0x0f) & ~0x0f));
-		memset(lp->page_vaddr, 0, MAX_RINGSIZE + 0x0f);
+		lp->page_vaddr_algn = lp->page_vaddr;
 
 #ifdef HP100_DEBUG_BM
 		printk("hp100: %s: Reserved DMA memory from 0x%x to 0x%x\n", dev->name, (u_int) lp->page_vaddr_algn, (u_int) lp->page_vaddr_algn + MAX_RINGSIZE);
@@ -1189,7 +1201,7 @@ static void hp100_init_pdls(struct net_d
 {
 	struct hp100_private *lp = (struct hp100_private *) dev->priv;
 	hp100_ring_t *ringptr;
-	u_int *pageptr;
+	u_int *pageptr;		/* Warning : increment by 4 - Jean II */
 	int i;
 
 #ifdef HP100_DEBUG_B
@@ -1245,8 +1257,12 @@ static int hp100_init_rxpdl(struct net_d
 		printk("hp100: %s: Init rxpdl: Unaligned pdlptr 0x%x.\n",
 		       dev->name, (unsigned) pdlptr);
 
+	/* Conversion to new PCI API :
+	 * The memory block we use, lp->page_vaddr, was DMA allocated via
+	 * pci_alloc_consistent(), so we just need to "retreive" the
+	 * original mapping to bus/phys address - Jean II */
 	ringptr->pdl = pdlptr + 1;
-	ringptr->pdl_paddr = virt_to_bus(pdlptr + 1);
+	ringptr->pdl_paddr = virt_to_phys(pdlptr + 1);
 	ringptr->skb = (void *) NULL;
 
 	/* 
@@ -1257,7 +1273,7 @@ static int hp100_init_rxpdl(struct net_d
 	 */
 	/* Note that pdlptr+1 and not pdlptr is the pointer to the PDH */
 
-	*(pdlptr + 2) = (u_int) virt_to_bus(pdlptr);	/* Address Frag 1 */
+	*(pdlptr + 2) = (u_int) virt_to_phys(pdlptr);	/* Address Frag 1 */
 	*(pdlptr + 3) = 4;	/* Length  Frag 1 */
 
 	return ((((MAX_RX_FRAG * 2 + 2) + 3) / 4) * 4);
@@ -1271,8 +1287,12 @@ static int hp100_init_txpdl(struct net_d
 	if (0 != (((unsigned) pdlptr) & 0xf))
 		printk("hp100: %s: Init txpdl: Unaligned pdlptr 0x%x.\n", dev->name, (unsigned) pdlptr);
 
+	/* Conversion to new PCI API :
+	 * The memory block we use, lp->page_vaddr, was DMA allocated via
+	 * pci_alloc_consistent(), so we just need to "retreive" the
+	 * original mapping to bus/phys address - Jean II */
 	ringptr->pdl = pdlptr;	/* +1; */
-	ringptr->pdl_paddr = virt_to_bus(pdlptr);	/* +1 */
+	ringptr->pdl_paddr = virt_to_phys(pdlptr);	/* +1 */
 	ringptr->skb = (void *) NULL;
 
 	return ((((MAX_TX_FRAG * 2 + 2) + 3) / 4) * 4);
@@ -1331,8 +1351,10 @@ static int hp100_build_rx_pdl(hp100_ring
 				     (unsigned int) ringptr->skb->data);
 #endif
 
+		/* Conversion to new PCI API : map skbuf data to PCI bus.
+		 * Doc says it's OK for EISA as well - Jean II */
 		ringptr->pdl[0] = 0x00020000;	/* Write PDH */
-		ringptr->pdl[3] = ((u_int) virt_to_bus(ringptr->skb->data));
+		ringptr->pdl[3] = ((u_int) pci_map_single(((struct hp100_private *) (dev->priv))->pci_dev, ringptr->skb->data, MAX_ETHER_SIZE, PCI_DMA_FROMDEVICE));
 		ringptr->pdl[4] = MAX_ETHER_SIZE;	/* Length of Data */
 
 #ifdef HP100_DEBUG_BM
@@ -1585,7 +1607,6 @@ static int hp100_start_xmit_bm(struct sk
 
 	ringptr->skb = skb;
 	ringptr->pdl[0] = ((1 << 16) | i);	/* PDH: 1 Fragment & length */
-	ringptr->pdl[1] = (u32) virt_to_bus(skb->data);	/* 1st Frag: Adr. of data */
 	if (lp->chip == HP100_CHIPID_SHASTA) {
 		/* TODO:Could someone who has the EISA card please check if this works? */
 		ringptr->pdl[2] = i;
@@ -1593,6 +1614,9 @@ static int hp100_start_xmit_bm(struct sk
 		/* In the PDL, don't use the padded size but the real packet size: */
 		ringptr->pdl[2] = skb->len;	/* 1st Frag: Length of frag */
 	}
+	/* Conversion to new PCI API : map skbuf data to PCI bus.
+	 * Doc says it's OK for EISA as well - Jean II */
+	ringptr->pdl[1] = ((u32) pci_map_single(lp->pci_dev, skb->data, ringptr->pdl[2], PCI_DMA_TODEVICE));	/* 1st Frag: Adr. of data */
 
 	/* Hand this PDL to the card. */
 	hp100_outl(ringptr->pdl_paddr, TX_PDA_L);	/* Low Prio. Queue */
@@ -1641,6 +1665,8 @@ static void hp100_clean_txring(struct ne
 				dev->name, (u_int) lp->txrhead->skb->data,
 				lp->txrcommit, hp100_inb(TX_PDL), donecount);
 #endif
+		/* Conversion to new PCI API : NOP */
+		pci_unmap_single(lp->pci_dev, (dma_addr_t) lp->txrhead->pdl[1], lp->txrhead->pdl[2], PCI_DMA_TODEVICE);
 		dev_kfree_skb_any(lp->txrhead->skb);
 		lp->txrhead->skb = (void *) NULL;
 		lp->txrhead = lp->txrhead->next;
@@ -1950,6 +1976,9 @@ static void hp100_rx_bm(struct net_devic
 		header = *(ptr->pdl - 1);
 		pkt_len = (header & HP100_PKT_LEN_MASK);
 
+		/* Conversion to new PCI API : NOP */
+		pci_unmap_single(lp->pci_dev, (dma_addr_t) ptr->pdl[3], MAX_ETHER_SIZE, PCI_DMA_FROMDEVICE);
+
 #ifdef HP100_DEBUG_BM
 		printk("hp100: %s: rx_bm: header@0x%x=0x%x length=%d, errors=0x%x, dest=0x%x\n",
 				dev->name, (u_int) (ptr->pdl - 1), (u_int) header,
@@ -2910,7 +2939,7 @@ static void release_dev(int i)
 	release_region(d->base_addr, HP100_REGION_SIZE);
 
 	if (p->mode == 1)	/* busmaster */
-		kfree(p->page_vaddr);
+		pci_free_consistent(p->pci_dev, MAX_RINGSIZE + 0x0f, p->page_vaddr, p->page_baddr);
 	if (p->mem_ptr_virt)
 		iounmap(p->mem_ptr_virt);
 	kfree(d->priv);

--EVF5PPMfhYS0aIcm--
