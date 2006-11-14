Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966395AbWKNVrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966395AbWKNVrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966392AbWKNVrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:47:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:62871 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S966389AbWKNVrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:47:15 -0500
Message-ID: <455A395D.1060407@us.ibm.com>
Date: Tue, 14 Nov 2006 13:47:09 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] sas_ata: satisfy libata qc function locking requirements
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ata_qc_complete and ata_sas_queuecmd require that the port lock be held
when they are called.  sas_ata doesn't do this, leading to BUG messages
about qc tags newly allocated qc tags already being in use.  This patch
fixes the locking, which should clean up the rest of those messages.

So far I've tested this against an IBM x206m with two SATA disks with no
BUG messages and no other signs of things going wrong, and the machine
finally passed the pounder stress test.  The patch is against jejb's
aic94xx-sas tree.

--

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index de42b5b..47fb274 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -92,6 +92,7 @@ static void sas_ata_task_done(struct sas
 	struct task_status_struct *stat = &task->task_status;
 	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
 	enum ata_completion_errors ac;
+	unsigned long flags;
 
 	if (stat->stat == SAS_PROTO_RESPONSE) {
 		ata_tf_from_fis(resp->ending_fis, &dev->sata_dev.tf);
@@ -112,7 +113,10 @@ static void sas_ata_task_done(struct sas
 		}
 	}
 
+	spin_lock_irqsave(dev->sata_dev.ap->lock, flags);
 	ata_qc_complete(qc);
+	spin_unlock_irqrestore(dev->sata_dev.ap->lock, flags);
+
 	list_del_init(&task->list);
 	sas_free_task(task);
 }
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 50cc22c..9d4d2ed 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -212,8 +212,12 @@ int sas_queuecommand(struct scsi_cmnd *c
 		struct sas_task *task;
 
 		if (dev_is_sata(dev)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(dev->sata_dev.ap->lock, flags);
 			res = ata_sas_queuecmd(cmd, scsi_done,
 					       dev->sata_dev.ap);
+			spin_unlock_irqrestore(dev->sata_dev.ap->lock, flags);
 			goto out;
 		}
 
