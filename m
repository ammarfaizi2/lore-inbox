Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVAGTJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVAGTJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVAGTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:08:06 -0500
Received: from [213.146.154.40] ([213.146.154.40]:4803 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261531AbVAGTFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:05:48 -0500
Date: Fri, 7 Jan 2005 19:05:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107190545.GA13898@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Saveliev <vs@namesys.com>, linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105118217.3616.171.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -puN include/linux/gfp.h~reiser4-perthread-pages include/linux/gfp.h
> --- linux-2.6.10-rc3/include/linux/gfp.h~reiser4-perthread-pages	2004-12-22 20:09:44.153164276 +0300
> +++ linux-2.6.10-rc3-vs/include/linux/gfp.h	2004-12-22 20:09:44.199167794 +0300
> @@ -134,4 +134,8 @@ extern void FASTCALL(free_cold_page(stru
>  
>  void page_alloc_init(void);
>  
> +int  perthread_pages_reserve(int nrpages, int gfp);
> +void perthread_pages_release(int nrpages);
> +int  perthread_pages_count(void);
> +
>  #endif /* __LINUX_GFP_H */
> diff -puN include/linux/init_task.h~reiser4-perthread-pages include/linux/init_task.h
> --- linux-2.6.10-rc3/include/linux/init_task.h~reiser4-perthread-pages	2004-12-22 20:09:44.160164812 +0300
> +++ linux-2.6.10-rc3-vs/include/linux/init_task.h	2004-12-22 20:09:44.201167947 +0300
> @@ -112,8 +112,8 @@ extern struct group_info init_groups;
>  	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
>  	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
>  	.journal_info	= NULL,						\
> +	.private_pages	= LIST_HEAD_INIT(tsk.private_pages),		\
> +	.private_pages_count = 0,					\
>  }
>  
> -
> -
>  #endif
> diff -puN include/linux/sched.h~reiser4-perthread-pages include/linux/sched.h
> --- linux-2.6.10-rc3/include/linux/sched.h~reiser4-perthread-pages	2004-12-22 20:09:44.170165576 +0300
> +++ linux-2.6.10-rc3-vs/include/linux/sched.h	2004-12-22 20:09:44.204168176 +0300
> @@ -691,6 +691,9 @@ struct task_struct {
>  	nodemask_t mems_allowed;
>  	int cpuset_mems_generation;
>  #endif
> +
> +	struct list_head private_pages;	/* per-process private pages */
> +	int private_pages_count;
>  };
>  
>  static inline pid_t process_group(struct task_struct *tsk)
> diff -puN kernel/fork.c~reiser4-perthread-pages kernel/fork.c
> --- linux-2.6.10-rc3/kernel/fork.c~reiser4-perthread-pages	2004-12-22 20:09:44.179166264 +0300
> +++ linux-2.6.10-rc3-vs/kernel/fork.c	2004-12-22 20:09:44.215169017 +0300
> @@ -154,6 +154,10 @@ static struct task_struct *dup_task_stru
>  	tsk->thread_info = ti;
>  	ti->task = tsk;
>  
> +	/* initialize list of pages privately reserved by process */
> +	INIT_LIST_HEAD(&tsk->private_pages);
> +	tsk->private_pages_count = 0;
> +
>  	/* One for us, one for whoever does the "release_task()" (usually parent) */
>  	atomic_set(&tsk->usage,2);
>  	return tsk;
> diff -puN mm/page_alloc.c~reiser4-perthread-pages mm/page_alloc.c
> --- linux-2.6.10-rc3/mm/page_alloc.c~reiser4-perthread-pages	2004-12-22 20:09:44.187166876 +0300
> +++ linux-2.6.10-rc3-vs/mm/page_alloc.c	2004-12-22 20:09:44.219169323 +0300
> @@ -551,6 +551,97 @@ void fastcall free_cold_page(struct page
>  	free_hot_cold_page(page, 1);
>  }
>  
> +static inline struct list_head *get_per_thread_pages(void)
> +{
> +	return &current->private_pages;
> +}

this is a completely useless wrapper that doesn't buy anything.

> +int perthread_pages_reserve(int nrpages, int gfp)
> +{
> +	int i;
> +	struct list_head  accumulator;
> +	struct list_head *per_thread;
> +
> +	per_thread = get_per_thread_pages();
> +	INIT_LIST_HEAD(&accumulator);
> +	list_splice_init(per_thread, &accumulator);

Can probably be written much simpler as:

int perthread_pages_reserve(int nrpages, int gfp)
{
	LIST_HEAD(accumulator);
	int i;

	list_splice_init(&current->private_pages, &accumulator);

Now the big question is, what's synchronizing access to
current->private_pages?

> +	for (i = 0; i < nrpages; ++i) {
> +		struct page *page;
> +
> +		page = alloc_page(gfp);
> +		if (page != NULL)
> +			list_add(&page->lru, &accumulator);
> +		else {
> +			for (; i > 0; --i) {
> +				page = list_entry(accumulator.next, struct page, lru);
> +				list_del(&page->lru);
> +				page_cache_release(page);
> +			}
> +			return -ENOMEM;
> +		}
> +	}

Would be much more readable with the error condition handling at the
end of the function and a goto.

> +int perthread_pages_count(void)
> +{
> +	return current->private_pages_count;
> +}
> +EXPORT_SYMBOL(perthread_pages_count);

Again a completely useless wrapper.

> +static inline struct page *
> +perthread_pages_alloc(void)
> +{
> +	struct list_head *perthread_pages;
> +
> +	/*
> +	 * try to allocate pages from the per-thread private_pages pool. No
> +	 * locking is needed: this list can only be modified by the thread
> +	 * itself, and not by interrupts or other threads.
> +	 */
> +	perthread_pages = get_per_thread_pages();
> +	if (!in_interrupt() && !list_empty(perthread_pages)) {
> +		struct page *page;
> +
> +		page = list_entry(perthread_pages->next, struct page, lru);
> +		list_del(&page->lru);
> +		current->private_pages_count--;
> +		/*
> +		 * per-thread page is already initialized, just return it.
> +		 */
> +		return page;
> +	} else
> +		return NULL;
> +}

Would be written much cleaner with a single return statement and the
comment above the function, ala:

/*
 * try to allocate pages from the per-thread private_pages pool. No
 * locking is needed: this list can only be modified by the thread
 * itself, and not by interrupts or other threads.
 */
static inline struct page *perthread_pages_alloc(void)
{
	struct list_head *perthread_pages = &current->private_pages;
	struct page *page = NULL;

	if (!in_interrupt() && !list_empty(perthread_pages)) {
		page = list_entry(perthread_pages->next, struct page, lru);
		list_del(&page->lru);
		current->private_pages_count--;
	}

	return page;
}

> +	if (order == 0) {
> +		page = perthread_pages_alloc();
> +		if (page != NULL)
> +			return page;
> +	}
> +

You should at least move the !in_interrupt() condition out here.

