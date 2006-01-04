Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWADUAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWADUAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWADT6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:32757 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965287AbWADT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:38 -0500
Message-Id: <20060104194500.180477000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:21 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 01/13] spufs: fix locking in spu_acquire_runnable
Content-Disposition: inline; filename=spufs-lock.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to check for validity of owner under down_write,
down_read is not enough.

Noticed by Al Viro.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-cg/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-cg.orig/arch/powerpc/platforms/cell/spufs/context.c	2005-12-22 12:10:15.000000000 +0000
+++ linux-cg/arch/powerpc/platforms/cell/spufs/context.c	2005-12-22 12:10:20.000000000 +0000
@@ -120,27 +120,29 @@
 		ctx->spu->prio = current->prio;
 		return 0;
 	}
+	up_read(&ctx->state_sema);
+
+	down_write(&ctx->state_sema);
 	/* ctx is about to be freed, can't acquire any more */
 	if (!ctx->owner) {
 		ret = -EINVAL;
 		goto out;
 	}
-	up_read(&ctx->state_sema);
 
-	down_write(&ctx->state_sema);
 	if (ctx->state == SPU_STATE_SAVED) {
 		ret = spu_activate(ctx, 0);
 		ctx->state = SPU_STATE_RUNNABLE;
 	}
-	downgrade_write(&ctx->state_sema);
 	if (ret)
 		goto out;
 
+	downgrade_write(&ctx->state_sema);
 	/* On success, we return holding the lock */
+
 	return ret;
 out:
 	/* Release here, to simplify calling code. */
-	up_read(&ctx->state_sema);
+	up_write(&ctx->state_sema);
 
 	return ret;
 }

--

