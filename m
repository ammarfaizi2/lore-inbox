Return-Path: <linux-kernel-owner+w=401wt.eu-S1750814AbXAIArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbXAIArS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXAIArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:47:18 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:39664 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbXAIArR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:47:17 -0500
Message-ID: <45A2E615.5020900@us.ibm.com>
Date: Mon, 08 Jan 2007 18:47:17 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maynard Johnson <maynardj@us.ibm.com>
CC: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
Subject: Re: [Cbe-oss-dev] [PATCH -- RFC]Add notification for active Cell
 SPU tasks	-- update #2
References: <457989EF.10805@us.ibm.com>
In-Reply-To: <457989EF.10805@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020205000904010505030806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020205000904010505030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch adds notification of already-active SPU tasks to 
SPUFS.  However, there's a bug that I'm having trouble finding.  The 
first execution of this code path works fine, but subsequent runs do not 
work properly.  On subsequent runs, I can see that not all of the 
already-active tasks are getting awakened, so my OProfile driver is not 
able to collect samples for those SPU contexts that were not awakened.  
If anyone can see the error in my logic or if you have any other 
comments on this patch, I would appreciate it.

Thanks.

Maynard

--------------020205000904010505030806
Content-Type: text/x-diff;
 name="spu-notifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spu-notifier.patch"

Subject: Enable SPU switch notification to detect currently active SPU tasks.

From: Maynard Johnson <maynardj@us.ibm.com>

This patch adds to the capability of spu_switch_event_register to notify the
caller of currently active SPU tasks.  It also exports spu_switch_event_register
and spu_switch_event_unregister.

Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>


Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-04 10:56:04.730698720 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2007-01-08 18:37:19.209355672 -0600
@@ -46,6 +46,10 @@
 
 #define SPU_MIN_TIMESLICE 	(100 * HZ / 1000)
 
+int notify_profiler;
+
+struct list_head active_spu_ctx_cache[MAX_NUMNODES];
+
 #define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
 struct spu_prio_array {
 	unsigned long bitmap[SPU_BITMAP_SIZE];
@@ -81,19 +85,62 @@
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
+	/* Obtain and cache the active spu_contexts. */
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct spu *spu;
+		mutex_lock(&spu_prio->active_mutex[node]);
+		list_for_each_entry(spu, &spu_prio->active_list[node],
+				    list) {
+			struct spu_context *ctx = spu->ctx;
+			/* Make sure the context doesn't go away before we use it. */
+			get_spu_context(ctx);
+			list_add(&ctx->active_cache_list,
+				 &active_spu_ctx_cache[node]);
+		}
+		mutex_unlock(&spu_prio->active_mutex[node]);
+	}
+	/* Now wake up the PPE tasks associated with the active spu contexts 
+	 * we found above. 
+	 */
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct spu_context *ctx, *tmp;
+		list_for_each_entry_safe(ctx, tmp,
+					 &active_spu_ctx_cache[node],
+					 active_cache_list) {
+			notify_profiler = 1;
+			wake_up_all(&ctx->stop_wq);
+			list_del(&ctx->active_cache_list);
+			put_spu_context(ctx);
+			set_current_state(TASK_RUNNING);
+			schedule();
+		}
+	}
 }
 
-int spu_switch_event_register(struct notifier_block * n)
+int spu_switch_event_register(struct notifier_block *n)
 {
-	return blocking_notifier_chain_register(&spu_switch_notifier, n);
+	int ret;
+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
+	if (!ret)
+		notify_spus_active();
+	return ret;
 }
 
-int spu_switch_event_unregister(struct notifier_block * n)
+EXPORT_SYMBOL_GPL(spu_switch_event_register);
+
+int spu_switch_event_unregister(struct notifier_block *n)
 {
 	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
 }
 
+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
+
 
 static inline void bind_context(struct spu *spu, struct spu_context *ctx)
 {
@@ -250,6 +297,14 @@
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
@@ -345,6 +400,7 @@
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		mutex_init(&spu_prio->active_mutex[i]);
 		INIT_LIST_HEAD(&spu_prio->active_list[i]);
+		INIT_LIST_HEAD(&active_spu_ctx_cache[i]);
 	}
 	return 0;
 }
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
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/run.c	2007-01-08 18:34:09.260344944 -0600
@@ -10,6 +10,8 @@
 
 #include "spufs.h"
 
+extern int notify_profiler;
+
 /* interrupt-level stop callback function. */
 void spufs_stop_callback(struct spu *spu)
 {
@@ -45,7 +47,7 @@
 	u64 pte_fault;
 
 	*stat = ctx->ops->status_read(ctx);
-	if (ctx->state != SPU_STATE_RUNNABLE)
+	if (ctx->state != SPU_STATE_RUNNABLE || notify_profiler)
 		return 1;
 	spu = ctx->spu;
 	pte_fault = spu->dsisr &
@@ -319,6 +321,10 @@
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
 		if (unlikely(ret))
 			break;
+		if (unlikely(notify_profiler)) {
+			spu_notify_already_active(ctx);
+			notify_profiler = 0;
+		}
 		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
 		    (status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
 			ret = spu_process_callback(ctx);

--------------020205000904010505030806--

