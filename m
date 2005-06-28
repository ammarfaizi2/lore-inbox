Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVF2BqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVF2BqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVF2Bpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:45:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12173 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262331AbVF1X7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:59:02 -0400
Date: Tue, 28 Jun 2005 18:58:55 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 5/13]: PCI Err: e1000 ethernet driver recovery
Message-ID: <20050628235855.GA6389@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-5-e1000.patch

Provide PCI Error recovery callbacks for the Intel gigabit E1000
ethernet driver.  Tested with 2-port card.

This patch shares some common logic with the power-management
shutdown and resume code; one could split up the power managment
code so that both this and that were even more similar, but 
there  didn't seem to be much to gain from doing this.

Signed-off-by: Linas Vepstas <linas@linas.org>

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-5-e1000.patch"

--- linux-2.6.12-git10/drivers/net/e1000/e1000_main.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/net/e1000/e1000_main.c	2005-06-22 17:02:17.000000000 -0500
@@ -173,6 +173,12 @@ static int e1000_resume(struct pci_dev *
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
+#ifdef CONFIG_E1000_EEH_RECOVERY
+static int e1000_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state);
+static int e1000_io_slot_reset (struct pci_dev *pdev);
+static void e1000_io_resume (struct pci_dev *pdev);
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 struct notifier_block e1000_notifier_reboot = {
 	.notifier_call	= e1000_notify_reboot,
 	.next		= NULL,
@@ -193,6 +199,14 @@ static struct pci_driver e1000_driver = 
 	.suspend  = e1000_suspend,
 	.resume   = e1000_resume
 #endif
+#ifdef CONFIG_E1000_EEH_RECOVERY
+	.err_handler = {
+		.error_detected = e1000_io_error_detected,
+		.slot_reset = e1000_io_slot_reset,
+		.resume = e1000_io_resume,
+	},
+#endif /* CONFIG_E1000_EEH_RECOVERY */
+
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -3820,4 +3834,91 @@ e1000_netpoll(struct net_device *netdev)
 }
 #endif
 
+#ifdef CONFIG_E1000_EEH_RECOVERY
+
+/** e1000_io_error_detected() is called when PCI error is detected */
+static int e1000_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+	
+	mod_timer(&adapter->watchdog_timer, jiffies + 20 * HZ);
+	if(netif_running(netdev)) 
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
+static int e1000_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+
+	if(pci_enable_device(pdev)) {
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
+static void e1000_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+	uint32_t manc, swsm;
+
+	if(netif_running(netdev)) {
+		if(e1000_up(adapter)) {
+			printk ("e1000: can't bring device back up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+
+	if(adapter->hw.mac_type >= e1000_82540 &&
+	   adapter->hw.media_type == e1000_media_type_copper) {
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
--- linux-2.6.12-git10/drivers/net/Kconfig.linas-orig	2005-06-22 15:26:13.000000000 -0500
+++ linux-2.6.12-git10/drivers/net/Kconfig	2005-06-22 15:28:29.000000000 -0500
@@ -1847,6 +1847,14 @@ config E1000_NAPI
 
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
--- linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig	2005-06-22 15:30:33.000000000 -0500
@@ -564,6 +564,7 @@ CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
 # CONFIG_E1000_NAPI is not set
+CONFIG_E1000_EEH_RECOVERY=y
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set

--a8Wt8u1KmwUX3Y2C--
