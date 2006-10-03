Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWJDAl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWJDAl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWJDAl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:41:26 -0400
Received: from mail0.lsil.com ([147.145.40.20]:4339 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1161032AbWJDAlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:41:24 -0400
Subject: [Patch 2/6] megaraid_sas: frame count optimization
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-8y1OnKg2RW0bqFXdDTqF"
Date: Tue, 03 Oct 2006 12:40:47 -0700
Message-Id: <1159904447.5618.15.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8y1OnKg2RW0bqFXdDTqF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Resubmitting.

This patch removes duplicated code in frame calculation &  adds
megasas_get_frame_count() that also takes into account the number of frames
that can be contained in the Main frame.  
FW uses the frame count to pull sufficient number of frames from host memory.

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 10:21:28.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 10:25:00.000000000 -0700
@@ -495,6 +495,46 @@ megasas_make_sgl64(struct megasas_instan
  return sge_count;
 }
 
+ /**
+ * megasas_get_frame_count - Computes the number of frames 
+ * @sge_count  : number of sg elements
+ *
+ * Returns the number of frames required for numnber of sge's (sge_count)
+ */
+
+u32 megasas_get_frame_count(u8 sge_count)
+{
+ int num_cnt;
+ int sge_bytes;
+ u32 sge_sz;
+ u32 frame_count=0;
+
+ sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
+     sizeof(struct megasas_sge32);
+
+	/*
+	* Main frame can contain 2 SGEs for 64-bit SGLs and 
+	* 3 SGEs for 32-bit SGLs
+	*/
+	if (IS_DMA64)
+		num_cnt = sge_count - 2;
+	else
+		num_cnt = sge_count - 3;
+
+	if(num_cnt>0){
+		sge_bytes = sge_sz * num_cnt;
+
+		frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
+		    ((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) ;
+	}
+	/* Main frame */
+	frame_count +=1;
+
+	if (frame_count > 7)
+		frame_count = 8;
+	return frame_count;
+}
+
 /**
  * megasas_build_dcdb -	Prepares a direct cdb (DCDB) command
  * @instance:		Adapter soft state
@@ -508,8 +548,6 @@ static int
 megasas_build_dcdb(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   struct megasas_cmd *cmd)
 {
-	u32 sge_sz;
-	int sge_bytes;
 	u32 is_logical;
 	u32 device_id;
 	u16 flags = 0;
@@ -544,9 +582,6 @@ megasas_build_dcdb(struct megasas_instan
 	/*
 	 * Construct SGL
 	 */
-	sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
-	    sizeof(struct megasas_sge32);
-
 	if (IS_DMA64) {
 		pthru->flags |= MFI_FRAME_SGL64;
 		pthru->sge_count = megasas_make_sgl64(instance, scp,
@@ -562,17 +597,11 @@ megasas_build_dcdb(struct megasas_instan
 	pthru->sense_buf_phys_addr_hi = 0;
 	pthru->sense_buf_phys_addr_lo = cmd->sense_phys_addr;
 
-	sge_bytes = sge_sz * pthru->sge_count;
-
 	/*
 	 * Compute the total number of frames this command consumes. FW uses
 	 * this number to pull sufficient number of frames from host memory.
 	 */
-	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
-	    ((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) + 1;
-
-	if (cmd->frame_count > 7)
-		cmd->frame_count = 8;
+	cmd->frame_count = megasas_get_frame_count(pthru->sge_count);
 
 	return cmd->frame_count;
 }
@@ -589,8 +618,6 @@ static int
 megasas_build_ldio(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   struct megasas_cmd *cmd)
 {
-	u32 sge_sz;
-	int sge_bytes;
 	u32 device_id;
 	u8 sc = scp->cmnd[0];
 	u16 flags = 0;
@@ -605,7 +632,7 @@ megasas_build_ldio(struct megasas_instan
 		flags = MFI_FRAME_DIR_READ;
 
 	/*
-	 * Preare the Logical IO frame: 2nd bit is zero for all read cmds
+	 * Prepare the Logical IO frame: 2nd bit is zero for all read cmds
 	 */
 	ldio->cmd = (sc & 0x02) ? MFI_CMD_LD_WRITE : MFI_CMD_LD_READ;
 	ldio->cmd_status = 0x0;
@@ -674,9 +701,6 @@ megasas_build_ldio(struct megasas_instan
 	/*
 	 * Construct SGL
 	 */
-	sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
-	    sizeof(struct megasas_sge32);
-
 	if (IS_DMA64) {
 		ldio->flags |= MFI_FRAME_SGL64;
 		ldio->sge_count = megasas_make_sgl64(instance, scp, &ldio->sgl);
@@ -690,13 +714,11 @@ megasas_build_ldio(struct megasas_instan
 	ldio->sense_buf_phys_addr_hi = 0;
 	ldio->sense_buf_phys_addr_lo = cmd->sense_phys_addr;
 
-	sge_bytes = sge_sz * ldio->sge_count;
-
- cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
-     ((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) + 1;
-
- if (cmd->frame_count > 7)
-		cmd->frame_count = 8;
+	/*
+	 * Compute the total number of frames this command consumes. FW uses
+	 * this number to pull sufficient number of frames from host memory.
+	 */
+	cmd->frame_count = megasas_get_frame_count(ldio->sge_count);
 
 	return cmd->frame_count;
 }


--=-8y1OnKg2RW0bqFXdDTqF
Content-Disposition: attachment; filename=frm_cnt-p2.patch
Content-Type: text/x-patch; name=frm_cnt-p2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 10:21:28.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 10:25:00.000000000 -0700
@@ -495,6 +495,46 @@ megasas_make_sgl64(struct megasas_instan
 	return sge_count;
 }
 
+ /**
+ * megasas_get_frame_count - Computes the number of frames 
+ * @sge_count		: number of sg elements
+ *
+ * Returns the number of frames required for numnber of sge's (sge_count)
+ */
+
+u32 megasas_get_frame_count(u8 sge_count)
+{
+	int num_cnt;
+	int sge_bytes;
+	u32 sge_sz;
+	u32 frame_count=0;
+
+	sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
+	    sizeof(struct megasas_sge32);
+
+	/*
+	* Main frame can contain 2 SGEs for 64-bit SGLs and 
+	* 3 SGEs for 32-bit SGLs
+	*/
+	if (IS_DMA64)
+		num_cnt = sge_count - 2;
+	else
+		num_cnt = sge_count - 3;
+
+	if(num_cnt>0){
+		sge_bytes = sge_sz * num_cnt;
+
+		frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
+		    ((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) ;
+	}
+	/* Main frame */
+	frame_count +=1;
+
+	if (frame_count > 7)
+		frame_count = 8;
+	return frame_count;
+}
+
 /**
  * megasas_build_dcdb -	Prepares a direct cdb (DCDB) command
  * @instance:		Adapter soft state
@@ -508,8 +548,6 @@ static int
 megasas_build_dcdb(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   struct megasas_cmd *cmd)
 {
-	u32 sge_sz;
-	int sge_bytes;
 	u32 is_logical;
 	u32 device_id;
 	u16 flags = 0;
@@ -544,9 +582,6 @@ megasas_build_dcdb(struct megasas_instan
 	/*
 	 * Construct SGL
 	 */
-	sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
-	    sizeof(struct megasas_sge32);
-
 	if (IS_DMA64) {
 		pthru->flags |= MFI_FRAME_SGL64;
 		pthru->sge_count = megasas_make_sgl64(instance, scp,
@@ -562,17 +597,11 @@ megasas_build_dcdb(struct megasas_instan
 	pthru->sense_buf_phys_addr_hi = 0;
 	pthru->sense_buf_phys_addr_lo = cmd->sense_phys_addr;
 
-	sge_bytes = sge_sz * pthru->sge_count;
-
 	/*
 	 * Compute the total number of frames this command consumes. FW uses
 	 * this number to pull sufficient number of frames from host memory.
 	 */
-	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
-	    ((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) + 1;
-
-	if (cmd->frame_count > 7)
-		cmd->frame_count = 8;
+	cmd->frame_count = megasas_get_frame_count(pthru->sge_count);
 
 	return cmd->frame_count;
 }
@@ -589,8 +618,6 @@ static int
 megasas_build_ldio(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   struct megasas_cmd *cmd)
 {
-	u32 sge_sz;
-	int sge_bytes;
 	u32 device_id;
 	u8 sc = scp->cmnd[0];
 	u16 flags = 0;
@@ -605,7 +632,7 @@ megasas_build_ldio(struct megasas_instan
 		flags = MFI_FRAME_DIR_READ;
 
 	/*
-	 * Preare the Logical IO frame: 2nd bit is zero for all read cmds
+	 * Prepare the Logical IO frame: 2nd bit is zero for all read cmds
 	 */
 	ldio->cmd = (sc & 0x02) ? MFI_CMD_LD_WRITE : MFI_CMD_LD_READ;
 	ldio->cmd_status = 0x0;
@@ -674,9 +701,6 @@ megasas_build_ldio(struct megasas_instan
 	/*
 	 * Construct SGL
 	 */
-	sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
-	    sizeof(struct megasas_sge32);
-
 	if (IS_DMA64) {
 		ldio->flags |= MFI_FRAME_SGL64;
 		ldio->sge_count = megasas_make_sgl64(instance, scp, &ldio->sgl);
@@ -690,13 +714,11 @@ megasas_build_ldio(struct megasas_instan
 	ldio->sense_buf_phys_addr_hi = 0;
 	ldio->sense_buf_phys_addr_lo = cmd->sense_phys_addr;
 
-	sge_bytes = sge_sz * ldio->sge_count;
-
-	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
-	    ((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) + 1;
-
-	if (cmd->frame_count > 7)
-		cmd->frame_count = 8;
+	/*
+	 * Compute the total number of frames this command consumes. FW uses
+	 * this number to pull sufficient number of frames from host memory.
+	 */
+	cmd->frame_count = megasas_get_frame_count(ldio->sge_count);
 
 	return cmd->frame_count;
 }

--=-8y1OnKg2RW0bqFXdDTqF--

