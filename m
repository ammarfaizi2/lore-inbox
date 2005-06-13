Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVFMSTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFMSTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFMSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:19:01 -0400
Received: from kanga.kvack.org ([66.96.29.28]:19914 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261182AbVFMSRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:17:01 -0400
Date: Mon, 13 Jun 2005 14:18:57 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: torvalds@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix do_sync_(read|write) to properly handle aio retries
Message-ID: <20050613181857.GA11285@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When do_sync_(read|write) encounters an aio method that makes use of the 
retry mechanism, they fail to correctly retry the operation.  This fixes 
that by adding the appropriate sleep and retry mechanism.

		-ben

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
diff -purN v2.6.12-rc6/fs/read_write.c uml-rc6/fs/read_write.c
--- v2.6.12-rc6/fs/read_write.c	2005-06-13 02:08:02.000000000 -0400
+++ uml-rc6/fs/read_write.c	2005-06-13 14:04:13.272313776 -0400
@@ -203,6 +203,16 @@ Einval:
 	return -EINVAL;
 }
 
+static void wait_on_retry_sync_kiocb(struct kiocb *iocb)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	if (!kiocbIsKicked(iocb))
+		schedule();
+	else
+		kiocbClearKicked(iocb);
+	__set_current_state(TASK_RUNNING);
+}
+
 ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
 	struct kiocb kiocb;
@@ -210,7 +220,10 @@ ssize_t do_sync_read(struct file *filp, 
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos);
+	while (-EIOCBRETRY == 
+		(ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos)))
+		wait_on_retry_sync_kiocb(&kiocb);
+
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	*ppos = kiocb.ki_pos;
@@ -258,7 +271,10 @@ ssize_t do_sync_write(struct file *filp,
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos);
+	while (-EIOCBRETRY == 
+	       (ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos)))
+		wait_on_retry_sync_kiocb(&kiocb);
+
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
 	*ppos = kiocb.ki_pos;
