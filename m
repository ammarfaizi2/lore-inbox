Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbVJTNp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVJTNp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVJTNp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:45:27 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:41773 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVJTNp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:45:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=V2/P42AbPsNaQP5bcyxFRx5SrHIJ4FMSbm0i6MKY37aNJTT/AcfeG5MS5VUMPED9R7nxaXg7HS8i8sk0w7XR+kI6Ip3ILfQDvlrfprfsvGwFw0pcj7FBXYsJugKnSd4LDwSc6wDyXIWLTKPbjn7B/TrtcMkanTSom23DwdIGSDY=
Date: Thu, 20 Oct 2005 22:45:15 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 01/05] blk: implement generic dispatch queue
Message-ID: <20051020134515.GA26004@htj.dyndns.org>
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.1D0A2F29@htj.dyndns.org> <20051020100003.GB2811@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020100003.GB2811@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, Jens.

On Thu, Oct 20, 2005 at 12:00:03PM +0200, Jens Axboe wrote:
> On Wed, Oct 19 2005, Tejun Heo wrote:
> > @@ -40,6 +40,11 @@
> >  static DEFINE_SPINLOCK(elv_list_lock);
> >  static LIST_HEAD(elv_list);
> >  
> > +static inline sector_t rq_last_sector(struct request *rq)
> > +{
> > +	return rq->sector + rq->nr_sectors;
> > +}
> 
> Slightly misnamed, since it's really the sector after the last sector
> :-)
> 
> I've renamed that to rq_end_sector() instead.

 Maybe rename request_queue->last_sector too?

> 
> > +/*
> > + * Insert rq into dispatch queue of q.  Queue lock must be held on
> > + * entry.  If sort != 0, rq is sort-inserted; otherwise, rq will be
> > + * appended to the dispatch queue.  To be used by specific elevators.
> > + */
> > +void elv_dispatch_insert(request_queue_t *q, struct request *rq, int sort)
> > +{
> > +	sector_t boundary;
> > +	unsigned max_back;
> > +	struct list_head *entry;
> > +
> > +	if (!sort) {
> > +		/* Specific elevator is performing sort.  Step away. */
> > +		q->last_sector = rq_last_sector(rq);
> > +		q->boundary_rq = rq;
> > +		list_add_tail(&rq->queuelist, &q->queue_head);
> > +		return;
> > +	}
> > +
> > +	boundary = q->last_sector;
> > +	max_back = q->max_back_kb * 2;
> > +	boundary = boundary > max_back ? boundary - max_back : 0;
> 
> This looks really strange, what are you doing with boundary here?
> 

 Taking backward seeking into account.  I reasonsed that if specific
elevator chooses the next request with backward seeking,
elv_dispatch_insert() shouldn't change the order because that may
result in less efficient seek pattern.  At the second thought,
specific elevators always perform sorting by itself in such cases, so
this seems unnecessary.  I think we can strip this thing out.

> > +	list_for_each_prev(entry, &q->queue_head) {
> > +		struct request *pos = list_entry_rq(entry);
> > +
> > +		if (pos->flags & (REQ_SOFTBARRIER|REQ_HARDBARRIER|REQ_STARTED))
> > +			break;
> > +		if (rq->sector >= boundary) {
> > +			if (pos->sector < boundary)
> > +				continue;
> > +		} else {
> > +			if (pos->sector >= boundary)
> > +				break;
> > +		}
> > +		if (rq->sector >= pos->sector)
> > +			break;
> > +	}
> > +
> > +	list_add(&rq->queuelist, entry);
> > +}
> 
> I've split this into, I don't like rolled-up functions that really do
> two seperate things. So elv_dispatch_sort() now does sorting,
> elv_dispatch_add_tail() does what !sort would have done.

 Fine.

> 
> >  	while ((rq = __elv_next_request(q)) != NULL) {
> > -		/*
> > -		 * just mark as started even if we don't start it, a request
> > -		 * that has been delayed should not be passed by new incoming
> > -		 * requests
> > -		 */
> > -		rq->flags |= REQ_STARTED;
> > +		if (!(rq->flags & REQ_STARTED)) {
> > +			elevator_t *e = q->elevator;
> > +
> > +			/*
> > +			 * This is the first time the device driver
> > +			 * sees this request (possibly after
> > +			 * requeueing).  Notify IO scheduler.
> > +			 */
> > +			if (blk_sorted_rq(rq) &&
> > +			    e->ops->elevator_activate_req_fn)
> > +				e->ops->elevator_activate_req_fn(q, rq);
> > +
> > +			/*
> > +			 * just mark as started even if we don't start
> > +			 * it, a request that has been delayed should
> > +			 * not be passed by new incoming requests
> > +			 */
> > +			rq->flags |= REQ_STARTED;
> > +		}
> >  
> >  		if (rq == q->last_merge)
> >  			q->last_merge = NULL;
> >  
> > +		if (!q->boundary_rq || q->boundary_rq == rq) {
> > +			q->last_sector = rq_last_sector(rq);
> > +			q->boundary_rq = NULL;
> > +		}
> 
> This seems to be the only place where you clear ->boundary_rq, that
> can't be right. What about rq-to-rq merging, ->boundary_rq could be
> freed and you wont notice. Generally I don't really like keeping
> pointers to rqs around, it's given us problems in the past with the
> last_merge bits even. For now I've added a clear of this in
> __blk_put_request() as well.

 Oh, please don't do that.  Now, it's guaranteed that there are only
three paths a request can travel.

 set_req_fn ->

 i.   add_req_fn -> (merged_fn ->)* -> dispatch_fn -> activate_req_fn ->
      (deactivate_req_fn -> activate_req_fn ->)* -> completed_req_fn
 ii.  add_req_fn -> (merged_fn ->)* -> merge_req_fn
 iii. [none]

 -> put_req_fn

 These three are the only paths a request can travel.  Also note that
dispatched requests don't get merged.  So, after dispatched, the only
way out is via elevator_complete_req_fn and that's why that's the only
place ->boundary_rq is cleared.  I've also documented above in biodoc
so that we can simplify codes knowing above information.

 boundary_rq is used to keep request sorting sane when some pre-sorted
requests are present in the dispatch queue.  Without it request
sorting acts wierdly when barrier requests are in the dispatch queue.

> 
> >  int elv_queue_empty(request_queue_t *q)
> >  {
> >  	elevator_t *e = q->elevator;
> >  
> > +	if (!list_empty(&q->queue_head))
> > +		return 0;
> > +
> >  	if (e->ops->elevator_queue_empty_fn)
> >  		return e->ops->elevator_queue_empty_fn(q);
> >  
> > -	return list_empty(&q->queue_head);
> > +	return 1;
> >  }
> 
> Agree, this order definitely makes more sense.
> 
> > @@ -2475,14 +2478,14 @@ static void __blk_put_request(request_qu
> >  
> >  void blk_put_request(struct request *req)
> >  {
> > +	unsigned long flags;
> > +	request_queue_t *q = req->q;
> > +
> >  	/*
> > -	 * if req->rl isn't set, this request didnt originate from the
> > -	 * block layer, so it's safe to just disregard it
> > +	 * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
> > +	 * following if (q) test.
> >  	 */
> > -	if (req->rl) {
> > -		unsigned long flags;
> > -		request_queue_t *q = req->q;
> > -
> > +	if (q) {
> 
> The q == NULL is because ide is using requests allocated on the stack,
> I've wanted for that to die for many years :)

 Somebody, please kill that thing.

 Thanks.  :-)

-- 
tejun
