Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbUIQE7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbUIQE7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUIQE7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:59:48 -0400
Received: from fmr05.intel.com ([134.134.136.6]:10973 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268413AbUIQE7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:59:37 -0400
Subject: hotplug e1000 failed after 32 times
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-+Ongff6PRNeODmYVFnBW"
Message-Id: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 12:53:13 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Ongff6PRNeODmYVFnBW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
I'm testing a hotplug driver. In my test, I will hot add/remove an e1000
NIC frequently. The result is my hot add failed after 32 times hotadd.
After looking at the code of e1000 driver, I found
e1000_adapter->bd_number has maxium limitation of 32, and it increased
one every hot add. Looks like the remove driver routine didn't free the
'bd_number', so hot add failed after 32 times. Below patch fixes this
issue.

thanks,
Shaohua

Signed-off-by Li Shaohua <shaohua.li@intel.com>
===== drivers/net/e1000/e1000_main.c 1.134 vs edited =====
--- 1.134/drivers/net/e1000/e1000_main.c	2004-09-13 07:52:48 +08:00
+++ edited/drivers/net/e1000/e1000_main.c	2004-09-17 12:01:08 +08:00
@@ -180,6 +180,8 @@ struct notifier_block e1000_notifier_reb
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
+extern int e1000_alloc_bd_number(void);
+extern void e1000_free_bd_number(int);
 
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
@@ -380,7 +382,6 @@ e1000_probe(struct pci_dev *pdev,
 {
 	struct net_device *netdev;
 	struct e1000_adapter *adapter;
-	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int pci_using_dac;
@@ -471,7 +472,7 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->mem_end = mmio_start + mmio_len;
 	netdev->base_addr = adapter->hw.io_base;
 
-	adapter->bd_number = cards_found;
+	adapter->bd_number = e1000_alloc_bd_number();;
 
 	/* setup the private structure */
 
@@ -590,13 +591,13 @@ e1000_probe(struct pci_dev *pdev,
 	if((err = register_netdevice(netdev)))
 		goto err_register;
 
-	cards_found++;
 	rtnl_unlock();
 	return 0;
 
 err_register:
 err_sw_init:
 err_eeprom:
+	e1000_free_bd_number(adapter->bd_number);
 	iounmap(adapter->hw.hw_addr);
 err_ioremap:
 err_free_unlock:
@@ -638,6 +639,7 @@ e1000_remove(struct pci_dev *pdev)
 	e1000_phy_hw_reset(&adapter->hw);
 
 	iounmap(adapter->hw.hw_addr);
+	e1000_free_bd_number(adapter->bd_number);
 	pci_release_regions(pdev);
 
 	free_netdev(netdev);
===== drivers/net/e1000/e1000_param.c 1.31 vs edited =====
--- 1.31/drivers/net/e1000/e1000_param.c	2004-08-29 06:55:39 +08:00
+++ edited/drivers/net/e1000/e1000_param.c	2004-09-17 12:37:41 +08:00
@@ -56,7 +56,7 @@
  */
 
 #define E1000_PARAM(X, S) \
-static const int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT;
\
+static int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
 MODULE_PARM(X, "1-" __MODULE_STRING(E1000_MAX_NIC) "i"); \
 MODULE_PARM_DESC(X, S);
 
@@ -703,3 +703,40 @@ e1000_check_copper_options(struct e1000_
 	}
 }
 
+#define BD_NUMBER_BITS (E1000_MAX_NIC + 1)
+#if BITS_PER_LONG > BD_NUMBER_BITS
+static unsigned long bd_number_bits;
+#else
+static unsigned long bd_number_bits[(E1000_MAX_NIC * 2)/BITS_PER_LONG];
+#endif
+
+int e1000_alloc_bd_number(void)
+{
+	int ret;
+
+	ret = find_first_zero_bit(&bd_number_bits, BD_NUMBER_BITS);
+	if (ret >= E1000_MAX_NIC)
+		ret = E1000_MAX_NIC;
+	__set_bit(ret, &bd_number_bits);
+	return ret;
+}
+
+void e1000_free_bd_number(int bd_number)
+{
+	if ((bd_number < 0) || (bd_number > E1000_MAX_NIC) ||
+		!test_bit(bd_number, &bd_number_bits))
+		return;
+	TxDescriptors[bd_number] = 
+	RxDescriptors[bd_number] = 
+	Speed[bd_number] =
+	Duplex[bd_number] =
+	AutoNeg[bd_number] =
+	FlowControl[bd_number] =
+	XsumRX[bd_number] =
+	TxIntDelay[bd_number] =
+	TxAbsIntDelay[bd_number] =
+	RxIntDelay[bd_number] =
+	RxAbsIntDelay[bd_number] =
+	InterruptThrottleRate[bd_number] = OPTION_UNSET;
+	__clear_bit(bd_number, &bd_number_bits);
+}


--=-+Ongff6PRNeODmYVFnBW
Content-Disposition: attachment; filename=e1000.patch
Content-Type: text/x-patch; name=e1000.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== drivers/net/e1000/e1000_main.c 1.134 vs edited =====
--- 1.134/drivers/net/e1000/e1000_main.c	2004-09-13 07:52:48 +08:00
+++ edited/drivers/net/e1000/e1000_main.c	2004-09-17 12:01:08 +08:00
@@ -180,6 +180,8 @@ struct notifier_block e1000_notifier_reb
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
+extern int e1000_alloc_bd_number(void);
+extern void e1000_free_bd_number(int);
 
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
@@ -380,7 +382,6 @@ e1000_probe(struct pci_dev *pdev,
 {
 	struct net_device *netdev;
 	struct e1000_adapter *adapter;
-	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int pci_using_dac;
@@ -471,7 +472,7 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->mem_end = mmio_start + mmio_len;
 	netdev->base_addr = adapter->hw.io_base;
 
-	adapter->bd_number = cards_found;
+	adapter->bd_number = e1000_alloc_bd_number();;
 
 	/* setup the private structure */
 
@@ -590,13 +591,13 @@ e1000_probe(struct pci_dev *pdev,
 	if((err = register_netdevice(netdev)))
 		goto err_register;
 
-	cards_found++;
 	rtnl_unlock();
 	return 0;
 
 err_register:
 err_sw_init:
 err_eeprom:
+	e1000_free_bd_number(adapter->bd_number);
 	iounmap(adapter->hw.hw_addr);
 err_ioremap:
 err_free_unlock:
@@ -638,6 +639,7 @@ e1000_remove(struct pci_dev *pdev)
 	e1000_phy_hw_reset(&adapter->hw);
 
 	iounmap(adapter->hw.hw_addr);
+	e1000_free_bd_number(adapter->bd_number);
 	pci_release_regions(pdev);
 
 	free_netdev(netdev);
===== drivers/net/e1000/e1000_param.c 1.31 vs edited =====
--- 1.31/drivers/net/e1000/e1000_param.c	2004-08-29 06:55:39 +08:00
+++ edited/drivers/net/e1000/e1000_param.c	2004-09-17 12:37:41 +08:00
@@ -56,7 +56,7 @@
  */
 
 #define E1000_PARAM(X, S) \
-static const int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
+static int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
 MODULE_PARM(X, "1-" __MODULE_STRING(E1000_MAX_NIC) "i"); \
 MODULE_PARM_DESC(X, S);
 
@@ -703,3 +703,40 @@ e1000_check_copper_options(struct e1000_
 	}
 }
 
+#define BD_NUMBER_BITS (E1000_MAX_NIC + 1)
+#if BITS_PER_LONG > BD_NUMBER_BITS
+static unsigned long bd_number_bits;
+#else
+static unsigned long bd_number_bits[(E1000_MAX_NIC * 2)/BITS_PER_LONG];
+#endif
+
+int e1000_alloc_bd_number(void)
+{
+	int ret;
+
+	ret = find_first_zero_bit(&bd_number_bits, BD_NUMBER_BITS);
+	if (ret >= E1000_MAX_NIC)
+		ret = E1000_MAX_NIC;
+	__set_bit(ret, &bd_number_bits);
+	return ret;
+}
+
+void e1000_free_bd_number(int bd_number)
+{
+	if ((bd_number < 0) || (bd_number > E1000_MAX_NIC) ||
+		!test_bit(bd_number, &bd_number_bits))
+		return;
+	TxDescriptors[bd_number] = 
+	RxDescriptors[bd_number] = 
+	Speed[bd_number] =
+	Duplex[bd_number] =
+	AutoNeg[bd_number] =
+	FlowControl[bd_number] =
+	XsumRX[bd_number] =
+	TxIntDelay[bd_number] =
+	TxAbsIntDelay[bd_number] =
+	RxIntDelay[bd_number] =
+	RxAbsIntDelay[bd_number] =
+	InterruptThrottleRate[bd_number] = OPTION_UNSET;
+	__clear_bit(bd_number, &bd_number_bits);
+}

--=-+Ongff6PRNeODmYVFnBW--

