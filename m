Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWAYTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWAYTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWAYTvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:51:25 -0500
Received: from mail0.lsil.com ([147.145.40.20]:4818 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751144AbWAYTvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:51:23 -0500
Subject: [PATCH 1/3] megaraid_sas: cleanup queue command path
From: Sumant Patro <sumantp@lsil.com>
To: hch@lst.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Cc: sreenib@lsil.com, Neela.kolli@lsil.com, Bo.Yang@lsil.com,
       hdoelfel@lsil.com
Content-Type: multipart/mixed; boundary="=-gbhwNGf0sb90xnNCJ0er"
Date: Wed, 25 Jan 2006 11:53:25 -0800
Message-Id: <1138218805.6383.6.camel@dhcp80-31.lsil.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gbhwNGf0sb90xnNCJ0er
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,

	Resending the patch as I did not get any response for previous
submission of the patch.
	This patch (originally submitted by Christoph Hellwig) removes code
duplication in megasas_build_cmd.
	It also defines MEGASAS_IOC_FIRMWARE32 to allow 64 bit compiled
applications to work.
	Patch is made against the latest git snapshot of scsi-misc-2.6 tree.

Thanks,

Sumant Patro

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas
linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas 1969-12-31
16:00:00.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas 2006-01-19
17:52:39.000000000 -0800
@@ -0,0 +1,15 @@
+1 Release Date    : Mon Dec 19 14:36:26 PST 2005 - Sumant Patro
<Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.00-rc4 
+3 Older Version   : 00.00.02.01 
+
+i. Code reorganized to remove code duplication in megasas_build_cmd. 
+
+ "There's a lot of duplicate code megasas_build_cmd.  Move that out of
the different codepathes and merge the reminder of megasas_build_cmd
into megasas_queue_command"
+
+ - Christoph Hellwig <hch@lst.de>
+
+ii. Defined MEGASAS_IOC_FIRMWARE32 for code paths that handles 32 bit
applications in 64 bit systems.
+
+ "MEGASAS_IOC_FIRMWARE can't be redefined if CONFIG_COMPAT is set, we
need to define a MEGASAS_IOC_FIRMWARE32 define so native binaries
continue to work"
+
+ - Christoph Hellwig <hch@lst.de>
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c
linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c 2006-01-19
16:47:01.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c 2006-01-19
17:52:20.000000000 -0800
@@ -10,7 +10,7 @@
  *    2 of the License, or (at your option) any later version.
  *
  * FILE : megaraid_sas.c
- * Version : v00.00.02.00-rc4
+ * Version : v00.00.02.01
  *
  * Authors:
  * Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
@@ -558,112 +558,29 @@ megasas_build_ldio(struct megasas_instan
}

/**
- * megasas_build_cmd - Prepares a command packet
- * @instance: Adapter soft state
- * @scp: SCSI command
- * @frame_count: [OUT] Number of frames used to prepare this command
+ * megasas_is_ldio - Checks if the cmd is for logical drive
+ * @scmd: SCSI command
+ * 
+ * Called by megasas_queue_command to find out if the command to be
queued
+ * is a logical drive command 
  */
-static inline struct megasas_cmd *megasas_build_cmd(struct
megasas_instance
-     *instance,
-     struct scsi_cmnd *scp,
-     int *frame_count)
+static inline int megasas_is_ldio(struct scsi_cmnd *cmd)
{
- u32 logical_cmd;
- struct megasas_cmd *cmd;
-
- /*
- * Find out if this is logical or physical drive command.
- */
- logical_cmd = MEGASAS_IS_LOGICAL(scp);
-
- /*
- * Logical drive command
- */
- if (logical_cmd) {
-
- if (scp->device->id >= MEGASAS_MAX_LD) {
- scp->result = DID_BAD_TARGET << 16;
- return NULL;
- }
-
- switch (scp->cmnd[0]) {
-
- case READ_10:
- case WRITE_10:
- case READ_12:
- case WRITE_12:
- case READ_6:
- case WRITE_6:
- case READ_16:
- case WRITE_16:
- /*
- * Fail for LUN > 0
- */
- if (scp->device->lun) {
- scp->result = DID_BAD_TARGET << 16;
- return NULL;
- }
-
- cmd = megasas_get_cmd(instance);
-
- if (!cmd) {
- scp->result = DID_IMM_RETRY << 16;
- return NULL;
- }
-
- *frame_count = megasas_build_ldio(instance, scp, cmd);
-
- if (!(*frame_count)) {
- megasas_return_cmd(instance, cmd);
- return NULL;
- }
-
- return cmd;
-
- default:
- /*
- * Fail for LUN > 0
- */
- if (scp->device->lun) {
- scp->result = DID_BAD_TARGET << 16;
- return NULL;
- }
-
- cmd = megasas_get_cmd(instance);
-
- if (!cmd) {
- scp->result = DID_IMM_RETRY << 16;
- return NULL;
- }
-
- *frame_count = megasas_build_dcdb(instance, scp, cmd);
-
- if (!(*frame_count)) {
- megasas_return_cmd(instance, cmd);
- return NULL;
- }
-
- return cmd;
- }
- } else {
- cmd = megasas_get_cmd(instance);
-
- if (!cmd) {
- scp->result = DID_IMM_RETRY << 16;
- return NULL;
- }
-
- *frame_count = megasas_build_dcdb(instance, scp, cmd);
-
- if (!(*frame_count)) {
- megasas_return_cmd(instance, cmd);
- return NULL;
- }
-
- return cmd;
+ if (!MEGASAS_IS_LOGICAL(cmd))
+ return 0;
+ switch (cmd->cmnd[0]) {
+ case READ_10:
+ case WRITE_10:
+ case READ_12:
+ case WRITE_12:
+ case READ_6:
+ case WRITE_6:
+ case READ_16:
+ case WRITE_16:
+ return 1;
+ default:
+ return 0;
}
-
- return NULL;
}

/**
@@ -684,13 +601,27 @@ megasas_queue_command(struct scsi_cmnd *
scmd->scsi_done = done;
scmd->result = 0;

- cmd = megasas_build_cmd(instance, scmd, &frame_count);
-
- if (!cmd) {
- done(scmd);
- return 0;
+ if (MEGASAS_IS_LOGICAL(scmd) &&
+     (scmd->device->id >= MEGASAS_MAX_LD || scmd->device->lun)) {
+ scmd->result = DID_BAD_TARGET << 16;
+ goto out_done;
}

+ cmd = megasas_get_cmd(instance);
+ if (!cmd)
+ return SCSI_MLQUEUE_HOST_BUSY;
+
+ /*
+ * Logical drive command
+ */
+ if (megasas_is_ldio(scmd))
+ frame_count = megasas_build_ldio(instance, scmd, cmd);
+ else
+ frame_count = megasas_build_dcdb(instance, scmd, cmd);
+
+ if (!frame_count)
+ goto out_return_cmd;
+
cmd->scmd = scmd;
scmd->SCp.ptr = (char *)cmd;
scmd->SCp.sent_command = jiffies;
@@ -706,6 +637,12 @@ megasas_queue_command(struct scsi_cmnd *
       &instance->reg_set->inbound_queue_port);

return 0;
+
+ out_return_cmd:
+ megasas_return_cmd(instance, cmd);
+ out_done:
+ done(scmd);
+ return 0;
}

/**
@@ -2681,9 +2618,8 @@ megasas_mgmt_compat_ioctl(struct file *f
  unsigned long arg)
{
switch (cmd) {
- case MEGASAS_IOC_FIRMWARE:{
- return megasas_mgmt_compat_ioctl_fw(file, arg);
- }
+ case MEGASAS_IOC_FIRMWARE32:
+ return megasas_mgmt_compat_ioctl_fw(file, arg);
case MEGASAS_IOC_GET_AEN:
return megasas_mgmt_ioctl_aen(file, arg);
}
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h
linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h 2006-01-19
16:47:01.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h 2006-01-19
17:52:20.000000000 -0800
@@ -18,10 +18,9 @@
/**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION "00.00.02.00-rc4"
-#define MEGASAS_RELDATE "Sep 16, 2005"
-#define MEGASAS_EXT_VERSION "Fri Sep 16 12:37:08 EDT 2005"
-
+#define MEGASAS_VERSION "00.00.02.01"
+#define MEGASAS_RELDATE "Dec 19, 2005"
+#define MEGASAS_EXT_VERSION "Mon Dec 19 14:36:26 PST 2005"
/*
  * =====================================
  * MegaRAID SAS MFI firmware definitions
@@ -1125,11 +1124,10 @@ struct compat_megasas_iocpacket {
struct compat_iovec sgl[MAX_IOCTL_SGE];
} __attribute__ ((packed));

-#define MEGASAS_IOC_FIRMWARE _IOWR('M', 1, struct
compat_megasas_iocpacket)
-#else
-#define MEGASAS_IOC_FIRMWARE _IOWR('M', 1, struct megasas_iocpacket)
#endif

+#define MEGASAS_IOC_FIRMWARE _IOWR('M', 1, struct megasas_iocpacket)
+#define MEGASAS_IOC_FIRMWARE32 _IOWR('M', 1, struct
compat_megasas_iocpacket)
#define MEGASAS_IOC_GET_AEN _IOW('M', 3, struct megasas_aen)

struct megasas_mgmt_info {











--=-gbhwNGf0sb90xnNCJ0er
Content-Disposition: attachment; filename=patch1.patch
Content-Type: text/x-patch; name=patch1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas	1969-12-31 16:00:00.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas	2006-01-19 17:52:39.000000000 -0800
@@ -0,0 +1,15 @@
+1 Release Date    : Mon Dec 19 14:36:26 PST 2005 - Sumant Patro <Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.00-rc4 
+3 Older Version   : 00.00.02.01 
+
+i.	Code reorganized to remove code duplication in megasas_build_cmd. 
+
+	"There's a lot of duplicate code megasas_build_cmd.  Move that out of the different codepathes and merge the reminder of megasas_build_cmd into megasas_queue_command"
+
+		- Christoph Hellwig <hch@lst.de>
+
+ii.	Defined MEGASAS_IOC_FIRMWARE32 for code paths that handles 32 bit applications in 64 bit systems.
+
+	"MEGASAS_IOC_FIRMWARE can't be redefined if CONFIG_COMPAT is set, we need to define a MEGASAS_IOC_FIRMWARE32 define so native binaries continue to work"
+
+		- Christoph Hellwig <hch@lst.de>
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-01-19 16:47:01.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-01-19 17:52:20.000000000 -0800
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.02.00-rc4
+ * Version	: v00.00.02.01
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -558,112 +558,29 @@ megasas_build_ldio(struct megasas_instan
 }
 
 /**
- * megasas_build_cmd -	Prepares a command packet
- * @instance:		Adapter soft state
- * @scp:		SCSI command
- * @frame_count:	[OUT] Number of frames used to prepare this command
+ * megasas_is_ldio -		Checks if the cmd is for logical drive
+ * @scmd:			SCSI command
+ *	
+ * Called by megasas_queue_command to find out if the command to be queued
+ * is a logical drive command	
  */
-static inline struct megasas_cmd *megasas_build_cmd(struct megasas_instance
-						    *instance,
-						    struct scsi_cmnd *scp,
-						    int *frame_count)
+static inline int megasas_is_ldio(struct scsi_cmnd *cmd)
 {
-	u32 logical_cmd;
-	struct megasas_cmd *cmd;
-
-	/*
-	 * Find out if this is logical or physical drive command.
-	 */
-	logical_cmd = MEGASAS_IS_LOGICAL(scp);
-
-	/*
-	 * Logical drive command
-	 */
-	if (logical_cmd) {
-
-		if (scp->device->id >= MEGASAS_MAX_LD) {
-			scp->result = DID_BAD_TARGET << 16;
-			return NULL;
-		}
-
-		switch (scp->cmnd[0]) {
-
-		case READ_10:
-		case WRITE_10:
-		case READ_12:
-		case WRITE_12:
-		case READ_6:
-		case WRITE_6:
-		case READ_16:
-		case WRITE_16:
-			/*
-			 * Fail for LUN > 0
-			 */
-			if (scp->device->lun) {
-				scp->result = DID_BAD_TARGET << 16;
-				return NULL;
-			}
-
-			cmd = megasas_get_cmd(instance);
-
-			if (!cmd) {
-				scp->result = DID_IMM_RETRY << 16;
-				return NULL;
-			}
-
-			*frame_count = megasas_build_ldio(instance, scp, cmd);
-
-			if (!(*frame_count)) {
-				megasas_return_cmd(instance, cmd);
-				return NULL;
-			}
-
-			return cmd;
-
-		default:
-			/*
-			 * Fail for LUN > 0
-			 */
-			if (scp->device->lun) {
-				scp->result = DID_BAD_TARGET << 16;
-				return NULL;
-			}
-
-			cmd = megasas_get_cmd(instance);
-
-			if (!cmd) {
-				scp->result = DID_IMM_RETRY << 16;
-				return NULL;
-			}
-
-			*frame_count = megasas_build_dcdb(instance, scp, cmd);
-
-			if (!(*frame_count)) {
-				megasas_return_cmd(instance, cmd);
-				return NULL;
-			}
-
-			return cmd;
-		}
-	} else {
-		cmd = megasas_get_cmd(instance);
-
-		if (!cmd) {
-			scp->result = DID_IMM_RETRY << 16;
-			return NULL;
-		}
-
-		*frame_count = megasas_build_dcdb(instance, scp, cmd);
-
-		if (!(*frame_count)) {
-			megasas_return_cmd(instance, cmd);
-			return NULL;
-		}
-
-		return cmd;
+	if (!MEGASAS_IS_LOGICAL(cmd))
+		return 0;
+	switch (cmd->cmnd[0]) {
+	case READ_10:
+	case WRITE_10:
+	case READ_12:
+	case WRITE_12:
+	case READ_6:
+	case WRITE_6:
+	case READ_16:
+	case WRITE_16:
+		return 1;
+	default:
+		return 0;
 	}
-
-	return NULL;
 }
 
 /**
@@ -684,13 +601,27 @@ megasas_queue_command(struct scsi_cmnd *
 	scmd->scsi_done = done;
 	scmd->result = 0;
 
-	cmd = megasas_build_cmd(instance, scmd, &frame_count);
-
-	if (!cmd) {
-		done(scmd);
-		return 0;
+	if (MEGASAS_IS_LOGICAL(scmd) &&
+	    (scmd->device->id >= MEGASAS_MAX_LD || scmd->device->lun)) {
+		scmd->result = DID_BAD_TARGET << 16;
+		goto out_done;
 	}
 
+	cmd = megasas_get_cmd(instance);
+	if (!cmd)
+		return SCSI_MLQUEUE_HOST_BUSY;
+
+	/*
+	 * Logical drive command
+	 */
+	if (megasas_is_ldio(scmd))
+		frame_count = megasas_build_ldio(instance, scmd, cmd);
+	else
+		frame_count = megasas_build_dcdb(instance, scmd, cmd);
+
+	if (!frame_count)
+		goto out_return_cmd;
+
 	cmd->scmd = scmd;
 	scmd->SCp.ptr = (char *)cmd;
 	scmd->SCp.sent_command = jiffies;
@@ -706,6 +637,12 @@ megasas_queue_command(struct scsi_cmnd *
 	       &instance->reg_set->inbound_queue_port);
 
 	return 0;
+
+ out_return_cmd:
+	megasas_return_cmd(instance, cmd);
+ out_done:
+	done(scmd);
+	return 0;
 }
 
 /**
@@ -2681,9 +2618,8 @@ megasas_mgmt_compat_ioctl(struct file *f
 			  unsigned long arg)
 {
 	switch (cmd) {
-	case MEGASAS_IOC_FIRMWARE:{
-			return megasas_mgmt_compat_ioctl_fw(file, arg);
-		}
+	case MEGASAS_IOC_FIRMWARE32:
+		return megasas_mgmt_compat_ioctl_fw(file, arg);
 	case MEGASAS_IOC_GET_AEN:
 		return megasas_mgmt_ioctl_aen(file, arg);
 	}
diff -uprN linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-01-19 16:47:01.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-01-19 17:52:20.000000000 -0800
@@ -18,10 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.02.00-rc4"
-#define MEGASAS_RELDATE				"Sep 16, 2005"
-#define MEGASAS_EXT_VERSION			"Fri Sep 16 12:37:08 EDT 2005"
-
+#define MEGASAS_VERSION				"00.00.02.01"
+#define MEGASAS_RELDATE				"Dec 19, 2005"
+#define MEGASAS_EXT_VERSION			"Mon Dec 19 14:36:26 PST 2005"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions
@@ -1125,11 +1124,10 @@ struct compat_megasas_iocpacket {
 	struct compat_iovec sgl[MAX_IOCTL_SGE];
 } __attribute__ ((packed));
 
-#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct compat_megasas_iocpacket)
-#else
-#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct megasas_iocpacket)
 #endif
 
+#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct megasas_iocpacket)
+#define MEGASAS_IOC_FIRMWARE32	_IOWR('M', 1, struct compat_megasas_iocpacket)
 #define MEGASAS_IOC_GET_AEN	_IOW('M', 3, struct megasas_aen)
 
 struct megasas_mgmt_info {

--=-gbhwNGf0sb90xnNCJ0er--

