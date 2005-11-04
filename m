Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbVKDAzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbVKDAzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbVKDAyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:54:45 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:20884
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161026AbVKDAyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:12 -0500
Date: Thu, 3 Nov 2005 18:54:11 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 31/42]: ethernet: add PCI error recovery to ixgb dev driver
Message-ID: <20051104005411.GA27090@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ten-gigabit
ethernet ixgb device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
Index: linux-2.6.14-git3/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/net/ixgb/ixgb_main.c	2005-11-02 14:28:49.225492020 -0600
+++ linux-2.6.14-git3/drivers/net/ixgb/ixgb_main.c	2005-11-02 14:44:02.380460486 -0600
@@ -132,6 +132,16 @@
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
+static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state);
+static int ixgb_io_slot_reset (struct pci_dev *pdev);
+static void ixgb_io_resume (struct pci_dev *pdev);
+
+static struct pci_error_handlers ixgb_err_handler = {
+	.error_detected = ixgb_io_error_detected,
+	.slot_reset = ixgb_io_slot_reset,
+	.resume = ixgb_io_resume,
+};
+
 /* Exported from other modules */
 
 extern void ixgb_check_options(struct ixgb_adapter *adapter);
@@ -141,6 +151,8 @@
 	.id_table = ixgb_pci_tbl,
 	.probe    = ixgb_probe,
 	.remove   = __devexit_p(ixgb_remove),
+	.err_handler = &ixgb_err_handler,
+
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -1654,8 +1666,16 @@
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
@@ -2125,4 +2145,70 @@
 }
 #endif
 
+/* -------------- PCI Error Recovery infrastructure ---------------- */
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
+	if(netif_running(netdev))
+		mod_timer(&adapter->watchdog_timer, jiffies);
+
+	/* Reading all-ff's from the adapter will completely hose
+	 * the counts and statistics. So just clear them out */
+	memset(&adapter->stats, 0, sizeof(struct ixgb_hw_stats));
+	ixgb_update_stats(adapter);
+}
+
 /* ixgb_main.c */
