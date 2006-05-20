Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWETE27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWETE27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWETE27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:28:59 -0400
Received: from havoc.gtf.org ([69.61.125.42]:6590 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932482AbWETE26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:28:58 -0400
Date: Sat, 20 May 2006 00:28:56 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20060520042856.GA7218@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/forcedeth.c                     |  312 +++++++---------------------
 drivers/net/pcmcia/axnet_cs.c               |   13 -
 drivers/net/skge.c                          |    8 
 drivers/net/sky2.c                          |   54 ++--
 drivers/net/sky2.h                          |    2 
 drivers/net/tulip/winbond-840.c             |    4 
 drivers/net/via-rhine.c                     |   34 ---
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |    6 
 8 files changed, 131 insertions(+), 302 deletions(-)

Andrew Morton:
      revert "forcedeth: fix multi irq issues"

David Woodhouse:
      bcm43xx: associate on 'ifconfig up'

Erling A. Jacobsen:
      winbond-840-remove-badness-in-pci_map_single

John W. Linville:
      via-rhine: revert "change mdelay to msleep and remove from ISR path"

Komuro:
      network: axnet_cs: bug fix multicast code (support older ax88190 chipset)

Stephen Hemminger:
      sky2: allow dual port usage
      Subjec: sky2, skge: correct PCI id for DGE-560T
      sky2: more fixes for Yukon Ultra
      sky2: force NAPI repoll if busy
      sky2 version 1.4
      skge: bad checksums on big-endian platforms
      skge: don't allow transmit ring to be too small

diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index f7235c9..7e078b4 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -106,7 +106,6 @@
  *	0.51: 20 Jan 2006: Add 64bit consistent memory allocation for rings.
  *	0.52: 20 Jan 2006: Add MSI/MSIX support.
  *	0.53: 19 Mar 2006: Fix init from low power mode and add hw reset.
- *	0.54: 21 Mar 2006: Fix spin locks for multi irqs and cleanup.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -118,7 +117,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.54"
+#define FORCEDETH_VERSION		"0.53"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -711,72 +710,6 @@ static void setup_hw_rings(struct net_de
 	}
 }
 
-static int using_multi_irqs(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-
-	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
-	    ((np->msi_flags & NV_MSI_X_ENABLED) &&
-	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1)))
-		return 0;
-	else
-		return 1;
-}
-
-static void nv_enable_irq(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-
-	if (!using_multi_irqs(dev)) {
-		if (np->msi_flags & NV_MSI_X_ENABLED)
-			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
-		else
-			enable_irq(dev->irq);
-	} else {
-		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
-		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
-		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
-	}
-}
-
-static void nv_disable_irq(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-
-	if (!using_multi_irqs(dev)) {
-		if (np->msi_flags & NV_MSI_X_ENABLED)
-			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
-		else
-			disable_irq(dev->irq);
-	} else {
-		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
-		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
-		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
-	}
-}
-
-/* In MSIX mode, a write to irqmask behaves as XOR */
-static void nv_enable_hw_interrupts(struct net_device *dev, u32 mask)
-{
-	u8 __iomem *base = get_hwbase(dev);
-
-	writel(mask, base + NvRegIrqMask);
-}
-
-static void nv_disable_hw_interrupts(struct net_device *dev, u32 mask)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 __iomem *base = get_hwbase(dev);
-
-	if (np->msi_flags & NV_MSI_X_ENABLED) {
-		writel(mask, base + NvRegIrqMask);
-	} else {
-		if (np->msi_flags & NV_MSI_ENABLED)
-			writel(0, base + NvRegMSIIrqMask);
-		writel(0, base + NvRegIrqMask);
-	}
-}
-
 #define MII_READ	(-1)
 /* mii_rw: read/write a register on the PHY.
  *
@@ -1086,25 +1019,24 @@ static void nv_do_rx_refill(unsigned lon
 	struct net_device *dev = (struct net_device *) data;
 	struct fe_priv *np = netdev_priv(dev);
 
-	if (!using_multi_irqs(dev)) {
-		if (np->msi_flags & NV_MSI_X_ENABLED)
-			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
-		else
-			disable_irq(dev->irq);
+
+	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+	    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
+		disable_irq(dev->irq);
 	} else {
 		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
 	}
 	if (nv_alloc_rx(dev)) {
-		spin_lock_irq(&np->lock);
+		spin_lock(&np->lock);
 		if (!np->in_shutdown)
 			mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-		spin_unlock_irq(&np->lock);
+		spin_unlock(&np->lock);
 	}
-	if (!using_multi_irqs(dev)) {
-		if (np->msi_flags & NV_MSI_X_ENABLED)
-			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
-		else
-			enable_irq(dev->irq);
+	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+	    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
+		enable_irq(dev->irq);
 	} else {
 		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
 	}
@@ -1736,7 +1668,15 @@ static int nv_change_mtu(struct net_devi
 		 * guessed, there is probably a simpler approach.
 		 * Changing the MTU is a rare event, it shouldn't matter.
 		 */
-		nv_disable_irq(dev);
+		if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+		    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+		     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
+			disable_irq(dev->irq);
+		} else {
+			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
+			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
+			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
+		}
 		spin_lock_bh(&dev->xmit_lock);
 		spin_lock(&np->lock);
 		/* stop engines */
@@ -1769,7 +1709,15 @@ static int nv_change_mtu(struct net_devi
 		nv_start_tx(dev);
 		spin_unlock(&np->lock);
 		spin_unlock_bh(&dev->xmit_lock);
-		nv_enable_irq(dev);
+		if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+		    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+		     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
+			enable_irq(dev->irq);
+		} else {
+			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
+			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
+			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
+		}
 	}
 	return 0;
 }
@@ -2160,16 +2108,16 @@ static irqreturn_t nv_nic_irq_tx(int foo
 		if (!(events & np->irqmask))
 			break;
 
-		spin_lock_irq(&np->lock);
+		spin_lock(&np->lock);
 		nv_tx_done(dev);
-		spin_unlock_irq(&np->lock);
+		spin_unlock(&np->lock);
 		
 		if (events & (NVREG_IRQ_TX_ERR)) {
 			dprintk(KERN_DEBUG "%s: received irq with events 0x%x. Probably TX fail.\n",
 						dev->name, events);
 		}
 		if (i > max_interrupt_work) {
-			spin_lock_irq(&np->lock);
+			spin_lock(&np->lock);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_TX_ALL, base + NvRegIrqMask);
 			pci_push(base);
@@ -2179,7 +2127,7 @@ static irqreturn_t nv_nic_irq_tx(int foo
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_tx.\n", dev->name, i);
-			spin_unlock_irq(&np->lock);
+			spin_unlock(&np->lock);
 			break;
 		}
 
@@ -2209,14 +2157,14 @@ static irqreturn_t nv_nic_irq_rx(int foo
 		
 		nv_rx_process(dev);
 		if (nv_alloc_rx(dev)) {
-			spin_lock_irq(&np->lock);
+			spin_lock(&np->lock);
 			if (!np->in_shutdown)
 				mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-			spin_unlock_irq(&np->lock);
+			spin_unlock(&np->lock);
 		}
 		
 		if (i > max_interrupt_work) {
-			spin_lock_irq(&np->lock);
+			spin_lock(&np->lock);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_RX_ALL, base + NvRegIrqMask);
 			pci_push(base);
@@ -2226,7 +2174,7 @@ static irqreturn_t nv_nic_irq_rx(int foo
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_rx.\n", dev->name, i);
-			spin_unlock_irq(&np->lock);
+			spin_unlock(&np->lock);
 			break;
 		}
 
@@ -2255,14 +2203,14 @@ static irqreturn_t nv_nic_irq_other(int 
 			break;
 		
 		if (events & NVREG_IRQ_LINK) {
-			spin_lock_irq(&np->lock);
+			spin_lock(&np->lock);
 			nv_link_irq(dev);
-			spin_unlock_irq(&np->lock);
+			spin_unlock(&np->lock);
 		}
 		if (np->need_linktimer && time_after(jiffies, np->link_timeout)) {
-			spin_lock_irq(&np->lock);
+			spin_lock(&np->lock);
 			nv_linkchange(dev);
-			spin_unlock_irq(&np->lock);
+			spin_unlock(&np->lock);
 			np->link_timeout = jiffies + LINK_TIMEOUT;
 		}
 		if (events & (NVREG_IRQ_UNKNOWN)) {
@@ -2270,7 +2218,7 @@ static irqreturn_t nv_nic_irq_other(int 
 						dev->name, events);
 		}
 		if (i > max_interrupt_work) {
-			spin_lock_irq(&np->lock);
+			spin_lock(&np->lock);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_OTHER, base + NvRegIrqMask);
 			pci_push(base);
@@ -2280,7 +2228,7 @@ static irqreturn_t nv_nic_irq_other(int 
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_other.\n", dev->name, i);
-			spin_unlock_irq(&np->lock);
+			spin_unlock(&np->lock);
 			break;
 		}
 
@@ -2303,11 +2251,10 @@ static void nv_do_nic_poll(unsigned long
 	 * nv_nic_irq because that may decide to do otherwise
 	 */
 
-	if (!using_multi_irqs(dev)) {
-		if (np->msi_flags & NV_MSI_X_ENABLED)
-			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
-		else
-			disable_irq(dev->irq);
+	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+	    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
+		disable_irq(dev->irq);
 		mask = np->irqmask;
 	} else {
 		if (np->nic_poll_irq & NVREG_IRQ_RX_ALL) {
@@ -2330,12 +2277,11 @@ static void nv_do_nic_poll(unsigned long
 	writel(mask, base + NvRegIrqMask);
 	pci_push(base);
 
-	if (!using_multi_irqs(dev)) {
+	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+	    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
 		nv_nic_irq((int) 0, (void *) data, (struct pt_regs *) NULL);
-		if (np->msi_flags & NV_MSI_X_ENABLED)
-			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
-		else
-			enable_irq(dev->irq);
+		enable_irq(dev->irq);
 	} else {
 		if (np->nic_poll_irq & NVREG_IRQ_RX_ALL) {
 			nv_nic_irq_rx((int) 0, (void *) data, (struct pt_regs *) NULL);
@@ -2682,113 +2628,6 @@ static void set_msix_vector_map(struct n
 	writel(readl(base + NvRegMSIXMap1) | msixmap, base + NvRegMSIXMap1);
 }
 
-static int nv_request_irq(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 __iomem *base = get_hwbase(dev);
-	int ret = 1;
-	int i;
-
-	if (np->msi_flags & NV_MSI_X_CAPABLE) {
-		for (i = 0; i < (np->msi_flags & NV_MSI_X_VECTORS_MASK); i++) {
-			np->msi_x_entry[i].entry = i;
-		}
-		if ((ret = pci_enable_msix(np->pci_dev, np->msi_x_entry, (np->msi_flags & NV_MSI_X_VECTORS_MASK))) == 0) {
-			np->msi_flags |= NV_MSI_X_ENABLED;
-			if (optimization_mode == NV_OPTIMIZATION_MODE_THROUGHPUT) {
-				/* Request irq for rx handling */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector, &nv_nic_irq_rx, SA_SHIRQ, dev->name, dev) != 0) {
-					printk(KERN_INFO "forcedeth: request_irq failed for rx %d\n", ret);
-					pci_disable_msix(np->pci_dev);
-					np->msi_flags &= ~NV_MSI_X_ENABLED;
-					goto out_err;
-				}
-				/* Request irq for tx handling */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector, &nv_nic_irq_tx, SA_SHIRQ, dev->name, dev) != 0) {
-					printk(KERN_INFO "forcedeth: request_irq failed for tx %d\n", ret);
-					pci_disable_msix(np->pci_dev);
-					np->msi_flags &= ~NV_MSI_X_ENABLED;
-					goto out_free_rx;
-				}
-				/* Request irq for link and timer handling */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector, &nv_nic_irq_other, SA_SHIRQ, dev->name, dev) != 0) {
-					printk(KERN_INFO "forcedeth: request_irq failed for link %d\n", ret);
-					pci_disable_msix(np->pci_dev);
-					np->msi_flags &= ~NV_MSI_X_ENABLED;
-					goto out_free_tx;
-				}
-				/* map interrupts to their respective vector */
-				writel(0, base + NvRegMSIXMap0);
-				writel(0, base + NvRegMSIXMap1);
-				set_msix_vector_map(dev, NV_MSI_X_VECTOR_RX, NVREG_IRQ_RX_ALL);
-				set_msix_vector_map(dev, NV_MSI_X_VECTOR_TX, NVREG_IRQ_TX_ALL);
-				set_msix_vector_map(dev, NV_MSI_X_VECTOR_OTHER, NVREG_IRQ_OTHER);
-			} else {
-				/* Request irq for all interrupts */
-				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) {
-					printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
-					pci_disable_msix(np->pci_dev);
-					np->msi_flags &= ~NV_MSI_X_ENABLED;
-					goto out_err;
-				}
-
-				/* map interrupts to vector 0 */
-				writel(0, base + NvRegMSIXMap0);
-				writel(0, base + NvRegMSIXMap1);
-			}
-		}
-	}
-	if (ret != 0 && np->msi_flags & NV_MSI_CAPABLE) {
-		if ((ret = pci_enable_msi(np->pci_dev)) == 0) {
-			np->msi_flags |= NV_MSI_ENABLED;
-			if (request_irq(np->pci_dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) {
-				printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
-				pci_disable_msi(np->pci_dev);
-				np->msi_flags &= ~NV_MSI_ENABLED;
-				goto out_err;
-			}
-
-			/* map interrupts to vector 0 */
-			writel(0, base + NvRegMSIMap0);
-			writel(0, base + NvRegMSIMap1);
-			/* enable msi vector 0 */
-			writel(NVREG_MSI_VECTOR_0_ENABLED, base + NvRegMSIIrqMask);
-		}
-	}
-	if (ret != 0) {
-		if (request_irq(np->pci_dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0)
-			goto out_err;
-	}
-
-	return 0;
-out_free_tx:
-	free_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector, dev);
-out_free_rx:
-	free_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector, dev);
-out_err:
-	return 1;
-}
-
-static void nv_free_irq(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	int i;
-
-	if (np->msi_flags & NV_MSI_X_ENABLED) {
-		for (i = 0; i < (np->msi_flags & NV_MSI_X_VECTORS_MASK); i++) {
-			free_irq(np->msi_x_entry[i].vector, dev);
-		}
-		pci_disable_msix(np->pci_dev);
-		np->msi_flags &= ~NV_MSI_X_ENABLED;
-	} else {
-		free_irq(np->pci_dev->irq, dev);
-		if (np->msi_flags & NV_MSI_ENABLED) {
-			pci_disable_msi(np->pci_dev);
-			np->msi_flags &= ~NV_MSI_ENABLED;
-		}
-	}
-}
-
 static int nv_open(struct net_device *dev)
 {
 	struct fe_priv *np = netdev_priv(dev);
@@ -2881,16 +2720,12 @@ static int nv_open(struct net_device *de
 	udelay(10);
 	writel(readl(base + NvRegPowerState) | NVREG_POWERSTATE_VALID, base + NvRegPowerState);
 
-	nv_disable_hw_interrupts(dev, np->irqmask);
+	writel(0, base + NvRegIrqMask);
 	pci_push(base);
 	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 	pci_push(base);
 
-	if (nv_request_irq(dev)) {
-		goto out_drain;
-	}
-
 	if (np->msi_flags & NV_MSI_X_CAPABLE) {
 		for (i = 0; i < (np->msi_flags & NV_MSI_X_VECTORS_MASK); i++) {
 			np->msi_x_entry[i].entry = i;
@@ -2964,7 +2799,7 @@ static int nv_open(struct net_device *de
 	}
 
 	/* ask for interrupts */
-	nv_enable_hw_interrupts(dev, np->irqmask);
+	writel(np->irqmask, base + NvRegIrqMask);
 
 	spin_lock_irq(&np->lock);
 	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
@@ -3008,6 +2843,7 @@ static int nv_close(struct net_device *d
 {
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base;
+	int i;
 
 	spin_lock_irq(&np->lock);
 	np->in_shutdown = 1;
@@ -3025,13 +2861,31 @@ static int nv_close(struct net_device *d
 
 	/* disable interrupts on the nic or we will lock up */
 	base = get_hwbase(dev);
-	nv_disable_hw_interrupts(dev, np->irqmask);
+	if (np->msi_flags & NV_MSI_X_ENABLED) {
+		writel(np->irqmask, base + NvRegIrqMask);
+	} else {
+		if (np->msi_flags & NV_MSI_ENABLED)
+			writel(0, base + NvRegMSIIrqMask);
+		writel(0, base + NvRegIrqMask);
+	}
 	pci_push(base);
 	dprintk(KERN_INFO "%s: Irqmask is zero again\n", dev->name);
 
 	spin_unlock_irq(&np->lock);
 
-	nv_free_irq(dev);
+	if (np->msi_flags & NV_MSI_X_ENABLED) {
+		for (i = 0; i < (np->msi_flags & NV_MSI_X_VECTORS_MASK); i++) {
+			free_irq(np->msi_x_entry[i].vector, dev);
+		}
+		pci_disable_msix(np->pci_dev);
+		np->msi_flags &= ~NV_MSI_X_ENABLED;
+	} else {
+		free_irq(np->pci_dev->irq, dev);
+		if (np->msi_flags & NV_MSI_ENABLED) {
+			pci_disable_msi(np->pci_dev);
+			np->msi_flags &= ~NV_MSI_ENABLED;
+		}
+	}
 
 	drain_ring(dev);
 
@@ -3120,18 +2974,20 @@ static int __devinit nv_probe(struct pci
 	if (id->driver_data & DEV_HAS_HIGH_DMA) {
 		/* packet format 3: supports 40-bit addressing */
 		np->desc_ver = DESC_VER_3;
-		np->txrxctl_bits = NVREG_TXRXCTL_DESC_3;
 		if (pci_set_dma_mask(pci_dev, DMA_39BIT_MASK)) {
 			printk(KERN_INFO "forcedeth: 64-bit DMA failed, using 32-bit addressing for device %s.\n",
 					pci_name(pci_dev));
 		} else {
-			dev->features |= NETIF_F_HIGHDMA;
-			printk(KERN_INFO "forcedeth: using HIGHDMA\n");
-		}
-		if (pci_set_consistent_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
-			printk(KERN_INFO "forcedeth: 64-bit DMA (consistent) failed for device %s.\n",
-			       pci_name(pci_dev));
+			if (pci_set_consistent_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
+				printk(KERN_INFO "forcedeth: 64-bit DMA (consistent) failed for device %s.\n",
+					pci_name(pci_dev));
+				goto out_relreg;
+			} else {
+				dev->features |= NETIF_F_HIGHDMA;
+				printk(KERN_INFO "forcedeth: using HIGHDMA\n");
+			}
 		}
+		np->txrxctl_bits = NVREG_TXRXCTL_DESC_3;
 	} else if (id->driver_data & DEV_HAS_LARGEDESC) {
 		/* packet format 2: supports jumbo frames */
 		np->desc_ver = DESC_VER_2;
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index 448a094..2ea66ac 100644
--- a/drivers/net/pcmcia/axnet_cs.c
+++ b/drivers/net/pcmcia/axnet_cs.c
@@ -1691,17 +1691,6 @@ static void do_set_multicast_list(struct
 		memset(ei_local->mcfilter, 0xFF, 8);
 	}
 
-	/* 
-	 * DP8390 manuals don't specify any magic sequence for altering
-	 * the multicast regs on an already running card. To be safe, we
-	 * ensure multicast mode is off prior to loading up the new hash
-	 * table. If this proves to be not enough, we can always resort
-	 * to stopping the NIC, loading the table and then restarting.
-	 */
-	 
-	if (netif_running(dev))
-		outb_p(E8390_RXCONFIG, e8390_base + EN0_RXCR);
-
 	outb_p(E8390_NODMA + E8390_PAGE1, e8390_base + E8390_CMD);
 	for(i = 0; i < 8; i++) 
 	{
@@ -1715,6 +1704,8 @@ static void do_set_multicast_list(struct
   		outb_p(E8390_RXCONFIG | 0x48, e8390_base + EN0_RXCR);
   	else
   		outb_p(E8390_RXCONFIG | 0x40, e8390_base + EN0_RXCR);
+
+	outb_p(E8390_NODMA+E8390_PAGE0+E8390_START, e8390_base+E8390_CMD);
 }
 
 /*
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index a70c2b0..5ca5a1b 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -78,8 +78,7 @@ static const struct pci_device_id skge_i
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_GE) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_YU) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, PCI_DEVICE_ID_DLINK_DGE510T), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },	/* DGE-530T */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) }, /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, PCI_DEVICE_ID_CNET_GIGACARD) },
@@ -402,7 +401,7 @@ static int skge_set_ring_param(struct ne
 	int err;
 
 	if (p->rx_pending == 0 || p->rx_pending > MAX_RX_RING_SIZE ||
-	    p->tx_pending == 0 || p->tx_pending > MAX_TX_RING_SIZE)
+	    p->tx_pending < MAX_SKB_FRAGS+1 || p->tx_pending > MAX_TX_RING_SIZE)
 		return -EINVAL;
 
 	skge->rx_ring.count = p->rx_pending;
@@ -2717,8 +2716,7 @@ static int skge_poll(struct net_device *
 		if (control & BMU_OWN)
 			break;
 
-		skb = skge_rx_get(skge, e, control, rd->status,
-				  le16_to_cpu(rd->csum2));
+		skb = skge_rx_get(skge, e, control, rd->status, rd->csum2);
 		if (likely(skb)) {
 			dev->last_rx = jiffies;
 			netif_receive_skb(skb);
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 62be6d9..60779eb 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -51,7 +51,7 @@ #endif
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"1.3"
+#define DRV_VERSION		"1.4"
 #define PFX			DRV_NAME " "
 
 /*
@@ -105,6 +105,7 @@ MODULE_PARM_DESC(idle_timeout, "Idle tim
 static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9000) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9E00) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00) },	/* DGE-560T */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4340) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4341) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4342) },
@@ -235,6 +236,7 @@ static int sky2_set_power_state(struct s
 		}
 
 		if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
+			sky2_write16(hw, B0_CTST, Y2_HW_WOL_ON);
 			sky2_pci_write32(hw, PCI_DEV_REG3, 0);
 			reg1 = sky2_pci_read32(hw, PCI_DEV_REG4);
 			reg1 &= P_ASPM_CONTROL_MSK;
@@ -306,7 +308,7 @@ static void sky2_phy_init(struct sky2_hw
 	u16 ctrl, ct1000, adv, pg, ledctrl, ledover;
 
 	if (sky2->autoneg == AUTONEG_ENABLE &&
-	    (hw->chip_id != CHIP_ID_YUKON_XL || hw->chip_id == CHIP_ID_YUKON_EC_U)) {
+	    !(hw->chip_id == CHIP_ID_YUKON_XL || hw->chip_id == CHIP_ID_YUKON_EC_U)) {
 		u16 ectrl = gm_phy_read(hw, port, PHY_MARV_EXT_CTRL);
 
 		ectrl &= ~(PHY_M_EC_M_DSC_MSK | PHY_M_EC_S_DSC_MSK |
@@ -1020,19 +1022,26 @@ static int sky2_up(struct net_device *de
 	struct sky2_hw *hw = sky2->hw;
 	unsigned port = sky2->port;
 	u32 ramsize, rxspace, imask;
-	int err;
+	int cap, err = -ENOMEM;
 	struct net_device *otherdev = hw->dev[sky2->port^1];
 
-	/* Block bringing up both ports at the same time on a dual port card.
-	 * There is an unfixed bug where receiver gets confused and picks up
-	 * packets out of order. Until this is fixed, prevent data corruption.
+	/*
+ 	 * On dual port PCI-X card, there is an problem where status
+	 * can be received out of order due to split transactions
 	 */
-	if (otherdev && netif_running(otherdev)) {
-		printk(KERN_INFO PFX "dual port support is disabled.\n");
-		return -EBUSY;
-	}
+	if (otherdev && netif_running(otherdev) &&
+ 	    (cap = pci_find_capability(hw->pdev, PCI_CAP_ID_PCIX))) {
+ 		struct sky2_port *osky2 = netdev_priv(otherdev);
+ 		u16 cmd;
+
+ 		cmd = sky2_pci_read16(hw, cap + PCI_X_CMD);
+ 		cmd &= ~PCI_X_CMD_MAX_SPLIT;
+ 		sky2_pci_write16(hw, cap + PCI_X_CMD, cmd);
+
+ 		sky2->rx_csum = 0;
+ 		osky2->rx_csum = 0;
+ 	}
 
-	err = -ENOMEM;
 	if (netif_msg_ifup(sky2))
 		printk(KERN_INFO PFX "%s: enabling interface\n", dev->name);
 
@@ -1910,6 +1919,12 @@ static inline void sky2_tx_done(struct n
 	}
 }
 
+/* Is status ring empty or is there more to do? */
+static inline int sky2_more_work(const struct sky2_hw *hw)
+{
+	return (hw->st_idx != sky2_read16(hw, STAT_PUT_IDX));
+}
+
 /* Process status response ring */
 static int sky2_status_intr(struct sky2_hw *hw, int to_do)
 {
@@ -2182,19 +2197,19 @@ static int sky2_poll(struct net_device *
 	if (status & Y2_IS_CHK_TXA2)
 		sky2_descriptor_error(hw, 1, "transmit", Y2_IS_CHK_TXA2);
 
-	if (status & Y2_IS_STAT_BMU)
-		sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
-
 	work_done = sky2_status_intr(hw, work_limit);
 	*budget -= work_done;
 	dev0->quota -= work_done;
 
-	if (work_done >= work_limit)
+	if (status & Y2_IS_STAT_BMU)
+		sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
+
+	if (sky2_more_work(hw))
 		return 1;
 
 	netif_rx_complete(dev0);
 
-	status = sky2_read32(hw, B0_Y2_SP_LISR);
+	sky2_read32(hw, B0_Y2_SP_LISR);
 	return 0;
 }
 
@@ -3078,12 +3093,7 @@ #endif
 	sky2->duplex = -1;
 	sky2->speed = -1;
 	sky2->advertising = sky2_supported_modes(hw);
-
-	/* Receive checksum disabled for Yukon XL
-	 * because of observed problems with incorrect
-	 * values when multiple packets are received in one interrupt
-	 */
-	sky2->rx_csum = (hw->chip_id != CHIP_ID_YUKON_XL);
+	sky2->rx_csum = 1;
 
 	spin_lock_init(&sky2->phy_lock);
 	sky2->tx_pending = TX_DEF_PENDING;
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 8012994..8a0bc55 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -214,6 +214,8 @@ #define RAM_BUFFER(port, reg)	(reg | (po
 enum {
 	Y2_VMAIN_AVAIL	= 1<<17,/* VMAIN available (YUKON-2 only) */
 	Y2_VAUX_AVAIL	= 1<<16,/* VAUX available (YUKON-2 only) */
+	Y2_HW_WOL_ON	= 1<<15,/* HW WOL On  (Yukon-EC Ultra A1 only) */
+	Y2_HW_WOL_OFF	= 1<<14,/* HW WOL On  (Yukon-EC Ultra A1 only) */
 	Y2_ASF_ENABLE	= 1<<13,/* ASF Unit Enable (YUKON-2 only) */
 	Y2_ASF_DISABLE	= 1<<12,/* ASF Unit Disable (YUKON-2 only) */
 	Y2_CLK_RUN_ENA	= 1<<11,/* CLK_RUN Enable  (YUKON-2 only) */
diff --git a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
index ba05ded..136a70c 100644
--- a/drivers/net/tulip/winbond-840.c
+++ b/drivers/net/tulip/winbond-840.c
@@ -850,7 +850,7 @@ static void init_rxtx_rings(struct net_d
 			break;
 		skb->dev = dev;			/* Mark as being used by this device. */
 		np->rx_addr[i] = pci_map_single(np->pci_dev,skb->data,
-					skb->len,PCI_DMA_FROMDEVICE);
+					np->rx_buf_sz,PCI_DMA_FROMDEVICE);
 
 		np->rx_ring[i].buffer1 = np->rx_addr[i];
 		np->rx_ring[i].status = DescOwn;
@@ -1316,7 +1316,7 @@ #endif
 			skb->dev = dev;			/* Mark as being used by this device. */
 			np->rx_addr[entry] = pci_map_single(np->pci_dev,
 							skb->data,
-							skb->len, PCI_DMA_FROMDEVICE);
+							np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			np->rx_ring[entry].buffer1 = np->rx_addr[entry];
 		}
 		wmb();
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index a6dc53b..fdc2103 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -491,8 +491,6 @@ struct rhine_private {
 	u8 tx_thresh, rx_thresh;
 
 	struct mii_if_info mii_if;
-	struct work_struct tx_timeout_task;
-	struct work_struct check_media_task;
 	void __iomem *base;
 };
 
@@ -500,8 +498,6 @@ static int  mdio_read(struct net_device 
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int  rhine_open(struct net_device *dev);
 static void rhine_tx_timeout(struct net_device *dev);
-static void rhine_tx_timeout_task(struct net_device *dev);
-static void rhine_check_media_task(struct net_device *dev);
 static int  rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t rhine_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static void rhine_tx(struct net_device *dev);
@@ -856,12 +852,6 @@ #endif
 	if (rp->quirks & rqRhineI)
 		dev->features |= NETIF_F_SG|NETIF_F_HW_CSUM;
 
-	INIT_WORK(&rp->tx_timeout_task,
-		  (void (*)(void *))rhine_tx_timeout_task, dev);
-
-	INIT_WORK(&rp->check_media_task,
-		  (void (*)(void *))rhine_check_media_task, dev);
-
 	/* dev->name not defined before register_netdev()! */
 	rc = register_netdev(dev);
 	if (rc)
@@ -1108,11 +1098,6 @@ static void rhine_set_carrier(struct mii
 		       netif_carrier_ok(mii->dev));
 }
 
-static void rhine_check_media_task(struct net_device *dev)
-{
-	rhine_check_media(dev, 0);
-}
-
 static void init_registers(struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
@@ -1166,8 +1151,8 @@ static void rhine_disable_linkmon(void _
 	if (quirks & rqRhineI) {
 		iowrite8(0x01, ioaddr + MIIRegAddr);	// MII_BMSR
 
-		/* Do not call from ISR! */
-		msleep(1);
+		/* Can be called from ISR. Evil. */
+		mdelay(1);
 
 		/* 0x80 must be set immediately before turning it off */
 		iowrite8(0x80, ioaddr + MIICmd);
@@ -1257,16 +1242,6 @@ static int rhine_open(struct net_device 
 static void rhine_tx_timeout(struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
-
-	/*
-	 * Move bulk of work outside of interrupt context
-	 */
-	schedule_work(&rp->tx_timeout_task);
-}
-
-static void rhine_tx_timeout_task(struct net_device *dev)
-{
-	struct rhine_private *rp = netdev_priv(dev);
 	void __iomem *ioaddr = rp->base;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
@@ -1677,7 +1652,7 @@ static void rhine_error(struct net_devic
 	spin_lock(&rp->lock);
 
 	if (intr_status & IntrLinkChange)
-		schedule_work(&rp->check_media_task);
+		rhine_check_media(dev, 0);
 	if (intr_status & IntrStatsMax) {
 		rp->stats.rx_crc_errors += ioread16(ioaddr + RxCRCErrs);
 		rp->stats.rx_missed_errors += ioread16(ioaddr + RxMissed);
@@ -1927,9 +1902,6 @@ static int rhine_close(struct net_device
 	spin_unlock_irq(&rp->lock);
 
 	free_irq(rp->pdev->irq, dev);
-
-	flush_scheduled_work();
-
 	free_rbufs(dev);
 	free_tbufs(dev);
 	free_ring(dev);
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index e2982a8..7ed18ca 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -3271,6 +3271,9 @@ static int bcm43xx_init_board(struct bcm
 	bcm43xx_sysfs_register(bcm);
 	//FIXME: check for bcm43xx_sysfs_register failure. This function is a bit messy regarding unwinding, though...
 
+	/*FIXME: This should be handled by softmac instead. */
+	schedule_work(&bcm->softmac->associnfo.work);
+
 	assert(err == 0);
 out:
 	return err;
@@ -3946,9 +3949,6 @@ static int bcm43xx_resume(struct pci_dev
 
 	netif_device_attach(net_dev);
 	
-	/*FIXME: This should be handled by softmac instead. */
-	schedule_work(&bcm->softmac->associnfo.work);
-
 	dprintk(KERN_INFO PFX "Device resumed.\n");
 
 	return 0;
