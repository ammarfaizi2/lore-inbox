Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755913AbWKQVDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbWKQVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbWKQVBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40890 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755906AbWKQVBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:38 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 07/15] sas_ata: Satisfy libata qc function locking requirements
Date: Fri, 17 Nov 2006 13:08:06 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210806.17052.54460.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ata_qc_complete and ata_sas_queuecmd require that the port lock be held
when they are called.  sas_ata doesn't do this, leading to BUG messages
about qc tags newly allocated qc tags already being in use.  This patch
fixes the locking, which should clean up the rest of those messages.

So far I've tested this against an IBM x206m with two SATA disks with no
BUG messages and no other signs of things going wrong, and the machine
finally passed the pounder stress test.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_ata.c       |    4 ++++
 drivers/scsi/libsas/sas_scsi_host.c |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index f92f035..32f2b66 100644
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
index a88d3a4..25639b5 100644
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
 
