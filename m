Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbUKMBZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUKMBZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbUKLXmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:42:50 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33923 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262705AbUKLXWw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:52 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017151066@kroah.com>
Date: Fri, 12 Nov 2004 15:21:55 -0800
Message-Id: <11003017153578@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.35.3, 2004/10/28 15:15:12-05:00, akpm@osdl.org

[PATCH] PCI: propagate pci_enable_device() errors

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Jeff Garzik pointed out that I should have propagated the error returned
from pci_enable_device() rather than making up -ENODEV.

Propagate pci_enable_device() error returns rather than using -ENODEV.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/atm/idt77252.c        |    4 ++--
 drivers/isdn/tpam/tpam_main.c |    4 ++--
 drivers/misc/ibmasm/module.c  |    6 +++---
 drivers/net/tulip/de4x5.c     |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)


diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	2004-11-12 15:14:36 -08:00
+++ b/drivers/atm/idt77252.c	2004-11-12 15:14:36 -08:00
@@ -3685,9 +3685,9 @@
 	int i, err;
 
 
-	if (pci_enable_device(pcidev)) {
+	if ((err = pci_enable_device(pcidev))) {
 		printk("idt77252: can't enable PCI device at %s\n", pci_name(pcidev));
-		return -ENODEV;
+		return err;
 	}
 
 	if (pci_read_config_word(pcidev, PCI_REVISION_ID, &revision)) {
diff -Nru a/drivers/isdn/tpam/tpam_main.c b/drivers/isdn/tpam/tpam_main.c
--- a/drivers/isdn/tpam/tpam_main.c	2004-11-12 15:14:36 -08:00
+++ b/drivers/isdn/tpam/tpam_main.c	2004-11-12 15:14:36 -08:00
@@ -88,10 +88,10 @@
 	tpam_card *card, *c;
 	int i, err;
 
-	if (pci_enable_device(dev)) {
+	if ((err = pci_enable_device(dev))) {
 		printk(KERN_ERR "TurboPAM: can't enable PCI device at %s\n",
 			pci_name(dev));
-		return -ENODEV;
+		return err;
 	}
 
 	/* allocate memory for the board structure */
diff -Nru a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
--- a/drivers/misc/ibmasm/module.c	2004-11-12 15:14:36 -08:00
+++ b/drivers/misc/ibmasm/module.c	2004-11-12 15:14:36 -08:00
@@ -59,13 +59,13 @@
 
 static int __init ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int result = -ENOMEM;
+	int err, result = -ENOMEM;
 	struct service_processor *sp;
 
-	if (pci_enable_device(pdev)) {
+	if ((err = pci_enable_device(pdev))) {
 		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
 			DRIVER_NAME, pci_name(pdev));
-		return -ENODEV;
+		return err;
 	}
 
 	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
diff -Nru a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	2004-11-12 15:14:36 -08:00
+++ b/drivers/net/tulip/de4x5.c	2004-11-12 15:14:36 -08:00
@@ -2242,8 +2242,8 @@
 		return -ENODEV;
 
 	/* Ok, the device seems to be for us. */
-	if (pci_enable_device (pdev))
-		return -ENODEV;
+	if ((error = pci_enable_device (pdev)))
+		return error;
 
 	if (!(dev = alloc_etherdev (sizeof (struct de4x5_private)))) {
 		error = -ENOMEM;

