Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVKGVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVKGVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVKGVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:39:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29089 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965159AbVKGVj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:39:57 -0500
Date: Mon, 7 Nov 2005 15:39:54 -0600
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 7/7]: Revised [PATCH 32/42]: RFC: Add compile-time config options
Message-ID: <20051107213954.GN19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107195727.GF19593@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:57:27PM -0600, linas was heard to remark:
> On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> > 3) realy strong typing that sparse can detect.

This OPTIONAL/RFC patch adds ifdef's around the PCI error recovery code in the 
various device drivers. This patch is "optional" in that its a little bit 
messy, but it does solve a little problem.

-- The good news: this gives some users (e.g. embeddd systems) the option 
	of not compiling in this code, thus making thier device drivers a tiny 
	bit smaller.

-- The bad news: This also clutters up the drivers with extraneous markup 
   and the config process with yet another config.

Please apply if you agree with the need for this patch :)

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-mm1/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/scsi/ipr.c	2005-11-07 15:02:00.639392946 -0600
+++ linux-2.6.14-mm1/drivers/scsi/ipr.c	2005-11-07 15:02:20.029668601 -0600
@@ -5329,6 +5329,8 @@
 }
 
 /* --------------- PCI Error Recovery infrastructure ----------- */
+#ifdef CONFIG_PCI_ERR_RECOVERY
+
 /** If the PCI slot is frozen, hold off all i/o
  *  activity; then, as soon as the slot is available again,
  *  initiate an adapter reset.
@@ -5414,6 +5416,7 @@
 	return PERS_RESULT_NEED_RESET;
 }
 
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 /* ------------- end of PCI Error Recovery suport ----------- */
 
 /**
@@ -6153,10 +6156,12 @@
 };
 MODULE_DEVICE_TABLE(pci, ipr_pci_table);
 
+#ifdef CONFIG_PCI_ERR_RECOVERY
 static struct pci_error_handlers ipr_err_handler = {
 	.error_detected = ipr_eeh_error_detected,
 	.slot_reset = ipr_eeh_slot_reset,
 };
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 static struct pci_driver ipr_driver = {
 	.name = IPR_NAME,
@@ -6164,7 +6169,9 @@
 	.probe = ipr_probe,
 	.remove = ipr_remove,
 	.shutdown = ipr_shutdown,
+#ifdef CONFIG_PCI_ERR_RECOVERY
 	.err_handler = &ipr_err_handler,
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 };
 
 /**
Index: linux-2.6.14-mm1/drivers/pci/Kconfig
===================================================================
--- linux-2.6.14-mm1.orig/drivers/pci/Kconfig	2005-11-07 13:55:23.869498177 -0600
+++ linux-2.6.14-mm1/drivers/pci/Kconfig	2005-11-07 15:02:20.030668460 -0600
@@ -13,6 +13,21 @@
 
 	   If you don't know what to do here, say N.
 
+config PCI_ERR_RECOVERY
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
Index: linux-2.6.14-mm1/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-11-07 15:02:08.152337375 -0600
+++ linux-2.6.14-mm1/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-11-07 15:02:20.034667898 -0600
@@ -763,6 +763,7 @@
  */
 static void sym_eh_timeout(u_long p) { __sym_eh_done((struct scsi_cmnd *)p, 1); }
 
+#ifdef CONFIG_PCI_ERR_RECOVERY
 static void sym_eeh_timeout(u_long p)
 {
 	struct sym_eh_wait *ep = (struct sym_eh_wait *) p;
@@ -781,6 +782,7 @@
 
 	complete(&ep->done);
 }
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 /*
  *  Generic method for our eh processing.
@@ -823,6 +825,7 @@
 	/* Try to proceed the operation we have been asked for */
 	sts = -1;
 
+#ifdef CONFIG_PCI_ERR_RECOVERY
 	/* We may be in an error condition because the PCI bus
 	 * went down. In this case, we need to wait until the
 	 * PCI bus is reset, the card is reset, and only then
@@ -850,6 +853,7 @@
 		}
 		np->s.io_reset_wait = NULL;
 	}
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 	switch(op) {
 	case SYM_EH_ABORT:
@@ -1971,6 +1975,7 @@
 }
 
 /* ------------- PCI Error Recovery infrastructure -------------- */
+#ifdef CONFIG_PCI_ERR_RECOVERY
 /** sym2_io_error_detected() is called when PCI error is detected */
 static pers_result_t sym2_io_error_detected (struct pci_dev *pdev, pci_channel_state_t state)
 {
@@ -2021,6 +2026,7 @@
 	np->s.io_state = pci_channel_io_normal;
 	sym_eeh_done (np->s.io_reset_wait);
 }
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 /*
  * Driver host template.
@@ -2275,18 +2281,22 @@
 
 MODULE_DEVICE_TABLE(pci, sym2_id_table);
 
+#ifdef CONFIG_PCI_ERR_RECOVERY
 static struct pci_error_handlers sym2_err_handler = {
 	.error_detected = sym2_io_error_detected,
 	.slot_reset = sym2_io_slot_reset,
 	.resume = sym2_io_resume,
 };
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 static struct pci_driver sym2_driver = {
 	.name		= NAME53C8XX,
 	.id_table	= sym2_id_table,
 	.probe		= sym2_probe,
 	.remove		= __devexit_p(sym2_remove),
+#ifdef CONFIG_PCI_ERR_RECOVERY
 	.err_handler = &sym2_err_handler,
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 };
 
 static int __init sym2_init(void)
Index: linux-2.6.14-mm1/drivers/net/e100.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/net/e100.c	2005-11-07 15:02:11.120920287 -0600
+++ linux-2.6.14-mm1/drivers/net/e100.c	2005-11-07 15:02:20.038667336 -0600
@@ -2466,6 +2466,7 @@
 
 
 /* ------------------ PCI Error Recovery infrastructure  -------------- */
+#ifdef CONFIG_PCI_ERR_RECOVERY
 /** e100_io_error_detected() is called when PCI error is detected */
 static pers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 {
@@ -2532,6 +2533,7 @@
 	.slot_reset = e100_io_slot_reset,
 	.resume = e100_io_resume,
 };
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 
 static struct pci_driver e100_driver = {
@@ -2544,7 +2546,9 @@
 	.resume =       e100_resume,
 #endif
 	.shutdown =	e100_shutdown,
+#ifdef CONFIG_PCI_ERR_RECOVERY
 	.err_handler = &e100_err_handler,
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 };
 
 static int __init e100_init_module(void)
Index: linux-2.6.14-mm1/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/net/e1000/e1000_main.c	2005-11-07 15:02:12.811682734 -0600
+++ linux-2.6.14-mm1/drivers/net/e1000/e1000_main.c	2005-11-07 15:02:20.071662701 -0600
@@ -206,6 +206,7 @@
 void e1000_rx_schedule(void *data);
 #endif
 
+#ifdef CONFIG_PCI_ERR_RECOVERY
 static pers_result_t e1000_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state);
 static pers_result_t e1000_io_slot_reset(struct pci_dev *pdev);
 static void e1000_io_resume(struct pci_dev *pdev);
@@ -215,6 +216,7 @@
 	.slot_reset = e1000_io_slot_reset,
 	.resume = e1000_io_resume,
 };
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 /* Exported from other modules */
 
@@ -230,7 +232,9 @@
 	.suspend  = e1000_suspend,
 	.resume   = e1000_resume,
 #endif
+#ifdef CONFIG_PCI_ERR_RECOVERY
 	.err_handler = &e1000_err_handler,
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -4375,6 +4379,7 @@
 #endif
 
 /* --------------- PCI Error Recovery infrastructure ------------ */
+#ifdef CONFIG_PCI_ERR_RECOVERY
 /** e1000_io_error_detected() is called when PCI error is detected */
 static pers_result_t e1000_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 {
@@ -4457,5 +4462,6 @@
 	if(netif_running(netdev))
 		mod_timer(&adapter->watchdog_timer, jiffies);
 }
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 /* e1000_main.c */
Index: linux-2.6.14-mm1/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/net/ixgb/ixgb_main.c	2005-11-07 15:02:14.779406268 -0600
+++ linux-2.6.14-mm1/drivers/net/ixgb/ixgb_main.c	2005-11-07 15:02:20.075662139 -0600
@@ -132,6 +132,7 @@
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
+#ifdef CONFIG_PCI_ERR_RECOVERY
 static pers_result_t ixgb_io_error_detected (struct pci_dev *pdev, pci_channel_state_t state);
 static pers_result_t ixgb_io_slot_reset (struct pci_dev *pdev);
 static void ixgb_io_resume (struct pci_dev *pdev);
@@ -141,6 +142,7 @@
 	.slot_reset = ixgb_io_slot_reset,
 	.resume = ixgb_io_resume,
 };
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 /* Exported from other modules */
 
@@ -151,8 +153,9 @@
 	.id_table = ixgb_pci_tbl,
 	.probe    = ixgb_probe,
 	.remove   = __devexit_p(ixgb_remove),
+#ifdef CONFIG_PCI_ERR_RECOVERY
 	.err_handler = &ixgb_err_handler,
-
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -2146,6 +2149,7 @@
 #endif
 
 /* -------------- PCI Error Recovery infrastructure ---------------- */
+#ifdef CONFIG_PCI_ERR_RECOVERY
 /** ixgb_io_error_detected() is called when PCI error is detected */
 static pers_result_t ixgb_io_error_detected (struct pci_dev *pdev, pci_channel_state_t state)
 {
@@ -2210,5 +2214,6 @@
 	memset(&adapter->stats, 0, sizeof(struct ixgb_hw_stats));
 	ixgb_update_stats(adapter);
 }
+#endif /* CONFIG_PCI_ERR_RECOVERY */
 
 /* ixgb_main.c */
