Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVGZV3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVGZV3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVGZV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:27:28 -0400
Received: from fmr24.intel.com ([143.183.121.16]:16080 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262044AbVGZVZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:25:42 -0400
Date: Tue, 26 Jul 2005 14:25:26 -0700
Message-Id: <200507262125.j6QLPQ18005509@agluck-lia64.sc.intel.com>
From: tony.luck@intel.com
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] e1000: no need for reboot notifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_reboot() now calls device_suspend(), so it is no longer necessary for
the e1000 driver to register a reboot notifier [in fact doing so results
in e1000_suspend() getting called twice].

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -162,7 +162,6 @@ static void e1000_vlan_rx_add_vid(struct
 static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
 
-static int e1000_notify_reboot(struct notifier_block *, unsigned long event, void *ptr);
 static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
 #ifdef CONFIG_PM
 static int e1000_resume(struct pci_dev *pdev);
@@ -173,12 +172,6 @@ static int e1000_resume(struct pci_dev *
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
-struct notifier_block e1000_notifier_reboot = {
-	.notifier_call	= e1000_notify_reboot,
-	.next		= NULL,
-	.priority	= 0
-};
-
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
@@ -221,9 +214,7 @@ e1000_init_module(void)
 	printk(KERN_INFO "%s\n", e1000_copyright);
 
 	ret = pci_module_init(&e1000_driver);
-	if(ret >= 0) {
-		register_reboot_notifier(&e1000_notifier_reboot);
-	}
+
 	return ret;
 }
 
@@ -239,7 +230,6 @@ module_init(e1000_init_module);
 static void __exit
 e1000_exit_module(void)
 {
-	unregister_reboot_notifier(&e1000_notifier_reboot);
 	pci_unregister_driver(&e1000_driver);
 }
 
@@ -3652,23 +3642,6 @@ e1000_set_spd_dplx(struct e1000_adapter 
 }
 
 static int
-e1000_notify_reboot(struct notifier_block *nb, unsigned long event, void *p)
-{
-	struct pci_dev *pdev = NULL;
-
-	switch(event) {
-	case SYS_DOWN:
-	case SYS_HALT:
-	case SYS_POWER_OFF:
-		while((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev))) {
-			if(pci_dev_driver(pdev) == &e1000_driver)
-				e1000_suspend(pdev, 3);
-		}
-	}
-	return NOTIFY_DONE;
-}
-
-static int
 e1000_suspend(struct pci_dev *pdev, uint32_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
