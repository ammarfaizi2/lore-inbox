Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVAGRRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVAGRRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVAGRRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:17:39 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:37905 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S261353AbVAGRRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:17:11 -0500
Subject: [RFC] per thread page reservation patch
From: Vladimir Saveliev <vs@namesys.com>
To: linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20050107144644.GA9606@infradead.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	 <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	 <1105019521.7074.79.camel@tribesman.namesys.com>
	 <20050107144644.GA9606@infradead.org>
Content-Type: multipart/mixed; boundary="=-+n1gIp+ooTfw0G3TtCNR"
Message-Id: <1105118217.3616.171.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 07 Jan 2005 20:16:58 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+n1gIp+ooTfw0G3TtCNR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Fri, 2005-01-07 at 17:46, Christoph Hellwig wrote:
>  
> > reiser4-perthread-pages.patch
> 
> this one I don't particularly object, but I'm not sure it's really
> the right thing to do.  Can you post it with a detailed description
> to linux-mm so we can kick off discussion?
> 

This patch adds an API to reserve some number of pages for exclusive use
of calling thread.  This is necessary to support operations that cannot
tolerate memory allocation failures in the middle (reiser4 uses this API
to not have to undo complex uncompleted (due to ENOMEM) filesystem tree
modifications).

Implementation is simple: reserved pages are stored in a list hanging
off calling task_struct. Caller is to manually release unused pages.

This API is supposed to be used for small reservation (no more than few
dozens of pages).
 
Looking forward for advices on how to do that better/properly
Thanks



--=-+n1gIp+ooTfw0G3TtCNR
Content-Disposition: attachment; filename=reiser4-perthread-pages.patch
Content-Type: text/plain; name=reiser4-perthread-pages.patch; charset=koi8-r
Content-Transfer-Encoding: 7bit



This patch adds an API to reserve some number of pages for exclusive use of
calling thread.  This is necessary to support operations that cannot tolerate
memory allocation failures in the middle.  Implementation is very simplistic
and would only work efficiently for small reservations (no more than few
dozens of pages).

Reserved pages are stored in a list hanging off calling task_struct.  This
list is only accessed by the current thread, hence, no locking is required. 
Note that this makes use of reservation from interrupt handlers impossible
without some external synchronization.  Caller is responsible for manually
releasing unused pages by calling perthread_pages_release(int nrpages) with
proper argument.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

diff -puN include/linux/gfp.h~reiser4-perthread-pages include/linux/gfp.h


 include/linux/gfp.h       |    4 +
 include/linux/init_task.h |    4 -
 include/linux/sched.h     |    3 +
 kernel/fork.c             |    4 +
 mm/page_alloc.c           |   97 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)

diff -puN include/linux/gfp.h~reiser4-perthread-pages include/linux/gfp.h
--- linux-2.6.10-rc3/include/linux/gfp.h~reiser4-perthread-pages	2004-12-22 20:09:44.153164276 +0300
+++ linux-2.6.10-rc3-vs/include/linux/gfp.h	2004-12-22 20:09:44.199167794 +0300
@@ -134,4 +134,8 @@ extern void FASTCALL(free_cold_page(stru
 
 void page_alloc_init(void);
 
+int  perthread_pages_reserve(int nrpages, int gfp);
+void perthread_pages_release(int nrpages);
+int  perthread_pages_count(void);
+
 #endif /* __LINUX_GFP_H */
diff -puN include/linux/init_task.h~reiser4-perthread-pages include/linux/init_task.h
--- linux-2.6.10-rc3/include/linux/init_task.h~reiser4-perthread-pages	2004-12-22 20:09:44.160164812 +0300
+++ linux-2.6.10-rc3-vs/include/linux/init_task.h	2004-12-22 20:09:44.201167947 +0300
@@ -112,8 +112,8 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.private_pages	= LIST_HEAD_INIT(tsk.private_pages),		\
+	.private_pages_count = 0,					\
 }
 
-
-
 #endif
diff -puN include/linux/sched.h~reiser4-perthread-pages include/linux/sched.h
--- linux-2.6.10-rc3/include/linux/sched.h~reiser4-perthread-pages	2004-12-22 20:09:44.170165576 +0300
+++ linux-2.6.10-rc3-vs/include/linux/sched.h	2004-12-22 20:09:44.204168176 +0300
@@ -691,6 +691,9 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+
+	struct list_head private_pages;	/* per-process private pages */
+	int private_pages_count;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -puN kernel/fork.c~reiser4-perthread-pages kernel/fork.c
--- linux-2.6.10-rc3/kernel/fork.c~reiser4-perthread-pages	2004-12-22 20:09:44.179166264 +0300
+++ linux-2.6.10-rc3-vs/kernel/fork.c	2004-12-22 20:09:44.215169017 +0300
@@ -154,6 +154,10 @@ static struct task_struct *dup_task_stru
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
+	/* initialize list of pages privately reserved by process */
+	INIT_LIST_HEAD(&tsk->private_pages);
+	tsk->private_pages_count = 0;
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
diff -puN mm/page_alloc.c~reiser4-perthread-pages mm/page_alloc.c
--- linux-2.6.10-rc3/mm/page_alloc.c~reiser4-perthread-pages	2004-12-22 20:09:44.187166876 +0300
+++ linux-2.6.10-rc3-vs/mm/page_alloc.c	2004-12-22 20:09:44.219169323 +0300
@@ -551,6 +551,97 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }
 
+static inline struct list_head *get_per_thread_pages(void)
+{
+	return &current->private_pages;
+}
+
+int perthread_pages_reserve(int nrpages, int gfp)
+{
+	int i;
+	struct list_head  accumulator;
+	struct list_head *per_thread;
+
+	per_thread = get_per_thread_pages();
+	INIT_LIST_HEAD(&accumulator);
+	list_splice_init(per_thread, &accumulator);
+	for (i = 0; i < nrpages; ++i) {
+		struct page *page;
+
+		page = alloc_page(gfp);
+		if (page != NULL)
+			list_add(&page->lru, &accumulator);
+		else {
+			for (; i > 0; --i) {
+				page = list_entry(accumulator.next, struct page, lru);
+				list_del(&page->lru);
+				page_cache_release(page);
+			}
+			return -ENOMEM;
+		}
+	}
+	/*
+	 * Q: why @accumulator is used, instead of directly adding pages to
+	 * the get_per_thread_pages()?
+	 *
+	 * A: because after first page is added to the get_per_thread_pages(),
+	 * next call to the alloc_page() (on the next loop iteration), will
+	 * re-use it.
+	 */
+	list_splice(&accumulator, per_thread);
+	current->private_pages_count += nrpages;
+	return 0;
+}
+EXPORT_SYMBOL(perthread_pages_reserve);
+
+void perthread_pages_release(int nrpages)
+{
+	struct list_head *per_thread;
+
+	current->private_pages_count -= nrpages;
+	per_thread = get_per_thread_pages();
+	for (; nrpages != 0; --nrpages) {
+		struct page *page;
+
+		BUG_ON(list_empty(per_thread));
+		page = list_entry(per_thread->next, struct page, lru);
+		list_del(&page->lru);
+		page_cache_release(page);
+	}
+}
+EXPORT_SYMBOL(perthread_pages_release);
+
+int perthread_pages_count(void)
+{
+	return current->private_pages_count;
+}
+EXPORT_SYMBOL(perthread_pages_count);
+
+static inline struct page *
+perthread_pages_alloc(void)
+{
+	struct list_head *perthread_pages;
+
+	/*
+	 * try to allocate pages from the per-thread private_pages pool. No
+	 * locking is needed: this list can only be modified by the thread
+	 * itself, and not by interrupts or other threads.
+	 */
+	perthread_pages = get_per_thread_pages();
+	if (!in_interrupt() && !list_empty(perthread_pages)) {
+		struct page *page;
+
+		page = list_entry(perthread_pages->next, struct page, lru);
+		list_del(&page->lru);
+		current->private_pages_count--;
+		/*
+		 * per-thread page is already initialized, just return it.
+		 */
+		return page;
+	} else
+		return NULL;
+}
+
 /*
  * Really, prep_compound_page() should be called from __rmqueue_bulk().  But
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
@@ -667,6 +758,12 @@ __alloc_pages(unsigned int gfp_mask, uns
 	 */
 	can_try_harder = (unlikely(rt_task(p)) && !in_interrupt()) || !wait;
 
+	if (order == 0) {
+		page = perthread_pages_alloc();
+		if (page != NULL)
+			return page;
+	}
+
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
 	if (unlikely(zones[0] == NULL)) {

_

--=-+n1gIp+ooTfw0G3TtCNR--

