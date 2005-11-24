Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVKXUCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVKXUCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVKXUCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:02:40 -0500
Received: from www.swissdisk.com ([216.144.233.50]:32671 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1751395AbVKXUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:02:40 -0500
Date: Thu, 24 Nov 2005 10:54:19 -0800
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2.6.15-rc2] Fxi hardcoded cpu=0 in workqueue for per_cpu_ptr() calls
Message-ID: <20051124185419.GC20937@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tracked this down on an Ultra Enterprise 3000. It's a 6-way machine. Odd
thing about this machine (and it's good for finding bugs like this) is
that the CPU id's are not 0 based. For instance, on my machine the CPU's
are 6/7/10/11/14/15.

This caused some NULL pointer dereference in kernel/workqueue.c because
for single_threaded workqueue's, it hardcoded the cpu to 0.

I changed the 0's to any_online_cpu(cpu_online_mask), which cpumask.h
claims is "First cpu in mask". So this fits the same usage.


diff --git a/include/linux/percpu.h b/include/linux/percpu.h
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -102,7 +102,7 @@ int fastcall queue_work(struct workqueue
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		if (unlikely(is_single_threaded(wq)))
-			cpu = 0;
+			cpu = any_online_cpu(cpu_online_map);
 		BUG_ON(!list_empty(&work->entry));
 		__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 		ret = 1;
@@ -118,7 +118,7 @@ static void delayed_work_timer_fn(unsign
 	int cpu = smp_processor_id();
 
 	if (unlikely(is_single_threaded(wq)))
-		cpu = 0;
+		cpu = any_online_cpu(cpu_online_map);
 
 	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 }
@@ -266,8 +266,8 @@ void fastcall flush_workqueue(struct wor
 	might_sleep();
 
 	if (is_single_threaded(wq)) {
-		/* Always use cpu 0's area. */
-		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, 0));
+		/* Always use first cpu's area. */
+		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, any_online_cpu(cpu_online_map)));
 	} else {
 		int cpu;
 
@@ -325,7 +325,7 @@ struct workqueue_struct *__create_workqu
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, 0);
+		p = create_workqueue_thread(wq, any_online_cpu(cpu_online_map));
 		if (!p)
 			destroy = 1;
 		else
@@ -379,7 +379,7 @@ void destroy_workqueue(struct workqueue_
 	/* We don't need the distraction of CPUs appearing and vanishing. */
 	lock_cpu_hotplug();
 	if (is_single_threaded(wq))
-		cleanup_workqueue_thread(wq, 0);
+		cleanup_workqueue_thread(wq, any_online_cpu(cpu_online_map));
 	else {
 		for_each_online_cpu(cpu)
 			cleanup_workqueue_thread(wq, cpu);

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
