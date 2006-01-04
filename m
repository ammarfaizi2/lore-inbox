Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWADT7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWADT7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWADT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:27892 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965286AbWADT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:38 -0500
Message-Id: <20060104194500.696404000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:24 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 04/13] spufs: serialize sys_spu_run per spu
Content-Disposition: inline; filename=spufs-serialize-spu-run.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During an earlier cleanup, we lost the serialization
of multiple spu_run calls performed on the same
spu_context. In order to get this back, introduce a
mutex in the spu_context that is held inside of spu_run.

Noticed by Al Viro.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-cg/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-cg.orig/arch/powerpc/platforms/cell/spufs/context.c	2005-12-22 13:25:12.000000000 +0000
+++ linux-cg/arch/powerpc/platforms/cell/spufs/context.c	2005-12-22 13:36:37.000000000 +0000
@@ -43,6 +43,7 @@
 	spin_lock_init(&ctx->mmio_lock);
 	kref_init(&ctx->kref);
 	init_rwsem(&ctx->state_sema);
+	init_MUTEX(&ctx->run_sema);
 	init_waitqueue_head(&ctx->ibox_wq);
 	init_waitqueue_head(&ctx->wbox_wq);
 	init_waitqueue_head(&ctx->stop_wq);
Index: linux-cg/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-cg.orig/arch/powerpc/platforms/cell/spufs/file.c	2005-12-22 13:25:12.000000000 +0000
+++ linux-cg/arch/powerpc/platforms/cell/spufs/file.c	2005-12-22 13:37:14.000000000 +0000
@@ -620,8 +620,12 @@
 {
 	int ret;
 
-	if ((ret = spu_run_init(ctx, npc, status)) != 0)
-		return ret;
+	if (down_interruptible(&ctx->run_sema))
+		return -ERESTARTSYS;
+
+	ret = spu_run_init(ctx, npc, status);
+	if (ret)
+		goto out;
 
 	do {
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, status));
@@ -629,9 +633,8 @@
 			break;
 		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
 			ret = spu_reacquire_runnable(ctx, npc, status);
-			if (ret) {
-				return ret;
-			}
+			if (ret)
+				goto out;
 			continue;
 		}
 		ret = spu_process_events(ctx);
@@ -645,6 +648,8 @@
 		ret = *status;
 	spu_yield(ctx);
 
+out:
+	up(&ctx->run_sema);
 	return ret;
 }
 
Index: linux-cg/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-cg.orig/arch/powerpc/platforms/cell/spufs/spufs.h	2005-12-22 13:25:26.000000000 +0000
+++ linux-cg/arch/powerpc/platforms/cell/spufs/spufs.h	2005-12-22 13:34:38.000000000 +0000
@@ -48,6 +48,7 @@
 
 	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED } state;
 	struct rw_semaphore state_sema;
+	struct semaphore run_sema;
 
 	struct mm_struct *owner;
 

--

