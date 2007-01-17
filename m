Return-Path: <linux-kernel-owner+w=401wt.eu-S932222AbXAQNrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbXAQNrQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAQNrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:47:15 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50176 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932180AbXAQNrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:47:11 -0500
Date: Wed, 17 Jan 2007 19:21:42 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Ingo Molnar <mingo@elte.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [take33 10/10] kevent: Kevent based AIO (aio_sendfile()/aio_sendfile_path()).
Message-ID: <20070117135142.GA24866@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <11690154353959@2ka.mipt.ru> <11690154352501@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11690154352501@2ka.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since you are implementing new APIs here, have you considered doing an
aio_sendfilev to be able to send a header with the data ?

Regards
Suparna

On Wed, Jan 17, 2007 at 09:30:35AM +0300, Evgeniy Polyakov wrote:
> 
> Kevent based AIO (aio_sendfile()/aio_sendfile_path()).
> 
> aio_sendfile()/aio_sendfile_path() contains of two major parts: AIO
> state machine and page processing code.
> The former is just a small subsystem, which allows to queue callback
> for theirs invocation in process' context on behalf of pool of kernel
> threads. It allows to queue caches of callbacks to the local thread
> or to any other specified. Each cache of callbacks is processed until
> there are callbacks in it, callbacks can requeue themselfs into the
> same cache.
> 
> Real work is being done in page processing code - code which populates
> pages into VFS cache and then sends pages to the destination socket
> via ->sendpage(). Unlike previous aio_sendfile() implementation, new
> one does not require low-level filesystem specific callbacks (->get_block())
> at all, instead I extended struct address_space_operations to contain new
> member called ->aio_readpages(), which is exactly the same as ->readpage()
> (read: mpage_readpages()) except different BIO allocation and sumbission
> routines. I changed mpage_readpages() to provide mpage_alloc() and
> mpage_bio_submit() to the new function called __mpage_readpages(), which is
> exactly old mpage_readpages() with provided callback invocation instead of
> usage for old functions. mpage_readpages_aio() provides kevent specific
> callbacks, which calls old functions, but with different destructor callbacks,
> which are essentially the same, except that they reschedule AIO processing.
> 
> aio_sendfile_path() is essentially aio_sendfile(), except that it takes
> source filename as parameter and returns opened file descriptor.
> 
> Benchmark of the 100 1MB files transfer (files are in VFS already) using sync
> sendfile() against aio_sendfile_path() shows about 10MB/sec performance win
> (78 MB/s vs 66-72 MB/s over 1 Gb network, sendfile sending server is one-way
> AMD Athlong 64 3500+) for aio_sendfile_path().
> 
> AIO state machine is a base for network AIO (which becomes
> quite trivial), but I will not start implementation until
> roadback of kevent as a whole and AIO implementation become more clear.
> 
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> diff --git a/fs/bio.c b/fs/bio.c
> index 7618bcb..291e7e8 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -120,7 +120,7 @@ void bio_free(struct bio *bio, struct bio_set *bio_set)
>  /*
>   * default destructor for a bio allocated with bio_alloc_bioset()
>   */
> -static void bio_fs_destructor(struct bio *bio)
> +void bio_fs_destructor(struct bio *bio)
>  {
>  	bio_free(bio, fs_bio_set);
>  }
> diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
> index beaf25f..f08c957 100644
> --- a/fs/ext3/inode.c
> +++ b/fs/ext3/inode.c
> @@ -1650,6 +1650,13 @@ ext3_readpages(struct file *file, struct address_space *mapping,
>  	return mpage_readpages(mapping, pages, nr_pages, ext3_get_block);
>  }
> 
> +static int
> +ext3_readpages_aio(struct file *file, struct address_space *mapping,
> +		struct list_head *pages, unsigned nr_pages, void *priv)
> +{
> +	return mpage_readpages_aio(mapping, pages, nr_pages, ext3_get_block, priv);
> +}
> +
>  static void ext3_invalidatepage(struct page *page, unsigned long offset)
>  {
>  	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
> @@ -1768,6 +1775,7 @@ static int ext3_journalled_set_page_dirty(struct page *page)
>  }
> 
>  static const struct address_space_operations ext3_ordered_aops = {
> +	.aio_readpages	= ext3_readpages_aio,
>  	.readpage	= ext3_readpage,
>  	.readpages	= ext3_readpages,
>  	.writepage	= ext3_ordered_writepage,
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 692a3e5..e5ba44b 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -102,7 +102,7 @@ static struct bio *mpage_bio_submit(int rw, struct bio *bio)
>  static struct bio *
>  mpage_alloc(struct block_device *bdev,
>  		sector_t first_sector, int nr_vecs,
> -		gfp_t gfp_flags)
> +		gfp_t gfp_flags, void *priv)
>  {
>  	struct bio *bio;
> 
> @@ -116,6 +116,7 @@ mpage_alloc(struct block_device *bdev,
>  	if (bio) {
>  		bio->bi_bdev = bdev;
>  		bio->bi_sector = first_sector;
> +		bio->bi_private = priv;
>  	}
>  	return bio;
>  }
> @@ -175,7 +176,10 @@ map_buffer_to_page(struct page *page, struct buffer_head *bh, int page_block)
>  static struct bio *
>  do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
>  		sector_t *last_block_in_bio, struct buffer_head *map_bh,
> -		unsigned long *first_logical_block, get_block_t get_block)
> +		unsigned long *first_logical_block, get_block_t get_block,
> +		struct bio *(*alloc)(struct block_device *bdev, sector_t first_sector,
> +			int nr_vecs, gfp_t gfp_flags, void *priv),
> +		struct bio *(*submit)(int rw, struct bio *bio), void *priv)
>  {
>  	struct inode *inode = page->mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
> @@ -302,25 +306,25 @@ do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
>  	 * This page will go to BIO.  Do we need to send this BIO off first?
>  	 */
>  	if (bio && (*last_block_in_bio != blocks[0] - 1))
> -		bio = mpage_bio_submit(READ, bio);
> +		bio = submit(READ, bio);
> 
>  alloc_new:
>  	if (bio == NULL) {
> -		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
> +		bio = alloc(bdev, blocks[0] << (blkbits - 9),
>  			  	min_t(int, nr_pages, bio_get_nr_vecs(bdev)),
> -				GFP_KERNEL);
> +				GFP_KERNEL, priv);
>  		if (bio == NULL)
>  			goto confused;
>  	}
> 
>  	length = first_hole << blkbits;
>  	if (bio_add_page(bio, page, length, 0) < length) {
> -		bio = mpage_bio_submit(READ, bio);
> +		bio = submit(READ, bio);
>  		goto alloc_new;
>  	}
> 
>  	if (buffer_boundary(map_bh) || (first_hole != blocks_per_page))
> -		bio = mpage_bio_submit(READ, bio);
> +		bio = submit(READ, bio);
>  	else
>  		*last_block_in_bio = blocks[blocks_per_page - 1];
>  out:
> @@ -328,7 +332,7 @@ out:
> 
>  confused:
>  	if (bio)
> -		bio = mpage_bio_submit(READ, bio);
> +		bio = submit(READ, bio);
>  	if (!PageUptodate(page))
>  	        block_read_full_page(page, get_block);
>  	else
> @@ -336,6 +340,48 @@ confused:
>  	goto out;
>  }
> 
> +int
> +__mpage_readpages(struct address_space *mapping, struct list_head *pages,
> +				unsigned nr_pages, get_block_t get_block,
> +		struct bio *(*alloc)(struct block_device *bdev, sector_t first_sector,
> +			int nr_vecs, gfp_t gfp_flags, void *priv),
> +		struct bio *(*submit)(int rw, struct bio *bio),
> +		void *priv)
> +{
> +	struct bio *bio = NULL;
> +	unsigned page_idx;
> +	sector_t last_block_in_bio = 0;
> +	struct pagevec lru_pvec;
> +	struct buffer_head map_bh;
> +	unsigned long first_logical_block = 0;
> +
> +	clear_buffer_mapped(&map_bh);
> +	pagevec_init(&lru_pvec, 0);
> +	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
> +		struct page *page = list_entry(pages->prev, struct page, lru);
> +
> +		prefetchw(&page->flags);
> +		list_del(&page->lru);
> +		if (!add_to_page_cache(page, mapping,
> +					page->index, GFP_KERNEL)) {
> +			bio = do_mpage_readpage(bio, page,
> +					nr_pages - page_idx,
> +					&last_block_in_bio, &map_bh,
> +					&first_logical_block,
> +					get_block, alloc, submit, priv);
> +			if (!pagevec_add(&lru_pvec, page))
> +				__pagevec_lru_add(&lru_pvec);
> +		} else {
> +			page_cache_release(page);
> +		}
> +	}
> +	pagevec_lru_add(&lru_pvec);
> +	BUG_ON(!list_empty(pages));
> +	if (bio)
> +		submit(READ, bio);
> +	return 0;
> +}
> +
>  /**
>   * mpage_readpages - populate an address space with some pages, and
>   *                       start reads against them.
> @@ -386,40 +432,28 @@ int
>  mpage_readpages(struct address_space *mapping, struct list_head *pages,
>  				unsigned nr_pages, get_block_t get_block)
>  {
> -	struct bio *bio = NULL;
> -	unsigned page_idx;
> -	sector_t last_block_in_bio = 0;
> -	struct pagevec lru_pvec;
> -	struct buffer_head map_bh;
> -	unsigned long first_logical_block = 0;
> +	return __mpage_readpages(mapping, pages, nr_pages, get_block,
> +			mpage_alloc, mpage_bio_submit, NULL);
> +}
> +EXPORT_SYMBOL(mpage_readpages);
> 
> -	clear_buffer_mapped(&map_bh);
> -	pagevec_init(&lru_pvec, 0);
> -	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
> -		struct page *page = list_entry(pages->prev, struct page, lru);
> +#ifdef CONFIG_KEVENT_AIO
> +extern struct bio *kaio_mpage_alloc(struct block_device *bdev, sector_t first_sector,
> +		int nr_vecs, gfp_t gfp_flags, void *priv);
> +extern struct bio *kaio_mpage_bio_submit(int rw, struct bio *bio);
> +#else
> +#define kaio_mpage_alloc	mpage_alloc
> +#define kaio_mpage_bio_submit	mpage_bio_submit
> +#endif
> 
> -		prefetchw(&page->flags);
> -		list_del(&page->lru);
> -		if (!add_to_page_cache(page, mapping,
> -					page->index, GFP_KERNEL)) {
> -			bio = do_mpage_readpage(bio, page,
> -					nr_pages - page_idx,
> -					&last_block_in_bio, &map_bh,
> -					&first_logical_block,
> -					get_block);
> -			if (!pagevec_add(&lru_pvec, page))
> -				__pagevec_lru_add(&lru_pvec);
> -		} else {
> -			page_cache_release(page);
> -		}
> -	}
> -	pagevec_lru_add(&lru_pvec);
> -	BUG_ON(!list_empty(pages));
> -	if (bio)
> -		mpage_bio_submit(READ, bio);
> -	return 0;
> +int
> +mpage_readpages_aio(struct address_space *mapping, struct list_head *pages,
> +				unsigned nr_pages, get_block_t get_block, void *priv)
> +{
> +	return __mpage_readpages(mapping, pages, nr_pages, get_block,
> +			kaio_mpage_alloc, kaio_mpage_bio_submit, priv);
>  }
> -EXPORT_SYMBOL(mpage_readpages);
> +EXPORT_SYMBOL(mpage_readpages_aio);
> 
>  /*
>   * This isn't called much at all
> @@ -433,7 +467,8 @@ int mpage_readpage(struct page *page, get_block_t get_block)
> 
>  	clear_buffer_mapped(&map_bh);
>  	bio = do_mpage_readpage(bio, page, 1, &last_block_in_bio,
> -			&map_bh, &first_logical_block, get_block);
> +			&map_bh, &first_logical_block, get_block,
> +			mpage_alloc, mpage_bio_submit, NULL);
>  	if (bio)
>  		mpage_bio_submit(READ, bio);
>  	return 0;
> @@ -595,7 +630,7 @@ page_is_mapped:
>  alloc_new:
>  	if (bio == NULL) {
>  		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
> -				bio_get_nr_vecs(bdev), GFP_NOFS|__GFP_HIGH);
> +				bio_get_nr_vecs(bdev), GFP_NOFS|__GFP_HIGH, NULL);
>  		if (bio == NULL)
>  			goto confused;
>  	}
> diff --git a/include/linux/mpage.h b/include/linux/mpage.h
> index cc5fb75..accdbdd 100644
> --- a/include/linux/mpage.h
> +++ b/include/linux/mpage.h
> @@ -16,6 +16,8 @@ typedef int (writepage_t)(struct page *page, struct writeback_control *wbc);
> 
>  int mpage_readpages(struct address_space *mapping, struct list_head *pages,
>  				unsigned nr_pages, get_block_t get_block);
> +int mpage_readpages_aio(struct address_space *mapping, struct list_head *pages,
> +				unsigned nr_pages, get_block_t get_block, void *priv);
>  int mpage_readpage(struct page *page, get_block_t get_block);
>  int mpage_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, get_block_t get_block);
> diff --git a/kernel/kevent/kevent_aio.c b/kernel/kevent/kevent_aio.c
> new file mode 100644
> index 0000000..d4c1c5f
> --- /dev/null
> +++ b/kernel/kevent/kevent_aio.c
> @@ -0,0 +1,881 @@
> +/*
> + * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/list.h>
> +#include <linux/kthread.h>
> +#include <linux/slab.h>
> +#include <linux/bio.h>
> +#include <linux/pagemap.h>
> +#include <linux/file.h>
> +#include <linux/swap.h>
> +#include <linux/kevent.h>
> +
> +#define KAIO_CALL_NUM		8
> +#define KAIO_THREAD_NUM		8
> +
> +//#define KEVENT_AIO_DEBUG
> +
> +#ifdef KEVENT_AIO_DEBUG
> +#define dprintk(f, a...) printk(f, ##a)
> +#else
> +#define dprintk(f, a...) do {} while (0)
> +#endif
> +
> +struct kaio_thread
> +{
> +	struct list_head	req_list;
> +	spinlock_t		req_lock;
> +	struct task_struct	*thread;
> +	int			refcnt;
> +	wait_queue_head_t 	wait;
> +};
> +
> +extern struct file_operations kevent_user_fops;
> +static DEFINE_PER_CPU(u32, kaio_req_counter);
> +static DEFINE_PER_CPU(int, kaio_req_cpu);
> +
> +/*
> + * Array of working threads.
> + * It can only be accessed under RCU protection,
> + * so threads reference counters are not atomic.
> + */
> +static struct kaio_thread *kaio_threads[KAIO_THREAD_NUM] __read_mostly;
> +static struct kmem_cache *kaio_req_cache __read_mostly;
> +static struct kmem_cache *kaio_priv_cache __read_mostly;
> +
> +struct kaio_req;
> +typedef int (* kaio_callback)(struct kaio_req *req, int direct);
> +
> +#define KAIO_REQ_PENDING	0
> +
> +/*
> + * Cache of kaio request callbacks.
> + * It is not allowed to change the same cache entry
> + * simultaneously (for example it is forbidden to add entries
> + * in parallel).
> + *
> + * When cache entry is scheduled for execution in one of the threads,
> + * it is forbidden to access it, since it will be freed when
> + * all callbacks have been invoked.
> + *
> + * It is possible to add callbacks into this cache from callbacks itself.
> + */
> +struct kaio_req
> +{
> +	struct list_head	req_entry;
> +	kaio_callback		call[KAIO_CALL_NUM];
> +	int			read_idx, add_idx;
> +	int			cpu;
> +	long			flags;
> +	atomic_t		refcnt;
> +	void			(*destructor)(struct kaio_req *);
> +	void			*priv;
> +};
> +
> +/*
> + * Returns pointer to thread entry for given index.
> + * Must be called under RCU protection.
> + */
> +static struct kaio_thread *kaio_get_thread(int cpu)
> +{
> +	struct kaio_thread *th;
> +
> +	if (cpu == -1) {
> +#if 1
> +		int *cnt = &__get_cpu_var(kaio_req_cpu);
> +		cpu = *cnt;
> +
> +		*cnt = *cnt + 1;
> +		if (*cnt >= KAIO_THREAD_NUM)
> +			*cnt = 0;
> +#else
> +		cpu = 0;
> +#endif
> +	}
> +
> +	if (unlikely(cpu >= KAIO_THREAD_NUM || !kaio_threads[cpu]))
> +		return NULL;
> +
> +	th = kaio_threads[cpu];
> +	th->refcnt++;
> +
> +	return th;
> +}
> +
> +/*
> + * Drops reference counter for given thread.
> + * Must be called under RCU protection.
> + */
> +static inline void kaio_put_thread(struct kaio_thread *th)
> +{
> +	th->refcnt--;
> +}
> +
> +void kaio_schedule_req(struct kaio_req *req)
> +{
> +	struct kaio_thread *th;
> +	unsigned long flags;
> +
> +	rcu_read_lock();
> +	th = kaio_get_thread(req->cpu);
> +	if (!th) {
> +		req->cpu = -1;
> +		th = kaio_get_thread(-1);
> +		BUG_ON(!th);
> +	}
> +
> +	if (!test_and_set_bit(KAIO_REQ_PENDING, &req->flags)) {
> +		spin_lock_irqsave(&th->req_lock, flags);
> +		list_add_tail(&req->req_entry, &th->req_list);
> +		spin_unlock_irqrestore(&th->req_lock, flags);
> +	}
> +
> +	wake_up(&th->wait);
> +
> +	kaio_put_thread(th);
> +	rcu_read_unlock();
> +}
> +
> +EXPORT_SYMBOL_GPL(kaio_schedule_req);
> +
> +static inline void kaio_req_get(struct kaio_req *req)
> +{
> +	atomic_inc(&req->refcnt);
> +}
> +
> +static inline int kaio_req_put(struct kaio_req *req)
> +{
> +	if (atomic_dec_and_test(&req->refcnt)) {
> +		dprintk("%s: freeing req: %p, priv: %p.\n", __func__, req, req->priv);
> +		if (req->destructor)
> +			req->destructor(req);
> +		kmem_cache_free(kaio_req_cache, req);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Append a call request into cache.
> + * Returns -EOVERFLOW in case cache is full, and 0 otherwise.
> + */
> +int kaio_append_call(struct kaio_req *req, kaio_callback call)
> +{
> +	if ((req->add_idx + 1 == req->read_idx) ||
> +			((req->add_idx + 1 == KAIO_CALL_NUM) && req->read_idx == 0))
> +		return -EOVERFLOW;
> +
> +	req->call[req->add_idx] = call;
> +
> +	dprintk("%s: req: %p, read_idx: %d, add_idx: %d, call: %p [%p].\n",
> +			__func__, req, req->read_idx, req->add_idx,
> +			req->call[req->read_idx], req->call[req->add_idx]);
> +	if (++req->add_idx == KAIO_CALL_NUM)
> +		req->add_idx = 0;
> +
> +	kaio_req_get(req);
> +	
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL_GPL(kaio_append_call);
> +
> +/*
> + * Adds one call request into given cache.
> + * If cache is NULL or full, allocate new one.
> + */
> +struct kaio_req *kaio_add_call(struct kaio_req *req, kaio_callback call, int cpu, gfp_t gflags)
> +{
> +	if (req && !kaio_append_call(req, call)) {
> +		kaio_schedule_req(req);
> +		return req;
> +	}
> +
> +	req = kmem_cache_alloc(kaio_req_cache, gflags);
> +	if (!req)
> +		return NULL;
> +
> +	memset(req->call, 0, sizeof(req->call));
> +
> +	req->destructor = NULL;
> +	req->cpu = cpu;
> +	req->call[0] = call;
> +	req->add_idx = 1;
> +	req->read_idx = 0;
> +	req->flags = 0;
> +	atomic_set(&req->refcnt, 1);
> +
> +	dprintk("%s: req: %p, call: %p [%p].\n", __func__, req, call, req->call[0]);
> +
> +	return req;
> +}
> +
> +EXPORT_SYMBOL_GPL(kaio_add_call);
> +
> +/*
> + * Call appropriate callbacks in cache.
> + * This can only be called by working threads, which means that cache
> + * is filled (probably partially) and are not even accessible from
> + * the originator of requests, which means that cache will be freed
> + * when all callbacks are invoked.
> + *
> + * Callback itself can reschedule new callback into the same cache.
> + *
> + * If callback returns negative value, the whole cache will be freed.
> + * If positive value is returned, then further processing is stopped,
> + * so cache can be queued into the end of the processing FIFO by callback.
> + * If zero is returned, next callback will be invoked if any.
> + */
> +static int kaio_call(struct kaio_req *req)
> +{
> +	int err = -EINVAL;
> +
> +	if (likely(req->add_idx != req->read_idx)) {
> +		dprintk("%s: req: %p, read_idx: %d, add_idx: %d, call: %p [%p].\n",
> +				__func__, req, req->read_idx, req->add_idx,
> +				req->call[req->read_idx], req->call[0]);
> +		err = (*req->call[req->read_idx])(req, 0);
> +		if (++req->read_idx == KAIO_CALL_NUM)
> +			req->read_idx = 0;
> +
> +		if (kaio_req_put(req))
> +			err = 0;
> +	}
> +	return err;
> +}
> +
> +static int kaio_thread_process(void *data)
> +{
> +	struct kaio_thread *th = data;
> +	unsigned long flags;
> +	struct kaio_req *req, *first;
> +	DECLARE_WAITQUEUE(wait, current);
> +	int err;
> +
> +	add_wait_queue_exclusive(&th->wait, &wait);
> +
> +	while (!kthread_should_stop()) {
> +		first = req = NULL;
> +		do {
> +			req = NULL;
> +			spin_lock_irqsave(&th->req_lock, flags);
> +			if (!list_empty(&th->req_list)) {
> +				req = list_entry(th->req_list.prev, struct kaio_req, req_entry);
> +				if (first != req)
> +					list_del(&req->req_entry);
> +			}
> +			spin_unlock_irqrestore(&th->req_lock, flags);
> +				
> +			if (!first)
> +				first = req;
> +			else if (first == req)
> +				break;
> +
> +			if (req) {
> +				err = 0;
> +				while ((req->read_idx != req->add_idx) && !kthread_should_stop()) {
> +					dprintk("%s: req: %p, read_idx: %d, add_idx: %d, err: %d.\n",
> +							__func__, req, req->read_idx, req->add_idx, err);
> +					err = kaio_call(req);
> +					if (err != 0)
> +						break;
> +				}
> +
> +				if (err > 0) {
> +					spin_lock_irqsave(&th->req_lock, flags);
> +					list_add_tail(&req->req_entry, &th->req_list);
> +					spin_unlock_irqrestore(&th->req_lock, flags);
> +				}
> +			}
> +		} while (req);
> +		__set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ);
> +		__set_current_state(TASK_RUNNING);
> +	}
> +	
> +	remove_wait_queue(&th->wait, &wait);
> +
> +	return 0;
> +}
> +
> +struct kaio_private
> +{
> +	union {
> +		void 		*sptr;
> +		__u64		sdata;
> +	};
> +	union {
> +		void 		*dptr;
> +		__u64		ddata;
> +	};
> +	__u64			offset, processed;
> +	__u64			count, limit;
> +	struct kevent_user	*kevent_user;
> +};
> +
> +extern void bio_fs_destructor(struct bio *bio);
> +
> +static void kaio_bio_destructor(struct bio *bio)
> +{
> +	dprintk("%s: bio=%p, num=%u.\n", __func__, bio, bio->bi_vcnt);
> +	bio_fs_destructor(bio);
> +}
> +
> +static int kaio_read_send_pages(struct kaio_req *req, int direct);
> +
> +static int kaio_mpage_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
> +{
> +	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
> +	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
> +	struct kaio_req *req = bio->bi_private;
> +
> +	if (bio->bi_size)
> +		return 1;
> +
> +	do {
> +		struct page *page = bvec->bv_page;
> +
> +		if (--bvec >= bio->bi_io_vec)
> +			prefetchw(&bvec->bv_page->flags);
> +
> +		if (uptodate) {
> +			SetPageUptodate(page);
> +		} else {
> +			ClearPageUptodate(page);
> +			SetPageError(page);
> +		}
> +		unlock_page(page);
> +	} while (bvec >= bio->bi_io_vec);
> +
> +	dprintk("%s: bio: %p, req: %p, pending: %d.\n",
> +			__func__, bio, req, test_bit(KAIO_REQ_PENDING, &req->flags));
> +
> +	kaio_append_call(req, kaio_read_send_pages);
> +	kaio_req_put(req);
> +	kaio_schedule_req(req);
> +
> +	bio_put(bio);
> +	return 0;
> +}
> +
> +struct bio *kaio_mpage_bio_submit(int rw, struct bio *bio)
> +{
> +	if (bio) {
> +		bio->bi_end_io = kaio_mpage_end_io_read;
> +		dprintk("%s: bio=%p, num=%u.\n", __func__, bio, bio->bi_vcnt);
> +		submit_bio(READ, bio);
> +	}
> +	return NULL;
> +}
> +
> +struct bio *kaio_mpage_alloc(struct block_device *bdev,
> +		sector_t first_sector, int nr_vecs, gfp_t gfp_flags, void *priv)
> +{
> +	struct bio *bio;
> +
> +	bio = bio_alloc(gfp_flags, nr_vecs);
> +
> +	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
> +		while (!bio && (nr_vecs /= 2))
> +			bio = bio_alloc(gfp_flags, nr_vecs);
> +	}
> +
> +	if (bio) {
> +		struct kaio_req *req = priv;
> +
> +		bio->bi_bdev = bdev;
> +		bio->bi_sector = first_sector;
> +		bio->bi_private = priv;
> +		bio->bi_destructor = kaio_bio_destructor;
> +		kaio_req_get(req);
> +		dprintk("%s: bio: %p, req: %p, num: %d.\n", __func__, bio, priv, nr_vecs);
> +	}
> +	return bio;
> +}
> +
> +static ssize_t kaio_vfs_read_actor(struct kaio_private *priv, struct page *page, size_t len)
> +{
> +	struct socket *sock = priv->dptr;
> +	struct file *file = sock->file;
> +	
> +	return file->f_op->sendpage(file, page, 0, len, &file->f_pos, 1);
> +}
> +
> +static int kaio_vfs_read(struct kaio_private *priv,
> +		ssize_t (*actor)(struct kaio_private *, struct page *, size_t))
> +{
> +	struct address_space *mapping;
> +	struct file *file = priv->sptr;
> +	ssize_t actor_size;
> +	loff_t isize;
> +	int i = 0, pg_num;
> +
> +	mapping = file->f_mapping;
> +	isize = i_size_read(file->f_dentry->d_inode);
> +
> +	if (priv->processed >= isize) {
> +		priv->count = 0;
> +		return 0;
> +	}
> +	priv->count = isize - priv->processed;
> +	pg_num = ALIGN(min_t(u64, isize, priv->count), PAGE_SIZE) >> PAGE_SHIFT;
> +	
> +	dprintk("%s: start: priv: %p, ret: %d, num: %d, count: %Lu, offset: %Lu, processed: %Lu.\n",
> +			__func__, priv, i, pg_num, priv->count, priv->offset, priv->processed);
> +
> +	for (i=0; i<pg_num && priv->count; ++i) {
> +		struct page *page;
> +		size_t nr = PAGE_CACHE_SIZE;
> +
> +		page = find_get_page(mapping, priv->processed >> PAGE_CACHE_SHIFT);
> +		if (unlikely(page == NULL))
> +			break;
> +		if (!PageUptodate(page)) {
> +			dprintk("%s: %2d: page=%p, processed=%Lu, count=%Lu not uptodate.\n",
> +					__func__, i, page, priv->processed, priv->count);
> +			page_cache_release(page);
> +			break;
> +		}
> +
> +		if (mapping_writably_mapped(mapping))
> +			flush_dcache_page(page);
> +
> +		mark_page_accessed(page);
> +
> +		if (nr + priv->processed > isize)
> +			nr = isize - priv->processed;
> +		if (nr > priv->count)
> +			nr = priv->count;
> +
> +		actor_size = actor(priv, page, nr);
> +		if (actor_size < 0) {
> +			page_cache_release(page);
> +			i = (int)actor_size;
> +			break;
> +		}
> +
> +		page_cache_release(page);
> +
> +		priv->processed += actor_size;
> +		priv->count -= actor_size;
> +	}
> +
> +	if (!priv->count)
> +		i = pg_num;
> +
> +	dprintk("%s: end: priv: %p, ret: %d, num: %d, count: %Lu, offset: %Lu, processed: %Lu.\n",
> +			__func__, priv, i, pg_num, priv->count, priv->offset, priv->processed);
> +
> +	return i;
> +}
> +
> +static int kaio_read_send_pages(struct kaio_req *req, int direct)
> +{
> +	struct kaio_private *priv = req->priv;
> +	struct file *file = priv->sptr;
> +	struct address_space *mapping = file->f_mapping;
> +	struct page *page;
> +	int err, i, num;
> +	u64 offset;
> +	LIST_HEAD(page_pool);
> +
> +	err = kaio_vfs_read(priv, &kaio_vfs_read_actor);
> +	if (err < 0)
> +		return err;
> +
> +	if (err == 0) {
> +		priv->limit >>= 1;
> +	} else {
> +		if (priv->limit)
> +			priv->limit <<= 1;
> +		else
> +			priv->limit = 8;
> +	}
> +
> +	if (priv->offset < priv->processed)
> +		priv->offset = priv->processed;
> +
> +	if (!priv->count) {
> +		kevent_storage_ready(&priv->kevent_user->st, NULL, KEVENT_MASK_ALL);
> +		return 0;
> +	}
> +
> +	if (priv->offset >= priv->processed + priv->count) {
> +		kaio_append_call(req, kaio_read_send_pages);
> +		return 0;
> +	}
> +
> +	num = min_t(int, max_sane_readahead(priv->limit),
> +			ALIGN(priv->count, PAGE_SIZE) >> PAGE_SHIFT);
> +
> +	offset = priv->offset;
> +	for (i=0; i<num; ++i) {
> +		page = page_cache_alloc_cold(mapping);
> +		if (!page)
> +			break;
> +
> +		page->index = priv->offset >> PAGE_CACHE_SHIFT;
> +		list_add(&page->lru, &page_pool);
> +
> +		priv->offset += PAGE_CACHE_SIZE;
> +	}
> +
> +	dprintk("%s: submit: req: %p, priv: %p, offset: %Lu, num: %d, limit: %Lu.\n",
> +			__func__, req, priv, offset, i, priv->limit);
> +
> +	err = mapping->a_ops->aio_readpages(file, mapping, &page_pool, i, req);
> +	if (err) {
> +		dprintk("%s: kevent_mpage_readpages failed: err=%d, count=%Lu.\n",
> +				__func__, err, priv->count);
> +		kaio_schedule_req(req);
> +		return err;
> +	}
> +
> +	return 1;
> +}
> +
> +static int kaio_add_kevent(int fd, struct kaio_req *req)
> +{
> +	struct ukevent uk;
> +	struct file *file;
> +	struct kevent_user *u;
> +	int err, need_fput = 0;
> +	u32 *cnt;
> +
> +	file = fget_light(fd, &need_fput);
> +	if (!file) {
> +		err = -EBADF;
> +		goto err_out;
> +	}
> +
> +	if (file->f_op != &kevent_user_fops) {
> +		err = -EINVAL;
> +		goto err_out_fput;
> +	}
> +
> +	u = file->private_data;
> +
> +	memset(&uk, 0, sizeof(struct ukevent));
> +
> +	uk.event = KEVENT_MASK_ALL;
> +	uk.type = KEVENT_AIO;
> +
> +	preempt_disable();
> +	uk.id.raw[0] = smp_processor_id();
> +	cnt = &__get_cpu_var(kaio_req_counter);
> +	uk.id.raw[1] = *cnt;
> +	*cnt = *cnt + 1;
> +	preempt_enable();
> +
> +	uk.req_flags = KEVENT_REQ_ONESHOT | KEVENT_REQ_ALWAYS_QUEUE;
> +	uk.ptr = req;
> +
> +	err = kevent_user_add_ukevent(&uk, u);
> +	if (err)
> +		goto err_out_fput;
> +
> +	kevent_user_get(u);
> +
> +	fput_light(file, need_fput);
> +
> +	return 0;
> +
> +err_out_fput:
> +	fput_light(file, need_fput);
> +err_out:
> +	return err;
> +}
> +
> +static void kaio_destructor(struct kaio_req *req)
> +{
> +	struct kaio_private *priv = req->priv;
> +	struct socket *sock = priv->dptr;
> +	struct file *file = priv->sptr;
> +
> +	fput(file);
> +	sockfd_put(sock);
> +
> +	kevent_storage_ready(&priv->kevent_user->st, NULL, KEVENT_MASK_ALL);
> +	kevent_user_put(priv->kevent_user);
> +
> +	kmem_cache_free(kaio_priv_cache, req->priv);
> +}
> +
> +static struct kaio_req *kaio_sendfile(int kevent_fd, int sock_fd, struct file *file, off_t offset, size_t count)
> +{
> +	struct kaio_req *req;
> +	struct socket *sock;
> +	struct kaio_private *priv;
> +	int err;
> +
> +	sock = sockfd_lookup(sock_fd, &err);
> +	if (!sock)
> +		goto err_out_exit;
> +
> +	priv = kmem_cache_alloc(kaio_priv_cache, GFP_KERNEL);
> +	if (!priv)
> +		goto err_out_sput;
> +
> +	priv->sptr = file;
> +	priv->dptr = sock;
> +	priv->offset = offset;
> +	priv->count = min_t(u64, i_size_read(file->f_dentry->d_inode), count);
> +	priv->processed = offset;
> +	priv->limit = 128;
> +
> +	req = kaio_add_call(NULL, &kaio_read_send_pages, -1, GFP_KERNEL);
> +	if (!req)
> +		goto err_out_free;
> +
> +	req->destructor = kaio_destructor;
> +	req->priv = priv;
> +
> +	err = kaio_add_kevent(kevent_fd, req);
> +
> +	dprintk("%s: req: %p, priv: %p, call: %p [%p], offset: %Lu, processed: %Lu, count: %Lu, err: %d.\n",
> +			__func__, req, priv, &kaio_read_send_pages,
> +			kaio_read_send_pages, priv->offset, priv->processed, priv->count, err);
> +
> +	if (err)
> +		goto err_out_remove;
> +
> +	kaio_schedule_req(req);
> +
> +	return req;
> +
> +err_out_remove:
> +	/* It is safe to just free the object since it is guaranteed that it was not
> +	 * queued for processing.
> +	 */
> +	kmem_cache_free(kaio_req_cache, req);
> +err_out_free:
> +	kmem_cache_free(kaio_priv_cache, priv);
> +err_out_sput:
> +	sockfd_put(sock);
> +err_out_exit:
> +	return NULL;
> +
> +}
> +
> +asmlinkage long sys_aio_sendfile(int kevent_fd, int sock_fd, int in_fd, off_t offset, size_t count)
> +{
> +	struct kaio_req *req;
> +	struct file *file;
> +	int err;
> +
> +	file = fget(in_fd);
> +	if (!file) {
> +		err = -EBADF;
> +		goto err_out_exit;
> +	}
> +
> +	req = kaio_sendfile(kevent_fd, sock_fd, file, offset, count);
> +	if (!req) {
> +		err = -EINVAL;
> +		goto err_out_fput;
> +	}
> +
> +	return (long)req;
> +
> +err_out_fput:
> +	fput(file);
> +err_out_exit:
> +	return err;
> +}
> +
> +asmlinkage long sys_aio_sendfile_path(int kevent_fd, int sock_fd, char __user *filename, off_t offset, size_t count)
> +{
> +	char *tmp = getname(filename);
> +	int fd = PTR_ERR(tmp);
> +	int flags = O_RDONLY, err;
> +	struct nameidata nd;
> +	struct file *file;
> +	struct kaio_req *req;
> +
> +	if (force_o_largefile())
> +		flags = O_LARGEFILE;
> +
> +	if (IS_ERR(tmp)) {
> +		err = fd;
> +		goto err_out_exit;
> +	}
> +
> +	fd = get_unused_fd();
> +	if (fd < 0) {
> +		err = fd;
> +		goto err_out_put_name;
> +	}
> +
> +	if ((flags+1) & O_ACCMODE)
> +		flags++;
> +
> +	err = open_namei(AT_FDCWD, tmp, flags, 0400, &nd);
> +	if (err)
> +		goto err_out_fdput;
> +
> +	file = nameidata_to_filp(&nd, flags);
> +	if (!file)
> +		goto err_out_fdput;
> +
> +	/* One reference will be released in sys_close(),
> +	 * second one through req->destructor()
> +	 */
> +	atomic_inc(&file->f_count);
> +
> +	req = kaio_sendfile(kevent_fd, sock_fd, file, offset, count);
> +	if (!req) {
> +		err = -EINVAL;
> +		goto err_out_fput;
> +	}
> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +
> +err_out_fput:
> +	fput(file);
> +	fput(file);
> +err_out_fdput:
> +	put_unused_fd(fd);
> +err_out_put_name:
> +	putname(tmp);
> +err_out_exit:
> +	return err;
> +}
> +
> +static int kevent_aio_callback(struct kevent *k)
> +{
> +	struct kaio_req *req = k->event.ptr;
> +	struct kaio_private *priv = req->priv;
> +
> +	if (!priv->count) {
> +		__u32 *processed = (__u32 *)&priv->processed;
> +		k->event.ret_data[0] = processed[0];
> +		k->event.ret_data[1] = processed[1];
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int kevent_aio_enqueue(struct kevent *k)
> +{
> +	int err;
> +	struct kaio_req *req = k->event.ptr;
> +	struct kaio_private *priv = req->priv;
> +
> +	err = kevent_storage_enqueue(&k->user->st, k);
> +	if (err)
> +		goto err_out_exit;
> +
> +	priv->kevent_user = k->user;
> +	if (k->event.req_flags & KEVENT_REQ_ALWAYS_QUEUE)
> +		kevent_requeue(k);
> +
> +	return 0;
> +
> +err_out_exit:
> +	return err;
> +}
> +
> +int kevent_aio_dequeue(struct kevent *k)
> +{
> +	kevent_storage_dequeue(k->st, k);
> +
> +	return 0;
> +}
> +
> +static void kaio_thread_stop(struct kaio_thread *th)
> +{
> +	kthread_stop(th->thread);
> +	kfree(th);
> +}
> +
> +static int kaio_thread_start(struct kaio_thread **thp, int num)
> +{
> +	struct kaio_thread *th;
> +
> +	th = kzalloc(sizeof(struct kaio_thread), GFP_KERNEL);
> +	if (!th)
> +		return -ENOMEM;
> +
> +	th->refcnt = 1;
> +	spin_lock_init(&th->req_lock);
> +	INIT_LIST_HEAD(&th->req_list);
> +	init_waitqueue_head(&th->wait);
> +
> +	th->thread = kthread_run(kaio_thread_process, th, "kaio/%d", num);
> +	if (IS_ERR(th->thread)) {
> +		int err = PTR_ERR(th->thread);
> +		kfree(th);
> +		return err;
> +	}
> +
> +	*thp = th;
> +	wmb();
> +
> +	return 0;
> +}
> +
> +static int __init kevent_init_aio(void)
> +{
> +	struct kevent_callbacks sc = {
> +		.callback = &kevent_aio_callback,
> +		.enqueue = &kevent_aio_enqueue,
> +		.dequeue = &kevent_aio_dequeue,
> +		.flags = 0,
> +	};
> +	int err, i;
> +
> +	kaio_req_cache = kmem_cache_create("kaio_req", sizeof(struct kaio_req),
> +			0, SLAB_PANIC, NULL, NULL);
> +	kaio_priv_cache = kmem_cache_create("kaio_priv", sizeof(struct kaio_private),
> +			0, SLAB_PANIC, NULL, NULL);
> +
> +	memset(kaio_threads, 0, sizeof(kaio_threads));
> +
> +	for (i=0; i<KAIO_THREAD_NUM; ++i) {
> +		err = kaio_thread_start(&kaio_threads[i], i);
> +		if (err)
> +			goto err_out_stop;
> +	}
> +
> +	err = kevent_add_callbacks(&sc, KEVENT_AIO);
> +	if (err)
> +		goto err_out_stop;
> +
> +	return 0;
> +
> +err_out_stop:
> +	while (--i >= 0) {
> +		struct kaio_thread *th = kaio_threads[i];
> +
> +		kaio_threads[i] = NULL;
> +		wmb();
> +
> +		kaio_thread_stop(th);
> +	}
> +	return err;
> +}
> +module_init(kevent_init_aio);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

