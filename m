Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUIPKoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUIPKoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUIPKoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:44:10 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:60357 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267615AbUIPKoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:44:02 -0400
Subject: [PATCH]: Suspend2 Merge: Device driver fixes 1/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1095331532.3855.133.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 20:45:32 +1000
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Forwarded Message-----
> From: Éric Brunet <Eric.Brunet@lps.ens.fr>
> To: Paul Gortmaker <p_gortmaker@yahoo.com>
> Cc: arekm@pld-linux.org, linux-kernel@vger.kernel.org
> Subject: PATCH swsuspend for ne2k-pci cards
> Date: Sat, 21 Aug 2004 14:14:30 +0200
> 
> Hi,
> 
> Arkadiusz Miskiewicz had some suggestions to improve my patch which
> adds suspend/resume support to ne2k-pci.c. Actually, he basically rewrote
> it.
> 
> This patch was only tested on my own ne2k clone [Realtek Semiconductor
> Co., Ltd. RTL-8029(AS)], and it works nicely for me. As 1) it cannot hurt
> people which are not using swsuspend 2) it can only improve things for
> people using swsuspend, it would be nice if this patch could go into the
> kernel.
> 
> Thank you,
> 
> 	Éric Brunet

diff -ruN linux-2.6.9-rc1/drivers/net/ne2k-pci.c software-suspend-linux-2.6.9-rc1-rev3/drivers/net/ne2k-pci.c
--- linux-2.6.9-rc1/drivers/net/ne2k-pci.c	2004-09-07 21:58:41.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/net/ne2k-pci.c	2004-09-09 19:36:24.000000000 +1000
@@ -653,12 +653,43 @@
 	pci_set_drvdata(pdev, NULL);
 }
 
+#ifdef CONFIG_PM
+static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
+{
+	struct net_device *dev = pci_get_drvdata (pdev);
+
+	netif_device_detach(dev);
+	pci_save_state(pdev, pdev->saved_config_space);
+	pci_set_power_state(pdev, state);
+
+	return 0;
+}
+
+static int ne2k_pci_resume (struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata (pdev);
+
+	pci_set_power_state(pdev, 0);
+	pci_restore_state(pdev, pdev->saved_config_space);
+	NS8390_init(dev, 1);
+	netif_device_attach(dev);
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 
 static struct pci_driver ne2k_driver = {
 	.name		= DRV_NAME,
 	.probe		= ne2k_pci_init_one,
 	.remove		= __devexit_p(ne2k_pci_remove_one),
 	.id_table	= ne2k_pci_tbl,
+#ifdef CONFIG_PM
+	.suspend	= ne2k_pci_suspend,
+	.resume		= ne2k_pci_resume,
+#endif /* CONFIG_PM */
+
 };
 
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

