Return-Path: <linux-kernel-owner+w=401wt.eu-S1751971AbXAQAa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbXAQAa6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbXAQAa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:30:58 -0500
Received: from verein.lst.de ([213.95.11.210]:50486 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbXAQAa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:30:57 -0500
Date: Wed, 17 Jan 2007 01:30:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH] Cell SPU task notification
Message-ID: <20070117003018.GA17955@lst.de>
References: <45A805A0.2080000@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A805A0.2080000@us.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.001 () BAYES_44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

	You seem to have some issues with tabs vs spaces for indentation
	here.

+			struct spu_context *ctx = spu->ctx;
+			spu->notify_active = 1;


	Please make this a bit in the sched_flags field that's added in
	the scheduler patch series I sent out.

+			wake_up_all(&ctx->stop_wq);
+			smp_wmb();
+		}
+                mutex_unlock(&spu_prio->active_mutex[node]);
+	}
+	yield();
+}

	Why do you add the yield() here?  yield is pretty much a sign
	for a bug

+void spu_notify_already_active(struct spu_context *ctx)
+{
+	struct spu *spu = ctx->spu;
+	if (!spu)
+		return;
+	spu_switch_notify(spu, ctx);
+}

	Please just call spu_switch_notify directly from the only
	caller.  Also the check for ctx->spu beeing there is not
	required if you look a the caller.


 	*stat = ctx->ops->status_read(ctx);
-	if (ctx->state != SPU_STATE_RUNNABLE)
-		return 1;
+	smp_rmb();


	What do you need the barrier for here?

