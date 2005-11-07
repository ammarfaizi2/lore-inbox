Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVKGVed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVKGVed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKGVec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:34:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29655 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965099AbVKGVea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:34:30 -0500
Date: Mon, 7 Nov 2005 15:34:28 -0600
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/7]: Revised [PATCH 29/42]: ethernet: add PCI error recovery to e100 dev driver
Message-ID: <20051107213428.GK19593@austin.ibm.com>
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

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ethernet e100
device driver. The patch has been tested, and appears to work well.

Please apply.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
Index: linux-2.6.14-mm1/drivers/net/e100.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/net/e100.c	2005-11-07 13:55:26.363148057 -0600
+++ linux-2.6.14-mm1/drivers/net/e100.c	2005-11-07 15:02:11.120920287 -0600
@@ -2465,6 +2465,75 @@
 }
 
 
+/* ------------------ PCI Error Recovery infrastructure  -------------- */
+/** e100_io_error_detected() is called when PCI error is detected */
+static pers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
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
+	return PERS_RESULT_NEED_RESET;
+}
+
+/** e100_io_slot_reset is called after the pci bus has been reset.
+ *  Restart the card from scratch. */
+static pers_result_t e100_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct nic *nic = netdev_priv(netdev);
+
+	if(pci_enable_device(pdev)) {
+		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
+		return PERS_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Only one device per card can do a reset */
+	if (0 != PCI_FUNC (pdev->devfn))
+		return PERS_RESULT_RECOVERED;
+
+	e100_hw_reset(nic);
+	e100_phy_init(nic);
+
+	if(e100_hw_init(nic)) {
+		DPRINTK(HW, ERR, "e100_hw_init failed\n");
+		return PERS_RESULT_DISCONNECT;
+	}
+
+	return PERS_RESULT_RECOVERED;
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
