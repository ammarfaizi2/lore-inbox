Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWJDBNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWJDBNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWJDBNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:13:51 -0400
Received: from mail0.lsil.com ([147.145.40.20]:46581 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030549AbWJDBNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:13:49 -0400
Subject: [Patch 5/6] megaraid_sas: adds tasklet for cmd completion
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org,
       Neela.Kolli@lsil.com, boy@lsil.com
Content-Type: multipart/mixed; boundary="=-imzQ5rEI40TFdaDhLSXU"
Date: Tue, 03 Oct 2006 13:13:18 -0700
Message-Id: <1159906398.5618.33.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-imzQ5rEI40TFdaDhLSXU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds a tasklet for command completion.

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 11:17:11.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 11:18:07.000000000 -0700
@@ -1271,11 +1271,6 @@ megasas_complete_cmd(struct megasas_inst
 static int
 megasas_deplete_reply_queue(struct megasas_instance *instance, u8 alt_status)
 {
- u32 producer;
- u32 consumer;
- u32 context;
- struct megasas_cmd *cmd;
-
  /*
   * Check if it is our interrupt
   * Clear the interrupt 
@@ -1283,23 +1278,10 @@ megasas_deplete_reply_queue(struct megas
  if(instance->instancet->clear_intr(instance->reg_set))
   return IRQ_NONE;
 
- producer = *instance->producer;
- consumer = *instance->consumer;
-
- while (consumer != producer) {
-  context = instance->reply_queue[consumer];
-
-		cmd = instance->cmd_list[context];
-
-		megasas_complete_cmd(instance, cmd, alt_status);
-
-		consumer++;
-		if (consumer == (instance->max_fw_cmds + 1)) {
-			consumer = 0;
-		}
-	}
-
-	*instance->consumer = producer;
+        /* 
+	* Schedule the tasklet for cmd completion 
+	*/
+	tasklet_schedule(&instance->isr_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -1742,6 +1724,39 @@ megasas_get_ctrl_info(struct megasas_ins
 }
 
 /**
+ * megasas_complete_cmd_dpc	 -	Returns FW's controller structure
+ * @instance_addr:			Address of adapter soft state
+ *
+ * Tasklet to complete cmds
+ */
+void megasas_complete_cmd_dpc(unsigned long instance_addr)
+{
+	u32 producer;
+	u32 consumer;
+	u32 context;
+	struct megasas_cmd *cmd;
+	struct megasas_instance *instance = (struct megasas_instance *)instance_addr;
+
+	producer = *instance->producer;
+	consumer = *instance->consumer;
+
+	while (consumer != producer) {
+		context = instance->reply_queue[consumer];
+
+		cmd = instance->cmd_list[context];
+
+		megasas_complete_cmd(instance, cmd, DID_OK);
+
+		consumer++;
+		if (consumer == (instance->max_fw_cmds + 1)) {
+			consumer = 0;
+		}
+	}
+
+	*instance->consumer = producer;
+}
+
+/**
  * megasas_init_mfi -	Initializes the FW
  * @instance:		Adapter soft state
  *
@@ -1911,6 +1926,12 @@ static int megasas_init_mfi(struct megas
 
 	kfree(ctrl_info);
 
+        /*
+	* Setup tasklet for cmd completion
+	*/
+
+        tasklet_init(&instance->isr_tasklet, megasas_complete_cmd_dpc,
+                        (unsigned long)instance);
 	return 0;
 
       fail_fw_init:
@@ -2470,6 +2491,7 @@ static void megasas_detach_one(struct pc
 	scsi_remove_host(instance->host);
 	megasas_flush_cache(instance);
 	megasas_shutdown_controller(instance);
+	tasklet_kill(&instance->isr_tasklet);
 
 	/*
 	 * Take the instance off the instance array. Note that we will not
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:17:11.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:18:07.000000000 -0700
@@ -1102,6 +1102,7 @@ struct megasas_instance {
 	u32 hw_crit_error;
 
  struct megasas_instance_template *instancet;
+ struct tasklet_struct isr_tasklet;
 };
 
 #define MEGASAS_IS_LOGICAL(scp)						\


--=-imzQ5rEI40TFdaDhLSXU
Content-Disposition: attachment; filename=tasklet-p5.patch
Content-Type: text/x-patch; name=tasklet-p5.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 11:17:11.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 11:18:07.000000000 -0700
@@ -1271,11 +1271,6 @@ megasas_complete_cmd(struct megasas_inst
 static int
 megasas_deplete_reply_queue(struct megasas_instance *instance, u8 alt_status)
 {
-	u32 producer;
-	u32 consumer;
-	u32 context;
-	struct megasas_cmd *cmd;
-
 	/*
 	 * Check if it is our interrupt
 	 * Clear the interrupt 
@@ -1283,23 +1278,10 @@ megasas_deplete_reply_queue(struct megas
 	if(instance->instancet->clear_intr(instance->reg_set))
 		return IRQ_NONE;
 
-	producer = *instance->producer;
-	consumer = *instance->consumer;
-
-	while (consumer != producer) {
-		context = instance->reply_queue[consumer];
-
-		cmd = instance->cmd_list[context];
-
-		megasas_complete_cmd(instance, cmd, alt_status);
-
-		consumer++;
-		if (consumer == (instance->max_fw_cmds + 1)) {
-			consumer = 0;
-		}
-	}
-
-	*instance->consumer = producer;
+        /* 
+	* Schedule the tasklet for cmd completion 
+	*/
+	tasklet_schedule(&instance->isr_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -1742,6 +1724,39 @@ megasas_get_ctrl_info(struct megasas_ins
 }
 
 /**
+ * megasas_complete_cmd_dpc	 -	Returns FW's controller structure
+ * @instance_addr:			Address of adapter soft state
+ *
+ * Tasklet to complete cmds
+ */
+void megasas_complete_cmd_dpc(unsigned long instance_addr)
+{
+	u32 producer;
+	u32 consumer;
+	u32 context;
+	struct megasas_cmd *cmd;
+	struct megasas_instance *instance = (struct megasas_instance *)instance_addr;
+
+	producer = *instance->producer;
+	consumer = *instance->consumer;
+
+	while (consumer != producer) {
+		context = instance->reply_queue[consumer];
+
+		cmd = instance->cmd_list[context];
+
+		megasas_complete_cmd(instance, cmd, DID_OK);
+
+		consumer++;
+		if (consumer == (instance->max_fw_cmds + 1)) {
+			consumer = 0;
+		}
+	}
+
+	*instance->consumer = producer;
+}
+
+/**
  * megasas_init_mfi -	Initializes the FW
  * @instance:		Adapter soft state
  *
@@ -1911,6 +1926,12 @@ static int megasas_init_mfi(struct megas
 
 	kfree(ctrl_info);
 
+        /*
+	* Setup tasklet for cmd completion
+	*/
+
+        tasklet_init(&instance->isr_tasklet, megasas_complete_cmd_dpc,
+                        (unsigned long)instance);
 	return 0;
 
       fail_fw_init:
@@ -2470,6 +2491,7 @@ static void megasas_detach_one(struct pc
 	scsi_remove_host(instance->host);
 	megasas_flush_cache(instance);
 	megasas_shutdown_controller(instance);
+	tasklet_kill(&instance->isr_tasklet);
 
 	/*
 	 * Take the instance off the instance array. Note that we will not
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:17:11.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:18:07.000000000 -0700
@@ -1102,6 +1102,7 @@ struct megasas_instance {
 	u32 hw_crit_error;
 
 	struct megasas_instance_template *instancet;
+	struct tasklet_struct isr_tasklet;
 };
 
 #define MEGASAS_IS_LOGICAL(scp)						\

--=-imzQ5rEI40TFdaDhLSXU--

