Return-Path: <linux-kernel-owner+w=401wt.eu-S1755151AbWL3QJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbWL3QJr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 11:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbWL3QJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 11:09:47 -0500
Received: from mail.screens.ru ([213.234.233.54]:34641 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbWL3QJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 11:09:46 -0500
Date: Sat, 30 Dec 2006 19:10:31 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/2] fix flush_workqueue() vs CPU_DEAD race
Message-ID: <20061230161031.GA101@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"[PATCH 1/2] reimplement flush_workqueue()" fixed one race when CPU goes down
while flush_cpu_workqueue() plays with it. But there is another problem, CPU
can die before flush_workqueue() has a chance to call flush_cpu_workqueue().
In that case pending work_structs can migrate to CPU which was already checked,
so we should redo the "for_each_online_cpu(cpu)" loop.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm-6.20-rc2/kernel/workqueue.c~3_race	2006-12-29 18:37:31.000000000 +0300
+++ mm-6.20-rc2/kernel/workqueue.c	2006-12-30 18:09:07.000000000 +0300
@@ -65,6 +65,7 @@ struct workqueue_struct {
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
    threads to each one as cpus come/go. */
+static long hotplug_sequence __read_mostly;
 static DEFINE_MUTEX(workqueue_mutex);
 static LIST_HEAD(workqueues);
 
@@ -454,10 +455,16 @@ void fastcall flush_workqueue(struct wor
 		/* Always use first cpu's area. */
 		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
 	} else {
+		long sequence;
 		int cpu;
+again:
+		sequence = hotplug_sequence;
 
 		for_each_online_cpu(cpu)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
+
+		if (unlikely(sequence != hotplug_sequence))
+			goto again;
 	}
 	mutex_unlock(&workqueue_mutex);
 }
@@ -874,6 +881,7 @@ static int __devinit workqueue_cpu_callb
 			cleanup_workqueue_thread(wq, hotcpu);
 		list_for_each_entry(wq, &workqueues, list)
 			take_over_work(wq, hotcpu);
+		hotplug_sequence++;
 		break;
 
 	case CPU_LOCK_RELEASE:

