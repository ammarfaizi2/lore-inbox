Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTJIF3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 01:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJIF3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 01:29:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58592 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261892AbTJIF3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 01:29:34 -0400
Date: Thu, 9 Oct 2003 11:04:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: [PATCH][2.6-mm] Fix AIO and 4G-4G hang
Message-ID: <20031009053456.GA11323@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears to fix the hangs seen with AIO and 
4G-4G for me. It ensures that the indirect versions of
copy_xxx_user are used during aio retries running in
worker thread context (i.e. access aio issuer's user-space 
instead of kernel-space).

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

-------------------------------------------------------
diffstat aio-4g4g-fix.patch

 aio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- 260t5mm2/fs/aio.c	Fri Sep 19 15:15:39 2003
+++ linux-2.6.0-test5-mm4/fs/aio.c	Tue Oct  7 23:40:22 2003
@@ -805,18 +814,23 @@ static inline void aio_run_iocbs(struct 
  * aio_kick_handler:
  * 	Work queue handler triggered to process pending
  * 	retries on an ioctx. Takes on the aio issuer's
- * 	mm context before running the iocbs.
+ * 	mm context before running the iocbs, so that
+ * 	copy_xxx_user operates on the issuer's address
+ * 	space.
  * Run on aiod's context.
  */
 static void aio_kick_handler(void *data)
 {
 	struct kioctx *ctx = data;
+	mm_segment_t oldfs = get_fs();
 
+	set_fs(USER_DS);
 	use_mm(ctx->mm);
 	spin_lock_irq(&ctx->ctx_lock);
 	__aio_run_iocbs(ctx);
 	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
+	set_fs(oldfs);
 }
 
 
