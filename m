Return-Path: <linux-kernel-owner+w=401wt.eu-S1754420AbWLRTHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbWLRTHS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbWLRTHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:07:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57721 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbWLRTHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:07:16 -0500
Date: Mon, 18 Dec 2006 20:05:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] workqueue: fix schedule_on_each_cpu()
Message-ID: <20061218190509.GA16579@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] workqueue: fix schedule_on_each_cpu()

fix the schedule_on_each_cpu() implementation: __queue_work() is now
stricter, hence set the work-pending bit before passing in the new work.

(found in the -rt tree, using Peter Zijlstra's files-lock scalability
patchset)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/workqueue.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux/kernel/workqueue.c
===================================================================
--- linux.orig/kernel/workqueue.c
+++ linux/kernel/workqueue.c
@@ -637,9 +637,11 @@ int schedule_on_each_cpu(work_func_t fun
 
 	mutex_lock(&workqueue_mutex);
 	for_each_online_cpu(cpu) {
-		INIT_WORK(per_cpu_ptr(works, cpu), func);
-		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
-				per_cpu_ptr(works, cpu));
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, func);
+		set_bit(WORK_STRUCT_PENDING, work_data_bits(work));
+		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu), work);
 	}
 	mutex_unlock(&workqueue_mutex);
 	flush_workqueue(keventd_wq);
