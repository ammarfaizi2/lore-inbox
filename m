Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWJLBpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWJLBpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWJLBpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:45:40 -0400
Received: from havoc.gtf.org ([69.61.125.42]:3296 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422675AbWJLBpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:45:39 -0400
Date: Wed, 11 Oct 2006 21:45:38 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI/qla2xxx: handle sysfs errors
Message-ID: <20061012014538.GA12894@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/qla2xxx/qla_attr.c |   52 +++++++++++++++++++++++++++++++---------
 drivers/scsi/qla2xxx/qla_gbl.h  |    4 ---
 drivers/scsi/qla2xxx/qla_os.c   |    7 ++++-

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index ee75a71..54e4a60 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -379,22 +379,52 @@ static struct bin_attribute sysfs_sfp_at
 	.read = qla2x00_sysfs_read_sfp,
 };
 
-void
+int
 qla2x00_alloc_sysfs_attr(scsi_qla_host_t *ha)
 {
 	struct Scsi_Host *host = ha->host;
-
-	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_fw_dump_attr);
-	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_nvram_attr);
-	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_optrom_attr);
-	sysfs_create_bin_file(&host->shost_gendev.kobj,
-	    &sysfs_optrom_ctl_attr);
+	int rc;
+
+	rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_fw_dump_attr);
+	if (rc) goto err;
+	rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_nvram_attr);
+	if (rc) goto err_fwd;
+	rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_optrom_attr);
+	if (rc) goto err_nvr;
+	rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_optrom_ctl_attr);
+	if (rc) goto err_optrom;
 	if (IS_QLA24XX(ha) || IS_QLA54XX(ha)) {
-		sysfs_create_bin_file(&host->shost_gendev.kobj,
-		    &sysfs_vpd_attr);
-		sysfs_create_bin_file(&host->shost_gendev.kobj,
-		    &sysfs_sfp_attr);
+		rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
+					   &sysfs_vpd_attr);
+		if (rc) goto err_opt_ctl;
+		rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
+					   &sysfs_sfp_attr);
+		if (rc) goto err_vpd;
 	}
+
+	return 0;
+
+err_vpd:
+	sysfs_remove_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_vpd_attr);
+err_opt_ctl:
+	sysfs_remove_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_optrom_ctl_attr);
+err_optrom:
+	sysfs_remove_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_optrom_attr);
+err_nvr:
+	sysfs_remove_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_nvram_attr);
+err_fwd:
+	sysfs_remove_bin_file(&host->shost_gendev.kobj,
+				   &sysfs_fw_dump_attr);
+err:
+	return rc;
 }
 
 void
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 7da6983..60ade19 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -296,9 +296,7 @@ struct class_device_attribute;
 extern struct class_device_attribute *qla2x00_host_attrs[];
 struct fc_function_template;
 extern struct fc_function_template qla2xxx_transport_functions;
-extern void qla2x00_alloc_sysfs_attr(scsi_qla_host_t *);
+extern int qla2x00_alloc_sysfs_attr(scsi_qla_host_t *);
 extern void qla2x00_free_sysfs_attr(scsi_qla_host_t *);
 extern void qla2x00_init_host_attr(scsi_qla_host_t *);
-extern void qla2x00_alloc_sysfs_attr(scsi_qla_host_t *);
-extern void qla2x00_free_sysfs_attr(scsi_qla_host_t *);
 #endif /* _QLA_GBL_H */
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 3f20d76..d70162b 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1638,7 +1638,9 @@ qla2x00_probe_one(struct pci_dev *pdev, 
 	if (ret)
 		goto probe_failed;
 
-	qla2x00_alloc_sysfs_attr(ha);
+	ret = qla2x00_alloc_sysfs_attr(ha);
+	if (ret)
+		goto probe_failed_rmhost;
 
 	qla2x00_init_host_attr(ha);
 
@@ -1658,6 +1660,9 @@ qla2x00_probe_one(struct pci_dev *pdev, 
 
 	return 0;
 
+probe_failed_rmhost:
+	scsi_remove_host(host);
+
 probe_failed:
 	qla2x00_free_device(ha);
 
