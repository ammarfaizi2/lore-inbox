Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310340AbSCBHT3>; Sat, 2 Mar 2002 02:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310341AbSCBHTU>; Sat, 2 Mar 2002 02:19:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21403 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310340AbSCBHTL>; Sat, 2 Mar 2002 02:19:11 -0500
Date: Sat, 2 Mar 2002 00:33:25 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020302003325.A14624@vger.timpanogas.org>
In-Reply-To: <3C7FE7DD.98121E87@zip.com.au>, <3C7FE7DD.98121E87@zip.com.au>; <20020301162016.A12413@vger.timpanogas.org> <3C800D66.F613BBAA@zip.com.au>, <3C800D66.F613BBAA@zip.com.au>; <20020301172701.A12718@vger.timpanogas.org> <3C8021A9.BB16E3FC@zip.com.au>, <3C8021A9.BB16E3FC@zip.com.au>; <20020301191626.A13313@vger.timpanogas.org> <3C804BF0.3993B153@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C804BF0.3993B153@zip.com.au>; from akpm@zip.com.au on Fri, Mar 01, 2002 at 07:50:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew,

Patch is tested and stable.  

Jeff


On Fri, Mar 01, 2002 at 07:50:08PM -0800, Andrew Morton wrote:
> "Jeff V. Merkey" wrote:
> > 
> > Andrew,
> > 
> > Patch tested and stable.  I has to manually modify the value
> > in /usr/src/linux/include/linux/blkdev.h from 128 to 1024
> > since I noticed the 3Ware driver is going through the scsi.c
> > call to blk_init_queue() macro in this include file.  I am
> > assuming that at some point, Adam and the other folks will
> > call this api directly.
> > 
> > Performance increased 2-3 % to 319 MB/S on dual 33/66 buses,
> > and utilization dropped to 27% +-.  All of this activity is
> > DMA based and copyless between reading/writing nodes and
> > I am running this UP and getting these numbers. I ran SMP
> > as well and it also looks good.
> > 
> > Someone needs to look at just how the drivers will call
> > __blk_init_queue() directly to setup custom depth queues
> > from scsi.c since this call is originating there for
> > those IDE RAID drivers that fake out the system in thinking
> > they are SCSI.
> > 
> 
> So it would be more straightforward to just allow the queue
> to be grown later on?
> 
> 
> 
> --- 2.4.19-pre2/drivers/block/ll_rw_blk.c~blk-queue	Fri Mar  1 19:40:12 2002
> +++ 2.4.19-pre2-akpm/drivers/block/ll_rw_blk.c	Fri Mar  1 19:48:33 2002
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
> @@ -330,31 +320,62 @@ void generic_unplug_device(void *data)
>  	spin_unlock_irqrestore(&io_request_lock, flags);
>  }
>  
> +/** blk_grow_request_list
> + *  @q: The &request_queue_t
> + *  @nr_requests: how many requests are desired
> + *
> + * More free requests are added to the queue's free lists, bringing
> + * the total number of requests to @nr_requests.
> + *
> + * The requests are added equally to the request queue's read
> + * and write freelists.
> + *
> + * This function can sleep.
> + *
> + * Returns the (new) number of requests which the queue has available.
> + */
> +int blk_grow_request_list(request_queue_t *q, int nr_requests)
> +{
> +	spin_lock_irq(&io_request_lock);
> +	while (q->nr_requests < nr_requests) {
> +		struct request *rq;
> +		int rw;
> +
> +		spin_unlock_irq(&io_request_lock);
> +		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
> +		spin_lock_irq(&io_request_lock);
> +		if (rq == NULL)
> +			break;
> +		memset(rq, 0, sizeof(*rq));
> +		rq->rq_status = RQ_INACTIVE;
> +		rw = q->nr_requests & 1;
> +		list_add(&rq->queue, &q->rq[rw].free);
> +		q->rq[rw].count++;
> +		q->nr_requests++;
> +	}
> +	q->batch_requests = q->nr_requests / 4;
> +	spin_unlock_irq(&io_request_lock);
> +	return q->nr_requests;
> +}
> +
>  static void blk_init_free_list(request_queue_t *q)
>  {
> -	struct request *rq;
> -	int i;
> +	struct sysinfo si;
> +	int megs;		/* Total memory, in megabytes */
> +	int nr_requests;
>  
>  	INIT_LIST_HEAD(&q->rq[READ].free);
>  	INIT_LIST_HEAD(&q->rq[WRITE].free);
>  	q->rq[READ].count = 0;
>  	q->rq[WRITE].count = 0;
> +	q->nr_requests = 0;
>  
> -	/*
> -	 * Divide requests in half between read and write
> -	 */
> -	for (i = 0; i < queue_nr_requests; i++) {
> -		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
> -		if (rq == NULL) {
> -			/* We'll get a `leaked requests' message from blk_cleanup_queue */
> -			printk(KERN_EMERG "blk_init_free_list: error allocating requests\n");
> -			break;
> -		}
> -		memset(rq, 0, sizeof(struct request));
> -		rq->rq_status = RQ_INACTIVE;
> -		list_add(&rq->queue, &q->rq[i&1].free);
> -		q->rq[i&1].count++;
> -	}
> +	si_meminfo(&si);
> +	megs = si.totalram >> (20 - PAGE_SHIFT);
> +	nr_requests = 128;
> +	if (megs < 32)
> +		nr_requests /= 2;
> +	blk_grow_request_list(q, nr_requests);
>  
>  	init_waitqueue_head(&q->wait_for_requests[0]);
>  	init_waitqueue_head(&q->wait_for_requests[1]);
> @@ -610,7 +631,7 @@ void blkdev_release_request(struct reque
>  	 */
>  	if (q) {
>  		list_add(&req->queue, &q->rq[rw].free);
> -		if (++q->rq[rw].count >= batch_requests &&
> +		if (++q->rq[rw].count >= q->batch_requests &&
>  				waitqueue_active(&q->wait_for_requests[rw]))
>  			wake_up(&q->wait_for_requests[rw]);
>  	}
> @@ -802,7 +823,7 @@ get_rq:
>  		 * See description above __get_request_wait()
>  		 */
>  		if (rw_ahead) {
> -			if (q->rq[rw].count < batch_requests) {
> +			if (q->rq[rw].count < q->batch_requests) {
>  				spin_unlock_irq(&io_request_lock);
>  				goto end_io;
>  			}
> @@ -1149,12 +1170,9 @@ void end_that_request_last(struct reques
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
> @@ -1170,22 +1188,6 @@ int __init blk_dev_init(void)
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
> @@ -1296,6 +1298,7 @@ int __init blk_dev_init(void)
>  EXPORT_SYMBOL(io_request_lock);
>  EXPORT_SYMBOL(end_that_request_first);
>  EXPORT_SYMBOL(end_that_request_last);
> +EXPORT_SYMBOL(blk_grow_request_list);
>  EXPORT_SYMBOL(blk_init_queue);
>  EXPORT_SYMBOL(blk_get_queue);
>  EXPORT_SYMBOL(blk_cleanup_queue);
> --- 2.4.19-pre2/include/linux/blkdev.h~blk-queue	Fri Mar  1 19:40:12 2002
> +++ 2.4.19-pre2-akpm/include/linux/blkdev.h	Fri Mar  1 19:40:12 2002
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
> @@ -157,6 +167,7 @@ extern void blkdev_release_request(struc
>  /*
>   * Access functions for manipulating queue properties
>   */
> +extern int blk_grow_request_list(request_queue_t *q, int nr_requests);
>  extern void blk_init_queue(request_queue_t *, request_fn_proc *);
>  extern void blk_cleanup_queue(request_queue_t *);
>  extern void blk_queue_headactive(request_queue_t *, int);
