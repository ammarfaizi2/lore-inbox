Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWIWM2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIWM2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWIWM2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:28:45 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1750825AbWIWM2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:28:45 -0400
Received: from natsumi.tdiedrich.de ([217.160.135.16]:41224 "EHLO
	natsumi.tdiedrich.de") by vger.kernel.org with ESMTP
	id S1751142AbWIWIV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:21:58 -0400
Date: Sat, 23 Sep 2006 10:28:51 +0200
From: Tobias Diedrich <ranma@tdiedrich.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: forcedeth broken powermanagement/irq handling ?
Message-ID: <20060923082851.GA2611@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@tdiedrich.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since there hasn't been much progress with the bugzilla entry I'm
bringing this issue to your attention here. :)

http://bugzilla.kernel.org/show_bug.cgi?id=6398

vanilla forcedeth doesn't seem to support suspend and an
ifdown/up-cycle is needed to get it working again after suspend.
Francois Romieu's "Awfully experimental" patch is working just fine
for me (with message signalled interrupts disabled) and has survived
quite a few suspend/resume cycles.

So I'd very much like to see (at least partial, with msi disabled)
suspend support for forcedeth in mainline. 

Romieu's patch:

--- linux-2.6.18-rc6/drivers/net/forcedeth.c	2006-09-09 09:45:43.000000000 +0200
+++ linux-2.6.17.11-xen/drivers/net/forcedeth.c	2006-09-09 09:41:25.000000000 +0200
@@ -4433,6 +4433,50 @@
 	pci_set_drvdata(pci_dev, NULL);
 }
 
+
+#ifdef CONFIG_PM
+
+static int nv_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct fe_priv *np = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_device_detach(dev);
+
+	// Gross.
+	nv_close(dev);
+
+	pci_save_state(pdev);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), np->wolenabled);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+out:
+	return 0;
+}
+
+static int nv_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	int rc = 0;
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_device_attach(dev);
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	rc = nv_open(dev);
+out:
+	return rc;
+}
+
+#endif /* CONFIG_PM */
+
 static struct pci_device_id pci_tbl[] = {
 	{	/* nForce Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_1),
@@ -4534,6 +4578,10 @@
 	.id_table = pci_tbl,
 	.probe = nv_probe,
 	.remove = __devexit_p(nv_remove),
+#ifdef CONFIG_PM
+	.suspend	= nv_suspend,
+	.resume		= nv_resume,
+#endif
 };
 
 
-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
このメールは十割再利用されたビットで作られています。
