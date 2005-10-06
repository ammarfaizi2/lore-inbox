Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVJFX7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVJFX7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVJFX7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:59:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53948 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932094AbVJFX7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:59:21 -0400
Date: Thu, 6 Oct 2005 18:59:19 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 22/22] PCI Error Recovery: ixgb network device driver
Message-ID: <20051006235919.GW29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI Error Recovery: ixgb network device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ten-gigabit
ethernet ixgb device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1 
 drivers/net/Kconfig                  |    8 +++
 drivers/net/ixgb/ixgb_main.c         |   78 +++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

Index: linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/configs/pSeries_defconfig	2005-10-05 16:55:25.109651477 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig	2005-10-05 16:55:26.410469062 -0500
@@ -610,6 +610,7 @@
 #
 CONFIG_IXGB=m
 # CONFIG_IXGB_NAPI is not set
+CONFIG_IXGB_EEH_RECOVERY=y
 CONFIG_S2IO=m
 # CONFIG_S2IO_NAPI is not set
 # CONFIG_2BUFF_MODE is not set
Index: linux-2.6.14-rc2-git6/drivers/net/Kconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/net/Kconfig	2005-10-05 16:55:25.114650776 -0500
+++ linux-2.6.14-rc2-git6/drivers/net/Kconfig	2005-10-05 16:55:26.414468501 -0500
@@ -2195,6 +2195,14 @@
 
 	  If in doubt, say N.
 
+config IXGB_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on IXGB && PPC_PSERIES
+   help
+      If you say Y here, the driver will be able to recover from
+      PCI bus errors on many PowerPC platforms. IBM pSeries users
+      should answer Y.
+
 config S2IO
 	tristate "S2IO 10Gbe XFrame NIC"
 	depends on PCI
Index: linux-2.6.14-rc2-git6/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/net/ixgb/ixgb_main.c	2005-10-05 16:54:33.590875982 -0500
+++ linux-2.6.14-rc2-git6/drivers/net/ixgb/ixgb_main.c	2005-10-05 17:00:08.092967727 -0500
@@ -132,6 +132,18 @@
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state);
+static int ixgb_io_slot_reset (struct pci_dev *pdev);
+static void ixgb_io_resume (struct pci_dev *pdev);
+
+static struct pci_error_handlers ixgb_err_handler = {
+	.error_detected = ixgb_io_error_detected,
+	.slot_reset = ixgb_io_slot_reset,
+	.resume = ixgb_io_resume,
+};
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 /* Exported from other modules */
 
 extern void ixgb_check_options(struct ixgb_adapter *adapter);
@@ -141,6 +153,10 @@
 	.id_table = ixgb_pci_tbl,
 	.probe    = ixgb_probe,
 	.remove   = __devexit_p(ixgb_remove),
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+	.err_handler = &ixgb_err_handler,
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -1653,8 +1669,16 @@
 	unsigned int i;
 #endif
 
+#ifdef XXX_CONFIG_IXGB_EEH_RECOVERY
+	if(unlikely(icr==EEH_IO_ERROR_VALUE(4))) {
+		if (eeh_slot_is_isolated (adapter->pdev))
+		// disable_irq_nosync (adapter->pdev->irq);
+		return IRQ_NONE;      /* Not our interrupt */
+	}
+#else
 	if(unlikely(!icr))
 		return IRQ_NONE;  /* Not our interrupt */
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
 
 	if(unlikely(icr & (IXGB_INT_RXSEQ | IXGB_INT_LSC))) {
 		mod_timer(&adapter->watchdog_timer, jiffies);
@@ -2124,4 +2148,71 @@
 }
 #endif
 
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+
+/** ixgb_io_error_detected() is called when PCI error is detected */
+static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter = netdev->priv;
+
+	if(netif_running(netdev))
+		ixgb_down(adapter, TRUE);
+
+	/* Request a slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** ixgb_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch.
+ *  Implementation resembles the first-half of the
+ *  ixgb_resume routine.
+ */
+static int ixgb_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter = netdev->priv;
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "ixgb: Cannot re-enable PCI device after reset.\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Perform card reset only on one instance of the card */
+	if (0 != PCI_FUNC (pdev->devfn))
+		return PCIERR_RESULT_RECOVERED;
+
+	ixgb_reset(adapter);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** ixgb_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ *  Implementation resembles the second-half of the
+ *  ixgb_resume routine.
+ */
+static void ixgb_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter = netdev->priv;
+
+	if(netif_running(netdev)) {
+		if(ixgb_up(adapter)) {
+			printk ("ixgb: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+	mod_timer(&adapter->watchdog_timer, jiffies);
+
+	/* Reading all-ff's from the adapter will completely hose
+	 * the counts and statistics. So just clear them out */
+	memset(&adapter->stats, 0, sizeof(struct ixgb_hw_stats));
+	ixgb_update_stats(adapter);
+}
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 /* ixgb_main.c */
