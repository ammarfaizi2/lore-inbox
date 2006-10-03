Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWJDA3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWJDA3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWJDA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:29:44 -0400
Received: from mail0.lsil.com ([147.145.40.20]:1522 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030530AbWJDA3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:29:42 -0400
Subject: [Patch 1/6] megaraid_sas: FW transition and q size changes
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-OLTp/3k5LLbKYwZGnT4p"
Date: Tue, 03 Oct 2006 12:28:49 -0700
Message-Id: <1159903729.5618.7.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OLTp/3k5LLbKYwZGnT4p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Resubmitting with one addition (item f mentioned below)

This patch has the following enhancements :
        a. handles new transition states of FW to support controller hotplug. 
        b. It reduces by 1 the maximum cmds that the driver may send to FW. 
        c. Sends "Stop Processing" cmd to FW before returning failure from reset routine
        d. Adds print in megasas_transition routine
        e. Sends "RESET" flag to FW to do a soft reset of controller 
to move from Operational to Ready state.
	f. Sending correct pointer (cmd->sense) to pci_pool_free 
          
        This patch has been generated on latest scsi-misc git.

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 10:15:31.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 10:16:40.000000000 -0700
@@ -832,6 +832,12 @@ static int megasas_wait_for_outstanding(
  }
 
  if (atomic_read(&instance->fw_outstanding)) {
+  /*
+  * Send signal to FW to stop processing any pending cmds.
+  * The controller will be taken offline by the OS now.
+  */
+  writel(MFI_STOP_ADP,
+    &instance->reg_set->inbound_doorbell);
   instance->hw_crit_error = 1;
   return FAILED;
  }
@@ -1229,10 +1235,12 @@ megasas_transition_to_ready(struct megas
 
  fw_state = instance->instancet->read_fw_status_reg(instance->reg_set) & MFI_STATE_MASK;
 
+ if (fw_state != MFI_STATE_READY) 
+   printk(KERN_INFO "megasas: Waiting for FW to come to ready"
+          " state\n");
+
  while (fw_state != MFI_STATE_READY) {
 
-  printk(KERN_INFO "megasas: Waiting for FW to come to ready"
-         " state\n");
   switch (fw_state) {
 
 		case MFI_STATE_FAULT:
@@ -1244,19 +1252,27 @@ megasas_transition_to_ready(struct megas
 			/*
 			 * Set the CLR bit in inbound doorbell
 			 */
-			writel(MFI_INIT_CLEAR_HANDSHAKE,
+			writel(MFI_INIT_CLEAR_HANDSHAKE|MFI_INIT_HOTPLUG,
 				&instance->reg_set->inbound_doorbell);
 
 			max_wait = 2;
 			cur_state = MFI_STATE_WAIT_HANDSHAKE;
 			break;
 
+		case MFI_STATE_BOOT_MESSAGE_PENDING:	
+			writel(MFI_INIT_HOTPLUG,
+				&instance->reg_set->inbound_doorbell);
+
+			max_wait = 10;
+			cur_state = MFI_STATE_BOOT_MESSAGE_PENDING;
+			break;
+
 		case MFI_STATE_OPERATIONAL:
 			/*
-			 * Bring it to READY state; assuming max wait 2 secs
+			 * Bring it to READY state; assuming max wait 10 secs
 			 */
 			megasas_disable_intr(instance);
-			writel(MFI_INIT_READY, &instance->reg_set->inbound_doorbell);
+			writel(MFI_RESET_FLAGS, &instance->reg_set->inbound_doorbell);
 
 			max_wait = 10;
 			cur_state = MFI_STATE_OPERATIONAL;
@@ -1323,6 +1339,7 @@ megasas_transition_to_ready(struct megas
 			return -ENODEV;
 		}
 	};
+ 	printk(KERN_INFO "megasas: FW now in Ready state\n");
 
 	return 0;
 }
@@ -1352,7 +1369,7 @@ static void megasas_teardown_frame_pool(
 				      cmd->frame_phys_addr);
 
 		if (cmd->sense)
-			pci_pool_free(instance->sense_dma_pool, cmd->frame,
+			pci_pool_free(instance->sense_dma_pool, cmd->sense,
 				      cmd->sense_phys_addr);
 	}
 
@@ -1690,6 +1707,12 @@ static int megasas_init_mfi(struct megas
 	 * Get various operational parameters from status register
 	 */
 	instance->max_fw_cmds = instance->instancet->read_fw_status_reg(reg_set) & 0x00FFFF;
+	/*
+	 * Reduce the max supported cmds by 1. This is to ensure that the 
+	 * reply_q_sz (1 more than the max cmd that driver may send)
+	 * does not exceed max cmds that the FW can support
+	 */
+	instance->max_fw_cmds = instance->max_fw_cmds-1;
 	instance->max_num_sge = (instance->instancet->read_fw_status_reg(reg_set) & 0xFF0000) >> 
 					0x10;
 	/*
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 10:15:31.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 10:16:13.000000000 -0700
@@ -50,6 +50,7 @@
 #define MFI_STATE_WAIT_HANDSHAKE		0x60000000
 #define MFI_STATE_FW_INIT_2			0x70000000
 #define MFI_STATE_DEVICE_SCAN			0x80000000
+#define MFI_STATE_BOOT_MESSAGE_PENDING		0x90000000
 #define MFI_STATE_FLUSH_CACHE			0xA0000000
 #define MFI_STATE_READY				0xB0000000
 #define MFI_STATE_OPERATIONAL			0xC0000000
@@ -64,12 +65,18 @@
  * READY	: Move from OPERATIONAL to READY state; discard queue info
  * MFIMODE	: Discard (possible) low MFA posted in 64-bit mode (??)
  * CLR_HANDSHAKE: FW is waiting for HANDSHAKE from BIOS or Driver
+ * HOTPLUG	: Resume from Hotplug
+ * MFI_STOP_ADP	: Send signal to FW to stop processing
  */
-#define MFI_INIT_ABORT				0x00000000
+#define MFI_INIT_ABORT				0x00000001
 #define MFI_INIT_READY				0x00000002
 #define MFI_INIT_MFIMODE			0x00000004
 #define MFI_INIT_CLEAR_HANDSHAKE		0x00000008
-#define MFI_RESET_FLAGS    MFI_INIT_READY|MFI_INIT_MFIMODE
+#define MFI_INIT_HOTPLUG   0x00000010
+#define MFI_STOP_ADP    0x00000020
+#define MFI_RESET_FLAGS    MFI_INIT_READY| \
+						MFI_INIT_MFIMODE| \
+						MFI_INIT_ABORT
 
 /**
  * MFI frame flags




--=-OLTp/3k5LLbKYwZGnT4p
Content-Disposition: attachment; filename=fw_changes-p1.patch
Content-Type: text/x-patch; name=fw_changes-p1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 10:15:31.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 10:16:40.000000000 -0700
@@ -832,6 +832,12 @@ static int megasas_wait_for_outstanding(
 	}
 
 	if (atomic_read(&instance->fw_outstanding)) {
+		/*
+		* Send signal to FW to stop processing any pending cmds.
+		* The controller will be taken offline by the OS now.
+		*/
+		writel(MFI_STOP_ADP,
+				&instance->reg_set->inbound_doorbell);
 		instance->hw_crit_error = 1;
 		return FAILED;
 	}
@@ -1229,10 +1235,12 @@ megasas_transition_to_ready(struct megas
 
 	fw_state = instance->instancet->read_fw_status_reg(instance->reg_set) & MFI_STATE_MASK;
 
+	if (fw_state != MFI_STATE_READY) 
+ 		printk(KERN_INFO "megasas: Waiting for FW to come to ready"
+ 		       " state\n");
+
 	while (fw_state != MFI_STATE_READY) {
 
-		printk(KERN_INFO "megasas: Waiting for FW to come to ready"
-		       " state\n");
 		switch (fw_state) {
 
 		case MFI_STATE_FAULT:
@@ -1244,19 +1252,27 @@ megasas_transition_to_ready(struct megas
 			/*
 			 * Set the CLR bit in inbound doorbell
 			 */
-			writel(MFI_INIT_CLEAR_HANDSHAKE,
+			writel(MFI_INIT_CLEAR_HANDSHAKE|MFI_INIT_HOTPLUG,
 				&instance->reg_set->inbound_doorbell);
 
 			max_wait = 2;
 			cur_state = MFI_STATE_WAIT_HANDSHAKE;
 			break;
 
+		case MFI_STATE_BOOT_MESSAGE_PENDING:	
+			writel(MFI_INIT_HOTPLUG,
+				&instance->reg_set->inbound_doorbell);
+
+			max_wait = 10;
+			cur_state = MFI_STATE_BOOT_MESSAGE_PENDING;
+			break;
+
 		case MFI_STATE_OPERATIONAL:
 			/*
-			 * Bring it to READY state; assuming max wait 2 secs
+			 * Bring it to READY state; assuming max wait 10 secs
 			 */
 			megasas_disable_intr(instance);
-			writel(MFI_INIT_READY, &instance->reg_set->inbound_doorbell);
+			writel(MFI_RESET_FLAGS, &instance->reg_set->inbound_doorbell);
 
 			max_wait = 10;
 			cur_state = MFI_STATE_OPERATIONAL;
@@ -1323,6 +1339,7 @@ megasas_transition_to_ready(struct megas
 			return -ENODEV;
 		}
 	};
+ 	printk(KERN_INFO "megasas: FW now in Ready state\n");
 
 	return 0;
 }
@@ -1352,7 +1369,7 @@ static void megasas_teardown_frame_pool(
 				      cmd->frame_phys_addr);
 
 		if (cmd->sense)
-			pci_pool_free(instance->sense_dma_pool, cmd->frame,
+			pci_pool_free(instance->sense_dma_pool, cmd->sense,
 				      cmd->sense_phys_addr);
 	}
 
@@ -1690,6 +1707,12 @@ static int megasas_init_mfi(struct megas
 	 * Get various operational parameters from status register
 	 */
 	instance->max_fw_cmds = instance->instancet->read_fw_status_reg(reg_set) & 0x00FFFF;
+	/*
+	 * Reduce the max supported cmds by 1. This is to ensure that the 
+	 * reply_q_sz (1 more than the max cmd that driver may send)
+	 * does not exceed max cmds that the FW can support
+	 */
+	instance->max_fw_cmds = instance->max_fw_cmds-1;
 	instance->max_num_sge = (instance->instancet->read_fw_status_reg(reg_set) & 0xFF0000) >> 
 					0x10;
 	/*
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 10:15:31.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 10:16:13.000000000 -0700
@@ -50,6 +50,7 @@
 #define MFI_STATE_WAIT_HANDSHAKE		0x60000000
 #define MFI_STATE_FW_INIT_2			0x70000000
 #define MFI_STATE_DEVICE_SCAN			0x80000000
+#define MFI_STATE_BOOT_MESSAGE_PENDING		0x90000000
 #define MFI_STATE_FLUSH_CACHE			0xA0000000
 #define MFI_STATE_READY				0xB0000000
 #define MFI_STATE_OPERATIONAL			0xC0000000
@@ -64,12 +65,18 @@
  * READY	: Move from OPERATIONAL to READY state; discard queue info
  * MFIMODE	: Discard (possible) low MFA posted in 64-bit mode (??)
  * CLR_HANDSHAKE: FW is waiting for HANDSHAKE from BIOS or Driver
+ * HOTPLUG	: Resume from Hotplug
+ * MFI_STOP_ADP	: Send signal to FW to stop processing
  */
-#define MFI_INIT_ABORT				0x00000000
+#define MFI_INIT_ABORT				0x00000001
 #define MFI_INIT_READY				0x00000002
 #define MFI_INIT_MFIMODE			0x00000004
 #define MFI_INIT_CLEAR_HANDSHAKE		0x00000008
-#define MFI_RESET_FLAGS				MFI_INIT_READY|MFI_INIT_MFIMODE
+#define MFI_INIT_HOTPLUG			0x00000010
+#define MFI_STOP_ADP				0x00000020
+#define MFI_RESET_FLAGS				MFI_INIT_READY| \
+						MFI_INIT_MFIMODE| \
+						MFI_INIT_ABORT
 
 /**
  * MFI frame flags

--=-OLTp/3k5LLbKYwZGnT4p--

