Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVF2Bua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVF2Bua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVF2Brm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:47:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1174 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262216AbVF1X66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:58:58 -0400
Date: Tue, 28 Jun 2005 18:58:48 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 4/13]: PCI Err: e100 ethernet driver recovery
Message-ID: <20050628235848.GA6376@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-4-e100.patch

Adds PCI error recovery callbacks to the Intel E100 ethernet device driver.
Lightly tested on an E100 two-port card. 

Signed-off-by: Linas Vepstas <linas@linas.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-4-e100.patch"

--- linux-2.6.12-git10/drivers/net/e100.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/net/e100.c	2005-06-22 17:18:26.000000000 -0500
@@ -2460,6 +2460,67 @@ static void e100_shutdown(struct device 
 #endif
 }
 
+#ifdef CONFIG_E100_EEH_RECOVERY
+
+/** e100_io_error_detected() is called when PCI error is detected */
+static int e100_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct nic *nic = netdev_priv(netdev);
+
+	mod_timer(&nic->watchdog, jiffies + 30*HZ);
+	e100_down(nic);
+
+	/* Request a slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** e100_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch. */
+static int e100_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct nic *nic = netdev_priv(netdev);
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Only one device per card can do a reset */
+	if (0 != PCI_FUNC (pdev->devfn))
+		return PCIERR_RESULT_RECOVERED;
+	
+	e100_hw_reset(nic);
+	e100_phy_init(nic);
+	
+	if(e100_hw_init(nic)) {
+		DPRINTK(HW, ERR, "e100_hw_init failed\n");
+		return PCIERR_RESULT_DISCONNECT;
+	}
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** e100_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ */
+static void e100_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct nic *nic = netdev_priv(netdev);
+
+	/* ack any pending wake events, disable PME */
+	pci_enable_wake(pdev, 0, 0);
+
+	netif_device_attach(netdev);
+	if(netif_running(netdev))
+		e100_open (netdev);
+	
+	mod_timer(&nic->watchdog, jiffies);
+}
+#endif /* CONFIG_E100_EEH_RECOVERY */
 
 static struct pci_driver e100_driver = {
 	.name =         DRV_NAME,
@@ -2470,6 +2531,13 @@ static struct pci_driver e100_driver = {
 	.suspend =      e100_suspend,
 	.resume =       e100_resume,
 #endif
+#ifdef CONFIG_E100_EEH_RECOVERY
+	.err_handler = {
+		.error_detected = e100_io_error_detected,
+		.slot_reset = e100_io_slot_reset,
+		.resume = e100_io_resume,
+	},
+#endif /* CONFIG_E100_EEH_RECOVERY */
 
 	.driver = {
 		.shutdown = e100_shutdown,
--- linux-2.6.12-git10/drivers/net/Kconfig.linas-orig	2005-06-22 15:26:13.000000000 -0500
+++ linux-2.6.12-git10/drivers/net/Kconfig	2005-06-22 15:28:29.000000000 -0500
@@ -1392,6 +1392,14 @@ config E100
 	  <file:Documentation/networking/net-modules.txt>.  The module
 	  will be called e100.
 
+config E100_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on E100 && PPC_PSERIES
+   help
+      If you say Y here, the driver will be able to recover from
+      PCI bus errors on many PowerPC platforms. IBM pSeries users
+      should answer Y.
+
 config LNE390
 	tristate "Mylex EISA LNE390A/B support (EXPERIMENTAL)"
 	depends on NET_PCI && EISA && EXPERIMENTAL
--- linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig	2005-06-22 15:30:33.000000000 -0500
@@ -545,6 +545,7 @@ CONFIG_PCNET32=y
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
+CONFIG_E100_EEH_RECOVERY=y
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set

--vkogqOf2sHV7VnPd--
