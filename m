Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUIQJOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUIQJOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUIQJMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:12:33 -0400
Received: from fmr05.intel.com ([134.134.136.6]:36321 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268602AbUIQJMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:12:17 -0400
Subject: Re: hotplug e1000 failed after 32 times
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040916221406.1f3764e0.akpm@osdl.org>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
	 <20040916221406.1f3764e0.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-9XWxJr06zqqWh5x37oOT"
Message-Id: <1095411936.10407.32.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 17:06:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9XWxJr06zqqWh5x37oOT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-09-17 at 13:14, Andrew Morton wrote:
> Li Shaohua <shaohua.li@intel.com> wrote:
> >
> > I'm testing a hotplug driver. In my test, I will hot add/remove an e1000
> >  NIC frequently. The result is my hot add failed after 32 times hotadd.
> >  After looking at the code of e1000 driver, I found
> >  e1000_adapter->bd_number has maxium limitation of 32, and it increased
> >  one every hot add. Looks like the remove driver routine didn't free the
> >  'bd_number', so hot add failed after 32 times. Below patch fixes this
> >  issue.
> 
> Yeah.  I think you'll find that damn near every net driver in the kernel
> has this problem.  I think it would be better to create a little suite of
> library functions in net/core/dev.c to handle this situation.
<snip>
Here is the patch for e1000 driver using APIs in my previous email.

Thanks,
Shaohua


Signed-off-by: Li Shaohua <shaohua.li@intel.com>
===== drivers/net/e1000/e1000_main.c 1.134 vs edited =====
--- 1.134/drivers/net/e1000/e1000_main.c	2004-09-13 07:52:48 +08:00
+++ edited/drivers/net/e1000/e1000_main.c	2004-09-17 16:39:34 +08:00
@@ -180,6 +180,9 @@ struct notifier_block e1000_notifier_reb
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
+extern void e1000_init_boards(void);
+extern int e1000_alloc_bd_number(void);
+extern void e1000_free_bd_number(int);
 
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
@@ -220,6 +223,7 @@ e1000_init_module(void)
 	ret = pci_module_init(&e1000_driver);
 	if(ret >= 0) {
 		register_reboot_notifier(&e1000_notifier_reboot);
+		e1000_init_boards();
 	}
 	return ret;
 }
@@ -380,7 +384,6 @@ e1000_probe(struct pci_dev *pdev,
 {
 	struct net_device *netdev;
 	struct e1000_adapter *adapter;
-	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int pci_using_dac;
@@ -471,7 +474,7 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->mem_end = mmio_start + mmio_len;
 	netdev->base_addr = adapter->hw.io_base;
 
-	adapter->bd_number = cards_found;
+	adapter->bd_number = e1000_alloc_bd_number();
 
 	/* setup the private structure */
 
@@ -590,13 +593,13 @@ e1000_probe(struct pci_dev *pdev,
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
@@ -638,6 +641,7 @@ e1000_remove(struct pci_dev *pdev)
 	e1000_phy_hw_reset(&adapter->hw);
 
 	iounmap(adapter->hw.hw_addr);
+	e1000_free_bd_number(adapter->bd_number);
 	pci_release_regions(pdev);
 
 	free_netdev(netdev);
===== drivers/net/e1000/e1000_param.c 1.31 vs edited =====
--- 1.31/drivers/net/e1000/e1000_param.c	2004-08-29 06:55:39 +08:00
+++ edited/drivers/net/e1000/e1000_param.c	2004-09-17 16:24:35 +08:00
@@ -56,7 +56,7 @@
  */
 
 #define E1000_PARAM(X, S) \
-static const int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT;
\
+static int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
 MODULE_PARM(X, "1-" __MODULE_STRING(E1000_MAX_NIC) "i"); \
 MODULE_PARM_DESC(X, S);
 
@@ -703,3 +703,36 @@ e1000_check_copper_options(struct e1000_
 	}
 }
 
+static struct net_boards board;
+void e1000_init_boards(void)
+{
+	net_boards_init(&board, E1000_MAX_NIC);
+}
+
+int e1000_alloc_bd_number(void)
+{
+	int ret;
+
+	if ((ret = net_boards_alloc(&board)) < 0)
+		return E1000_MAX_NIC;
+	return ret;
+}
+
+void e1000_free_bd_number(int bd_number)
+{
+	if ((bd_number < 0) || (bd_number > E1000_MAX_NIC))
+		return;
+	TxDescriptors[bd_number] = OPTION_UNSET;
+	RxDescriptors[bd_number] = OPTION_UNSET;
+	Speed[bd_number] = OPTION_UNSET;
+	Duplex[bd_number] = OPTION_UNSET;
+	AutoNeg[bd_number] = OPTION_UNSET;
+	FlowControl[bd_number] = OPTION_UNSET;
+	XsumRX[bd_number] = OPTION_UNSET;
+	TxIntDelay[bd_number] = OPTION_UNSET;
+	TxAbsIntDelay[bd_number] = OPTION_UNSET;
+	RxIntDelay[bd_number] = OPTION_UNSET;
+	RxAbsIntDelay[bd_number] = OPTION_UNSET;
+	InterruptThrottleRate[bd_number] = OPTION_UNSET;
+	net_boards_free(&board, bd_number);
+}


--=-9XWxJr06zqqWh5x37oOT
Content-Disposition: attachment; filename=nic-e1000.patch
Content-Type: text/x-patch; name=nic-e1000.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== drivers/net/e1000/e1000_main.c 1.134 vs edited =====
--- 1.134/drivers/net/e1000/e1000_main.c	2004-09-13 07:52:48 +08:00
+++ edited/drivers/net/e1000/e1000_main.c	2004-09-17 16:39:34 +08:00
@@ -180,6 +180,9 @@ struct notifier_block e1000_notifier_reb
 /* Exported from other modules */
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
+extern void e1000_init_boards(void);
+extern int e1000_alloc_bd_number(void);
+extern void e1000_free_bd_number(int);
 
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
@@ -220,6 +223,7 @@ e1000_init_module(void)
 	ret = pci_module_init(&e1000_driver);
 	if(ret >= 0) {
 		register_reboot_notifier(&e1000_notifier_reboot);
+		e1000_init_boards();
 	}
 	return ret;
 }
@@ -380,7 +384,6 @@ e1000_probe(struct pci_dev *pdev,
 {
 	struct net_device *netdev;
 	struct e1000_adapter *adapter;
-	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int pci_using_dac;
@@ -471,7 +474,7 @@ e1000_probe(struct pci_dev *pdev,
 	netdev->mem_end = mmio_start + mmio_len;
 	netdev->base_addr = adapter->hw.io_base;
 
-	adapter->bd_number = cards_found;
+	adapter->bd_number = e1000_alloc_bd_number();
 
 	/* setup the private structure */
 
@@ -590,13 +593,13 @@ e1000_probe(struct pci_dev *pdev,
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
@@ -638,6 +641,7 @@ e1000_remove(struct pci_dev *pdev)
 	e1000_phy_hw_reset(&adapter->hw);
 
 	iounmap(adapter->hw.hw_addr);
+	e1000_free_bd_number(adapter->bd_number);
 	pci_release_regions(pdev);
 
 	free_netdev(netdev);
===== drivers/net/e1000/e1000_param.c 1.31 vs edited =====
--- 1.31/drivers/net/e1000/e1000_param.c	2004-08-29 06:55:39 +08:00
+++ edited/drivers/net/e1000/e1000_param.c	2004-09-17 16:24:35 +08:00
@@ -56,7 +56,7 @@
  */
 
 #define E1000_PARAM(X, S) \
-static const int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
+static int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
 MODULE_PARM(X, "1-" __MODULE_STRING(E1000_MAX_NIC) "i"); \
 MODULE_PARM_DESC(X, S);
 
@@ -703,3 +703,36 @@ e1000_check_copper_options(struct e1000_
 	}
 }
 
+static struct net_boards board;
+void e1000_init_boards(void)
+{
+	net_boards_init(&board, E1000_MAX_NIC);
+}
+
+int e1000_alloc_bd_number(void)
+{
+	int ret;
+
+	if ((ret = net_boards_alloc(&board)) < 0)
+		return E1000_MAX_NIC;
+	return ret;
+}
+
+void e1000_free_bd_number(int bd_number)
+{
+	if ((bd_number < 0) || (bd_number > E1000_MAX_NIC))
+		return;
+	TxDescriptors[bd_number] = OPTION_UNSET;
+	RxDescriptors[bd_number] = OPTION_UNSET;
+	Speed[bd_number] = OPTION_UNSET;
+	Duplex[bd_number] = OPTION_UNSET;
+	AutoNeg[bd_number] = OPTION_UNSET;
+	FlowControl[bd_number] = OPTION_UNSET;
+	XsumRX[bd_number] = OPTION_UNSET;
+	TxIntDelay[bd_number] = OPTION_UNSET;
+	TxAbsIntDelay[bd_number] = OPTION_UNSET;
+	RxIntDelay[bd_number] = OPTION_UNSET;
+	RxAbsIntDelay[bd_number] = OPTION_UNSET;
+	InterruptThrottleRate[bd_number] = OPTION_UNSET;
+	net_boards_free(&board, bd_number);
+}

--=-9XWxJr06zqqWh5x37oOT--

