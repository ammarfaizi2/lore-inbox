Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUIAO52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUIAO52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUIAO52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:57:28 -0400
Received: from nef.ens.fr ([129.199.96.32]:12049 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S266825AbUIAO4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 10:56:40 -0400
Date: Wed, 1 Sep 2004 16:56:38 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH (RESENT) swsuspend for ne2k-pci cards
Message-ID: <20040901145638.GA9993@lps.ens.fr>
References: <20040806235438.GA7095@lps.ens.fr> <20040807071346.91641.qmail@web60510.mail.yahoo.com> <20040807140845.GA8353@lps.ens.fr> <20040821121430.GB8826@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040821121430.GB8826@lps.ens.fr>
User-Agent: Mutt/1.4.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Wed, 01 Sep 2004 16:56:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a resent of my patch to add suspend/resume support to ne2k-pci
network adapters.

* The patch was tested on a RealTek ne2k clone and works nicely,
* It was reviewed and largely improved by Arkadiusz Miskiewicz
* It was approved of by Pavel Machek, the software suspend maintainer.

It would be nice if this patch could go into the kernel.

Thank you,

	Éric Brunet

--- linux-old/drivers/net/ne2k-pci.c	2004-08-07 15:54:24.000000000 +0200
+++ linux-2.6.8-rc1/drivers/net/ne2k-pci.c	2004-08-21 12:24:27.000000000 +0200
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
 
 
