Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVBGSt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVBGSt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVBGSt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:49:57 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:24766 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261178AbVBGStz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:49:55 -0500
Subject: [PATCH] de214x.c uses uninitialized pci_dev->irq
From: Bjorn Helgaas <bjorn-helgaas@comcast.net>
Reply-To: bjorn.helgaas@hp.com
To: jgarzik@pobox.com, tulip-users@lists.sourceforge.net
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 07 Feb 2005 11:49:42 -0700
Message-Id: <1107802183.8074.30.camel@piglet>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use pci_dev->irq until after pci_enable_device().
Andy Esten reported that his NIC stopped working in
2.6.10 because of this problem.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/net/tulip/de2104x.c 1.33 vs edited =====
--- 1.33/drivers/net/tulip/de2104x.c	2004-10-25 19:04:30 -06:00
+++ edited/drivers/net/tulip/de2104x.c	2005-02-07 09:51:57 -07:00
@@ -1958,8 +1958,6 @@
 	dev->tx_timeout = de_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
-	dev->irq = pdev->irq;
-
 	de = dev->priv;
 	de->de21040 = ent->driver_data == 0 ? 1 : 0;
 	de->pdev = pdev;
@@ -1994,6 +1992,8 @@
 		       pdev->irq, pci_name(pdev));
 		goto err_out_res;
 	}
+
+	dev->irq = pdev->irq;
 
 	/* obtain and check validity of PCI I/O address */
 	pciaddr = pci_resource_start(pdev, 1);


