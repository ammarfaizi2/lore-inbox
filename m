Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269898AbUJMW6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269898AbUJMW6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269903AbUJMW6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:58:09 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:65428 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269898AbUJMW5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:57:54 -0400
Date: Thu, 14 Oct 2004 00:53:04 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       chas@cmf.nrl.navy.mil
Subject: Re: [PATCH 2.6] zatm.c: replace pci_find_device with pci_get_device
Message-ID: <20041013225304.GB32276@electric-eye.fr.zoreil.com>
References: <194130000.1097705759@w-hlinder.beaverton.ibm.com> <197610000.1097706024@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197610000.1097706024@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> :
[...]

You will hate me but I had some code waiting for resurrection. :o)


Modern PCI device style module init.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/atm/zatm.c~zatm-10 drivers/atm/zatm.c
--- linux-2.6.9-rc3/drivers/atm/zatm.c~zatm-10	2004-10-14 00:39:02.000000000 +0200
+++ linux-2.6.9-rc3-fr/drivers/atm/zatm.c	2004-10-14 00:47:56.000000000 +0200
@@ -46,6 +46,8 @@
  *  - OAM
  */
 
+#define ZATM_COPPER	1
+
 #if 0
 #define DPRINTK(format,args...) printk(KERN_DEBUG format,##args)
 #else
@@ -1577,51 +1579,77 @@ static const struct atmdev_ops ops = {
 	.change_qos	= zatm_change_qos,
 };
 
-static int __init zatm_module_init(void)
+static int __devinit zatm_init_one(struct pci_dev *pci_dev,
+				   const struct pci_device_id *ent)
 {
 	struct atm_dev *dev;
 	struct zatm_dev *zatm_dev;
-	int devs,type;
+	int ret = -ENOMEM;
 
-	zatm_dev = (struct zatm_dev *) kmalloc(sizeof(struct zatm_dev),
-	    GFP_KERNEL);
-	if (!zatm_dev) return -ENOMEM;
-	devs = 0;
-	for (type = 0; type < 2; type++) {
-		struct pci_dev *pci_dev;
-
-		pci_dev = NULL;
-		while ((pci_dev = pci_find_device(PCI_VENDOR_ID_ZEITNET,type ?
-		    PCI_DEVICE_ID_ZEITNET_1225 : PCI_DEVICE_ID_ZEITNET_1221,
-		    pci_dev))) {
-			if (pci_enable_device(pci_dev)) break;
-			dev = atm_dev_register(DEV_LABEL,&ops,-1,NULL);
-			if (!dev) break;
-			zatm_dev->pci_dev = pci_dev;
-			dev->dev_data = zatm_dev;
-			zatm_dev->copper = type;
-			if (zatm_init(dev) || zatm_start(dev)) {
-				atm_dev_deregister(dev);
-				break;
-			}
-			zatm_dev->more = zatm_boards;
-			zatm_boards = dev;
-			devs++;
-			zatm_dev = (struct zatm_dev *) kmalloc(sizeof(struct
-			    zatm_dev),GFP_KERNEL);
-			if (!zatm_dev) {
-				printk(KERN_EMERG "zatm.c: memory shortage\n");
-				goto out;
-			}
-		}
-	}
+	zatm_dev = (struct zatm_dev *) kmalloc(sizeof(*zatm_dev), GFP_KERNEL);
+	if (!zatm_dev) {
+		printk(KERN_EMERG "%s: memory shortage\n", DEV_LABEL);
+		goto out;
+	}
+
+	dev = atm_dev_register(DEV_LABEL, &ops, -1, NULL);
+	if (!dev)
+		goto out_free;
+
+	ret = pci_enable_device(pci_dev);
+	if (ret < 0)
+		goto out_deregister;
+
+	ret = pci_request_regions(pci_dev, DEV_LABEL);
+	if (ret < 0)
+		goto out_disable;
+
+	zatm_dev->pci_dev = pci_dev;
+	ZATM_DEV(dev) = zatm_dev;
+	zatm_dev->copper = (int)ent->driver_data;
+	if ((ret = zatm_init(dev)) || (ret = zatm_start(dev)))
+		goto out_release;
+
+	pci_set_drvdata(pci_dev, dev);
+	zatm_dev->more = zatm_boards;
+	zatm_boards = dev;
+	ret = 0;
 out:
-	kfree(zatm_dev);
+	return ret;
 
-	return 0;
+out_release:
+	pci_release_regions(pci_dev);
+out_disable:
+	pci_disable_device(pci_dev);
+out_deregister:
+	atm_dev_deregister(dev);
+out_free:
+	kfree(zatm_dev);
+	goto out;
 }
 
+
 MODULE_LICENSE("GPL");
 
-module_init(zatm_module_init);
+static struct pci_device_id zatm_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_ZEITNET, PCI_DEVICE_ID_ZEITNET_1221,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ZATM_COPPER },
+	{ PCI_VENDOR_ID_ZEITNET, PCI_DEVICE_ID_ZEITNET_1225,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, zatm_pci_tbl);
+
+static struct pci_driver zatm_driver = {
+	.name =		DEV_LABEL,
+	.id_table =	zatm_pci_tbl,
+	.probe =	zatm_init_one,
+};
+
+static int __init zatm_init_module(void)
+{
+	return pci_module_init(&zatm_driver);
+}
+
+module_init(zatm_init_module);
 /* module_exit not defined so not unloadable */

_
