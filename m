Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVF2BqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVF2BqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVF2Boy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:44:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26765 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262291AbVF1X7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:59:14 -0400
Date: Tue, 28 Jun 2005 18:59:08 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 6/13]: PCI Err: ixgb ethernet driver recovery
Message-ID: <20050628235908.GA6402@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-6-ixgb.patch

Adds PCI Error recovery callbacks to the Intel 10-gigabit ethernet
ixgb device driver. Lightly tested, works.

Signed-off-by: Linas Vepstas <linas@linas.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-6-ixgb.patch"

--- linux-2.6.12-git10/drivers/net/ixgb/ixgb_main.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/net/ixgb/ixgb_main.c	2005-06-27 15:57:48.000000000 -0500
@@ -128,6 +128,12 @@ static void ixgb_restore_vlan(struct ixg
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+static int ixgb_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state);
+static int ixgb_io_slot_reset (struct pci_dev *pdev);
+static void ixgb_io_resume (struct pci_dev *pdev);
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 /* Exported from other modules */
 
 extern void ixgb_check_options(struct ixgb_adapter *adapter);
@@ -137,6 +143,14 @@ static struct pci_driver ixgb_driver = {
 	.id_table = ixgb_pci_tbl,
 	.probe    = ixgb_probe,
 	.remove   = __devexit_p(ixgb_remove),
+#ifdef CONFIG_IXGB_EEH_RECOVERY
+	.err_handler = {
+		.error_detected = ixgb_io_error_detected,
+		.slot_reset = ixgb_io_slot_reset,
+		.resume = ixgb_io_resume,
+	},
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -2119,4 +2133,67 @@ static void ixgb_netpoll(struct net_devi
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
+}
+#endif /* CONFIG_IXGB_EEH_RECOVERY */
+
 /* ixgb_main.c */
--- linux-2.6.12-git10/drivers/net/Kconfig.linas-orig	2005-06-22 15:26:13.000000000 -0500
+++ linux-2.6.12-git10/drivers/net/Kconfig	2005-06-27 14:41:46.000000000 -0500
@@ -2146,6 +2146,14 @@ config IXGB_NAPI
 
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
--- linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig	2005-06-27 14:43:24.000000000 -0500
@@ -580,6 +580,7 @@ CONFIG_TIGON3=y
 #
 CONFIG_IXGB=m
 # CONFIG_IXGB_NAPI is not set
+CONFIG_IXGB_EEH_RECOVERY=y
 CONFIG_S2IO=m
 # CONFIG_S2IO_NAPI is not set
 # CONFIG_2BUFF_MODE is not set

--XsQoSWH+UP9D9v3l--
