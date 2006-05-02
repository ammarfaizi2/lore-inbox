Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWEBTbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWEBTbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWEBTbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:31:04 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32736 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750867AbWEBTbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:31:01 -0400
Date: Tue, 2 May 2006 15:30:59 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [git patches] net driver fixes
Message-ID: <20060502193059.GA5859@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the last net driver push from me until May 12th.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/forcedeth.c   |  312 +++++++++++++++++++++++++++++++++-------------
 drivers/net/mv643xx_eth.c |    2 
 drivers/net/via-rhine.c   |    6 
 3 files changed, 236 insertions(+), 84 deletions(-)

Ayaz Abdulla:
      forcedeth: fix multi irq issues

Craig Brind:
      via-rhine: zero pad short packets on Rhine I ethernet cards

Olaf Hering:
      mv643xx_eth: provide sysfs class device symlink

diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 9788b1e..f7235c9 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -106,6 +106,7 @@
  *	0.51: 20 Jan 2006: Add 64bit consistent memory allocation for rings.
  *	0.52: 20 Jan 2006: Add MSI/MSIX support.
  *	0.53: 19 Mar 2006: Fix init from low power mode and add hw reset.
+ *	0.54: 21 Mar 2006: Fix spin locks for multi irqs and cleanup.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -117,7 +118,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.53"
+#define FORCEDETH_VERSION		"0.54"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -710,6 +711,72 @@ static void setup_hw_rings(struct net_de
 	}
 }
 
+static int using_multi_irqs(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
+	    ((np->msi_flags & NV_MSI_X_ENABLED) &&
+	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1)))
+		return 0;
+	else
+		return 1;
+}
+
+static void nv_enable_irq(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	if (!using_multi_irqs(dev)) {
+		if (np->msi_flags & NV_MSI_X_ENABLED)
+			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
+		else
+			enable_irq(dev->irq);
+	} else {
+		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
+		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
+		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
+	}
+}
+
+static void nv_disable_irq(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	if (!using_multi_irqs(dev)) {
+		if (np->msi_flags & NV_MSI_X_ENABLED)
+			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
+		else
+			disable_irq(dev->irq);
+	} else {
+		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
+		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
+		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
+	}
+}
+
+/* In MSIX mode, a write to irqmask behaves as XOR */
+static void nv_enable_hw_interrupts(struct net_device *dev, u32 mask)
+{
+	u8 __iomem *base = get_hwbase(dev);
+
+	writel(mask, base + NvRegIrqMask);
+}
+
+static void nv_disable_hw_interrupts(struct net_device *dev, u32 mask)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u8 __iomem *base = get_hwbase(dev);
+
+	if (np->msi_flags & NV_MSI_X_ENABLED) {
+		writel(mask, base + NvRegIrqMask);
+	} else {
+		if (np->msi_flags & NV_MSI_ENABLED)
+			writel(0, base + NvRegMSIIrqMask);
+		writel(0, base + NvRegIrqMask);
+	}
+}
+
 #define MII_READ	(-1)
 /* mii_rw: read/write a register on the PHY.
  *
@@ -1019,24 +1086,25 @@ static void nv_do_rx_refill(unsigned lon
 	struct net_device *dev = (struct net_device *) data;
 	struct fe_priv *np = netdev_priv(dev);
 
-
-	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
-	    ((np->msi_flags & NV_MSI_X_ENABLED) && 
-	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
-		disable_irq(dev->irq);
+	if (!using_multi_irqs(dev)) {
+		if (np->msi_flags & NV_MSI_X_ENABLED)
+			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
+		else
+			disable_irq(dev->irq);
 	} else {
 		disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
 	}
 	if (nv_alloc_rx(dev)) {
-		spin_lock(&np->lock);
+		spin_lock_irq(&np->lock);
 		if (!np->in_shutdown)
 			mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-		spin_unlock(&np->lock);
+		spin_unlock_irq(&np->lock);
 	}
-	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
-	    ((np->msi_flags & NV_MSI_X_ENABLED) && 
-	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
-		enable_irq(dev->irq);
+	if (!using_multi_irqs(dev)) {
+		if (np->msi_flags & NV_MSI_X_ENABLED)
+			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
+		else
+			enable_irq(dev->irq);
 	} else {
 		enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
 	}
@@ -1668,15 +1736,7 @@ static int nv_change_mtu(struct net_devi
 		 * guessed, there is probably a simpler approach.
 		 * Changing the MTU is a rare event, it shouldn't matter.
 		 */
-		if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
-		    ((np->msi_flags & NV_MSI_X_ENABLED) && 
-		     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
-			disable_irq(dev->irq);
-		} else {
-			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
-			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
-			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
-		}
+		nv_disable_irq(dev);
 		spin_lock_bh(&dev->xmit_lock);
 		spin_lock(&np->lock);
 		/* stop engines */
@@ -1709,15 +1769,7 @@ static int nv_change_mtu(struct net_devi
 		nv_start_tx(dev);
 		spin_unlock(&np->lock);
 		spin_unlock_bh(&dev->xmit_lock);
-		if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
-		    ((np->msi_flags & NV_MSI_X_ENABLED) && 
-		     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
-			enable_irq(dev->irq);
-		} else {
-			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector);
-			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector);
-			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector);
-		}
+		nv_enable_irq(dev);
 	}
 	return 0;
 }
@@ -2108,16 +2160,16 @@ static irqreturn_t nv_nic_irq_tx(int foo
 		if (!(events & np->irqmask))
 			break;
 
-		spin_lock(&np->lock);
+		spin_lock_irq(&np->lock);
 		nv_tx_done(dev);
-		spin_unlock(&np->lock);
+		spin_unlock_irq(&np->lock);
 		
 		if (events & (NVREG_IRQ_TX_ERR)) {
 			dprintk(KERN_DEBUG "%s: received irq with events 0x%x. Probably TX fail.\n",
 						dev->name, events);
 		}
 		if (i > max_interrupt_work) {
-			spin_lock(&np->lock);
+			spin_lock_irq(&np->lock);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_TX_ALL, base + NvRegIrqMask);
 			pci_push(base);
@@ -2127,7 +2179,7 @@ static irqreturn_t nv_nic_irq_tx(int foo
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_tx.\n", dev->name, i);
-			spin_unlock(&np->lock);
+			spin_unlock_irq(&np->lock);
 			break;
 		}
 
@@ -2157,14 +2209,14 @@ static irqreturn_t nv_nic_irq_rx(int foo
 		
 		nv_rx_process(dev);
 		if (nv_alloc_rx(dev)) {
-			spin_lock(&np->lock);
+			spin_lock_irq(&np->lock);
 			if (!np->in_shutdown)
 				mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-			spin_unlock(&np->lock);
+			spin_unlock_irq(&np->lock);
 		}
 		
 		if (i > max_interrupt_work) {
-			spin_lock(&np->lock);
+			spin_lock_irq(&np->lock);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_RX_ALL, base + NvRegIrqMask);
 			pci_push(base);
@@ -2174,7 +2226,7 @@ static irqreturn_t nv_nic_irq_rx(int foo
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_rx.\n", dev->name, i);
-			spin_unlock(&np->lock);
+			spin_unlock_irq(&np->lock);
 			break;
 		}
 
@@ -2203,14 +2255,14 @@ static irqreturn_t nv_nic_irq_other(int 
 			break;
 		
 		if (events & NVREG_IRQ_LINK) {
-			spin_lock(&np->lock);
+			spin_lock_irq(&np->lock);
 			nv_link_irq(dev);
-			spin_unlock(&np->lock);
+			spin_unlock_irq(&np->lock);
 		}
 		if (np->need_linktimer && time_after(jiffies, np->link_timeout)) {
-			spin_lock(&np->lock);
+			spin_lock_irq(&np->lock);
 			nv_linkchange(dev);
-			spin_unlock(&np->lock);
+			spin_unlock_irq(&np->lock);
 			np->link_timeout = jiffies + LINK_TIMEOUT;
 		}
 		if (events & (NVREG_IRQ_UNKNOWN)) {
@@ -2218,7 +2270,7 @@ static irqreturn_t nv_nic_irq_other(int 
 						dev->name, events);
 		}
 		if (i > max_interrupt_work) {
-			spin_lock(&np->lock);
+			spin_lock_irq(&np->lock);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_OTHER, base + NvRegIrqMask);
 			pci_push(base);
@@ -2228,7 +2280,7 @@ static irqreturn_t nv_nic_irq_other(int 
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_other.\n", dev->name, i);
-			spin_unlock(&np->lock);
+			spin_unlock_irq(&np->lock);
 			break;
 		}
 
@@ -2251,10 +2303,11 @@ static void nv_do_nic_poll(unsigned long
 	 * nv_nic_irq because that may decide to do otherwise
 	 */
 
-	if (!(np->msi_flags & NV_MSI_X_ENABLED) ||
-	    ((np->msi_flags & NV_MSI_X_ENABLED) && 
-	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
-		disable_irq(dev->irq);
+	if (!using_multi_irqs(dev)) {
+		if (np->msi_flags & NV_MSI_X_ENABLED)
+			disable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
+		else
+			disable_irq(dev->irq);
 		mask = np->irqmask;
 	} else {
 		if (np->nic_poll_irq & NVREG_IRQ_RX_ALL) {
@@ -2277,11 +2330,12 @@ static void nv_do_nic_poll(unsigned long
 	writel(mask, base + NvRegIrqMask);
 	pci_push(base);
 
-	if (!(np->msi_flags & NV_MSI_X_ENABLED) || 
-	    ((np->msi_flags & NV_MSI_X_ENABLED) && 
-	     ((np->msi_flags & NV_MSI_X_VECTORS_MASK) == 0x1))) {
+	if (!using_multi_irqs(dev)) {
 		nv_nic_irq((int) 0, (void *) data, (struct pt_regs *) NULL);
-		enable_irq(dev->irq);
+		if (np->msi_flags & NV_MSI_X_ENABLED)
+			enable_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector);
+		else
+			enable_irq(dev->irq);
 	} else {
 		if (np->nic_poll_irq & NVREG_IRQ_RX_ALL) {
 			nv_nic_irq_rx((int) 0, (void *) data, (struct pt_regs *) NULL);
@@ -2628,6 +2682,113 @@ static void set_msix_vector_map(struct n
 	writel(readl(base + NvRegMSIXMap1) | msixmap, base + NvRegMSIXMap1);
 }
 
+static int nv_request_irq(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u8 __iomem *base = get_hwbase(dev);
+	int ret = 1;
+	int i;
+
+	if (np->msi_flags & NV_MSI_X_CAPABLE) {
+		for (i = 0; i < (np->msi_flags & NV_MSI_X_VECTORS_MASK); i++) {
+			np->msi_x_entry[i].entry = i;
+		}
+		if ((ret = pci_enable_msix(np->pci_dev, np->msi_x_entry, (np->msi_flags & NV_MSI_X_VECTORS_MASK))) == 0) {
+			np->msi_flags |= NV_MSI_X_ENABLED;
+			if (optimization_mode == NV_OPTIMIZATION_MODE_THROUGHPUT) {
+				/* Request irq for rx handling */
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector, &nv_nic_irq_rx, SA_SHIRQ, dev->name, dev) != 0) {
+					printk(KERN_INFO "forcedeth: request_irq failed for rx %d\n", ret);
+					pci_disable_msix(np->pci_dev);
+					np->msi_flags &= ~NV_MSI_X_ENABLED;
+					goto out_err;
+				}
+				/* Request irq for tx handling */
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector, &nv_nic_irq_tx, SA_SHIRQ, dev->name, dev) != 0) {
+					printk(KERN_INFO "forcedeth: request_irq failed for tx %d\n", ret);
+					pci_disable_msix(np->pci_dev);
+					np->msi_flags &= ~NV_MSI_X_ENABLED;
+					goto out_free_rx;
+				}
+				/* Request irq for link and timer handling */
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_OTHER].vector, &nv_nic_irq_other, SA_SHIRQ, dev->name, dev) != 0) {
+					printk(KERN_INFO "forcedeth: request_irq failed for link %d\n", ret);
+					pci_disable_msix(np->pci_dev);
+					np->msi_flags &= ~NV_MSI_X_ENABLED;
+					goto out_free_tx;
+				}
+				/* map interrupts to their respective vector */
+				writel(0, base + NvRegMSIXMap0);
+				writel(0, base + NvRegMSIXMap1);
+				set_msix_vector_map(dev, NV_MSI_X_VECTOR_RX, NVREG_IRQ_RX_ALL);
+				set_msix_vector_map(dev, NV_MSI_X_VECTOR_TX, NVREG_IRQ_TX_ALL);
+				set_msix_vector_map(dev, NV_MSI_X_VECTOR_OTHER, NVREG_IRQ_OTHER);
+			} else {
+				/* Request irq for all interrupts */
+				if (request_irq(np->msi_x_entry[NV_MSI_X_VECTOR_ALL].vector, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) {
+					printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
+					pci_disable_msix(np->pci_dev);
+					np->msi_flags &= ~NV_MSI_X_ENABLED;
+					goto out_err;
+				}
+
+				/* map interrupts to vector 0 */
+				writel(0, base + NvRegMSIXMap0);
+				writel(0, base + NvRegMSIXMap1);
+			}
+		}
+	}
+	if (ret != 0 && np->msi_flags & NV_MSI_CAPABLE) {
+		if ((ret = pci_enable_msi(np->pci_dev)) == 0) {
+			np->msi_flags |= NV_MSI_ENABLED;
+			if (request_irq(np->pci_dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0) {
+				printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
+				pci_disable_msi(np->pci_dev);
+				np->msi_flags &= ~NV_MSI_ENABLED;
+				goto out_err;
+			}
+
+			/* map interrupts to vector 0 */
+			writel(0, base + NvRegMSIMap0);
+			writel(0, base + NvRegMSIMap1);
+			/* enable msi vector 0 */
+			writel(NVREG_MSI_VECTOR_0_ENABLED, base + NvRegMSIIrqMask);
+		}
+	}
+	if (ret != 0) {
+		if (request_irq(np->pci_dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev) != 0)
+			goto out_err;
+	}
+
+	return 0;
+out_free_tx:
+	free_irq(np->msi_x_entry[NV_MSI_X_VECTOR_TX].vector, dev);
+out_free_rx:
+	free_irq(np->msi_x_entry[NV_MSI_X_VECTOR_RX].vector, dev);
+out_err:
+	return 1;
+}
+
+static void nv_free_irq(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	int i;
+
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
+}
+
 static int nv_open(struct net_device *dev)
 {
 	struct fe_priv *np = netdev_priv(dev);
@@ -2720,12 +2881,16 @@ static int nv_open(struct net_device *de
 	udelay(10);
 	writel(readl(base + NvRegPowerState) | NVREG_POWERSTATE_VALID, base + NvRegPowerState);
 
-	writel(0, base + NvRegIrqMask);
+	nv_disable_hw_interrupts(dev, np->irqmask);
 	pci_push(base);
 	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 	pci_push(base);
 
+	if (nv_request_irq(dev)) {
+		goto out_drain;
+	}
+
 	if (np->msi_flags & NV_MSI_X_CAPABLE) {
 		for (i = 0; i < (np->msi_flags & NV_MSI_X_VECTORS_MASK); i++) {
 			np->msi_x_entry[i].entry = i;
@@ -2799,7 +2964,7 @@ static int nv_open(struct net_device *de
 	}
 
 	/* ask for interrupts */
-	writel(np->irqmask, base + NvRegIrqMask);
+	nv_enable_hw_interrupts(dev, np->irqmask);
 
 	spin_lock_irq(&np->lock);
 	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
@@ -2843,7 +3008,6 @@ static int nv_close(struct net_device *d
 {
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base;
-	int i;
 
 	spin_lock_irq(&np->lock);
 	np->in_shutdown = 1;
@@ -2861,31 +3025,13 @@ static int nv_close(struct net_device *d
 
 	/* disable interrupts on the nic or we will lock up */
 	base = get_hwbase(dev);
-	if (np->msi_flags & NV_MSI_X_ENABLED) {
-		writel(np->irqmask, base + NvRegIrqMask);
-	} else {
-		if (np->msi_flags & NV_MSI_ENABLED)
-			writel(0, base + NvRegMSIIrqMask);
-		writel(0, base + NvRegIrqMask);
-	}
+	nv_disable_hw_interrupts(dev, np->irqmask);
 	pci_push(base);
 	dprintk(KERN_INFO "%s: Irqmask is zero again\n", dev->name);
 
 	spin_unlock_irq(&np->lock);
 
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
+	nv_free_irq(dev);
 
 	drain_ring(dev);
 
@@ -2974,20 +3120,18 @@ static int __devinit nv_probe(struct pci
 	if (id->driver_data & DEV_HAS_HIGH_DMA) {
 		/* packet format 3: supports 40-bit addressing */
 		np->desc_ver = DESC_VER_3;
+		np->txrxctl_bits = NVREG_TXRXCTL_DESC_3;
 		if (pci_set_dma_mask(pci_dev, DMA_39BIT_MASK)) {
 			printk(KERN_INFO "forcedeth: 64-bit DMA failed, using 32-bit addressing for device %s.\n",
 					pci_name(pci_dev));
 		} else {
-			if (pci_set_consistent_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
-				printk(KERN_INFO "forcedeth: 64-bit DMA (consistent) failed for device %s.\n",
-					pci_name(pci_dev));
-				goto out_relreg;
-			} else {
-				dev->features |= NETIF_F_HIGHDMA;
-				printk(KERN_INFO "forcedeth: using HIGHDMA\n");
-			}
+			dev->features |= NETIF_F_HIGHDMA;
+			printk(KERN_INFO "forcedeth: using HIGHDMA\n");
+		}
+		if (pci_set_consistent_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
+			printk(KERN_INFO "forcedeth: 64-bit DMA (consistent) failed for device %s.\n",
+			       pci_name(pci_dev));
 		}
-		np->txrxctl_bits = NVREG_TXRXCTL_DESC_3;
 	} else if (id->driver_data & DEV_HAS_LARGEDESC) {
 		/* packet format 2: supports jumbo frames */
 		np->desc_ver = DESC_VER_2;
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index ea62a3e..411f4d8 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -1419,6 +1419,8 @@ #endif
 	mv643xx_eth_update_pscr(dev, &cmd);
 	mv643xx_set_settings(dev, &cmd);
 
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 	err = register_netdev(dev);
 	if (err)
 		goto out;
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index 6a23964..a6dc53b 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -129,6 +129,7 @@
 	- Massive clean-up
 	- Rewrite PHY, media handling (remove options, full_duplex, backoff)
 	- Fix Tx engine race for good
+	- Craig Brind: Zero padded aligned buffers for short packets.
 
 */
 
@@ -1326,7 +1327,12 @@ static int rhine_start_tx(struct sk_buff
 			rp->stats.tx_dropped++;
 			return 0;
 		}
+
+		/* Padding is not copied and so must be redone. */
 		skb_copy_and_csum_dev(skb, rp->tx_buf[entry]);
+		if (skb->len < ETH_ZLEN)
+			memset(rp->tx_buf[entry] + skb->len, 0,
+			       ETH_ZLEN - skb->len);
 		rp->tx_skbuff_dma[entry] = 0;
 		rp->tx_ring[entry].addr = cpu_to_le32(rp->tx_bufs_dma +
 						      (rp->tx_buf[entry] -
