Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWGBNxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWGBNxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWGBNxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:53:41 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:30411 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750900AbWGBNxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:53:39 -0400
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Neil Brown <neilb@suse.de>, Grant Wilson <grant.wilson@zen.co.uk>
In-Reply-To: <44A7560B.3050000@reub.net>
References: <20060701033524.3c478698.akpm@osdl.org>
	 <20060701181455.GA16412@aitel.hist.no>
	 <20060701152258.bea091a6.akpm@osdl.org>  <44A7560B.3050000@reub.net>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 08:53:13 -0500
Message-Id: <1151848394.3558.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 17:13 +1200, Reuben Farrelly wrote:
> Just for kicks, after testing those two trees (see previous email) I
> took my 
> 2.6.17-mm5 without git-scsi-misc and then patched git-scsi-misc.patch
> back in, 
> rebuilt and rebooted and noted that RAID broke again.  Reverted the
> patch and it 
> all worked.
> 
> So I can conclude that definitely and reproduceably that's the
> one.........

OK, I have a theory.  I think 

[SCSI] sd/scsi_lib simplify sd_rw_intr and scsi_io_completion

Failed to take into account completion of zero length commands (which is
what a flush is).  Could you try the whole of -mm with this patch?

Thanks,

James

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4c4add5..3d04a9f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -855,7 +855,8 @@ static void scsi_release_buffers(struct 
  *		b) We can just use scsi_requeue_command() here.  This would
  *		   be used if we just wanted to retry, for example.
  */
-void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
+void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes,
+			unsigned int block_bytes)
 {
 	int result = cmd->result;
 	int this_count = cmd->bufflen;
@@ -920,72 +921,87 @@ void scsi_io_completion(struct scsi_cmnd
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
 	 */
-	if (good_bytes > 0) {
-		SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, "
-					      "%d bytes done.\n",
+	if (good_bytes >= 0) {
+		SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, %d bytes done.\n",
 					      req->nr_sectors, good_bytes));
 		SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));
 
 		if (clear_errors)
 			req->errors = 0;
+		/*
+		 * If multiple sectors are requested in one buffer, then
+		 * they will have been finished off by the first command.
+		 * If not, then we have a multi-buffer command.
+		 *
+		 * If block_bytes != 0, it means we had a medium error
+		 * of some sort, and that we want to mark some number of
+		 * sectors as not uptodate.  Thus we want to inhibit
+		 * requeueing right here - we will requeue down below
+		 * when we handle the bad sectors.
+		 */
 
-		/* A number of bytes were successfully read.  If there
-		 * is leftovers and there is some kind of error
-		 * (result != 0), retry the rest.
+		/*
+		 * If the command completed without error, then either
+		 * finish off the rest of the command, or start a new one.
 		 */
-		if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
+		if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
 			return;
 	}
-
-	/* good_bytes = 0, or (inclusive) there were leftovers and
-	 * result = 0, so scsi_end_request couldn't retry.
+	/*
+	 * Now, if we were good little boys and girls, Santa left us a request
+	 * sense buffer.  We can extract information from this, so we
+	 * can choose a block to remap, etc.
 	 */
 	if (sense_valid && !sense_deferred) {
 		switch (sshdr.sense_key) {
 		case UNIT_ATTENTION:
 			if (cmd->device->removable) {
-				/* Detected disc change.  Set a bit
+				/* detected disc change.  set a bit 
 				 * and quietly refuse further access.
 				 */
 				cmd->device->changed = 1;
-				scsi_end_request(cmd, 0, this_count, 1);
+				scsi_end_request(cmd, 0,
+						this_count, 1);
 				return;
 			} else {
-				/* Must have been a power glitch, or a
-				 * bus reset.  Could not have been a
-				 * media change, so we just retry the
-				 * request and see what happens.
-				 */
+				/*
+				* Must have been a power glitch, or a
+				* bus reset.  Could not have been a
+				* media change, so we just retry the
+				* request and see what happens.  
+				*/
 				scsi_requeue_command(q, cmd);
 				return;
 			}
 			break;
 		case ILLEGAL_REQUEST:
-			/* If we had an ILLEGAL REQUEST returned, then
-			 * we may have performed an unsupported
-			 * command.  The only thing this should be
-			 * would be a ten byte read where only a six
-			 * byte read was supported.  Also, on a system
-			 * where READ CAPACITY failed, we may have
-			 * read past the end of the disk.
-			 */
+			/*
+		 	* If we had an ILLEGAL REQUEST returned, then we may
+		 	* have performed an unsupported command.  The only
+		 	* thing this should be would be a ten byte read where
+			* only a six byte read was supported.  Also, on a
+			* system where READ CAPACITY failed, we may have read
+			* past the end of the disk.
+		 	*/
 			if ((cmd->device->use_10_for_rw &&
 			    sshdr.asc == 0x20 && sshdr.ascq == 0x00) &&
 			    (cmd->cmnd[0] == READ_10 ||
 			     cmd->cmnd[0] == WRITE_10)) {
 				cmd->device->use_10_for_rw = 0;
-				/* This will cause a retry with a
-				 * 6-byte command.
+				/*
+				 * This will cause a retry with a 6-byte
+				 * command.
 				 */
 				scsi_requeue_command(q, cmd);
-				return;
+				result = 0;
 			} else {
 				scsi_end_request(cmd, 0, this_count, 1);
 				return;
 			}
 			break;
 		case NOT_READY:
-			/* If the device is in the process of becoming
+			/*
+			 * If the device is in the process of becoming
 			 * ready, or has a temporary blockage, retry.
 			 */
 			if (sshdr.asc == 0x04) {
@@ -1005,7 +1021,7 @@ void scsi_io_completion(struct scsi_cmnd
 			}
 			if (!(req->flags & REQ_QUIET)) {
 				scmd_printk(KERN_INFO, cmd,
-					    "Device not ready: ");
+					   "Device not ready: ");
 				scsi_print_sense_hdr("", &sshdr);
 			}
 			scsi_end_request(cmd, 0, this_count, 1);
@@ -1013,21 +1029,21 @@ void scsi_io_completion(struct scsi_cmnd
 		case VOLUME_OVERFLOW:
 			if (!(req->flags & REQ_QUIET)) {
 				scmd_printk(KERN_INFO, cmd,
-					    "Volume overflow, CDB: ");
+					   "Volume overflow, CDB: ");
 				__scsi_print_command(cmd->data_cmnd);
 				scsi_print_sense("", cmd);
 			}
-			/* See SSC3rXX or current. */
-			scsi_end_request(cmd, 0, this_count, 1);
+			scsi_end_request(cmd, 0, block_bytes, 1);
 			return;
 		default:
 			break;
 		}
-	}
+	}			/* driver byte != 0 */
 	if (host_byte(result) == DID_RESET) {
-		/* Third party bus reset or reset for error recovery
-		 * reasons.  Just retry the request and see what
-		 * happens.
+		/*
+		 * Third party bus reset or reset for error
+		 * recovery reasons.  Just retry the request
+		 * and see what happens.  
 		 */
 		scsi_requeue_command(q, cmd);
 		return;
@@ -1035,13 +1051,21 @@ void scsi_io_completion(struct scsi_cmnd
 	if (result) {
 		if (!(req->flags & REQ_QUIET)) {
 			scmd_printk(KERN_INFO, cmd,
-				    "SCSI error: return code = 0x%08x\n",
-				    result);
+				   "SCSI error: return code = 0x%x\n", result);
+
 			if (driver_byte(result) & DRIVER_SENSE)
 				scsi_print_sense("", cmd);
 		}
+		/*
+		 * Mark a single buffer as not uptodate.  Queue the remainder.
+		 * We sometimes get this cruft in the event that a medium error
+		 * isn't properly reported.
+		 */
+		block_bytes = req->hard_cur_sectors << 9;
+		if (!block_bytes)
+			block_bytes = req->data_len;
+		scsi_end_request(cmd, 0, block_bytes, 1);
 	}
-	scsi_end_request(cmd, 0, this_count, !result);
 }
 EXPORT_SYMBOL(scsi_io_completion);
 
@@ -1145,7 +1169,7 @@ static void scsi_blk_pc_done(struct scsi
 	 * successfully. Since this is a REQ_BLOCK_PC command the
 	 * caller should check the request's errors value
 	 */
-	scsi_io_completion(cmd, cmd->bufflen);
+	scsi_io_completion(cmd, cmd->bufflen, 0);
 }
 
 static void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f899ff0..3541990 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -891,10 +891,11 @@ #endif
 static void sd_rw_intr(struct scsi_cmnd * SCpnt)
 {
 	int result = SCpnt->result;
- 	unsigned int xfer_size = SCpnt->request_bufflen;
- 	unsigned int good_bytes = result ? 0 : xfer_size;
- 	u64 start_lba = SCpnt->request->sector;
- 	u64 bad_lba;
+	int this_count = SCpnt->request_bufflen;
+	int good_bytes = (result == 0 ? this_count : 0);
+	sector_t block_sectors = 1;
+	u64 first_err_block;
+	sector_t error_sector;
 	struct scsi_sense_hdr sshdr;
 	int sense_valid = 0;
 	int sense_deferred = 0;
@@ -905,6 +906,7 @@ static void sd_rw_intr(struct scsi_cmnd 
 		if (sense_valid)
 			sense_deferred = scsi_sense_is_deferred(&sshdr);
 	}
+
 #ifdef CONFIG_SCSI_LOGGING
 	SCSI_LOG_HLCOMPLETE(1, printk("sd_rw_intr: %s: res=0x%x\n", 
 				SCpnt->request->rq_disk->disk_name, result));
@@ -914,72 +916,89 @@ #ifdef CONFIG_SCSI_LOGGING
 				sshdr.sense_key, sshdr.asc, sshdr.ascq));
 	}
 #endif
-	if (driver_byte(result) != DRIVER_SENSE &&
-	    (!sense_valid || sense_deferred))
-		goto out;
+	/*
+	   Handle MEDIUM ERRORs that indicate partial success.  Since this is a
+	   relatively rare error condition, no care is taken to avoid
+	   unnecessary additional work such as memcpy's that could be avoided.
+	 */
+	if (driver_byte(result) != 0 &&
+		 sense_valid && !sense_deferred) {
+		switch (sshdr.sense_key) {
+		case MEDIUM_ERROR:
+			if (!blk_fs_request(SCpnt->request))
+				break;
+			info_valid = scsi_get_sense_info_fld(
+				SCpnt->sense_buffer, SCSI_SENSE_BUFFERSIZE,
+				&first_err_block);
+			/*
+			 * May want to warn and skip if following cast results
+			 * in actual truncation (if sector_t < 64 bits)
+			 */
+			error_sector = (sector_t)first_err_block;
+			if (SCpnt->request->bio != NULL)
+				block_sectors = bio_sectors(SCpnt->request->bio);
+			switch (SCpnt->device->sector_size) {
+			case 1024:
+				error_sector <<= 1;
+				if (block_sectors < 2)
+					block_sectors = 2;
+				break;
+			case 2048:
+				error_sector <<= 2;
+				if (block_sectors < 4)
+					block_sectors = 4;
+				break;
+			case 4096:
+				error_sector <<=3;
+				if (block_sectors < 8)
+					block_sectors = 8;
+				break;
+			case 256:
+				error_sector >>= 1;
+				break;
+			default:
+				break;
+			}
 
-	switch (sshdr.sense_key) {
-	case HARDWARE_ERROR:
-	case MEDIUM_ERROR:
-		if (!blk_fs_request(SCpnt->request))
-			goto out;
-		info_valid = scsi_get_sense_info_fld(SCpnt->sense_buffer,
-						     SCSI_SENSE_BUFFERSIZE,
-						     &bad_lba);
-		if (!info_valid)
-			goto out;
-		if (xfer_size <= SCpnt->device->sector_size)
-			goto out;
-		switch (SCpnt->device->sector_size) {
-		case 256:
-			start_lba <<= 1;
-			break;
-		case 512:
+			error_sector &= ~(block_sectors - 1);
+			good_bytes = (error_sector - SCpnt->request->sector) << 9;
+			if (good_bytes < 0 || good_bytes >= this_count)
+				good_bytes = 0;
 			break;
-		case 1024:
-			start_lba >>= 1;
-			break;
-		case 2048:
-			start_lba >>= 2;
+
+		case RECOVERED_ERROR: /* an error occurred, but it recovered */
+		case NO_SENSE: /* LLDD got sense data */
+			/*
+			 * Inform the user, but make sure that it's not treated
+			 * as a hard error.
+			 */
+			scsi_print_sense("sd", SCpnt);
+			SCpnt->result = 0;
+			memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
+			good_bytes = this_count;
 			break;
-		case 4096:
-			start_lba >>= 3;
+
+		case ILLEGAL_REQUEST:
+			if (SCpnt->device->use_10_for_rw &&
+			    (SCpnt->cmnd[0] == READ_10 ||
+			     SCpnt->cmnd[0] == WRITE_10))
+				SCpnt->device->use_10_for_rw = 0;
+			if (SCpnt->device->use_10_for_ms &&
+			    (SCpnt->cmnd[0] == MODE_SENSE_10 ||
+			     SCpnt->cmnd[0] == MODE_SELECT_10))
+				SCpnt->device->use_10_for_ms = 0;
 			break;
+
 		default:
-			/* Print something here with limiting frequency. */
-			goto out;
 			break;
 		}
-		/* This computation should always be done in terms of
-		 * the resolution of the device's medium.
-		 */
-		good_bytes = (bad_lba - start_lba)*SCpnt->device->sector_size;
-		break;
-	case RECOVERED_ERROR:
-	case NO_SENSE:
-		/* Inform the user, but make sure that it's not treated
-		 * as a hard error.
-		 */
-		scsi_print_sense("sd", SCpnt);
-		SCpnt->result = 0;
-		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
-		good_bytes = xfer_size;
-		break;
-	case ILLEGAL_REQUEST:
-		if (SCpnt->device->use_10_for_rw &&
-		    (SCpnt->cmnd[0] == READ_10 ||
-		     SCpnt->cmnd[0] == WRITE_10))
-			SCpnt->device->use_10_for_rw = 0;
-		if (SCpnt->device->use_10_for_ms &&
-		    (SCpnt->cmnd[0] == MODE_SENSE_10 ||
-		     SCpnt->cmnd[0] == MODE_SELECT_10))
-			SCpnt->device->use_10_for_ms = 0;
-		break;
-	default:
-		break;
 	}
- out:
-	scsi_io_completion(SCpnt, good_bytes);
+	/*
+	 * This calls the generic completion function, now that we know
+	 * how many actual sectors finished, and how many sectors we need
+	 * to say have failed.
+	 */
+	scsi_io_completion(SCpnt, good_bytes, block_sectors << 9);
 }
 
 static int media_not_present(struct scsi_disk *sdkp,
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index fd94408..ebf6579 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -292,7 +292,7 @@ #endif
 	 * how many actual sectors finished, and how many sectors we need
 	 * to say have failed.
 	 */
-	scsi_io_completion(SCpnt, good_bytes);
+	scsi_io_completion(SCpnt, good_bytes, block_sectors << 9);
 }
 
 static int sr_init_command(struct scsi_cmnd * SCpnt)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 371f70d..e46cd40 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -143,7 +143,7 @@ #define SCSI_STATE_MLQUEUE         0x100
 
 extern struct scsi_cmnd *scsi_get_command(struct scsi_device *, gfp_t);
 extern void scsi_put_command(struct scsi_cmnd *);
-extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
+extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 extern void scsi_req_abort_cmd(struct scsi_cmnd *cmd);
 


