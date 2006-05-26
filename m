Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWEZSXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWEZSXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWEZSXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:23:48 -0400
Received: from mail0.lsil.com ([147.145.40.20]:6863 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751240AbWEZSXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:23:48 -0400
Subject: [Patch 1/2] megaraid_sas: switch fw_outstanding to an atomic_t
From: Sumant Patro <sumantp@lsil.com>
To: linux-kernel@vger.kernel.org
Cc: hch@lst.de
Content-Type: multipart/mixed; boundary="=-rUBiq71EDW0bWZsnmABl"
Date: Fri, 26 May 2006 12:27:04 -0700
Message-Id: <1148671624.8277.9.camel@dhcp80-125.lsil.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rUBiq71EDW0bWZsnmABl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,

 	This patch( originally submitted by Christoph Hellwig) removes instance_lock
and changes fw_outstanding variable data type to atomic_t.

	Patch is made against the latest git snapshot of scsi-misc-2.6 tree.

Thanks,

Sumant Patro

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux-2.6.17-rc4-orig/Documentation/scsi/ChangeLog.megaraid_sas linux-2.6.17-rc4-new/Documentation/scsi/ChangeLog.megaraid_sas
--- linux-2.6.17-rc4-orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-05-25 12:10:34.000000000 -0700
+++ linux-2.6.17-rc4-new/Documentation/scsi/ChangeLog.megaraid_sas	2006-05-25 18:00:02.000000000 -0700
@@ -1,3 +1,16 @@
+
+1 Release Date    : Wed Feb 03 14:31:44 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.04
+3 Older Version   : 00.00.02.04 
+
+i.	Remove superflous instance_lock
+
+	gets rid of the otherwise superflous instance_lock and avoids an unsave 
+	unsynchronized access in the error handler.
+
+		- Christoph Hellwig <hch@lst.de>
+
+
 1 Release Date    : Wed Feb 03 14:31:44 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.04
 3 Older Version   : 00.00.02.04 
diff -uprN linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-05-25 12:06:03.000000000 -0700
+++ linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.c	2006-05-25 17:03:14.000000000 -0700
@@ -741,7 +741,6 @@ static int
 megasas_queue_command(struct scsi_cmnd *scmd, void (*done) (struct scsi_cmnd *))
 {
 	u32 frame_count;
-	unsigned long flags;
 	struct megasas_cmd *cmd;
 	struct megasas_instance *instance;
 
@@ -776,9 +775,7 @@ megasas_queue_command(struct scsi_cmnd *
 	/*
 	 * Issue the command to the FW
 	 */
-	spin_lock_irqsave(&instance->instance_lock, flags);
-	instance->fw_outstanding++;
-	spin_unlock_irqrestore(&instance->instance_lock, flags);
+	atomic_inc(&instance->fw_outstanding);
 
 	instance->instancet->fire_cmd(cmd->frame_phys_addr ,cmd->frame_count-1,instance->reg_set);
 
@@ -826,19 +823,20 @@ static int megasas_wait_for_outstanding(
 
 	for (i = 0; i < wait_time; i++) {
 
-		if (!instance->fw_outstanding)
+		int outstanding = atomic_read(&instance->fw_outstanding);
+
+		if (!outstanding)
 			break;
 
 		if (!(i % MEGASAS_RESET_NOTICE_INTERVAL)) {
 			printk(KERN_NOTICE "megasas: [%2d]waiting for %d "
-			       "commands to complete\n", i,
-			       instance->fw_outstanding);
+			       "commands to complete\n",i,outstanding);
 		}
 
 		msleep(1000);
 	}
 
-	if (instance->fw_outstanding) {
+	if (atomic_read(&instance->fw_outstanding)) {
 		instance->hw_crit_error = 1;
 		return FAILED;
 	}
@@ -1050,7 +1048,6 @@ megasas_complete_cmd(struct megasas_inst
 {
 	int exception = 0;
 	struct megasas_header *hdr = &cmd->frame->hdr;
-	unsigned long flags;
 
 	if (cmd->scmd) {
 		cmd->scmd->SCp.ptr = (char *)0;
@@ -1082,9 +1079,7 @@ megasas_complete_cmd(struct megasas_inst
 
 		if (exception) {
 
-			spin_lock_irqsave(&instance->instance_lock, flags);
-			instance->fw_outstanding--;
-			spin_unlock_irqrestore(&instance->instance_lock, flags);
+			atomic_dec(&instance->fw_outstanding);
 
 			megasas_unmap_sgbuf(instance, cmd);
 			cmd->scmd->scsi_done(cmd->scmd);
@@ -1132,9 +1127,7 @@ megasas_complete_cmd(struct megasas_inst
 			break;
 		}
 
-		spin_lock_irqsave(&instance->instance_lock, flags);
-		instance->fw_outstanding--;
-		spin_unlock_irqrestore(&instance->instance_lock, flags);
+		atomic_dec(&instance->fw_outstanding);
 
 		megasas_unmap_sgbuf(instance, cmd);
 		cmd->scmd->scsi_done(cmd->scmd);
@@ -2171,11 +2164,12 @@ megasas_probe_one(struct pci_dev *pdev, 
 	 */
 	INIT_LIST_HEAD(&instance->cmd_pool);
 
+	atomic_set(&instance->fw_outstanding,0);
+
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
 	spin_lock_init(&instance->cmd_pool_lock);
-	spin_lock_init(&instance->instance_lock);
 
 	sema_init(&instance->aen_mutex, 1);
 	sema_init(&instance->ioctl_sem, MEGASAS_INT_CMDS);
diff -uprN linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.h linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-05-25 12:06:03.000000000 -0700
+++ linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.h	2006-05-25 17:04:02.000000000 -0700
@@ -1077,9 +1077,8 @@ struct megasas_instance {
 	struct pci_dev *pdev;
 	u32 unique_id;
 
-	u32 fw_outstanding;
+	atomic_t fw_outstanding;
 	u32 hw_crit_error;
-	spinlock_t instance_lock;
 
 	struct megasas_instance_template *instancet;
 };


--=-rUBiq71EDW0bWZsnmABl
Content-Disposition: attachment; filename=megaraid_sas_remove_lock.patch
Content-Type: text/x-patch; name=megaraid_sas_remove_lock.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6.17-rc4-orig/Documentation/scsi/ChangeLog.megaraid_sas linux-2.6.17-rc4-new/Documentation/scsi/ChangeLog.megaraid_sas
--- linux-2.6.17-rc4-orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-05-25 12:10:34.000000000 -0700
+++ linux-2.6.17-rc4-new/Documentation/scsi/ChangeLog.megaraid_sas	2006-05-25 18:00:02.000000000 -0700
@@ -1,3 +1,16 @@
+
+1 Release Date    : Wed Feb 03 14:31:44 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.04
+3 Older Version   : 00.00.02.04 
+
+i.	Remove superflous instance_lock
+
+	gets rid of the otherwise superflous instance_lock and avoids an unsave 
+	unsynchronized access in the error handler.
+
+		- Christoph Hellwig <hch@lst.de>
+
+
 1 Release Date    : Wed Feb 03 14:31:44 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.04
 3 Older Version   : 00.00.02.04 
diff -uprN linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-05-25 12:06:03.000000000 -0700
+++ linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.c	2006-05-25 17:03:14.000000000 -0700
@@ -741,7 +741,6 @@ static int
 megasas_queue_command(struct scsi_cmnd *scmd, void (*done) (struct scsi_cmnd *))
 {
 	u32 frame_count;
-	unsigned long flags;
 	struct megasas_cmd *cmd;
 	struct megasas_instance *instance;
 
@@ -776,9 +775,7 @@ megasas_queue_command(struct scsi_cmnd *
 	/*
 	 * Issue the command to the FW
 	 */
-	spin_lock_irqsave(&instance->instance_lock, flags);
-	instance->fw_outstanding++;
-	spin_unlock_irqrestore(&instance->instance_lock, flags);
+	atomic_inc(&instance->fw_outstanding);
 
 	instance->instancet->fire_cmd(cmd->frame_phys_addr ,cmd->frame_count-1,instance->reg_set);
 
@@ -826,19 +823,20 @@ static int megasas_wait_for_outstanding(
 
 	for (i = 0; i < wait_time; i++) {
 
-		if (!instance->fw_outstanding)
+		int outstanding = atomic_read(&instance->fw_outstanding);
+
+		if (!outstanding)
 			break;
 
 		if (!(i % MEGASAS_RESET_NOTICE_INTERVAL)) {
 			printk(KERN_NOTICE "megasas: [%2d]waiting for %d "
-			       "commands to complete\n", i,
-			       instance->fw_outstanding);
+			       "commands to complete\n",i,outstanding);
 		}
 
 		msleep(1000);
 	}
 
-	if (instance->fw_outstanding) {
+	if (atomic_read(&instance->fw_outstanding)) {
 		instance->hw_crit_error = 1;
 		return FAILED;
 	}
@@ -1050,7 +1048,6 @@ megasas_complete_cmd(struct megasas_inst
 {
 	int exception = 0;
 	struct megasas_header *hdr = &cmd->frame->hdr;
-	unsigned long flags;
 
 	if (cmd->scmd) {
 		cmd->scmd->SCp.ptr = (char *)0;
@@ -1082,9 +1079,7 @@ megasas_complete_cmd(struct megasas_inst
 
 		if (exception) {
 
-			spin_lock_irqsave(&instance->instance_lock, flags);
-			instance->fw_outstanding--;
-			spin_unlock_irqrestore(&instance->instance_lock, flags);
+			atomic_dec(&instance->fw_outstanding);
 
 			megasas_unmap_sgbuf(instance, cmd);
 			cmd->scmd->scsi_done(cmd->scmd);
@@ -1132,9 +1127,7 @@ megasas_complete_cmd(struct megasas_inst
 			break;
 		}
 
-		spin_lock_irqsave(&instance->instance_lock, flags);
-		instance->fw_outstanding--;
-		spin_unlock_irqrestore(&instance->instance_lock, flags);
+		atomic_dec(&instance->fw_outstanding);
 
 		megasas_unmap_sgbuf(instance, cmd);
 		cmd->scmd->scsi_done(cmd->scmd);
@@ -2171,11 +2164,12 @@ megasas_probe_one(struct pci_dev *pdev, 
 	 */
 	INIT_LIST_HEAD(&instance->cmd_pool);
 
+	atomic_set(&instance->fw_outstanding,0);
+
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
 	spin_lock_init(&instance->cmd_pool_lock);
-	spin_lock_init(&instance->instance_lock);
 
 	sema_init(&instance->aen_mutex, 1);
 	sema_init(&instance->ioctl_sem, MEGASAS_INT_CMDS);
diff -uprN linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.h linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6.17-rc4-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-05-25 12:06:03.000000000 -0700
+++ linux-2.6.17-rc4-new/drivers/scsi/megaraid/megaraid_sas.h	2006-05-25 17:04:02.000000000 -0700
@@ -1077,9 +1077,8 @@ struct megasas_instance {
 	struct pci_dev *pdev;
 	u32 unique_id;
 
-	u32 fw_outstanding;
+	atomic_t fw_outstanding;
 	u32 hw_crit_error;
-	spinlock_t instance_lock;
 
 	struct megasas_instance_template *instancet;
 };

--=-rUBiq71EDW0bWZsnmABl--

