Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVJFX6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVJFX6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVJFX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:58:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:15249 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932090AbVJFX6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:58:20 -0400
Date: Thu, 6 Oct 2005 18:58:18 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 21/22] PCI Error Recovery: e1000 network device driver
Message-ID: <20051006235818.GV29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI Error Recovery: e1000 network device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel gigabit
ethernet e1000 device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1 
 drivers/net/Kconfig                  |    8 ++
 drivers/net/e1000/e1000_main.c       |  103 ++++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 1 deletion(-)

Index: linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/configs/pSeries_defconfig	2005-10-06 17:47:05.582635736 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig	2005-10-06 17:47:12.737631817 -0500
@@ -593,6 +593,7 @@
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
 # CONFIG_E1000_NAPI is not set
+CONFIG_E1000_EEH_RECOVERY=y
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
Index: linux-2.6.14-rc2-git6/drivers/net/Kconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/net/Kconfig	2005-10-06 17:47:05.582635736 -0500
+++ linux-2.6.14-rc2-git6/drivers/net/Kconfig	2005-10-06 17:47:12.742631116 -0500
@@ -1856,6 +1856,14 @@
 
 	  If in doubt, say N.
 
+config E1000_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on E1000 && PPC_PSERIES
+   help
+      If you say Y here, the driver will be able to recover from
+      PCI bus errors on many PowerPC platforms. IBM pSeries users
+      should answer Y.
+
 config MYRI_SBUS
 	tristate "MyriCOM Gigabit Ethernet support"
 	depends on SBUS
Index: linux-2.6.14-rc2-git6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/net/e1000/e1000_main.c	2005-10-06 17:47:05.582635736 -0500
+++ linux-2.6.14-rc2-git6/drivers/net/e1000/e1000_main.c	2005-10-06 17:47:36.880244362 -0500
@@ -172,6 +172,18 @@
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
+#ifdef CONFIG_E1000_EEH_RECOVERY
+static int e1000_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state);
+static int e1000_io_slot_reset(struct pci_dev *pdev);
+static void e1000_io_resume(struct pci_dev *pdev);
+
+static struct pci_error_handlers e1000_err_handler = {
+	.error_detected = e1000_io_error_detected,
+	.slot_reset = e1000_io_slot_reset,
+	.resume = e1000_io_resume,
+};
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
@@ -184,8 +196,11 @@
 	/* Power Managment Hooks */
 #ifdef CONFIG_PM
 	.suspend  = e1000_suspend,
-	.resume   = e1000_resume
+	.resume   = e1000_resume,
 #endif
+#ifdef CONFIG_E1000_EEH_RECOVERY
+	.err_handler = &e1000_err_handler,
+#endif /* CONFIG_E1000_EEH_RECOVERY */
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -2446,6 +2461,12 @@
 
 #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
 
+#ifdef CONFIG_E1000_EEH_RECOVERY
+	/* Prevent stats update while adapter is being reset */
+	if (adapter->link_speed == 0)
+		return;
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 	spin_lock_irqsave(&adapter->stats_lock, flags);
 
 	/* these counters are modified from e1000_adjust_tbi_stats,
@@ -3791,4 +3812,90 @@
 }
 #endif
 
+#ifdef CONFIG_E1000_EEH_RECOVERY
+
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
+	if (0 != PCI_FUNC (pdev->devfn))
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
+	if (netif_running(netdev)) {
+		if (e1000_up(adapter)) {
+			printk("e1000: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+
+	if (adapter->hw.mac_type >= e1000_82540 &&
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
+	mod_timer(&adapter->watchdog_timer, jiffies);
+}
+
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 /* e1000_main.c */
