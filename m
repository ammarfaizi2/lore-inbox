Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310202AbSCBANP>; Fri, 1 Mar 2002 19:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310205AbSCBANF>; Fri, 1 Mar 2002 19:13:05 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:56985 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310202AbSCBAMw>; Fri, 1 Mar 2002 19:12:52 -0500
Date: Fri, 1 Mar 2002 17:27:01 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301172701.A12718@vger.timpanogas.org>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au>, <3C7FE7DD.98121E87@zip.com.au>; <20020301162016.A12413@vger.timpanogas.org> <3C800D66.F613BBAA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C800D66.F613BBAA@zip.com.au>; from akpm@zip.com.au on Fri, Mar 01, 2002 at 03:23:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 03:23:18PM -0800, Andrew Morton wrote:
> "Jeff V. Merkey" wrote:
> > 
> > The issue here is that it sleeps too much
> > and what's really happening and that we are forcing 8 disk drives
> > toshare 64/128 request buffers rather than provide each physical disk
> > with what it really needs.
> 
> OK.  So would it suffice to make queue_nr_requests an argument to
> a new blk_init_queue()?
> 
> -	blk_init_queue(q, sci_request);
> +	blk_init_queue_ng(q, sci_request, 1024);
> 

Andrew,

Yep.  This will do it.  3Ware (Adam) and the other RAID card folks 
would need to call and setup their queues based on how many disks 
are actually attached to the controller (which they know based on
their local state).  It would be great if this value were maintained as
adapter specific, i.e.

id blk_init_queue(request_queue_t * q, request_fn_proc * rfn, int depth)
{
        INIT_LIST_HEAD(&q->queue_head);
        elevator_init(&q->elevator, ELEVATOR_LINUS);
        blk_init_free_list(q);
        q->request_fn           = rfn;
        q->back_merge_fn        = ll_back_merge_fn;
        q->front_merge_fn       = ll_front_merge_fn;
        q->merge_requests_fn    = ll_merge_requests_fn;
        q->make_request_fn      = __make_request;
        q->plug_tq.sync         = 0;
        q->plug_tq.routine      = &generic_unplug_device;
        q->plug_tq.data         = q;
        q->plugged              = 0;

        // NEW CODE

        if (depth > 1024)
           depth = 1024;
        q->queue_nr_requests_local = (depth ? depth : -1);

        //  

        /*
         * These booleans describe the queue properties.  We set the
         * default (and most common) values here.  Other drivers can
         * use the appropriate functions to alter the queue properties.
         * as appropriate.
         */
        q->plug_device_fn       = generic_plug_device;
        q->head_active          = 1;
}

and the modify this function something like this:

static void blk_init_free_list(request_queue_t *q)
{
        struct request *rq;
        int i;

        // NEW CODE
        //
        int queue_depth;

        queue_depth = ((q->queue_nr_requests_local != -1)
                      ? q->queue_nr_requests_local
                      : queue_nr_requests);
        //
        //

        INIT_LIST_HEAD(&q->rq[READ].free);
        INIT_LIST_HEAD(&q->rq[WRITE].free);
        q->rq[READ].count = 0;
        q->rq[WRITE].count = 0;

        /*
         * Divide requests in half between read and write
         */

//        for (i = 0; i < queue_nr_requests; i++) {
        for (i = 0; i < queue_depth; i++) {

                rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
                if (rq == NULL) {
                        /* We'll get a `leaked requests' message from blk_cleanup_queue */
                        printk(KERN_EMERG "blk_init_free_list: error allocating
requests\n");
                        break;
                }
                memset(rq, 0, sizeof(struct request));
                rq->rq_status = RQ_INACTIVE;
                list_add(&rq->queue, &q->rq[i&1].free);
                q->rq[i&1].count++;
        }

        init_waitqueue_head(&q->wait_for_request);
        spin_lock_init(&q->queue_lock);
}

and we're there.

:-)

Jeff

> 
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
