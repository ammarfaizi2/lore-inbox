Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbTIIPht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbTIIPht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:37:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:25789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264176AbTIIPhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:37:43 -0400
Date: Tue, 9 Sep 2003 08:38:16 -0700
From: Dave Olien <dmo@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Badness in as_completed_request warning
Message-ID: <20030909153816.GA16855@osdl.org>
References: <20030908164802.GA13441@osdl.org> <3F5D4BC9.6020708@cyberone.com.au> <20030909061214.GA15840@osdl.org> <3F5D7B6A.70703@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <3F5D7B6A.70703@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Sorry, this one Bug()'d  really quickly. I applied this patch to
an unmodified test5 kernel.  Console output is attached.

On Tue, Sep 09, 2003 at 05:04:10PM +1000, Nick Piggin wrote:
> 
> Thanks Dave,
> Can you try this one? I can't reproduce the problem here as I don't have
> enough disks unfortunately. Thanks
> 
> Nick

>  linux-2.6-npiggin/drivers/block/as-iosched.c |   60 +++++++++++++++++++--------
>  1 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff -puN drivers/block/as-iosched.c~as-warn-fix drivers/block/as-iosched.c
> --- linux-2.6/drivers/block/as-iosched.c~as-warn-fix	2003-09-09 17:02:41.000000000 +1000
> +++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-09-09 17:02:41.000000000 +1000
> @@ -373,7 +373,7 @@ static void as_move_to_dispatch(struct a
>   * direct IO, then move the alias to the dispatch list and then add the
>   * request.
>   */
> -static void as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
> +static int as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
>  {
>  	struct as_rq *alias;
>  	struct request *rq = arq->request;
> @@ -381,10 +381,20 @@ static void as_add_arq_rb(struct as_data
>  	arq->rb_key = rq_rb_key(rq);
>  
>  	/* This can be caused by direct IO */
> +#if 0
>  	while ((alias = __as_add_arq_rb(ad, arq)))
>  		as_move_to_dispatch(ad, alias);
> +#endif
> +	if ((alias = __as_add_arq_rb(ad, arq))) {
> +		arq->state = AS_RQ_NEW;
> +		list_add_tail(&arq->request->queuelist,
> +				&alias->request->queuelist);
> +
> +		return 1;
> +	}
>  
>  	rb_insert_color(&arq->rb_node, ARQ_RB_ROOT(ad, arq));
> +	return 0;
>  }
>  
>  static inline void as_del_arq_rb(struct as_data *ad, struct as_rq *arq)
> @@ -1131,7 +1141,21 @@ static void as_move_to_dispatch(struct a
>  	 * take it off the sort and fifo list, add to dispatch queue
>  	 */
>  	as_remove_queued_request(ad->q, arq->request);
> +
> +	for (;;) {
> +		struct list_head *alias = &arq->request->queuelist;
> +
> +		if (!list_empty(alias)) {
> +			struct request *rq;
> +			rq = list_entry_rq(alias->next);
> +			list_del(&rq->queuelist);
> +			list_add_tail(&rq->queuelist, ad->dispatch);
> +		} else
> +			break;
> +	}
> +
>  	list_add_tail(&arq->request->queuelist, ad->dispatch);
> +
>  	if (arq->io_context && arq->io_context->aic)
>  		atomic_inc(&arq->io_context->aic->nr_dispatched);
>  
> @@ -1303,22 +1327,22 @@ static void as_add_request(struct as_dat
>  		arq->is_sync = 0;
>  	data_dir = arq->is_sync;
>  
> -	arq->io_context = as_get_io_context();
> +	if (!as_add_arq_rb(ad, arq)) {
> +		arq->io_context = as_get_io_context();
>  
> -	if (arq->io_context) {
> -		atomic_inc(&arq->io_context->aic->nr_queued);
> -		as_update_iohist(arq->io_context->aic, arq->request);
> -	}
> -
> -	as_add_arq_rb(ad, arq);
> +		if (arq->io_context) {
> +			atomic_inc(&arq->io_context->aic->nr_queued);
> +			as_update_iohist(arq->io_context->aic, arq->request);
> +		}
>  
> -	/*
> -	 * set expire time (only used for reads) and add to fifo list
> -	 */
> -	arq->expires = jiffies + ad->fifo_expire[data_dir];
> -	list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
> -	arq->state = AS_RQ_QUEUED;
> -	as_update_arq(ad, arq); /* keep state machine up to date */
> +		/*
> +		 * set expire time (only used for reads) and add to fifo list
> +		 */
> +		arq->expires = jiffies + ad->fifo_expire[data_dir];
> +		list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
> +		arq->state = AS_RQ_QUEUED;
> +		as_update_arq(ad, arq); /* keep state machine up to date */
> +	}
>  }
>  
>  /*
> @@ -1495,7 +1519,8 @@ static void as_merged_request(request_qu
>  	 */
>  	if (rq_rb_key(req) != arq->rb_key) {
>  		as_del_arq_rb(ad, arq);
> -		as_add_arq_rb(ad, arq);
> +		if (as_add_arq_rb(ad, arq))
> +			WARN_ON(1);
>  		/*
>  		 * Note! At this stage of this and the next function, our next
>  		 * request may not be optimal - eg the request may have "grown"
> @@ -1526,7 +1551,8 @@ as_merged_requests(request_queue_t *q, s
>  
>  	if (rq_rb_key(req) != arq->rb_key) {
>  		as_del_arq_rb(ad, arq);
> -		as_add_arq_rb(ad, arq);
> +		if (as_add_arq_rb(ad, arq))
> +			WARN_ON(1);
>  	}
>  
>  	/*
> 
> _


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=typescript


root@cl045 root]# ------------[ cut here ]------------
kernel BUG at drivers/block/as-iosched.c:302!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c021a880>]    Not tainted
EFLAGS: 00010046
EIP is at as_find_arq_hash+0x80/0x90
eax: 00000000   ebx: d2fc8ed4   ecx: d2fc8ed4   edx: d2fc8eb8
esi: d2fc9ec0   edi: c17319e0   ebp: 007c054f   esp: dd4fdae0
ds: 007b   es: 007b   ss: 0068
Process mkfs.ext2 (pid: 1276, threadinfo=dd4fc000 task=df5b06f0)
Stack: c4acd320 c1731a00 007c0551 00000000 c021bf54 dfd3cbc0 007c054f d41d6a98 
       c0215a49 dfd3cbc0 00000000 c1731a00 d41d6a98 00000001 c0213709 c1731a00 
       dd4fdb4c c4acd320 c0216578 c1731a00 dd4fdb4c c4acd320 00000000 007c054f 
Call Trace:
 [<c021bf54>] as_merge+0xe4/0x170
 [<c0215a49>] get_request+0x1b9/0x2a0
 [<c0213709>] elv_merge+0x29/0x30
 [<c0216578>] __make_request+0x338/0x580
 [<c02168d5>] generic_make_request+0x115/0x1a0
 [<c0119ebd>] smp_apic_timer_interrupt+0xdd/0x150
 [<c015d917>] bio_alloc+0xd7/0x1c0
 [<c02169b4>] submit_bio+0x54/0xa0
 [<c015b660>] __block_write_full_page+0x270/0x470
 [<c015ceda>] block_write_full_page+0xfa/0x120
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c015fe3f>] blkdev_writepage+0x1f/0x30
 [<c015fcc0>] blkdev_get_block+0x0/0x60
 [<c017a308>] mpage_writepages+0x208/0x2db
 [<c015fe20>] blkdev_writepage+0x0/0x30
 [<c016102f>] generic_writepages+0x1f/0x23
 [<c014198e>] do_writepages+0x1e/0x40
 [<c0178866>] __sync_single_inode+0xc6/0x220
 [<c0178c1c>] sync_sb_inodes+0x1ac/0x270
 [<c0178d4a>] writeback_inodes+0x6a/0xa0
 [<c0141438>] balance_dirty_pages+0xb8/0x160
 [<c013e1ad>] generic_file_aio_write_nolock+0x4cd/0xac0
 [<c013cbf1>] file_read_actor+0xe1/0x100
 [<c010b96e>] apic_timer_interrupt+0x1a/0x20
 [<c013e81e>] generic_file_write_nolock+0x7e/0xa0
 [<c011e8e0>] default_wake_function+0x0/0x30
 [<c012a906>] update_wall_time+0x16/0x40
 [<c012ad30>] do_timer+0xc0/0xd0
 [<c0111826>] timer_interrupt+0x56/0x110
 [<c0160dd7>] blkdev_file_write+0x37/0x40
 [<c015844e>] vfs_write+0xbe/0x130
 [<c0158572>] sys_write+0x42/0x70
 [<c010af2d>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 2e 01 49 bf 30 c0 eb b5 8d b6 00 00 00 00 8b 54 24 08 

--PEIAKu/WMn1b1Hv9--
