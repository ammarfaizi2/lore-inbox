Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDMVbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDMVbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 17:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDMVbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 17:31:51 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:18633 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261198AbVDMVbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 17:31:45 -0400
Subject: [PATCH] PC300 pci_enable_device fix
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: pc300@cyclades.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 15:31:43 -0600
Message-Id: <1113427903.21308.3.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call pci_enable_device() before looking at IRQ and resources.
The driver requires this fix or the "pci=routeirq" workaround
on 2.6.10 and later kernels.

Reported and tested by Artur Lipowski.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/net/wan/pc300_drv.c 1.24 vs edited =====
--- 1.24/drivers/net/wan/pc300_drv.c	2004-12-29 12:25:16 -07:00
+++ edited/drivers/net/wan/pc300_drv.c	2005-04-13 13:35:21 -06:00
@@ -3439,6 +3439,9 @@
 #endif
 	}
 
+	if ((err = pci_enable_device(pdev)) != 0)
+		return err;
+
 	card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
 	if (card == NULL) {
 		printk("PC300 found at RAM 0x%08lx, "
@@ -3526,9 +3529,6 @@
 		err = -ENODEV;
 		goto err_release_ram;
 	}
-
-	if ((err = pci_enable_device(pdev)) != 0)
-		goto err_release_sca;
 
 	card->hw.plxbase = ioremap(card->hw.plxphys, card->hw.plxsize);
 	card->hw.rambase = ioremap(card->hw.ramphys, card->hw.alloc_ramsize);


