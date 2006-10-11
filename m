Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWJKVsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWJKVsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWJKVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:48:12 -0400
Received: from havoc.gtf.org ([69.61.125.42]:54999 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422660AbWJKVsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:48:09 -0400
Date: Wed, 11 Oct 2006 17:48:09 -0400
From: Jeff Garzik <jeff@garzik.org>
To: oakad@yahoo.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/{mmc,misc}: handle PCI errors on resume
Message-ID: <20061011214809.GA21756@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since pci_enable_device() is one of the first things called in the
resume step, take the minimalist approach and return immediately, if
pci_enable_device() fails during resume.

Also, in sdhci:  don't check for impossible condition (chip==NULL)

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/misc/tifm_7xx1.c      |    7 ++++++-
 drivers/mmc/sdhci.c           |   11 +++++------

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index 1ba8754..03988b9 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -273,9 +273,14 @@ static int tifm_7xx1_resume(struct pci_d
 {
 	struct tifm_adapter *fm = pci_get_drvdata(dev);
 	unsigned long flags;
+	int rc;
 
 	pci_restore_state(dev);
-        pci_enable_device(dev);
+
+	rc = pci_enable_device(dev);
+	if (rc)
+		return rc;
+
         pci_set_power_state(dev, PCI_D0);
         pci_set_master(dev);
 
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 9a7d39b..b27fff9 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1090,18 +1090,17 @@ static int sdhci_suspend (struct pci_dev
 
 static int sdhci_resume (struct pci_dev *pdev)
 {
-	struct sdhci_chip *chip;
+	struct sdhci_chip *chip = pci_get_drvdata(pdev);
 	int i, ret;
 
-	chip = pci_get_drvdata(pdev);
-	if (!chip)
-		return 0;
-
 	DBG("Resuming...\n");
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
 
 	for (i = 0;i < chip->num_slots;i++) {
 		if (!chip->hosts[i])
