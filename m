Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVLTOH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVLTOH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVLTOH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:07:29 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:20779 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1751038AbVLTOH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:07:28 -0500
Date: Tue, 20 Dec 2005 09:07:17 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: [PATCH] block: Better CDROMEJECT
In-reply-to: <20051220133939.GI3734@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Message-id: <1135087637.16754.12.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1135047119.8407.24.camel@leatherman>
 <20051220074652.GW3734@suse.de>
 <1135082490.16754.0.camel@localhost.localdomain>
 <20051220132821.GH3734@suse.de>
 <1135085557.16754.2.camel@localhost.localdomain>
 <20051220133939.GI3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 14:39 +0100, Jens Axboe wrote:
> > Should be an easy check to add. In fact, I'll resend both patches with
> > that in place if you want.
> 
> There's still the quirky problem of forcing a locked tray out. In some
> cases this is what you want, if things get stuck for some reason or
> another. But usually the tray is locked for a good reason, because there
> are active users of the device.
> 
> Say two processes has the cdrom open, one of them doing io (maybe even
> writing!), the other could do a CDROMEJECT now and force the ejection of
> a busy drive.

But that's possible now with "eject -s" as long as you have write access
to it. Most users are using "eject -s" anyway.

You can't stop this from happening. However, the fact is that a lot of
devices (iPod's being the most popular) require this to work.

Here's the patch. Currently it will not even try the
ALLOW_MEDIUM_REMOVAL unless they have write access (to avoid returning
an uneeded error for people using eject -r that isn't patched to open
the device O_RDRW). However, I still changed the __blk_send_generic()
function to use verify_command().

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 382dea7..df259f7 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -442,11 +442,54 @@ error:
 	return err;
 }
 
+
+/* Send basic block requests */
+static int __blk_send_generic(struct file *file, request_queue_t *q, struct gendisk *bd_disk, int cmd, int data)
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
+
+	rq->cmd[0] = cmd;
+	rq->cmd[4] = data;
+	rq->cmd_len = 6;
+
+	if (file) {
+		err = verify_command(file, rq->cmd);
+		if (err)
+			goto send_error;
+	}
+	
+	err = blk_execute_rq(q, bd_disk, rq, 0);
+
+send_error:
+	blk_put_request(rq);
+
+	return err;
+}
+
+/* START_STOP just needs read only, so safe */
+static inline int blk_send_start_stop(request_queue_t *q, struct gendisk *bd_disk, int data)
+{
+	return __blk_send_generic(NULL, q, bd_disk, GPCMD_START_STOP_UNIT, data);
+}
+
+/* ALLOW_MEDIUM_REMOVAL needs write access */
+static inline int blk_send_allow_medium_removal(struct file *file, request_queue_t *q, struct gendisk *bd_disk)
+{
+	return __blk_send_generic(file, q, bd_disk, GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, 0);
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
@@ -564,19 +607,20 @@ int scsi_cmd_ioctl(struct file *file, st
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
+			/* We don't even want to try the
+			 * ALLOW_MEDIUM_REMOVAL unless the user has write
+			 * access. The START_STOP will fail if the drive
+			 * needs ALLOW_MEDIUM_REMOVAL anyway. */
+			if (!(file->f_mode & FMODE_WRITE)) {
+				err |= blk_send_allow_medium_removal(file, q, bd_disk);
+				err |= blk_send_start_stop(q, bd_disk, 0x01);
+			}
+			err |= blk_send_start_stop(q, bd_disk, 0x02);
 			break;
 		default:
 			err = -ENOTTY;


-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

