Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272810AbTHKQwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272796AbTHKQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:59 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:857 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272810AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sync iocb wakeup
Message-Id: <E19mFqq-00067z-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if ki_users = 1, we don't do the wakeup, which seems wrong.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/aio.c linux-2.5/fs/aio.c
--- bk-linus/fs/aio.c	2003-07-11 13:57:40.000000000 +0100
+++ linux-2.5/fs/aio.c	2003-07-16 02:34:59.000000000 +0100
@@ -639,13 +639,13 @@ int aio_complete(struct kiocb *iocb, lon
 		iocb->ki_user_data = res;
 		if (iocb->ki_users == 1) {
 			iocb->ki_users = 0;
-			return 1;
+			ret = 1;
+		} else {
+			spin_lock_irq(&ctx->ctx_lock);
+			iocb->ki_users--;
+			ret = (0 == iocb->ki_users);
+			spin_unlock_irq(&ctx->ctx_lock);
 		}
-		spin_lock_irq(&ctx->ctx_lock);
-		iocb->ki_users--;
-		ret = (0 == iocb->ki_users);
-		spin_unlock_irq(&ctx->ctx_lock);
-
 		/* sync iocbs put the task here for us */
 		wake_up_process(iocb->ki_user_obj);
 		return ret;
