Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423280AbWF1L0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423280AbWF1L0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423279AbWF1L0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:26:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8030 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932775AbWF1L0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:26:10 -0400
Date: Wed, 28 Jun 2006 13:27:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lubos Lunak <l.lunak@suse.cz>
Subject: Re: [PATCH 7/7] iosched: introduce deadline_kick_page()
Message-ID: <20060628112731.GP32115@suse.de>
References: <20060624082006.574472632@localhost.localdomain> <20060624082312.833976992@localhost.localdomain> <20060624110104.GP4083@suse.de> <20060625063232.GA5867@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625063232.GA5867@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25 2006, Fengguang Wu wrote:
> On Sat, Jun 24, 2006 at 01:01:04PM +0200, Jens Axboe wrote:
> > >  /*
> > > + * We have a pending read on @page,
> > > + * find the corresponding request of type READA,
> > > + * promote it to READ, and reschedule it.
> > > + */
> > > +static int
> > > +deadline_kick_page(struct request_queue *q, struct page *page)
> > > +{
> > > +	struct deadline_data *dd = q->elevator->elevator_data;
> > > +	struct deadline_rq *drq;
> > > +	struct request *rq;
> > > +	struct list_head *pos;
> > > +	struct bio_vec *bvec;
> > > +	struct bio *bio;
> > > +	int i;
> > > +
> > > +	list_for_each(pos, &dd->fifo_list[READ]) {
> > > +		drq = list_entry_fifo(pos);
> > > +		rq = drq->request;
> > > +		if (rq->flags & (1 << BIO_RW_AHEAD)) {
> > > +			rq_for_each_bio(bio, rq) {
> > > +				bio_for_each_segment(bvec, bio, i) {
> > > +					if (page == bvec->bv_page)
> > > +						goto found;
> > > +				}
> > > +			}
> > > +		}
> > > +	}
> > 
> > Uh that's horrible!
> > 
> > Before we go into further details, I'd like to see some numbers on where
> > this makes a difference.
> 
> Sorry, it is.  It brings non-trivial overhead.

Sorry for the late reply, apparently spamassassin thought this was
spam...

> This is the oprofile outputs:
> 
> reading small files:
>  1245 c01edae4 9         0.1404  deadline_dispatch_requests
>  1253 c01ed4d6 9         0.1404  deadline_queue_empty
>  1338 c01ed3d5 8         0.1248  deadline_kick_page
>  1619 c01ed350 6         0.0936  deadline_add_drq_fifo
>  1707 c01eda62 5         0.0780  deadline_add_request
>  1712 c01ed2e5 5         0.0780  deadline_set_request
>  1867 c01ed871 4         0.0624  deadline_remove_request
>  2242 c01ed9b9 2         0.0312  deadline_add_drq_rb
>  2244 c01edc1e 2         0.0312  deadline_merge
>  2246 c01ed923 2         0.0312  deadline_move_request
>  2249 c01ed232 2         0.0312  deadline_put_request
> 
> reading a big file:
>  1330 c01ed3d5 89        0.2926  deadline_kick_page
>  2528 c01edae4 16        0.0526  deadline_dispatch_requests
>  3036 c01ed9b9 8         0.0263  deadline_add_drq_rb
>  3163 c01ed4d6 7         0.0230  deadline_queue_empty
>  3394 c01edc1e 5         0.0164  deadline_merge
>  3399 c01ed923 5         0.0164  deadline_move_request
>  3403 c01ed2e5 5         0.0164  deadline_set_request
>  3707 c01eda62 3         0.0099  deadline_add_request
>  3711 c01ed871 3         0.0099  deadline_remove_request
>  3917 c01ede3c 2         0.0066  deadline_merged_request
>  3920 c01ed232 2         0.0066  deadline_put_request
>  4214 c01ed350 1         0.0033  deadline_add_drq_fifo
> 
> The overhead of deadline_kick_page() becomes large when the request is
> large (256 pages). But I guess there's way to optimize it:
> - most requests will be consisted of a set of continuous pages, i.e. a
>   range comparison will be sufficient.
> - for a system with lots of queued requests(>100), maybe the gain can
>   well pay for the overheads?

Sorry, there's just no way that something like that is acceptable for
inclusion. I don't care much about the overhead numbers (I can see from
the code that it sucks :-), I wanted to see some numbers on what
scenarios this helps performance and by how much.

-- 
Jens Axboe

