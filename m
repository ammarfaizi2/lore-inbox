Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSCBCCv>; Fri, 1 Mar 2002 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310260AbSCBCCm>; Fri, 1 Mar 2002 21:02:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:23450 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310258AbSCBCCb>; Fri, 1 Mar 2002 21:02:31 -0500
Date: Fri, 1 Mar 2002 19:16:26 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301191626.A13313@vger.timpanogas.org>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au>, <3C7FE7DD.98121E87@zip.com.au>; <20020301162016.A12413@vger.timpanogas.org> <3C800D66.F613BBAA@zip.com.au>, <3C800D66.F613BBAA@zip.com.au>; <20020301172701.A12718@vger.timpanogas.org> <3C8021A9.BB16E3FC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8021A9.BB16E3FC@zip.com.au>; from akpm@zip.com.au on Fri, Mar 01, 2002 at 04:49:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew,

Patch tested and stable.  I has to manually modify the value 
in /usr/src/linux/include/linux/blkdev.h from 128 to 1024 
since I noticed the 3Ware driver is going through the scsi.c
call to blk_init_queue() macro in this include file.  I am 
assuming that at some point, Adam and the other folks will
call this api directly.

Performance increased 2-3 % to 319 MB/S on dual 33/66 buses,
and utilization dropped to 27% +-.  All of this activity is 
DMA based and copyless between reading/writing nodes and 
I am running this UP and getting these numbers. I ran SMP 
as well and it also looks good.
 
Someone needs to look at just how the drivers will call 
__blk_init_queue() directly to setup custom depth queues
from scsi.c since this call is originating there for 
those IDE RAID drivers that fake out the system in thinking
they are SCSI.

:-)

Thanks for the help.  

Jeff 


On Fri, Mar 01, 2002 at 04:49:47PM -0800, Andrew Morton wrote:
> "Jeff V. Merkey" wrote:
> > 
> > ...
> > > OK.  So would it suffice to make queue_nr_requests an argument to
> > > a new blk_init_queue()?
> > >
> > > -     blk_init_queue(q, sci_request);
> > > +     blk_init_queue_ng(q, sci_request, 1024);
> > >
> > 
> > Andrew,
> > 
> > Yep.  This will do it.
> 
> OK.   The requirement seems eminently sensible to me.  Could
> you please verify the suitability of this patch?  And if Jens
> is OK with it, I'll stick it in the pile marked "Brazil".
> 
> 
> --- 2.4.19-pre2/drivers/block/ll_rw_blk.c~blk-queue	Fri Mar  1 15:30:13 2002
> +++ 2.4.19-pre2-akpm/drivers/block/ll_rw_blk.c	Fri Mar  1 15:57:07 2002
> @@ -117,16 +117,6 @@ int * max_readahead[MAX_BLKDEV];
>   */
>  int * max_sectors[MAX_BLKDEV];
>  
> -/*
> - * The total number of requests in each queue.
> - */
> -static int queue_nr_requests;
> -
> -/*
> - * The threshold around which we make wakeup decisions
> - */
> -static int batch_requests;
> -
>  static inline int get_max_sectors(kdev_t dev)
>  {
>  	if (!max_sectors[MAJOR(dev)])
> @@ -180,7 +170,7 @@ static int __blk_cleanup_queue(struct re
>   **/
>  void blk_cleanup_queue(request_queue_t * q)
>  {
> -	int count = queue_nr_requests;
> +	int count = q->nr_requests;
>  
>  	count -= __blk_cleanup_queue(&q->rq[READ]);
>  	count -= __blk_cleanup_queue(&q->rq[WRITE]);
> @@ -330,9 +320,11 @@ void generic_unplug_device(void *data)
>  	spin_unlock_irqrestore(&io_request_lock, flags);
>  }
>  
> -static void blk_init_free_list(request_queue_t *q)
> +static void blk_init_free_list(request_queue_t *q, int nr_requests)
>  {
>  	struct request *rq;
> +	struct sysinfo si;
> +	int megs;		/* Total memory, in megabytes */
>  	int i;
>  
>  	INIT_LIST_HEAD(&q->rq[READ].free);
> @@ -340,10 +332,17 @@ static void blk_init_free_list(request_q
>  	q->rq[READ].count = 0;
>  	q->rq[WRITE].count = 0;
>  
> +	si_meminfo(&si);
> +	megs = si.totalram >> (20 - PAGE_SHIFT);
> +	q->nr_requests = nr_requests;
> +	if (megs < 32)
> +		q->nr_requests /= 2;
> +	q->batch_requests = q->nr_requests / 4;
> +
>  	/*
>  	 * Divide requests in half between read and write
>  	 */
> -	for (i = 0; i < queue_nr_requests; i++) {
> +	for (i = 0; i < nr_requests; i++) {
>  		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
>  		if (rq == NULL) {
>  			/* We'll get a `leaked requests' message from blk_cleanup_queue */
> @@ -364,15 +363,17 @@ static void blk_init_free_list(request_q
>  static int __make_request(request_queue_t * q, int rw, struct buffer_head * bh);
>  
>  /**
> - * blk_init_queue  - prepare a request queue for use with a block device
> + * __blk_init_queue  - prepare a request queue for use with a block device
>   * @q:    The &request_queue_t to be initialised
>   * @rfn:  The function to be called to process requests that have been
>   *        placed on the queue.
> + * @nr_requests: the number of request structures on each of the device's
> + *               read and write request lists.
>   *
>   * Description:
>   *    If a block device wishes to use the standard request handling procedures,
>   *    which sorts requests and coalesces adjacent requests, then it must
> - *    call blk_init_queue().  The function @rfn will be called when there
> + *    call __blk_init_queue().  The function @rfn will be called when there
>   *    are requests on the queue that need to be processed.  If the device
>   *    supports plugging, then @rfn may not be called immediately when requests
>   *    are available on the queue, but may be called at some time later instead.
> @@ -392,15 +393,21 @@ static int __make_request(request_queue_
>   *    whenever the given queue is unplugged. This behaviour can be changed with
>   *    blk_queue_headactive().
>   *
> + *    Your selected value of nr_requests will be scaled down for small
> + *    machines.  See blk_init_free_list().
> + *
> + *    If nr_requests is less than 16, things will probably fail mysteriously.
> + *
>   * Note:
> - *    blk_init_queue() must be paired with a blk_cleanup_queue() call
> + *    __blk_init_queue() must be paired with a blk_cleanup_queue() call
>   *    when the block device is deactivated (such as at module unload).
>   **/
> -void blk_init_queue(request_queue_t * q, request_fn_proc * rfn)
> +void __blk_init_queue(request_queue_t * q,
> +		request_fn_proc * rfn, int nr_requests)
>  {
>  	INIT_LIST_HEAD(&q->queue_head);
>  	elevator_init(&q->elevator, ELEVATOR_LINUS);
> -	blk_init_free_list(q);
> +	blk_init_free_list(q, nr_requests);
>  	q->request_fn     	= rfn;
>  	q->back_merge_fn       	= ll_back_merge_fn;
>  	q->front_merge_fn      	= ll_front_merge_fn;
> @@ -610,7 +617,7 @@ void blkdev_release_request(struct reque
>  	 */
>  	if (q) {
>  		list_add(&req->queue, &q->rq[rw].free);
> -		if (++q->rq[rw].count >= batch_requests &&
> +		if (++q->rq[rw].count >= q->batch_requests &&
>  				waitqueue_active(&q->wait_for_requests[rw]))
>  			wake_up(&q->wait_for_requests[rw]);
>  	}
> @@ -802,7 +809,7 @@ get_rq:
>  		 * See description above __get_request_wait()
>  		 */
>  		if (rw_ahead) {
> -			if (q->rq[rw].count < batch_requests) {
> +			if (q->rq[rw].count < q->batch_requests) {
>  				spin_unlock_irq(&io_request_lock);
>  				goto end_io;
>  			}
> @@ -1149,12 +1156,9 @@ void end_that_request_last(struct reques
>  	blkdev_release_request(req);
>  }
>  
> -#define MB(kb)	((kb) << 10)
> -
>  int __init blk_dev_init(void)
>  {
>  	struct blk_dev_struct *dev;
> -	int total_ram;
>  
>  	request_cachep = kmem_cache_create("blkdev_requests",
>  					   sizeof(struct request),
> @@ -1170,22 +1174,6 @@ int __init blk_dev_init(void)
>  	memset(max_readahead, 0, sizeof(max_readahead));
>  	memset(max_sectors, 0, sizeof(max_sectors));
>  
> -	total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
> -
> -	/*
> -	 * Free request slots per queue.
> -	 * (Half for reads, half for writes)
> -	 */
> -	queue_nr_requests = 64;
> -	if (total_ram > MB(32))
> -		queue_nr_requests = 128;
> -
> -	/*
> -	 * Batch frees according to queue length
> -	 */
> -	batch_requests = queue_nr_requests/4;
> -	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
> -
>  #ifdef CONFIG_AMIGA_Z2RAM
>  	z2_init();
>  #endif
> @@ -1296,7 +1284,7 @@ int __init blk_dev_init(void)
>  EXPORT_SYMBOL(io_request_lock);
>  EXPORT_SYMBOL(end_that_request_first);
>  EXPORT_SYMBOL(end_that_request_last);
> -EXPORT_SYMBOL(blk_init_queue);
> +EXPORT_SYMBOL(__blk_init_queue);
>  EXPORT_SYMBOL(blk_get_queue);
>  EXPORT_SYMBOL(blk_cleanup_queue);
>  EXPORT_SYMBOL(blk_queue_headactive);
> --- 2.4.19-pre2/include/linux/blkdev.h~blk-queue	Fri Mar  1 15:31:09 2002
> +++ 2.4.19-pre2-akpm/include/linux/blkdev.h	Fri Mar  1 15:41:50 2002
> @@ -79,6 +79,16 @@ struct request_queue
>  	struct request_list	rq[2];
>  
>  	/*
> +	 * The total number of requests on each queue
> +	 */
> +	int nr_requests;
> +
> +	/*
> +	 * Batching threshold for sleep/wakeup decisions
> +	 */
> +	int batch_requests;
> +
> +	/*
>  	 * Together with queue_head for cacheline sharing
>  	 */
>  	struct list_head	queue_head;
> @@ -157,7 +167,8 @@ extern void blkdev_release_request(struc
>  /*
>   * Access functions for manipulating queue properties
>   */
> -extern void blk_init_queue(request_queue_t *, request_fn_proc *);
> +#define blk_init_queue(q, fn) __blk_init_queue(q, fn, 128)
> +extern void __blk_init_queue(request_queue_t *, request_fn_proc *, int);
>  extern void blk_cleanup_queue(request_queue_t *);
>  extern void blk_queue_headactive(request_queue_t *, int);
>  extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
> 
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
