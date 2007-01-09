Return-Path: <linux-kernel-owner+w=401wt.eu-S1751196AbXAIJBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbXAIJBZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbXAIJBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:01:25 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44896 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbXAIJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:01:22 -0500
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 2/5] fixing errors handling during pci_driver resume stage [ata]
From: Dmitriy Monakhov <dmonakhov@openvz.org>
Date: Tue, 09 Jan 2007 12:01:28 +0300
Message-ID: <87tzz0mv4n.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

ata pci drivers have to return correct error code during resume stage in
case of errors.
Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
-----

--=-=-=
Content-Disposition: inline; filename=diff-pci-ata

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b517d24..0656334 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1372,7 +1372,9 @@ static int ahci_pci_device_resume(struct
 	void __iomem *mmio = host->mmio_base;
 	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(mmio, pdev);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0d51d13..3d6729d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6221,12 +6221,19 @@ void ata_pci_device_do_suspend(struct pc
 	}
 }
 
-void ata_pci_device_do_resume(struct pci_dev *pdev)
+int ata_pci_device_do_resume(struct pci_dev *pdev)
 {
+	int ret = 0; 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot enable PCI device, aborting.\n");
+		return ret;
+	}
+	
 	pci_set_master(pdev);
+	return ret;
 }
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
@@ -6246,8 +6253,10 @@ int ata_pci_device_suspend(struct pci_de
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int err;
 
-	ata_pci_device_do_resume(pdev);
+	if ((err = ata_pci_device_do_resume(pdev)))
+		return err;
 	ata_host_resume(host);
 	return 0;
 }
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 7808d03..8451143 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -710,8 +710,12 @@ err_out:
 static int sil_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int err;
+
+	err = ata_pci_device_do_resume(pdev);
+	if (err)
+		return err;
 
-	ata_pci_device_do_resume(pdev);
 	sil_init_controller(pdev, host->n_ports, host->ports[0]->flags,
 			    host->mmio_base);
 	ata_host_resume(host);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 5aa288d..be6971a 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1200,8 +1200,11 @@ static int sil24_pci_device_resume(struc
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct sil24_host_priv *hpriv = host->private_data;
+	int err;
 
-	ata_pci_device_do_resume(pdev);
+	err = ata_pci_device_do_resume(pdev);
+	if (err)
+		return err;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
 		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab27548..283ca72 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -719,7 +719,7 @@ extern int ata_pci_init_one (struct pci_
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern void ata_pci_device_do_resume(struct pci_dev *pdev);
+extern int ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);

--=-=-=--

