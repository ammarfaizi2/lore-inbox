Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWAJA7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWAJA7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWAJA7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:59:00 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:25735 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750781AbWAJA67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:58:59 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Tue, 10 Jan 2006 01:58:36 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH] happy-meal-pci-probing
In-reply-to: <8budr11mfchfp03ncrpqjeck6f04urom8n@4ax.com>
Message-Id: <20060110005834.405D722AEAC@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

against 2.6.15-mm2

happy-meal-pci-probing

Pci probing functions added, some functions were rewritten.
Use PCI_DEVICE macro.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit eb724d05644c4a6fa80fc7f4beaeabfcd7a19905
tree a75be76af0e6a59f2f1526c7cce188403cff63cf
parent 43aabaed0719318490527bd09bc0b0872953c518
author <ku@bellona.(none)> Tue, 10 Jan 2006 01:52:57 +0100
committer <ku@bellona.(none)> Tue, 10 Jan 2006 01:52:57 +0100

 drivers/net/sunhme.c |   79 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -3013,7 +3013,7 @@ static void get_hme_mac_nonsparc(struct 
 }
 #endif /* !(__sparc__) */
 
-static int __init happy_meal_pci_init(struct pci_dev *pdev)
+static int __devinit happy_meal_pci_init(struct pci_dev *pdev)
 {
 	struct quattro *qp = NULL;
 #ifdef __sparc__
@@ -3073,6 +3073,7 @@ static int __init happy_meal_pci_init(st
 	memset(hp, 0, sizeof(*hp));
 
 	hp->happy_dev = pdev;
+	pci_dev_get(pdev);
 
 	spin_lock_init(&hp->happy_lock);
 
@@ -3260,6 +3261,7 @@ err_out_free_res:
 	pci_release_regions(pdev);
 
 err_out_clear_quattro:
+	pci_dev_put(pdev);
 	if (qp != NULL)
 		qp->happy_meals[qfe_slot] = NULL;
 
@@ -3304,21 +3306,58 @@ static int __init happy_meal_sbus_probe(
 #endif
 
 #ifdef CONFIG_PCI
-static int __init happy_meal_pci_probe(void)
+static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
+	const struct pci_device_id *id)
 {
-	struct pci_dev *pdev = NULL;
-	int cards = 0;
+	int retval;
+
+	retval = pci_enable_device(pdev);
+	if (retval < 0)
+		goto err;
+
+	pci_set_master(pdev);
+	happy_meal_pci_init(pdev);
+
+	return 0;
+err:
+	return retval;
+}
 
-	while ((pdev = pci_find_device(PCI_VENDOR_ID_SUN,
-				       PCI_DEVICE_ID_SUN_HAPPYMEAL, pdev)) != NULL) {
-		if (pci_enable_device(pdev))
-			continue;
-		pci_set_master(pdev);
-		cards++;
-		happy_meal_pci_init(pdev);
+static void __devexit happy_meal_pci_remove(struct pci_dev *pdev)
+{
+	struct quattro *tmp, *qp = qfe_pci_list;
+	struct pci_dev *bdev = pdev->bus->self;
+
+	if (qp->quattro_dev == bdev) { /* is it the 1st one? */
+		qfe_pci_list = qp->next;
+		kfree(qp);
+		goto end;
 	}
-	return cards;
+
+	for (; qp->next != NULL; qp = qp->next) /* some further? */
+		if (qp->next->quattro_dev == bdev)
+			break;
+
+	tmp = qp->next; /* kill it, but preserve list */
+	qp->next = qp->next->next;
+	kfree(tmp);
+end:
+	pci_dev_put(pdev);
 }
+
+static struct pci_device_id happy_meal_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_HAPPYMEAL) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, happy_meal_pci_tbl);
+
+static struct pci_driver happy_meal_pci_driver = {
+	.name		= "happy_meal_pci",
+	.id_table	= happy_meal_pci_tbl,
+	.probe		= happy_meal_pci_probe,
+	.remove		= __devexit_p(happy_meal_pci_remove)
+};
+
 #endif
 
 static int __init happy_meal_probe(void)
@@ -3337,11 +3376,10 @@ static int __init happy_meal_probe(void)
 	cards += happy_meal_sbus_probe();
 #endif
 #ifdef CONFIG_PCI
-	cards += happy_meal_pci_probe();
+	return pci_register_driver(&happy_meal_pci_driver);
+#else
+	return cards ? 0 : -ENODEV;
 #endif
-	if (!cards)
-		return -ENODEV;
-	return 0;
 }
 
 
@@ -3408,14 +3446,7 @@ static void __exit happy_meal_cleanup_mo
 	}
 #endif
 #ifdef CONFIG_PCI
-	while (qfe_pci_list) {
-		struct quattro *qfe = qfe_pci_list;
-		struct quattro *next = qfe->next;
-
-		kfree(qfe);
-
-		qfe_pci_list = next;
-	}
+	pci_unregister_driver(&happy_meal_pci_driver);
 #endif
 }
 
