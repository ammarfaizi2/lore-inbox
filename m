Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWGCUoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWGCUoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWGCUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:44:54 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:3762 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751200AbWGCUox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:44:53 -0400
Message-ID: <44A98220.2000007@oracle.com>
Date: Mon, 03 Jul 2006 13:46:24 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, axboe <axboe@suse.de>,
       jejb <James.Bottomley@SteelEye.com>, scsi <linux-scsi@vger.kernel.org>
Subject: [Ubuntu PATCH] CDROMEJECT cannot eject some devices
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the bug where CDROMEJECT cannot eject some devices.

bug discussion: https://bugzilla.ubuntu.com/show_bug.cgi?id=5049

Patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=f431f87fc9ac9ba248f43662ef9da9cdaa3418c2

---
 block/scsi_ioctl.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- linux-2617-g21.orig/block/scsi_ioctl.c
+++ linux-2617-g21/block/scsi_ioctl.c
@@ -501,7 +501,7 @@ static int __blk_send_generic(request_qu
 	struct request *rq;
 	int err;
 
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq = blk_get_request(q, READ, __GFP_WAIT);
 	rq->flags |= REQ_BLOCK_PC;
 	rq->data = NULL;
 	rq->data_len = 0;
@@ -521,6 +521,11 @@ static inline int blk_send_start_stop(re
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
@@ -645,7 +650,11 @@ int scsi_cmd_ioctl(struct file *file, st
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

