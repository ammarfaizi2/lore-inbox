Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWIUBbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWIUBbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWIUBbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:31:37 -0400
Received: from mail0.lsil.com ([147.145.40.20]:57029 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750936AbWIUBbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:31:36 -0400
Subject: [Patch 6/7] megaraid_sas: adds tasklet for cmd completion
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org,
       Neela.Kolli@lsil.com, Bo.Yang@lsil.com
Content-Type: multipart/mixed; boundary="=-pLtG5AwkDorwJKEVUr2Z"
Date: Wed, 20 Sep 2006 19:31:29 -0700
Message-Id: <1158805889.4171.66.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pLtG5AwkDorwJKEVUr2Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds a tasklet for command completion.

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>


diff -uprN linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.c 2006-09-20 15:20:45.000000000 -0700
+++ linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.c 2006-09-20 15:22:28.000000000 -0700
@@ -1273,11 +1273,6 @@ megasas_complete_cmd(struct megasas_inst
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
@@ -1285,23 +1280,10 @@ megasas_deplete_reply_queue(struct megas
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
@@ -1744,6 +1726,39 @@ megasas_get_ctrl_info(struct megasas_ins
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
@@ -1913,6 +1928,12 @@ static int megasas_init_mfi(struct megas
 
 	kfree(ctrl_info);
 
+        /*
+	* Setup tasklet for cmd completion
+	*/
+
+        tasklet_init(&instance->isr_tasklet, megasas_complete_cmd_dpc,
+                        (unsigned long)instance);
 	return 0;
 
       fail_fw_init:
@@ -2502,6 +2523,7 @@ static void megasas_detach_one(struct pc
 	scsi_remove_host(instance->host);
 	megasas_flush_cache(instance);
 	megasas_shutdown_controller(instance);
+	tasklet_kill(&instance->isr_tasklet);
 
 	/*
 	 * Take the instance off the instance array. Note that we will not
diff -uprN linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 15:20:45.000000000 -0700
+++ linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 15:22:28.000000000 -0700
@@ -1102,6 +1102,7 @@ struct megasas_instance {
 	u32 hw_crit_error;
 
  struct megasas_instance_template *instancet;
+ struct tasklet_struct isr_tasklet;
 };
 
 #define MEGASAS_IS_LOGICAL(scp)						\


--=-pLtG5AwkDorwJKEVUr2Z
Content-Disposition: attachment; filename=tasklet-p6.patch
Content-Type: text/x-patch; name=tasklet-p6.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-09-20 15:20:45.000000000 -0700
+++ linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.c	2006-09-20 15:22:28.000000000 -0700
@@ -1273,11 +1273,6 @@ megasas_complete_cmd(struct megasas_inst
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
@@ -1285,23 +1280,10 @@ megasas_deplete_reply_queue(struct megas
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
@@ -1744,6 +1726,39 @@ megasas_get_ctrl_info(struct megasas_ins
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
@@ -1913,6 +1928,12 @@ static int megasas_init_mfi(struct megas
 
 	kfree(ctrl_info);
 
+        /*
+	* Setup tasklet for cmd completion
+	*/
+
+        tasklet_init(&instance->isr_tasklet, megasas_complete_cmd_dpc,
+                        (unsigned long)instance);
 	return 0;
 
       fail_fw_init:
@@ -2502,6 +2523,7 @@ static void megasas_detach_one(struct pc
 	scsi_remove_host(instance->host);
 	megasas_flush_cache(instance);
 	megasas_shutdown_controller(instance);
+	tasklet_kill(&instance->isr_tasklet);
 
 	/*
 	 * Take the instance off the instance array. Note that we will not
diff -uprN linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 15:20:45.000000000 -0700
+++ linux-2.6-new/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 15:22:28.000000000 -0700
@@ -1102,6 +1102,7 @@ struct megasas_instance {
 	u32 hw_crit_error;
 
 	struct megasas_instance_template *instancet;
+	struct tasklet_struct isr_tasklet;
 };
 
 #define MEGASAS_IS_LOGICAL(scp)						\

--=-pLtG5AwkDorwJKEVUr2Z--

