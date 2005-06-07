Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVFGUYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVFGUYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVFGUYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:24:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:2000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261963AbVFGUVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:21:45 -0400
Date: Tue, 7 Jun 2005 13:21:29 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050607202129.GB18039@kroah.com>
References: <20050607002045.GA12849@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607002045.GA12849@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, here's an updated patch that should have fixed the errors I had in
my previous one where I wasn't disabling MSI for the devices that did
not want it enabled (note, my patch skips the hotplug and pcie driver
for now, those would have to be fixed if this patch goes on.)

However, now that I've messed around with the MSI-X logic in the IB
driver, I'm thinking that this whole thing is just pointless, and I
should just drop it and we should stick with the current way of enabling
MSI only if the driver wants it.  If you look at the logic in the mthca
driver you'll see what I mean.

So, anyone else think this is a good idea?  Votes for me to just drop it
and go back to hacking on the driver core instead?

Oh, and in looking at the drivers/pci/msi.c file, it could use some
cleanups to make it smaller and a bit less complex.  I've also seen some
complaints that it is very arch specific (x86 based).  But as no other
arches seem to want to support MSI, I don't really see any need to split
it up.  Any comments about this?

thanks,

greg k-h

-----------

PCI: remove access to pci_[enable|disable]_msi() for drivers

This is now handled by the PCI core.  A new function, pci_in_msi_mode() can
be used to tell if a PCI device has MSI enabled for it or not.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/infiniband/hw/mthca/mthca_main.c |    8 +++-----
 drivers/net/bnx2.c                       |    3 ++-
 drivers/net/e1000/e1000_main.c           |   12 ++++--------
 drivers/net/ixgb/ixgb_main.c             |   15 ++++++---------
 drivers/net/tg3.c                        |   20 ++------------------
 drivers/pci/msi.c                        |   25 +++++++++++++++++++++++++
 drivers/pci/pci.c                        |    4 +++-
 include/linux/pci.h                      |    2 ++

--- gregkh-2.6.orig/drivers/pci/msi.c	2005-06-06 16:16:25.000000000 -0700
+++ gregkh-2.6/drivers/pci/msi.c	2005-06-06 22:16:14.000000000 -0700
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
--- gregkh-2.6.orig/include/linux/pci.h	2005-06-06 16:16:25.000000000 -0700
+++ gregkh-2.6/include/linux/pci.h	2005-06-06 22:17:03.000000000 -0700
@@ -880,6 +880,7 @@
 };
 
 #ifndef CONFIG_PCI_MSI
+static inline int pci_in_msi_mode(struct pci_dev* dev) {return 0;}
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
 static inline void pci_disable_msi(struct pci_dev *dev) {}
@@ -888,6 +889,7 @@
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 #else
+extern int pci_in_msi_mode(struct pci_dev* dev);
 extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
 extern void pci_disable_msi(struct pci_dev *dev);
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
+++ gregkh-2.6/drivers/net/bnx2.c	2005-06-06 22:49:38.000000000 -0700
@@ -3888,7 +3888,7 @@
 		(CHIP_ID(bp) != CHIP_ID_5706_A1) &&
 		!disable_msi) {
 
-		if (pci_enable_msi(bp->pdev) == 0) {
+		if (pci_in_msi_mode(bp->pdev)) {
 			bp->flags |= USING_MSI_FLAG;
 			rc = request_irq(bp->pdev->irq, bnx2_msi, 0, dev->name,
 					dev);
@@ -3899,6 +3899,7 @@
 		}
 	}
 	else {
+		pci_disable_msi(bp->pdev);
 		rc = request_irq(bp->pdev->irq, bnx2_interrupt, SA_SHIRQ,
 				dev->name, dev);
 	}
--- gregkh-2.6.orig/drivers/net/e1000/e1000_main.c	2005-06-06 12:08:47.000000000 -0700
+++ gregkh-2.6/drivers/net/e1000/e1000_main.c	2005-06-06 22:56:45.000000000 -0700
@@ -321,12 +321,13 @@
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
-	}
+	} else
+		pci_disable_msi(adapter->pdev);
 #endif
 	if((err = request_irq(adapter->pdev->irq, &e1000_intr,
 		              SA_SHIRQ | SA_SAMPLE_RANDOM,
@@ -353,11 +354,6 @@
 
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
+++ gregkh-2.6/drivers/net/ixgb/ixgb_main.c	2005-06-06 23:02:18.000000000 -0700
@@ -237,11 +237,12 @@
 						  IXGB_STATUS_PCIX_MODE) ? TRUE : FALSE;
 	adapter->have_msi = TRUE;
 
-	if (!pcix)
-	   adapter->have_msi = FALSE;
-	else if((err = pci_enable_msi(adapter->pdev))) {
-		printk (KERN_ERR
-		 "Unable to allocate MSI interrupt Error: %d\n", err);
+	if (!pcix) {
+		adapter->have_msi = FALSE;
+		pci_disable_msi(adapter->pdev);
+	} else if (!pci_in_msi_mode(adapter->pdev)) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to allocate MSI interrupt\n");
 		adapter->have_msi = FALSE;
 		/* proceed to try to request regular interrupt */
 	}
@@ -291,11 +292,7 @@
 
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
+++ gregkh-2.6/drivers/net/tg3.c	2005-06-06 22:53:49.000000000 -0700
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
@@ -6063,15 +6062,12 @@
 		if (tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)
 			fn = tg3_interrupt_tagged;
 
+		pci_disable_msi(tp->pdev);
 		err = request_irq(tp->pdev->irq, fn,
 				  SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
 	}
 
 	if (err) {
-		if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-			pci_disable_msi(tp->pdev);
-			tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-		}
 		tg3_free_consistent(tp);
 		return err;
 	}
@@ -6106,10 +6102,6 @@
 
 	if (err) {
 		free_irq(tp->pdev->irq, dev);
-		if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-			pci_disable_msi(tp->pdev);
-			tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-		}
 		tg3_free_consistent(tp);
 		return err;
 	}
@@ -6121,10 +6113,6 @@
 			spin_lock_irq(&tp->lock);
 			spin_lock(&tp->tx_lock);
 
-			if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-				pci_disable_msi(tp->pdev);
-				tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-			}
 			tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
 			tg3_free_rings(tp);
 			tg3_free_consistent(tp);
@@ -6409,10 +6397,6 @@
 	spin_unlock_irq(&tp->lock);
 
 	free_irq(tp->pdev->irq, dev);
-	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
-		pci_disable_msi(tp->pdev);
-		tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
-	}
 
 	memcpy(&tp->net_stats_prev, tg3_get_stats(tp->dev),
 	       sizeof(tp->net_stats_prev));
--- gregkh-2.6.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-06 12:08:42.000000000 -0700
+++ gregkh-2.6/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-06 23:04:25.000000000 -0700
@@ -828,11 +828,13 @@
 	entries[1].entry = 1;
 	entries[2].entry = 2;
 
+	pci_disable_msi(mdev->pdev);
 	err = pci_enable_msix(mdev->pdev, entries, ARRAY_SIZE(entries));
 	if (err) {
 		if (err > 0)
 			mthca_info(mdev, "Only %d MSI-X vectors available, "
 				   "not using MSI-X\n", err);
+		pci_enable_msi(mdev->pdev);
 		return err;
 	}
 
@@ -1001,7 +1003,7 @@
 	if (msi_x && !mthca_enable_msi_x(mdev))
 		mdev->mthca_flags |= MTHCA_FLAG_MSI_X;
 	if (msi && !(mdev->mthca_flags & MTHCA_FLAG_MSI_X) &&
-	    !pci_enable_msi(pdev))
+	    pci_in_msi_mode(pdev))
 		mdev->mthca_flags |= MTHCA_FLAG_MSI;
 
 	sema_init(&mdev->cmd.hcr_sem, 1);
@@ -1076,8 +1078,6 @@
 err_free_dev:
 	if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 		pci_disable_msix(pdev);
-	if (mdev->mthca_flags & MTHCA_FLAG_MSI)
-		pci_disable_msi(pdev);
 
 	ib_dealloc_device(&mdev->ib_dev);
 
@@ -1125,8 +1125,6 @@
 
 		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 			pci_disable_msix(pdev);
-		if (mdev->mthca_flags & MTHCA_FLAG_MSI)
-			pci_disable_msi(pdev);
 
 		ib_dealloc_device(&mdev->ib_dev);
 		mthca_release_regions(pdev, mdev->mthca_flags &

