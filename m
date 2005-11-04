Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbVKDAzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbVKDAzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbVKDAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:54:47 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:18580
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161019AbVKDAyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:05 -0500
Date: Thu, 3 Nov 2005 18:54:04 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 30/42]: ethernet: add PCI error recovery to e1000 dev driver
Message-ID: <20051104005404.GA27082@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel gigabit
ethernet e1000 device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
Index: linux-2.6.14-git3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/net/e1000/e1000_main.c	2005-11-02 14:28:50.471317390 -0600
+++ linux-2.6.14-git3/drivers/net/e1000/e1000_main.c	2005-11-02 14:44:00.730691851 -0600
@@ -206,6 +206,16 @@
 void e1000_rx_schedule(void *data);
 #endif
 
+static int e1000_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state);
+static int e1000_io_slot_reset(struct pci_dev *pdev);
+static void e1000_io_resume(struct pci_dev *pdev);
+
+static struct pci_error_handlers e1000_err_handler = {
+	.error_detected = e1000_io_error_detected,
+	.slot_reset = e1000_io_slot_reset,
+	.resume = e1000_io_resume,
+};
+
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
@@ -218,8 +228,9 @@
 	/* Power Managment Hooks */
 #ifdef CONFIG_PM
 	.suspend  = e1000_suspend,
-	.resume   = e1000_resume
+	.resume   = e1000_resume,
 #endif
+	.err_handler = &e1000_err_handler,
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -2937,6 +2948,10 @@
 
 #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
 
+	/* Prevent stats update while adapter is being reset */
+	if (adapter->link_speed == 0)
+		return;
+
 	spin_lock_irqsave(&adapter->stats_lock, flags);
 
 	/* these counters are modified from e1000_adjust_tbi_stats,
@@ -4358,4 +4373,88 @@
 }
 #endif
 
+/* --------------- PCI Error Recovery infrastructure ------------ */
+/** e1000_io_error_detected() is called when PCI error is detected */
+static int e1000_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+
+	if (netif_running(netdev))
+		e1000_down(adapter);
+
+	/* Request a slot slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** e1000_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch.
+ *  Implementation resembles the first-half of the
+ *  e1000_resume routine.
+ */
+static int e1000_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "e1000: Cannot re-enable PCI device after reset.\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	pci_enable_wake(pdev, 3, 0);
+	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
+
+	/* Perform card reset only on one instance of the card */
+	if(0 != PCI_FUNC (pdev->devfn))
+		return PCIERR_RESULT_RECOVERED;
+
+	e1000_reset(adapter);
+	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** e1000_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ *  Implementation resembles the second-half of the
+ *  e1000_resume routine.
+ */
+static void e1000_io_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+	uint32_t manc, swsm;
+
+	if(netif_running(netdev)) {
+		if (e1000_up(adapter)) {
+			printk("e1000: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+
+	if(adapter->hw.mac_type >= e1000_82540 &&
+	    adapter->hw.media_type == e1000_media_type_copper) {
+		manc = E1000_READ_REG(&adapter->hw, MANC);
+		manc &= ~(E1000_MANC_ARP_EN);
+		E1000_WRITE_REG(&adapter->hw, MANC, manc);
+	}
+
+	switch(adapter->hw.mac_type) {
+	case e1000_82573:
+		swsm = E1000_READ_REG(&adapter->hw, SWSM);
+		E1000_WRITE_REG(&adapter->hw, SWSM,
+				swsm | E1000_SWSM_DRV_LOAD);
+		break;
+	default:
+		break;
+	}
+
+	if(netif_running(netdev))
+		mod_timer(&adapter->watchdog_timer, jiffies);
+}
+
 /* e1000_main.c */
