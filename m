Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVFGAYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVFGAYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVFGAYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:24:01 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:17754 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261791AbVFGAUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:20:54 -0400
Date: Mon, 6 Jun 2005 17:20:45 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607002045.GA12849@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, as it seems there is a bit of confusion, here's real code that
should help explain what I am proposing.  This works on my desktop, but
I don't think it supports MSI :)

I'll go dig out an old 4-way AMD box that has MSI to see if this still
works properly, but comments are welcome.

thanks,

greg k-h

--------------------

PCI: remove access to pci_[enable|disable]_msi() for drivers

This is now handled by the PCI core.  A new function, pci_in_msi_mode() can
be used to tell if a PCI device has MSI enabled for it or not.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/infiniband/hw/mthca/mthca_main.c |    6 +-----
 drivers/net/bnx2.c                       |    2 +-
 drivers/net/e1000/e1000_main.c           |    9 ++-------
 drivers/net/ixgb/ixgb_main.c             |   10 +++-------
 drivers/net/tg3.c                        |   19 +------------------
 drivers/pci/hotplug/pciehp_hpc.c         |    2 --
 drivers/pci/hotplug/shpchp_hpc.c         |    4 +---
 drivers/pci/msi.c                        |   29 +++++++++++++++++++++++++++--
 drivers/pci/pci.c                        |    4 +++-
 drivers/pci/pci.h                        |    8 ++++++++
 drivers/pci/pcie/portdrv_core.c          |    5 +----
 include/linux/pci.h                      |    6 ++----
 12 files changed, 50 insertions(+), 54 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c	2005-06-06 16:16:25.000000000 -0700
+++ gregkh-2.6/drivers/pci/msi.c	2005-06-06 17:01:35.000000000 -0700
@@ -692,6 +692,31 @@
 }
 
 /**
+ * pci_in_msi_mode - determine if a specific PCI device is in MSI mode or not.
+ * @dev: pointer to the pci_dev data structure to test
+ *
+ * Returns 1 if MSI is enabled for this PCI device, otherwise will return 0.
+ **/
+int pci_in_msi_mode(struct pci_dev* dev)
+{
+	int pos;
+	u16 control;
+
+	if (!pci_msi_enable || !dev)
+ 		return 0;
+
+   	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSI)))
+		return 0;
+
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	if (control & PCI_MSI_FLAGS_ENABLE)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_in_msi_mode);
+
+/**
  * pci_enable_msi - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
@@ -1145,7 +1170,7 @@
 	}
 }
 
-EXPORT_SYMBOL(pci_enable_msi);
-EXPORT_SYMBOL(pci_disable_msi);
+//EXPORT_SYMBOL(pci_enable_msi);
+//EXPORT_SYMBOL(pci_disable_msi);
 EXPORT_SYMBOL(pci_enable_msix);
 EXPORT_SYMBOL(pci_disable_msix);
--- gregkh-2.6.orig/include/linux/pci.h	2005-06-06 16:16:25.000000000 -0700
+++ gregkh-2.6/include/linux/pci.h	2005-06-06 16:29:59.000000000 -0700
@@ -880,17 +880,15 @@
 };
 
 #ifndef CONFIG_PCI_MSI
+static inline int pci_in_msi_mode(struct pci_dev* dev) {return 0;}
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
-static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
-static inline void pci_disable_msi(struct pci_dev *dev) {}
 static inline int pci_enable_msix(struct pci_dev* dev,
 	struct msix_entry *entries, int nvec) {return -1;}
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 #else
+extern int pci_in_msi_mode(struct pci_dev* dev);
 extern void pci_scan_msi_device(struct pci_dev *dev);
-extern int pci_enable_msi(struct pci_dev *dev);
-extern void pci_disable_msi(struct pci_dev *dev);
 extern int pci_enable_msix(struct pci_dev* dev,
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
--- gregkh-2.6.orig/drivers/pci/pci.c	2005-06-06 16:16:30.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci.c	2005-06-06 16:20:06.000000000 -0700
@@ -402,6 +402,7 @@
 	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
+	pci_enable_msi(dev);
 	dev->is_enabled = 1;
 	return 0;
 }
@@ -427,7 +428,8 @@
 pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
-	
+
+	pci_disable_msi(dev);
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
--- gregkh-2.6.orig/drivers/net/bnx2.c	2005-06-06 12:08:46.000000000 -0700
+++ gregkh-2.6/drivers/net/bnx2.c	2005-06-06 16:30:30.000000000 -0700
@@ -3888,7 +3888,7 @@
 		(CHIP_ID(bp) != CHIP_ID_5706_A1) &&
 		!disable_msi) {
 
-		if (pci_enable_msi(bp->pdev) == 0) {
+		if (pci_in_msi_mode(bp->pdev)) {
 			bp->flags |= USING_MSI_FLAG;
 			rc = request_irq(bp->pdev->irq, bnx2_msi, 0, dev->name,
 					dev);
--- gregkh-2.6.orig/drivers/pci/pci.h	2005-06-06 12:08:52.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci.h	2005-06-06 16:29:47.000000000 -0700
@@ -37,6 +37,14 @@
 /* Lock for read/write access to pci device and bus lists */
 extern spinlock_t pci_bus_lock;
 
+#ifndef CONFIG_PCI_MSI
+static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
+static inline void pci_disable_msi(struct pci_dev *dev) {}
+#else
+extern int pci_enable_msi(struct pci_dev *dev);
+extern void pci_disable_msi(struct pci_dev *dev);
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 extern int pci_msi_quirk;
 #else
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchp_hpc.c	2005-03-01 23:37:52.000000000 -0800
+++ gregkh-2.6/drivers/pci/hotplug/shpchp_hpc.c	2005-06-06 16:33:25.000000000 -0700
@@ -792,7 +792,6 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
-			pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) {
@@ -1552,8 +1551,7 @@
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-		rc = pci_enable_msi(pdev);
-		if (rc) {
+		if (!pci_in_msi_mode(pdev)) {
 			info("Can't get msi for the hotplug controller\n");
 			info("Use INTx for the hotplug controller\n");
 			dbg("%s: rc = %x\n", __FUNCTION__, rc);
--- gregkh-2.6.orig/drivers/pci/pcie/portdrv_core.c	2005-06-06 12:23:18.000000000 -0700
+++ gregkh-2.6/drivers/pci/pcie/portdrv_core.c	2005-06-06 16:32:24.000000000 -0700
@@ -164,8 +164,7 @@
 		pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 		if (pos) {
 			printk("%s Found MSI capability\n", __FUNCTION__);
-			status = pci_enable_msi(dev);
-			if (!status) {
+			if (pci_in_msi_mode(dev)) {
 				interrupt_mode = PCIE_PORT_MSI_MODE;
 				for (i = 0;i < PCIE_PORT_DEVICE_MAXSERVICES;i++)
 					vectors[i] = dev->irq;
@@ -398,8 +397,6 @@
 	/* Switch to INTx by default if MSI enabled */
 	if (interrupt_mode == PCIE_PORT_MSIX_MODE)
 		pci_disable_msix(dev);
-	else if (interrupt_mode == PCIE_PORT_MSI_MODE)
-		pci_disable_msi(dev);
 }
 
 void pcie_port_bus_register(void)
--- gregkh-2.6.orig/drivers/net/e1000/e1000_main.c	2005-06-06 12:08:47.000000000 -0700
+++ gregkh-2.6/drivers/net/e1000/e1000_main.c	2005-06-06 16:52:02.000000000 -0700
@@ -321,9 +321,9 @@
 #ifdef CONFIG_PCI_MSI
 	if(adapter->hw.mac_type > e1000_82547_rev_2) {
 		adapter->have_msi = TRUE;
-		if((err = pci_enable_msi(adapter->pdev))) {
+		if (!pci_in_msi_mode(adapter->pdev)) {
 			DPRINTK(PROBE, ERR,
-			 "Unable to allocate MSI interrupt Error: %d\n", err);
+			 "Unable to allocate MSI interrupt\n");
 			adapter->have_msi = FALSE;
 		}
 	}
@@ -353,11 +353,6 @@
 
 	e1000_irq_disable(adapter);
 	free_irq(adapter->pdev->irq, netdev);
-#ifdef CONFIG_PCI_MSI
-	if(adapter->hw.mac_type > e1000_82547_rev_2 &&
-	   adapter->have_msi == TRUE)
-		pci_disable_msi(adapter->pdev);
-#endif
 	del_timer_sync(&adapter->tx_fifo_stall_timer);
 	del_timer_sync(&adapter->watchdog_timer);
 	del_timer_sync(&adapter->phy_info_timer);
--- gregkh-2.6.orig/drivers/net/ixgb/ixgb_main.c	2005-06-06 12:08:48.000000000 -0700
+++ gregkh-2.6/drivers/net/ixgb/ixgb_main.c	2005-06-06 16:54:49.000000000 -0700
@@ -239,9 +239,9 @@
 
 	if (!pcix)
 	   adapter->have_msi = FALSE;
-	else if((err = pci_enable_msi(adapter->pdev))) {
-		printk (KERN_ERR
-		 "Unable to allocate MSI interrupt Error: %d\n", err);
+	else if (!pci_in_msi_mode(adapter->pdev)) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to allocate MSI interrupt\n");
 		adapter->have_msi = FALSE;
 		/* proceed to try to request regular interrupt */
 	}
@@ -291,11 +291,7 @@
 
 	ixgb_irq_disable(adapter);
 	free_irq(adapter->pdev->irq, netdev);
-#ifdef CONFIG_PCI_MSI
-	if(adapter->have_msi == TRUE)
-		pci_disable_msi(adapter->pdev);
 
-#endif
 	if(kill_watchdog)
 		del_timer_sync(&adapter->watchdog_timer);
 #ifdef CONFIG_IXGB_NAPI
--- gregkh-2.6.orig/drivers/net/tg3.c	2005-06-06 12:08:51.000000000 -0700
+++ gregkh-2.6/drivers/net/tg3.c	2005-06-06 16:57:34.000000000 -0700
@@ -5984,7 +5984,6 @@
 		       tp->dev->name);
 
 	free_irq(tp->pdev->irq, dev);
-	pci_disable_msi(tp->pdev);
 
 	tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
 
@@ -6047,7 +6046,7 @@
 		if (!(tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)) {
 			printk(KERN_WARNING PFX "%s: MSI without TAGGED? "
 			       "Not using MSI.\n", tp->dev->name);
-		} else if (pci_enable_msi(tp->pdev) == 0) {
+		} else if (pci_in_msi_mode(tp->pdev)) {
 			u32 msi_mode;
 
 			msi_mode = tr32(MSGINT_MODE);
@@ -6068,10 +6067,6 @@
 	}
 
 	if (err) {
-		if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-			pci_disable_msi(tp->pdev);
-			tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-		}
 		tg3_free_consistent(tp);
 		return err;
 	}
@@ -6106,10 +6101,6 @@
 
 	if (err) {
 		free_irq(tp->pdev->irq, dev);
-		if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-			pci_disable_msi(tp->pdev);
-			tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-		}
 		tg3_free_consistent(tp);
 		return err;
 	}
@@ -6121,10 +6112,6 @@
 			spin_lock_irq(&tp->lock);
 			spin_lock(&tp->tx_lock);
 
-			if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-				pci_disable_msi(tp->pdev);
-				tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-			}
 			tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 			tg3_free_rings(tp);
 			tg3_free_consistent(tp);
@@ -6409,10 +6396,6 @@
 	spin_unlock_irq(&tp->lock);
 
 	free_irq(tp->pdev->irq, dev);
-	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-		pci_disable_msi(tp->pdev);
-		tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-	}
 
 	memcpy(&tp->net_stats_prev, tg3_get_stats(tp->dev),
 	       sizeof(tp->net_stats_prev));
--- gregkh-2.6.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-06 12:08:42.000000000 -0700
+++ gregkh-2.6/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-06 17:01:37.000000000 -0700
@@ -1001,7 +1001,7 @@
 	if (msi_x && !mthca_enable_msi_x(mdev))
 		mdev->mthca_flags |= MTHCA_FLAG_MSI_X;
 	if (msi && !(mdev->mthca_flags & MTHCA_FLAG_MSI_X) &&
-	    !pci_enable_msi(pdev))
+	    pci_in_msi_mode(pdev))
 		mdev->mthca_flags |= MTHCA_FLAG_MSI;
 
 	sema_init(&mdev->cmd.hcr_sem, 1);
@@ -1076,8 +1076,6 @@
 err_free_dev:
 	if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 		pci_disable_msix(pdev);
-	if (mdev->mthca_flags & MTHCA_FLAG_MSI)
-		pci_disable_msi(pdev);
 
 	ib_dealloc_device(&mdev->ib_dev);
 
@@ -1125,8 +1123,6 @@
 
 		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 			pci_disable_msix(pdev);
-		if (mdev->mthca_flags & MTHCA_FLAG_MSI)
-			pci_disable_msi(pdev);
 
 		ib_dealloc_device(&mdev->ib_dev);
 		mthca_release_regions(pdev, mdev->mthca_flags &
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c	2005-06-06 12:08:52.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehp_hpc.c	2005-06-06 17:02:40.000000000 -0700
@@ -741,8 +741,6 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
-			if (!pcie_mch_quirk) 
-				pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) 
