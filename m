Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSH1JY2>; Wed, 28 Aug 2002 05:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSH1JY2>; Wed, 28 Aug 2002 05:24:28 -0400
Received: from [62.70.77.106] ([62.70.77.106]:20388 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316599AbSH1JYY> convert rfc822-to-8bit;
	Wed, 28 Aug 2002 05:24:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Andrew Morton <akpm@zip.com.au>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: [BUG+FIX] 2.4 buggercache sucks
Date: Wed, 28 Aug 2002 11:28:28 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200205241004.g4OA4Ul28364@mail.pronto.tv> <1572079531.1022225730@[10.10.2.3]> <3CEE954F.9CB99816@zip.com.au>
In-Reply-To: <3CEE954F.9CB99816@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208281128.28256.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

the patch below has now been tested out for quite some time.

Will it be likely to see this into 2.4.20?

roy


On Friday 24 May 2002 21:32, Andrew Morton wrote:
> "Martin J. Bligh" wrote:
> > >> Sounds like exactly the same problem we were having. There are two
> > >> approaches to solving this - Andrea has a patch that tries to free
> > >> them under memory pressure, akpm has a patch that hacks them down as
> > >> soon as you've fininshed with them (posted to lse-tech mailing list).
> > >> Both approaches seemed to work for me, but the performance of the
> > >> fixes still has to be established.
> > >
> > > Where can I find the akpm patch?
> >
> > http://marc.theaimsgroup.com/?l=lse-tech&m=102083525007877&w=2
> >
> > > Any plans to merge this into the main kernel, giving a choice
> > > (in config or /proc) to enable this?
> >
> > I don't think Andrew is ready to submit this yet ... before anything
> > gets merged back, it'd be very worthwhile testing the relative
> > performance of both solutions ... the more testers we have the
> > better ;-)
>
> Cripes no.  It's pretty experimental.  Andrea spotted a bug, too.  Fixed
> version is below.
>
> It's possible that keeping the number of buffers as low as possible
> will give improved performance over Andrea's approach because it
> leaves more ZONE_NORMAL for other things.  It's also possible that
> it'll give worse performance because more get_block's need to be
> done for file overwriting.
>
>
> --- 2.4.19-pre8/include/linux/pagemap.h~nuke-buffers	Fri May 24 12:24:56
> 2002 +++ 2.4.19-pre8-akpm/include/linux/pagemap.h	Fri May 24 12:26:30 2002
> @@ -89,13 +89,7 @@ extern void add_to_page_cache(struct pag
>  extern void add_to_page_cache_locked(struct page * page, struct
> address_space *mapping, unsigned long index); extern int
> add_to_page_cache_unique(struct page * page, struct address_space *mapping,
> unsigned long index, struct page **hash);
>
> -extern void ___wait_on_page(struct page *);
> -
> -static inline void wait_on_page(struct page * page)
> -{
> -	if (PageLocked(page))
> -		___wait_on_page(page);
> -}
> +extern void wait_on_page(struct page *);
>
>  extern struct page * grab_cache_page (struct address_space *, unsigned
> long); extern struct page * grab_cache_page_nowait (struct address_space *,
> unsigned long); --- 2.4.19-pre8/mm/filemap.c~nuke-buffers	Fri May 24
> 12:24:56 2002 +++ 2.4.19-pre8-akpm/mm/filemap.c	Fri May 24 12:24:56 2002
> @@ -608,7 +608,7 @@ int filemap_fdatawait(struct address_spa
>  		page_cache_get(page);
>  		spin_unlock(&pagecache_lock);
>
> -		___wait_on_page(page);
> +		wait_on_page(page);
>  		if (PageError(page))
>  			ret = -EIO;
>
> @@ -805,33 +805,29 @@ static inline wait_queue_head_t *page_wa
>  	return &wait[hash];
>  }
>
> -/*
> - * Wait for a page to get unlocked.
> +static void kill_buffers(struct page *page)
> +{
> +	if (!PageLocked(page))
> +		BUG();
> +	if (page->buffers)
> +		try_to_release_page(page, GFP_NOIO);
> +}
> +
> +/*
> + * Wait for a page to come unlocked.  Then try to ditch its buffer_heads.
>   *
> - * This must be called with the caller "holding" the page,
> - * ie with increased "page->count" so that the page won't
> - * go away during the wait..
> + * FIXME: Make the ditching dependent on CONFIG_MONSTER_BOX or something.
>   */
> -void ___wait_on_page(struct page *page)
> +void wait_on_page(struct page *page)
>  {
> -	wait_queue_head_t *waitqueue = page_waitqueue(page);
> -	struct task_struct *tsk = current;
> -	DECLARE_WAITQUEUE(wait, tsk);
> -
> -	add_wait_queue(waitqueue, &wait);
> -	do {
> -		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> -		if (!PageLocked(page))
> -			break;
> -		sync_page(page);
> -		schedule();
> -	} while (PageLocked(page));
> -	__set_task_state(tsk, TASK_RUNNING);
> -	remove_wait_queue(waitqueue, &wait);
> +	lock_page(page);
> +	kill_buffers(page);
> +	unlock_page(page);
>  }
> +EXPORT_SYMBOL(wait_on_page);
>
>  /*
> - * Unlock the page and wake up sleepers in ___wait_on_page.
> + * Unlock the page and wake up sleepers in lock_page.
>   */
>  void unlock_page(struct page *page)
>  {
> @@ -1400,6 +1396,11 @@ found_page:
>
>  		if (!Page_Uptodate(page))
>  			goto page_not_up_to_date;
> +		if (page->buffers) {
> +			lock_page(page);
> +			kill_buffers(page);
> +			unlock_page(page);
> +		}
>  		generic_file_readahead(reada_ok, filp, inode, page);
>  page_ok:
>  		/* If users can be writing to this page using arbitrary
> @@ -1457,6 +1458,7 @@ page_not_up_to_date:
>
>  		/* Did somebody else fill it already? */
>  		if (Page_Uptodate(page)) {
> +			kill_buffers(page);
>  			UnlockPage(page);
>  			goto page_ok;
>  		}
> @@ -1948,6 +1950,11 @@ retry_find:
>  	 */
>  	if (!Page_Uptodate(page))
>  		goto page_not_uptodate;
> +	if (page->buffers) {
> +		lock_page(page);
> +		kill_buffers(page);
> +		unlock_page(page);
> +	}
>
>  success:
>   	/*
> @@ -2006,6 +2013,7 @@ page_not_uptodate:
>
>  	/* Did somebody else get it up-to-date? */
>  	if (Page_Uptodate(page)) {
> +		kill_buffers(page);
>  		UnlockPage(page);
>  		goto success;
>  	}
> @@ -2033,6 +2041,7 @@ page_not_uptodate:
>
>  	/* Somebody else successfully read it in? */
>  	if (Page_Uptodate(page)) {
> +		kill_buffers(page);
>  		UnlockPage(page);
>  		goto success;
>  	}
> @@ -2850,6 +2859,7 @@ retry:
>  		goto retry;
>  	}
>  	if (Page_Uptodate(page)) {
> +		kill_buffers(page);
>  		UnlockPage(page);
>  		goto out;
>  	}
> --- 2.4.19-pre8/kernel/ksyms.c~nuke-buffers	Fri May 24 12:24:56 2002
> +++ 2.4.19-pre8-akpm/kernel/ksyms.c	Fri May 24 12:24:56 2002
> @@ -202,7 +202,6 @@ EXPORT_SYMBOL(ll_rw_block);
>  EXPORT_SYMBOL(submit_bh);
>  EXPORT_SYMBOL(unlock_buffer);
>  EXPORT_SYMBOL(__wait_on_buffer);
> -EXPORT_SYMBOL(___wait_on_page);
>  EXPORT_SYMBOL(generic_direct_IO);
>  EXPORT_SYMBOL(discard_bh_page);
>  EXPORT_SYMBOL(block_write_full_page);
> --- 2.4.19-pre8/mm/vmscan.c~nuke-buffers	Fri May 24 12:24:56 2002
> +++ 2.4.19-pre8-akpm/mm/vmscan.c	Fri May 24 12:24:56 2002
> @@ -365,8 +365,13 @@ static int shrink_cache(int nr_pages, zo
>  		if (unlikely(!page_count(page)))
>  			continue;
>
> -		if (!memclass(page_zone(page), classzone))
> +		if (!memclass(page_zone(page), classzone)) {
> +			if (page->buffers && !TryLockPage(page)) {
> +				try_to_release_page(page, GFP_NOIO);
> +				unlock_page(page);
> +			}
>  			continue;
> +		}
>
>  		/* Racy check to avoid trylocking when not worthwhile */
>  		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
> @@ -562,6 +567,11 @@ static int shrink_caches(zone_t * classz
>  	nr_pages -= kmem_cache_reap(gfp_mask);
>  	if (nr_pages <= 0)
>  		return 0;
> +	if ((gfp_mask & __GFP_WAIT) && (shrink_buffer_cache() > 16)) {
> +		nr_pages -= kmem_cache_reap(gfp_mask);
> +		if (nr_pages <= 0)
> +			return 0;
> +	}
>
>  	nr_pages = chunk_size;
>  	/* try to keep the active list 2/3 of the size of the cache */
> --- 2.4.19-pre8/fs/buffer.c~nuke-buffers	Fri May 24 12:24:56 2002
> +++ 2.4.19-pre8-akpm/fs/buffer.c	Fri May 24 12:26:28 2002
> @@ -1500,6 +1500,10 @@ static int __block_write_full_page(struc
>  	/* Stage 3: submit the IO */
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
> +		/*
> +		 * Stick it on BUF_LOCKED so shrink_buffer_cache() can nail it.
> +		 */
> +		refile_buffer(bh);
>  		submit_bh(WRITE, bh);
>  		bh = next;
>  	} while (bh != head);
> @@ -2615,6 +2619,25 @@ static int sync_page_buffers(struct buff
>  int try_to_free_buffers(struct page * page, unsigned int gfp_mask)
>  {
>  	struct buffer_head * tmp, * bh = page->buffers;
> +	int was_uptodate = 1;
> +
> +	if (!PageLocked(page))
> +		BUG();
> +
> +	if (!bh)
> +		return 1;
> +	/*
> +	 * Quick check for freeable buffers before we go take three
> +	 * global locks.
> +	 */
> +	if (!(gfp_mask & __GFP_IO)) {
> +		tmp = bh;
> +		do {
> +			if (buffer_busy(tmp))
> +				return 0;
> +			tmp = tmp->b_this_page;
> +		} while (tmp != bh);
> +	}
>
>  cleaned_buffers_try_again:
>  	spin_lock(&lru_list_lock);
> @@ -2637,7 +2660,8 @@ cleaned_buffers_try_again:
>  		tmp = tmp->b_this_page;
>
>  		if (p->b_dev == B_FREE) BUG();
> -
> +		if (!buffer_uptodate(p))
> +			was_uptodate = 0;
>  		remove_inode_queue(p);
>  		__remove_from_queues(p);
>  		__put_unused_buffer_head(p);
> @@ -2645,7 +2669,15 @@ cleaned_buffers_try_again:
>  	spin_unlock(&unused_list_lock);
>
>  	/* Wake up anyone waiting for buffer heads */
> -	wake_up(&buffer_wait);
> +	smp_mb();
> +	if (waitqueue_active(&buffer_wait))
> +		wake_up(&buffer_wait);
> +
> +	/*
> +	 * Make sure we don't read buffers again when they are reattached
> +	 */
> +	if (was_uptodate)
> +		SetPageUptodate(page);
>
>  	/* And free the page */
>  	page->buffers = NULL;
> @@ -2674,6 +2706,62 @@ busy_buffer_page:
>  }
>  EXPORT_SYMBOL(try_to_free_buffers);
>
> +/*
> + * Returns the number of pages which might have become freeable
> + */
> +int shrink_buffer_cache(void)
> +{
> +	struct buffer_head *bh;
> +	int nr_todo;
> +	int nr_shrunk = 0;
> +
> +	/*
> +	 * Move any clean unlocked buffers from BUF_LOCKED onto BUF_CLEAN
> +	 */
> +	spin_lock(&lru_list_lock);
> +	for ( ; ; ) {
> +		bh = lru_list[BUF_LOCKED];
> +		if (!bh || buffer_locked(bh))
> +			break;
> +		__refile_buffer(bh);
> +	}
> +
> +	/*
> +	 * Now start liberating buffers
> +	 */
> +	nr_todo = nr_buffers_type[BUF_CLEAN];
> +	while (nr_todo--) {
> +		struct page *page;
> +
> +		bh = lru_list[BUF_CLEAN];
> +		if (!bh)
> +			break;
> +
> +		/*
> +		 * Park the buffer on BUF_LOCKED so we don't revisit it on
> +		 * this pass.
> +		 */
> +		__remove_from_lru_list(bh);
> +		bh->b_list = BUF_LOCKED;
> +		__insert_into_lru_list(bh, BUF_LOCKED);
> +		page = bh->b_page;
> +		if (TryLockPage(page))
> +			continue;
> +
> +		page_cache_get(page);
> +		spin_unlock(&lru_list_lock);
> +		if (try_to_release_page(page, GFP_NOIO))
> +			nr_shrunk++;
> +		unlock_page(page);
> +		page_cache_release(page);
> +		spin_lock(&lru_list_lock);
> +	}
> +	spin_unlock(&lru_list_lock);
> +//	printk("%s: liberated %d page's worth of buffer_heads\n",
> +//		__FUNCTION__, nr_shrunk);
> +	return (nr_shrunk * sizeof(struct buffer_head)) / PAGE_CACHE_SIZE;
> +}
> +
>  /* ================== Debugging =================== */
>
>  void show_buffers(void)
> @@ -2988,6 +3076,7 @@ int kupdate(void *startup)
>  #ifdef DEBUG
>  		printk(KERN_DEBUG "kupdate() activated...\n");
>  #endif
> +		shrink_buffer_cache();
>  		sync_old_buffers();
>  		run_task_queue(&tq_disk);
>  	}
> --- 2.4.19-pre8/include/linux/fs.h~nuke-buffers	Fri May 24 12:24:56 2002
> +++ 2.4.19-pre8-akpm/include/linux/fs.h	Fri May 24 12:24:56 2002
> @@ -1116,6 +1116,7 @@ extern int FASTCALL(try_to_free_buffers(
>  extern void refile_buffer(struct buffer_head * buf);
>  extern void create_empty_buffers(struct page *, kdev_t, unsigned long);
>  extern void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
> +extern int shrink_buffer_cache(void);
>
>  /* reiserfs_writepage needs this */
>  extern void set_buffer_async_io(struct buffer_head *bh) ;
>
>
> -

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

