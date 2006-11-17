Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933766AbWKQVFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbWKQVFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933762AbWKQVFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:05:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:50618 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755915AbWKQVBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:46 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 08/15] sas_ata: sas_ata_qc_issue should return AC_ERR_*
Date: Fri, 17 Nov 2006 13:08:09 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210809.17052.22332.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sas_ata_qc_issue function was incorrectly written to return error
codes such as -ENOMEM.  Since libata OR's qc->err_mask with the
return value, It is necessary to make my code return one of the
AC_ERR_ codes instead.  For now, use AC_ERR_SYSTEM because an error
here means that the OS couldn't send the command to the controller.

If anybody has a suggestion for a better AC_ERR_ code to use, please
suggest it.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_ata.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 32f2b66..a33ef6d 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -123,7 +123,7 @@ static void sas_ata_task_done(struct sas
 
 static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 {
-	int res = -ENOMEM;
+	int res;
 	struct sas_task *task;
 	struct domain_device *dev = qc->ap->private_data;
 	struct sas_ha_struct *sas_ha = dev->port->ha;
@@ -135,7 +135,7 @@ static unsigned int sas_ata_qc_issue(str
 
 	task = sas_alloc_task(GFP_ATOMIC);
 	if (!task)
-		goto out;
+		return AC_ERR_SYSTEM;
 	task->dev = dev;
 	task->task_proto = SAS_PROTOCOL_STP;
 	task->task_done = sas_ata_task_done;
@@ -186,12 +186,10 @@ static unsigned int sas_ata_qc_issue(str
 		SAS_DPRINTK("lldd_execute_task returned: %d\n", res);
 
 		sas_free_task(task);
-		if (res == -SAS_QUEUE_FULL)
-			return -ENOMEM;
+		return AC_ERR_SYSTEM;
 	}
 
-out:
-	return res;
+	return 0;
 }
 
 static u8 sas_ata_check_status(struct ata_port *ap)
