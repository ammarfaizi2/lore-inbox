Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284644AbRLIXYt>; Sun, 9 Dec 2001 18:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284638AbRLIXYf>; Sun, 9 Dec 2001 18:24:35 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20845 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284629AbRLIXYR>; Sun, 9 Dec 2001 18:24:17 -0500
Date: Sun, 9 Dec 2001 18:24:13 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre7
Message-ID: <20011209182413.B8846@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112091722050.24350-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112091722050.24350-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sun, Dec 09, 2001 at 05:24:14PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 05:24:14PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes pre7.

Here's a retransmit of the ns83820 update.  Still applies, although the 
Configure.help hunk is offset.

		-ben


diff -ur /md0/kernels/2.4/v2.4.17-pre5/Documentation/Configure.help ns83820/Documentation/Configure.help
--- /md0/kernels/2.4/v2.4.17-pre5/Documentation/Configure.help	Thu Dec  6 23:38:42 2001
+++ ns83820/Documentation/Configure.help	Fri Dec  7 17:27:42 2001
@@ -22475,10 +22475,15 @@
 National Semiconductor DP83820 support
 CONFIG_NS83820
   This is a driver for the National Semiconductor DP83820 series
-  of gigabit ethernet MACs.  Cards using this chipset include
-  the D-Link DGE-500T, PureData's PDP8023Z-TG, SMC's SMC9462TX,
-  SOHO-GA2000T, SOHO-GA2500T.  The driver supports the use of
-  zero copy.
+  of gigabit ethernet MACs.  Cards using this chipset include:
+
+        SMC 9452TX          SMC SMC9462TX       
+        D-Link DGE-500T     PureData PDP8023Z-TG
+        SOHO-GA2000T        SOHO-GA2500T.
+        NetGear GA621
+
+  This driver supports the use of zero copy on tx, checksum 
+  validation on rx, and 64 bit addressing.
 
 Toshiba Type-O IR Port device driver
 CONFIG_TOSHIBA_FIR
diff -ur /md0/kernels/2.4/v2.4.17-pre5/drivers/net/ns83820.c ns83820/drivers/net/ns83820.c
--- /md0/kernels/2.4/v2.4.17-pre5/drivers/net/ns83820.c	Mon Nov 26 23:43:07 2001
+++ ns83820/drivers/net/ns83820.c	Fri Dec  7 17:22:13 2001
@@ -1,7 +1,7 @@
-#define VERSION "0.13"
-/* ns83820.c by Benjamin LaHaise <bcrl@redhat.com>
+#define _VERSION "0.15"
+/* ns83820.c by Benjamin LaHaise <bcrl@redhat.com> with contributions.
  *
- * $Revision: 1.34.2.8 $
+ * $Revision: 1.34.2.12 $
  *
  * Copyright 2001 Benjamin LaHaise.
  * Copyright 2001 Red Hat.
@@ -45,6 +45,12 @@
  *			0.12 - add statistics counters
  *			     - add allmulti/promisc support
  *	20011009	0.13 - hotplug support, other smaller pci api cleanups
+ *	20011204	0.13a - optical transceiver support added
+ *				by Michael Clark <michael@metaparadigm.com>
+ *	20011205	0.13b - call register_netdev earlier in initialization
+ *				suppress duplicate link status messages
+ *	20011117 	0.14 - ethtool GDRVINFO, GLINK support from jgarzik
+ *	20011204 	0.15	get ppc (big endian) working
  *
  * Driver Overview
  * ===============
@@ -65,6 +71,7 @@
  *	D-Link		DGE-500T
  *	PureData	PDP8023Z-TG
  *	SMC		SMC9452TX	SMC9462TX
+ *	Netgear		GA621
  *
  * Special thanks to SMC for providing hardware to test this driver on.
  *
@@ -86,23 +93,25 @@
 #include <linux/in.h>	/* for IPPROTO_... */
 #include <linux/eeprom.h>
 #include <linux/compiler.h>
+#include <linux/ethtool.h>
 //#include <linux/skbrefill.h>
 
 #include <asm/io.h>
+#include <asm/uaccess.h>
 
 /* Dprintk is used for more interesting debug events */
 #undef Dprintk
 #define	Dprintk			dprintk
 
 #ifdef CONFIG_HIGHMEM64G
-#define USE_64BIT_ADDR
+#define USE_64BIT_ADDR	"+"
 #elif defined(__ia64__)
-#define USE_64BIT_ADDR
+#define USE_64BIT_ADDR	"+"
 #endif
 
 /* Tell davem to fix the pci dma api.  Grrr. */
 /* stolen from acenic.c */
-#ifdef CONFIG_HIGHMEM
+#if 0 //def CONFIG_HIGHMEM
 #if defined(CONFIG_X86)
 #define DMAADDR_OFFSET  0
 #if defined(CONFIG_HIGHMEM64G)
@@ -138,6 +147,12 @@
 }
 #endif
 
+#if defined(USE_64BIT_ADDR)
+#define	VERSION	_VERSION USE_64BIT_ADDR
+#else
+#define	VERSION	_VERSION
+#endif
+
 /* tunables */
 #define RX_BUF_SIZE	6144	/* 8192 */
 #define NR_RX_DESC	256
@@ -213,6 +228,7 @@
 #define CFG_DUPSTS	0x10000000
 #define CFG_TBI_EN	0x01000000
 #define CFG_MODE_1000	0x00400000
+#define CFG_AUTO_1000	0x00200000
 #define CFG_PINT_CTL	0x001c0000
 #define CFG_PINT_DUPSTS	0x00100000
 #define CFG_PINT_LNKSTS	0x00080000
@@ -316,6 +332,36 @@
 #define VDR		0xc4
 #define CCSR		0xcc
 
+#define TBICR		0xe0
+#define TBISR		0xe4
+#define TANAR		0xe8
+#define TANLPAR		0xec
+#define TANER		0xf0
+#define TESR		0xf4
+
+#define TBICR_MR_AN_ENABLE	0x00001000
+#define TBICR_MR_RESTART_AN	0x00000200
+
+#define TBISR_MR_LINK_STATUS	0x00000020
+#define TBISR_MR_AN_COMPLETE	0x00000004
+
+#define TANAR_PS2 		0x00000100
+#define TANAR_PS1 		0x00000080
+#define TANAR_HALF_DUP 		0x00000040
+#define TANAR_FULL_DUP 		0x00000020
+
+#define GPIOR_GP5_OE		0x00000200
+#define GPIOR_GP4_OE		0x00000100
+#define GPIOR_GP3_OE		0x00000080
+#define GPIOR_GP2_OE		0x00000040
+#define GPIOR_GP1_OE		0x00000020
+#define GPIOR_GP3_OUT		0x00000004
+#define GPIOR_GP1_OUT		0x00000001
+
+#define LINK_AUTONEGOTIATE	0x01
+#define LINK_DOWN		0x02
+#define LINK_UP			0x04
+
 #define __kick_rx(dev)	writel(CR_RXE, dev->base + CR)
 
 #define kick_rx(dev) do { \
@@ -390,6 +436,7 @@
 	u32			IMR_cache;
 	struct eeprom		ee;
 
+	unsigned		linkstate;
 
 	spinlock_t	tx_lock;
 
@@ -441,11 +488,11 @@
 
 static inline void build_rx_desc32(struct ns83820 *dev, u32 *desc, u32 link, u32 buf, u32 cmdsts, u32 extsts)
 {
-	desc[0] = link;
-	desc[1] = buf;
-	desc[3] = extsts;
+	desc[0] = cpu_to_le32(link);
+	desc[1] = cpu_to_le32(buf);
+	desc[3] = cpu_to_le32(extsts);
 	mb();
-	desc[2] = cmdsts;
+	desc[2] = cpu_to_le32(cmdsts);
 }
 
 #define build_rx_desc	build_rx_desc32
@@ -486,7 +533,7 @@
 	build_rx_desc(dev, sg, 0, buf, cmdsts, 0);
 	/* update link of previous rx */
 	if (next_empty != dev->rx_info.next_rx)
-		dev->rx_info.descs[((NR_RX_DESC + next_empty - 1) % NR_RX_DESC) * DESC_SIZE] = dev->rx_info.phy_descs + (next_empty * DESC_SIZE * 4);
+		dev->rx_info.descs[((NR_RX_DESC + next_empty - 1) % NR_RX_DESC) * DESC_SIZE] = cpu_to_le32(dev->rx_info.phy_descs + (next_empty * DESC_SIZE * 4));
 
 	return 0;
 }
@@ -545,39 +592,93 @@
 
 static void phy_intr(struct ns83820 *dev)
 {
-	static char *speeds[] = { "10", "100", "1000", "1000(?)" };
+	static char *speeds[] = { "10", "100", "1000", "1000(?)", "1000F" };
 	u32 cfg, new_cfg;
+	u32 tbisr, tanar, tanlpar;
+	int speed, fullduplex, newlinkstate;
 
-	new_cfg = dev->CFG_cache & ~(CFG_SB | CFG_MODE_1000 | CFG_SPDSTS);
 	cfg = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
 
-	if (cfg & CFG_SPDSTS1)
-		new_cfg |= CFG_MODE_1000 | CFG_SB;
-	else
-		new_cfg &= ~CFG_MODE_1000 | CFG_SB;
+	if (dev->CFG_cache & CFG_TBI_EN) {
 
-	if ((cfg & CFG_LNKSTS) && ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
-		writel(new_cfg, dev->base + CFG);
-		dev->CFG_cache = new_cfg;
-	}
+		/* we have an optical transceiver */
+		tbisr = readl(dev->base + TBISR);
+		tanar = readl(dev->base + TANAR);
+		tanlpar = readl(dev->base + TANLPAR);
+		dprintk("phy_intr: tbisr=%08x, tanar=%08x, tanlpar=%08x\n",
+			tbisr, tanar, tanlpar);
+
+		if ( (fullduplex = (tanlpar & TANAR_FULL_DUP)
+		      && (tanar & TANAR_FULL_DUP)) ) {
+
+			/* both of us are full duplex */
+			writel(readl(dev->base + TXCFG)
+			       | TXCFG_CSI | TXCFG_HBI | TXCFG_ATP,
+			       dev->base + TXCFG);
+			writel(readl(dev->base + RXCFG) | RXCFG_RX_FD,
+			       dev->base + RXCFG);
+			/* Light up full duplex LED */
+			writel(readl(dev->base + GPIOR) | GPIOR_GP1_OUT,
+			       dev->base + GPIOR);
+
+		} else if(((tanlpar & TANAR_HALF_DUP)
+			   && (tanar & TANAR_HALF_DUP))
+			|| ((tanlpar & TANAR_FULL_DUP)
+			    && (tanar & TANAR_HALF_DUP))
+			|| ((tanlpar & TANAR_HALF_DUP)
+			    && (tanar & TANAR_FULL_DUP))) {
+
+			/* one or both of us are half duplex */
+			writel((readl(dev->base + TXCFG)
+				& ~(TXCFG_CSI | TXCFG_HBI)) | TXCFG_ATP,
+			       dev->base + TXCFG);
+			writel(readl(dev->base + RXCFG) & ~RXCFG_RX_FD,
+			       dev->base + RXCFG);
+			/* Turn off full duplex LED */
+			writel(readl(dev->base + GPIOR) & ~GPIOR_GP1_OUT,
+			       dev->base + GPIOR);
+		}
 
-	dev->CFG_cache &= ~CFG_SPDSTS;
-	dev->CFG_cache |= cfg & CFG_SPDSTS;
+		speed = 4; /* 1000F */
 
-	if (cfg & CFG_LNKSTS) {
-		netif_start_queue(&dev->net_dev);
-		netif_wake_queue(&dev->net_dev);
 	} else {
-		netif_stop_queue(&dev->net_dev);
+		/* we have a copper transceiver */
+		new_cfg = dev->CFG_cache & ~(CFG_SB | CFG_MODE_1000 | CFG_SPDSTS);
+
+		if (cfg & CFG_SPDSTS1)
+			new_cfg |= CFG_MODE_1000 | CFG_SB;
+		else
+			new_cfg &= ~CFG_MODE_1000 | CFG_SB;
+
+		if ((cfg & CFG_LNKSTS) && ((new_cfg ^ dev->CFG_cache) & CFG_MODE_1000)) {
+			writel(new_cfg, dev->base + CFG);
+			dev->CFG_cache = new_cfg;
+		}
+
+		dev->CFG_cache &= ~CFG_SPDSTS;
+		dev->CFG_cache |= cfg & CFG_SPDSTS;
+
+		speed = ((cfg / CFG_SPDSTS0) & 3);
+		fullduplex = (cfg & CFG_DUPSTS);
 	}
 
-	if (cfg & CFG_LNKSTS)
+	newlinkstate = (cfg & CFG_LNKSTS) ? LINK_UP : LINK_DOWN;
+
+	if (newlinkstate & LINK_UP
+	    && dev->linkstate != newlinkstate) {
+		netif_start_queue(&dev->net_dev);
+		netif_wake_queue(&dev->net_dev);
 		printk(KERN_INFO "%s: link now %s mbps, %s duplex and up.\n",
 			dev->net_dev.name,
-			speeds[((cfg / CFG_SPDSTS0) & 3)],
-			(cfg & CFG_DUPSTS) ? "full" : "half");
-	else
+			speeds[speed],
+			fullduplex ? "full" : "half");
+	} else if (newlinkstate & LINK_DOWN
+		   && dev->linkstate != newlinkstate) {
+		netif_stop_queue(&dev->net_dev);
 		printk(KERN_INFO "%s: link now down.\n", dev->net_dev.name);
+	}
+
+	dev->linkstate = newlinkstate;
 }
 
 static int ns83820_setup_rx(struct ns83820 *dev)
@@ -698,15 +799,15 @@
 	dprintk("walking descs\n");
 	next_rx = info->next_rx;
 	desc = info->descs + (DESC_SIZE * next_rx);
-	while ((CMDSTS_OWN & (cmdsts = desc[CMDSTS])) &&
+	while ((CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[CMDSTS]))) &&
 	       (cmdsts != CMDSTS_OWN)) {
 		struct sk_buff *skb;
-		u32 extsts = desc[EXTSTS];
-		dmaaddr_high_t bufptr = *(hw_addr_t *)(desc + BUFPTR);
+		u32 extsts = le32_to_cpu(desc[EXTSTS]);
+		dmaaddr_high_t bufptr = le32_to_cpu(desc[BUFPTR]);
 
 		dprintk("cmdsts: %08x\n", cmdsts);
-		dprintk("link: %08x\n", desc[LINK]);
-		dprintk("extsts: %08x\n", desc[EXTSTS]);
+		dprintk("link: %08x\n", cpu_to_le32(desc[LINK]));
+		dprintk("extsts: %08x\n", extsts);
 
 		skb = info->skbs[next_rx];
 		info->skbs[next_rx] = NULL;
@@ -718,14 +819,14 @@
 		pci_unmap_single(dev->pci_dev, bufptr,
 				 RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
 		if (CMDSTS_OK & cmdsts) {
-#ifndef __i386__
+#if 0 //ndef __i386__
 			struct sk_buff *tmp;
 #endif
 			int len = cmdsts & 0xffff;
 			if (!skb)
 				BUG();
 			skb_put(skb, len);
-#ifndef __i386__	/* I hate the network stack sometimes */
+#if 0 //ndef __i386__	/* I hate the network stack sometimes */
 			tmp = __dev_alloc_skb(RX_BUF_SIZE+16, GFP_ATOMIC);
 			if (!tmp)
 				goto done;
@@ -788,9 +889,9 @@
 	desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
 
 	dprintk("tx_done_idx=%d free_idx=%d cmdsts=%08x\n",
-		tx_done_idx, dev->tx_free_idx, desc[CMDSTS]);
+		tx_done_idx, dev->tx_free_idx, le32_to_cpu(desc[CMDSTS]));
 	while ((tx_done_idx != dev->tx_free_idx) &&
-	       !(CMDSTS_OWN & (cmdsts = desc[CMDSTS])) ) {
+	       !(CMDSTS_OWN & (cmdsts = le32_to_cpu(desc[CMDSTS]))) ) {
 		struct sk_buff *skb;
 
 		if (cmdsts & CMDSTS_ERR)
@@ -801,13 +902,13 @@
 			dev->stats.tx_bytes += cmdsts & 0xffff;
 
 		dprintk("tx_done_idx=%d free_idx=%d cmdsts=%08x\n",
-			tx_done_idx, dev->tx_free_idx, desc[CMDSTS]);
+			tx_done_idx, dev->tx_free_idx, cmdsts);
 		skb = dev->tx_skbs[tx_done_idx];
 		dev->tx_skbs[tx_done_idx] = NULL;
 		dprintk("done(%p)\n", skb);
 		if (skb) {
 			pci_unmap_single(dev->pci_dev,
-					*(hw_addr_t *)(desc + BUFPTR),
+					le32_to_cpu(desc[BUFPTR]),
 					skb->len,
 					PCI_DMA_TODEVICE);
 			dev_kfree_skb_irq(skb);
@@ -815,7 +916,7 @@
 
 		tx_done_idx = (tx_done_idx + 1) % NR_TX_DESC;
 		dev->tx_done_idx = tx_done_idx;
-		desc[CMDSTS] = 0;
+		desc[CMDSTS] = cpu_to_le32(0);
 		barrier();
 		desc = dev->tx_descs + (tx_done_idx * DESC_SIZE);
 	}
@@ -936,17 +1037,17 @@
 		}
 #endif
 
-		dprintk("frag[%3u]: %4u @ 0x%x%08Lx\n", free_idx, len,
+		dprintk("frag[%3u]: %4u @ 0x%08Lx\n", free_idx, len,
 			(unsigned long long)buf);
 		free_idx = (free_idx + 1) % NR_TX_DESC;
-		desc[LINK] = dev->tx_phy_descs + (free_idx * DESC_SIZE * 4);
-		*(hw_addr_t *)(desc + BUFPTR) = buf;
-		desc[EXTSTS] = extsts;
+		desc[LINK] = cpu_to_le32(dev->tx_phy_descs + (free_idx * DESC_SIZE * 4));
+		desc[BUFPTR] = cpu_to_le32(buf);
+		desc[EXTSTS] = cpu_to_le32(extsts);
 
 		cmdsts = ((nr_frags|residue) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
 		cmdsts |= (desc == first_desc) ? 0 : CMDSTS_OWN;
 		cmdsts |= len;
-		desc[CMDSTS] = cmdsts;
+		desc[CMDSTS] = cpu_to_le32(cmdsts);
 
 		if (residue) {
 			buf += len;
@@ -967,7 +1068,7 @@
 	}
 	dprintk("done pkt\n");
 	dev->tx_skbs[free_idx] = skb;
-	first_desc[CMDSTS] |= CMDSTS_OWN;
+	first_desc[CMDSTS] |= cpu_to_le32(CMDSTS_OWN);
 	dev->tx_free_idx = free_idx;
 	kick_tx(dev);
 
@@ -1007,6 +1108,59 @@
 	return &dev->stats;
 }
 
+static int ns83820_ethtool_ioctl (struct ns83820 *dev, void *useraddr)
+{
+	u32 ethcmd;
+
+	if (copy_from_user(&ethcmd, useraddr, sizeof (ethcmd)))
+		return -EFAULT;
+
+	switch (ethcmd) {
+	case ETHTOOL_GDRVINFO:
+		{
+			struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
+			strcpy(info.driver, "ns83820");
+			strcpy(info.version, VERSION);
+			strcpy(info.bus_info, dev->pci_dev->slot_name);
+			if (copy_to_user(useraddr, &info, sizeof (info)))
+				return -EFAULT;
+			return 0;
+		}
+
+	/* get link status */
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = { ETHTOOL_GLINK };
+		u32 cfg = readl(dev->base + CFG) ^ SPDSTS_POLARITY;
+
+		if (cfg & CFG_LNKSTS)
+			edata.data = 1;
+		else
+			edata.data = 0;
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int ns83820_ioctl(struct net_device *_dev, struct ifreq *rq, int cmd)
+{
+	struct ns83820 *dev = _dev->priv;
+
+	switch(cmd) {
+	case SIOCETHTOOL:
+		return ns83820_ethtool_ioctl(dev, (void *) rq->ifr_data);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void ns83820_irq(int foo, void *data, struct pt_regs *regs)
 {
 	struct ns83820 *dev = data;
@@ -1048,10 +1202,14 @@
 			Dprintk("BAD\n");
 	}
 
-	if (ISR_RXSOVR & isr)
-		Dprintk("overrun\n");
-	if (ISR_RXORN & isr)
-		Dprintk("overrun\n");
+	if (unlikely(ISR_RXSOVR & isr)) {
+		Dprintk("overrun: rxsovr\n");
+		dev->stats.rx_over_errors ++;
+	}
+	if (unlikely(ISR_RXORN & isr)) {
+		Dprintk("overrun: rxorn\n");
+		dev->stats.rx_over_errors ++;
+	}
 
 	if ((ISR_RXRCMP & isr) && dev->rx_info.up)
 		writel(CR_RXE, dev->base + CR);
@@ -1150,9 +1308,10 @@
 
 	memset(dev->tx_descs, 0, 4 * NR_TX_DESC * DESC_SIZE);
 	for (i=0; i<NR_TX_DESC; i++) {
-		*(hw_addr_t *)(dev->tx_descs + (i * DESC_SIZE) + LINK)
-				= dev->tx_phy_descs
-				  + ((i+1) % NR_TX_DESC) * DESC_SIZE * 4;
+		dev->tx_descs[(i * DESC_SIZE) + LINK]
+				= cpu_to_le32(
+				  dev->tx_phy_descs
+				  + ((i+1) % NR_TX_DESC) * DESC_SIZE * 4);
 	}
 
 	dev->tx_idx = 0;
@@ -1190,6 +1349,9 @@
 #if 0	/* I've left this in as an example of how to use eeprom.h */
 		data = eeprom_readw(&dev->ee, 0xa + 2 - i);
 #else
+		/* Read from the perfect match memory: this is loaded by
+		 * the chip from the EEPROM via the EELOAD self test.
+		 */
 		writel(i*2, dev->base + RFCR);
 		data = readl(dev->base + RFDR);
 #endif
@@ -1287,6 +1449,8 @@
 		goto out_unmap;
 	}
 
+	if(register_netdev(&dev->net_dev)) goto out_unmap;
+
 	dev->net_dev.open = ns83820_open;
 	dev->net_dev.stop = ns83820_stop;
 	dev->net_dev.hard_start_xmit = ns83820_hard_start_xmit;
@@ -1294,6 +1458,7 @@
 	dev->net_dev.get_stats = ns83820_get_stats;
 	dev->net_dev.change_mtu = ns83820_change_mtu;
 	dev->net_dev.set_multicast_list = ns83820_set_multicast;
+	dev->net_dev.do_ioctl = ns83820_ioctl;
 	//FIXME: dev->net_dev.tx_timeout = ns83820_tx_timeout;
 
 	pci_set_drvdata(pci_dev, dev);
@@ -1318,12 +1483,15 @@
 	dev->CFG_cache = readl(dev->base + CFG);
 
 	if ((dev->CFG_cache & CFG_PCI64_DET)) {
-		printk("%s: enabling 64 bit PCI.\n", dev->net_dev.name);
+		printk("%s: enabling 64 bit PCI addressing.\n",
+			dev->net_dev.name);
 		dev->CFG_cache |= CFG_T64ADDR | CFG_DATA64_EN;
-	} else {
-		printk("%s: disabling 64 bit PCI.\n", dev->net_dev.name);
+#if defined(USE_64BIT_ADDR)
+		dev->net_dev.features |= NETIF_F_HIGHDMA;
+#endif
+	} else
 		dev->CFG_cache &= ~(CFG_T64ADDR | CFG_DATA64_EN);
-	}
+
 	dev->CFG_cache &= (CFG_TBI_EN  | CFG_MRM_DIS   | CFG_MWI_DIS |
 			   CFG_T64ADDR | CFG_DATA64_EN | CFG_EXT_125 |
 			   CFG_M64ADDR);
@@ -1333,15 +1501,28 @@
 	dev->CFG_cache |= CFG_POW;
 #ifdef USE_64BIT_ADDR
 	dev->CFG_cache |= CFG_M64ADDR;
-	printk("using 64 bit addressing\n");
 #endif
-#ifdef __LITTLE_ENDIAN
+	/* Big endian mode does not seem to do what the docs suggest */
 	dev->CFG_cache &= ~CFG_BEM;
-#elif defined(__BIG_ENDIAN)
-	dev->CFG_cache |= CFG_BEM;
-#else
-#error This driver only works for big or little endian!!!
-#endif
+
+	/* setup optical transceiver if we have one */
+	if (dev->CFG_cache & CFG_TBI_EN) {
+		printk("%s: enabling optical transceiver\n", dev->net_dev.name);
+		writel(readl(dev->base + GPIOR) | 0x3e8, dev->base + GPIOR);
+
+		/* setup auto negotiation feature advertisement */
+		writel(readl(dev->base + TANAR)
+		       | TANAR_HALF_DUP | TANAR_FULL_DUP,
+		       dev->base + TANAR);
+
+		/* start auto negotiation */
+		writel(TBICR_MR_AN_ENABLE | TBICR_MR_RESTART_AN,
+		       dev->base + TBICR);
+		writel(TBICR_MR_AN_ENABLE, dev->base + TBICR);
+		dev->linkstate = LINK_AUTONEGOTIATE;
+
+		dev->CFG_cache |= CFG_MODE_1000;
+	}
 
 	writel(dev->CFG_cache, dev->base + CFG);
 	dprintk("CFG: %08x\n", dev->CFG_cache);
@@ -1397,15 +1578,15 @@
 	dev->net_dev.features |= NETIF_F_HIGHDMA;
 #endif
 
-	register_netdev(&dev->net_dev);
-
-	printk(KERN_INFO "%s: ns83820.c v" VERSION ": DP83820 %02x:%02x:%02x:%02x:%02x:%02x pciaddr=0x%08lx irq=%d rev 0x%x\n",
+	printk(KERN_INFO "%s: ns83820 v" VERSION ": DP83820 v%u.%u: %02x:%02x:%02x:%02x:%02x:%02x io=0x%08lx irq=%d f=%s\n",
 		dev->net_dev.name,
+		(unsigned)readl(dev->base + SRR) >> 8,
+		(unsigned)readl(dev->base + SRR) & 0xff,
 		dev->net_dev.dev_addr[0], dev->net_dev.dev_addr[1],
 		dev->net_dev.dev_addr[2], dev->net_dev.dev_addr[3],
 		dev->net_dev.dev_addr[4], dev->net_dev.dev_addr[5],
 		addr, pci_dev->irq,
-		(unsigned)readl(dev->base + SRR)
+		(dev->net_dev.features & NETIF_F_HIGHDMA) ? "sg" : "h,sg"
 		);
 
 	return 0;
diff -ur /md0/kernels/2.4/v2.4.17-pre5/include/linux/eeprom.h ns83820/include/linux/eeprom.h
--- /md0/kernels/2.4/v2.4.17-pre5/include/linux/eeprom.h	Thu Dec  6 23:43:10 2001
+++ ns83820/include/linux/eeprom.h	Mon Sep 24 23:56:37 2001
@@ -1,6 +1,7 @@
 /* credit winbond-840.c
  */
 #include <asm/io.h>
+
 struct eeprom_ops {
 	void	(*set_cs)(void *ee);
 	void	(*clear_cs)(void *ee);
