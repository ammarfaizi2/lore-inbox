Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422869AbWJLQ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWJLQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422867AbWJLQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:57:38 -0400
Received: from pat.qlogic.com ([198.70.193.2]:52491 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S1422862AbWJLQ5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:57:37 -0400
Date: Thu, 12 Oct 2006 09:57:35 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI/qla2xxx: handle sysfs errors
Message-ID: <20061012165734.GG3638@andrew-vasquezs-computer.local>
References: <20061012014538.GA12894@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012014538.GA12894@havoc.gtf.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 12 Oct 2006 16:57:36.0456 (UTC) FILETIME=[84B61480:01C6EE1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006, Jeff Garzik wrote:

> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
>  drivers/scsi/qla2xxx/qla_attr.c |   52 +++++++++++++++++++++++++++++++---------
>  drivers/scsi/qla2xxx/qla_gbl.h  |    4 ---
>  drivers/scsi/qla2xxx/qla_os.c   |    7 ++++-
> 
> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
> index ee75a71..54e4a60 100644
> --- a/drivers/scsi/qla2xxx/qla_attr.c
> +++ b/drivers/scsi/qla2xxx/qla_attr.c
> @@ -379,22 +379,52 @@ static struct bin_attribute sysfs_sfp_at
>  	.read = qla2x00_sysfs_read_sfp,
>  };
>  
> -void
> +int
>  qla2x00_alloc_sysfs_attr(scsi_qla_host_t *ha)
>  {
>  	struct Scsi_Host *host = ha->host;
> -
> -	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_fw_dump_attr);
> -	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_nvram_attr);
> -	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_optrom_attr);
> -	sysfs_create_bin_file(&host->shost_gendev.kobj,
> -	    &sysfs_optrom_ctl_attr);
> +	int rc;
> +
> +	rc = sysfs_create_bin_file(&host->shost_gendev.kobj,
> +				   &sysfs_fw_dump_attr);
> +	if (rc) goto err;

NACK, please don't do this.  SYSFS entries, albiet important, aren't
necessarilly critical to a functioning driver.  I'd rather the driver
not error out.

Here's what I had stewing to address the must_check directives and
qla2xxx:

---

qla2xxx: Check return value of sysfs_create_bin_file() usage.

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
---
 drivers/scsi/qla2xxx/qla_attr.c |   51 ++++++++++++++++++++++++--------------
 1 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index ee75a71..285c8e8 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -379,21 +379,37 @@ static struct bin_attribute sysfs_sfp_at
 	.read = qla2x00_sysfs_read_sfp,
 };
 
+static struct sysfs_entry {
+	char *name;
+	struct bin_attribute *attr;
+	int is4GBp_only;
+} bin_file_entries[] = {
+	{ "fw_dump", &sysfs_fw_dump_attr, },
+	{ "nvram", &sysfs_nvram_attr, },
+	{ "optrom", &sysfs_optrom_attr, },
+	{ "optrom_ctl", &sysfs_optrom_ctl_attr, },
+	{ "vpd", &sysfs_vpd_attr, 1 },
+	{ "sfp", &sysfs_sfp_attr, 1 },
+	{ 0 },
+};
+
 void
 qla2x00_alloc_sysfs_attr(scsi_qla_host_t *ha)
 {
 	struct Scsi_Host *host = ha->host;
+	struct sysfs_entry *iter;
+	int ret;
 
-	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_fw_dump_attr);
-	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_nvram_attr);
-	sysfs_create_bin_file(&host->shost_gendev.kobj, &sysfs_optrom_attr);
-	sysfs_create_bin_file(&host->shost_gendev.kobj,
-	    &sysfs_optrom_ctl_attr);
-	if (IS_QLA24XX(ha) || IS_QLA54XX(ha)) {
-		sysfs_create_bin_file(&host->shost_gendev.kobj,
-		    &sysfs_vpd_attr);
-		sysfs_create_bin_file(&host->shost_gendev.kobj,
-		    &sysfs_sfp_attr);
+	for (iter = bin_file_entries; iter->name; iter++) {
+		if (iter->is4GBp_only && (!IS_QLA24XX(ha) && !IS_QLA54XX(ha)))
+			continue;
+
+		ret = sysfs_create_bin_file(&host->shost_gendev.kobj,
+		    iter->attr);
+		if (ret)
+			qla_printk(KERN_INFO, ha,
+			    "Unable to create sysfs %s binary attribute "
+			    "(%d).\n", iter->name, ret);
 	}
 }
 
@@ -401,17 +417,14 @@ void
 qla2x00_free_sysfs_attr(scsi_qla_host_t *ha)
 {
 	struct Scsi_Host *host = ha->host;
+	struct sysfs_entry *iter;
+
+	for (iter = bin_file_entries; iter->name; iter++) {
+		if (iter->is4GBp_only && (!IS_QLA24XX(ha) && !IS_QLA54XX(ha)))
+			continue;
 
-	sysfs_remove_bin_file(&host->shost_gendev.kobj, &sysfs_fw_dump_attr);
-	sysfs_remove_bin_file(&host->shost_gendev.kobj, &sysfs_nvram_attr);
-	sysfs_remove_bin_file(&host->shost_gendev.kobj, &sysfs_optrom_attr);
-	sysfs_remove_bin_file(&host->shost_gendev.kobj,
-	    &sysfs_optrom_ctl_attr);
-	if (IS_QLA24XX(ha) || IS_QLA54XX(ha)) {
-		sysfs_remove_bin_file(&host->shost_gendev.kobj,
-		    &sysfs_vpd_attr);
 		sysfs_remove_bin_file(&host->shost_gendev.kobj,
-		    &sysfs_sfp_attr);
+		    iter->attr);
 	}
 
 	if (ha->beacon_blink_led == 1)
-- 
1.4.3.rc2.g0503

