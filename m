Return-Path: <linux-kernel-owner+w=401wt.eu-S932520AbXAQP4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbXAQP4W (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbXAQP4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:56:22 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57026 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbXAQP4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:56:21 -0500
Message-ID: <45AE471C.8040909@us.ibm.com>
Date: Wed, 17 Jan 2007 09:56:12 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH] Cell SPU task notification
References: <45A805A0.2080000@us.ibm.com> <20070117003018.GA17955@lst.de>
In-Reply-To: <20070117003018.GA17955@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
>===================================================================
>--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-04 10:56:04.730698720 -0600
>+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2007-01-15 16:22:31.808461448 -0600
>@@ -84,15 +84,42 @@
> 			    ctx ? ctx->object_id : 0, spu);
> }
>
>+static void notify_spus_active(void)
>+{
>+       int node;
>+	/* Wake up the active spu_contexts. When the awakened processes
>+	 * sees their notify_active flag is set, they will call
>+	 * spu_notify_already_active().
>+	 */
>+	for (node = 0; node < MAX_NUMNODES; node++) {
>+		struct spu *spu;
>+		mutex_lock(&spu_prio->active_mutex[node]);
>+                list_for_each_entry(spu, &spu_prio->active_list[node], list) {
>
>	You seem to have some issues with tabs vs spaces for indentation
>	here.
>  
>
fixed

>+			struct spu_context *ctx = spu->ctx;
>+			spu->notify_active = 1;
>
>
>	Please make this a bit in the sched_flags field that's added in
>	the scheduler patch series I sent out.
>  
>
I haven't seen that the scheduler patch series got applied yet.  This 
Cell spu task notification patch is a pre-req for OProfile development 
to support profiling SPUs.   When the scheduler patch gets applied to a 
kernel version that fits our needs for our OProfile development, I don't 
see any problem in using the sched_flags field instead of notify_active.

>+			wake_up_all(&ctx->stop_wq);
>+			smp_wmb();
>+		}
>+                mutex_unlock(&spu_prio->active_mutex[node]);
>+	}
>+	yield();
>+}
>
>	Why do you add the yield() here?  yield is pretty much a sign
>	for a bug
>  
>
Yes, the yield() and the memory barriers were leftovers from an earlier 
ill-conceived attempt at solving this problem.  They should have been 
removed.  They're gone now.

>+void spu_notify_already_active(struct spu_context *ctx)
>+{
>+	struct spu *spu = ctx->spu;
>+	if (!spu)
>+		return;
>+	spu_switch_notify(spu, ctx);
>+}
>
>	Please just call spu_switch_notify directly from the only
>  
>
I hesitated doing this since it would entail changing spu_switch_notify 
from being static to non-static.  I'd like to get Arnd's opinion on this 
question before going ahead and making such a change.

>	caller.  Also the check for ctx->spu beeing there is not
>	required if you look a the caller.
>
>
> 	*stat = ctx->ops->status_read(ctx);
>-	if (ctx->state != SPU_STATE_RUNNABLE)
>-		return 1;
>+	smp_rmb();
>  
>
>
>	What do you need the barrier for here?
>  
>
Removed.


