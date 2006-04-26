Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWDZK0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWDZK0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWDZK0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:26:19 -0400
Received: from havoc.gtf.org ([69.61.125.42]:23936 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932317AbWDZK0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:26:16 -0400
Date: Wed, 26 Apr 2006 06:26:14 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060426102614.GA9377@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 MAINTAINERS                                     |    8 ++
 drivers/net/e1000/e1000_main.c                  |    1 
 drivers/net/forcedeth.c                         |   79 +++++++++++++++++---
 drivers/net/gianfar.c                           |   56 +++++++-------
 drivers/net/gianfar.h                           |   67 ++++++++++++-----
 drivers/net/gianfar_ethtool.c                   |   20 +++--
 drivers/net/gianfar_sysfs.c                     |   24 +++---
 drivers/net/sky2.c                              |   52 ++++++++++---
 drivers/net/sky2.h                              |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h      |    8 ++
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c      |   92 ++++++++++++++++--------
 drivers/net/wireless/bcm43xx/bcm43xx_pio.h      |   16 +++-
 drivers/net/wireless/hostap/hostap_ioctl.c      |    4 -
 include/linux/netdevice.h                       |   18 ++--
 include/net/ieee80211softmac.h                  |    5 +
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   20 ++++-
 net/ieee80211/softmac/ieee80211softmac_module.c |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c     |   27 ++++---
 18 files changed, 354 insertions(+), 147 deletions(-)

Andy Fleming:
      Fix locking in gianfar

Auke Kok:
      e1000: Update truesize with the length of the packet for packet split

Ayaz Abdulla:
      forcedeth: fix initialization

Johannes Berg:
      softmac: fix SIOCSIWAP

Michael Buesch:
      bcm43xx: add to MAINTAINERS
      bcm43xx: make PIO mode usable

Pavel Roskin:
      Fix crash on big-endian systems during scan

Stephen Hemminger:
      sky2: reschedule if irq still pending
      sky2: add fake idle irq timer
      sky2: use ALIGN() macro
      sky2: reset function can be devinit
      sky2: version 1.2

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e1e817..d6a8e5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -421,6 +421,14 @@ L:	linux-hams@vger.kernel.org
 W:	http://www.baycom.org/~tom/ham/ham.html
 S:	Maintained
 
+BCM43XX WIRELESS DRIVER
+P:	Michael Buesch
+M:	mb@bu3sch.de
+P:	Stefano Brivio
+M:	st3@riseup.net
+W:	http://bcm43xx.berlios.de/
+S:	Maintained
+
 BEFS FILE SYSTEM
 P:	Sergey S. Kostyliov
 M:	rathamahata@php4.ru
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index add8dc4..c99e878 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3768,6 +3768,7 @@ #endif
 			ps_page->ps_page[j] = NULL;
 			skb->len += length;
 			skb->data_len += length;
+			skb->truesize += length;
 		}
 
 copydone:
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 7627a75..9788b1e 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -105,6 +105,7 @@
  *	0.50: 20 Jan 2006: Add 8021pq tagging support.
  *	0.51: 20 Jan 2006: Add 64bit consistent memory allocation for rings.
  *	0.52: 20 Jan 2006: Add MSI/MSIX support.
+ *	0.53: 19 Mar 2006: Fix init from low power mode and add hw reset.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -116,7 +117,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.52"
+#define FORCEDETH_VERSION		"0.53"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -160,6 +161,7 @@ #define DEV_HAS_CHECKSUM        0x0010  
 #define DEV_HAS_VLAN            0x0020  /* device supports vlan tagging and striping */
 #define DEV_HAS_MSI             0x0040  /* device supports MSI */
 #define DEV_HAS_MSI_X           0x0080  /* device supports MSI-X */
+#define DEV_HAS_POWER_CNTRL     0x0100  /* device supports power savings */
 
 enum {
 	NvRegIrqStatus = 0x000,
@@ -203,6 +205,8 @@ #define NVREG_MSI_VECTOR_0_ENABLED 0x01
 #define NVREG_MISC1_HD		0x02
 #define NVREG_MISC1_FORCE	0x3b0f3c
 
+	NvRegMacReset = 0x3c,
+#define NVREG_MAC_RESET_ASSERT	0x0F3
 	NvRegTransmitterControl = 0x084,
 #define NVREG_XMITCTL_START	0x01
 	NvRegTransmitterStatus = 0x088,
@@ -326,6 +330,10 @@ #define NVREG_VLANCONTROL_ENABLE	0x2000
 	NvRegMSIXMap0 = 0x3e0,
 	NvRegMSIXMap1 = 0x3e4,
 	NvRegMSIXIrqStatus = 0x3f0,
+
+	NvRegPowerState2 = 0x600,
+#define NVREG_POWERSTATE2_POWERUP_MASK		0x0F11
+#define NVREG_POWERSTATE2_POWERUP_REV_A3	0x0001
 };
 
 /* Big endian: should work, but is untested */
@@ -414,7 +422,8 @@ #define NV_RX3_VLAN_TAG_PRESENT (1<<16)
 #define NV_RX3_VLAN_TAG_MASK	(0x0000FFFF)
 
 /* Miscelaneous hardware related defines: */
-#define NV_PCI_REGSZ		0x270
+#define NV_PCI_REGSZ_VER1      	0x270
+#define NV_PCI_REGSZ_VER2      	0x604
 
 /* various timeout delays: all in usec */
 #define NV_TXRX_RESET_DELAY	4
@@ -431,6 +440,7 @@ #define NV_POWERUP_DELAYMAX	5000
 #define NV_MIIBUSY_DELAY	50
 #define NV_MIIPHY_DELAY	10
 #define NV_MIIPHY_DELAYMAX	10000
+#define NV_MAC_RESET_DELAY	64
 
 #define NV_WAKEUPPATTERNS	5
 #define NV_WAKEUPMASKENTRIES	4
@@ -552,6 +562,8 @@ struct fe_priv {
 	u32 desc_ver;
 	u32 txrxctl_bits;
 	u32 vlanctl_bits;
+	u32 driver_data;
+	u32 register_size;
 
 	void __iomem *base;
 
@@ -919,6 +931,24 @@ static void nv_txrx_reset(struct net_dev
 	pci_push(base);
 }
 
+static void nv_mac_reset(struct net_device *dev)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
+
+	dprintk(KERN_DEBUG "%s: nv_mac_reset\n", dev->name);
+	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->txrxctl_bits, base + NvRegTxRxControl);
+	pci_push(base);
+	writel(NVREG_MAC_RESET_ASSERT, base + NvRegMacReset);
+	pci_push(base);
+	udelay(NV_MAC_RESET_DELAY);
+	writel(0, base + NvRegMacReset);
+	pci_push(base);
+	udelay(NV_MAC_RESET_DELAY);
+	writel(NVREG_TXRXCTL_BIT2 | np->txrxctl_bits, base + NvRegTxRxControl);
+	pci_push(base);
+}
+
 /*
  * nv_get_stats: dev->get_stats function
  * Get latest stats value from the nic.
@@ -1331,7 +1361,7 @@ static void nv_tx_timeout(struct net_dev
 				dev->name, (unsigned long)np->ring_addr,
 				np->next_tx, np->nic_tx);
 		printk(KERN_INFO "%s: Dumping tx registers\n", dev->name);
-		for (i=0;i<0x400;i+= 32) {
+		for (i=0;i<=np->register_size;i+= 32) {
 			printk(KERN_INFO "%3x: %08x %08x %08x %08x %08x %08x %08x %08x\n",
 					i,
 					readl(base + i + 0), readl(base + i + 4),
@@ -2488,11 +2518,11 @@ static int nv_set_settings(struct net_de
 }
 
 #define FORCEDETH_REGS_VER	1
-#define FORCEDETH_REGS_SIZE	0x400 /* 256 32-bit registers */
 
 static int nv_get_regs_len(struct net_device *dev)
 {
-	return FORCEDETH_REGS_SIZE;
+	struct fe_priv *np = netdev_priv(dev);
+	return np->register_size;
 }
 
 static void nv_get_regs(struct net_device *dev, struct ethtool_regs *regs, void *buf)
@@ -2504,7 +2534,7 @@ static void nv_get_regs(struct net_devic
 
 	regs->version = FORCEDETH_REGS_VER;
 	spin_lock_irq(&np->lock);
-	for (i=0;i<FORCEDETH_REGS_SIZE/sizeof(u32);i++)
+	for (i = 0;i <= np->register_size/sizeof(u32); i++)
 		rbuf[i] = readl(base + i*sizeof(u32));
 	spin_unlock_irq(&np->lock);
 }
@@ -2608,6 +2638,8 @@ static int nv_open(struct net_device *de
 	dprintk(KERN_DEBUG "nv_open: begin\n");
 
 	/* 1) erase previous misconfiguration */
+	if (np->driver_data & DEV_HAS_POWER_CNTRL)
+		nv_mac_reset(dev);
 	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */
 	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
 	writel(0, base + NvRegMulticastAddrB);
@@ -2878,6 +2910,7 @@ static int __devinit nv_probe(struct pci
 	unsigned long addr;
 	u8 __iomem *base;
 	int err, i;
+	u32 powerstate;
 
 	dev = alloc_etherdev(sizeof(struct fe_priv));
 	err = -ENOMEM;
@@ -2910,6 +2943,11 @@ static int __devinit nv_probe(struct pci
 	if (err < 0)
 		goto out_disable;
 
+	if (id->driver_data & (DEV_HAS_VLAN|DEV_HAS_MSI_X|DEV_HAS_POWER_CNTRL))
+		np->register_size = NV_PCI_REGSZ_VER2;
+	else
+		np->register_size = NV_PCI_REGSZ_VER1;
+
 	err = -EINVAL;
 	addr = 0;
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
@@ -2918,7 +2956,7 @@ static int __devinit nv_probe(struct pci
 				pci_resource_len(pci_dev, i),
 				pci_resource_flags(pci_dev, i));
 		if (pci_resource_flags(pci_dev, i) & IORESOURCE_MEM &&
-				pci_resource_len(pci_dev, i) >= NV_PCI_REGSZ) {
+				pci_resource_len(pci_dev, i) >= np->register_size) {
 			addr = pci_resource_start(pci_dev, i);
 			break;
 		}
@@ -2929,6 +2967,9 @@ static int __devinit nv_probe(struct pci
 		goto out_relreg;
 	}
 
+	/* copy of driver data */
+	np->driver_data = id->driver_data;
+
 	/* handle different descriptor versions */
 	if (id->driver_data & DEV_HAS_HIGH_DMA) {
 		/* packet format 3: supports 40-bit addressing */
@@ -2986,7 +3027,7 @@ #endif
 	}
 
 	err = -ENOMEM;
-	np->base = ioremap(addr, NV_PCI_REGSZ);
+	np->base = ioremap(addr, np->register_size);
 	if (!np->base)
 		goto out_relreg;
 	dev->base_addr = (unsigned long)np->base;
@@ -3062,6 +3103,20 @@ #endif
 	writel(0, base + NvRegWakeUpFlags);
 	np->wolenabled = 0;
 
+	if (id->driver_data & DEV_HAS_POWER_CNTRL) {
+		u8 revision_id;
+		pci_read_config_byte(pci_dev, PCI_REVISION_ID, &revision_id);
+
+		/* take phy and nic out of low power mode */
+		powerstate = readl(base + NvRegPowerState2);
+		powerstate &= ~NVREG_POWERSTATE2_POWERUP_MASK;
+		if ((id->device == PCI_DEVICE_ID_NVIDIA_NVENET_12 ||
+		     id->device == PCI_DEVICE_ID_NVIDIA_NVENET_13) &&
+		    revision_id >= 0xA3)
+			powerstate |= NVREG_POWERSTATE2_POWERUP_REV_A3;
+		writel(powerstate, base + NvRegPowerState2);
+	}
+
 	if (np->desc_ver == DESC_VER_1) {
 		np->tx_flags = NV_TX_VALID;
 	} else {
@@ -3223,19 +3278,19 @@ static struct pci_device_id pci_tbl[] = 
 	},
 	{	/* MCP51 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_12),
-		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_HIGH_DMA,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_HIGH_DMA|DEV_HAS_POWER_CNTRL,
 	},
 	{	/* MCP51 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_13),
-		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_HIGH_DMA,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_HIGH_DMA|DEV_HAS_POWER_CNTRL,
 	},
 	{	/* MCP55 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_14),
-		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA|DEV_HAS_VLAN|DEV_HAS_MSI|DEV_HAS_MSI_X,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA|DEV_HAS_VLAN|DEV_HAS_MSI|DEV_HAS_MSI_X|DEV_HAS_POWER_CNTRL,
 	},
 	{	/* MCP55 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_15),
-		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA|DEV_HAS_VLAN|DEV_HAS_MSI|DEV_HAS_MSI_X,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA|DEV_HAS_VLAN|DEV_HAS_MSI|DEV_HAS_MSI_X|DEV_HAS_POWER_CNTRL,
 	},
 	{0,},
 };
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 771e25d..218d317 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -210,7 +210,8 @@ static int gfar_probe(struct platform_de
 		goto regs_fail;
 	}
 
-	spin_lock_init(&priv->lock);
+	spin_lock_init(&priv->txlock);
+	spin_lock_init(&priv->rxlock);
 
 	platform_set_drvdata(pdev, dev);
 
@@ -515,11 +516,13 @@ void stop_gfar(struct net_device *dev)
 	phy_stop(priv->phydev);
 
 	/* Lock it down */
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->txlock, flags);
+	spin_lock(&priv->rxlock);
 
 	gfar_halt(dev);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->rxlock);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 
 	/* Free the IRQs */
 	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
@@ -605,14 +608,15 @@ void gfar_start(struct net_device *dev)
 	tempval |= DMACTRL_INIT_SETTINGS;
 	gfar_write(&priv->regs->dmactrl, tempval);
 
-	/* Clear THLT, so that the DMA starts polling now */
-	gfar_write(&regs->tstat, TSTAT_CLEAR_THALT);
-
 	/* Make sure we aren't stopped */
 	tempval = gfar_read(&priv->regs->dmactrl);
 	tempval &= ~(DMACTRL_GRS | DMACTRL_GTS);
 	gfar_write(&priv->regs->dmactrl, tempval);
 
+	/* Clear THLT/RHLT, so that the DMA starts polling now */
+	gfar_write(&regs->tstat, TSTAT_CLEAR_THALT);
+	gfar_write(&regs->rstat, RSTAT_CLEAR_RHALT);
+
 	/* Unmask the interrupts we look for */
 	gfar_write(&regs->imask, IMASK_DEFAULT);
 }
@@ -928,12 +932,13 @@ static int gfar_start_xmit(struct sk_buf
 	struct txfcb *fcb = NULL;
 	struct txbd8 *txbdp;
 	u16 status;
+	unsigned long flags;
 
 	/* Update transmit stats */
 	priv->stats.tx_bytes += skb->len;
 
 	/* Lock priv now */
-	spin_lock_irq(&priv->lock);
+	spin_lock_irqsave(&priv->txlock, flags);
 
 	/* Point at the first free tx descriptor */
 	txbdp = priv->cur_tx;
@@ -1004,7 +1009,7 @@ static int gfar_start_xmit(struct sk_buf
 	gfar_write(&priv->regs->tstat, TSTAT_CLEAR_THALT);
 
 	/* Unlock priv */
-	spin_unlock_irq(&priv->lock);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 
 	return 0;
 }
@@ -1049,7 +1054,7 @@ static void gfar_vlan_rx_register(struct
 	unsigned long flags;
 	u32 tempval;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->rxlock, flags);
 
 	priv->vlgrp = grp;
 
@@ -1076,7 +1081,7 @@ static void gfar_vlan_rx_register(struct
 		gfar_write(&priv->regs->rctrl, tempval);
 	}
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->rxlock, flags);
 }
 
 
@@ -1085,12 +1090,12 @@ static void gfar_vlan_rx_kill_vid(struct
 	struct gfar_private *priv = netdev_priv(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->rxlock, flags);
 
 	if (priv->vlgrp)
 		priv->vlgrp->vlan_devices[vid] = NULL;
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->rxlock, flags);
 }
 
 
@@ -1179,7 +1184,7 @@ static irqreturn_t gfar_transmit(int irq
 	gfar_write(&priv->regs->ievent, IEVENT_TX_MASK);
 
 	/* Lock priv */
-	spin_lock(&priv->lock);
+	spin_lock(&priv->txlock);
 	bdp = priv->dirty_tx;
 	while ((bdp->status & TXBD_READY) == 0) {
 		/* If dirty_tx and cur_tx are the same, then either the */
@@ -1224,7 +1229,7 @@ static irqreturn_t gfar_transmit(int irq
 	else
 		gfar_write(&priv->regs->txic, 0);
 
-	spin_unlock(&priv->lock);
+	spin_unlock(&priv->txlock);
 
 	return IRQ_HANDLED;
 }
@@ -1305,9 +1310,10 @@ irqreturn_t gfar_receive(int irq, void *
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct gfar_private *priv = netdev_priv(dev);
-
 #ifdef CONFIG_GFAR_NAPI
 	u32 tempval;
+#else
+	unsigned long flags;
 #endif
 
 	/* Clear IEVENT, so rx interrupt isn't called again
@@ -1330,7 +1336,7 @@ #ifdef CONFIG_GFAR_NAPI
 	}
 #else
 
-	spin_lock(&priv->lock);
+	spin_lock_irqsave(&priv->rxlock, flags);
 	gfar_clean_rx_ring(dev, priv->rx_ring_size);
 
 	/* If we are coalescing interrupts, update the timer */
@@ -1341,7 +1347,7 @@ #else
 	else
 		gfar_write(&priv->regs->rxic, 0);
 
-	spin_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->rxlock, flags);
 #endif
 
 	return IRQ_HANDLED;
@@ -1490,13 +1496,6 @@ int gfar_clean_rx_ring(struct net_device
 	/* Update the current rxbd pointer to be the next one */
 	priv->cur_rx = bdp;
 
-	/* If no packets have arrived since the
-	 * last one we processed, clear the IEVENT RX and
-	 * BSY bits so that another interrupt won't be
-	 * generated when we set IMASK */
-	if (bdp->status & RXBD_EMPTY)
-		gfar_write(&priv->regs->ievent, IEVENT_RX_MASK);
-
 	return howmany;
 }
 
@@ -1516,7 +1515,7 @@ static int gfar_poll(struct net_device *
 	rx_work_limit -= howmany;
 	*budget -= howmany;
 
-	if (rx_work_limit >= 0) {
+	if (rx_work_limit > 0) {
 		netif_rx_complete(dev);
 
 		/* Clear the halt bit in RSTAT */
@@ -1533,7 +1532,8 @@ static int gfar_poll(struct net_device *
 			gfar_write(&priv->regs->rxic, 0);
 	}
 
-	return (rx_work_limit < 0) ? 1 : 0;
+	/* Return 1 if there's more work to do */
+	return (rx_work_limit > 0) ? 0 : 1;
 }
 #endif
 
@@ -1629,7 +1629,7 @@ static void adjust_link(struct net_devic
 	struct phy_device *phydev = priv->phydev;
 	int new_state = 0;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->txlock, flags);
 	if (phydev->link) {
 		u32 tempval = gfar_read(&regs->maccfg2);
 		u32 ecntrl = gfar_read(&regs->ecntrl);
@@ -1694,7 +1694,7 @@ static void adjust_link(struct net_devic
 	if (new_state && netif_msg_link(priv))
 		phy_print_status(phydev);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 }
 
 /* Update the hash table based on the current list of multicast
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index d37d540..127c98c 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -656,43 +656,62 @@ struct gfar {
  * the buffer descriptor determines the actual condition.
  */
 struct gfar_private {
-	/* pointers to arrays of skbuffs for tx and rx */
+	/* Fields controlled by TX lock */
+	spinlock_t txlock;
+
+	/* Pointer to the array of skbuffs */
 	struct sk_buff ** tx_skbuff;
-	struct sk_buff ** rx_skbuff;
 
-	/* indices pointing to the next free sbk in skb arrays */
+	/* next free skb in the array */
 	u16 skb_curtx;
-	u16 skb_currx;
 
-	/* index of the first skb which hasn't been transmitted
-	 * yet. */
+	/* First skb in line to be transmitted */
 	u16 skb_dirtytx;
 
 	/* Configuration info for the coalescing features */
 	unsigned char txcoalescing;
 	unsigned short txcount;
 	unsigned short txtime;
+
+	/* Buffer descriptor pointers */
+	struct txbd8 *tx_bd_base;	/* First tx buffer descriptor */
+	struct txbd8 *cur_tx;	        /* Next free ring entry */
+	struct txbd8 *dirty_tx;		/* First buffer in line
+					   to be transmitted */
+	unsigned int tx_ring_size;
+
+	/* RX Locked fields */
+	spinlock_t rxlock;
+
+	/* skb array and index */
+	struct sk_buff ** rx_skbuff;
+	u16 skb_currx;
+
+	/* RX Coalescing values */
 	unsigned char rxcoalescing;
 	unsigned short rxcount;
 	unsigned short rxtime;
 
-	/* GFAR addresses */
-	struct rxbd8 *rx_bd_base;	/* Base addresses of Rx and Tx Buffers */
-	struct txbd8 *tx_bd_base;
+	struct rxbd8 *rx_bd_base;	/* First Rx buffers */
 	struct rxbd8 *cur_rx;           /* Next free rx ring entry */
-	struct txbd8 *cur_tx;	        /* Next free ring entry */
-	struct txbd8 *dirty_tx;		/* The Ring entry to be freed. */
-	struct gfar __iomem *regs;	/* Pointer to the GFAR memory mapped Registers */
-	u32 __iomem *hash_regs[16];
-	int hash_width;
-	struct net_device_stats stats; /* linux network statistics */
-	struct gfar_extra_stats extra_stats;
-	spinlock_t lock;
+
+	/* RX parameters */
+	unsigned int rx_ring_size;
 	unsigned int rx_buffer_size;
 	unsigned int rx_stash_size;
 	unsigned int rx_stash_index;
-	unsigned int tx_ring_size;
-	unsigned int rx_ring_size;
+
+	struct vlan_group *vlgrp;
+
+	/* Unprotected fields */
+	/* Pointer to the GFAR memory mapped Registers */
+	struct gfar __iomem *regs;
+
+	/* Hash registers and their width */
+	u32 __iomem *hash_regs[16];
+	int hash_width;
+
+	/* global parameters */
 	unsigned int fifo_threshold;
 	unsigned int fifo_starve;
 	unsigned int fifo_starve_off;
@@ -702,13 +721,15 @@ struct gfar_private {
 		extended_hash:1,
 		bd_stash_en:1;
 	unsigned short padding;
-	struct vlan_group *vlgrp;
-	/* Info structure initialized by board setup code */
+
 	unsigned int interruptTransmit;
 	unsigned int interruptReceive;
 	unsigned int interruptError;
+
+	/* info structure initialized by platform code */
 	struct gianfar_platform_data *einfo;
 
+	/* PHY stuff */
 	struct phy_device *phydev;
 	struct mii_bus *mii_bus;
 	int oldspeed;
@@ -716,6 +737,10 @@ struct gfar_private {
 	int oldlink;
 
 	uint32_t msg_enable;
+
+	/* Network Statistics */
+	struct net_device_stats stats;
+	struct gfar_extra_stats extra_stats;
 };
 
 static inline u32 gfar_read(volatile unsigned __iomem *addr)
diff --git a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
index 5de7b2e..d69698c 100644
--- a/drivers/net/gianfar_ethtool.c
+++ b/drivers/net/gianfar_ethtool.c
@@ -455,10 +455,14 @@ static int gfar_sringparam(struct net_de
 
 		/* Halt TX and RX, and process the frames which
 		 * have already been received */
-		spin_lock_irqsave(&priv->lock, flags);
+		spin_lock_irqsave(&priv->txlock, flags);
+		spin_lock(&priv->rxlock);
+
 		gfar_halt(dev);
 		gfar_clean_rx_ring(dev, priv->rx_ring_size);
-		spin_unlock_irqrestore(&priv->lock, flags);
+
+		spin_unlock(&priv->rxlock);
+		spin_unlock_irqrestore(&priv->txlock, flags);
 
 		/* Now we take down the rings to rebuild them */
 		stop_gfar(dev);
@@ -488,10 +492,14 @@ static int gfar_set_rx_csum(struct net_d
 
 		/* Halt TX and RX, and process the frames which
 		 * have already been received */
-		spin_lock_irqsave(&priv->lock, flags);
+		spin_lock_irqsave(&priv->txlock, flags);
+		spin_lock(&priv->rxlock);
+
 		gfar_halt(dev);
 		gfar_clean_rx_ring(dev, priv->rx_ring_size);
-		spin_unlock_irqrestore(&priv->lock, flags);
+
+		spin_unlock(&priv->rxlock);
+		spin_unlock_irqrestore(&priv->txlock, flags);
 
 		/* Now we take down the rings to rebuild them */
 		stop_gfar(dev);
@@ -523,7 +531,7 @@ static int gfar_set_tx_csum(struct net_d
 	if (!(priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_CSUM))
 		return -EOPNOTSUPP;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->txlock, flags);
 	gfar_halt(dev);
 
 	if (data)
@@ -532,7 +540,7 @@ static int gfar_set_tx_csum(struct net_d
 		dev->features &= ~NETIF_F_IP_CSUM;
 
 	gfar_start(dev);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 
 	return 0;
 }
diff --git a/drivers/net/gianfar_sysfs.c b/drivers/net/gianfar_sysfs.c
index 51ef181..a6d5c43 100644
--- a/drivers/net/gianfar_sysfs.c
+++ b/drivers/net/gianfar_sysfs.c
@@ -82,7 +82,7 @@ static ssize_t gfar_set_bd_stash(struct 
 	else
 		return count;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->rxlock, flags);
 
 	/* Set the new stashing value */
 	priv->bd_stash_en = new_setting;
@@ -96,7 +96,7 @@ static ssize_t gfar_set_bd_stash(struct 
 
 	gfar_write(&priv->regs->attr, temp);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->rxlock, flags);
 
 	return count;
 }
@@ -118,7 +118,7 @@ static ssize_t gfar_set_rx_stash_size(st
 	u32 temp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->rxlock, flags);
 	if (length > priv->rx_buffer_size)
 		return count;
 
@@ -142,7 +142,7 @@ static ssize_t gfar_set_rx_stash_size(st
 
 	gfar_write(&priv->regs->attr, temp);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->rxlock, flags);
 
 	return count;
 }
@@ -166,7 +166,7 @@ static ssize_t gfar_set_rx_stash_index(s
 	u32 temp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->rxlock, flags);
 	if (index > priv->rx_stash_size)
 		return count;
 
@@ -180,7 +180,7 @@ static ssize_t gfar_set_rx_stash_index(s
 	temp |= ATTRELI_EI(index);
 	gfar_write(&priv->regs->attreli, flags);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->rxlock, flags);
 
 	return count;
 }
@@ -205,7 +205,7 @@ static ssize_t gfar_set_fifo_threshold(s
 	if (length > GFAR_MAX_FIFO_THRESHOLD)
 		return count;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->txlock, flags);
 
 	priv->fifo_threshold = length;
 
@@ -214,7 +214,7 @@ static ssize_t gfar_set_fifo_threshold(s
 	temp |= length;
 	gfar_write(&priv->regs->fifo_tx_thr, temp);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 
 	return count;
 }
@@ -240,7 +240,7 @@ static ssize_t gfar_set_fifo_starve(stru
 	if (num > GFAR_MAX_FIFO_STARVE)
 		return count;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->txlock, flags);
 
 	priv->fifo_starve = num;
 
@@ -249,7 +249,7 @@ static ssize_t gfar_set_fifo_starve(stru
 	temp |= num;
 	gfar_write(&priv->regs->fifo_tx_starve, temp);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 
 	return count;
 }
@@ -274,7 +274,7 @@ static ssize_t gfar_set_fifo_starve_off(
 	if (num > GFAR_MAX_FIFO_STARVE_OFF)
 		return count;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->txlock, flags);
 
 	priv->fifo_starve_off = num;
 
@@ -283,7 +283,7 @@ static ssize_t gfar_set_fifo_starve_off(
 	temp |= num;
 	gfar_write(&priv->regs->fifo_tx_starve_shutoff, temp);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->txlock, flags);
 
 	return count;
 }
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 67b0eab..227df98 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -51,7 +51,7 @@ #endif
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"1.1"
+#define DRV_VERSION		"1.2"
 #define PFX			DRV_NAME " "
 
 /*
@@ -925,8 +925,7 @@ static inline struct sk_buff *sky2_alloc
 	skb = alloc_skb(size + RX_SKB_ALIGN, gfp_mask);
 	if (likely(skb)) {
 		unsigned long p	= (unsigned long) skb->data;
-		skb_reserve(skb,
-			((p + RX_SKB_ALIGN - 1) & ~(RX_SKB_ALIGN - 1)) - p);
+		skb_reserve(skb, ALIGN(p, RX_SKB_ALIGN) - p);
 	}
 
 	return skb;
@@ -1686,13 +1685,12 @@ static void sky2_tx_timeout(struct net_d
 }
 
 
-#define roundup(x, y)   ((((x)+((y)-1))/(y))*(y))
 /* Want receive buffer size to be multiple of 64 bits
  * and incl room for vlan and truncation
  */
 static inline unsigned sky2_buf_size(int mtu)
 {
-	return roundup(mtu + ETH_HLEN + VLAN_HLEN, 8) + 8;
+	return ALIGN(mtu + ETH_HLEN + VLAN_HLEN, 8) + 8;
 }
 
 static int sky2_change_mtu(struct net_device *dev, int new_mtu)
@@ -2086,6 +2084,20 @@ static void sky2_descriptor_error(struct
 	}
 }
 
+/* If idle then force a fake soft NAPI poll once a second
+ * to work around cases where sharing an edge triggered interrupt.
+ */
+static void sky2_idle(unsigned long arg)
+{
+	struct net_device *dev = (struct net_device *) arg;
+
+	local_irq_disable();
+	if (__netif_rx_schedule_prep(dev))
+		__netif_rx_schedule(dev);
+	local_irq_enable();
+}
+
+
 static int sky2_poll(struct net_device *dev0, int *budget)
 {
 	struct sky2_hw *hw = ((struct sky2_port *) netdev_priv(dev0))->hw;
@@ -2093,6 +2105,7 @@ static int sky2_poll(struct net_device *
 	int work_done = 0;
 	u32 status = sky2_read32(hw, B0_Y2_SP_EISR);
 
+ restart_poll:
 	if (unlikely(status & ~Y2_IS_STAT_BMU)) {
 		if (status & Y2_IS_HW_ERR)
 			sky2_hw_intr(hw);
@@ -2123,7 +2136,7 @@ static int sky2_poll(struct net_device *
 	}
 
 	if (status & Y2_IS_STAT_BMU) {
-		work_done = sky2_status_intr(hw, work_limit);
+		work_done += sky2_status_intr(hw, work_limit - work_done);
 		*budget -= work_done;
 		dev0->quota -= work_done;
 
@@ -2133,9 +2146,24 @@ static int sky2_poll(struct net_device *
 		sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
 	}
 
-	netif_rx_complete(dev0);
+	mod_timer(&hw->idle_timer, jiffies + HZ);
+
+	local_irq_disable();
+	__netif_rx_complete(dev0);
 
 	status = sky2_read32(hw, B0_Y2_SP_LISR);
+
+	if (unlikely(status)) {
+		/* More work pending, try and keep going */
+		if (__netif_rx_schedule_prep(dev0)) {
+			__netif_rx_reschedule(dev0, work_done);
+			status = sky2_read32(hw, B0_Y2_SP_EISR);
+			local_irq_enable();
+			goto restart_poll;
+		}
+	}
+
+	local_irq_enable();
 	return 0;
 }
 
@@ -2153,8 +2181,6 @@ static irqreturn_t sky2_intr(int irq, vo
 	prefetch(&hw->st_le[hw->st_idx]);
 	if (likely(__netif_rx_schedule_prep(dev0)))
 		__netif_rx_schedule(dev0);
-	else
-		printk(KERN_DEBUG PFX "irq race detected\n");
 
 	return IRQ_HANDLED;
 }
@@ -2193,7 +2219,7 @@ static inline u32 sky2_clk2us(const stru
 }
 
 
-static int sky2_reset(struct sky2_hw *hw)
+static int __devinit sky2_reset(struct sky2_hw *hw)
 {
 	u16 status;
 	u8 t8, pmd_type;
@@ -3276,6 +3302,8 @@ #endif
 
 	sky2_write32(hw, B0_IMSK, Y2_IS_BASE);
 
+	setup_timer(&hw->idle_timer, sky2_idle, (unsigned long) dev);
+
 	pci_set_drvdata(pdev, hw);
 
 	return 0;
@@ -3311,13 +3339,15 @@ static void __devexit sky2_remove(struct
 	if (!hw)
 		return;
 
+	del_timer_sync(&hw->idle_timer);
+
+	sky2_write32(hw, B0_IMSK, 0);
 	dev0 = hw->dev[0];
 	dev1 = hw->dev[1];
 	if (dev1)
 		unregister_netdev(dev1);
 	unregister_netdev(dev0);
 
-	sky2_write32(hw, B0_IMSK, 0);
 	sky2_set_power_state(hw, PCI_D3hot);
 	sky2_write16(hw, B0_Y2LED, LED_STAT_OFF);
 	sky2_write8(hw, B0_CTST, CS_RST_SET);
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 89dd18c..b026f56 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1880,6 +1880,8 @@ struct sky2_hw {
 	struct sky2_status_le *st_le;
 	u32		     st_idx;
 	dma_addr_t   	     st_dma;
+
+	struct timer_list    idle_timer;
 	int		     msi_detected;
 	wait_queue_head_t    msi_wait;
 };
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_dma.h b/drivers/net/wireless/bcm43xx/bcm43xx_dma.h
index 2d520e4..b7d7763 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_dma.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_dma.h
@@ -213,6 +213,14 @@ static inline
 void bcm43xx_dma_rx(struct bcm43xx_dmaring *ring)
 {
 }
+static inline
+void bcm43xx_dma_tx_suspend(struct bcm43xx_dmaring *ring)
+{
+}
+static inline
+void bcm43xx_dma_tx_resume(struct bcm43xx_dmaring *ring)
+{
+}
 
 #endif /* CONFIG_BCM43XX_DMA */
 #endif /* BCM43xx_DMA_H_ */
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_pio.c b/drivers/net/wireless/bcm43xx/bcm43xx_pio.c
index c59ddd4..0aa1bd2 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_pio.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_pio.c
@@ -27,6 +27,7 @@ #include "bcm43xx.h"
 #include "bcm43xx_pio.h"
 #include "bcm43xx_main.h"
 #include "bcm43xx_xmit.h"
+#include "bcm43xx_power.h"
 
 #include <linux/delay.h>
 
@@ -44,10 +45,10 @@ static void tx_octet(struct bcm43xx_pioq
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXDATA,
 				  octet);
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXCTL,
-				  BCM43xx_PIO_TXCTL_WRITEHI);
+				  BCM43xx_PIO_TXCTL_WRITELO);
 	} else {
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXCTL,
-				  BCM43xx_PIO_TXCTL_WRITEHI);
+				  BCM43xx_PIO_TXCTL_WRITELO);
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXDATA,
 				  octet);
 	}
@@ -103,7 +104,7 @@ static void tx_complete(struct bcm43xx_p
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXDATA,
 				  skb->data[skb->len - 1]);
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXCTL,
-				  BCM43xx_PIO_TXCTL_WRITEHI |
+				  BCM43xx_PIO_TXCTL_WRITELO |
 				  BCM43xx_PIO_TXCTL_COMPLETE);
 	} else {
 		bcm43xx_pio_write(queue, BCM43xx_PIO_TXCTL,
@@ -112,9 +113,10 @@ static void tx_complete(struct bcm43xx_p
 }
 
 static u16 generate_cookie(struct bcm43xx_pioqueue *queue,
-			   int packetindex)
+			   struct bcm43xx_pio_txpacket *packet)
 {
 	u16 cookie = 0x0000;
+	int packetindex;
 
 	/* We use the upper 4 bits for the PIO
 	 * controller ID and the lower 12 bits
@@ -135,6 +137,7 @@ static u16 generate_cookie(struct bcm43x
 	default:
 		assert(0);
 	}
+	packetindex = pio_txpacket_getindex(packet);
 	assert(((u16)packetindex & 0xF000) == 0x0000);
 	cookie |= (u16)packetindex;
 
@@ -184,7 +187,7 @@ static void pio_tx_write_fragment(struct
 	bcm43xx_generate_txhdr(queue->bcm,
 			       &txhdr, skb->data, skb->len,
 			       (packet->xmitted_frags == 0),
-			       generate_cookie(queue, pio_txpacket_getindex(packet)));
+			       generate_cookie(queue, packet));
 
 	tx_start(queue);
 	octets = skb->len + sizeof(txhdr);
@@ -241,7 +244,7 @@ static int pio_tx_packet(struct bcm43xx_
 		queue->tx_devq_packets++;
 		queue->tx_devq_used += octets;
 
-		assert(packet->xmitted_frags <= packet->txb->nr_frags);
+		assert(packet->xmitted_frags < packet->txb->nr_frags);
 		packet->xmitted_frags++;
 		packet->xmitted_octets += octets;
 	}
@@ -257,8 +260,14 @@ static void tx_tasklet(unsigned long d)
 	unsigned long flags;
 	struct bcm43xx_pio_txpacket *packet, *tmp_packet;
 	int err;
+	u16 txctl;
 
 	bcm43xx_lock_mmio(bcm, flags);
+
+	txctl = bcm43xx_pio_read(queue, BCM43xx_PIO_TXCTL);
+	if (txctl & BCM43xx_PIO_TXCTL_SUSPEND)
+		goto out_unlock;
+
 	list_for_each_entry_safe(packet, tmp_packet, &queue->txqueue, list) {
 		assert(packet->xmitted_frags < packet->txb->nr_frags);
 		if (packet->xmitted_frags == 0) {
@@ -288,6 +297,7 @@ static void tx_tasklet(unsigned long d)
 	next_packet:
 		continue;
 	}
+out_unlock:
 	bcm43xx_unlock_mmio(bcm, flags);
 }
 
@@ -330,12 +340,19 @@ struct bcm43xx_pioqueue * bcm43xx_setup_
 		     (unsigned long)queue);
 
 	value = bcm43xx_read32(bcm, BCM43xx_MMIO_STATUS_BITFIELD);
-	value |= BCM43xx_SBF_XFER_REG_BYTESWAP;
+	value &= ~BCM43xx_SBF_XFER_REG_BYTESWAP;
 	bcm43xx_write32(bcm, BCM43xx_MMIO_STATUS_BITFIELD, value);
 
 	qsize = bcm43xx_read16(bcm, queue->mmio_base + BCM43xx_PIO_TXQBUFSIZE);
+	if (qsize == 0) {
+		printk(KERN_ERR PFX "ERROR: This card does not support PIO "
+				    "operation mode. Please use DMA mode "
+				    "(module parameter pio=0).\n");
+		goto err_freequeue;
+	}
 	if (qsize <= BCM43xx_PIO_TXQADJUST) {
-		printk(KERN_ERR PFX "PIO tx device-queue too small (%u)\n", qsize);
+		printk(KERN_ERR PFX "PIO tx device-queue too small (%u)\n",
+		       qsize);
 		goto err_freequeue;
 	}
 	qsize -= BCM43xx_PIO_TXQADJUST;
@@ -444,15 +461,10 @@ int bcm43xx_pio_tx(struct bcm43xx_privat
 {
 	struct bcm43xx_pioqueue *queue = bcm43xx_current_pio(bcm)->queue1;
 	struct bcm43xx_pio_txpacket *packet;
-	u16 tmp;
 
 	assert(!queue->tx_suspended);
 	assert(!list_empty(&queue->txfree));
 
-	tmp = bcm43xx_pio_read(queue, BCM43xx_PIO_TXCTL);
-	if (tmp & BCM43xx_PIO_TXCTL_SUSPEND)
-		return -EBUSY;
-
 	packet = list_entry(queue->txfree.next, struct bcm43xx_pio_txpacket, list);
 	packet->txb = txb;
 	packet->xmitted_frags = 0;
@@ -462,7 +474,7 @@ int bcm43xx_pio_tx(struct bcm43xx_privat
 	assert(queue->nr_txfree < BCM43xx_PIO_MAXTXPACKETS);
 
 	/* Suspend TX, if we are out of packets in the "free" queue. */
-	if (unlikely(list_empty(&queue->txfree))) {
+	if (list_empty(&queue->txfree)) {
 		netif_stop_queue(queue->bcm->net_dev);
 		queue->tx_suspended = 1;
 	}
@@ -480,15 +492,15 @@ void bcm43xx_pio_handle_xmitstatus(struc
 
 	queue = parse_cookie(bcm, status->cookie, &packet);
 	assert(queue);
-//TODO
-if (!queue)
-return;
+
 	free_txpacket(packet, 1);
-	if (unlikely(queue->tx_suspended)) {
+	if (queue->tx_suspended) {
 		queue->tx_suspended = 0;
 		netif_wake_queue(queue->bcm->net_dev);
 	}
-	/* If there are packets on the txqueue, poke the tasklet. */
+	/* If there are packets on the txqueue, poke the tasklet
+	 * to transmit them.
+	 */
 	if (!list_empty(&queue->txqueue))
 		tasklet_schedule(&queue->txtask);
 }
@@ -519,12 +531,9 @@ void bcm43xx_pio_rx(struct bcm43xx_pioqu
 	int i, preamble_readwords;
 	struct sk_buff *skb;
 
-return;
 	tmp = bcm43xx_pio_read(queue, BCM43xx_PIO_RXCTL);
-	if (!(tmp & BCM43xx_PIO_RXCTL_DATAAVAILABLE)) {
-		dprintkl(KERN_ERR PFX "PIO RX: No data available\n");//TODO: remove this printk.
+	if (!(tmp & BCM43xx_PIO_RXCTL_DATAAVAILABLE))
 		return;
-	}
 	bcm43xx_pio_write(queue, BCM43xx_PIO_RXCTL,
 			  BCM43xx_PIO_RXCTL_DATAAVAILABLE);
 
@@ -538,8 +547,7 @@ return;
 	return;
 data_ready:
 
-//FIXME: endianess in this function.
-	len = le16_to_cpu(bcm43xx_pio_read(queue, BCM43xx_PIO_RXDATA));
+	len = bcm43xx_pio_read(queue, BCM43xx_PIO_RXDATA);
 	if (unlikely(len > 0x700)) {
 		pio_rx_error(queue, 0, "len > 0x700");
 		return;
@@ -555,7 +563,7 @@ data_ready:
 		preamble_readwords = 18 / sizeof(u16);
 	for (i = 0; i < preamble_readwords; i++) {
 		tmp = bcm43xx_pio_read(queue, BCM43xx_PIO_RXDATA);
-		preamble[i + 1] = cpu_to_be16(tmp);//FIXME?
+		preamble[i + 1] = cpu_to_le16(tmp);
 	}
 	rxhdr = (struct bcm43xx_rxhdr *)preamble;
 	rxflags2 = le16_to_cpu(rxhdr->flags2);
@@ -591,16 +599,40 @@ data_ready:
 	}
 	skb_put(skb, len);
 	for (i = 0; i < len - 1; i += 2) {
-		tmp = cpu_to_be16(bcm43xx_pio_read(queue, BCM43xx_PIO_RXDATA));
-		*((u16 *)(skb->data + i)) = tmp;
+		tmp = bcm43xx_pio_read(queue, BCM43xx_PIO_RXDATA);
+		*((u16 *)(skb->data + i)) = cpu_to_le16(tmp);
 	}
 	if (len % 2) {
 		tmp = bcm43xx_pio_read(queue, BCM43xx_PIO_RXDATA);
 		skb->data[len - 1] = (tmp & 0x00FF);
+/* The specs say the following is required, but
+ * it is wrong and corrupts the PLCP. If we don't do
+ * this, the PLCP seems to be correct. So ifdef it out for now.
+ */
+#if 0
 		if (rxflags2 & BCM43xx_RXHDR_FLAGS2_TYPE2FRAME)
-			skb->data[0x20] = (tmp & 0xFF00) >> 8;
+			skb->data[2] = (tmp & 0xFF00) >> 8;
 		else
-			skb->data[0x1E] = (tmp & 0xFF00) >> 8;
+			skb->data[0] = (tmp & 0xFF00) >> 8;
+#endif
 	}
+	skb_trim(skb, len - IEEE80211_FCS_LEN);
 	bcm43xx_rx(queue->bcm, skb, rxhdr);
 }
+
+void bcm43xx_pio_tx_suspend(struct bcm43xx_pioqueue *queue)
+{
+	bcm43xx_power_saving_ctl_bits(queue->bcm, -1, 1);
+	bcm43xx_pio_write(queue, BCM43xx_PIO_TXCTL,
+			  bcm43xx_pio_read(queue, BCM43xx_PIO_TXCTL)
+			  | BCM43xx_PIO_TXCTL_SUSPEND);
+}
+
+void bcm43xx_pio_tx_resume(struct bcm43xx_pioqueue *queue)
+{
+	bcm43xx_pio_write(queue, BCM43xx_PIO_TXCTL,
+			  bcm43xx_pio_read(queue, BCM43xx_PIO_TXCTL)
+			  & ~BCM43xx_PIO_TXCTL_SUSPEND);
+	bcm43xx_power_saving_ctl_bits(queue->bcm, -1, -1);
+	tasklet_schedule(&queue->txtask);
+}
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_pio.h b/drivers/net/wireless/bcm43xx/bcm43xx_pio.h
index 970627b..dfc7820 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_pio.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_pio.h
@@ -14,8 +14,8 @@ #define BCM43xx_PIO_TXQBUFSIZE		0x04
 #define BCM43xx_PIO_RXCTL		0x08
 #define BCM43xx_PIO_RXDATA		0x0A
 
-#define BCM43xx_PIO_TXCTL_WRITEHI	(1 << 0)
-#define BCM43xx_PIO_TXCTL_WRITELO	(1 << 1)
+#define BCM43xx_PIO_TXCTL_WRITELO	(1 << 0)
+#define BCM43xx_PIO_TXCTL_WRITEHI	(1 << 1)
 #define BCM43xx_PIO_TXCTL_COMPLETE	(1 << 2)
 #define BCM43xx_PIO_TXCTL_INIT		(1 << 3)
 #define BCM43xx_PIO_TXCTL_SUSPEND	(1 << 7)
@@ -95,6 +95,7 @@ void bcm43xx_pio_write(struct bcm43xx_pi
 		       u16 offset, u16 value)
 {
 	bcm43xx_write16(queue->bcm, queue->mmio_base + offset, value);
+	mmiowb();
 }
 
 
@@ -107,6 +108,9 @@ void bcm43xx_pio_handle_xmitstatus(struc
 				   struct bcm43xx_xmitstatus *status);
 void bcm43xx_pio_rx(struct bcm43xx_pioqueue *queue);
 
+void bcm43xx_pio_tx_suspend(struct bcm43xx_pioqueue *queue);
+void bcm43xx_pio_tx_resume(struct bcm43xx_pioqueue *queue);
+
 #else /* CONFIG_BCM43XX_PIO */
 
 static inline
@@ -133,6 +137,14 @@ static inline
 void bcm43xx_pio_rx(struct bcm43xx_pioqueue *queue)
 {
 }
+static inline
+void bcm43xx_pio_tx_suspend(struct bcm43xx_pioqueue *queue)
+{
+}
+static inline
+void bcm43xx_pio_tx_resume(struct bcm43xx_pioqueue *queue)
+{
+}
 
 #endif /* CONFIG_BCM43XX_PIO */
 #endif /* BCM43xx_PIO_H_ */
diff --git a/drivers/net/wireless/hostap/hostap_ioctl.c b/drivers/net/wireless/hostap/hostap_ioctl.c
index 8b37e82..8399de5 100644
--- a/drivers/net/wireless/hostap/hostap_ioctl.c
+++ b/drivers/net/wireless/hostap/hostap_ioctl.c
@@ -1860,7 +1860,7 @@ static char * __prism2_translate_scan(lo
 	memset(&iwe, 0, sizeof(iwe));
 	iwe.cmd = SIOCGIWFREQ;
 	if (scan) {
-		chan = scan->chid;
+		chan = le16_to_cpu(scan->chid);
 	} else if (bss) {
 		chan = bss->chan;
 	} else {
@@ -1868,7 +1868,7 @@ static char * __prism2_translate_scan(lo
 	}
 
 	if (chan > 0) {
-		iwe.u.freq.m = freq_list[le16_to_cpu(chan - 1)] * 100000;
+		iwe.u.freq.m = freq_list[chan - 1] * 100000;
 		iwe.u.freq.e = 1;
 		current_ev = iwe_stream_add_event(current_ev, end_buf, &iwe,
 						  IW_EV_FREQ_LEN);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 40ccf8c..01db7b8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -829,19 +829,21 @@ static inline void netif_rx_schedule(str
 		__netif_rx_schedule(dev);
 }
 
-/* Try to reschedule poll. Called by dev->poll() after netif_rx_complete().
- * Do not inline this?
- */
+
+static inline void  __netif_rx_reschedule(struct net_device *dev, int undo)
+{
+	dev->quota += undo;
+	list_add_tail(&dev->poll_list, &__get_cpu_var(softnet_data).poll_list);
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+}
+
+/* Try to reschedule poll. Called by dev->poll() after netif_rx_complete(). */
 static inline int netif_rx_reschedule(struct net_device *dev, int undo)
 {
 	if (netif_rx_schedule_prep(dev)) {
 		unsigned long flags;
-
-		dev->quota += undo;
-
 		local_irq_save(flags);
-		list_add_tail(&dev->poll_list, &__get_cpu_var(softnet_data).poll_list);
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		__netif_rx_reschedule(dev, undo);
 		local_irq_restore(flags);
 		return 1;
 	}
diff --git a/include/net/ieee80211softmac.h b/include/net/ieee80211softmac.h
index 6b3693f..b1ebfba 100644
--- a/include/net/ieee80211softmac.h
+++ b/include/net/ieee80211softmac.h
@@ -96,10 +96,13 @@ struct ieee80211softmac_assoc_info {
 	 *
 	 * bssvalid is true if we found a matching network
 	 * and saved it's BSSID into the bssid above.
+	 *
+	 * bssfixed is used for SIOCSIWAP.
 	 */
 	u8 static_essid:1,
 	   associating:1,
-	   bssvalid:1;
+	   bssvalid:1,
+	   bssfixed:1;
 
 	/* Scan retries remaining */
 	int scan_retry;
diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index 4498023..fb79ce7 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -144,6 +144,12 @@ network_matches_request(struct ieee80211
 	if (!we_support_all_basic_rates(mac, net->rates_ex, net->rates_ex_len))
 		return 0;
 
+	/* assume that users know what they're doing ...
+	 * (note we don't let them select a net we're incompatible with) */
+	if (mac->associnfo.bssfixed) {
+		return !memcmp(mac->associnfo.bssid, net->bssid, ETH_ALEN);
+	}
+
 	/* if 'ANY' network requested, take any that doesn't have privacy enabled */
 	if (mac->associnfo.req_essid.len == 0 
 	    && !(net->capability & WLAN_CAPABILITY_PRIVACY))
@@ -176,7 +182,7 @@ ieee80211softmac_assoc_work(void *d)
 		ieee80211softmac_disassoc(mac, WLAN_REASON_DISASSOC_STA_HAS_LEFT);
 
 	/* try to find the requested network in our list, if we found one already */
-	if (mac->associnfo.bssvalid)
+	if (mac->associnfo.bssvalid || mac->associnfo.bssfixed)
 		found = ieee80211softmac_get_network_by_bssid(mac, mac->associnfo.bssid);	
 	
 	/* Search the ieee80211 networks for this network if we didn't find it by bssid,
@@ -241,19 +247,25 @@ ieee80211softmac_assoc_work(void *d)
 			if (ieee80211softmac_start_scan(mac))
 				dprintk(KERN_INFO PFX "Associate: failed to initiate scan. Is device up?\n");
 			return;
-		}
-		else {
+		} else {
 			spin_lock_irqsave(&mac->lock, flags);
 			mac->associnfo.associating = 0;
 			mac->associated = 0;
 			spin_unlock_irqrestore(&mac->lock, flags);
 
 			dprintk(KERN_INFO PFX "Unable to find matching network after scan!\n");
+			/* reset the retry counter for the next user request since we
+			 * break out and don't reschedule ourselves after this point. */
+			mac->associnfo.scan_retry = IEEE80211SOFTMAC_ASSOC_SCAN_RETRY_LIMIT;
 			ieee80211softmac_call_events(mac, IEEE80211SOFTMAC_EVENT_ASSOCIATE_NET_NOT_FOUND, NULL);
 			return;
 		}
 	}
-	
+
+	/* reset the retry counter for the next user request since we
+	 * now found a net and will try to associate to it, but not
+	 * schedule this function again. */
+	mac->associnfo.scan_retry = IEEE80211SOFTMAC_ASSOC_SCAN_RETRY_LIMIT;
 	mac->associnfo.bssvalid = 1;
 	memcpy(mac->associnfo.bssid, found->bssid, ETH_ALEN);
 	/* copy the ESSID for displaying it */
diff --git a/net/ieee80211/softmac/ieee80211softmac_module.c b/net/ieee80211/softmac/ieee80211softmac_module.c
index 60f06a3..be83bdc 100644
--- a/net/ieee80211/softmac/ieee80211softmac_module.c
+++ b/net/ieee80211/softmac/ieee80211softmac_module.c
@@ -45,6 +45,8 @@ struct net_device *alloc_ieee80211softma
 	softmac->ieee->handle_disassoc = ieee80211softmac_handle_disassoc;
 	softmac->scaninfo = NULL;
 
+	softmac->associnfo.scan_retry = IEEE80211SOFTMAC_ASSOC_SCAN_RETRY_LIMIT;
+
 	/* TODO: initialise all the other callbacks in the ieee struct
 	 *	 (once they're written)
 	 */
diff --git a/net/ieee80211/softmac/ieee80211softmac_wx.c b/net/ieee80211/softmac/ieee80211softmac_wx.c
index 00f0d4f..27edb2b 100644
--- a/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ b/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -27,7 +27,8 @@
 #include "ieee80211softmac_priv.h"
 
 #include <net/iw_handler.h>
-
+/* for is_broadcast_ether_addr and is_zero_ether_addr */
+#include <linux/etherdevice.h>
 
 int
 ieee80211softmac_wx_trigger_scan(struct net_device *net_dev,
@@ -83,7 +84,6 @@ ieee80211softmac_wx_set_essid(struct net
 			sm->associnfo.static_essid = 1;
 		}
 	}
-	sm->associnfo.scan_retry = IEEE80211SOFTMAC_ASSOC_SCAN_RETRY_LIMIT;
 
 	/* set our requested ESSID length.
 	 * If applicable, we have already copied the data in */
@@ -310,8 +310,6 @@ ieee80211softmac_wx_set_wap(struct net_d
 			    char *extra)
 {
 	struct ieee80211softmac_device *mac = ieee80211_priv(net_dev);
-	static const unsigned char any[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	static const unsigned char off[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 	unsigned long flags;
 
 	/* sanity check */
@@ -320,10 +318,17 @@ ieee80211softmac_wx_set_wap(struct net_d
 	}
 
 	spin_lock_irqsave(&mac->lock, flags);
-	if (!memcmp(any, data->ap_addr.sa_data, ETH_ALEN) ||
-	    !memcmp(off, data->ap_addr.sa_data, ETH_ALEN)) {
-		schedule_work(&mac->associnfo.work);
-		goto out;
+	if (is_broadcast_ether_addr(data->ap_addr.sa_data)) {
+		/* the bssid we have is not to be fixed any longer,
+		 * and we should reassociate to the best AP. */
+		mac->associnfo.bssfixed = 0;
+		/* force reassociation */
+		mac->associnfo.bssvalid = 0;
+		if (mac->associated)
+			schedule_work(&mac->associnfo.work);
+	} else if (is_zero_ether_addr(data->ap_addr.sa_data)) {
+		/* the bssid we have is no longer fixed */
+		mac->associnfo.bssfixed = 0;
         } else {
 		if (!memcmp(mac->associnfo.bssid, data->ap_addr.sa_data, ETH_ALEN)) {
 			if (mac->associnfo.associating || mac->associated) {
@@ -333,12 +338,14 @@ ieee80211softmac_wx_set_wap(struct net_d
 		} else {
 			/* copy new value in data->ap_addr.sa_data to bssid */
 			memcpy(mac->associnfo.bssid, data->ap_addr.sa_data, ETH_ALEN);
-		}	
+		}
+		/* tell the other code that this bssid should be used no matter what */
+		mac->associnfo.bssfixed = 1;
 		/* queue associate if new bssid or (old one again and not associated) */
 		schedule_work(&mac->associnfo.work);
         }
 
-out:
+ out:
 	spin_unlock_irqrestore(&mac->lock, flags);
 	return 0;
 }
