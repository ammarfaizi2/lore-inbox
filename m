Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSJHWy5>; Tue, 8 Oct 2002 18:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJHWy5>; Tue, 8 Oct 2002 18:54:57 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:7672 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261606AbSJHWsc>; Tue, 8 Oct 2002 18:48:32 -0400
Date: Tue, 8 Oct 2002 18:54:12 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-aio@kvack.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch/BK tree] aio-core changes and ns83820 update to 0.20]
Message-ID: <20021008185412.D15858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry about the duplicate to l-k, I got the addresses wrong]

Hello Linus,

Please do a bk pull from master.kernel.org:/home/bcrl/aio-2.5 to grab the 
changesets that result in the following patch.  The interesting bits are 
the addition of "kick" functionality for iocbs that can be used to issue 
retries (tested with the early stages of TCP aio support which is going to 
davem separately) that are executed within the issuer's mm struct.  This 
makes the case where ios don't need to pin memory much easier to code, as 
with non-zero copy network io.  Additionally, the changes to read_write.c 
allow sys_read/write to operate on file descriptors that only provide 
aio_read support.  A few cleanups are required to make exec() use vfs_read() 
to transparently use this functionality.  The goal with this set of changes 
is to allow various files to provide either async or non-async functionality 
to ease transition.  Comments?  Note that I'm still getting used to bitkeeper, 
so any suggestions for improvements in the sync format would be appreciated.
Cheers,

		-ben
-- 
"Do you seek knowledge in time travel?"

Summary of changes from to current
============================================

<bcrl@toomuch.toronto.redhat.com>
	v2.5.31-aio-nohighmem.diff
		- cleanup aio highmem handling, make it faster

	correct return value from aio_complete on sync iocbs
	update ns83820.c to v0.19
	sync iocbs need to actually wake_up_process the waiter (as spotted by Suparna).
	several updates for testing aio_{read,write}
	support for file descriptors with only async ops in vfs_{read,write}
	several minor bugfixes for the aio core
	create support for iocb kicking, where a retry operation gets triggered in the mm 
	context of the submitter to allow the use of copy_*_user.
	queue descriptor io errors instead of returning them from io_submit
	adapt aio kick changes to ingo's work queues
	buildbug.diff
	fix missing list initialization in aio context creation
	fix a bug in kick_iocb that caused it to fail for async iocbs.
	update ns83820 to 0.20


 drivers/net/ns83820.c  |  634 +++++++++++++++++++++++++++++++++++++++----------
 fs/aio.c               |  159 +++++++++---
 fs/exec.c              |   11 
 fs/ext2/file.c         |    2 
 fs/ext3/file.c         |   11 
 fs/nfs/file.c          |   26 +-
 fs/read_write.c        |   42 ++-
 include/linux/aio.h    |   43 ++-
 include/linux/fs.h     |    6 
 include/linux/kernel.h |    3 
 mm/filemap.c           |   11 
 11 files changed, 762 insertions(+), 186 deletions(-)


diff -urN linus-2.5/drivers/net/ns83820.c aio-2.5/drivers/net/ns83820.c
--- linus-2.5/drivers/net/ns83820.c	Tue Oct  8 18:30:09 2002
+++ aio-2.5/drivers/net/ns83820.c	Tue Oct  8 18:23:50 2002
@@ -1,9 +1,9 @@
-#define _VERSION "0.18"
+#define _VERSION "0.20"
 /* ns83820.c by Benjamin LaHaise with contributions.
  *
  * Questions/comments/discussion to linux-ns83820@kvack.org.
  *
- * $Revision: 1.34.2.16 $
+ * $Revision: 1.34.2.23 $
  *
  * Copyright 2001 Benjamin LaHaise.
  * Copyright 2001, 2002 Red Hat.
@@ -57,6 +57,12 @@
  *	20020310	0.17	speedups
  *	20020610	0.18 -	actually use the pci dma api for highmem
  *			     -	remove pci latency register fiddling
+ *			0.19 -	better bist support
+ *			     -	add ihr and reset_phy parameters
+ *			     -	gmii bus probing
+ *			     -	fix missed txok introduced during performance
+ *				tuning
+ *			0.20 -	fix stupid RFEN thinko.  i am such a smurf.
  *
  * Driver Overview
  * ===============
@@ -101,9 +107,16 @@
 #include <linux/compiler.h>
 #include <linux/prefetch.h>
 #include <linux/ethtool.h>
+#include <linux/timer.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
+#include <asm/system.h>
+
+/* Global parameters.  See MODULE_PARM near the bottom. */
+static int ihr = 2;
+static int reset_phy = 0;
+static int lnksts = 0;		/* CFG_LNKSTS bit polarity */
 
 /* Dprintk is used for more interesting debug events */
 #undef Dprintk
@@ -126,7 +139,7 @@
 
 /* Must not exceed ~65000. */
 #define NR_RX_DESC	64
-#define NR_TX_DESC	64
+#define NR_TX_DESC	128
 
 /* not tunable */
 #define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14)	/* rx/tx mac addr + type */
@@ -138,6 +151,9 @@
 
 #define CR_TXE		0x00000001
 #define CR_TXD		0x00000002
+/* Ramit : Here's a tip, don't do a RXD immediately followed by an RXE
+ * The Receive engine skips one descriptor and moves
+ * onto the next one!! */
 #define CR_RXE		0x00000004
 #define CR_RXD		0x00000008
 #define CR_TXR		0x00000010
@@ -145,8 +161,21 @@
 #define CR_SWI		0x00000080
 #define CR_RST		0x00000100
 
-#define PTSCR_EEBIST_EN	0x00000002
-#define PTSCR_EELOAD_EN	0x00000004
+#define PTSCR_EEBIST_FAIL       0x00000001
+#define PTSCR_EEBIST_EN         0x00000002
+#define PTSCR_EELOAD_EN         0x00000004
+#define PTSCR_RBIST_FAIL        0x000001b8
+#define PTSCR_RBIST_DONE        0x00000200
+#define PTSCR_RBIST_EN          0x00000400
+#define PTSCR_RBIST_RST         0x00002000
+
+#define MEAR_EEDI		0x00000001
+#define MEAR_EEDO		0x00000002
+#define MEAR_EECLK		0x00000004
+#define MEAR_EESEL		0x00000008
+#define MEAR_MDIO		0x00000010
+#define MEAR_MDDIR		0x00000020
+#define MEAR_MDC		0x00000040
 
 #define ISR_TXDESC3	0x40000000
 #define ISR_TXDESC2	0x20000000
@@ -202,6 +231,8 @@
 #define CFG_DUPSTS	0x10000000
 #define CFG_TBI_EN	0x01000000
 #define CFG_MODE_1000	0x00400000
+/* Ramit : Dont' ever use AUTO_1000, it never works and is buggy.
+ * Read the Phy response and then configure the MAC accordingly */
 #define CFG_AUTO_1000	0x00200000
 #define CFG_PINT_CTL	0x001c0000
 #define CFG_PINT_DUPSTS	0x00100000
@@ -230,22 +261,29 @@
 #define EXTSTS_TCPPKT	0x00080000
 #define EXTSTS_IPPKT	0x00020000
 
-#define SPDSTS_POLARITY	(CFG_SPDSTS1 | CFG_SPDSTS0 | CFG_DUPSTS)
+#define SPDSTS_POLARITY	(CFG_SPDSTS1 | CFG_SPDSTS0 | CFG_DUPSTS | (lnksts ? CFG_LNKSTS : 0))
 
 #define MIBC_MIBS	0x00000008
 #define MIBC_ACLR	0x00000004
 #define MIBC_FRZ	0x00000002
 #define MIBC_WRN	0x00000001
 
+#define PCR_PSEN	(1 << 31)
+#define PCR_PS_MCAST	(1 << 30)
+#define PCR_PS_DA	(1 << 29)
+#define PCR_STHI_8	(3 << 23)
+#define PCR_STLO_4	(1 << 23)
+#define PCR_FFHI_8K	(3 << 21)
+#define PCR_FFLO_4K	(1 << 21)
+#define PCR_PAUSE_CNT	0xFFFE
+
 #define RXCFG_AEP	0x80000000
 #define RXCFG_ARP	0x40000000
 #define RXCFG_STRIPCRC	0x20000000
 #define RXCFG_RX_FD	0x10000000
 #define RXCFG_ALP	0x08000000
 #define RXCFG_AIRL	0x04000000
-#define RXCFG_MXDMA	0x00700000
-#define RXCFG_MXDMA0	0x00100000
-#define RXCFG_MXDMA64	0x00600000
+#define RXCFG_MXDMA512	0x00700000
 #define RXCFG_DRTH	0x0000003e
 #define RXCFG_DRTH0	0x00000002
 
@@ -354,23 +392,22 @@
 #define desc_addr_set(desc, addr)				\
 	do {							\
 		u64 __addr = (addr);				\
-		desc[BUFPTR] = cpu_to_le32(__addr);		\
-		desc[BUFPTR+1] = cpu_to_le32(__addr >> 32);	\
+		(desc)[0] = cpu_to_le32(__addr);		\
+		(desc)[1] = cpu_to_le32(__addr >> 32);		\
 	} while(0)
 #define desc_addr_get(desc)					\
-		(((u64)le32_to_cpu(desc[BUFPTR+1]) << 32)	\
-		     | le32_to_cpu(desc[BUFPTR]))
+		(((u64)le32_to_cpu((desc)[1]) << 32)		\
+		     | le32_to_cpu((desc)[0]))
 #else
 #define HW_ADDR_LEN	4
-#define desc_addr_set(desc, addr)	(desc[BUFPTR] = cpu_to_le32(addr))
-#define desc_addr_get(desc)		(le32_to_cpu(desc[BUFPTR]))
+#define desc_addr_set(desc, addr)	((desc)[0] = cpu_to_le32(addr))
+#define desc_addr_get(desc)		(le32_to_cpu((desc)[0]))
 #endif
 
-#define LINK		0
-#define BUFPTR		(LINK + HW_ADDR_LEN/4)
-#define CMDSTS		(BUFPTR + HW_ADDR_LEN/4)
-#define EXTSTS		(CMDSTS + 4/4)
-#define DRV_NEXT	(EXTSTS + 4/4)
+#define DESC_LINK		0
+#define DESC_BUFPTR		(DESC_LINK + HW_ADDR_LEN/4)
+#define DESC_CMDSTS		(DESC_BUFPTR + HW_ADDR_LEN/4)
+#define DESC_EXTSTS		(DESC_CMDSTS + 4/4)
 
 #define CMDSTS_OWN	0x80000000
 #define CMDSTS_MORE	0x40000000
@@ -426,18 +463,19 @@
 
 	spinlock_t	tx_lock;
 
-	long		tx_idle;
-
 	u16		tx_done_idx;
 	u16		tx_idx;
 	volatile u16	tx_free_idx;	/* idx of free desc chain */
 	u16		tx_intr_idx;
 
+	atomic_t	nr_tx_skbs;
 	struct sk_buff	*tx_skbs[NR_TX_DESC];
 
 	char		pad[16] __attribute__((aligned(16)));
 	u32		*tx_descs;
 	dma_addr_t	tx_phy_descs;
+
+	struct timer_list	tx_watchdog;
 };
 
 //free = (tx_done_idx + NR_TX_DESC-2 - free_idx) % NR_TX_DESC
@@ -458,33 +496,15 @@
  * conditions, still route realtime traffic with as low jitter as
  * possible.
  */
-#ifdef USE_64BIT_ADDR
-static inline void build_rx_desc64(struct ns83820 *dev, u32 *desc, u64 link, u64 buf, u32 cmdsts, u32 extsts)
-{
-	desc[0] = link;
-	desc[1] = link >> 32;
-	desc[2] = buf;
-	desc[3] = buf >> 32;
-	desc[5] = extsts;
-	mb();
-	desc[4] = cmdsts;
-}
-
-#define build_rx_desc	build_rx_desc64
-#else
-
-static inline void build_rx_desc32(struct ns83820 *dev, u32 *desc, u32 link, u32 buf, u32 cmdsts, u32 extsts)
+static inline void build_rx_desc(struct ns83820 *dev, u32 *desc, dma_addr_t link, dma_addr_t buf, u32 cmdsts, u32 extsts)
 {
-	desc[0] = cpu_to_le32(link);
-	desc[1] = cpu_to_le32(buf);
-	desc[3] = cpu_to_le32(extsts);
+	desc_addr_set(desc + DESC_LINK, link);
+	desc_addr_set(desc + DESC_BUFPTR, buf);
+	desc[DESC_EXTSTS] = extsts;
 	mb();
-	desc[2] = cpu_to_le32(cmdsts);
+	desc[DESC_CMDSTS] = cmdsts;
 }
 
-#define build_rx_desc	build_rx_desc32
-#endif
-
 #define nr_rx_empty(dev) ((NR_RX_DESC-2 + dev->rx_info.next_rx - dev->rx_info.next_empty) % NR_RX_DESC)
 static inline int ns83820_add_rx_skb(struct ns83820 *dev, struct sk_buff *skb)
 {
@@ -717,7 +737,7 @@
 		phy_intr(dev);
 
 		/* Okay, let it rip */
-		spin_lock(&dev->misc_lock);
+		spin_lock_irq(&dev->misc_lock);
 		dev->IMR_cache |= ISR_PHY;
 		dev->IMR_cache |= ISR_RXRCMP;
 		//dev->IMR_cache |= ISR_RXERR;
@@ -731,7 +751,7 @@
 
 		writel(dev->IMR_cache, dev->base + IMR);
 		writel(1, dev->base + IER);
-		spin_unlock(&dev->misc_lock);
+		spin_unlock_irq(&dev->misc_lock);
 
 		kick_rx(dev);
 
@@ -788,7 +808,7 @@
 	else
 		kick_rx(dev);
 	if (dev->rx_info.idle)
-		Dprintk("BAD\n");
+		printk(KERN_DEBUG "%s: BAD\n", dev->net_dev.name);
 }
 
 /* rx_irq
@@ -820,14 +840,14 @@
 	dprintk("walking descs\n");
 	next_rx = info->next_rx;
 	desc = info->next_rx_desc;
-	while ((CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[CMDSTS]))) &&
+	while ((CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[DESC_CMDSTS]))) &&
 	       (cmdsts != CMDSTS_OWN)) {
 		struct sk_buff *skb;
-		u32 extsts = le32_to_cpu(desc[EXTSTS]);
-		dma_addr_t bufptr = desc_addr_get(desc);
+		u32 extsts = le32_to_cpu(desc[DESC_EXTSTS]);
+		dma_addr_t bufptr = desc_addr_get(desc + DESC_BUFPTR);
 
 		dprintk("cmdsts: %08x\n", cmdsts);
-		dprintk("link: %08x\n", cpu_to_le32(desc[LINK]));
+		dprintk("link: %08x\n", cpu_to_le32(desc[DESC_LINK]));
 		dprintk("extsts: %08x\n", extsts);
 
 		skb = info->skbs[next_rx];
@@ -881,8 +901,13 @@
 {
 	struct ns83820 *dev = (void *)_dev;
 	rx_irq(dev);
-	writel(0x002, dev->base + IHR);
-	writel(dev->IMR_cache | ISR_RXDESC, dev->base + IMR);
+	writel(ihr, dev->base + IHR);
+
+	spin_lock_irq(&dev->misc_lock);
+	dev->IMR_cache |= ISR_RXDESC;
+	writel(dev->IMR_cache, dev->base + IMR);
+	spin_unlock_irq(&dev->misc_lock);
+
 	rx_irq(dev);
 	ns83820_rx_kick(dev);
 }
@@ -891,8 +916,8 @@
  */
 static inline void kick_tx(struct ns83820 *dev)
 {
-	dprintk("kick_tx(%p): tx_idle=%ld, tx_idx=%d free_idx=%d\n",
-		dev, dev->tx_idle, dev->tx_idx, dev->tx_free_idx);
+	dprintk("kick_tx(%p): tx_idx=%d free_idx=%d\n",
+		dev, dev->tx_idx, dev->tx_free_idx);
 	writel(CR_TXE, dev->base + CR);
 }
 
@@ -903,14 +928,16 @@
 {
 	u32 cmdsts, tx_done_idx, *desc;
 
+	spin_lock_irq(&dev->tx_lock);
+
 	dprintk("do_tx_done(%p)\n", dev);
 	tx_done_idx = dev->tx_done_idx;
 	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
 
 	dprintk("tx_done_idx=%d free_idx=%d cmdsts=%08x\n",
-		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[CMDSTS]));
+		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[DESC_CMDSTS]));
 	while ((tx_done_idx != dev->tx_free_idx) &&
-	       !(CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[CMDSTS]))) ) {
+	       !(CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[DESC_CMDSTS]))) ) {
 		struct sk_buff *skb;
 		unsigned len;
 		dma_addr_t addr;
@@ -929,13 +956,14 @@
 		dprintk("done(%p)\n", skb);
 
 		len = cmdsts & CMDSTS_LEN_MASK;
-		addr = desc_addr_get(desc);
+		addr = desc_addr_get(desc + DESC_BUFPTR);
 		if (skb) {
 			pci_unmap_single(dev->pci_dev,
 					addr,
 					len,
 					PCI_DMA_TODEVICE);
 			dev_kfree_skb_irq(skb);
+			atomic_dec(&dev->nr_tx_skbs);
 		} else
 			pci_unmap_page(dev->pci_dev, 
 					addr,
@@ -944,7 +972,7 @@
 
 		tx_done_idx = (tx_done_idx + 1) % NR_TX_DESC;
 		dev->tx_done_idx = tx_done_idx;
-		desc[CMDSTS] = cpu_to_le32(0);
+		desc[DESC_CMDSTS] = cpu_to_le32(0);
 		mb();
 		desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
 	}
@@ -957,6 +985,7 @@
 		netif_start_queue(&dev->net_dev);
 		netif_wake_queue(&dev->net_dev);
 	}
+	spin_unlock_irq(&dev->tx_lock);
 }
 
 static void ns83820_cleanup_tx(struct ns83820 *dev)
@@ -966,12 +995,18 @@
 	for (i=0; i<NR_TX_DESC; i++) {
 		struct sk_buff *skb = dev->tx_skbs[i];
 		dev->tx_skbs[i] = NULL;
-		if (skb)
-			dev_kfree_skb(skb);
+		if (skb) {
+			u32 *desc = dev->tx_descs + (i * DESC_SIZE);
+			pci_unmap_single(dev->pci_dev,
+					desc_addr_get(desc + DESC_BUFPTR),
+					le32_to_cpu(desc[DESC_CMDSTS]) & CMDSTS_LEN_MASK,
+					PCI_DMA_TODEVICE);
+			dev_kfree_skb_irq(skb);
+			atomic_dec(&dev->nr_tx_skbs);
+		}
 	}
 
 	memset(dev->tx_descs, 0, NR_TX_DESC * DESC_SIZE * 4);
-	set_bit(0, &dev->tx_idle);
 }
 
 /* transmit routine.  This code relies on the network layer serializing
@@ -985,7 +1020,7 @@
 	struct ns83820 *dev = (struct ns83820 *)_dev;
 	u32 free_idx, cmdsts, extsts;
 	int nr_free, nr_frags;
-	unsigned tx_done_idx;
+	unsigned tx_done_idx, last_idx;
 	dma_addr_t buf;
 	unsigned len;
 	skb_frag_t *frag;
@@ -1004,7 +1039,7 @@
 		netif_start_queue(&dev->net_dev);
 	}
 
-	free_idx = dev->tx_free_idx;
+	last_idx = free_idx = dev->tx_free_idx;
 	tx_done_idx = dev->tx_done_idx;
 	nr_free = (tx_done_idx + NR_TX_DESC-2 - free_idx) % NR_TX_DESC;
 	nr_free -= 1;
@@ -1058,15 +1093,16 @@
 
 		dprintk("frag[%3u]: %4u @ 0x%08Lx\n", free_idx, len,
 			(unsigned long long)buf);
+		last_idx = free_idx;
 		free_idx = (free_idx + 1) % NR_TX_DESC;
-		desc[LINK] = cpu_to_le32(dev->tx_phy_descs + (free_idx * DESC_SIZE * 4));
-		desc_addr_set(desc, buf);
-		desc[EXTSTS] = cpu_to_le32(extsts);
+		desc[DESC_LINK] = cpu_to_le32(dev->tx_phy_descs + (free_idx * DESC_SIZE * 4));
+		desc_addr_set(desc + DESC_BUFPTR, buf);
+		desc[DESC_EXTSTS] = cpu_to_le32(extsts);
 
 		cmdsts = ((nr_frags|residue) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
 		cmdsts |= (desc == first_desc) ? 0 : CMDSTS_OWN;
 		cmdsts |= len;
-		desc[CMDSTS] = cpu_to_le32(cmdsts);
+		desc[DESC_CMDSTS] = cpu_to_le32(cmdsts);
 
 		if (residue) {
 			buf += len;
@@ -1088,15 +1124,22 @@
 		nr_frags--;
 	}
 	dprintk("done pkt\n");
-	dev->tx_skbs[free_idx] = skb;
-	first_desc[CMDSTS] |= cpu_to_le32(CMDSTS_OWN);
+
+	spin_lock_irq(&dev->tx_lock);
+	dev->tx_skbs[last_idx] = skb;
+	first_desc[DESC_CMDSTS] |= cpu_to_le32(CMDSTS_OWN);
 	dev->tx_free_idx = free_idx;
+	atomic_inc(&dev->nr_tx_skbs);
+	spin_unlock_irq(&dev->tx_lock);
+
 	kick_tx(dev);
 
 	/* Check again: we may have raced with a tx done irq */
 	if (stopped && (dev->tx_done_idx != tx_done_idx) && start_tx_okay(dev))
 		netif_start_queue(&dev->net_dev);
 
+	/* set the transmit start time to catch transmit timeouts */
+	dev->net_dev.trans_start = jiffies;
 	return 0;
 }
 
@@ -1190,6 +1233,7 @@
 	spin_unlock(&dev->misc_lock);
 }
 
+static void ns83820_do_isr(struct ns83820 *dev, u32 isr);
 static void ns83820_irq(int foo, void *data, struct pt_regs *regs)
 {
 	struct ns83820 *dev = data;
@@ -1200,7 +1244,11 @@
 
 	isr = readl(dev->base + ISR);
 	dprintk("irq: %08x\n", isr);
+	ns83820_do_isr(dev, isr);
+}
 
+static void ns83820_do_isr(struct ns83820 *dev, u32 isr)
+{
 #ifdef DEBUG
 	if (isr & ~(ISR_PHY | ISR_RXDESC | ISR_RXEARLY | ISR_RXOK | ISR_RXERR | ISR_TXIDLE | ISR_TXOK | ISR_TXDESC))
 		Dprintk("odd isr? 0x%08x\n", isr);
@@ -1214,7 +1262,12 @@
 
 	if ((ISR_RXDESC | ISR_RXOK) & isr) {
 		prefetch(dev->rx_info.next_rx_desc);
-		writel(dev->IMR_cache & ~(ISR_RXDESC | ISR_RXOK), dev->base + IMR);
+
+		spin_lock_irq(&dev->misc_lock);
+		dev->IMR_cache &= ~(ISR_RXDESC | ISR_RXOK);
+		writel(dev->IMR_cache, dev->base + IMR);
+		spin_unlock_irq(&dev->misc_lock);
+
 		tasklet_schedule(&dev->rx_tasklet);
 		//rx_irq(dev);
 		//writel(4, dev->base + IHR);
@@ -1246,12 +1299,11 @@
 			printk(KERN_ALERT "%s: BUG -- txdp out of range\n", dev->net_dev.name);
 			dev->tx_idx = 0;
 		}
-		if (dev->tx_idx != dev->tx_free_idx)
-			writel(CR_TXE, dev->base + CR);
-			//kick_tx(dev);
-		else
-			dev->tx_idle = 1;
-		mb();
+		/* The may have been a race between a pci originated read
+		 * and the descriptor update from the cpu.  Just in case, 
+		 * kick the transmitter if the hardware thinks it is on a 
+		 * different descriptor than we are.
+		 */
 		if (dev->tx_idx != dev->tx_free_idx)
 			kick_tx(dev);
 	}
@@ -1259,12 +1311,38 @@
 	/* Defer tx ring processing until more than a minimum amount of
 	 * work has accumulated
 	 */
-	if ((ISR_TXDESC | ISR_TXIDLE) & isr)
+	if ((ISR_TXDESC | ISR_TXIDLE | ISR_TXOK | ISR_TXERR) & isr) {
 		do_tx_done(dev);
 
+		/* Disable TxOk if there are no outstanding tx packets.
+		 */
+		if ((dev->tx_done_idx == dev->tx_free_idx) &&
+		    (dev->IMR_cache & ISR_TXOK)) {
+			spin_lock_irq(&dev->misc_lock);
+			dev->IMR_cache &= ~ISR_TXOK;
+			writel(dev->IMR_cache, dev->base + IMR);
+			spin_unlock_irq(&dev->misc_lock);
+		}
+	}
+
+	/* The TxIdle interrupt can come in before the transmit has
+	 * completed.  Normally we reap packets off of the combination
+	 * of TxDesc and TxIdle and leave TxOk disabled (since it 
+	 * occurs on every packet), but when no further irqs of this 
+	 * nature are expected, we must enable TxOk.
+	 */
+	if ((ISR_TXIDLE & isr) && (dev->tx_done_idx != dev->tx_free_idx)) {
+		spin_lock_irq(&dev->misc_lock);
+		dev->IMR_cache |= ISR_TXOK;
+		writel(dev->IMR_cache, dev->base + IMR);
+		spin_unlock_irq(&dev->misc_lock);
+	}
+
+	/* MIB interrupt: one of the statistics counters is about to overflow */
 	if (unlikely(ISR_MIB & isr))
 		ns83820_mib_isr(dev);
 
+	/* PHY: Link up/down/negotiation state change */
 	if (unlikely(ISR_PHY & isr))
 		phy_intr(dev);
 
@@ -1289,6 +1367,7 @@
 	struct ns83820 *dev = (struct ns83820 *)_dev;
 
 	/* FIXME: protect against interrupt handler? */
+	del_timer_sync(&dev->tx_watchdog);
 
 	/* disable interrupts */
 	writel(0, dev->base + IMR);
@@ -1302,13 +1381,75 @@
 
 	synchronize_irq(dev->pci_dev->irq);
 
+	spin_lock_irq(&dev->misc_lock);
 	dev->IMR_cache &= ~(ISR_TXURN | ISR_TXIDLE | ISR_TXERR | ISR_TXDESC | ISR_TXOK);
+	spin_unlock_irq(&dev->misc_lock);
+
 	ns83820_cleanup_rx(dev);
 	ns83820_cleanup_tx(dev);
 
 	return 0;
 }
 
+static void ns83820_do_isr(struct ns83820 *dev, u32 isr);
+static void ns83820_tx_timeout(struct net_device *_dev)
+{
+	struct ns83820 *dev = (struct ns83820 *)_dev;
+        u32 tx_done_idx, *desc;
+	long flags;
+
+	local_irq_save(flags);
+
+	tx_done_idx = dev->tx_done_idx;
+	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
+
+	printk(KERN_INFO "%s: tx_timeout: tx_done_idx=%d free_idx=%d cmdsts=%08x\n",
+		dev->net_dev.name,
+		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[DESC_CMDSTS]));
+
+#if defined(DEBUG)
+	{
+		u32 isr;
+		isr = readl(dev->base + ISR);
+		printk("irq: %08x imr: %08x\n", isr, dev->IMR_cache);
+		ns83820_do_isr(dev, isr);
+	}
+#endif
+
+	do_tx_done(dev);
+
+	tx_done_idx = dev->tx_done_idx;
+	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
+
+	printk(KERN_INFO "%s: after: tx_done_idx=%d free_idx=%d cmdsts=%08x\n",
+		dev->net_dev.name,
+		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[DESC_CMDSTS]));
+
+	local_irq_restore(flags);
+}
+
+static void ns83820_tx_watch(unsigned long data)
+{
+	struct ns83820 *dev = (void *)data;
+
+#if defined(DEBUG)
+	printk("ns83820_tx_watch: %u %u %d\n",
+		dev->tx_done_idx, dev->tx_free_idx, atomic_read(&dev->nr_tx_skbs)
+		);
+#endif
+
+	if (time_after(jiffies, dev->net_dev.trans_start + 1*HZ) &&
+	    dev->tx_done_idx != dev->tx_free_idx) {
+		printk(KERN_DEBUG "%s: ns83820_tx_watch: %u %u %d\n",
+			dev->net_dev.name,
+			dev->tx_done_idx, dev->tx_free_idx,
+			atomic_read(&dev->nr_tx_skbs));
+		ns83820_tx_timeout(&dev->net_dev);
+	}
+
+	mod_timer(&dev->tx_watchdog, jiffies + 2*HZ);
+}
+
 static int ns83820_open(struct net_device *_dev)
 {
 	struct ns83820 *dev = (struct ns83820 *)_dev;
@@ -1326,7 +1467,7 @@
 
 	memset(dev->tx_descs, 0, 4 * NR_TX_DESC * DESC_SIZE);
 	for (i=0; i<NR_TX_DESC; i++) {
-		dev->tx_descs[(i * DESC_SIZE) + LINK]
+		dev->tx_descs[(i * DESC_SIZE) + DESC_LINK]
 				= cpu_to_le32(
 				  dev->tx_phy_descs
 				  + ((i+1) % NR_TX_DESC) * DESC_SIZE * 4);
@@ -1338,9 +1479,11 @@
 	writel(0, dev->base + TXDP_HI);
 	writel(desc, dev->base + TXDP);
 
-//printk("IMR: %08x / %08x\n", readl(dev->base + IMR), dev->IMR_cache);
+	init_timer(&dev->tx_watchdog);
+	dev->tx_watchdog.data = (unsigned long)dev;
+	dev->tx_watchdog.function = ns83820_tx_watch;
+	mod_timer(&dev->tx_watchdog, jiffies + 2*HZ);
 
-	set_bit(0, &dev->tx_idle);
 	netif_start_queue(&dev->net_dev);	/* FIXME: wait for phy to come up */
 
 	return 0;
@@ -1350,15 +1493,6 @@
 	return ret;
 }
 
-#if 0	/* FIXME: implement this! */
-static void ns83820_tx_timeout(struct net_device *_dev)
-{
-	struct ns83820 *dev = (struct ns83820 *)_dev;
-
-	printk("ns83820_tx_timeout\n");
-}
-#endif
-
 static void ns83820_getmac(struct ns83820 *dev, u8 *mac)
 {
 	unsigned i;
@@ -1392,6 +1526,7 @@
 	u8 *rfcr = dev->base + RFCR;
 	u32 and_mask = 0xffffffff;
 	u32 or_mask = 0;
+	u32 val;
 
 	if (dev->net_dev.flags & IFF_PROMISC)
 		or_mask |= RFCR_AAU | RFCR_AAM;
@@ -1404,10 +1539,225 @@
 		and_mask &= ~RFCR_AAM;
 
 	spin_lock_irq(&dev->misc_lock);
-	writel((readl(rfcr) & and_mask) | or_mask, rfcr);
+	val = (readl(rfcr) & and_mask) | or_mask;
+	/* Ramit : RFCR Write Fix doc says RFEN must be 0 modify other bits */
+	writel(val & ~RFCR_RFEN, rfcr);
+	writel(val, rfcr);
 	spin_unlock_irq(&dev->misc_lock);
 }
 
+static void ns83820_run_bist(struct ns83820 *dev, const char *name, u32 enable, u32 done, u32 fail)
+{
+	int timed_out = 0;
+	long start;
+	u32 status;
+	int loops = 0;
+
+	dprintk("%s: start %s\n", dev->net_dev.name, name);
+
+	start = jiffies;
+
+	writel(enable, dev->base + PTSCR);
+	for (;;) {
+		loops++;
+		status = readl(dev->base + PTSCR);
+		if (!(status & enable))
+			break;
+		if (status & done)
+			break;
+		if (status & fail)
+			break;
+		if ((jiffies - start) >= HZ) {
+			timed_out = 1;
+			break;
+		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+	}
+
+	if (status & fail)
+		printk(KERN_INFO "%s: %s failed! (0x%08x & 0x%08x)\n",
+			dev->net_dev.name, name, status, fail);
+	else if (timed_out)
+		printk(KERN_INFO "%s: run_bist %s timed out! (%08x)\n",
+			dev->net_dev.name, name, status);
+
+	dprintk("%s: done %s in %d loops\n", dev->net_dev.name, name, loops);
+}
+
+static void ns83820_mii_write_bit(struct ns83820 *dev, int bit)
+{
+	/* drive MDC low */
+	dev->MEAR_cache &= ~MEAR_MDC;
+	writel(dev->MEAR_cache, dev->base + MEAR);
+	readl(dev->base + MEAR);
+
+	/* enable output, set bit */
+	dev->MEAR_cache |= MEAR_MDDIR;
+	if (bit)
+		dev->MEAR_cache |= MEAR_MDIO;
+	else
+		dev->MEAR_cache &= ~MEAR_MDIO;
+
+	/* set the output bit */
+	writel(dev->MEAR_cache, dev->base + MEAR);
+	readl(dev->base + MEAR);
+
+	/* Wait.  Max clock rate is 2.5MHz, this way we come in under 1MHz */
+	udelay(1);
+
+	/* drive MDC high causing the data bit to be latched */
+	dev->MEAR_cache |= MEAR_MDC;
+	writel(dev->MEAR_cache, dev->base + MEAR);
+	readl(dev->base + MEAR);
+
+	/* Wait again... */
+	udelay(1);
+}
+
+static int ns83820_mii_read_bit(struct ns83820 *dev)
+{
+	int bit;
+
+	/* drive MDC low, disable output */
+	dev->MEAR_cache &= ~MEAR_MDC;
+	dev->MEAR_cache &= ~MEAR_MDDIR;
+	writel(dev->MEAR_cache, dev->base + MEAR);
+	readl(dev->base + MEAR);
+
+	/* Wait.  Max clock rate is 2.5MHz, this way we come in under 1MHz */
+	udelay(1);
+
+	/* drive MDC high causing the data bit to be latched */
+	bit = (readl(dev->base + MEAR) & MEAR_MDIO) ? 1 : 0;
+	dev->MEAR_cache |= MEAR_MDC;
+	writel(dev->MEAR_cache, dev->base + MEAR);
+
+	/* Wait again... */
+	udelay(1);
+
+	return bit;
+}
+
+static unsigned ns83820_mii_read_reg(struct ns83820 *dev, unsigned phy, unsigned reg)
+{
+	unsigned data = 0;
+	int i;
+
+	/* read some garbage so that we eventually sync up */
+	for (i=0; i<64; i++)
+		ns83820_mii_read_bit(dev);
+
+	ns83820_mii_write_bit(dev, 0);	/* start */
+	ns83820_mii_write_bit(dev, 1);
+	ns83820_mii_write_bit(dev, 1);	/* opcode read */
+	ns83820_mii_write_bit(dev, 0);
+
+	/* write out the phy address: 5 bits, msb first */
+	for (i=0; i<5; i++)
+		ns83820_mii_write_bit(dev, phy & (0x10 >> i));
+
+	/* write out the register address, 5 bits, msb first */
+	for (i=0; i<5; i++)
+		ns83820_mii_write_bit(dev, reg & (0x10 >> i));
+
+	ns83820_mii_read_bit(dev);	/* turn around cycles */
+	ns83820_mii_read_bit(dev);
+
+	/* read in the register data, 16 bits msb first */
+	for (i=0; i<16; i++) {
+		data <<= 1;
+		data |= ns83820_mii_read_bit(dev);
+	}
+
+	return data;
+}
+
+static unsigned ns83820_mii_write_reg(struct ns83820 *dev, unsigned phy, unsigned reg, unsigned data)
+{
+	int i;
+
+	/* read some garbage so that we eventually sync up */
+	for (i=0; i<64; i++)
+		ns83820_mii_read_bit(dev);
+
+	ns83820_mii_write_bit(dev, 0);	/* start */
+	ns83820_mii_write_bit(dev, 1);
+	ns83820_mii_write_bit(dev, 0);	/* opcode read */
+	ns83820_mii_write_bit(dev, 1);
+
+	/* write out the phy address: 5 bits, msb first */
+	for (i=0; i<5; i++)
+		ns83820_mii_write_bit(dev, phy & (0x10 >> i));
+
+	/* write out the register address, 5 bits, msb first */
+	for (i=0; i<5; i++)
+		ns83820_mii_write_bit(dev, reg & (0x10 >> i));
+
+	ns83820_mii_read_bit(dev);	/* turn around cycles */
+	ns83820_mii_read_bit(dev);
+
+	/* read in the register data, 16 bits msb first */
+	for (i=0; i<16; i++)
+		ns83820_mii_write_bit(dev, (data >> (15 - i)) & 1);
+
+	return data;
+}
+
+static void ns83820_probe_phy(struct ns83820 *dev)
+{
+	static int first;
+	int i;
+#define MII_PHYIDR1	0x02
+#define MII_PHYIDR2	0x03
+
+#if 0
+	if (!first) {
+		unsigned tmp;
+		ns83820_mii_read_reg(dev, 1, 0x09);
+		ns83820_mii_write_reg(dev, 1, 0x10, 0x0d3e);
+
+		tmp = ns83820_mii_read_reg(dev, 1, 0x00);
+		ns83820_mii_write_reg(dev, 1, 0x00, tmp | 0x8000);
+		udelay(1300);
+		ns83820_mii_read_reg(dev, 1, 0x09);
+	}
+#endif
+	first = 1;
+
+	for (i=1; i<2; i++) {
+		int j;
+		unsigned a, b;
+		a = ns83820_mii_read_reg(dev, i, MII_PHYIDR1);
+		b = ns83820_mii_read_reg(dev, i, MII_PHYIDR2);
+
+		//printk("%s: phy %d: 0x%04x 0x%04x\n",
+		//	dev->net_dev.name, i, a, b);
+
+		for (j=0; j<0x16; j+=4) {
+			dprintk("%s: [0x%02x] %04x %04x %04x %04x\n",
+				dev->net_dev.name, j,
+				ns83820_mii_read_reg(dev, i, 0 + j),
+				ns83820_mii_read_reg(dev, i, 1 + j),
+				ns83820_mii_read_reg(dev, i, 2 + j),
+				ns83820_mii_read_reg(dev, i, 3 + j)
+				);
+		}
+	}
+	{
+		unsigned a, b;
+		/* read firmware version: memory addr is 0x8402 and 0x8403 */
+		ns83820_mii_write_reg(dev, 1, 0x16, 0x000d);
+		ns83820_mii_write_reg(dev, 1, 0x1e, 0x810e);
+		a = ns83820_mii_read_reg(dev, 1, 0x1d);
+
+		ns83820_mii_write_reg(dev, 1, 0x16, 0x000d);
+		ns83820_mii_write_reg(dev, 1, 0x1e, 0x810e);
+		b = ns83820_mii_read_reg(dev, 1, 0x1d);
+		dprintk("version: 0x%04x 0x%04x\n", a, b);
+	}
+}
+
 static int __devinit ns83820_init_one(struct pci_dev *pci_dev, const struct pci_device_id *id)
 {
 	struct ns83820 *dev;
@@ -1415,6 +1765,7 @@
 	int err;
 	int using_dac = 0;
 
+	/* See if we can set the dma mask early on; failure is fatal. */
 	if (TRY_DAC && !pci_set_dma_mask(pci_dev, 0xffffffffffffffff)) {
 		using_dac = 1;
 	} else if (!pci_set_dma_mask(pci_dev, 0xffffffff)) {
@@ -1443,7 +1794,7 @@
 
 	err = pci_enable_device(pci_dev);
 	if (err) {
-		printk(KERN_INFO "ns83820: pci_enable_dev: %d\n", err);
+		printk(KERN_INFO "ns83820: pci_enable_dev failed: %d\n", err);
 		goto out_free;
 	}
 
@@ -1461,6 +1812,7 @@
 	dprintk("%p: %08lx  %p: %08lx\n",
 		dev->tx_descs, (long)dev->tx_phy_descs,
 		dev->rx_info.descs, (long)dev->rx_info.phy_descs);
+
 	/* disable interrupts */
 	writel(0, dev->base + IMR);
 	writel(0, dev->base + IER);
@@ -1479,45 +1831,47 @@
 		goto out_unmap;
 	}
 
-	if(register_netdev(&dev->net_dev)) goto out_unmap;
+	err = register_netdev(&dev->net_dev);
+	if (err) {
+		printk(KERN_INFO "ns83820: unable to register netdev: %d\n", err);
+		goto out_unmap;
+	}
+
+	printk("%s: ns83820.c: 0x22c: %08x, subsystem: %04x:%04x\n",
+		dev->net_dev.name, le32_to_cpu(readl(dev->base + 0x22c)),
+		pci_dev->subsystem_vendor, pci_dev->subsystem_device);
 
 	dev->net_dev.open = ns83820_open;
 	dev->net_dev.stop = ns83820_stop;
 	dev->net_dev.hard_start_xmit = ns83820_hard_start_xmit;
-	dev->net_dev.change_mtu = ns83820_change_mtu;
 	dev->net_dev.get_stats = ns83820_get_stats;
 	dev->net_dev.change_mtu = ns83820_change_mtu;
 	dev->net_dev.set_multicast_list = ns83820_set_multicast;
 	dev->net_dev.do_ioctl = ns83820_ioctl;
-	//FIXME: dev->net_dev.tx_timeout = ns83820_tx_timeout;
+	dev->net_dev.tx_timeout = ns83820_tx_timeout;
+	dev->net_dev.watchdog_timeo = 5 * HZ;
 
 	pci_set_drvdata(pci_dev, dev);
 
 	ns83820_do_reset(dev, CR_RST);
 
-	dprintk("start bist\n");
-	writel(PTSCR_EEBIST_EN, dev->base + PTSCR);
-	do {
-		schedule();
-	} while (readl(dev->base + PTSCR) & PTSCR_EEBIST_EN);
-	dprintk("done bist\n");
-
-	dprintk("start eeload\n");
-	writel(PTSCR_EELOAD_EN, dev->base + PTSCR);
-	do {
-		schedule();
-	} while (readl(dev->base + PTSCR) & PTSCR_EELOAD_EN);
-	dprintk("done eeload\n");
+	/* Must reset the ram bist before running it */
+	writel(PTSCR_RBIST_RST, dev->base + PTSCR);
+	ns83820_run_bist(dev, "sram bist",   PTSCR_RBIST_EN,
+			 PTSCR_RBIST_DONE, PTSCR_RBIST_FAIL);
+	ns83820_run_bist(dev, "eeprom bist", PTSCR_EEBIST_EN, 0,
+			 PTSCR_EEBIST_FAIL);
+	ns83820_run_bist(dev, "eeprom load", PTSCR_EELOAD_EN, 0, 0);
 
 	/* I love config registers */
 	dev->CFG_cache = readl(dev->base + CFG);
 
 	if ((dev->CFG_cache & CFG_PCI64_DET)) {
-		printk("%s: detected 64 bit PCI data bus.\n",
+		printk(KERN_INFO "%s: detected 64 bit PCI data bus.\n",
 			dev->net_dev.name);
 		/*dev->CFG_cache |= CFG_DATA64_EN;*/
 		if (!(dev->CFG_cache & CFG_DATA64_EN))
-			printk("%s: EEPROM did not enable 64 bit bus.  Disabled.\n",
+			printk(KERN_INFO "%s: EEPROM did not enable 64 bit bus.  Disabled.\n",
 				dev->net_dev.name);
 	} else
 		dev->CFG_cache &= ~(CFG_DATA64_EN);
@@ -1529,6 +1883,11 @@
 			  CFG_EXTSTS_EN   | CFG_EXD         | CFG_PESEL;
 	dev->CFG_cache |= CFG_REQALG;
 	dev->CFG_cache |= CFG_POW;
+	dev->CFG_cache |= CFG_TMRTEST;
+
+	/* When compiled with 64 bit addressing, we must always enable
+	 * the 64 bit descriptor format.
+	 */
 #ifdef USE_64BIT_ADDR
 	dev->CFG_cache |= CFG_M64ADDR;
 #endif
@@ -1540,7 +1899,8 @@
 
 	/* setup optical transceiver if we have one */
 	if (dev->CFG_cache & CFG_TBI_EN) {
-		printk("%s: enabling optical transceiver\n", dev->net_dev.name);
+		printk(KERN_INFO "%s: enabling optical transceiver\n",
+			dev->net_dev.name);
 		writel(readl(dev->base + GPIOR) | 0x3e8, dev->base + GPIOR);
 
 		/* setup auto negotiation feature advertisement */
@@ -1560,6 +1920,14 @@
 	writel(dev->CFG_cache, dev->base + CFG);
 	dprintk("CFG: %08x\n", dev->CFG_cache);
 
+	if (reset_phy) {
+		printk(KERN_INFO "%s: resetting phy\n", dev->net_dev.name);
+		writel(dev->CFG_cache | CFG_PHY_RST, dev->base + CFG);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout((HZ+99)/100);
+		writel(dev->CFG_cache, dev->base + CFG);
+	}
+
 #if 0	/* Huh?  This sets the PCI latency register.  Should be done via 
 	 * the PCI layer.  FIXME.
 	 */
@@ -1572,7 +1940,9 @@
 	 * can be transmitted is 8192 - FLTH - burst size.
 	 * If only the transmit fifo was larger...
 	 */
-	writel(TXCFG_CSI | TXCFG_HBI | TXCFG_ATP | TXCFG_MXDMA1024
+	/* Ramit : 1024 DMA is not a good idea, it ends up banging 
+	 * some DELL and COMPAQ SMP systems */
+	writel(TXCFG_CSI | TXCFG_HBI | TXCFG_ATP | TXCFG_MXDMA512
 		| ((1600 / 32) * 0x100),
 		dev->base + TXCFG);
 
@@ -1582,12 +1952,15 @@
 	writel(0x000, dev->base + IHR);
 
 	/* Set Rx to full duplex, don't accept runt, errored, long or length
-	 * range errored packets.  Set MXDMA to 0 => 1024 word burst
+	 * range errored packets.  Use 512 byte DMA.
 	 */
+	/* Ramit : 1024 DMA is not a good idea, it ends up banging 
+	 * some DELL and COMPAQ SMP systems 
+	 * Turn on ALP, only we are accpeting Jumbo Packets */
 	writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
 		| RXCFG_STRIPCRC
-		| RXCFG_ALP
-		| (RXCFG_MXDMA0 * 0) | 0, dev->base + RXCFG);
+		//| RXCFG_ALP
+		| (RXCFG_MXDMA512) | 0, dev->base + RXCFG);
 
 	/* Disable priority queueing */
 	writel(0, dev->base + PQCR);
@@ -1597,13 +1970,23 @@
 	 * revision of the chip does not properly accept IP fragments
 	 * at least for UDP.
 	 */
+	/* Ramit : Be sure to turn on RXCFG_ARP if VLAN's are enabled, since
+	 * the MAC it calculates the packetsize AFTER stripping the VLAN
+	 * header, and if a VLAN Tagged packet of 64 bytes is received (like
+	 * a ping with a VLAN header) then the card, strips the 4 byte VLAN
+	 * tag and then checks the packet size, so if RXCFG_ARP is not enabled,
+	 * it discrards it!.  These guys......
+	 */
 	writel(VRCR_IPEN | VRCR_VTDEN, dev->base + VRCR);
 
 	/* Enable per-packet TCP/UDP/IP checksumming */
 	writel(VTCR_PPCHK, dev->base + VTCR);
 
-	/* Disable Pause frames */
-	writel(0, dev->base + PCR);
+	/* Ramit : Enable async and sync pause frames */
+	/* writel(0, dev->base + PCR); */
+	writel((PCR_PS_MCAST | PCR_PS_DA | PCR_PSEN | PCR_FFLO_4K |
+		PCR_FFHI_8K | PCR_STLO_4 | PCR_STHI_8 | PCR_PAUSE_CNT),
+		dev->base + PCR);
 
 	/* Disable Wake On Lan */
 	writel(0, dev->base + WCSR);
@@ -1631,6 +2014,10 @@
 		(dev->net_dev.features & NETIF_F_HIGHDMA) ? "h,sg" : "sg"
 		);
 
+#ifdef PHY_CODE_IS_FINISHED
+	ns83820_probe_phy(dev);
+#endif
+
 	return 0;
 
 out_unmap:
@@ -1670,7 +2057,7 @@
 }
 
 static struct pci_device_id ns83820_pci_tbl[] __devinitdata = {
-	{ 0x100b, 0x0022, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
+	{ 0x100b, 0x0022, PCI_ANY_ID, PCI_ANY_ID, 0, .driver_data = 0, },
 	{ 0, },
 };
 
@@ -1703,5 +2090,14 @@
 
 MODULE_DEVICE_TABLE(pci, ns83820_pci_tbl);
 
+MODULE_PARM(lnksts, "i");
+MODULE_PARM_DESC(lnksts, "Polarity of LNKSTS bit");
+
+MODULE_PARM(ihr, "i");
+MODULE_PARM_DESC(ihr, "Time in 100 us increments to delay interrupts (range 0-127)");
+
+MODULE_PARM(reset_phy, "i");
+MODULE_PARM_DESC(reset_phy, "Set to 1 to reset the PHY on startup");
+
 module_init(ns83820_init);
 module_exit(ns83820_exit);
diff -urN linus-2.5/fs/aio.c aio-2.5/fs/aio.c
--- linus-2.5/fs/aio.c	Tue Oct  8 18:30:28 2002
+++ aio-2.5/fs/aio.c	Tue Oct  8 18:28:53 2002
@@ -35,6 +35,7 @@
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
+#include <asm/mmu_context.h>
 
 #if DEBUG > 1
 #define dprintk		printk
@@ -59,6 +60,8 @@
 static spinlock_t	fput_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(fput_head);
 
+static void aio_kick_handler(void *);
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -175,31 +178,28 @@
 	return 0;
 }
 
+
 /* aio_ring_event: returns a pointer to the event at the given index from
  * kmap_atomic(, km).  Release the pointer with put_aio_ring_event();
  */
-static inline struct io_event *aio_ring_event(struct aio_ring_info *info, int nr, enum km_type km)
-{
-	struct io_event *events;
 #define AIO_EVENTS_PER_PAGE	(PAGE_SIZE / sizeof(struct io_event))
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
+#define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-	if (nr < AIO_EVENTS_FIRST_PAGE) {
-		struct aio_ring *ring;
-		ring = kmap_atomic(info->ring_pages[0], km);
-		return &ring->io_events[nr];
-	}
-	nr -= AIO_EVENTS_FIRST_PAGE;
-
-	events = kmap_atomic(info->ring_pages[1 + nr / AIO_EVENTS_PER_PAGE], km);
-
-	return events + (nr % AIO_EVENTS_PER_PAGE);
-}
-
-static inline void put_aio_ring_event(struct io_event *event, enum km_type km)
-{
-	kunmap_atomic((void *)((unsigned long)event & PAGE_MASK), km);
-}
+#define aio_ring_event(info, nr, km) ({					\
+	unsigned pos = (nr) + AIO_EVENTS_OFFSET;			\
+	struct io_event *__event;					\
+	__event = kmap_atomic(						\
+			(info)->ring_pages[pos / AIO_EVENTS_PER_PAGE], km); \
+	__event += pos % AIO_EVENTS_PER_PAGE;				\
+	__event;							\
+})
+
+#define put_aio_ring_event(event, km) do {	\
+	struct io_event *__event = (event);	\
+	(void)__event;				\
+	kunmap_atomic((void *)((unsigned long)__event & PAGE_MASK), km); \
+} while(0)
 
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
@@ -234,14 +234,18 @@
 	init_waitqueue_head(&ctx->wait);
 
 	INIT_LIST_HEAD(&ctx->active_reqs);
+	INIT_LIST_HEAD(&ctx->run_list);
+	INIT_WORK(&ctx->wq, aio_kick_handler, ctx);
 
 	if (aio_setup_ring(ctx) < 0)
 		goto out_freectx;
 
-	/* now link into global list.  kludge.  FIXME */
+	/* limit the number of system wide aios */
 	atomic_add(ctx->max_reqs, &aio_nr);	/* undone by __put_ioctx */
 	if (unlikely(atomic_read(&aio_nr) > aio_max_nr))
 		goto out_cleanup;
+
+	/* now link into global list.  kludge.  FIXME */
 	write_lock(&mm->ioctx_list_lock);
 	ctx->next = mm->ioctx_list;
 	mm->ioctx_list = ctx;
@@ -383,17 +387,26 @@
 {
 	struct kiocb *req = NULL;
 	struct aio_ring *ring;
+	int okay = 0;
 
 	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
 	if (unlikely(!req))
 		return NULL;
 
+	req->ki_flags = 1 << KIF_LOCKED;
+	req->ki_users = 1;
+	req->ki_key = 0;
+	req->ki_ctx = ctx;
+	req->ki_cancel = NULL;
+	req->ki_retry = NULL;
+	req->ki_user_obj = NULL;
+
 	/* Check if the completion queue has enough free space to
 	 * accept an event from this io.
 	 */
 	spin_lock_irq(&ctx->ctx_lock);
 	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
-	if (likely(ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring))) {
+	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
 		list_add(&req->ki_list, &ctx->active_reqs);
 		get_ioctx(ctx);
 		ctx->reqs_active++;
@@ -402,11 +415,16 @@
 		req->ki_users = 1;
 	} else {
 		kmem_cache_free(kiocb_cachep, req);
-		req = NULL;
+		okay = 1;
 	}
 	kunmap_atomic(ring, KM_USER0);
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	if (!okay) {
+		kmem_cache_free(kiocb_cachep, req);
+		req = NULL;
+	}
+
 	return req;
 }
 
@@ -476,6 +494,7 @@
 		return 0;
 	list_del(&req->ki_list);		/* remove from active_reqs */
 	req->ki_cancel = NULL;
+	req->ki_retry = NULL;
 
 	/* Must be done under the lock to serialise against cancellation.
 	 * Call this aio_fput as it duplicates fput via the fput_work.
@@ -527,6 +546,82 @@
 	return ioctx;
 }
 
+static void use_mm(struct mm_struct *mm)
+{
+	struct mm_struct *active_mm = current->active_mm;
+	atomic_inc(&mm->mm_count);
+	current->mm = mm;
+	if (mm != active_mm) {
+		current->active_mm = mm;
+		activate_mm(active_mm, mm);
+	}
+	mmdrop(active_mm);
+}
+
+static void unuse_mm(struct mm_struct *mm)
+{
+	current->mm = NULL;
+	/* active_mm is still 'mm' */
+	enter_lazy_tlb(mm, current, smp_processor_id());
+}
+
+/* Run on kevent's context.  FIXME: needs to be per-cpu and warn if an
+ * operation blocks.
+ */
+static void aio_kick_handler(void *data)
+{
+	struct kioctx *ctx = data;
+
+	use_mm(ctx->mm);
+
+	spin_lock_irq(&ctx->ctx_lock);
+	while (!list_empty(&ctx->run_list)) {
+		struct kiocb *iocb;
+		long ret;
+
+		iocb = list_entry(ctx->run_list.next, struct kiocb,
+				  ki_run_list);
+		list_del(&iocb->ki_run_list);
+		iocb->ki_users ++;
+		spin_unlock_irq(&ctx->ctx_lock);
+
+		kiocbClearKicked(iocb);
+		ret = iocb->ki_retry(iocb);
+		if (-EIOCBQUEUED != ret) {
+			aio_complete(iocb, ret, 0);
+			iocb = NULL;
+		}
+
+		spin_lock_irq(&ctx->ctx_lock);
+		if (NULL != iocb)
+			__aio_put_req(ctx, iocb);
+	}
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	unuse_mm(ctx->mm);
+}
+
+void kick_iocb(struct kiocb *iocb)
+{
+	struct kioctx	*ctx = iocb->ki_ctx;
+
+	/* sync iocbs are easy: they can only ever be executing from a 
+	 * single context. */
+	if (is_sync_kiocb(iocb)) {
+		kiocbSetKicked(iocb);
+		wake_up_process(iocb->ki_user_obj);
+		return;
+	}
+
+	if (!kiocbTryKick(iocb)) {
+		long flags;
+		spin_lock_irqsave(&ctx->ctx_lock, flags);
+		list_add_tail(&iocb->ki_run_list, &ctx->run_list);
+		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+		schedule_work(&ctx->wq);
+	}
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  *	Returns true if this is the last user of the request.  The 
@@ -548,7 +643,7 @@
 	 * case the usage count checks will have to move under ctx_lock
 	 * for all cases.
 	 */
-	if (ctx == &ctx->mm->default_kioctx) {
+	if (is_sync_kiocb(iocb)) {
 		int ret;
 
 		iocb->ki_user_data = res;
@@ -560,7 +655,10 @@
 		iocb->ki_users--;
 		ret = (0 == iocb->ki_users);
 		spin_unlock_irq(&ctx->ctx_lock);
-		return 0;
+
+		/* sync iocbs put the task here for us */
+		wake_up_process(iocb->ki_user_obj);
+		return ret;
 	}
 
 	info = &ctx->ring_info;
@@ -940,6 +1038,7 @@
 
 	req->ki_user_obj = user_iocb;
 	req->ki_user_data = iocb->aio_data;
+	req->ki_pos = iocb->aio_offset;
 
 	buf = (char *)(unsigned long)iocb->aio_buf;
 
@@ -954,7 +1053,7 @@
 		ret = -EINVAL;
 		if (file->f_op->aio_read)
 			ret = file->f_op->aio_read(req, buf,
-					iocb->aio_nbytes, iocb->aio_offset);
+					iocb->aio_nbytes, req->ki_pos);
 		break;
 	case IOCB_CMD_PWRITE:
 		ret = -EBADF;
@@ -966,7 +1065,7 @@
 		ret = -EINVAL;
 		if (file->f_op->aio_write)
 			ret = file->f_op->aio_write(req, buf,
-					iocb->aio_nbytes, iocb->aio_offset);
+					iocb->aio_nbytes, req->ki_pos);
 		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
@@ -983,12 +1082,10 @@
 		ret = -EINVAL;
 	}
 
-	if (likely(EIOCBQUEUED == ret))
+	if (likely(-EIOCBQUEUED == ret))
 		return 0;
-	if (ret >= 0) {
-		aio_complete(req, ret, 0);
-		return 0;
-	}
+	aio_complete(req, ret, 0);
+	return 0;
 
 out_put_req:
 	aio_put_req(req);
diff -urN linus-2.5/fs/exec.c aio-2.5/fs/exec.c
--- linus-2.5/fs/exec.c	Tue Oct  8 18:30:28 2002
+++ aio-2.5/fs/exec.c	Tue Oct  8 18:23:56 2002
@@ -131,7 +131,7 @@
 		goto out;
 
 	error = -ENOEXEC;
-	if(file->f_op && file->f_op->read) {
+	if(file->f_op) {
 		struct linux_binfmt * fmt;
 
 		read_lock(&binfmt_lock);
@@ -453,19 +453,16 @@
 }
 
 int kernel_read(struct file *file, unsigned long offset,
-	char * addr, unsigned long count)
+	char *addr, unsigned long count)
 {
 	mm_segment_t old_fs;
 	loff_t pos = offset;
-	int result = -ENOSYS;
+	int result;
 
-	if (!file->f_op->read)
-		goto fail;
 	old_fs = get_fs();
 	set_fs(get_ds());
-	result = file->f_op->read(file, addr, count, &pos);
+	result = vfs_read(file, addr, count, &pos);
 	set_fs(old_fs);
-fail:
 	return result;
 }
 
diff -urN linus-2.5/fs/ext2/file.c aio-2.5/fs/ext2/file.c
--- linus-2.5/fs/ext2/file.c	Tue Oct  8 18:30:29 2002
+++ aio-2.5/fs/ext2/file.c	Tue Oct  8 18:23:56 2002
@@ -41,6 +41,8 @@
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
 	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.ioctl		= ext2_ioctl,
 	.mmap		= generic_file_mmap,
 	.open		= generic_file_open,
diff -urN linus-2.5/fs/ext3/file.c aio-2.5/fs/ext3/file.c
--- linus-2.5/fs/ext3/file.c	Tue Oct  8 18:30:29 2002
+++ aio-2.5/fs/ext3/file.c	Tue Oct  8 18:23:56 2002
@@ -58,8 +58,9 @@
  */
 
 static ssize_t
-ext3_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+ext3_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
 
 	/*
@@ -72,13 +73,15 @@
 	if (IS_SYNC(inode) || (file->f_flags & O_SYNC))
 		mark_inode_dirty(inode);
 
-	return generic_file_write(file, buf, count, ppos);
+	return generic_file_aio_write(iocb, buf, count, pos);
 }
 
 struct file_operations ext3_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= ext3_file_write,
+	.read		= do_sync_read,
+	.write		= do_sync_write,
+	.aio_read		= generic_file_aio_read,
+	.aio_write		= ext3_file_write,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
diff -urN linus-2.5/fs/nfs/file.c aio-2.5/fs/nfs/file.c
--- linus-2.5/fs/nfs/file.c	Tue Oct  8 18:30:37 2002
+++ aio-2.5/fs/nfs/file.c	Tue Oct  8 18:23:57 2002
@@ -35,15 +35,17 @@
 #define NFSDBG_FACILITY		NFSDBG_FILE
 
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
-static ssize_t nfs_file_read(struct file *, char *, size_t, loff_t *);
-static ssize_t nfs_file_write(struct file *, const char *, size_t, loff_t *);
+static ssize_t nfs_file_read(struct kiocb *, char *, size_t, loff_t);
+static ssize_t nfs_file_write(struct kiocb *, const char *, size_t, loff_t);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 
 struct file_operations nfs_file_operations = {
 	.llseek		= remote_llseek,
-	.read		= nfs_file_read,
-	.write		= nfs_file_write,
+	.read		= do_sync_read,
+	.write		= do_sync_write,
+	.aio_read		= nfs_file_read,
+	.aio_write		= nfs_file_write,
 	.mmap		= nfs_file_mmap,
 	.open		= nfs_open,
 	.flush		= nfs_file_flush,
@@ -89,19 +91,19 @@
 }
 
 static ssize_t
-nfs_file_read(struct file * file, char * buf, size_t count, loff_t *ppos)
+nfs_file_read(struct kiocb *iocb, char * buf, size_t count, loff_t pos)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 
 	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		(unsigned long) count, (unsigned long) *ppos);
+		(unsigned long) count, (unsigned long) pos);
 
 	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (!result)
-		result = generic_file_read(file, buf, count, ppos);
+		result = generic_file_aio_read(iocb, buf, count, pos);
 	return result;
 }
 
@@ -209,15 +211,15 @@
  * Write to a file (through the page cache).
  */
 static ssize_t
-nfs_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+nfs_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 
 	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		inode->i_ino, (unsigned long) count, (unsigned long) *ppos);
+		inode->i_ino, (unsigned long) count, (unsigned long) pos);
 
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
@@ -230,7 +232,7 @@
 	if (!count)
 		goto out;
 
-	result = generic_file_write(file, buf, count, ppos);
+	result = generic_file_aio_write(iocb, buf, count, pos);
 out:
 	return result;
 
diff -urN linus-2.5/fs/read_write.c aio-2.5/fs/read_write.c
--- linus-2.5/fs/read_write.c	Tue Oct  8 18:30:28 2002
+++ aio-2.5/fs/read_write.c	Tue Oct  8 18:23:56 2002
@@ -176,6 +176,20 @@
 }
 #endif
 
+ssize_t do_sync_read(struct file *filp, char *buf, size_t len, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	kiocb.ki_pos = *ppos;
+	ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
+	return ret;
+}
+
 ssize_t vfs_read(struct file *file, char *buf, size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -183,14 +197,17 @@
 
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
-	if (!file->f_op || !file->f_op->read)
+	if (!file->f_op || (!file->f_op->read && !file->f_op->aio_read))
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
 		ret = security_ops->file_permission (file, MAY_READ);
 		if (!ret) {
-			ret = file->f_op->read(file, buf, count, pos);
+			if (file->f_op->read)
+				ret = file->f_op->read(file, buf, count, pos);
+			else
+				ret = do_sync_read(file, buf, count, pos);
 			if (ret > 0)
 				dnotify_parent(file->f_dentry, DN_ACCESS);
 		}
@@ -199,6 +216,20 @@
 	return ret;
 }
 
+ssize_t do_sync_write(struct file *filp, const char *buf, size_t len, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	kiocb.ki_pos = *ppos;
+	ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	*ppos = kiocb.ki_pos;
+	return ret;
+}
+
 ssize_t vfs_write(struct file *file, const char *buf, size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -206,14 +237,17 @@
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
-	if (!file->f_op || !file->f_op->write)
+	if (!file->f_op || (!file->f_op->write && !file->f_op->aio_write))
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
 		ret = security_ops->file_permission (file, MAY_WRITE);
 		if (!ret) {
-			ret = file->f_op->write(file, buf, count, pos);
+			if (file->f_op->write)
+				ret = file->f_op->write(file, buf, count, pos);
+			else
+				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0)
 				dnotify_parent(file->f_dentry, DN_MODIFY);
 		}
diff -urN linus-2.5/include/linux/aio.h aio-2.5/include/linux/aio.h
--- linus-2.5/include/linux/aio.h	Thu Oct  3 15:47:07 2002
+++ aio-2.5/include/linux/aio.h	Tue Oct  8 18:23:59 2002
@@ -2,10 +2,11 @@
 #define __LINUX__AIO_H
 
 #include <linux/list.h>
-#include <asm/atomic.h>
-
+#include <linux/workqueue.h>
 #include <linux/aio_abi.h>
 
+#include <asm/atomic.h>
+
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
 
@@ -22,28 +23,54 @@
 
 #define KIOCB_SYNC_KEY		(~0U)
 
-#define KIOCB_PRIVATE_SIZE	(16 * sizeof(long))
+#define KIOCB_PRIVATE_SIZE	(24 * sizeof(long))
+
+/* ki_flags bits */
+#define KIF_LOCKED		0
+#define KIF_KICKED		1
+#define KIF_CANCELLED		2
+
+#define kiocbTryLock(iocb)	test_and_set_bit(KIF_LOCKED, &(iocb)->ki_flags)
+#define kiocbTryKick(iocb)	test_and_set_bit(KIF_KICKED, &(iocb)->ki_flags)
+
+#define kiocbSetLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
+#define kiocbSetKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbSetCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+
+#define kiocbClearLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
+#define kiocbClearKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbClearCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+
+#define kiocbIsLocked(iocb)	test_bit(0, &(iocb)->ki_flags)
+#define kiocbIsKicked(iocb)	test_bit(1, &(iocb)->ki_flags)
+#define kiocbIsCancelled(iocb)	test_bit(2, &(iocb)->ki_flags)
 
 struct kiocb {
+	struct list_head	ki_run_list;
+	long			ki_flags;
 	int			ki_users;
 	unsigned		ki_key;		/* id of this request */
 
 	struct file		*ki_filp;
 	struct kioctx		*ki_ctx;	/* may be NULL for sync ops */
 	int			(*ki_cancel)(struct kiocb *, struct io_event *);
+	long			(*ki_retry)(struct kiocb *);
 
-	struct list_head	ki_list;
+	struct list_head	ki_list;	/* the aio core uses this
+						 * for cancellation */
 
-	void			*ki_data;	/* for use by the the file */
 	void			*ki_user_obj;	/* pointer to userland's iocb */
 	__u64			ki_user_data;	/* user's data for completion */
+	loff_t			ki_pos;
 
-	long			private[KIOCB_PRIVATE_SIZE/sizeof(long)];
+	char			private[KIOCB_PRIVATE_SIZE];
 };
 
+#define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
 #define init_sync_kiocb(x, filp)			\
 	do {						\
 		struct task_struct *tsk = current;	\
+		(x)->ki_flags = 0;			\
 		(x)->ki_users = 1;			\
 		(x)->ki_key = KIOCB_SYNC_KEY;		\
 		(x)->ki_filp = (filp);			\
@@ -101,10 +128,13 @@
 
 	int			reqs_active;
 	struct list_head	active_reqs;	/* used for cancellation */
+	struct list_head	run_list;	/* used for kicked reqs */
 
 	unsigned		max_reqs;
 
 	struct aio_ring_info	ring_info;
+
+	struct work_struct	wq;
 };
 
 /* prototypes */
@@ -112,6 +142,7 @@
 
 extern ssize_t FASTCALL(wait_on_sync_kiocb(struct kiocb *iocb));
 extern int FASTCALL(aio_put_req(struct kiocb *iocb));
+extern void FASTCALL(kick_iocb(struct kiocb *iocb));
 extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
 extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
 struct mm_struct;
diff -urN linus-2.5/include/linux/fs.h aio-2.5/include/linux/fs.h
--- linus-2.5/include/linux/fs.h	Tue Oct  8 18:30:47 2002
+++ aio-2.5/include/linux/fs.h	Tue Oct  8 18:23:59 2002
@@ -747,7 +747,7 @@
 	ssize_t (*read) (struct file *, char *, size_t, loff_t *);
 	ssize_t (*aio_read) (struct kiocb *, char *, size_t, loff_t);
 	ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
-	ssize_t (*aio_write) (struct kiocb *, char *, size_t, loff_t);
+	ssize_t (*aio_write) (struct kiocb *, const char *, size_t, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1239,6 +1239,10 @@
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
+extern ssize_t generic_file_aio_read(struct kiocb *, char *, size_t, loff_t);
+extern ssize_t generic_file_aio_write(struct kiocb *, const char *, size_t, loff_t);
+extern ssize_t do_sync_read(struct file *filp, char *buf, size_t len, loff_t *ppos);
+extern ssize_t do_sync_write(struct file *filp, const char *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, struct file *, loff_t *, size_t);
diff -urN linus-2.5/include/linux/kernel.h aio-2.5/include/linux/kernel.h
--- linus-2.5/include/linux/kernel.h	Tue Oct  8 18:30:47 2002
+++ aio-2.5/include/linux/kernel.h	Tue Oct  8 18:23:59 2002
@@ -201,6 +201,9 @@
 
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 
+extern void BUILD_BUG(void);
+#define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
+
 /* Trap pasters of __FUNCTION__ at compile-time */
 #if __GNUC__ > 2 || __GNUC_MINOR__ >= 95
 #define __FUNCTION__ (__func__)
diff -urN linus-2.5/mm/filemap.c aio-2.5/mm/filemap.c
--- linus-2.5/mm/filemap.c	Tue Oct  8 18:30:51 2002
+++ aio-2.5/mm/filemap.c	Tue Oct  8 18:24:00 2002
@@ -885,11 +885,12 @@
 }
 
 ssize_t
-generic_file_aio_read(struct kiocb *iocb, char *buf, size_t count, loff_t *ppos)
+generic_file_aio_read(struct kiocb *iocb, char *buf, size_t count, loff_t pos)
 {
 	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
 
-	return __generic_file_aio_read(iocb, &local_iov, 1, ppos);
+	BUG_ON(iocb->ki_pos != pos);
+	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
 }
 
 ssize_t
@@ -1645,6 +1646,12 @@
 	return err;
 }
 
+ssize_t generic_file_aio_write(struct kiocb *iocb, const char *buf,
+			       size_t count, loff_t pos)
+{
+	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
+}
+
 ssize_t generic_file_write(struct file *file, const char *buf,
 			   size_t count, loff_t *ppos)
 {

