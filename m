Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVLSQli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVLSQli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVLSQlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:41:37 -0500
Received: from www.swissdisk.com ([216.144.233.50]:16830 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S964843AbVLSQlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:41:37 -0500
Date: Mon, 19 Dec 2005 07:32:36 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
Message-ID: <20051219153236.GA10905@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reference: https://bugzilla.ubuntu.com/5049

The eject command was failing for a large group of users for removable
devices. The "eject -r" command, which uses the CDROMEJECT ioctl would not
work, however "eject -s", which uses SG_IO did work, but required root access.

Since SG_IO was using the same mechanism as CDROMEJECT, there should be no
difference. The main reason for getting the CDROMEJECT ioctl working was
because it didn't need root privileges like the SG_IO commands did.

One bug was noticed, and that is CDROMEJECT was setting the blk request to a
WRITE operation, when in fact it wasn't. The block layer did not like getting
WRITE requests when data_len==0 and data==NULL.

The other issue was that "eject -s" was sending two extra commands that
seemed to work for just about any removable device. CDROMEJECT works as
such:

START_STOP : 0x02

While "eject -s" sent(via SG_IO):

ALLOW_MEDIUM_REMOVAL
START_STOP : 0x01
START_STOP : 0x02

This patch fixes the WRITE vs READ issue, and also sends the extra two
commands. Anyone with an iPod connected via USB (not sure about firewire)
should be able to reproduce this issue, and verify the patch.


diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 382dea7..573da94 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -442,11 +442,38 @@ error:
 	return err;
 }
 
+/* This is only useful for the following macros */
+static int __blk_send_generic(request_queue_t *q, struct gendisk *bd_disk, int cmd, int data)
+{
+	struct request *rq;
+	int err;
+
+	rq = blk_get_request(q, READ, __GFP_WAIT);
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
+#define blk_send_start_stop(q, bd_disk, data) \
+	__blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data)
+
+#define blk_send_allow_medium_removal(q, bd_disk) \
+	__blk_send_generic(q, bd_disk, GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, 0)
+
+
 int scsi_cmd_ioctl(struct file *file, struct gendisk *bd_disk, unsigned int cmd, void __user *arg)
 {
 	request_queue_t *q;
-	struct request *rq;
-	int close = 0, err;
+	int err;
 
 	q = bd_disk->queue;
 	if (!q)
@@ -564,19 +591,14 @@ int scsi_cmd_ioctl(struct file *file, st
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
+			err = 0;
+
+			err |= blk_send_allow_medium_removal(q, bd_disk);
+			err |= blk_send_start_stop(q, bd_disk, 0x01);
+			err |= blk_send_start_stop(q, bd_disk, 0x02);
 			break;
 		default:
 			err = -ENOTTY;
