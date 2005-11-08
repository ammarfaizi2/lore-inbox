Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVKHX7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVKHX7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbVKHX7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:59:04 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:18353 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030426AbVKHX7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:59:01 -0500
Date: Tue, 8 Nov 2005 17:58:46 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] PCI Error Recovery: e100 network device driver
Message-ID: <20051108235846.GG19593@austin.ibm.com>
References: <20051108234911.GC19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108234911.GC19593@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.

-----
Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ethernet e100
device driver. The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
Index: linux-2.6.14-git10/drivers/net/e100.c
===================================================================
--- linux-2.6.14-git10.orig/drivers/net/e100.c	2005-11-07 17:24:10.000000000 -0600
+++ linux-2.6.14-git10/drivers/net/e100.c	2005-11-07 17:44:42.911603712 -0600
@@ -2465,6 +2465,75 @@
 }
 
 
+/* ------------------ PCI Error Recovery infrastructure  -------------- */
+/** e100_io_error_detected() is called when PCI error is detected */
+static pci_ers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
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
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/** e100_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch. */
+static pci_ers_result_t e100_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct nic *nic = netdev_priv(netdev);
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Only one device per card can do a reset */
+	if (0 != PCI_FUNC (pdev->devfn))
+		return PCI_ERS_RESULT_RECOVERED;
+
+	e100_hw_reset(nic);
+	e100_phy_init(nic);
+
+	if(e100_hw_init(nic)) {
+		DPRINTK(HW, ERR, "e100_hw_init failed\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
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
+	if(netif_running(netdev)) {
+		e100_open (netdev);
+		mod_timer(&nic->watchdog, jiffies);
+	}
+}
+
+static struct pci_error_handlers e100_err_handler = {
+	.error_detected = e100_io_error_detected,
+	.slot_reset = e100_io_slot_reset,
+	.resume = e100_io_resume,
+};
+
+
 static struct pci_driver e100_driver = {
 	.name =         DRV_NAME,
 	.id_table =     e100_id_table,
@@ -2475,6 +2544,7 @@
 	.resume =       e100_resume,
 #endif
 	.shutdown =	e100_shutdown,
+	.err_handler = &e100_err_handler,
 };
 
 static int __init e100_init_module(void)
