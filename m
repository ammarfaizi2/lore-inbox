Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUEEGmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUEEGmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUEEGmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:42:53 -0400
Received: from sartre.ispvip.biz ([209.118.182.154]:45498 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S263028AbUEEGmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:42:44 -0400
Subject: Re: [3/3] wake-one PG_locked/BH_Lock semantics
From: "Michael J. Cohen" <mjc@unre.st>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040505061630.GY1397@holomorphy.com>
References: <20040505060612.GV1397@holomorphy.com>
	 <20040505060849.GW1397@holomorphy.com>
	 <20040505061121.GX1397@holomorphy.com>
	 <20040505061630.GY1397@holomorphy.com>
Content-Type: text/plain
Message-Id: <1083739343.7320.13.camel@dvdburner.uni.325i.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 05 May 2004 02:42:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tiobench numbers will be coming shortly from my test box but it appears
that this one at least feels slightly better than mainline.

------
Michael

On Wed, 2004-05-05 at 02:16, William Lee Irwin III wrote:
> On Tue, May 04, 2004 at 11:11:21PM -0700, William Lee Irwin III wrote:
> > Now, make bh's use the new wakeup primitive also. This has the bugfix
> > vs. the prior version that autoremoved waitqueue wakeup functions are
> > made to match autoremove API usage in __wait_event_filtered().
> 
> This is still grossly inefficient in that it's only necessary to wake
> one waiter when the waiter promises to eventually issue another wakeup
> e.g. when it releases the bit on the page. So here, wake-one semantics
> are implemented for those cases, using the WQ_FLAG_EXCLUSIVE flag in
> the waitqueue and the surrounding API's e.g. prepare_to_wait_exclusive().
> 
> I took the small liberty of adding list_for_each_entry_reverse_safe()
> to list.h as it generally makes sense, and gives the opportunity for
> fair FIFO wakeups wrapped up in a neat API.
> 
> 
> -- wli
> 
> Index: wake-2.6.6-rc3-mm1/fs/buffer.c
> ===================================================================
> --- wake-2.6.6-rc3-mm1.orig/fs/buffer.c	2004-05-04 13:16:16.000000000 -0700
> +++ wake-2.6.6-rc3-mm1/fs/buffer.c	2004-05-04 15:19:49.000000000 -0700
> @@ -78,6 +78,30 @@
>  }
>  EXPORT_SYMBOL(wake_up_buffer);
>  
> +static void sync_buffer(struct buffer_head *bh)
> +{
> +	struct block_device *bd;
> +	smp_mb();
> +	bd = bh->b_bdev;
> +	if (bd)
> +		blk_run_address_space(bd->bd_inode->i_mapping);
> +}
> +
> +void fastcall __lock_buffer(struct buffer_head *bh)
> +{
> +	wait_queue_head_t *wqh = bh_waitq_head(bh);
> +	DEFINE_FILTERED_WAIT(wait, bh);
> +	do {
> +		prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
> +		if (buffer_locked(bh)) {
> +			sync_buffer(bh);
> +			io_schedule();
> +		}
> +	} while (test_set_buffer_locked(bh));
> +	finish_wait(wqh, &wait.wait);
> +}
> +EXPORT_SYMBOL(__lock_buffer);
> +
>  void fastcall unlock_buffer(struct buffer_head *bh)
>  {
>  	clear_buffer_locked(bh);
> @@ -98,11 +122,7 @@
>  	do {
>  		prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
>  		if (buffer_locked(bh)) {
> -			struct block_device *bd;
> -			smp_mb();
> -			bd = bh->b_bdev;
> -			if (bd)
> -				blk_run_address_space(bd->bd_inode->i_mapping);
> +			sync_buffer(bh);
>  			io_schedule();
>  		}
>  	} while (buffer_locked(bh));
> Index: wake-2.6.6-rc3-mm1/include/linux/list.h
> ===================================================================
> --- wake-2.6.6-rc3-mm1.orig/include/linux/list.h	2004-04-30 15:06:48.000000000 -0700
> +++ wake-2.6.6-rc3-mm1/include/linux/list.h	2004-05-04 13:16:53.000000000 -0700
> @@ -413,6 +413,19 @@
>  	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
>  
>  /**
> + * list_for_each_entry_reverse_safe - iterate over list of given type safe against removal of list entry backward
> + * @pos:	the type * to use as a loop counter.
> + * @n:		another type * to use as temporary storage
> + * @head:	the head for your list.
> + * @member:	the name of the list_struct within the struct.
> + */
> +#define list_for_each_entry_reverse_safe(pos, n, head, member)		\
> +	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
> +		n = list_entry(pos->member.prev, typeof(*pos), member);	\
> +	     &pos->member != (head); 					\
> +	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
> +
> +/**
>   * list_for_each_rcu	-	iterate over an rcu-protected list
>   * @pos:	the &struct list_head to use as a loop counter.
>   * @head:	the head for your list.
> Index: wake-2.6.6-rc3-mm1/include/linux/buffer_head.h
> ===================================================================
> --- wake-2.6.6-rc3-mm1.orig/include/linux/buffer_head.h	2004-04-30 15:05:52.000000000 -0700
> +++ wake-2.6.6-rc3-mm1/include/linux/buffer_head.h	2004-05-04 15:13:37.000000000 -0700
> @@ -170,6 +170,7 @@
>  struct buffer_head *alloc_buffer_head(int gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void FASTCALL(unlock_buffer(struct buffer_head *bh));
> +void FASTCALL(__lock_buffer(struct buffer_head *bh));
>  void ll_rw_block(int, int, struct buffer_head * bh[]);
>  void sync_dirty_buffer(struct buffer_head *bh);
>  void submit_bh(int, struct buffer_head *);
> @@ -279,8 +280,8 @@
>  
>  static inline void lock_buffer(struct buffer_head *bh)
>  {
> -	while (test_set_buffer_locked(bh))
> -		__wait_on_buffer(bh);
> +	if (test_set_buffer_locked(bh))
> +		__lock_buffer(bh);
>  }
>  
>  #endif /* _LINUX_BUFFER_HEAD_H */
> Index: wake-2.6.6-rc3-mm1/kernel/sched.c
> ===================================================================
> --- wake-2.6.6-rc3-mm1.orig/kernel/sched.c	2004-05-04 13:16:00.000000000 -0700
> +++ wake-2.6.6-rc3-mm1/kernel/sched.c	2004-05-04 18:27:39.000000000 -0700
> @@ -2524,9 +2524,14 @@
>  	unsigned int mode = TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE;
>  	struct filtered_wait_queue *wait, *save;
>  	spin_lock_irqsave(&q->lock, flags);
> -	list_for_each_entry_safe(wait, save, &q->task_list, wait.task_list) {
> -		if (wait->key == key)
> -			wait->wait.func(&wait->wait, mode, 0);
> +	list_for_each_entry_reverse_safe(wait, save, &q->task_list, wait.task_list) {
> +		int exclusive = wait->wait.flags & WQ_FLAG_EXCLUSIVE;
> +		if (wait->key != key)
> +			continue;
> +		else if (!wait->wait.func(&wait->wait, mode, 0))
> +			continue;
> +		else if (exclusive)
> +			break;
>  	}
>  	spin_unlock_irqrestore(&q->lock, flags);
>  }
> Index: wake-2.6.6-rc3-mm1/mm/filemap.c
> ===================================================================
> --- wake-2.6.6-rc3-mm1.orig/mm/filemap.c	2004-05-04 13:16:00.000000000 -0700
> +++ wake-2.6.6-rc3-mm1/mm/filemap.c	2004-05-04 15:24:01.000000000 -0700
> @@ -297,17 +297,23 @@
>   * at a cost of "thundering herd" phenomena during rare hash
>   * collisions.
>   */
> -static wait_queue_head_t *page_waitqueue(struct page *page)
> +static wait_queue_head_t *page_waitqueue(struct page *page, int bit)
>  {
>  	const struct zone *zone = page_zone(page);
> +	unsigned long key = (unsigned long)page + bit;
> +	return &zone->wait_table[hash_long(key, zone->wait_table_bits)];
> +}
>  
> -	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
> +#define PAGE_KEY_SHIFT	(BITS_PER_LONG - (BITS_PER_LONG == 32 ? 5 : 6))
> +static void *page_key(struct page *page, unsigned long bit)
> +{
> +	return (void *)(page_to_pfn(page) | bit << PAGE_KEY_SHIFT);
>  }
>  
>  void fastcall wait_on_page_bit(struct page *page, int bit_nr)
>  {
> -	wait_queue_head_t *waitqueue = page_waitqueue(page);
> -	DEFINE_FILTERED_WAIT(wait, page);
> +	wait_queue_head_t *waitqueue = page_waitqueue(page, bit_nr);
> +	DEFINE_FILTERED_WAIT(wait, page_key(page, bit_nr));
>  
>  	do {
>  		prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
> @@ -338,13 +344,13 @@
>   */
>  void fastcall unlock_page(struct page *page)
>  {
> -	wait_queue_head_t *waitqueue = page_waitqueue(page);
> +	wait_queue_head_t *waitqueue = page_waitqueue(page, PG_locked);
>  	smp_mb__before_clear_bit();
>  	if (!TestClearPageLocked(page))
>  		BUG();
>  	smp_mb__after_clear_bit(); 
>  	if (waitqueue_active(waitqueue))
> -		wake_up_filtered(waitqueue, page);
> +		wake_up_filtered(waitqueue, page_key(page, PG_locked));
>  }
>  
>  EXPORT_SYMBOL(unlock_page);
> @@ -355,7 +361,7 @@
>   */
>  void end_page_writeback(struct page *page)
>  {
> -	wait_queue_head_t *waitqueue = page_waitqueue(page);
> +	wait_queue_head_t *waitqueue = page_waitqueue(page, PG_writeback);
>  
>  	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
>  		if (!test_clear_page_writeback(page))
> @@ -363,7 +369,7 @@
>  		smp_mb__after_clear_bit();
>  	}
>  	if (waitqueue_active(waitqueue))
> -		wake_up_filtered(waitqueue, page);
> +		wake_up_filtered(waitqueue, page_key(page, PG_writeback));
>  }
>  
>  EXPORT_SYMBOL(end_page_writeback);
> @@ -378,11 +384,11 @@
>   */
>  void fastcall __lock_page(struct page *page)
>  {
> -	wait_queue_head_t *wqh = page_waitqueue(page);
> -	DEFINE_FILTERED_WAIT(wait, page);
> +	wait_queue_head_t *wqh = page_waitqueue(page, PG_locked);
> +	DEFINE_FILTERED_WAIT(wait, page_key(page, PG_locked));
>  
>  	while (TestSetPageLocked(page)) {
> -		prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
> +		prepare_to_wait_exclusive(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
>  		if (PageLocked(page)) {
>  			sync_page(page);
>  			io_schedule();
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

