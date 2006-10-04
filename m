Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030795AbWJDKTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030795AbWJDKTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030788AbWJDKTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:19:20 -0400
Received: from havoc.gtf.org ([69.61.125.42]:48007 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030542AbWJDKTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:19:19 -0400
Date: Wed, 4 Oct 2006 06:19:18 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI aic94xx: handle sysfs errors
Message-ID: <20061004101918.GA17841@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Handle and unwind from errors returned by driver model functions.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/aic94xx/aic94xx_init.c |   41 ++++++++++++++++++++++++++++--------
 1 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index ee2ccad..418e789 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -310,11 +310,29 @@ static ssize_t asd_show_dev_pcba_sn(stru
 }
 static DEVICE_ATTR(pcba_sn, S_IRUGO, asd_show_dev_pcba_sn, NULL);
 
-static void asd_create_dev_attrs(struct asd_ha_struct *asd_ha)
+static int asd_create_dev_attrs(struct asd_ha_struct *asd_ha)
 {
-	device_create_file(&asd_ha->pcidev->dev, &dev_attr_revision);
-	device_create_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
-	device_create_file(&asd_ha->pcidev->dev, &dev_attr_pcba_sn);
+	int err;
+
+	err = device_create_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	if (err)
+		return err;
+
+	err = device_create_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
+	if (err)
+		goto err_rev;
+
+	err = device_create_file(&asd_ha->pcidev->dev, &dev_attr_pcba_sn);
+	if (err)
+		goto err_biosb;
+	
+	return 0;
+
+err_biosb:
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
+err_rev:
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	return err;
 }
 
 static void asd_remove_dev_attrs(struct asd_ha_struct *asd_ha)
@@ -646,7 +664,9 @@ static int __devinit asd_pci_probe(struc
 	}
 	ASD_DPRINTK("escbs posted\n");
 
-	asd_create_dev_attrs(asd_ha);
+	err = asd_create_dev_attrs(asd_ha);
+	if (err)
+		goto Err_dev_attrs;
 
 	err = asd_register_sas_ha(asd_ha);
 	if (err)
@@ -669,6 +689,7 @@ Err_en_phys:
 	asd_unregister_sas_ha(asd_ha);
 Err_reg_sas:
 	asd_remove_dev_attrs(asd_ha);
+Err_dev_attrs:
 Err_escbs:
 	asd_disable_ints(asd_ha);
 	free_irq(dev->irq, asd_ha);
@@ -755,9 +776,9 @@ static ssize_t asd_version_show(struct d
 }
 static DRIVER_ATTR(version, S_IRUGO, asd_version_show, NULL);
 
-static void asd_create_driver_attrs(struct device_driver *driver)
+static int asd_create_driver_attrs(struct device_driver *driver)
 {
-	driver_create_file(driver, &driver_attr_version);
+	return driver_create_file(driver, &driver_attr_version);
 }
 
 static void asd_remove_driver_attrs(struct device_driver *driver)
@@ -835,10 +856,14 @@ static int __init aic94xx_init(void)
 	if (err)
 		goto out_release_transport;
 
-	asd_create_driver_attrs(&aic94xx_pci_driver.driver);
+	err = asd_create_driver_attrs(&aic94xx_pci_driver.driver);
+	if (err)
+		goto out_unregister_pcidrv;
 
 	return err;
 
+ out_unregister_pcidrv:
+	pci_unregister_driver(&aic94xx_pci_driver);
  out_release_transport:
 	sas_release_transport(aic94xx_transport_template);
  out_destroy_caches:
