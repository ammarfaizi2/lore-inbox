Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbTCNGb0>; Fri, 14 Mar 2003 01:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbTCNGb0>; Fri, 14 Mar 2003 01:31:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:457 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263252AbTCNGbZ>;
	Fri, 14 Mar 2003 01:31:25 -0500
Date: Fri, 14 Mar 2003 12:17:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com
Cc: akpm@digeo.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH][FIX][AIO] sync iocb wakeup
Message-ID: <20030314121713.A2475@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In aio_complete, sync iocbs aren't being woken up if
iocb->ki_users == 1. The following patch should fix this.

(Ben, let me know if I'm missing anything here)

diff -ur linux-2.5.62/fs/aio.c linux-2.5.62-aio/fs/aio.c
--- linux-2.5.62/fs/aio.c	Tue Feb 18 04:26:14 2003
+++ linux-2.5.62-aio/fs/aio.c	Tue Mar 11 21:07:35 2003
@@ -642,13 +717,13 @@
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
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

