Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269774AbRHEP66>; Sun, 5 Aug 2001 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269766AbRHEP6y>; Sun, 5 Aug 2001 11:58:54 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:23682 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269973AbRHEP6o>; Sun, 5 Aug 2001 11:58:44 -0400
Date: Sun, 5 Aug 2001 11:58:52 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Craig Spurgeon <cspurgeon@applianceware.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: NatSemi DP83820 driver problem
In-Reply-To: <3B5DECD6.B4351288@applianceware.com>
Message-ID: <Pine.LNX.4.33.0108051154590.12183-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2001, Craig Spurgeon wrote:

> We have an Asante GigaNIX 1000T Gigabit Ethernet adapter that we are
> trying to get to work under kernel 2.4.6ac5.

> If anyone has gotten the Scyld driver to work under 2.4.x, we'd
> really appreciate the info.

Well, I ended up writing a driver for another card based on the DP83820.
Here's my driver -- it has a few known problems in that it isn't
completely up to snuff wrt the pci dma api, but it works well under x86,
including surviving stress testing with rx and tx buffer under/overruns.
If you could give it a whirl and report any problems to me, I'd appreciate
it.

		-ben

diff -x .* -urN v2.4.6-pre8/drivers/net/Config.in pgc-2.4.6-pre8/drivers/net/Config.in
--- v2.4.6-pre8/drivers/net/Config.in	Sat Jun 30 14:04:27 2001
+++ pgc-2.4.6-pre8/drivers/net/Config.in	Mon Jul  9 21:20:27 2001
@@ -212,6 +212,7 @@
    bool '  Omit support for old Tigon I based AceNICs' CONFIG_ACENIC_OMIT_TIGON_I
 fi
 dep_tristate 'MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS $CONFIG_SBUS
+dep_tristate 'National Semiconductor DP83820 support' CONFIG_NS83820 $CONFIG_PCI
 dep_tristate 'Broadcom BCM570 support ' CONFIG_NET_BROADCOM $CONFIG_PCI m
 dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONFIG_PCI
 dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)' CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
diff -x .* -urN v2.4.6-pre8/drivers/net/Makefile pgc-2.4.6-pre8/drivers/net/Makefile
--- v2.4.6-pre8/drivers/net/Makefile	Sat Jun 30 14:04:27 2001
+++ pgc-2.4.6-pre8/drivers/net/Makefile	Mon Jul  9 21:19:40 2001
@@ -74,6 +74,7 @@
 obj-$(CONFIG_DM9102) += dmfe.o
 obj-$(CONFIG_YELLOWFIN) += yellowfin.o
 obj-$(CONFIG_ACENIC) += acenic.o
 obj-$(CONFIG_VETH) += veth.o
+obj-$(CONFIG_NS83820) += ns83820.o
 obj-$(CONFIG_NATSEMI) += natsemi.o
 obj-$(CONFIG_STNIC) += stnic.o 8390.o
diff -x .* -urN v2.4.6-pre8/drivers/net/ns83820.c pgc-2.4.6-pre8/drivers/net/ns83820.c
--- v2.4.6-pre8/drivers/net/ns83820.c	Wed Dec 31 19:00:00 1969
+++ pgc-2.4.6-pre8/drivers/net/ns83820.c	Fri Jul 20 17:15:11 2001
@@ -0,0 +1,1409 @@
+#define VERSION "0.5"
+/* ns83820.c by Benjamin LaHaise <bcrl@redhat.com>
+ * $Revision: 1.3 $
+ *
+ * Copyright 2001 Benjamin LaHaise.
+ * Copyright 2001 Red Hat.
+ *
+ * Mmmm, chocolate vanilla mocha...
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ * ChangeLog
+ * =========
+ *	20010414	0.1 - created
+ *	20010622	0.2 - basic rx and tx.
+ *	20010711	0.3 - added duplex and link state detection support.
+ *	20010713	0.4 - zero copy, no hangs.
+ *			0.5 - 64 bit dma support (davem will hate me for this)
+ *			    - disable jumbo frames to avoid tx hangs
+ *			    - work around tx deadlocks on my 1.02 card via
+ *			      fiddling with TXCFG
+ *
+ * Driver Overview
+ * ===============
+ *
+ * This driver was originally written for the National Semiconductor
+ * 83820 chip, a 10/100/1000 Mbps 64 bit PCI ethernet NIC.  Hopefully
+ * this code will turn out to be a) clean, b) correct, and c) fast.
+ * With that in mind, I'm aiming to split the code up as much as
+ * reasonably possible.  At present there are X major sections that
+ * break down into a) packet receive, b) packet transmit, c) link
+ * management, d) initialization and configuration.  Where possible,
+ * these code paths are designed to run in parallel.
+ *
+ */
+//#define dprintk		printk
+#define dprintk(x...)		/**/
+#define DEBUG_PROC
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/delay.h>
+#include <linux/smp_lock.h>
+#include <linux/tqueue.h>
+#include <linux/init.h>
+#include <linux/ip.h>	/* for iph */
+#include <linux/in.h>	/* for IPPROTO_... */
+#include <linux/eeprom.h>
+//#include <linux/skbrefill.h>
+
+#ifdef CONFIG_HIGHMEM64G
+//#define USE_64BIT_ADDR	/* Disabled for now as it doesn't work. */
+#endif
+
+/* Tell davem to fix the pci dma api.  Grrr. */
+/* stolen from acenic.c */
+#ifdef CONFIG_HIGHMEM
+#if defined(CONFIG_X86)
+#define DMAADDR_OFFSET  0
+typedef u64 dmaaddr_high_t;
+#elif defined(CONFIG_PPC)
+#define DMAADDR_OFFSET PCI_DRAM_OFFSET
+typedef unsigned long dmaaddr_high_t;
+#endif
+#define dmaaddr_high(a)		((u32)((a) >> 32))
+#define dmaaddr_low(a)		((u32)a)
+
+dmaaddr_high_t
+pci_map_single_high(struct pci_dev *hwdev, struct page *page,
+		    int offset, size_t size, int dir)
+{
+	u64 phys;
+	dmaaddr_high_t addr;
+	phys = page - mem_map;
+	phys <<= PAGE_SHIFT;
+	phys += offset;
+	phys += DMAADDR_OFFSET;
+	return phys;
+}
+#else
+
+typedef unsigned long dmaaddr_high_t;
+#define dmaaddr_high(a)		(0)
+#define dmaaddr_low(a)		(a)
+
+static inline dmaaddr_high_t
+pci_map_single_high(struct pci_dev *hwdev, struct page *page,
+		    int offset, size_t size, int dir)
+{
+	return pci_map_single(hwdev, page_address(page) + offset, size, dir);
+}
+#endif
+
+
+/* tunables */
+#define RX_BUF_SIZE	1536	/* 8192 */
+#define NR_RX_DESC	256
+
+#define NR_TX_DESC	256
+
+/* register defines */
+#define CFGCS		0x04
+
+#define CR_TXE		0x00000001
+#define CR_TXD		0x00000002
+#define CR_RXE		0x00000004
+#define CR_RXD		0x00000008
+#define CR_TXR		0x00000010
+#define CR_RXR		0x00000020
+#define CR_SWI		0x00000080
+#define CR_RST		0x00000100
+
+#define PTSCR_EEBIST_EN	0x00000002
+#define PTSCR_EELOAD_EN	0x00000004
+
+#define ISR_TXDESC3	0x40000000
+#define ISR_TXDESC2	0x20000000
+#define ISR_TXDESC1	0x10000000
+#define ISR_TXDESC0	0x08000000
+#define ISR_RXDESC3	0x04000000
+#define ISR_RXDESC2	0x02000000
+#define ISR_RXDESC1	0x01000000
+#define ISR_RXDESC0	0x00800000
+#define ISR_TXRCMP	0x00400000
+#define ISR_RXRCMP	0x00200000
+#define ISR_DPERR	0x00100000
+#define ISR_SSERR	0x00080000
+#define ISR_RMABT	0x00040000
+#define ISR_RTABT	0x00020000
+#define ISR_RXSOVR	0x00010000
+#define ISR_HIBINT	0x00008000
+#define ISR_PHY		0x00004000
+#define ISR_PME		0x00002000
+#define ISR_SWI		0x00001000
+#define ISR_MIB		0x00000800
+#define ISR_TXURN	0x00000400
+#define ISR_TXIDLE	0x00000200
+#define ISR_TXERR	0x00000100
+#define ISR_TXDESC	0x00000080
+#define ISR_TXOK	0x00000040
+#define ISR_RXORN	0x00000020
+#define ISR_RXIDLE	0x00000010
+#define ISR_RXEARLY	0x00000008
+#define ISR_RXERR	0x00000004
+#define ISR_RXDESC	0x00000002
+#define ISR_RXOK	0x00000001
+
+#define TXCFG_CSI	0x80000000
+#define TXCFG_HBI	0x40000000
+#define TXCFG_MLB	0x20000000
+#define TXCFG_ATP	0x10000000
+#define TXCFG_ECRETRY	0x00800000
+#define TXCFG_BRST_DIS	0x00080000
+#define TXCFG_MXDMA1024	0x00000000
+#define TXCFG_MXDMA512	0x00700000
+#define TXCFG_MXDMA256	0x00600000
+#define TXCFG_MXDMA128	0x00500000
+#define TXCFG_MXDMA64	0x00400000
+#define TXCFG_MXDMA32	0x00300000
+#define TXCFG_MXDMA16	0x00200000
+#define TXCFG_MXDMA8	0x00100000
+
+#define CFG_LNKSTS	0x80000000
+#define CFG_SPDSTS	0x60000000
+#define CFG_SPDSTS1	0x40000000
+#define CFG_SPDSTS0	0x20000000
+#define CFG_DUPSTS	0x10000000
+#define CFG_TBI_EN	0x01000000
+#define CFG_MODE_1000	0x00400000
+#define CFG_PINT_CTL	0x001c0000
+#define CFG_PINT_DUPSTS	0x00100000
+#define CFG_PINT_LNKSTS	0x00080000
+#define CFG_PINT_SPDSTS	0x00040000
+#define CFG_TMRTEST	0x00020000
+#define CFG_MRM_DIS	0x00010000
+#define CFG_MWI_DIS	0x00008000
+#define CFG_T64ADDR	0x00004000
+#define CFG_PCI64_DET	0x00002000
+#define CFG_DATA64_EN	0x00001000
+#define CFG_M64ADDR	0x00000800
+#define CFG_PHY_RST	0x00000400
+#define CFG_PHY_DIS	0x00000200
+#define CFG_EXTSTS_EN	0x00000100
+#define CFG_REQALG	0x00000080
+#define CFG_SB		0x00000040
+#define CFG_POW		0x00000020
+#define CFG_EXD		0x00000010
+#define CFG_PESEL	0x00000008
+#define CFG_BROM_DIS	0x00000004
+#define CFG_EXT_125	0x00000002
+#define CFG_BEM		0x00000001
+
+#define EXTSTS_UDPPKT	0x00200000
+#define EXTSTS_TCPPKT	0x00080000
+#define EXTSTS_IPPKT	0x00020000
+
+#define SPDSTS_POLARITY	(CFG_SPDSTS1 | CFG_SPDSTS0 | CFG_DUPSTS)
+
+#define MIBC_MIBS	0x00000008
+#define MIBC_ACLR	0x00000004
+#define MIBC_FRZ	0x00000002
+#define MIBC_WRN	0x00000001
+
+#define RXCFG_AEP	0x80000000
+#define RXCFG_ARP	0x40000000
+#define RXCFG_STRIPCRC	0x20000000
+#define RXCFG_RX_FD	0x10000000
+#define RXCFG_ALP	0x08000000
+#define RXCFG_AIRL	0x04000000
+#define RXCFG_MXDMA	0x00700000
+#define RXCFG_MXDMA0	0x00100000
+#define RXCFG_MXDMA64	0x00600000
+#define RXCFG_DRTH	0x0000003e
+#define RXCFG_DRTH0	0x00000002
+
+#define RFCR_RFEN	0x80000000
+#define RFCR_AAB	0x40000000
+#define RFCR_AAM	0x20000000
+#define RFCR_AAU	0x10000000
+#define RFCR_APM	0x08000000
+#define RFCR_APAT	0x07800000
+#define RFCR_APAT3	0x04000000
+#define RFCR_APAT2	0x02000000
+#define RFCR_APAT1	0x01000000
+#define RFCR_APAT0	0x00800000
+#define RFCR_AARP	0x00400000
+#define RFCR_MHEN	0x00200000
+#define RFCR_UHEN	0x00100000
+#define RFCR_ULM	0x00080000
+
+#define VRCR_RUDPE	0x00000080
+#define VRCR_RTCPE	0x00000040
+#define VRCR_RIPE	0x00000020
+#define VRCR_IPEN	0x00000010
+#define VRCR_DUTF	0x00000008
+#define VRCR_DVTF	0x00000004
+#define VRCR_VTREN	0x00000002
+#define VRCR_VTDEN	0x00000001
+
+#define VTCR_PPCHK	0x00000008
+#define VTCR_GCHK	0x00000004
+#define VTCR_VPPTI	0x00000002
+#define VTCR_VGTI	0x00000001
+
+#define CR		0x00
+#define CFG		0x04
+#define MEAR		0x08
+#define PTSCR		0x0c
+#define	ISR		0x10
+#define	IMR		0x14
+#define	IER		0x18
+#define	IHR		0x1c
+#define TXDP		0x20
+#define TXDP_HI		0x24
+#define TXCFG		0x28
+#define GPIOR		0x2c
+#define RXDP		0x30
+#define RXDP_HI		0x34
+#define RXCFG		0x38
+#define PQCR		0x3c
+#define WCSR		0x40
+#define PCR		0x44
+#define RFCR		0x48
+#define RFDR		0x4c
+
+#define SRR		0x58
+
+#define VRCR		0xbc
+#define VTCR		0xc0
+#define VDR		0xc4
+#define CCSR		0xcc
+
+//#define kick_rx(dev)	writel(CR_RXE, dev->base + CR)
+
+#if 1
+#define kick_rx(dev) do { \
+	dprintk("kick_rx: maybe kicking\n"); \
+	if (test_and_clear_bit(0, &dev->rx_info.idle)) { \
+		dprintk("actually kicking\n"); \
+		writel((u32)virt_to_bus(dev->rx_info.descs[dev->rx_info.next_rx]), dev->base + RXDP); \
+		if (dev->rx_info.next_rx == dev->rx_info.next_empty) \
+			printk("duh\n");\
+		writel(CR_RXE, dev->base + CR); \
+	} \
+} while(0)
+#endif
+
+#ifdef USE_64BIT_ADDR
+typedef u64	hw_addr_t;
+#else
+typedef u32	hw_addr_t;
+#endif
+
+#define HW_ADDR_LEN	(sizeof(hw_addr_t))
+
+#define LINK		0
+#define BUFPTR		(LINK + HW_ADDR_LEN/4)
+#define CMDSTS		(BUFPTR + HW_ADDR_LEN/4)
+#define EXTSTS		(CMDSTS + 4/4)
+#define DRV_NEXT	(EXTSTS + 4/4)
+
+#define CMDSTS_OWN	0x80000000
+#define CMDSTS_MORE	0x40000000
+#define CMDSTS_INTR	0x20000000
+#define CMDSTS_ERR	0x10000000
+#define CMDSTS_OK	0x08000000
+
+#define CMDSTS_DEST_MASK	0x01800000
+#define CMDSTS_DEST_SELF	0x00800000
+#define CMDSTS_DEST_MULTI	0x01000000
+
+struct sg_desc {
+	hw_addr_t	link;
+	hw_addr_t	bufptr;
+	u32		cmdsts;
+	u32		extsts;
+
+	u32		pad[4];
+} __attribute__((packed));
+
+#define DESC_SIZE	8		/* Should be cache line sized */
+
+struct rx_info {
+	spinlock_t	lock;
+	int		up;
+	long		idle;
+
+	struct sk_buff	*skbs[NR_RX_DESC];
+
+	unsigned	next_rx, next_empty;
+
+	char		pad[16] __attribute__((aligned(16)));
+	u32		descs[NR_RX_DESC][DESC_SIZE] __attribute__((aligned(16)));
+};
+
+
+struct ns83820 {
+	struct net_device	net_dev;
+	u8			*base;
+
+	struct pci_dev		*pci_dev;
+	struct ns83820		*next_dev;
+
+	struct rx_info		rx_info __attribute__ ((aligned(16)));
+
+	unsigned		ihr;
+	struct tq_struct	tq_refill;
+
+	/* protects everything below.  irqsave when using. */
+	spinlock_t		misc_lock;
+
+	u32			CFG_cache;
+
+	u32			MEAR_cache;
+	u32			IMR_cache;
+	struct eeprom		ee;
+
+
+	spinlock_t	tx_lock;
+
+	long		tx_idle;
+	u32		tx_done_idx;
+	u32		tx_idx;
+	u32		tx_free_idx;	/* idx of free desc chain */
+	u32		tx_intr_idx;
+
+	struct sk_buff	*tx_skbs[NR_TX_DESC];
+
+	char		pad[16] __attribute__((aligned(16)));
+	u32		tx_descs[NR_TX_DESC][DESC_SIZE] __attribute__((aligned(16)));
+
+
+};
+
+//free = (tx_done_idx + NR_TX_DESC-2 - free_idx) % NR_TX_DESC
+#define start_tx_okay(dev)	\
+	(((NR_TX_DESC-2 + dev->tx_done_idx - dev->tx_free_idx) % NR_TX_DESC) > NR_TX_DESC/2)
+
+static struct ns83820	*ns83820_chain;
+
+
+/* Packet Receiver
+ *
+ * The hardware supports linked lists of receive descriptors for
+ * which ownership is transfered back and forth by means of an
+ * ownership bit.  While the hardware does support the use of a
+ * ring for receive descriptors, we only make use of a chain in
+ * an attempt to reduce bus traffic under heavy load scenarios.
+ * This will also make bugs a bit more obvious.  The current code
+ * only makes use of a single rx chain; I hope to implement
+ * priority based rx for version 1.0.  Goal: even under overload
+ * conditions, still route realtime traffic with as low jitter as
+ * possible.
+ */
+#ifdef USE_64BIT_ADDR
+static inline void build_rx_desc64(struct ns83820 *dev, u32 *desc, void *link, u64 buf, u32 cmdsts, u32 extsts)
+{
+	u64 lnk = link ? virt_to_phys(link) : 0;
+	desc[0] = lnk;
+	desc[1] = 0; //lnk >> 32;
+	desc[2] = buf;
+	desc[3] = buf >> 32;
+	desc[5] = extsts;
+	mb();
+	desc[4] = cmdsts;
+}
+
+#define build_rx_desc	build_rx_desc64
+#else
+
+static inline void build_rx_desc32(struct ns83820 *dev, u32 *desc, void *link, u32 buf, u32 cmdsts, u32 extsts)
+{
+	desc[0] = link ? (u32)virt_to_phys(link) : 0;
+	desc[1] = buf;
+	desc[3] = extsts;
+	mb();
+	desc[2] = cmdsts;
+}
+
+#define build_rx_desc	build_rx_desc32
+#endif
+
+#define nr_rx_empty(dev) ((NR_RX_DESC-2 + dev->rx_info.next_rx - dev->rx_info.next_empty) % NR_RX_DESC)
+static int ns83820_add_rx_skb(struct ns83820 *dev, struct sk_buff *skb)
+{
+	unsigned next_empty;
+	u32 cmdsts;
+	u32 *sg;
+	hw_addr_t buf;
+
+	next_empty = dev->rx_info.next_empty;
+
+	/* don't overrun last rx marker */
+	if (nr_rx_empty(dev) <= 2) {
+		kfree_skb(skb);
+		return 1;
+	}
+
+#if 0
+	dprintk("next_empty[%d] nr_used[%d] next_rx[%d]\n",
+		dev->rx_info.next_empty,
+		dev->rx_info.nr_used,
+		dev->rx_info.next_rx
+		);
+#endif
+
+	sg = dev->rx_info.descs[next_empty];
+	if (dev->rx_info.skbs[next_empty])
+		BUG();
+	dev->rx_info.skbs[next_empty] = skb;
+
+	dev->rx_info.next_empty = (next_empty + 1) % NR_RX_DESC;
+	cmdsts = RX_BUF_SIZE | CMDSTS_INTR;
+	buf = pci_map_single(dev->pci_dev, skb->tail, RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
+	build_rx_desc(dev, sg, NULL, buf, cmdsts, 0);
+	/* update link of previous rx */
+	if (next_empty != dev->rx_info.next_rx)
+		dev->rx_info.descs[(NR_RX_DESC + next_empty - 1) % NR_RX_DESC][0] = (u32)virt_to_bus(dev->rx_info.descs[next_empty]);
+
+	return 0;
+}
+
+static int rx_refill(struct ns83820 *dev, int gfp)
+{
+	unsigned i;
+	long flags = 0;
+
+	dprintk("rx_refill(%p)\n", dev);
+	if (gfp == GFP_ATOMIC)
+		spin_lock_irqsave(&dev->rx_info.lock, flags);
+	for (i=0; i<NR_RX_DESC; i++) {
+		struct sk_buff *skb;
+		int res;
+		skb = __dev_alloc_skb(RX_BUF_SIZE+16, gfp);
+		if (!skb)
+			break;
+
+		res = (int)skb->tail & 0xf;
+		res = 0x10 - res;
+		res &= 0xf;
+		skb_reserve(skb, res);
+
+		skb->dev = &dev->net_dev;
+		if (gfp != GFP_ATOMIC)
+			spin_lock_irqsave(&dev->rx_info.lock, flags);
+		res = ns83820_add_rx_skb(dev, skb);
+		if (gfp != GFP_ATOMIC)
+			spin_unlock_irqrestore(&dev->rx_info.lock, flags);
+		if (res) {
+			i = 1;
+			break;
+		}
+	}
+	if (gfp == GFP_ATOMIC)
+		spin_unlock_irqrestore(&dev->rx_info.lock, flags);
+
+	return i ? 0 : -ENOMEM;
+}
+
+/* REFILL */
+static inline void queue_refill(void *_dev)
+{
+	struct ns83820 *dev = _dev;
+	static int foo;
+
+	if (!foo++)
+		printk("qyeye_refill\n");
+	rx_refill(dev, GFP_KERNEL);
+
+	if (dev->rx_info.up)
+		kick_rx(dev);
+}
+
+static inline void clear_rx_desc(struct ns83820 *dev, unsigned i)
+{
+	build_rx_desc(dev, dev->rx_info.descs[i], 0, 0, CMDSTS_OWN, 0);
+}
+
+static void phy_intr(struct ns83820 *dev)
+{
+	static char *speeds[] = { "10", "100", "1000", "1000(?)" };
+	u32 cfg, new_cfg;
+
+	new_cfg = dev->CFG_cache & ~(CFG_SB | CFG_MODE_1000 | CFG_SPDSTS);
+	cfg = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
+
+	if (cfg & CFG_SPDSTS1)
+		new_cfg |= CFG_MODE_1000 | CFG_SB;
+	else
+		new_cfg &= ~CFG_MODE_1000 | CFG_SB;
+
+	if ((cfg & CFG_LNKSTS) && ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
+		writel(new_cfg, dev->base + CFG);
+		dev->CFG_cache = new_cfg;
+	}
+
+	dev->CFG_cache &= ~CFG_SPDSTS;
+	dev->CFG_cache |= cfg & CFG_SPDSTS;
+
+	if (cfg & CFG_LNKSTS) {
+		netif_start_queue(&dev->net_dev);
+		netif_wake_queue(&dev->net_dev);
+	} else {
+		netif_stop_queue(&dev->net_dev);
+	}
+
+	printk(KERN_INFO "%s: link now %s mbps, %s duplex and %s.\n",
+		dev->net_dev.name,
+		speeds[((cfg / CFG_SPDSTS0) & 3)],
+		(cfg & CFG_DUPSTS) ? "full" : "half",
+		(cfg & CFG_LNKSTS) ? "up" : "down");
+}
+
+static int ns83820_setup_rx(struct ns83820 *dev)
+{
+	unsigned i;
+	int ret;
+
+	dprintk("ns83820_setup_rx(%p)\n", dev);
+
+	dev->rx_info.idle = 1;
+	dev->rx_info.next_rx = 0;
+	dev->rx_info.next_empty = 0;
+
+	for (i=0; i<NR_RX_DESC; i++)
+		clear_rx_desc(dev, i);
+
+	//dev->rx_info.descs[NR_RX_DESC - 1][CMDSTS] = 0;
+
+	writel(0, dev->base + RXDP_HI);
+	writel(virt_to_bus(dev->rx_info.descs[0]), dev->base + RXDP);
+
+	ret = rx_refill(dev, GFP_KERNEL);
+	if (!ret) {
+		dprintk("starting receiver\n");
+		/* prevent the interrupt handler from stomping on us */
+		spin_lock_irq(&dev->rx_info.lock);
+
+		writel(0x0001, dev->base + CCSR);
+		writel(0, dev->base + RFCR);
+		writel(0x7fc00000, dev->base + RFCR);
+		writel(0xffc00000, dev->base + RFCR);
+
+		dev->rx_info.up = 1;
+
+		phy_intr(dev);
+
+		/* Okay, let it rip */
+		spin_lock(&dev->misc_lock);
+		dev->IMR_cache |= ISR_PHY;
+		dev->IMR_cache |= ISR_RXRCMP;
+		//dev->IMR_cache |= ISR_RXERR;
+		//dev->IMR_cache |= ISR_RXOK;
+		dev->IMR_cache |= ISR_RXORN;
+		dev->IMR_cache |= ISR_RXSOVR;
+		dev->IMR_cache |= ISR_RXDESC;
+		dev->IMR_cache |= ISR_RXIDLE;
+		dev->IMR_cache |= ISR_TXDESC;
+		dev->IMR_cache |= ISR_TXIDLE;
+#if 0
+			/*ISR_TXURN |*/ ISR_TXERR | /*ISR_TXIDLE | ISR_TXDESC |*/ ISR_TXOK;
+#endif
+		writel(dev->IMR_cache, dev->base + IMR);
+		writel(1, dev->base + IER);
+		//readl(dev->base + ISR);
+		spin_unlock(&dev->misc_lock);
+
+		kick_rx(dev);
+
+		spin_unlock_irq(&dev->rx_info.lock);
+	}
+	return ret;
+}
+
+static void ns83820_cleanup_rx(struct ns83820 *dev)
+{
+	unsigned i;
+	long flags;
+
+	dprintk("ns83820_cleanup_rx(%p)\n", dev);
+
+	/* disable receive interrupts */
+	spin_lock_irqsave(&dev->misc_lock, flags);
+	dev->IMR_cache &= ~(ISR_RXOK | ISR_RXDESC | ISR_RXERR | ISR_RXEARLY | ISR_RXIDLE);
+	writel(dev->IMR_cache, dev->base + IMR);
+	spin_unlock_irqrestore(&dev->misc_lock, flags);
+
+	/* synchronize with the interrupt handler and kill it */
+	dev->rx_info.up = 0;
+	synchronize_irq();
+
+	/* touch the pci bus... */
+	readl(dev->base + IMR);
+
+	/* assumes the transmitter is already disabled and reset */
+	writel(0, dev->base + RXDP_HI);
+	writel(0, dev->base + RXDP);
+
+	for (i=0; i<NR_RX_DESC; i++) {
+		struct sk_buff *skb = dev->rx_info.skbs[i];
+		dev->rx_info.skbs[i] = NULL;
+		clear_rx_desc(dev, i);
+		if (skb)
+			kfree_skb(skb);
+	}
+}
+
+/* rx_irq
+ *
+ */
+static void FASTCALL(rx_irq(struct ns83820 *dev));
+static void rx_irq(struct ns83820 *dev)
+{
+	struct rx_info *info = &dev->rx_info;
+	unsigned next_rx;
+	u32 cmdsts, *desc;
+	long flags;
+	void *bufptr;
+	int nr = 0;
+
+	dprintk("rx_irq(%p)\n", dev);
+	dprintk("rxdp: %08x, descs: %08lx next_rx[%d]: %08lx next_empty[%d]: %08lx\n",
+	readl(dev->base + RXDP),
+	(dev->rx_info.descs),
+	dev->rx_info.next_rx,
+	(dev->rx_info.descs[dev->rx_info.next_rx]),
+	dev->rx_info.next_empty,
+	(dev->rx_info.descs[dev->rx_info.next_empty])
+	);
+
+	spin_lock_irqsave(&info->lock, flags);
+	if (!info->up)
+		goto out;
+
+	dprintk("walking descs\n");
+	next_rx = info->next_rx;
+	desc = info->descs[next_rx];
+	bufptr = bus_to_virt(desc[BUFPTR]);
+	while ((CMDSTS_OWN & (cmdsts = desc[CMDSTS])) &&
+	       (cmdsts != CMDSTS_OWN)) {
+		struct sk_buff *skb;
+		u32 extsts = desc[EXTSTS];
+
+		dprintk("cmdsts: %08x\n", cmdsts);
+		dprintk("link: %08x\n", desc[LINK]);
+		dprintk("bufptr: %08x\n", desc[BUFPTR]);
+		dprintk("extsts: %08x\n", desc[EXTSTS]);
+
+		//desc[CMDSTS] = CMDSTS_OWN;
+		skb = info->skbs[next_rx];
+		info->skbs[next_rx] = NULL;
+		info->next_rx = (next_rx + 1) % NR_RX_DESC;
+
+		barrier();
+		clear_rx_desc(dev, next_rx);
+
+		//pci_unmap_single(dev->pci_dev, RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
+		if (CMDSTS_OK & cmdsts) {
+			int len = cmdsts & 0xffff;
+			if (!skb)
+				BUG();
+			skb_put(skb, len);
+			if (bufptr != (skb->tail - skb->len)) {
+				dprintk("bufptr[%p] != data[%p]/tail[%p] len=%x/%x\n",
+					bufptr, skb->data, skb->tail, skb->len, len);
+			}
+			if ((extsts & 0x002a0000) && !(extsts & 0x00540000)) {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			} else {
+				if (len >500) printk("bad\n");
+				skb->ip_summed = CHECKSUM_NONE;
+			}
+			skb->protocol = eth_type_trans(skb, &dev->net_dev);
+			switch (netif_rx(skb)) {
+			case NET_RX_SUCCESS:
+				dev->ihr = 0;
+				break;
+			case NET_RX_CN_LOW:
+				dev->ihr = 2;
+				break;
+			case NET_RX_CN_MOD:
+				dev->ihr = dev->ihr + 1;
+				break;
+			case NET_RX_CN_HIGH:
+				dev->ihr += dev->ihr/2 + 1;
+				break;
+			case NET_RX_DROP:
+				dev->ihr = 255;
+				break;
+			}
+			if (dev->ihr > 255)
+				dev->ihr = 8;
+		} else {
+			static int err;
+			if (err++ < 20) {
+				printk("error packet: %08x\n", cmdsts);
+				//writel(CR_RXR, dev->base + CR);
+			}
+			kfree_skb(skb);
+		}
+
+		nr++;
+		next_rx = info->next_rx;
+		desc = info->descs[next_rx];
+	}
+	info->next_rx = next_rx;
+
+#if 0
+	if (dev->rx_info.next_empty != dev->rx_info.next_rx)
+		kick_rx(dev);
+#endif
+
+out:
+	if (0 && !nr) {
+		printk("dazed: cmdsts_f: %08x\n", cmdsts);
+	}
+
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
+
+/* Packet Transmit code
+ */
+static inline void kick_tx(struct ns83820 *dev)
+{
+	dprintk("kick_tx(%p): id_irqle=%ld, tx_idx=%d free_idx=%d\n",
+		dev, dev->tx_idle, dev->tx_idx,
+		dev->tx_free_idx);
+	if (test_and_clear_bit(0, &dev->tx_idle)) {
+		if (dev->tx_idx == dev->tx_free_idx) {
+			dev->tx_idle = 1;
+			return;
+		}
+		if (!dev->tx_descs[dev->tx_idx][CMDSTS]) {
+			printk(KERN_ALERT "BUG -- CMDSTS!\n");
+			return;
+		}
+		dprintk("IMR: %08x\n", readl(dev->base + IMR));
+		dprintk("TXE: free_idx=%d, tx_idx=%d, descs=%p desc=%08x\n", dev->tx_free_idx, dev->tx_idx, dev->tx_descs, readl(dev->base + TXDP));
+
+		writel(CR_TXE, dev->base + CR);
+		dprintk("IMR: %08x / %08x\n", readl(dev->base + IMR), dev->IMR_cache);
+		dprintk("CR: %08x\n", readl(dev->base + CR));
+	} else
+		writel(CR_TXE, dev->base + CR);
+}
+
+/* no spinlock needed on the transmit irq path as the interrupt handler is serialized */
+static void do_tx_done(struct ns83820 *dev)
+{
+	u32 cmdsts, tx_done_idx, *desc;
+
+	dprintk("do_tx_done(%p)\n", dev);
+	tx_done_idx = dev->tx_done_idx;
+	desc = dev->tx_descs[tx_done_idx];
+
+	dprintk("tx_done_idx=%d free_idx=%d cmdsts=%08x\n", tx_done_idx, dev->tx_free_idx, desc[CMDSTS]);
+	while ((tx_done_idx != dev->tx_free_idx) &&
+	       !(CMDSTS_OWN & (cmdsts = desc[CMDSTS])) ) {
+		struct sk_buff *skb;
+
+		dprintk("tx_done_idx=%d free_idx=%d cmdsts=%08x\n",
+			tx_done_idx, dev->tx_free_idx, desc[CMDSTS]);
+		skb = dev->tx_skbs[tx_done_idx];
+		dev->tx_skbs[tx_done_idx] = NULL;
+		dprintk("done(%p)\n", skb);
+		pci_unmap_single(dev->pci_dev,
+				*(hw_addr_t *)&desc[BUFPTR],
+				skb->len,
+				PCI_DMA_TODEVICE);
+		if (skb)
+			dev_kfree_skb_irq(skb);
+
+		tx_done_idx = (tx_done_idx + 1) % NR_TX_DESC;
+		dev->tx_done_idx = tx_done_idx;
+		desc[CMDSTS] = 0;
+		barrier();
+		desc = dev->tx_descs[tx_done_idx];
+	}
+
+	/* Allow network stack to resume queueing packets after we've
+	 * finished transmitting at least 1/4 of the packets in the queue.
+	 */
+	if (netif_queue_stopped(&dev->net_dev) && start_tx_okay(dev)) {
+		dprintk("start_queue(%p)\n", dev);
+		netif_start_queue(&dev->net_dev);
+		netif_wake_queue(&dev->net_dev);
+	}
+}
+
+static void ns83820_cleanup_tx(struct ns83820 *dev)
+{
+	unsigned i;
+
+	for (i=0; i<NR_TX_DESC; i++) {
+		struct sk_buff *skb = dev->tx_skbs[i];
+		dev->tx_skbs[i] = NULL;
+		if (skb)
+			dev_kfree_skb(skb);
+	}
+
+	memset(dev->tx_descs, 0, sizeof dev->tx_descs);
+	set_bit(0, &dev->tx_idle);
+}
+
+#define MAX_FRAG_LEN	8192	/* disabled for now */
+static int ns83820_hard_start_xmit(struct sk_buff *skb, struct net_device *_dev)
+{
+	static char zeros[64];
+	struct ns83820 *dev = (struct ns83820 *)_dev;
+	u32 free_idx, cmdsts, extsts;
+	int nr_free, nr_frags;
+	unsigned tx_done_idx;
+	dmaaddr_high_t buf;
+	unsigned len;
+	skb_frag_t *frag;
+	int stopped = 0;
+	int do_intr = 0;
+	volatile u32 *first_desc;
+
+	dprintk("ns83820_hard_start_xmit\n");
+
+	__cli();
+	nr_frags =  skb_shinfo(skb)->nr_frags;
+again:
+	if ((dev->CFG_cache & CFG_LNKSTS)) {
+		netif_stop_queue(&dev->net_dev);
+		if ((dev->CFG_cache & CFG_LNKSTS))
+			return 1;
+		netif_start_queue(&dev->net_dev);
+	}
+
+	free_idx = dev->tx_free_idx;
+	tx_done_idx = dev->tx_done_idx;
+	nr_free = (tx_done_idx + NR_TX_DESC-2 - free_idx) % NR_TX_DESC;
+	nr_free -= 1;
+	if ((nr_free <= nr_frags) || (nr_free <= 8192 / MAX_FRAG_LEN)) {
+		dprintk("stop_queue - not enough(%p)\n", dev);
+		netif_stop_queue(&dev->net_dev);
+
+		/* Check again: we may have raced with a tx done irq */
+		if (dev->tx_done_idx != tx_done_idx) {
+			dprintk("restart queue(%p)\n", dev);
+			netif_start_queue(&dev->net_dev);
+			goto again;
+		}
+		return 1;
+	}
+
+	if (free_idx == dev->tx_intr_idx) {
+		do_intr = 1;
+		dev->tx_intr_idx = (dev->tx_intr_idx + NR_TX_DESC/2) % NR_TX_DESC;
+	}
+
+	nr_free -= nr_frags;
+	if (nr_free < 1) {
+		dprintk("stop_queue - last entry(%p)\n", dev);
+		netif_stop_queue(&dev->net_dev);
+		stopped = 1;
+	}
+
+	frag = skb_shinfo(skb)->frags;
+	extsts = 0;
+	if (skb->ip_summed == CHECKSUM_HW) {
+		extsts |= EXTSTS_IPPKT;
+
+		if (IPPROTO_TCP == skb->nh.iph->protocol)
+			extsts |= EXTSTS_TCPPKT;
+		else if (IPPROTO_UDP == skb->nh.iph->protocol)
+			extsts |= EXTSTS_UDPPKT;
+	}
+
+	len = skb->len;
+	//dmaaddr_high(buf) = 0;
+	dmaaddr_low(buf) = pci_map_single(dev->pci_dev, skb->data, len, PCI_DMA_TODEVICE);
+
+	first_desc = dev->tx_descs[free_idx];
+
+	for (;;) {
+		volatile u32 *desc = dev->tx_descs[free_idx];
+		u32 residue = 0;
+#if 0
+		if (len > MAX_FRAG_LEN) {
+			residue = len;
+			/* align the start address of the next fragment */
+			len = MAX_FRAG_LEN;
+			residue -= len;
+		}
+#endif
+
+		dprintk("frag[%3u]: %4u @ 0x%x%08x\n", free_idx, len,
+			dmaaddr_high(buf), dmaaddr_low(buf));
+		free_idx = (free_idx + 1) % NR_TX_DESC;
+		desc[LINK] = (u32)virt_to_bus(dev->tx_descs[free_idx]);
+		desc[BUFPTR] = dmaaddr_low(buf);
+		desc[BUFPTR+1] = dmaaddr_high(buf);
+		desc[EXTSTS] = extsts;
+
+		wmb();
+		cmdsts = ((nr_frags|residue) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
+		cmdsts |= (desc == first_desc) ? 0 : CMDSTS_OWN;
+		cmdsts |= len;
+		desc[CMDSTS] = cmdsts;
+
+		if (residue) {
+			buf += len;
+			len = residue;
+			continue;
+		}
+
+		if (!nr_frags)
+			break;
+
+		buf = pci_map_single_high(dev->pci_dev, frag->page, 0, frag->size, PCI_DMA_TODEVICE);
+		dprintk("frag: buf=%08Lx  page=%08x\n", buf, frag->page - mem_map);
+		len = frag->size;
+		frag++;
+		nr_frags--;
+	}
+	dprintk("done pkt\n");
+	dev->tx_skbs[free_idx] = skb;
+	dev->tx_free_idx = free_idx;
+	first_desc[CMDSTS] |= CMDSTS_OWN;
+	kick_tx(dev);
+	__sti();
+
+	/* Check again: we may have raced with a tx done irq */
+	if (stopped && (dev->tx_done_idx != tx_done_idx) && start_tx_okay(dev))
+		netif_start_queue(&dev->net_dev);
+
+	return 0;
+}
+
+static void ns83820_irq(int foo, void *data, struct pt_regs *regs)
+{
+	struct ns83820 *dev = data;
+	int count = 0;
+	u32 isr;
+	dprintk("ns83820_irq(%p)\n", dev);
+
+	dev->ihr = 0;
+
+	while (count++ < 32 && (isr = readl(dev->base + ISR))) {
+		dprintk("irq: %08x\n", isr);
+
+		if (isr & ~(ISR_PHY | ISR_RXDESC | ISR_RXEARLY | ISR_RXOK | ISR_RXERR | ISR_TXIDLE | ISR_TXOK | ISR_TXDESC))
+			printk("odd isr? 0x%08x\n", isr);
+
+	if ((ISR_RXEARLY | ISR_RXIDLE | ISR_RXORN | ISR_RXDESC | ISR_RXOK | ISR_RXERR) & isr) {
+ 		if (ISR_RXIDLE & isr) {
+			dev->rx_info.idle = 1;
+			printk("oh dear, we are idle\n");
+		}
+
+		if ((ISR_RXDESC) & isr)
+			rx_irq(dev);
+
+		if (nr_rx_empty(dev) >= NR_RX_DESC/4) {
+			if (dev->rx_info.up) {
+				rx_refill(dev, GFP_ATOMIC);
+				kick_rx(dev);
+			}
+		}
+
+		if (dev->rx_info.up && nr_rx_empty(dev) > NR_RX_DESC*3/4)
+			schedule_task(&dev->tq_refill);
+		else
+			kick_rx(dev);
+		if (dev->rx_info.idle)
+			printk("BAD\n");
+	}
+
+	if (ISR_RXSOVR & isr)
+		printk("overrun\n");
+	if (ISR_RXORN & isr)
+		printk("overrun\n");
+
+	if ((ISR_RXRCMP & isr) && dev->rx_info.up)
+		writel(CR_RXE, dev->base + CR);
+
+#if 1
+	if (ISR_TXIDLE & isr) {
+		u32 txdp;
+		txdp = readl(dev->base + TXDP);
+		dprintk("txdp: %08x\n", txdp);
+		txdp -= (u32)virt_to_bus(dev->tx_descs);
+		dev->tx_idx = txdp / (DESC_SIZE * 4);
+		if (dev->tx_idx >= NR_TX_DESC) {
+			printk(KERN_ALERT "%s: BUG -- txdp out of range\n", dev->net_dev.name);
+			dev->tx_idx = 0;
+		}
+		if (dev->tx_idx != dev->tx_free_idx)
+			writel(CR_TXE, dev->base + CR);
+			//kick_tx(dev);
+		else
+			dev->tx_idle = 1;
+		mb();
+		if (dev->tx_idx != dev->tx_free_idx)
+			kick_tx(dev);
+	}
+#endif
+	//if ((ISR_TXDESC | ISR_TXOK | ISR_TXERR) & isr)
+	if ((ISR_TXDESC | ISR_TXIDLE) & isr)
+		do_tx_done(dev);
+
+	if (ISR_PHY & isr)
+		phy_intr(dev);
+	}
+
+	if (dev->ihr)
+		writel(dev->ihr, dev->base + IHR);
+}
+
+static void ns83820_do_reset(struct ns83820 *dev, u32 which)
+{
+	printk("resetting chip...\n");
+	writel(which, dev->base + CR);
+	do {
+		schedule();
+	} while (readl(dev->base + CR) & which);
+	printk("okay!\n");
+}
+
+static int ns83820_stop(struct net_device *_dev)
+{
+	struct ns83820 *dev = (struct ns83820 *)_dev;
+
+	//printk("ns83820_stop\n");
+
+	/* FIXME: protect against interrupt handler */
+
+	/* disable interrupts */
+	writel(0, dev->base + IMR);
+	writel(0, dev->base + IER);
+	readl(dev->base + IER);
+
+	dev->rx_info.up = 0;
+	synchronize_irq();
+
+	ns83820_do_reset(dev, CR_RST);
+
+	synchronize_irq();
+
+	dev->IMR_cache &= ~(ISR_TXURN | ISR_TXIDLE | ISR_TXERR | ISR_TXDESC | ISR_TXOK);
+	ns83820_cleanup_rx(dev);
+	ns83820_cleanup_tx(dev);
+
+	return 0;
+}
+
+static int ns83820_open(struct net_device *_dev)
+{
+	struct ns83820 *dev = (struct ns83820 *)_dev;
+	unsigned i;
+	u32 desc;
+	int ret;
+
+	//printk("ns83820_open\n");
+
+	writel(0, dev->base + PQCR);
+
+	ret = ns83820_setup_rx(dev);
+	if (ret)
+		goto failed;
+
+	memset(dev->tx_descs, 0, sizeof dev->tx_descs);
+	for (i=0; i<NR_TX_DESC; i++) {
+		*(hw_addr_t *)&dev->tx_descs[i][LINK] =
+			virt_to_bus(dev->tx_descs[(i+1) % NR_TX_DESC]);
+	}
+
+	dev->tx_idx = 0;
+	dev->tx_done_idx = 0;
+	desc = virt_to_bus(dev->tx_descs[0]);
+	writel(0, dev->base + TXDP_HI);
+	writel(desc, dev->base + TXDP);
+
+//printk("IMR: %08x / %08x\n", readl(dev->base + IMR), dev->IMR_cache);
+
+	set_bit(0, &dev->tx_idle);
+	netif_start_queue(&dev->net_dev);	/* FIXME: wait for phy to come up */
+
+	return 0;
+
+failed:
+	ns83820_stop(_dev);
+	return ret;
+}
+#if 0
+static void ns83820_tx_timeout(struct net_device *_dev)
+{
+	//struct ns83820 *dev = (struct ns83820 *)_dev;
+
+	//printk("ns83820_tx_timeout\n");
+}
+#endif
+static void ns83820_getmac(struct ns83820 *dev, u8 *mac)
+{
+	unsigned i;
+	for (i=0; i<3; i++) {
+		u32 data;
+#if 0
+		data = eeprom_readw(&dev->ee, 0xa + 2 - i);
+#else
+		writel(i*2, dev->base + RFCR);
+		data = readl(dev->base + RFDR);
+#endif
+		*mac++ = data;
+		*mac++ = data >> 8;
+	}
+}
+
+static int ns83820_change_mtu(struct net_device *_dev, int new_mtu)
+{
+	if (new_mtu > RX_BUF_SIZE)
+		return -EINVAL;
+	_dev->mtu = new_mtu;
+	return 0;
+}
+
+static int ns83820_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
+{
+	struct ns83820 *dev;
+	long addr;
+	int err;
+
+	dev = (struct ns83820 *)alloc_etherdev((sizeof *dev) - (sizeof dev->net_dev));
+	err = -ENOMEM;
+	if (!dev)
+		goto out;
+
+	spin_lock_init(&dev->rx_info.lock);
+	spin_lock_init(&dev->tx_lock);
+	spin_lock_init(&dev->misc_lock);
+	dev->pci_dev = pci_dev;
+
+	dev->ee.cache = &dev->MEAR_cache;
+	dev->ee.lock = &dev->misc_lock;
+	dev->net_dev.owner = THIS_MODULE;
+
+	PREPARE_TQUEUE(&dev->tq_refill, queue_refill, dev);
+
+	err = pci_enable_device(pci_dev);
+	if (err) {
+		printk(KERN_INFO "ns83820: pci_enable_dev: %d\n", err);
+		goto out_free;
+	}
+
+	pci_set_master(pci_dev);
+	addr = pci_resource_start(pci_dev, 1);
+	dev->base = ioremap_nocache(addr, PAGE_SIZE);
+	err = -ENOMEM;
+	if (!dev->base)
+		goto out_disable;
+
+	/* disable interrupts */
+	writel(0, dev->base + IMR);
+	writel(0, dev->base + IER);
+	readl(dev->base + IER);
+
+	dev->IMR_cache = 0;
+
+	setup_ee_mem_bitbanger(&dev->ee, (long)dev->base + MEAR, 3, 2, 1, 0,
+		0);
+
+	err = request_irq(pci_dev->irq, ns83820_irq, SA_SHIRQ, dev->net_dev.name, dev);
+	if (err) {
+		printk(KERN_INFO "ns83820: unable to register irq %d\n", pci_dev->irq);
+		goto out_unmap;
+	}
+
+	dev->net_dev.open = ns83820_open;
+	dev->net_dev.stop = ns83820_stop;
+	dev->net_dev.hard_start_xmit = ns83820_hard_start_xmit;
+	dev->net_dev.change_mtu = ns83820_change_mtu;
+	//FIXME: dev->net_dev.tx_timeout = ns83820_tx_timeout;
+
+	lock_kernel();
+	dev->next_dev = ns83820_chain;
+	ns83820_chain = dev;
+	unlock_kernel();
+
+	ns83820_do_reset(dev, CR_RST);
+
+	dprintk("start bist\n");
+	writel(PTSCR_EEBIST_EN, dev->base + PTSCR);
+	do {
+		schedule();
+	} while (readl(dev->base + PTSCR) & PTSCR_EEBIST_EN);
+	dprintk("done bist\n");
+
+	dprintk("start eeload\n");
+	writel(PTSCR_EELOAD_EN, dev->base + PTSCR);
+	do {
+		schedule();
+	} while (readl(dev->base + PTSCR) & PTSCR_EELOAD_EN);
+	dprintk("done eeload\n");
+
+	/* I love config registers */
+	dev->CFG_cache = readl(dev->base + CFG);
+
+	if ((dev->CFG_cache & CFG_PCI64_DET)) {
+		printk("%s: enabling 64 bit PCI.\n", dev->net_dev.name);
+		dev->CFG_cache |= CFG_T64ADDR | CFG_DATA64_EN;
+	} else {
+		printk("%s: disabling 64 bit PCI.\n", dev->net_dev.name);
+		dev->CFG_cache &= ~(CFG_T64ADDR | CFG_DATA64_EN);
+	}
+	dev->CFG_cache &= (CFG_TBI_EN  | CFG_MRM_DIS   | CFG_MWI_DIS |
+			   CFG_T64ADDR | CFG_DATA64_EN | CFG_EXT_125 |
+			   CFG_M64ADDR);
+	dev->CFG_cache |= CFG_PINT_DUPSTS | CFG_PINT_LNKSTS | CFG_PINT_SPDSTS |
+			  CFG_EXTSTS_EN   | CFG_EXD         | CFG_PESEL;
+	dev->CFG_cache |= CFG_REQALG;
+	dev->CFG_cache |= CFG_POW;
+#ifdef USE_64BIT_ADDR
+	dev->CFG_cache |= CFG_M64ADDR;
+	printk("using 64 bit addressing\n");
+#endif
+#ifdef __LITTLE_ENDIAN
+	dev->CFG_cache &= ~CFG_BEM;
+#elif defined(__BIG_ENDIAN)
+	dev->CFG_cache |= CFG_BEM;
+#else
+#error This driver only works for big or little endian!!!
+#endif
+
+	writel(dev->CFG_cache, dev->base + CFG);
+	dprintk("CFG: %08x\n", dev->CFG_cache);
+
+	if (readl(dev->base + SRR))
+		writel(readl(dev->base+0x20c) | 0xfe00, dev->base + 0x20c);
+
+	/* Note!  The DMA burst size interacts with packet
+	 * transmission, such that the largest packet that
+	 * can be transmitted is 8192 - FLTH - burst size.
+	 * If only the transmit fifo was larger...
+	 */
+	writel(TXCFG_CSI | TXCFG_HBI | TXCFG_ATP | TXCFG_MXDMA1024
+		| ((1600 / 32) * 0x100),
+		dev->base + TXCFG);
+
+
+	//writel(0x102, dev->base + IHR);
+	//writel(0x001, dev->base + IHR);
+	writel(0x000, dev->base + IHR);
+	writel(0x100, dev->base + IHR);
+
+	/* Set Rx to full duplex, don't accept runt, errored, long or length
+	 * range errored packets.  Set MXDMA to 7 => 512 word burst
+	 */
+	writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
+		| RXCFG_ALP
+		| RXCFG_MXDMA | 0, dev->base + RXCFG);
+
+	/* Disable priority queueing */
+	writel(0, dev->base + PQCR);
+
+	/* Enable IP checksum validation and detetion of VLAN headers */
+	writel(VRCR_RUDPE | VRCR_RTCPE | VRCR_RIPE | VRCR_IPEN | VRCR_VTDEN, dev->base + VRCR);
+
+	/* Enable per-packet TCP/UDP/IP checksumming */
+	writel(VTCR_PPCHK, dev->base + VTCR);
+
+	/* Disable Pause frames */
+	writel(0, dev->base + PCR);
+
+	/* Disable Wake On Lan */
+	writel(0, dev->base + WCSR);
+
+	ns83820_getmac(dev, dev->net_dev.dev_addr);
+
+	/* Yes, we support dumb IP checksum on transmit */
+	dev->net_dev.features |= NETIF_F_SG;
+	dev->net_dev.features |= NETIF_F_IP_CSUM;
+#if defined(USE_64BIT_ADDR) || defined(CONFIG_HIGHMEM4G)
+	dev->net_dev.features |= NETIF_F_HIGHDMA;
+#endif
+
+	register_netdev(&dev->net_dev);
+
+	printk(KERN_INFO "%s: ns83820.c v" VERSION ": DP83820 %02x:%02x:%02x:%02x:%02x:%02x pciaddr=0x%08lx irq=%d rev 0x%x\n",
+		dev->net_dev.name,
+		dev->net_dev.dev_addr[0], dev->net_dev.dev_addr[1],
+		dev->net_dev.dev_addr[2], dev->net_dev.dev_addr[3],
+		dev->net_dev.dev_addr[4], dev->net_dev.dev_addr[5],
+		addr, pci_dev->irq,
+		(unsigned)readl(dev->base + SRR)
+		);
+
+	return 0;
+
+out_unmap:
+	iounmap(dev->base);
+out_disable:
+	pci_disable_device(pci_dev);
+out_free:
+	kfree(dev);
+out:
+	return err;
+}
+
+static struct pci_device_id pci_device_id[] __devinitdata = {
+	{ 0x100b, 0x0022, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
+	{ 0, },
+};
+
+static struct pci_driver driver = {
+	name:		"ns83820",
+	id_table:	pci_device_id,
+	probe:		ns83820_probe,
+#if 0
+	remove:		,
+	suspend:	,
+	resume:		,
+#endif
+};
+
+
+static int __init ns83820_init(void)
+{
+	printk(KERN_INFO "ns83820.c: National Semiconductor DP83820 10/100/100 driver.\n");
+	return pci_module_init(&driver);
+}
+
+static void ns83820_exit(void)
+{
+	struct ns83820	*dev;
+
+	for (dev = ns83820_chain; dev; ) {
+		struct ns83820 *next = dev->next_dev;
+
+		writel(0, dev->base + IMR);	/* paranoia */
+		writel(0, dev->base + IER);
+		readl(dev->base + IER);
+
+		unregister_netdev(&dev->net_dev);
+		free_irq(dev->pci_dev->irq, dev);
+		iounmap(dev->base);
+		pci_disable_device(dev->pci_dev);
+		kfree(dev);
+		dev = next;
+	}
+	pci_unregister_driver(&driver);
+	ns83820_chain = NULL;
+}
+
+MODULE_AUTHOR("Benjamin LaHaise <bcrl@redhat.com>");
+MODULE_DESCRIPTION("National Semiconductor DP83820 10/100/1000 driver");
+MODULE_DEVICE_TABLE(pci, pci_device_id);
+module_init(ns83820_init);
+module_exit(ns83820_exit);
diff -x .* -urN v2.4.6-pre8/include/linux/eeprom.h pgc-2.4.6-pre8/include/linux/eeprom.h
--- v2.4.6-pre8/include/linux/eeprom.h	Wed Dec 31 19:00:00 1969
+++ pgc-2.4.6-pre8/include/linux/eeprom.h	Mon Jun 25 17:53:27 2001
@@ -0,0 +1,135 @@
+/* credit winbond-840.c
+ */
+struct eeprom_ops {
+	void	(*set_cs)(void *ee);
+	void	(*clear_cs)(void *ee);
+};
+
+#define EEPOL_EEDI	0x01
+#define EEPOL_EEDO	0x02
+#define EEPOL_EECLK	0x04
+#define EEPOL_EESEL	0x08
+
+struct eeprom {
+	void *dev;
+	struct eeprom_ops *ops;
+
+	long		addr;
+
+	unsigned	ee_addr_bits;
+
+	unsigned	eesel;
+	unsigned	eeclk;
+	unsigned	eedo;
+	unsigned	eedi;
+	unsigned	polarity;
+	unsigned	ee_state;
+
+	spinlock_t	*lock;
+	u32		*cache;
+};
+
+
+u8   eeprom_readb(struct eeprom *ee, unsigned address);
+void eeprom_read(struct eeprom *ee, unsigned address, u8 *bytes,
+		unsigned count);
+void eeprom_writeb(struct eeprom *ee, unsigned address, u8 data);
+void eeprom_write(struct eeprom *ee, unsigned address, u8 *bytes,
+		unsigned count);
+
+/* The EEPROM commands include the alway-set leading bit. */
+enum EEPROM_Cmds {
+        EE_WriteCmd=(5 << 6), EE_ReadCmd=(6 << 6), EE_EraseCmd=(7 << 6),
+};
+
+void setup_ee_mem_bitbanger(struct eeprom *ee, long memaddr, int eesel_bit, int eeclk_bit, int eedo_bit, int eedi_bit, unsigned polarity)
+{
+	ee->addr = memaddr;
+	ee->eesel = 1 << eesel_bit;
+	ee->eeclk = 1 << eeclk_bit;
+	ee->eedo = 1 << eedo_bit;
+	ee->eedi = 1 << eedi_bit;
+
+	ee->polarity = polarity;
+
+	*ee->cache = readl(ee->addr);
+}
+
+/* foo. put this in a .c file */
+static inline void eeprom_update(struct eeprom *ee, u32 mask, int pol)
+{
+	long flags;
+	u32 data;
+
+	spin_lock_irqsave(ee->lock, flags);
+	data = *ee->cache;
+
+	data &= ~mask;
+	if (pol)
+		data |= mask;
+
+	*ee->cache = data;
+//printk("update: %08x\n", data);
+	writel(data, ee->addr);
+	spin_unlock_irqrestore(ee->lock, flags);
+}
+
+void eeprom_clk_lo(struct eeprom *ee)
+{
+	int pol = !!(ee->polarity & EEPOL_EECLK);
+
+	eeprom_update(ee, ee->eeclk, pol);
+	udelay(2);
+}
+
+void eeprom_clk_hi(struct eeprom *ee)
+{
+	int pol = !!(ee->polarity & EEPOL_EECLK);
+
+	eeprom_update(ee, ee->eeclk, !pol);
+	udelay(2);
+}
+
+void eeprom_send_addr(struct eeprom *ee, unsigned address)
+{
+	int pol = !!(ee->polarity & EEPOL_EEDI);
+	unsigned i;
+	address |= 6 << 6;
+
+        /* Shift the read command bits out. */
+        for (i=0; i<11; i++) {
+		eeprom_update(ee, ee->eedi, ((address >> 10) & 1) ^ pol);
+		address <<= 1;
+		eeprom_clk_hi(ee);
+		eeprom_clk_lo(ee);
+        }
+	eeprom_update(ee, ee->eedi, pol);
+}
+
+u16   eeprom_readw(struct eeprom *ee, unsigned address)
+{
+	unsigned i;
+	u16	res = 0;
+
+	eeprom_clk_lo(ee);
+	eeprom_update(ee, ee->eesel, 1 ^ !!(ee->polarity & EEPOL_EESEL));
+	eeprom_send_addr(ee, address);
+
+	for (i=0; i<16; i++) {
+		u32 data;
+		eeprom_clk_hi(ee);
+		res <<= 1;
+		data = readl(ee->addr);
+//printk("eeprom_readw: %08x\n", data);
+		res |= !!(data & ee->eedo) ^ !!(ee->polarity & EEPOL_EEDO);
+		eeprom_clk_lo(ee);
+	}
+	eeprom_update(ee, ee->eesel, 0 ^ !!(ee->polarity & EEPOL_EESEL));
+
+	return res;
+}
+
+
+void eeprom_writeb(struct eeprom *ee, unsigned address, u8 data)
+{
+}

