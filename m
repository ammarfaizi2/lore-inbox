Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWADT5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWADT5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWADT5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:57:33 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:22263 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965276AbWADT5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:32 -0500
Message-Id: <20060104194500.870361000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:25 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 05/13] spufs fix spu_acquire_runnable error path
Content-Disposition: inline; filename=spufs-aquire-runnable-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When spu_activate fails in spu_acquire_runnable, the
state must still be SPU_STATE_SAVED, we were
incorrectly setting it to SPU_STATE_RUNNABLE.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/context.c
@@ -132,10 +132,10 @@ int spu_acquire_runnable(struct spu_cont
 
 	if (ctx->state == SPU_STATE_SAVED) {
 		ret = spu_activate(ctx, 0);
+		if (ret)
+			goto out;
 		ctx->state = SPU_STATE_RUNNABLE;
 	}
-	if (ret)
-		goto out;
 
 	downgrade_write(&ctx->state_sema);
 	/* On success, we return holding the lock */

--

