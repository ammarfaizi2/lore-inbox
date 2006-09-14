Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWINVNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWINVNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWINVNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:13:05 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:33256 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751137AbWINVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:13:04 -0400
Subject: [GIT PATCH] (hopefully) final SCSI fixes for 2.6.19
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 16:12:58 -0500
Message-Id: <1158268378.3514.61.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is here

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

However, as there's only a single patch in there, I attach it in case
you'd prefer simply to apply it as a patch rather than merge a single
patch tree.

James

---

commit 15d100224c123f0f993ef88e95fd5d46bb0bd085
Author: James Smart <James.Smart@Emulex.Com>
Date:   Thu Aug 31 12:27:57 2006 -0400

    [SCSI] lpfc: don't free mempool if mailbox is busy
    
    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f6948ff..c31fe41 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -387,7 +387,8 @@ lpfc_config_port_post(struct lpfc_hba * 
 
 	lpfc_init_link(phba, pmb, phba->cfg_topology, phba->cfg_link_speed);
 	pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
-	if (lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT) != MBX_SUCCESS) {
+	rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
+	if (rc != MBX_SUCCESS) {
 		lpfc_printf_log(phba,
 				KERN_ERR,
 				LOG_INIT,
@@ -404,7 +405,8 @@ lpfc_config_port_post(struct lpfc_hba * 
 		readl(phba->HAregaddr); /* flush */
 
 		phba->hba_state = LPFC_HBA_ERROR;
-		mempool_free(pmb, phba->mbox_mem_pool);
+		if (rc != MBX_BUSY)
+			mempool_free(pmb, phba->mbox_mem_pool);
 		return -EIO;
 	}
 	/* MBOX buffer will be freed in mbox compl */


