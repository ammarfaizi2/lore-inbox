Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966337AbWKTSL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966337AbWKTSL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966328AbWKTSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:10:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:49874 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934285AbWKTSHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:05 -0500
Message-Id: <20061120180523.820143000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:04 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 10/22] spufs: fix missing stop-and-signal
Content-Disposition: inline; filename=spufs-fix-missing-stop-and-signal.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

When there is pending signals, current spufs_run_spu() always returns 
-ERESTARTSYS and it is called again automatically.
But, if spe already stopped by stop-and-signal or halt instruction,
returning -ERESTARTSYS makes stop-and-signal/halt lost and 
spu run over the end-point.

For your convenience, I attached a sample code to restage this bug.
If there is no bug, printed NPC will be 0x4000.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 run.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)


Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -79,13 +79,7 @@ static inline int spu_run_fini(struct sp
 
 	if (signal_pending(current))
 		ret = -ERESTARTSYS;
-	if (unlikely(current->ptrace & PT_PTRACED)) {
-		if ((*status & SPU_STATUS_STOPPED_BY_STOP)
-		    && (*status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
-			force_sig(SIGTRAP, current);
-			ret = -ERESTARTSYS;
-		}
-	}
+
 	return ret;
 }
 
@@ -232,7 +226,7 @@ long spufs_run_spu(struct file *file, st
 		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
 			ret = spu_reacquire_runnable(ctx, npc, &status);
 			if (ret)
-				goto out;
+				goto out2;
 			continue;
 		}
 		ret = spu_process_events(ctx);
@@ -242,10 +236,24 @@ long spufs_run_spu(struct file *file, st
 
 	ctx->ops->runcntl_stop(ctx);
 	ret = spu_run_fini(ctx, npc, &status);
-	if (!ret)
-		ret = status;
 	spu_yield(ctx);
 
+out2:
+	if ((ret == 0) ||
+	    ((ret == -ERESTARTSYS) &&
+	     ((status & SPU_STATUS_STOPPED_BY_HALT) ||
+	      ((status & SPU_STATUS_STOPPED_BY_STOP) &&
+	       (status >> SPU_STOP_STATUS_SHIFT != 0x2104)))))
+		ret = status;
+
+	if (unlikely(current->ptrace & PT_PTRACED)) {
+		if ((status & SPU_STATUS_STOPPED_BY_STOP)
+		    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
+			force_sig(SIGTRAP, current);
+			ret = -ERESTARTSYS;
+		}
+	}
+
 out:
 	*event = ctx->event_return;
 	up(&ctx->run_sema);

--

