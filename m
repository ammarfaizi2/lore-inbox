Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVJFX5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVJFX5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVJFX5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:57:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51597 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932089AbVJFX5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:57:38 -0400
Date: Thu, 6 Oct 2005 18:57:29 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 20/22] PCI Error Recovery: e100 network device driver
Message-ID: <20051006235729.GU29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI Error Recovery: e100 network device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ethernet e100
device driver. The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/configs/pSeries_defconfig |    1 
 drivers/net/Kconfig                  |    8 +++
 drivers/net/e100.c                   |   73 +++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

Index: linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/configs/pSeries_defconfig	2005-09-27 16:15:29.957254295 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig	2005-09-27 16:23:17.992430104 -0500
@@ -574,6 +574,7 @@
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
+CONFIG_E100_EEH_RECOVERY=y
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
Index: linux-2.6.14-rc2-git6/drivers/net/Kconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/net/Kconfig	2005-09-27 14:35:57.000000000 -0500
+++ linux-2.6.14-rc2-git6/drivers/net/Kconfig	2005-09-27 16:23:17.993429963 -0500
@@ -1394,6 +1394,14 @@
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
Index: linux-2.6.14-rc2-git6/drivers/net/e100.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/net/e100.c	2005-09-27 14:35:57.825425161 -0500
+++ linux-2.6.14-rc2-git6/drivers/net/e100.c	2005-09-27 16:23:48.110194710 -0500
@@ -2650,6 +2650,76 @@
 #endif
 }
 
+#ifdef CONFIG_E100_EEH_RECOVERY
+
+/** e100_io_error_detected() is called when PCI error is detected */
+static int e100_io_error_detected(struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	/* Same as calling e100_down(netdev_priv(netdev)), but generic */
+	netdev->stop(netdev);
+
+	/* Is a detach needed ?? */
+	// netif_device_detach(netdev);
+
+	/* Request a slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** e100_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch. */
+static int e100_io_slot_reset(struct pci_dev *pdev)
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
+static void e100_io_resume(struct pci_dev *pdev)
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
+
+static struct pci_error_handlers e100_err_handler = {
+	.error_detected = e100_io_error_detected,
+	.slot_reset = e100_io_slot_reset,
+	.resume = e100_io_resume,
+};
+
+#endif /* CONFIG_E100_EEH_RECOVERY */
 
 static struct pci_driver e100_driver = {
 	.name =         DRV_NAME,
@@ -2661,6 +2731,9 @@
 	.resume =       e100_resume,
 #endif
 	.shutdown =	e100_shutdown,
+#ifdef CONFIG_E100_EEH_RECOVERY
+	.err_handler = &e100_err_handler,
+#endif /* CONFIG_E100_EEH_RECOVERY */
 };
 
 static int __init e100_init_module(void)
