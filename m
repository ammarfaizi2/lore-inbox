Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVLHAly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVLHAly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVLHAly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:41:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965073AbVLHAlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:41:53 -0500
Date: Wed, 7 Dec 2005 16:41:00 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
In-Reply-To: <20051207161319.6ada5c33.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0512071635250.26288@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
 <20051207161319.6ada5c33.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Andrew Morton wrote:

> > in Andrews tree no longer necessary.
> 
> Why not just extend the irq protection into lru_cache_add[_active]() and
> lru_add_drain()?
> 
> Answer: because
> preserve-irq-status-in-release_pages-__pagevec_lru_add.patch sucks, and
> extending it in this manner sucks more.

The concern was that doing so would mean disabling interrupts in more 
cases.

> Being able to push everything up to process context as you're proposing
> puts all the suckiness into this slowpath, so fine.

Right.

> Normally it's poor form for a library function to assume it can use
> GFP_KERNEL.  But in this case, the allocation has such a huge upper-bound
> that there's no reasonable alternative, so OK.

flush_workqueue() can sleep. gfp atomic is not a possbility.

> kmalloc() can return NULL, y'know.

Fixed. Here is a new version:

isolate_lru_page() currently uses an IPI to notify other processors that 
the lru caches need to be drained if the page cannot be found on the LRU. 
The IPI interrupt may interrupt a processor that is just processing lru 
requests and cause a race condition.

This patch introduces a new function run_on_each_cpu() that uses the keventd()
to run the LRU draining on each processor. Processors disable preemption
when dealing the LRU caches (these are per processor) and thus executing
LRU draining from another process is safe.

Thanks to Lee Schermerhorn <lee.schermerhorn@hp.com> for finding this race
condition.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c	2005-12-05 11:32:21.000000000 -0800
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c	2005-12-06 18:03:24.000000000 -0800
@@ -1038,7 +1038,7 @@ redo:
 		 * Maybe this page is still waiting for a cpu to drain it
 		 * from one of the lru lists?
 		 */
-		on_each_cpu(lru_add_drain_per_cpu, NULL, 0, 1);
+		schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
 		if (PageLRU(page))
 			goto redo;
 	}
Index: linux-2.6.15-rc5-mm1/include/linux/workqueue.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/linux/workqueue.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm1/include/linux/workqueue.h	2005-12-07 16:29:47.000000000 -0800
@@ -65,6 +65,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 
 extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
+extern int schedule_on_each_cpu(void (*func)(void *info), void *info);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
Index: linux-2.6.15-rc5-mm1/kernel/workqueue.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/workqueue.c	2005-12-05 11:15:24.000000000 -0800
+++ linux-2.6.15-rc5-mm1/kernel/workqueue.c	2005-12-07 16:38:54.000000000 -0800
@@ -424,6 +424,25 @@ int schedule_delayed_work_on(int cpu,
 	return ret;
 }
 
+int schedule_on_each_cpu(void (*func) (void *info), void *info)
+{
+	int cpu;
+	struct work_struct *work;
+
+	work = kmalloc(NR_CPUS * sizeof(struct work_struct), GFP_KERNEL);
+
+	if (!work)
+		return 0;
+	for_each_online_cpu(cpu) {
+		INIT_WORK(work + cpu, func, info);
+		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
+				work + cpu);
+	}
+	flush_workqueue(keventd_wq);
+	kfree(work);
+	return 1;
+}
+
 void flush_scheduled_work(void)
 {
 	flush_workqueue(keventd_wq);
