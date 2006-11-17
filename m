Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755922AbWKQVCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbWKQVCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbWKQVCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:02:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:40097 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755923AbWKQVCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:02:05 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 15/15] sas_ata: Make this a module separate from libsas
Date: Fri, 17 Nov 2006 13:08:33 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210833.17052.41537.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Break out sas_ata as a free-standing module that provides a SATA
Translation Layer (SATL) for libsas.  This patch requires the libsas
SATL registration patch; the changes to sas_ata itself are rather
minor.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/Makefile  |    5 +++--
 drivers/scsi/libsas/sas_ata.c |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/libsas/Makefile b/drivers/scsi/libsas/Makefile
index 6383eb5..5e95902 100644
--- a/drivers/scsi/libsas/Makefile
+++ b/drivers/scsi/libsas/Makefile
@@ -33,5 +33,6 @@ libsas-y +=  sas_init.o     \
 		sas_dump.o     \
 		sas_discover.o \
 		sas_expander.o \
-		sas_scsi_host.o \
-		sas_ata.o
+		sas_scsi_host.o
+
+obj-$(CONFIG_SCSI_SAS_SATL) += sas_ata.o
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 7338775..bfaee88 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -398,8 +398,8 @@ static struct ata_port_info sata_port_in
 	.port_ops = &sas_sata_ops
 };
 
-int sas_ata_init_host_and_port(struct domain_device *found_dev,
-			       struct scsi_target *starget)
+static int sas_ata_init_host_and_port(struct domain_device *found_dev,
+				      struct scsi_target *starget)
 {
 	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
 	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
@@ -424,3 +424,33 @@ int sas_ata_init_host_and_port(struct do
 
 	return 0;
 }
+
+/* Module initialization */
+static struct satl_operations sas_ata_ops = {
+	.owner			= THIS_MODULE,
+	.init_target		= sas_ata_init_host_and_port,
+	.queuecommand		= ata_sas_queuecmd,
+	.ioctl			= ata_scsi_ioctl,
+	.configure_port		= ata_sas_slave_configure,
+	.deactivate_port	= ata_port_disable,
+	.destroy_port		= ata_sas_port_destroy,
+	.init_port		= ata_sas_port_init
+};
+
+static int __init sas_ata_init(void)
+{
+	return sas_register_satl(&sas_ata_ops);
+}
+
+static void __exit sas_ata_exit(void)
+{
+	sas_unregister_satl(&sas_ata_ops);
+}
+
+module_init(sas_ata_init);
+module_exit(sas_ata_exit);
+
+MODULE_AUTHOR("Darrick Wong <djwong@us.ibm.com>");
+MODULE_DESCRIPTION("libata SATL for SAS");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("1.0");
