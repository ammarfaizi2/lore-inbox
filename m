Return-Path: <linux-kernel-owner+w=401wt.eu-S1030270AbWLTSrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWLTSrb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWLTSrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:47:31 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27471 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030270AbWLTSra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:47:30 -0500
Date: Wed, 20 Dec 2006 19:49:17 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be  called from interrupt context
Message-ID: <20061220184917.GJ10535@kernel.dk>
References: <20061219.171119.18572687.k-ueda@ct.jp.nec.com> <20061220134848.GF10535@kernel.dk> <20061220.125002.71083198.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220.125002.71083198.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20 2006, Kiyoshi Ueda wrote:
> Hi Jens,
> 
> Thank you for the comment.
> 
> On Wed, 20 Dec 2006 14:48:49 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >  static struct request *get_request(request_queue_t *q, int rw, struct bio *bio,
> > > -				   gfp_t gfp_mask)
> > > +				   gfp_t gfp_mask, unsigned long *flags)
> > >  {
> > >  	struct request *rq = NULL;
> > >  	struct request_list *rl = &q->rq;
> > > @@ -2119,7 +2120,10 @@ static struct request *get_request(reque
> > >  	if (priv)
> > >  		rl->elvpriv++;
> > >  
> > > -	spin_unlock_irq(q->queue_lock);
> > > +	if (flags)
> > > +		spin_unlock_irqrestore(q->queue_lock, *flags);
> > > +	else
> > > +		spin_unlock_irq(q->queue_lock);
> > 
> > Big NACK on this - it's not only really ugly, it's also buggy to pass
> > interrupt flags as function arguments. As you also mention in the 0/1
> > mail, this also breaks CFQ.
> > 
> > Why do you need in-interrupt request allocation?
>  
> Because I'd like to use blk_get_request() in q->request_fn()
> which can be called from interrupt context like below:
>   scsi_io_completion -> scsi_end_request -> scsi_next_command
>   -> scsi_run_queue -> blk_run_queue -> q->request_fn
> 
> Generally, device-mapper (dm) clones an original I/O and dispatches
> the clones to underlying destination devices.
> In the request-based dm patch, the clone creation and the dispatch
> are done in q->request_fn().  To create the clone, blk_get_request()
> is used to get a request from underlying destination device's queue.
> By doing that in q->request_fn(), dm can deal with struct request
> after bios are merged by __make_request().
> 
> Do you think creating another function like blk_get_request_nowait()
> is acceptable?
> Or request should not be allocated in q->request_fn() anyway?

You should not be allocating requests from that path, for a number of
reasons. The design isn't very nice either.

The easy way out would be to punt to a workqueue to handle the requests.

An alternative way would be to set aside some requests that you can get
at without allocation (maintain a little freelist of manually allocated
requests), and retrieve a free one from there when inside request_fn. If
you run out, just bail out of request_fn and make sure to reinvoke it
when some of your previously issued requests complete and are added back
to that freelist.

-- 
Jens Axboe

