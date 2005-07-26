Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVGZKwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVGZKwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGZKwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:52:31 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:22679 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261720AbVGZKwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:52:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
Date: Tue, 26 Jul 2005 12:54:04 +0200
User-Agent: KMail/1.8.1
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
References: <200507261247.05684.rjw@sisk.pl>
In-Reply-To: <200507261247.05684.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507261254.05507.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds basic suspend/resume support to the sk98lin
network driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.13-rc3-git5/drivers/net/sk98lin/skge.c	2005-07-23 19:26:29.000000000 +0200
+++ patched/drivers/net/sk98lin/skge.c	2005-07-25 18:17:57.000000000 +0200
@@ -5133,6 +5133,75 @@ static void __devexit skge_remove_one(st
 	kfree(pAC);
 }
 
+#ifdef CONFIG_PM
+static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	DEV_NET *pNet = netdev_priv(dev);
+	SK_AC *pAC = pNet->pAC;
+	struct net_device *otherdev = pAC->dev[1];
+
+	if (pNet->Up) {
+		pAC->WasIfUp[0] = SK_TRUE;
+		DoPrintInterfaceChange = SK_FALSE;
+		SkDrvDeInitAdapter(pAC, 0);  /* performs SkGeClose */
+	}
+	if (otherdev != dev) {
+		pNet = netdev_priv(otherdev);
+		if (pNet->Up) {
+			pAC->WasIfUp[1] = SK_TRUE;
+			DoPrintInterfaceChange = SK_FALSE;
+			SkDrvDeInitAdapter(pAC, 1);  /* performs SkGeClose */
+		}
+	}
+
+	pci_save_state(pdev);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
+	if (pAC->AllocFlag & SK_ALLOC_IRQ) {
+		free_irq(dev->irq, dev);
+	}
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
+	return 0;
+}
+
+static int skge_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	DEV_NET *pNet = netdev_priv(dev);
+	SK_AC *pAC = pNet->pAC;
+	int ret;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+	if (pAC->GIni.GIMacsFound == 2)
+		ret = request_irq(dev->irq, SkGeIsr, SA_SHIRQ, pAC->Name, dev);
+	else
+		ret = request_irq(dev->irq, SkGeIsrOnePort, SA_SHIRQ, pAC->Name, dev);
+	if (ret) {
+		printk(KERN_WARNING "sk98lin: unable to acquire IRQ %d\n", dev->irq);
+		pAC->AllocFlag &= ~SK_ALLOC_IRQ;
+		dev->irq = 0;
+		pci_disable_device(pdev);
+		return -EBUSY;
+	}
+
+	if (pAC->WasIfUp[0] == SK_TRUE) {
+		DoPrintInterfaceChange = SK_FALSE;
+		SkDrvInitAdapter(pAC, 0);    /* first device  */
+	}
+	if (pAC->dev[1] != dev && pAC->WasIfUp[1] == SK_TRUE) {
+		DoPrintInterfaceChange = SK_FALSE;
+		SkDrvInitAdapter(pAC, 1);    /* second device  */
+	}
+
+	return 0;
+}
+#endif
+
 static struct pci_device_id skge_pci_tbl[] = {
 	{ PCI_VENDOR_ID_3COM, 0x1700, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_3COM, 0x80eb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -5158,6 +5227,8 @@ static struct pci_driver skge_driver = {
 	.id_table	= skge_pci_tbl,
 	.probe		= skge_probe_one,
 	.remove		= __devexit_p(skge_remove_one),
+	.suspend	= skge_suspend,
+	.resume		= skge_resume,
 };
 
 static int __init skge_init(void)
