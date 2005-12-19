Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVLSU6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVLSU6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVLSU6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:58:25 -0500
Received: from www.swissdisk.com ([216.144.233.50]:9663 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S964964AbVLSU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:58:24 -0500
Date: Mon, 19 Dec 2005 11:49:24 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: axboe@suse.de, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH rc6] block: Cleanup CDROMEJECT ioctl
Message-ID: <20051219194924.GA13561@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a basic cleanup. No change in functionality.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 382dea7..56bbb20 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -442,11 +442,37 @@ error:
 	return err;
 }
 
+
+/* Send basic block requests */
+static int __blk_send_generic(request_queue_t *q, struct gendisk *bd_disk, int cmd, int data)
+{
+	struct request *rq;
+	int err;
+
+	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq->flags |= REQ_BLOCK_PC;
+	rq->data = NULL;
+	rq->data_len = 0;
+	rq->timeout = BLK_DEFAULT_TIMEOUT;
+	memset(rq->cmd, 0, sizeof(rq->cmd));
+	rq->cmd[0] = cmd;
+	rq->cmd[4] = data;
+	rq->cmd_len = 6;
+	err = blk_execute_rq(q, bd_disk, rq, 0);
+	blk_put_request(rq);
+
+	return err;
+}
+
+static inline int blk_send_start_stop(request_queue_t *q, struct gendisk *bd_disk, int data)
+{
+	return __blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data);
+}
+
 int scsi_cmd_ioctl(struct file *file, struct gendisk *bd_disk, unsigned int cmd, void __user *arg)
 {
 	request_queue_t *q;
-	struct request *rq;
-	int close = 0, err;
+	int err;
 
 	q = bd_disk->queue;
 	if (!q)
@@ -564,19 +590,10 @@ int scsi_cmd_ioctl(struct file *file, st
 			err = sg_scsi_ioctl(file, q, bd_disk, arg);
 			break;
 		case CDROMCLOSETRAY:
-			close = 1;
+			err = blk_send_start_stop(q, bd_disk, 0x03);
+			break;
 		case CDROMEJECT:
-			rq = blk_get_request(q, WRITE, __GFP_WAIT);
-			rq->flags |= REQ_BLOCK_PC;
-			rq->data = NULL;
-			rq->data_len = 0;
-			rq->timeout = BLK_DEFAULT_TIMEOUT;
-			memset(rq->cmd, 0, sizeof(rq->cmd));
-			rq->cmd[0] = GPCMD_START_STOP_UNIT;
-			rq->cmd[4] = 0x02 + (close != 0);
-			rq->cmd_len = 6;
-			err = blk_execute_rq(q, bd_disk, rq, 0);
-			blk_put_request(rq);
+			err = blk_send_start_stop(q, bd_disk, 0x02);
 			break;
 		default:
 			err = -ENOTTY;
