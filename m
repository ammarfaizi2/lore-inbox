Return-Path: <linux-kernel-owner+w=401wt.eu-S932676AbWLZPVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWLZPVU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWLZPVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:21:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:58125 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbWLZPSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=hYH2A5woHoO4zGknFqz3E7cNYwWIQ3mlBGNNN7htBe8czzkOtCNliiLfrFrcfcHdjBjXIH4e2n8ncMDe4yPICGLIrU/Tz1QJZSwgzfjujfwy6gmiSXUnjv3G+9XDFzpxIdvg3U9lVQd7BGj0VGlYCwaRh8mt11Ng5lPcOxMpdi4=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/12] libata: handle pci_enable_device() failure while resuming
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:34 +0900
Message-Id: <1167146314835-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle pci_enable_device() failure while resuming.  This patch kills
the "ignoring return value of 'pci_enable_device'" warning message and
propagates __must_check through ata_pci_device_do_resume().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    4 +++-
 drivers/ata/libata-core.c |   22 +++++++++++++++++-----
 drivers/ata/sata_sil.c    |    6 +++++-
 drivers/ata/sata_sil24.c  |    5 ++++-
 include/linux/libata.h    |    2 +-
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b517d24..0656334 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1372,7 +1372,9 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 	void __iomem *mmio = host->mmio_base;
 	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(mmio, pdev);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0d51d13..5fdf37f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6221,12 +6221,22 @@ void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	}
 }
 
-void ata_pci_device_do_resume(struct pci_dev *pdev)
+int ata_pci_device_do_resume(struct pci_dev *pdev)
 {
+	int rc;
+
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "failed to enable device after resume (%d)\n", rc);
+		return rc;
+	}
+
 	pci_set_master(pdev);
+	return 0;
 }
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
@@ -6246,10 +6256,12 @@ int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
 
-	ata_pci_device_do_resume(pdev);
-	ata_host_resume(host);
-	return 0;
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc == 0)
+		ata_host_resume(host);
+	return rc;
 }
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 7808d03..ca7111a 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -710,8 +710,12 @@ err_out:
 static int sil_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
-	ata_pci_device_do_resume(pdev);
 	sil_init_controller(pdev, host->n_ports, host->ports[0]->flags,
 			    host->mmio_base);
 	ata_host_resume(host);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 5aa288d..da982ed 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1200,8 +1200,11 @@ static int sil24_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct sil24_host_priv *hpriv = host->private_data;
+	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
 		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab27548..8028a57 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -719,7 +719,7 @@ extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_i
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern void ata_pci_device_do_resume(struct pci_dev *pdev);
+extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
-- 
1.4.4.2


