Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVF0W5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVF0W5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVF0W5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:57:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261984AbVF0WzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:55:03 -0400
Date: Mon, 27 Jun 2005 15:53:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, hch@infradead.org,
       James.Bottomley@SteelEye.com
Subject: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow board initialization.
Message-ID: <20050627225349.GK9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


Return to previous held-logic of calling scsi_add_host() only
after the board has been completely initialized.  Also return
pci_*() error-codes during probe failure paths.

This also corrects an issue where only lun 0 is being scanned for
a given port.

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

---
commit a1541d5af66d02426655b1498f814c52347dd7d3
tree 02d041e54ebaec744d30ebf6012e305b9673bec0
parent 27198d855abbfc82df69e81b6c8d2f333580114c
author Andrew Vasquez <andrew.vasquez@qlogic.com> Thu, 09 Jun 2005 17:21:28 -0700
committer James Bottomley <jejb@mulgrave.(none)> Sat, 11 Jun 2005 13:06:22 -0500

 drivers/scsi/qla2xxx/qla_os.c |   55 +++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1150,7 +1150,7 @@ iospace_error_exit:
  */
 int qla2x00_probe_one(struct pci_dev *pdev, struct qla_board_info *brd_info)
 {
-	int	ret;
+	int	ret = -ENODEV;
 	device_reg_t __iomem *reg;
 	struct Scsi_Host *host;
 	scsi_qla_host_t *ha;
@@ -1161,7 +1161,7 @@ int qla2x00_probe_one(struct pci_dev *pd
 	fc_port_t *fcport;
 
 	if (pci_enable_device(pdev))
-		return -1;
+		goto probe_out;
 
 	host = scsi_host_alloc(&qla2x00_driver_template,
 	    sizeof(scsi_qla_host_t));
@@ -1183,9 +1183,8 @@ int qla2x00_probe_one(struct pci_dev *pd
 
 	/* Configure PCI I/O space */
 	ret = qla2x00_iospace_config(ha);
-	if (ret != 0) {
-		goto probe_alloc_failed;
-	}
+	if (ret)
+		goto probe_failed;
 
 	/* Sanitize the information from PCI BIOS. */
 	host->irq = pdev->irq;
@@ -1258,23 +1257,10 @@ int qla2x00_probe_one(struct pci_dev *pd
 		qla_printk(KERN_WARNING, ha,
 		    "[ERROR] Failed to allocate memory for adapter\n");
 
-		goto probe_alloc_failed;
+		ret = -ENOMEM;
+		goto probe_failed;
 	}
 
-	pci_set_drvdata(pdev, ha);
-	host->this_id = 255;
-	host->cmd_per_lun = 3;
-	host->unique_id = ha->instance;
-	host->max_cmd_len = MAX_CMDSZ;
-	host->max_channel = ha->ports - 1;
-	host->max_id = ha->max_targets;
-	host->max_lun = ha->max_luns;
-	host->transportt = qla2xxx_transport_template;
-	if (scsi_add_host(host, &pdev->dev))
-		goto probe_alloc_failed;
-
-	qla2x00_alloc_sysfs_attr(ha);
-
 	if (qla2x00_initialize_adapter(ha) &&
 	    !(ha->device_flags & DFLG_NO_CABLE)) {
 
@@ -1285,11 +1271,10 @@ int qla2x00_probe_one(struct pci_dev *pd
 		    "Adapter flags %x.\n",
 		    ha->host_no, ha->device_flags));
 
+		ret = -ENODEV;
 		goto probe_failed;
 	}
 
-	qla2x00_init_host_attr(ha);
-
 	/*
 	 * Startup the kernel thread for this host adapter
 	 */
@@ -1299,17 +1284,26 @@ int qla2x00_probe_one(struct pci_dev *pd
 		qla_printk(KERN_WARNING, ha,
 		    "Unable to start DPC thread!\n");
 
+		ret = -ENODEV;
 		goto probe_failed;
 	}
 	wait_for_completion(&ha->dpc_inited);
 
+	host->this_id = 255;
+	host->cmd_per_lun = 3;
+	host->unique_id = ha->instance;
+	host->max_cmd_len = MAX_CMDSZ;
+	host->max_channel = ha->ports - 1;
+	host->max_lun = MAX_LUNS;
+	host->transportt = qla2xxx_transport_template;
+
 	if (IS_QLA2100(ha) || IS_QLA2200(ha))
 		ret = request_irq(host->irq, qla2100_intr_handler,
 		    SA_INTERRUPT|SA_SHIRQ, ha->brd_info->drv_name, ha);
 	else
 		ret = request_irq(host->irq, qla2300_intr_handler,
 		    SA_INTERRUPT|SA_SHIRQ, ha->brd_info->drv_name, ha);
-	if (ret != 0) {
+	if (ret) {
 		qla_printk(KERN_WARNING, ha,
 		    "Failed to reserve interrupt %d already in use.\n",
 		    host->irq);
@@ -1363,9 +1357,18 @@ int qla2x00_probe_one(struct pci_dev *pd
 		msleep(10);
 	}
 
+	pci_set_drvdata(pdev, ha);
 	ha->flags.init_done = 1;
 	num_hosts++;
 
+	ret = scsi_add_host(host, &pdev->dev);
+	if (ret)
+		goto probe_failed;
+
+	qla2x00_alloc_sysfs_attr(ha);
+
+	qla2x00_init_host_attr(ha);
+
 	qla_printk(KERN_INFO, ha, "\n"
 	    " QLogic Fibre Channel HBA Driver: %s\n"
 	    "  QLogic %s - %s\n"
@@ -1384,9 +1387,6 @@ int qla2x00_probe_one(struct pci_dev *pd
 probe_failed:
 	fc_remove_host(ha->host);
 
-	scsi_remove_host(host);
-
-probe_alloc_failed:
 	qla2x00_free_device(ha);
 
 	scsi_host_put(host);
@@ -1394,7 +1394,8 @@ probe_alloc_failed:
 probe_disable_device:
 	pci_disable_device(pdev);
 
-	return -1;
+probe_out:
+	return ret;
 }
 EXPORT_SYMBOL_GPL(qla2x00_probe_one);
 
