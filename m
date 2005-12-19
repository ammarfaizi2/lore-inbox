Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVLSU7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVLSU7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVLSU7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:59:12 -0500
Received: from www.swissdisk.com ([216.144.233.50]:10431 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S964973AbVLSU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:59:11 -0500
Date: Mon, 19 Dec 2005 11:50:14 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: axboe@suse.de, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
Message-ID: <20051219195014.GA13578@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the request to a READ instead of WRITE. Also adds and calls
blk_send_allow_medium_removal() for CDROMEJECT case.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

--- a/block/scsi_ioctl.c~	2005-12-19 15:44:06.000000000 -0500
+++ b/block/scsi_ioctl.c	2005-12-19 15:46:43.000000000 -0500
@@ -449,7 +449,7 @@
 	struct request *rq;
 	int err;
 
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq = blk_get_request(q, READ, __GFP_WAIT);
 	rq->flags |= REQ_BLOCK_PC;
 	rq->data = NULL;
 	rq->data_len = 0;
@@ -469,6 +469,11 @@
 	return __blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data);
 }
 
+static inline int blk_send_allow_medium_removal(request_queue_t *q, struct gendisk *bd_disk)
+{
+	return __blk_send_generic(q, bd_disk, GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, 0);
+}
+
 int scsi_cmd_ioctl(struct file *file, struct gendisk *bd_disk, unsigned int cmd, void __user *arg)
 {
 	request_queue_t *q;
@@ -593,7 +598,11 @@
 			err = blk_send_start_stop(q, bd_disk, 0x03);
 			break;
 		case CDROMEJECT:
-			err = blk_send_start_stop(q, bd_disk, 0x02);
+			err = 0;
+
+			err |= blk_send_allow_medium_removal(q, bd_disk);
+			err |= blk_send_start_stop(q, bd_disk, 0x01);
+			err |= blk_send_start_stop(q, bd_disk, 0x02);
 			break;
 		default:
 			err = -ENOTTY;
