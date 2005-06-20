Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVFUGPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVFUGPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVFUGNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:13:10 -0400
Received: from coderock.org ([193.77.147.115]:15513 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261739AbVFTVzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:13 -0400
Message-Id: <20050620215138.918628000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:40 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 10/12] block/swim_iop: replace schedule_timeout() with msleep_interruptible()
Content-Disposition: inline; filename=msleep-drivers_block_swim_iop.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>


Change the delay logic of swimiop_eject() to use
msleep_interruptible() and time_before(). Rather than depend on the
number of iterations of the loop for timing accuracy, I rely on the
current value of jiffies relative to a static timeout (end_jiffies).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 swim_iop.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: quilt/drivers/block/swim_iop.c
===================================================================
--- quilt.orig/drivers/block/swim_iop.c
+++ quilt/drivers/block/swim_iop.c
@@ -317,7 +317,8 @@ static void swimiop_status_update(int dr
 
 static int swimiop_eject(struct floppy_state *fs)
 {
-	int err, n;
+	int err;
+	unsigned long end_jiffies;
 	struct swim_iop_req req;
 	struct swimcmd_eject *cmd = (struct swimcmd_eject *) &req.command[0];
 
@@ -332,14 +333,13 @@ static int swimiop_eject(struct floppy_s
 		release_drive(fs);
 		return err;
 	}
-	for (n = 2*HZ; n > 0; --n) {
-		if (req.complete) break;
+	end_jiffies = jiffies + 2 * HZ;
+	while (!req.complete && time_before(jiffies, end_jiffies)) {
+		msleep_interruptible(10);
 		if (signal_pending(current)) {
 			err = -EINTR;
 			break;
 		}
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(1);
 	}
 	release_drive(fs);
 	return cmd->error;

--
