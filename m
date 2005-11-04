Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbVKDAyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVKDAyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVKDAx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:53:58 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:16276
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030587AbVKDAxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:53:54 -0500
Date: Thu, 3 Nov 2005 18:53:53 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 29/42]: ethernet: add PCI error recovery to e100 dev driver
Message-ID: <20051104005353.GA27074@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ethernet e100
device driver. The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
Index: linux-2.6.14-git3/drivers/net/e100.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/net/e100.c	2005-11-02 14:28:51.524169808 -0600
+++ linux-2.6.14-git3/drivers/net/e100.c	2005-11-02 14:43:58.890949857 -0600
@@ -2465,6 +2465,75 @@
 }
 
 
+/* ------------------ PCI Error Recovery infrastructure  -------------- */
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
