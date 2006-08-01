Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWHANrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWHANrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWHANrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:47:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:41284 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751581AbWHANrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:47:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XymSaZ10G7ap8RD6y3x721Bwh2P+fCRAZGakKHjISc5RrVGuyDseFigxHj+VgWHlDWVG2sqX1LMbTNOHLWz7WqpC/qwnoxxJEldeVJHaoL5+IyzeM5gOSeoP4peAPGYrPrTBTP3mj8FCEmOcFg0cNpRJMpFYI1xtL7jYS5UqSjc=
Date: Tue, 1 Aug 2006 17:47:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ifdef blktrace debugging fields
Message-ID: <20060801134703.GG7006@martell.zuzino.mipt.ru>
References: <200608010657.k716vBWF004420@shell0.pdx.osdl.net> <20060801071658.GG31908@suse.de> <20060801002904.53407219.akpm@osdl.org> <20060801074436.GJ31908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801074436.GJ31908@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:44:36AM +0200, Jens Axboe wrote:
> Certainly. If Alexey adds the blkdev.h bit as well, we can go ahead with
> it.

Done. Originally I looked at slab size of task_struct and still
recovering.

[PATCH] ifdef blktrace debugging fields

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/ll_rw_blk.c      |    4 ++--
 include/linux/blkdev.h |    4 ++--
 include/linux/sched.h  |    3 ++-
 kernel/fork.c          |    2 ++
 4 files changed, 8 insertions(+), 5 deletions(-)

--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1779,10 +1779,10 @@ static void blk_release_queue(struct kob
 
 	if (q->queue_tags)
 		__blk_queue_free_tags(q);
-
+#ifdef CONFIG_BLK_DEV_IO_TRACE
 	if (q->blk_trace)
 		blk_trace_shutdown(q);
-
+#endif
 	kmem_cache_free(requestq_cachep, q);
 }
 
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -417,9 +417,9 @@ struct request_queue
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
 	int			node;
-
+#ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
-
+#endif
 	/*
 	 * reserved for flush operations
 	 */
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -784,8 +784,9 @@ #endif
 	struct prio_array *array;
 
 	unsigned short ioprio;
+#ifdef CONFIG_BLK_DEV_IO_TRACE
 	unsigned int btrace_seq;
-
+#endif
 	unsigned long sleep_avg;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -177,7 +177,9 @@ static struct task_struct *dup_task_stru
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
+#ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
+#endif
 	tsk->splice_pipe = NULL;
 	return tsk;
 }

