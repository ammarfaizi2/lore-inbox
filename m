Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbVKDA7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbVKDA7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVKDAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:54:41 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:22420
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161032AbVKDAyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:18 -0500
Date: Thu, 3 Nov 2005 18:54:17 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 32/42]: RFC: Add compile-time config options
Message-ID: <20051104005417.GA27098@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

32-pci-error-recovery_config-option.patch

This OPTIONAL/RFC patch adds ifdef's around the PCI error recovery code in the 
various device drivers. This patch is "optional" in that its a little bit 
messy, but it does solve a little problem.

-- The good news: this gives some users (e.g. embeddd systems) the option 
	of not compiling in this code, thus making thier device drivers a tiny 
	bit smaller.

-- The bad news: This also clutters up the drivers with extraneous markup 
   and the config process with yet another config.

I don't know if this patch is worth it.  Apply or reject, as desired ... 
Its up to you ... :-)

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-git3/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/scsi/ipr.c	2005-11-02 14:43:52.782806465 -0600
+++ linux-2.6.14-git3/drivers/scsi/ipr.c	2005-11-02 14:44:04.167209911 -0600
@@ -5329,6 +5329,8 @@
 }
 
 /* --------------- PCI Error Recovery infrastructure ----------- */
+#ifdef CONFIG_PCIERR_RECOVERY
+
 /** If the PCI slot is frozen, hold off all i/o
  *  activity; then, as soon as the slot is available again,
  *  initiate an adapter reset.
@@ -5414,6 +5416,7 @@
 	return PCIERR_RESULT_NEED_RESET;
 }
 
+#endif /* CONFIG_PCIERR_RECOVERY */
 /* ------------- end of PCI Error Recovery suport ----------- */
 
 /**
@@ -6153,10 +6156,12 @@
 };
 MODULE_DEVICE_TABLE(pci, ipr_pci_table);
 
+#ifdef CONFIG_PCIERR_RECOVERY
 static struct pci_error_handlers ipr_err_handler = {
 	.error_detected = ipr_eeh_error_detected,
 	.slot_reset = ipr_eeh_slot_reset,
 };
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 static struct pci_driver ipr_driver = {
 	.name = IPR_NAME,
@@ -6164,7 +6169,9 @@
 	.probe = ipr_probe,
 	.remove = ipr_remove,
 	.shutdown = ipr_shutdown,
+#ifdef CONFIG_PCIERR_RECOVERY
 	.err_handler = &ipr_err_handler,
+#endif /* CONFIG_PCIERR_RECOVERY */
 };
 
 /**
Index: linux-2.6.14-git3/drivers/pci/Kconfig
===================================================================
--- linux-2.6.14-git3.orig/drivers/pci/Kconfig	2005-11-02 14:28:48.597580036 -0600
+++ linux-2.6.14-git3/drivers/pci/Kconfig	2005-11-02 14:44:04.172209210 -0600
@@ -13,6 +13,21 @@
 
 	   If you don't know what to do here, say N.
 
+config PCIERR_RECOVERY
+	bool "PCI Error Recovery support"
+	depends on PCI
+	depends on PPC_PSERIES
+	default y
+	help
+	   PCI Error Recovery is a mechanism by which crashed/hung 
+		PCI adapters are automatically detected and rebooted without
+		otherwise disturbing the operation of the system.  Support
+		for this recovery requires special PCI bridge chips (some
+		PCI-E chips may have this support) as well as support in 
+		the device drivers (not all device drivers can handle this).
+
+	   When in doubt, say Y.
+
 config PCI_LEGACY_PROC
 	bool "Legacy /proc/pci interface"
 	depends on PCI
Index: linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-11-02 14:43:56.084343457 -0600
+++ linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-11-02 14:44:04.195205985 -0600
@@ -763,6 +763,7 @@
  */
 static void sym_eh_timeout(u_long p) { __sym_eh_done((struct scsi_cmnd *)p, 1); }
 
+#ifdef CONFIG_PCIERR_RECOVERY
 static void sym_eeh_timeout(u_long p)
 {
 	struct sym_eh_wait *ep = (struct sym_eh_wait *) p;
@@ -781,6 +782,7 @@
 
 	complete(&ep->done);
 }
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 /*
  *  Generic method for our eh processing.
@@ -823,6 +825,7 @@
 	/* Try to proceed the operation we have been asked for */
 	sts = -1;
 
+#ifdef CONFIG_PCIERR_RECOVERY
 	/* We may be in an error condition because the PCI bus
 	 * went down. In this case, we need to wait until the
 	 * PCI bus is reset, the card is reset, and only then
@@ -850,6 +853,7 @@
 		}
 		np->s.io_reset_wait = NULL;
 	}
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 	switch(op) {
 	case SYM_EH_ABORT:
@@ -1971,6 +1975,7 @@
 }
 
 /* ------------- PCI Error Recovery infrastructure -------------- */
+#ifdef CONFIG_PCIERR_RECOVERY
 /** sym2_io_error_detected() is called when PCI error is detected */
 static int sym2_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state)
 {
@@ -2021,6 +2026,7 @@
 	np->s.io_state = pci_channel_io_normal;
 	sym_eeh_done (np->s.io_reset_wait);
 }
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 /*
  * Driver host template.
@@ -2275,18 +2281,22 @@
 
 MODULE_DEVICE_TABLE(pci, sym2_id_table);
 
+#ifdef CONFIG_PCIERR_RECOVERY
 static struct pci_error_handlers sym2_err_handler = {
 	.error_detected = sym2_io_error_detected,
 	.slot_reset = sym2_io_slot_reset,
 	.resume = sym2_io_resume,
 };
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 static struct pci_driver sym2_driver = {
 	.name		= NAME53C8XX,
 	.id_table	= sym2_id_table,
 	.probe		= sym2_probe,
 	.remove		= __devexit_p(sym2_remove),
+#ifdef CONFIG_PCIERR_RECOVERY
 	.err_handler = &sym2_err_handler,
+#endif /* CONFIG_PCIERR_RECOVERY */
 };
 
 static int __init sym2_init(void)
Index: linux-2.6.14-git3/drivers/net/e100.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/net/e100.c	2005-11-02 14:43:58.890949857 -0600
+++ linux-2.6.14-git3/drivers/net/e100.c	2005-11-02 14:44:04.222202199 -0600
@@ -2466,6 +2466,7 @@
 
 
 /* ------------------ PCI Error Recovery infrastructure  -------------- */
+#ifdef CONFIG_PCIERR_RECOVERY
 /** e100_io_error_detected() is called when PCI error is detected */
 static int e100_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state)
 {
@@ -2532,6 +2533,7 @@
 	.slot_reset = e100_io_slot_reset,
 	.resume = e100_io_resume,
 };
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 
 static struct pci_driver e100_driver = {
@@ -2544,7 +2546,9 @@
 	.resume =       e100_resume,
 #endif
 	.shutdown =	e100_shutdown,
+#ifdef CONFIG_PCIERR_RECOVERY
 	.err_handler = &e100_err_handler,
+#endif /* CONFIG_PCIERR_RECOVERY */
 };
 
 static int __init e100_init_module(void)
Index: linux-2.6.14-git3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/net/e1000/e1000_main.c	2005-11-02 14:44:00.730691851 -0600
+++ linux-2.6.14-git3/drivers/net/e1000/e1000_main.c	2005-11-02 14:44:04.266196029 -0600
@@ -206,6 +206,7 @@
 void e1000_rx_schedule(void *data);
 #endif
 
+#ifdef CONFIG_PCIERR_RECOVERY
 static int e1000_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state);
 static int e1000_io_slot_reset(struct pci_dev *pdev);
 static void e1000_io_resume(struct pci_dev *pdev);
@@ -215,6 +216,7 @@
 	.slot_reset = e1000_io_slot_reset,
 	.resume = e1000_io_resume,
 };
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 /* Exported from other modules */
 
@@ -230,7 +232,9 @@
 	.suspend  = e1000_suspend,
 	.resume   = e1000_resume,
 #endif
+#ifdef CONFIG_PCIERR_RECOVERY
 	.err_handler = &e1000_err_handler,
+#endif /* CONFIG_PCIERR_RECOVERY */
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -4374,6 +4378,7 @@
 #endif
 
 /* --------------- PCI Error Recovery infrastructure ------------ */
+#ifdef CONFIG_PCIERR_RECOVERY
 /** e1000_io_error_detected() is called when PCI error is detected */
 static int e1000_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state)
 {
@@ -4456,5 +4461,6 @@
 	if(netif_running(netdev))
 		mod_timer(&adapter->watchdog_timer, jiffies);
 }
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 /* e1000_main.c */
Index: linux-2.6.14-git3/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/net/ixgb/ixgb_main.c	2005-11-02 14:44:02.380460486 -0600
+++ linux-2.6.14-git3/drivers/net/ixgb/ixgb_main.c	2005-11-02 14:44:04.289192804 -0600
@@ -132,6 +132,7 @@
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
+#ifdef CONFIG_PCIERR_RECOVERY
 static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state);
 static int ixgb_io_slot_reset (struct pci_dev *pdev);
 static void ixgb_io_resume (struct pci_dev *pdev);
@@ -141,6 +142,7 @@
 	.slot_reset = ixgb_io_slot_reset,
 	.resume = ixgb_io_resume,
 };
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 /* Exported from other modules */
 
@@ -151,8 +153,9 @@
 	.id_table = ixgb_pci_tbl,
 	.probe    = ixgb_probe,
 	.remove   = __devexit_p(ixgb_remove),
+#ifdef CONFIG_PCIERR_RECOVERY
 	.err_handler = &ixgb_err_handler,
-
+#endif /* CONFIG_PCIERR_RECOVERY */
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -2146,6 +2149,7 @@
 #endif
 
 /* -------------- PCI Error Recovery infrastructure ---------------- */
+#ifdef CONFIG_PCIERR_RECOVERY
 /** ixgb_io_error_detected() is called when PCI error is detected */
 static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state)
 {
@@ -2210,5 +2214,6 @@
 	memset(&adapter->stats, 0, sizeof(struct ixgb_hw_stats));
 	ixgb_update_stats(adapter);
 }
+#endif /* CONFIG_PCIERR_RECOVERY */
 
 /* ixgb_main.c */
