Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVAGUzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVAGUzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVAGUzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:55:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:4037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261597AbVAGUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:54:48 -0500
Date: Fri, 7 Jan 2005 20:54:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107205444.GA15969@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <nikita@clusterfs.com>,
	Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <20050107190545.GA13898@infradead.org> <m1pt0hq81x.fsf@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pt0hq81x.fsf@clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 11:48:58PM +0300, Nikita Danilov wrote:
> sufficient to create and use per-thread reservations. Using
> current->private_pages_count directly
> 
>  - makes API less uniform, not contained within single namespace
>    (perthread_pages_*), and worse,
> 
>  - exhibits internal implementation detail to the user.

Completely disagreed, hiding all the details doesn't help for such
trivial access, it's just obsfucating things.

But looking at it the API doesn't make sense at all.  Number of pages
in the thread-pool is an internal implementation detail and no caller
must look at it - think about two callers, e.g. filesystem and iscsi
initiator using it in the same thread.

Here's an updated patch with my suggestions implemented and other goodies
such a kerneldoc comments (but completely untested so far):


--- 1.20/include/linux/gfp.h	2005-01-05 18:30:39 +01:00
+++ edited/include/linux/gfp.h	2005-01-07 20:30:20 +01:00
@@ -130,6 +130,9 @@
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr),0)
 
+extern int perthread_pages_reserve(unsigned int nrpages, unsigned int gfp_mask);
+extern void perthread_pages_release(unsigned int nrpages);
+
 void page_alloc_init(void);
 
 #endif /* __LINUX_GFP_H */
--- 1.33/include/linux/init_task.h	2005-01-05 03:48:20 +01:00
+++ edited/include/linux/init_task.h	2005-01-07 20:33:25 +01:00
@@ -112,6 +112,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.private_pages  = LIST_HEAD_INIT(tsk.private_pages),		\
 }
 
 
--- 1.280/include/linux/sched.h	2005-01-05 03:48:20 +01:00
+++ edited/include/linux/sched.h	2005-01-07 20:32:44 +01:00
@@ -658,6 +658,7 @@
 
 /* VM state */
 	struct reclaim_state *reclaim_state;
+	struct list_head private_pages; /* per-process private pages */
 
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
--- 1.229/kernel/fork.c	2005-01-05 03:48:20 +01:00
+++ edited/kernel/fork.c	2005-01-07 20:34:04 +01:00
@@ -153,6 +153,9 @@
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
+	/* initialize list of pages privately reserved by process */
+	INIT_LIST_HEAD(&tsk->private_pages);
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
--- 1.249/mm/page_alloc.c	2005-01-05 18:32:52 +01:00
+++ edited/mm/page_alloc.c	2005-01-07 20:36:34 +01:00
@@ -641,6 +641,86 @@
 	return 1;
 }
 
+/**
+ * perthread_pages_reserve  --  reserve some pages for this thread
+ * @nrpages:		number of pages to reserve
+ * @gfp_mask:		constaints passed to alloc_page()
+ *
+ * This functions allocates @nrpages into a thread-local pool that
+ * __alloc_pages() will use.  Used to support operations that cannot
+ * tolerate memory allocation failures.
+ */
+int perthread_pages_reserve(unsigned int nrpages, unsigned int gfp_mask)
+{
+	LIST_HEAD(accumulator);
+	int i;
+
+	list_splice_init(&current->private_pages, &accumulator);
+
+	for (i = 0; i < nrpages; ++i) {
+		struct page *page = alloc_page(gfp_mask);
+
+		if (!page)
+			goto fail_free_pages;
+		list_add(&page->lru, &accumulator);
+	}
+
+	/*
+	 * Q: why @accumulator is used, instead of directly adding pages to
+	 * current->private_pages?
+	 * 
+	 * A: because after first page is added to the current->private_pages
+	 * next call to the alloc_page() (on the next loop iteration), will
+	 * re-use it.
+	 */
+	list_splice(&accumulator, &current->private_pages);
+	return 0;
+ fail_free_pages:
+	perthread_pages_release(i);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(perthread_pages_reserve);
+
+/**
+ * perthread_pages_release  --  release pages from thread-local pool
+ * @nrpages:		number of pages to release
+ *
+ * This functions release @nrpages that we allocated to a thread-local
+ * pool using perthread_pages_reserve().
+ */
+void perthread_pages_release(unsigned int nrpages)
+{
+	struct list_head *perthread_pages = &current->private_pages;
+
+	for (; nrpages; --nrpages) {
+		struct page *page;
+	
+		BUG_ON(list_empty(perthread_pages));
+		page = list_entry(perthread_pages->next, struct page, lru);
+		list_del(&page->lru);
+		page_cache_release(page);
+	}
+}
+EXPORT_SYMBOL_GPL(perthread_pages_release);
+
+/*
+ * Try to allocate pages from the per-thread private_pages pool. No
+ * locking is needed: this list can only be modified by the thread
+ * itself, and not by interrupts or other threads.
+ */
+static inline struct page *__alloc_perthread_page(void)
+{
+	struct list_head *perthread_pages = &current->private_pages;
+	struct page *page = NULL;
+
+	if (!list_empty(perthread_pages)) {
+		page = list_entry(perthread_pages->next, struct page, lru);
+		list_del(&page->lru);
+	}
+
+	return page;
+}
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  *
@@ -672,6 +752,12 @@
 	int can_try_harder;
 
 	might_sleep_if(wait);
+
+	if (order == 0 && !in_interrupt()) {
+		page = __alloc_perthread_page();
+		if (page)
+			return page;
+	}
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
