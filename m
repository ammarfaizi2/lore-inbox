Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSFKBx2>; Mon, 10 Jun 2002 21:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSFKBx1>; Mon, 10 Jun 2002 21:53:27 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:37623 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316614AbSFKBxX>; Mon, 10 Jun 2002 21:53:23 -0400
Date: Mon, 10 Jun 2002 21:53:24 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] ns83820 v0.18 update
Message-ID: <20020610215324.D13225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in ns83820.c in conjunction with the pci 
dma fix and allows zero copy tx from highmem to function again.  
It also removes the cruft from the pre-pci highmem days to bring 
the driver into compliance with the pci dma mapping api.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.4/v2.4.19-pre10-ns83820-0.18.diff
diff -urN v2.4.19-pre10/drivers/net/ns83820.c ns83820-v2.4.19-pre10/drivers/net/ns83820.c
--- v2.4.19-pre10/drivers/net/ns83820.c	Thu Jun  6 20:10:02 2002
+++ ns83820-v2.4.19-pre10/drivers/net/ns83820.c	Mon Jun 10 21:50:27 2002
@@ -1,10 +1,12 @@
-#define _VERSION "0.17"
-/* ns83820.c by Benjamin LaHaise <bcrl@redhat.com> with contributions.
+#define _VERSION "0.18"
+/* ns83820.c by Benjamin LaHaise with contributions.
  *
- * $Revision: 1.34.2.14 $
+ * Questions/comments/discussion to linux-ns83820@kvack.org.
+ *
+ * $Revision: 1.34.2.16 $
  *
  * Copyright 2001 Benjamin LaHaise.
- * Copyright 2001 Red Hat.
+ * Copyright 2001, 2002 Red Hat.
  *
  * Mmmm, chocolate vanilla mocha...
  *
@@ -53,6 +55,8 @@
  *	20011204 	0.15	get ppc (big endian) working
  *	20011218	0.16	various cleanups
  *	20020310	0.17	speedups
+ *	20020610	0.18 -	actually use the pci dma api for highmem
+ *			     -	remove pci latency register fiddling
  *
  * Driver Overview
  * ===============
@@ -105,54 +109,16 @@
 #undef Dprintk
 #define	Dprintk			dprintk
 
-#ifdef CONFIG_HIGHMEM64G
-#define USE_64BIT_ADDR	"+"
-#elif defined(__ia64__)
+#if defined(CONFIG_HIGHMEM64G) || defined(__ia64__)
 #define USE_64BIT_ADDR	"+"
 #endif
 
-/* Tell davem to fix the pci dma api.  Grrr. */
-/* stolen from acenic.c */
-#if 0 //def CONFIG_HIGHMEM
-#if defined(CONFIG_X86)
-#define DMAADDR_OFFSET  0
-#if defined(CONFIG_HIGHMEM64G)
-typedef u64 dmaaddr_high_t;
-#else
-typedef u32 dmaaddr_high_t;
-#endif
-#elif defined(CONFIG_PPC)
-#define DMAADDR_OFFSET PCI_DRAM_OFFSET
-typedef unsigned long dmaaddr_high_t;
-#endif
-
-static inline dmaaddr_high_t
-pci_map_single_high(struct pci_dev *hwdev, struct page *page,
-		    int offset, size_t size, int dir)
-{
-	u64 phys;
-	phys = page - mem_map;
-	phys <<= PAGE_SHIFT;
-	phys += offset;
-	phys += DMAADDR_OFFSET;
-	return phys;
-}
-#else
-
-typedef unsigned long dmaaddr_high_t;
-
-static inline dmaaddr_high_t
-pci_map_single_high(struct pci_dev *hwdev, struct page *page,
-		    int offset, size_t size, int dir)
-{
-	return pci_map_single(hwdev, page_address(page) + offset, size, dir);
-}
-#endif
-
 #if defined(USE_64BIT_ADDR)
 #define	VERSION	_VERSION USE_64BIT_ADDR
+#define TRY_DAC	1
 #else
 #define	VERSION	_VERSION
+#define TRY_DAC	0
 #endif
 
 /* tunables */
@@ -384,13 +350,22 @@
 } while(0)
 
 #ifdef USE_64BIT_ADDR
-typedef u64	hw_addr_t;
+#define HW_ADDR_LEN	8
+#define desc_addr_set(desc, addr)				\
+	do {							\
+		u64 __addr = (addr);				\
+		desc[BUFPTR] = cpu_to_le32(__addr);		\
+		desc[BUFPTR+1] = cpu_to_le32(__addr >> 32);	\
+	} while(0)
+#define desc_addr_get(desc)					\
+		(((u64)le32_to_cpu(desc[BUFPTR+1]) << 32)	\
+		     | le32_to_cpu(desc[BUFPTR]))
 #else
-typedef u32	hw_addr_t;
+#define HW_ADDR_LEN	4
+#define desc_addr_set(desc, addr)	(desc[BUFPTR] = cpu_to_le32(addr))
+#define desc_addr_get(desc)		(le32_to_cpu(desc[BUFPTR]))
 #endif
 
-#define HW_ADDR_LEN	(sizeof(hw_addr_t))
-
 #define LINK		0
 #define BUFPTR		(LINK + HW_ADDR_LEN/4)
 #define CMDSTS		(BUFPTR + HW_ADDR_LEN/4)
@@ -402,6 +377,7 @@
 #define CMDSTS_INTR	0x20000000
 #define CMDSTS_ERR	0x10000000
 #define CMDSTS_OK	0x08000000
+#define CMDSTS_LEN_MASK	0x0000ffff
 
 #define CMDSTS_DEST_MASK	0x01800000
 #define CMDSTS_DEST_SELF	0x00800000
@@ -515,7 +491,7 @@
 	unsigned next_empty;
 	u32 cmdsts;
 	u32 *sg;
-	hw_addr_t buf;
+	dma_addr_t buf;
 
 	next_empty = dev->rx_info.next_empty;
 
@@ -848,7 +824,7 @@
 	       (cmdsts != CMDSTS_OWN)) {
 		struct sk_buff *skb;
 		u32 extsts = le32_to_cpu(desc[EXTSTS]);
-		dmaaddr_high_t bufptr = le32_to_cpu(desc[BUFPTR]);
+		dma_addr_t bufptr = desc_addr_get(desc);
 
 		dprintk("cmdsts: %08x\n", cmdsts);
 		dprintk("link: %08x\n", cpu_to_le32(desc[LINK]));
@@ -936,6 +912,8 @@
 	while ((tx_done_idx != dev->tx_free_idx) &&
 	       !(CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[CMDSTS]))) ) {
 		struct sk_buff *skb;
+		unsigned len;
+		dma_addr_t addr;
 
 		if (cmdsts & CMDSTS_ERR)
 			dev->stats.tx_errors ++;
@@ -949,13 +927,20 @@
 		skb = dev->tx_skbs[tx_done_idx];
 		dev->tx_skbs[tx_done_idx] = NULL;
 		dprintk("done(%p)\n", skb);
+
+		len = cmdsts & CMDSTS_LEN_MASK;
+		addr = desc_addr_get(desc);
 		if (skb) {
 			pci_unmap_single(dev->pci_dev,
-					le32_to_cpu(desc[BUFPTR]),
-					skb->len,
+					addr,
+					len,
 					PCI_DMA_TODEVICE);
 			dev_kfree_skb_irq(skb);
-		}
+		} else
+			pci_unmap_page(dev->pci_dev, 
+					addr,
+					len,
+					PCI_DMA_TODEVICE);
 
 		tx_done_idx = (tx_done_idx + 1) % NR_TX_DESC;
 		dev->tx_done_idx = tx_done_idx;
@@ -1001,7 +986,7 @@
 	u32 free_idx, cmdsts, extsts;
 	int nr_free, nr_frags;
 	unsigned tx_done_idx;
-	dmaaddr_high_t buf;
+	dma_addr_t buf;
 	unsigned len;
 	skb_frag_t *frag;
 	int stopped = 0;
@@ -1075,7 +1060,7 @@
 			(unsigned long long)buf);
 		free_idx = (free_idx + 1) % NR_TX_DESC;
 		desc[LINK] = cpu_to_le32(dev->tx_phy_descs + (free_idx * DESC_SIZE * 4));
-		desc[BUFPTR] = cpu_to_le32(buf);
+		desc_addr_set(desc, buf);
 		desc[EXTSTS] = cpu_to_le32(extsts);
 
 		cmdsts = ((nr_frags|residue) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
@@ -1092,11 +1077,12 @@
 		if (!nr_frags)
 			break;
 
-		buf = pci_map_single_high(dev->pci_dev, frag->page,
-					  frag->page_offset,
-					  frag->size, PCI_DMA_TODEVICE);
-		dprintk("frag: buf=%08Lx  page=%08lx\n",
-			(long long)buf, (long)(frag->page - mem_map));
+		buf = pci_map_page(dev->pci_dev, frag->page,
+				   frag->page_offset,
+				   frag->size, PCI_DMA_TODEVICE);
+		printk("frag: buf=%08Lx  page=%08lx offset=%08lx\n",
+			(long long)buf, (long)(frag->page - mem_map),
+			frag->page_offset);
 		len = frag->size;
 		frag++;
 		nr_frags--;
@@ -1427,6 +1413,16 @@
 	struct ns83820 *dev;
 	long addr;
 	int err;
+	int using_dac = 0;
+
+	if (TRY_DAC && !pci_set_dma_mask(pci_dev, 0xffffffffffffffff)) {
+		using_dac = 1;
+	} else if (!pci_set_dma_mask(pci_dev, 0xffffffff)) {
+		using_dac = 0;
+	} else {
+		printk(KERN_WARNING "ns83820.c: pci_set_dma_mask failed!\n");
+		return -ENODEV;
+	}
 
 	dev = (struct ns83820 *)alloc_etherdev((sizeof *dev) - (sizeof dev->net_dev));
 	err = -ENOMEM;
@@ -1536,6 +1532,9 @@
 #ifdef USE_64BIT_ADDR
 	dev->CFG_cache |= CFG_M64ADDR;
 #endif
+	if (using_dac)
+		dev->CFG_cache |= CFG_T64ADDR;
+
 	/* Big endian mode does not seem to do what the docs suggest */
 	dev->CFG_cache &= ~CFG_BEM;
 
@@ -1561,7 +1560,7 @@
 	writel(dev->CFG_cache, dev->base + CFG);
 	dprintk("CFG: %08x\n", dev->CFG_cache);
 
-#if 1	/* Huh?  This sets the PCI latency register.  Should be done via 
+#if 0	/* Huh?  This sets the PCI latency register.  Should be done via 
 	 * the PCI layer.  FIXME.
 	 */
 	if (readl(dev->base + SRR))
@@ -1614,13 +1613,12 @@
 	/* Yes, we support dumb IP checksum on transmit */
 	dev->net_dev.features |= NETIF_F_SG;
 	dev->net_dev.features |= NETIF_F_IP_CSUM;
-#if defined(USE_64BIT_ADDR) || defined(CONFIG_HIGHMEM4G)
-	if ((dev->CFG_cache & CFG_T64ADDR)) {
+
+	if (using_dac) {
 		printk(KERN_INFO "%s: using 64 bit addressing.\n",
 			dev->net_dev.name);
 		dev->net_dev.features |= NETIF_F_HIGHDMA;
 	}
-#endif
 
 	printk(KERN_INFO "%s: ns83820 v" VERSION ": DP83820 v%u.%u: %02x:%02x:%02x:%02x:%02x:%02x io=0x%08lx irq=%d f=%s\n",
 		dev->net_dev.name,
