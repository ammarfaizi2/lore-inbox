Return-Path: <linux-kernel-owner+w=401wt.eu-S936787AbWLHPux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936787AbWLHPux (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938067AbWLHPux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:50:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58473 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936787AbWLHPuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:50:52 -0500
Message-ID: <457989EF.10805@us.ibm.com>
Date: Fri, 08 Dec 2006 09:51:11 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH]Add notification for active Cell SPU tasks -- updated
 patch
Content-Type: multipart/mixed;
 boundary="------------060705080909020700060503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060705080909020700060503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060705080909020700060503
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
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-08 09:04:40.558774376 -0600
@@ -84,15 +84,36 @@
 			    ctx ? ctx->object_id : 0, spu);
 }
 
+static void notify_spus_active(struct notifier_block * n)
+{
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct spu *spu;
+		mutex_lock(&spu_prio->active_mutex[node]);
+		list_for_each_entry(spu, &spu_prio->active_list[node], list) {
+	 			 struct spu_context *ctx = spu->ctx;
+				 n->notifier_call(n, ctx ? ctx->object_id : 0, spu);
+		}
+		mutex_unlock(&spu_prio->active_mutex[node]);
+	 }
+
+}
+
 int spu_switch_event_register(struct notifier_block * n)
 {
-	return blocking_notifier_chain_register(&spu_switch_notifier, n);
+	int ret;
+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
+	if (!ret)
+		notify_spus_active(n);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_register);
 
 int spu_switch_event_unregister(struct notifier_block * n)
 {
 	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
 
 
 static inline void bind_context(struct spu *spu, struct spu_context *ctx)

--------------060705080909020700060503--

