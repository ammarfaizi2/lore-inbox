Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWCYDV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWCYDV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 22:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWCYDV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 22:21:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:49861 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750703AbWCYDV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 22:21:56 -0500
Date: Fri, 24 Mar 2006 21:21:46 -0600
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux.nics@intel.com
Subject: Re: [PATCH] PCI Error Recovery: e1000 network device driver
Message-ID: <20060325032146.GE21895@austin.ibm.com>
References: <20060324220002.GC26137@austin.ibm.com> <20060325022206.GA6361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325022206.GA6361@kroah.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 06:22:06PM -0800, Greg KH wrote:
> ... a bit
> different from the traditional kernel coding style.

Sorry, this is due to inattention on my part; I get cross-eyed 
after staring at the same code for too long. The patch below should
fix things.  

--linas


[PATCH] PCI Error Recovery: e1000 network device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the intel gigabit
ethernet e1000 device driver. The patch has been tested, and appears
to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

----

 drivers/net/e1000/e1000_main.c |  114 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 113 insertions(+), 1 deletion(-)

Index: linux-2.6.16-git6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-git6.orig/drivers/net/e1000/e1000_main.c	2006-03-23 15:48:01.000000000 -0600
+++ linux-2.6.16-git6/drivers/net/e1000/e1000_main.c	2006-03-24 15:14:40.431371705 -0600
@@ -226,6 +226,16 @@ static int e1000_resume(struct pci_dev *
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
+static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
+                     pci_channel_state_t state);
+static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev);
+static void e1000_io_resume(struct pci_dev *pdev);
+
+static struct pci_error_handlers e1000_err_handler = {
+	.error_detected = e1000_io_error_detected,
+	.slot_reset = e1000_io_slot_reset,
+	.resume = e1000_io_resume,
+};
 
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
@@ -235,8 +245,9 @@ static struct pci_driver e1000_driver = 
 	/* Power Managment Hooks */
 #ifdef CONFIG_PM
 	.suspend  = e1000_suspend,
-	.resume   = e1000_resume
+	.resume   = e1000_resume,
 #endif
+	.err_handler = &e1000_err_handler,
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -3063,6 +3074,10 @@ e1000_update_stats(struct e1000_adapter 
 
 #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
 
+	/* Prevent stats update while adapter is being reset */
+	if (adapter->link_speed == 0)
+		return;
+
 	spin_lock_irqsave(&adapter->stats_lock, flags);
 
 	/* these counters are modified from e1000_adjust_tbi_stats,
@@ -4631,4 +4646,101 @@ e1000_netpoll(struct net_device *netdev)
 }
 #endif
 
+/**
+ * e1000_io_error_detected - called when PCI error is detected
+ * @pdev: Pointer to PCI device
+ * @state: The current pci conneection state
+ *
+ * This function is called after a PCI bus error affecting
+ * this device has been detected.
+ */
+static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev))
+		e1000_down(adapter);
+
+	/* Request a slot slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * e1000_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Restart the card from scratch, as if from a cold-boot. Implementation
+ * resembles the first-half of the e1000_resume routine.
+ */
+static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct e1000_adapter *adapter = netdev->priv;
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "e1000: Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	pci_set_master(pdev);
+
+	pci_enable_wake(pdev, 3, 0);
+	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
+
+	/* Perform card reset only on one instance of the card */
+	if (PCI_FUNC (pdev->devfn) != 0)
+		return PCI_ERS_RESULT_RECOVERED;
+
+	e1000_reset(adapter);
+	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * e1000_io_resume - called when traffic can start flowing again.
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the error recovery driver tells us that
+ * its OK to resume normal operation. Implementation resembles the
+ * second-half of the e1000_resume routine.
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
+	switch (adapter->hw.mac_type) {
+	case e1000_82573:
+		swsm = E1000_READ_REG(&adapter->hw, SWSM);
+		E1000_WRITE_REG(&adapter->hw, SWSM,
+				swsm | E1000_SWSM_DRV_LOAD);
+		break;
+	default:
+		break;
+	}
+
+	if (netif_running(netdev))
+		mod_timer(&adapter->watchdog_timer, jiffies);
+}
+
 /* e1000_main.c */
