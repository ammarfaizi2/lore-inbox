Return-Path: <linux-kernel-owner+w=401wt.eu-S932068AbXAOWjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbXAOWjn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXAOWjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:39:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46590 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbXAOWjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:39:42 -0500
Message-ID: <45AC02A4.8080301@us.ibm.com>
Date: Mon, 15 Jan 2007 16:39:32 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] Cell SPU task notification -- updated patch: #1
References: <45A805A0.2080000@us.ibm.com> <1168826871.4622.32.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1168826871.4622.32.camel@concordia.ozlabs.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060808080906030204090802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060808080906030204090802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is an updated patch that addresses Michael Ellerman's comments.

One comment made by Michael has not yet been addressed:
The comment was in regard to the for-loop in 
spufs/sched.c:notify_spus_active().  He wondered if the scheduler can 
swap a context from one node to another.  If so, there's a small window 
in this loop (where we switch the lock from one node's active list to 
the next) where it may be possible we might miss waking up a context and 
send a spurious wakeup to another.
	Arnd . . . can you comment on this question?

Thanks.
-Maynard


--------------060808080906030204090802
Content-Type: text/x-diff;
 name="spu-notifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spu-notifier.patch"

Subject: Enable SPU switch notification to detect currently active SPU tasks.

From: Maynard Johnson <maynardj@us.ibm.com>

This patch adds to the capability of spu_switch_event_register so that the
caller is also notified of currently active SPU tasks.  It also exports
spu_switch_event_register and spu_switch_event_unregister.

Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>


Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-04 10:56:04.730698720 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2007-01-15 16:22:31.808461448 -0600
@@ -84,15 +84,42 @@
 			    ctx ? ctx->object_id : 0, spu);
 }
 
+static void notify_spus_active(void)
+{
+       int node;
+	/* Wake up the active spu_contexts. When the awakened processes 
+	 * sees their notify_active flag is set, they will call
+	 * spu_notify_already_active().
+	 */
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct spu *spu;
+		mutex_lock(&spu_prio->active_mutex[node]);
+                list_for_each_entry(spu, &spu_prio->active_list[node], list) {
+			struct spu_context *ctx = spu->ctx;
+			spu->notify_active = 1;
+			wake_up_all(&ctx->stop_wq);
+			smp_wmb();
+		}
+                mutex_unlock(&spu_prio->active_mutex[node]);
+	}
+	yield();
+}
+
 int spu_switch_event_register(struct notifier_block * n)
 {
-	return blocking_notifier_chain_register(&spu_switch_notifier, n);
+	int ret;
+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
+	if (!ret)
+		notify_spus_active();
+	return ret;
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_register);
 
 int spu_switch_event_unregister(struct notifier_block * n)
 {
 	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
 
 
 static inline void bind_context(struct spu *spu, struct spu_context *ctx)
@@ -250,6 +277,14 @@
 	return spu_get_idle(ctx, flags);
 }
 
+void spu_notify_already_active(struct spu_context *ctx)
+{
+	struct spu *spu = ctx->spu;
+	if (!spu)
+		return;
+	spu_switch_notify(spu, ctx);
+}
+
 /* The three externally callable interfaces
  * for the scheduler begin here.
  *
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/spufs.h	2007-01-08 18:18:40.093354608 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/spufs.h	2007-01-08 18:31:03.610345792 -0600
@@ -183,6 +183,7 @@
 void spu_yield(struct spu_context *ctx);
 int __init spu_sched_init(void);
 void __exit spu_sched_exit(void);
+void spu_notify_already_active(struct spu_context *ctx);
 
 extern char *isolated_loader;
 
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/run.c	2007-01-08 18:33:51.979311680 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.c	2007-01-15 16:31:30.104499992 -0600
@@ -45,9 +45,11 @@
 	u64 pte_fault;
 
 	*stat = ctx->ops->status_read(ctx);
-	if (ctx->state != SPU_STATE_RUNNABLE)
-		return 1;
+	smp_rmb();
+
 	spu = ctx->spu;
+	if (ctx->state != SPU_STATE_RUNNABLE || spu->notify_active)
+		return 1;
 	pte_fault = spu->dsisr &
 	    (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED);
 	return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
@@ -304,6 +306,7 @@
 		   u32 *npc, u32 *event)
 {
 	int ret;
+	struct * spu;
 	u32 status;
 
 	if (down_interruptible(&ctx->run_sema))
@@ -317,8 +320,16 @@
 
 	do {
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
+		spu = ctx->spu;
 		if (unlikely(ret))
 			break;
+		if (unlikely(spu->notify_active)) {
+			spu->notify_active = 0;
+			if (!(status & SPU_STATUS_STOPPED_BY_STOP)) {
+				spu_notify_already_active(ctx);
+				continue;
+			}
+		}
 		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
 		    (status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
 			ret = spu_process_callback(ctx);

--------------060808080906030204090802--

