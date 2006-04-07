Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWDGXLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWDGXLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWDGXLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 19:11:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50816 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965047AbWDGXLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 19:11:38 -0400
Date: Fri, 7 Apr 2006 18:11:34 -0500
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
Message-ID: <20060407231134.GN25225@austin.ibm.com>
References: <20060406222359.GA30037@austin.ibm.com> <20060406224643.GA6278@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406224643.GA6278@kroah.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 03:46:43PM -0700, Greg KH wrote:
> On Thu, Apr 06, 2006 at 05:24:00PM -0500, Linas Vepstas wrote:
> > +	if(pci_enable_device(pdev)) {
> 
> Add a space after "if" and before "(" please.

I guess I'm immune to learning from experience. :-/

Here's a new improved patch.

--linas

[PATCH] PCI Error Recovery: e100 network device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel ethernet e100
device driver. The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

----

 drivers/net/e100.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+)

Index: linux-2.6.17-rc1/drivers/net/e100.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/e100.c	2006-04-07 16:21:46.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/e100.c	2006-04-07 18:10:52.411266545 -0500
@@ -2780,6 +2780,80 @@ static void e100_shutdown(struct pci_dev
 		DPRINTK(PROBE,ERR, "Error enabling wake\n");
 }
 
+/* ------------------ PCI Error Recovery infrastructure  -------------- */
+/**
+ * e100_io_error_detected - called when PCI error is detected.
+ * @pdev: Pointer to PCI device
+ * @state: The current pci conneection state
+ */
+static pci_ers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	/* Similar to calling e100_down(), but avoids adpater I/O. */
+	netdev->stop(netdev);
+
+	/* Detach; put netif into state similar to hotplug unplug. */
+	netif_poll_enable(netdev);
+	netif_device_detach(netdev);
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * e100_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Restart the card from scratch.
+ */
+static pci_ers_result_t e100_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct nic *nic = netdev_priv(netdev);
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	/* Only one device per card can do a reset */
+	if (0 != PCI_FUNC(pdev->devfn))
+		return PCI_ERS_RESULT_RECOVERED;
+	e100_hw_reset(nic);
+	e100_phy_init(nic);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * e100_io_resume - resume normal operations
+ * @pdev: Pointer to PCI device
+ *
+ * Resume normal operations after an error recovery
+ * sequence has been completed.
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
+	if (netif_running(netdev)) {
+		e100_open(netdev);
+		mod_timer(&nic->watchdog, jiffies);
+	}
+}
+
+static struct pci_error_handlers e100_err_handler = {
+	.error_detected = e100_io_error_detected,
+	.slot_reset = e100_io_slot_reset,
+	.resume = e100_io_resume,
+};
 
 static struct pci_driver e100_driver = {
 	.name =         DRV_NAME,
@@ -2791,6 +2865,7 @@ static struct pci_driver e100_driver = {
 	.resume =       e100_resume,
 #endif
 	.shutdown =     e100_shutdown,
+	.err_handler = &e100_err_handler,
 };
 
 static int __init e100_init_module(void)
