Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWIUBjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWIUBjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWIUBjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:39:51 -0400
Received: from mail0.lsil.com ([147.145.40.20]:39622 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750957AbWIUBju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:39:50 -0400
Subject: [Patch 7/7] megaraid_sas: sets ioctl timeout and updates
	version,changelog
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org,
       Neela.Kolli@lsil.com, Bo.Yang@lsil.com
Content-Type: multipart/mixed; boundary="=-wnH4TvozvNEiVnUHxCas"
Date: Wed, 20 Sep 2006 19:39:42 -0700
Message-Id: <1158806382.4171.76.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wnH4TvozvNEiVnUHxCas
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch sets timeout of max 180 seconds for ioctl completion.
It also updates the Changelog and hikes the version to 3.05.

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux-2.6orig/Documentation/scsi/ChangeLog.megaraid_sas linux-2.6new/Documentation/scsi/ChangeLog.megaraid_sas
--- linux-2.6orig/Documentation/scsi/ChangeLog.megaraid_sas 2006-09-20 11:35:08.000000000 -0700
+++ linux-2.6new/Documentation/scsi/ChangeLog.megaraid_sas 2006-09-20 14:36:36.000000000 -0700
@@ -1,4 +1,46 @@
 
+1 Release Date    : Wed Sep 20 10:06:47 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.05
+3 Older Version   : 00.00.03.04
+
+i. PCI_DEVICE macro used
+
+ Convert the pci_device_id-table of the megaraid_sas-driver to the PCI_DEVICE-macro, to safe some lines.
+
+  - Henrik Kretzschmar <henne@nachtwindheim.de>
+ii. All compiler warnings removed
+iii. megasas_ctrl_info struct reverted to 3.02 release
+iv. Default value of megasas_dbg_lvl set to 0
+v. Removing in megasas_exit the sysfs entry created for megasas_dbg_lvl
+
+1 Release Date    : Wed Sep 13 14:22:51 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.04
+3 Older Version   : 00.00.03.03
+
+i.	Added Reboot notify
+ii.	Reduced by 1 max cmds sent to FW from Driver to make the reply_q_sz same
+	as Max Cmds FW can support
+
+1 Release Date    : Tue Aug 22 16:33:14 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.03
+3 Older Version   : 00.00.03.02
+
+i.	Send stop adapter to FW & Dump pending FW cmds before declaring adapter dead.
+	New varible added to set dbg level.
+ii.	Disable interrupt made as fn pointer as they are different for 1068 / 1078
+iii.	Frame count optimization. Main frame can contain 2 SGE for 64 bit SGLs and 
+	3 SGE for 32 bit SGL
+iv.	Tasklet added for cmd completion
+v.	If FW in operational state before firing INIT, now we send RESET Flag to FW instead of just READY. This is used to do soft reset.
+vi.	megasas_ctrl_prop structure updated (based on FW struct)
+vii.	Added print : FW now in Ready State during initialization
+
+1 Release Date    : Sun Aug 06 22:49:52 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.02
+3 Older Version   : 00.00.03.01
+
+i.	Added FW tranistion state for Hotplug scenario
+
 1 Release Date    : Sun May 14 22:49:52 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.03.01
 3 Older Version   : 00.00.02.04
diff -uprN linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.c	2006-09-20 15:32:51.000000000 -0700
+++ linux-2.6new/drivers/scsi/megaraid/megaraid_sas.c	2006-09-20 15:37:46.000000000 -0700
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.03.01
+ * Version	: v00.00.03.05
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -349,6 +349,7 @@ megasas_issue_polled(struct megasas_inst
  * @cmd:			Command to be issued
  *
  * This function waits on an event for the command to be returned from ISR.
+ * Max wait time is MEGASAS_INTERNAL_CMD_WAIT_TIME secs
  * Used to issue ioctl commands.
  */
 static int
@@ -359,7 +360,8 @@ megasas_issue_blocked_cmd(struct megasas
 
 	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance->reg_set);
 
-	wait_event(instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA));
+	wait_event_timeout(instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA),
+		MEGASAS_INTERNAL_CMD_WAIT_TIME*HZ);
 
 	return 0;
 }
@@ -371,7 +373,8 @@ megasas_issue_blocked_cmd(struct megasas
  *
  * MFI firmware can abort previously issued AEN comamnd (automatic event
  * notification). The megasas_issue_blocked_abort_cmd() issues such abort
- * cmd and blocks till it is completed.
+ * cmd and waits for return status.
+ * Max wait time is MEGASAS_INTERNAL_CMD_WAIT_TIME secs
  */
 static int
 megasas_issue_blocked_abort_cmd(struct megasas_instance *instance,
@@ -405,7 +408,8 @@ megasas_issue_blocked_abort_cmd(struct m
 	/*
 	 * Wait for this cmd to complete
 	 */
-	wait_event(instance->abort_cmd_wait_q, (cmd->cmd_status != 0xFF));
+	wait_event_timeout(instance->abort_cmd_wait_q, (cmd->cmd_status != 0xFF),
+		MEGASAS_INTERNAL_CMD_WAIT_TIME*HZ);
 
 	megasas_return_cmd(instance, cmd);
 	return 0;
diff -uprN linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.h linux-2.6new/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 11:34:07.000000000 -0700
+++ linux-2.6new/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 11:35:30.000000000 -0700
@@ -18,9 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.03.01"
-#define MEGASAS_RELDATE				"May 14, 2006"
-#define MEGASAS_EXT_VERSION			"Sun May 14 22:49:52 PDT 2006"
+#define MEGASAS_VERSION				"00.00.03.05"
+#define MEGASAS_RELDATE				"Sep 20, 2006"
+#define MEGASAS_EXT_VERSION			"Wed Sep 20 10:06:47 PDT 2006"
 
 /*
  * Device IDs
@@ -547,6 +547,7 @@ struct megasas_ctrl_info {
  * every MEGASAS_RESET_NOTICE_INTERVAL seconds
  */
 #define MEGASAS_RESET_WAIT_TIME   180
+#define MEGASAS_INTERNAL_CMD_WAIT_TIME  180
 #define	MEGASAS_RESET_NOTICE_INTERVAL		5
 
 #define MEGASAS_IOCTL_CMD			0


--=-wnH4TvozvNEiVnUHxCas
Content-Disposition: attachment; filename=ioctl_timeout-p7.patch
Content-Type: text/x-patch; name=ioctl_timeout-p7.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6orig/Documentation/scsi/ChangeLog.megaraid_sas linux-2.6new/Documentation/scsi/ChangeLog.megaraid_sas
--- linux-2.6orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-09-20 11:35:08.000000000 -0700
+++ linux-2.6new/Documentation/scsi/ChangeLog.megaraid_sas	2006-09-20 14:36:36.000000000 -0700
@@ -1,4 +1,46 @@
 
+1 Release Date    : Wed Sep 20 10:06:47 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.05
+3 Older Version   : 00.00.03.04
+
+i.	PCI_DEVICE macro used
+
+	Convert the pci_device_id-table of the megaraid_sas-driver to the PCI_DEVICE-macro, to safe some lines.
+
+		- Henrik Kretzschmar <henne@nachtwindheim.de>
+ii.	All compiler warnings removed
+iii.	megasas_ctrl_info struct reverted to 3.02 release
+iv.	Default value of megasas_dbg_lvl set to 0
+v.	Removing in megasas_exit the sysfs entry created for megasas_dbg_lvl
+
+1 Release Date    : Wed Sep 13 14:22:51 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.04
+3 Older Version   : 00.00.03.03
+
+i.	Added Reboot notify
+ii.	Reduced by 1 max cmds sent to FW from Driver to make the reply_q_sz same
+	as Max Cmds FW can support
+
+1 Release Date    : Tue Aug 22 16:33:14 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.03
+3 Older Version   : 00.00.03.02
+
+i.	Send stop adapter to FW & Dump pending FW cmds before declaring adapter dead.
+	New varible added to set dbg level.
+ii.	Disable interrupt made as fn pointer as they are different for 1068 / 1078
+iii.	Frame count optimization. Main frame can contain 2 SGE for 64 bit SGLs and 
+	3 SGE for 32 bit SGL
+iv.	Tasklet added for cmd completion
+v.	If FW in operational state before firing INIT, now we send RESET Flag to FW instead of just READY. This is used to do soft reset.
+vi.	megasas_ctrl_prop structure updated (based on FW struct)
+vii.	Added print : FW now in Ready State during initialization
+
+1 Release Date    : Sun Aug 06 22:49:52 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.03.02
+3 Older Version   : 00.00.03.01
+
+i.	Added FW tranistion state for Hotplug scenario
+
 1 Release Date    : Sun May 14 22:49:52 PDT 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.03.01
 3 Older Version   : 00.00.02.04
diff -uprN linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.c	2006-09-20 15:32:51.000000000 -0700
+++ linux-2.6new/drivers/scsi/megaraid/megaraid_sas.c	2006-09-20 15:37:46.000000000 -0700
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.03.01
+ * Version	: v00.00.03.05
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -349,6 +349,7 @@ megasas_issue_polled(struct megasas_inst
  * @cmd:			Command to be issued
  *
  * This function waits on an event for the command to be returned from ISR.
+ * Max wait time is MEGASAS_INTERNAL_CMD_WAIT_TIME secs
  * Used to issue ioctl commands.
  */
 static int
@@ -359,7 +360,8 @@ megasas_issue_blocked_cmd(struct megasas
 
 	instance->instancet->fire_cmd(cmd->frame_phys_addr ,0,instance->reg_set);
 
-	wait_event(instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA));
+	wait_event_timeout(instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA),
+		MEGASAS_INTERNAL_CMD_WAIT_TIME*HZ);
 
 	return 0;
 }
@@ -371,7 +373,8 @@ megasas_issue_blocked_cmd(struct megasas
  *
  * MFI firmware can abort previously issued AEN comamnd (automatic event
  * notification). The megasas_issue_blocked_abort_cmd() issues such abort
- * cmd and blocks till it is completed.
+ * cmd and waits for return status.
+ * Max wait time is MEGASAS_INTERNAL_CMD_WAIT_TIME secs
  */
 static int
 megasas_issue_blocked_abort_cmd(struct megasas_instance *instance,
@@ -405,7 +408,8 @@ megasas_issue_blocked_abort_cmd(struct m
 	/*
 	 * Wait for this cmd to complete
 	 */
-	wait_event(instance->abort_cmd_wait_q, (cmd->cmd_status != 0xFF));
+	wait_event_timeout(instance->abort_cmd_wait_q, (cmd->cmd_status != 0xFF),
+		MEGASAS_INTERNAL_CMD_WAIT_TIME*HZ);
 
 	megasas_return_cmd(instance, cmd);
 	return 0;
diff -uprN linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.h linux-2.6new/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6orig/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 11:34:07.000000000 -0700
+++ linux-2.6new/drivers/scsi/megaraid/megaraid_sas.h	2006-09-20 11:35:30.000000000 -0700
@@ -18,9 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.03.01"
-#define MEGASAS_RELDATE				"May 14, 2006"
-#define MEGASAS_EXT_VERSION			"Sun May 14 22:49:52 PDT 2006"
+#define MEGASAS_VERSION				"00.00.03.05"
+#define MEGASAS_RELDATE				"Sep 20, 2006"
+#define MEGASAS_EXT_VERSION			"Wed Sep 20 10:06:47 PDT 2006"
 
 /*
  * Device IDs
@@ -547,6 +547,7 @@ struct megasas_ctrl_info {
  * every MEGASAS_RESET_NOTICE_INTERVAL seconds
  */
 #define MEGASAS_RESET_WAIT_TIME			180
+#define MEGASAS_INTERNAL_CMD_WAIT_TIME		180
 #define	MEGASAS_RESET_NOTICE_INTERVAL		5
 
 #define MEGASAS_IOCTL_CMD			0

--=-wnH4TvozvNEiVnUHxCas--

