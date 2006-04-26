Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWDZU1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWDZU1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWDZU1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:27:49 -0400
Received: from rtr.ca ([64.26.128.89]:15033 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964866AbWDZU1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:27:48 -0400
From: Mark Lord <lkml@rtr.ca>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in handling medium errors
Date: Wed, 26 Apr 2006 16:27:29 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261627.29419.lkml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Lord <lkml@rtr.ca>

I am looking into how SCSI/SATA handle medium (disk) errors,
and the observed behaviour is a little more random than expected,
due to a bug in sd.c.

When scsi_get_sense_info_fld() fails (returns 0), it does NOT update the
value of first_err_block.  But sd_rw_intr() merrily continues to use that
variable regardless, possibly making incorrect decisions about retries and the like.

This patch removes the randomness there, by using the first sector of the
request (SCpnt->request->sector) in such cases, instead of first_err_block.

The patch shows more context than usual, to help see what's going on.

Signed-off-by: Mark Lord <lkml@rtr.ca>
---
--- linux-2.6.17-rc2-git8/drivers/scsi/sd.c	2006-04-26 15:36:12.000000000 -0400
+++ linux/drivers/scsi/sd.c	2006-04-26 16:07:39.000000000 -0400
@@ -930,64 +930,66 @@
 			info_valid = scsi_get_sense_info_fld(
 				SCpnt->sense_buffer, SCSI_SENSE_BUFFERSIZE,
 				&first_err_block);
 			/*
 			 * May want to warn and skip if following cast results
 			 * in actual truncation (if sector_t < 64 bits)
 			 */
 			error_sector = (sector_t)first_err_block;
 			if (SCpnt->request->bio != NULL)
 				block_sectors = bio_sectors(SCpnt->request->bio);
 			switch (SCpnt->device->sector_size) {
 			case 1024:
 				error_sector <<= 1;
 				if (block_sectors < 2)
 					block_sectors = 2;
 				break;
 			case 2048:
 				error_sector <<= 2;
 				if (block_sectors < 4)
 					block_sectors = 4;
 				break;
 			case 4096:
 				error_sector <<=3;
 				if (block_sectors < 8)
 					block_sectors = 8;
 				break;
 			case 256:
 				error_sector >>= 1;
 				break;
 			default:
 				break;
 			}
+			if (!info_valid)
+				error_sector = SCpnt->request->sector;
 
 			error_sector &= ~(block_sectors - 1);
 			good_bytes = (error_sector - SCpnt->request->sector) << 9;
 			if (good_bytes < 0 || good_bytes >= this_count)
 				good_bytes = 0;
 			break;
 
 		case RECOVERED_ERROR: /* an error occurred, but it recovered */
 		case NO_SENSE: /* LLDD got sense data */
 			/*
 			 * Inform the user, but make sure that it's not treated
 			 * as a hard error.
 			 */
 			scsi_print_sense("sd", SCpnt);
 			SCpnt->result = 0;
 			memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 			good_bytes = this_count;
 			break;
 
 		case ILLEGAL_REQUEST:
 			if (SCpnt->device->use_10_for_rw &&
 			    (SCpnt->cmnd[0] == READ_10 ||
 			     SCpnt->cmnd[0] == WRITE_10))
 				SCpnt->device->use_10_for_rw = 0;
 			if (SCpnt->device->use_10_for_ms &&
 			    (SCpnt->cmnd[0] == MODE_SENSE_10 ||
 			     SCpnt->cmnd[0] == MODE_SELECT_10))
 				SCpnt->device->use_10_for_ms = 0;
 			break;
 
 		default:
 			break;
