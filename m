Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966393AbWKNVrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966393AbWKNVrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966392AbWKNVrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:47:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:41397 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S966391AbWKNVrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:47:15 -0500
Message-ID: <455A3960.9070207@us.ibm.com>
Date: Tue, 14 Nov 2006 13:47:12 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] sas_ata: Fix sas_ata_qc_issue to return AC_ERR_*
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mistakenly wrote sas_ata_qc_issue to return error codes such as
ENOMEM.  Since libata OR's qc->err_mask with the return value, I believe
that it is necessary to make my code return one of the AC_ERR_ codes.
For now I'm using AC_ERR_SYSTEM because an error here means that the
command couldn't be sent to the controller.  Patch is against jejb's
aic94xx-sas tree.

If anybody has a suggestion for a better AC_ERR_ code to use, please
suggest it.

--

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 47fb274..9208b8b 100644
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
@@ -187,12 +187,10 @@ static unsigned int sas_ata_qc_issue(str
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
