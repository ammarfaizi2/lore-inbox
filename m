Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWEQVkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWEQVkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWEQVkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:40:42 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:29370 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751145AbWEQVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:40:41 -0400
Date: Thu, 18 May 2006 05:40:42 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@suse.de>,
       "David S.Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] list: use list_replace_init() instead of list_splice_init()
Message-ID: <20060518014042.GA891@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

list_splice_init(list, head) does unneeded job if it is known that
list_empty(head) == 1. We can use list_replace_init() instead.

[ I did list_replace() for use in kernel/timer.c. I am not sure it
  is ok to patch random files at once, but it looks so simple ... ].

 arch/i386/mm/pageattr.c |    8 ++++----
 block/ll_rw_blk.c       |    5 ++---
 fs/aio.c                |    4 ++--
 kernel/timer.c          |    8 ++++----
 kernel/workqueue.c      |    4 ++--
 net/core/dev.c          |    6 +++---
 net/core/link_watch.c   |    5 ++---
 7 files changed, 19 insertions(+), 21 deletions(-)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc4/block/ll_rw_blk.c~2_USE	2006-05-18 03:29:13.000000000 +0400
+++ 2.6.17-rc4/block/ll_rw_blk.c	2006-05-18 04:09:36.000000000 +0400
@@ -3359,12 +3359,11 @@ EXPORT_SYMBOL(end_that_request_chunk);
  */
 static void blk_done_softirq(struct softirq_action *h)
 {
-	struct list_head *cpu_list;
-	LIST_HEAD(local_list);
+	struct list_head *cpu_list, local_list;
 
 	local_irq_disable();
 	cpu_list = &__get_cpu_var(blk_cpu_done);
-	list_splice_init(cpu_list, &local_list);
+	list_replace_init(cpu_list, &local_list);
 	local_irq_enable();
 
 	while (!list_empty(&local_list)) {
--- 2.6.17-rc4/fs/aio.c~2_USE	2006-04-03 16:21:25.000000000 +0400
+++ 2.6.17-rc4/fs/aio.c	2006-05-18 04:12:32.000000000 +0400
@@ -777,11 +777,11 @@ out:
 static int __aio_run_iocbs(struct kioctx *ctx)
 {
 	struct kiocb *iocb;
-	LIST_HEAD(run_list);
+	struct list_head run_list;
 
 	assert_spin_locked(&ctx->ctx_lock);
 
-	list_splice_init(&ctx->run_list, &run_list);
+	list_replace_init(&ctx->run_list, &run_list);
 	while (!list_empty(&run_list)) {
 		iocb = list_entry(run_list.next, struct kiocb,
 			ki_run_list);
--- 2.6.17-rc4/kernel/timer.c~2_USE	2006-04-27 17:25:22.000000000 +0400
+++ 2.6.17-rc4/kernel/timer.c	2006-05-18 04:37:49.000000000 +0400
@@ -419,10 +419,10 @@ static inline void __run_timers(tvec_bas
 
 	spin_lock_irq(&base->lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
-		struct list_head work_list = LIST_HEAD_INIT(work_list);
+		struct list_head work_list;
 		struct list_head *head = &work_list;
  		int index = base->timer_jiffies & TVR_MASK;
- 
+
 		/*
 		 * Cascade timers:
 		 */
@@ -431,8 +431,8 @@ static inline void __run_timers(tvec_bas
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
-		list_splice_init(base->tv1.vec + index, &work_list);
+		++base->timer_jiffies;
+		list_replace_init(base->tv1.vec + index, &work_list);
 		while (!list_empty(head)) {
 			void (*fn)(unsigned long);
 			unsigned long data;
--- 2.6.17-rc4/kernel/workqueue.c~2_USE	2006-04-27 17:25:22.000000000 +0400
+++ 2.6.17-rc4/kernel/workqueue.c	2006-05-18 04:17:01.000000000 +0400
@@ -531,11 +531,11 @@ int current_is_keventd(void)
 static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
 {
 	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-	LIST_HEAD(list);
+	struct list_head list;
 	struct work_struct *work;
 
 	spin_lock_irq(&cwq->lock);
-	list_splice_init(&cwq->worklist, &list);
+	list_replace_init(&cwq->worklist, &list);
 
 	while (!list_empty(&list)) {
 		printk("Taking work for %s\n", wq->name);
--- 2.6.17-rc4/arch/i386/mm/pageattr.c~2_USE	2006-04-03 16:21:23.000000000 +0400
+++ 2.6.17-rc4/arch/i386/mm/pageattr.c	2006-05-18 04:28:49.000000000 +0400
@@ -209,19 +209,19 @@ int change_page_attr(struct page *page, 
 }
 
 void global_flush_tlb(void)
-{ 
-	LIST_HEAD(l);
+{
+	struct list_head l;
 	struct page *pg, *next;
 
 	BUG_ON(irqs_disabled());
 
 	spin_lock_irq(&cpa_lock);
-	list_splice_init(&df_list, &l);
+	list_replace_init(&df_list, &l);
 	spin_unlock_irq(&cpa_lock);
 	flush_map();
 	list_for_each_entry_safe(pg, next, &l, lru)
 		__free_page(pg);
-} 
+}
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void kernel_map_pages(struct page *page, int numpages, int enable)
--- 2.6.17-rc4/net/core/dev.c~2_USE	2006-05-18 03:29:13.000000000 +0400
+++ 2.6.17-rc4/net/core/dev.c	2006-05-18 04:32:00.000000000 +0400
@@ -3020,7 +3020,7 @@ static void netdev_wait_allrefs(struct n
 static DEFINE_MUTEX(net_todo_run_mutex);
 void netdev_run_todo(void)
 {
-	struct list_head list = LIST_HEAD_INIT(list);
+	struct list_head list;
 
 	/* Need to guard against multiple cpu's getting out of order. */
 	mutex_lock(&net_todo_run_mutex);
@@ -3035,9 +3035,9 @@ void netdev_run_todo(void)
 
 	/* Snapshot list, allow later requests */
 	spin_lock(&net_todo_list_lock);
-	list_splice_init(&net_todo_list, &list);
+	list_replace_init(&net_todo_list, &list);
 	spin_unlock(&net_todo_list_lock);
-		
+
 	while (!list_empty(&list)) {
 		struct net_device *dev
 			= list_entry(list.next, struct net_device, todo_list);
--- 2.6.17-rc4/net/core/link_watch.c~2_USE	2006-05-18 03:29:13.000000000 +0400
+++ 2.6.17-rc4/net/core/link_watch.c	2006-05-18 04:33:17.000000000 +0400
@@ -91,11 +91,10 @@ static void rfc2863_policy(struct net_de
 /* Must be called with the rtnl semaphore held */
 void linkwatch_run_queue(void)
 {
-	LIST_HEAD(head);
-	struct list_head *n, *next;
+	struct list_head head, *n, *next;
 
 	spin_lock_irq(&lweventlist_lock);
-	list_splice_init(&lweventlist, &head);
+	list_replace_init(&lweventlist, &head);
 	spin_unlock_irq(&lweventlist_lock);
 
 	list_for_each_safe(n, next, &head) {

