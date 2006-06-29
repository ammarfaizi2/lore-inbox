Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWF2Q0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWF2Q0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWF2Q0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:26:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50113 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750899AbWF2Q0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:26:37 -0400
Date: Thu, 29 Jun 2006 11:26:34 -0500
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@vger.kernel.org
Subject: [PATCH] ixgb: add PCI Error recovery callbacks
Message-ID: <20060629162634.GC5472@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adds PCI Error recovery callbacks to the Intel 10-gigabit ethernet
ixgb device driver. Lightly tested, works.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/ixgb/ixgb_main.c |  112 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

Index: linux-2.6.17-mm3/drivers/net/ixgb/ixgb_main.c
===================================================================
--- linux-2.6.17-mm3.orig/drivers/net/ixgb/ixgb_main.c	2006-06-27 11:39:08.000000000 -0500
+++ linux-2.6.17-mm3/drivers/net/ixgb/ixgb_main.c	2006-06-28 18:04:32.000000000 -0500
@@ -118,15 +118,26 @@ static void ixgb_restore_vlan(struct ixg
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
-/* Exported from other modules */
+static pci_ers_result_t ixgb_io_error_detected (struct pci_dev *pdev,
+	                     enum pci_channel_state state);
+static pci_ers_result_t ixgb_io_slot_reset (struct pci_dev *pdev);
+static void ixgb_io_resume (struct pci_dev *pdev);
 
+/* Exported from other modules */
 extern void ixgb_check_options(struct ixgb_adapter *adapter);
 
+static struct pci_error_handlers ixgb_err_handler = {
+	.error_detected = ixgb_io_error_detected,
+	.slot_reset = ixgb_io_slot_reset,
+	.resume = ixgb_io_resume,
+};
+
 static struct pci_driver ixgb_driver = {
 	.name     = ixgb_driver_name,
 	.id_table = ixgb_pci_tbl,
 	.probe    = ixgb_probe,
 	.remove   = __devexit_p(ixgb_remove),
+	.err_handler = &ixgb_err_handler
 };
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
@@ -1543,6 +1554,11 @@ void
 ixgb_update_stats(struct ixgb_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+
+	/* Prevent stats update while adapter is being reset */
+	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+		return;
 
 	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
 	   (netdev->mc_count > IXGB_MAX_NUM_MULTICAST_ADDRESSES)) {
@@ -2198,4 +2214,98 @@ static void ixgb_netpoll(struct net_devi
 }
 #endif
 
+/**
+ * ixgb_io_error_detected() - called when PCI error is detected
+ * @pdev    pointer to pci device with error
+ * @state   pci channel state after error
+ *
+ * This callback is called by the PCI subsystem whenever
+ * a PCI bus error is detected.
+ */
+static pci_ers_result_t ixgb_io_error_detected (struct pci_dev *pdev,
+			             enum pci_channel_state state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter = netdev->priv;
+
+	if(netif_running(netdev))
+		ixgb_down(adapter, TRUE);
+
+	pci_disable_device(pdev);
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * ixgb_io_slot_reset - called after the pci bus has been reset.
+ * @pdev    pointer to pci device with error
+ *
+ * This callback is called after the PCI buss has been reset.
+ * Basically, this tries to restart the card from scratch.
+ * This is a shortened version of the device probe/discovery code,
+ * it resembles the first-half of the ixgb_probe() routine.
+ */
+static pci_ers_result_t ixgb_io_slot_reset (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter = netdev->priv;
+
+	if(pci_enable_device(pdev)) {
+		DPRINTK(PROBE, ERR, "Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	/* Perform card reset only on one instance of the card */
+	if (0 != PCI_FUNC (pdev->devfn))
+		return PCI_ERS_RESULT_RECOVERED;
+
+	pci_set_master(pdev);
+
+	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
+	ixgb_reset(adapter);
+
+	/* Make sure the EEPROM is good */
+	if(!ixgb_validate_eeprom_checksum(&adapter->hw)) {
+		DPRINTK(PROBE, ERR, "After reset, the EEPROM checksum is not valid.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	ixgb_get_ee_mac_addr(&adapter->hw, netdev->dev_addr);
+	memcpy(netdev->perm_addr, netdev->dev_addr, netdev->addr_len);
+
+	if(!is_valid_ether_addr(netdev->perm_addr)) {
+		DPRINTK(PROBE, ERR, "After reset, invalid MAC address.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * ixgb_io_resume - called when its OK to resume normal operations
+ * @pdev    pointer to pci device with error
+ *
+ * The error recovery driver tells us that its OK to resume
+ * normal operation. Implementation resembles the second-half
+ * of the ixgb_probe() routine.
+ */
+static void ixgb_io_resume (struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct ixgb_adapter *adapter = netdev->priv;
+
+	pci_set_master(pdev);
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
+
 /* ixgb_main.c */
