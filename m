Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWAKMB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWAKMB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWAKMB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:01:26 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:42374 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932382AbWAKMBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:01:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17348.62356.869372.208463@jaguar.mkp.net>
Date: Wed, 11 Jan 2006 07:01:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephane Eranian <eranian@hpl.hp.com>
Subject: [patch] perfmon sem2completion
X-Mailer: VM 7.19 under Emacs 21.4.1
From: jes@trained-monkey.org (Jes Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A patch to eliminate the semaphore in the perfmon driver. I believe
Stephane also already applied this to his private tree.

Cheers,
Jes


Migrate perfmon from using an old semaphore to a completion handler.

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 arch/ia64/kernel/perfmon.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6/arch/ia64/kernel/perfmon.c
@@ -39,6 +39,7 @@
 #include <linux/mount.h>
 #include <linux/bitops.h>
 #include <linux/rcupdate.h>
+#include <linux/completion.h>
 
 #include <asm/errno.h>
 #include <asm/intrinsics.h>
@@ -285,7 +286,7 @@
 
 	unsigned long		ctx_ovfl_regs[4];	/* which registers overflowed (notification) */
 
-	struct semaphore	ctx_restart_sem;   	/* use for blocking notification mode */
+	struct completion	ctx_restart_done;  	/* use for blocking notification mode */
 
 	unsigned long		ctx_used_pmds[4];	/* bitmask of PMD used            */
 	unsigned long		ctx_all_pmds[4];	/* bitmask of all accessible PMDs */
@@ -1988,7 +1989,7 @@
 		/*
 		 * force task to wake up from MASKED state
 		 */
-		up(&ctx->ctx_restart_sem);
+		complete(&ctx->ctx_restart_done);
 
 		DPRINT(("waking up ctx_state=%d\n", state));
 
@@ -2703,7 +2704,7 @@
 	/*
 	 * init restart semaphore to locked
 	 */
-	sema_init(&ctx->ctx_restart_sem, 0);
+	init_completion(&ctx->ctx_restart_done);
 
 	/*
 	 * activation is used in SMP only
@@ -3684,7 +3685,7 @@
 	 */
 	if (CTX_OVFL_NOBLOCK(ctx) == 0 && state == PFM_CTX_MASKED) {
 		DPRINT(("unblocking [%d] \n", task->pid));
-		up(&ctx->ctx_restart_sem);
+		complete(&ctx->ctx_restart_done);
 	} else {
 		DPRINT(("[%d] armed exit trap\n", task->pid));
 
@@ -5086,7 +5087,7 @@
 	 * may go through without blocking on SMP systems
 	 * if restart has been received already by the time we call down()
 	 */
-	ret = down_interruptible(&ctx->ctx_restart_sem);
+	ret = wait_for_completion_interruptible(&ctx->ctx_restart_done);
 
 	DPRINT(("after block sleeping ret=%d\n", ret));
 
