Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWDZW4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWDZW4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWDZW4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:56:07 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:8109 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964885AbWDZW4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:56:05 -0400
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in
	handling medium errors
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604261627.29419.lkml@rtr.ca>
References: <200604261627.29419.lkml@rtr.ca>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 17:56:01 -0500
Message-Id: <1146092161.12914.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 16:27 -0400, Mark Lord wrote:
> From: Mark Lord <lkml@rtr.ca>
> 
> I am looking into how SCSI/SATA handle medium (disk) errors,
> and the observed behaviour is a little more random than expected,
> due to a bug in sd.c.
> 
> When scsi_get_sense_info_fld() fails (returns 0), it does NOT update the
> value of first_err_block.  But sd_rw_intr() merrily continues to use that
> variable regardless, possibly making incorrect decisions about retries and the like.
> 
> This patch removes the randomness there, by using the first sector of the
> request (SCpnt->request->sector) in such cases, instead of first_err_block.
> 
> The patch shows more context than usual, to help see what's going on.

Thanks for finding the bug.  Your solution is a bit, um, convoluted.
What it should really be doing if we find no valid information field is
a break so we go out with the default good_sectors of zero (rather than
arriving at that value via a circuitous route).

And, of course, I couldn't resist eliminating the superfluous info_valid
variable and tidying the logic to be programmatic instead of a switch
case.  How does this work?

James

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c647d85..fff423e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -894,12 +894,10 @@ static void sd_rw_intr(struct scsi_cmnd 
 	int this_count = SCpnt->bufflen;
 	int good_bytes = (result == 0 ? this_count : 0);
 	sector_t block_sectors = 1;
-	u64 first_err_block;
 	sector_t error_sector;
 	struct scsi_sense_hdr sshdr;
 	int sense_valid = 0;
 	int sense_deferred = 0;
-	int info_valid;
 
 	if (result) {
 		sense_valid = scsi_command_normalize_sense(SCpnt, &sshdr);
@@ -923,43 +921,44 @@ #endif
 	 */
 	if (driver_byte(result) != 0 &&
 		 sense_valid && !sense_deferred) {
+		u64 first_err_block;
+		int sector_size;
+
 		switch (sshdr.sense_key) {
 		case MEDIUM_ERROR:
 			if (!blk_fs_request(SCpnt->request))
 				break;
-			info_valid = scsi_get_sense_info_fld(
-				SCpnt->sense_buffer, SCSI_SENSE_BUFFERSIZE,
-				&first_err_block);
-			/*
-			 * May want to warn and skip if following cast results
-			 * in actual truncation (if sector_t < 64 bits)
-			 */
-			error_sector = (sector_t)first_err_block;
-			if (SCpnt->request->bio != NULL)
-				block_sectors = bio_sectors(SCpnt->request->bio);
-			switch (SCpnt->device->sector_size) {
-			case 1024:
-				error_sector <<= 1;
-				if (block_sectors < 2)
-					block_sectors = 2;
-				break;
-			case 2048:
-				error_sector <<= 2;
-				if (block_sectors < 4)
-					block_sectors = 4;
-				break;
-			case 4096:
-				error_sector <<=3;
-				if (block_sectors < 8)
-					block_sectors = 8;
-				break;
-			case 256:
-				error_sector >>= 1;
-				break;
-			default:
+			if (!scsi_get_sense_info_fld(SCpnt->sense_buffer,
+						    SCSI_SENSE_BUFFERSIZE,
+						    &first_err_block))
 				break;
+
+			sector_size = SCpnt->device->sector_size / 512;
+
+			if (SCpnt->request->bio != NULL)
+				block_sectors = 
+					bio_sectors(SCpnt->request->bio);
+			if (block_sectors < sector_size)
+				block_sectors = sector_size;
+
+			error_sector = (sector_t)first_err_block;
+			/* 
+			 * convert from physical sector size to
+			 * standard 512 byte sized sectors
+			 */
+			if (sector_size)
+				error_sector *= sector_size;
+			else {
+				int sector_size_div =
+					512 / SCpnt->device->sector_size;
+				error_sector /= sector_size_div;
 			}
 
+			/*
+			 * if the device has a larger logical than
+			 * physical sector size, round down to the
+			 * beginning of a logical sector
+			 */
 			error_sector &= ~(block_sectors - 1);
 			good_bytes = (error_sector - SCpnt->request->sector) << 9;
 			if (good_bytes < 0 || good_bytes >= this_count)


