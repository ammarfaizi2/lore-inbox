Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVLRDsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVLRDsP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVLRDsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:48:15 -0500
Received: from www.swissdisk.com ([216.144.233.50]:41641 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S965045AbVLRDsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:48:14 -0500
Date: Sat, 17 Dec 2005 18:39:23 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH 2.6.15-git] i2o: Do not disable pci device when it's in use
Message-ID: <20051218023923.GA15246@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reference: https://bugzilla.ubuntu.com/17897
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When dpt_i2o is loaded first, i2o being loaded would cause it to call
pci_device_disable, thus breaking dpt_i2o's use of the device. Based on
similar usage of pci_disable_device in other drivers.
    
Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/drivers/message/i2o/pci.c b/drivers/message/i2o/pci.c
index 81ef306..8859c8a 100644
--- a/drivers/message/i2o/pci.c
+++ b/drivers/message/i2o/pci.c
@@ -303,6 +303,7 @@ static int __devinit i2o_pci_probe(struc
 	struct i2o_controller *c;
 	int rc;
 	struct pci_dev *i960 = NULL;
+	int pci_dev_busy = 0;
 
 	printk(KERN_INFO "i2o: Checking for PCI I2O controllers...\n");
 
@@ -395,6 +396,8 @@ static int __devinit i2o_pci_probe(struc
 	if ((rc = i2o_pci_alloc(c))) {
 		printk(KERN_ERR "%s: DMA / IO allocation for I2O controller "
 		       " failed\n", c->name);
+		if (rc == -ENODEV)
+			pci_dev_busy = 1;
 		goto free_controller;
 	}
 
@@ -425,7 +428,8 @@ static int __devinit i2o_pci_probe(struc
 	i2o_iop_free(c);
 
       disable:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 
 	return rc;
 }
