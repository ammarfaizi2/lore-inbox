Return-Path: <linux-kernel-owner+w=401wt.eu-S1161126AbXALWDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbXALWDG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbXALWDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:03:06 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59533 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161107AbXALWDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:03:04 -0500
Message-ID: <45A805A0.2080000@us.ibm.com>
Date: Fri, 12 Jan 2007 16:03:12 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH] Cell SPU task notification
Content-Type: multipart/mixed;
 boundary="------------040508030100030202060105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508030100030202060105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040508030100030202060105
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
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2007-01-11 09:45:37.918333128 -0600
@@ -46,6 +46,8 @@
 
 #define SPU_MIN_TIMESLICE 	(100 * HZ / 1000)
 
+int notify_active[MAX_NUMNODES];
+
 #define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
 struct spu_prio_array {
 	unsigned long bitmap[SPU_BITMAP_SIZE];
@@ -81,18 +83,45 @@
 static void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
 {
 	blocking_notifier_call_chain(&spu_switch_notifier,
-			    ctx ? ctx->object_id : 0, spu);
+				     ctx ? ctx->object_id : 0, spu);
+}
+
+static void notify_spus_active(void)
+{
+	int node;
+	/* Wake up the active spu_contexts. When the awakened processes 
+	 * sees their notify_active flag is set, they will call
+	 * spu_notify_already_active().
+	 */
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct spu *spu;
+		mutex_lock(&spu_prio->active_mutex[node]);
+                list_for_each_entry(spu, &spu_prio->active_list[node], list) {
+			struct spu_context *ctx = spu->ctx;
+			wake_up_all(&ctx->stop_wq);
+			notify_active[ctx->spu->number] = 1;
+			smp_mb();
+		}
+                mutex_unlock(&spu_prio->active_mutex[node]);
+	}
+	yield();
 }
 
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
@@ -250,6 +279,14 @@
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
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.c	2007-01-11 10:17:20.777344984 -0600
@@ -10,6 +10,8 @@
 
 #include "spufs.h"
 
+extern int notify_active[MAX_NUMNODES];
+
 /* interrupt-level stop callback function. */
 void spufs_stop_callback(struct spu *spu)
 {
@@ -45,7 +47,9 @@
 	u64 pte_fault;
 
 	*stat = ctx->ops->status_read(ctx);
-	if (ctx->state != SPU_STATE_RUNNABLE)
+	smp_mb();
+
+	if (ctx->state != SPU_STATE_RUNNABLE || notify_active[ctx->spu->number])
 		return 1;
 	spu = ctx->spu;
 	pte_fault = spu->dsisr &
@@ -319,6 +323,11 @@
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
 		if (unlikely(ret))
 			break;
+		if (unlikely(notify_active[ctx->spu->number])) {
+			notify_active[ctx->spu->number] = 0;
+			if (!(status & SPU_STATUS_STOPPED_BY_STOP))
+				spu_notify_already_active(ctx);
+		}
 		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
 		    (status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
 			ret = spu_process_callback(ctx);

--------------040508030100030202060105--

