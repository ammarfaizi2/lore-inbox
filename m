Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTJ1BiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTJ1BiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:38:19 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:1990 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263849AbTJ1BiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:38:07 -0500
Date: Tue, 28 Oct 2003 14:37:52 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
In-reply-to: <3F9DAF2C.8010308@cyberone.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: cliff white <cliffw@osdl.org>, Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1067305071.1693.14.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200310261201.14719.mhf@linuxmail.org>
 <20031027145531.2eb01017.cliffw@osdl.org> <3F9DAF2C.8010308@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try it with my software suspend patch. Under 2.4, I get around 45
pages per jiffy written when suspending. Under 2.6, I'm currently
getting 2-4, so any improvement should be obvious!

Regards,

Nigel

On Tue, 2003-10-28 at 12:50, Nick Piggin wrote:
> cliff white wrote:
> 
> >On Tue, 28 Oct 2003 05:52:45 +0800
> >Michael Frank <mhf@linuxmail.org> wrote:
> >
> >
> >>To my surprise 2.6 - which used to do better then 2.4 - does no longer 
> >>handle these test that well.
> >>
> >>Generally, IDE IO throughput is _very_ uneven and IO _stops_ at times with the
> >>system cpu load very high (and the disk LED off).
> >>
> >>IMHO the CPU scheduling is OK but the IO scheduling acts up here.
> >>
> >>The test system is a 2.4GHz P4 with 512M RAM and a 55MB/s udma IDE harddisk.
> >>
> >>The tests load the system to loadavg > 30. IO should be about 20MB/s on avg.
> >>
> >>Enclosed are vmstat -1 logs for 2.6-test9-Vanilla, followed by 2.6-test8-Vanilla 
> >>(-mm1 behaves similar), 2.4.22-Vanilla and 2.4.21+swsusp all compiled wo preempt.
> >>
> >>IO on 2.6 stops now for seconds at a time. -test8 is worse than -test9
> >>
> >
> >We see the same delta at OSDL. Try repeating your tests with 'elevator=deadline' 
> >to confirm.
> >For example, on the 8-cpu platform:
> >STP id Kernel Name         MaxJPM      Change  Options
> >281669 linux-2.6.0-test8   7014.42      0.0    
> >281671 linux-2.6.0-test8   8294.94     +18.26%  elevator=deadline
> >
> >The -mm kernels don't show this big delta. We also do not see this delta on
> >smaller machines
> >
> 
> I'm working with Randy to fix this. Attached is what I have so far. See how
> you go with it.
> 
> 
> ______________________________________________________________________
> 
>  linux-2.6-npiggin/drivers/block/as-iosched.c |   30 ++++++---------------------
>  1 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff -puN drivers/block/as-iosched.c~as-fix drivers/block/as-iosched.c
> --- linux-2.6/drivers/block/as-iosched.c~as-fix	2003-10-27 14:53:47.000000000 +1100
> +++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-10-27 14:54:04.000000000 +1100
> @@ -99,7 +99,6 @@ struct as_data {
>  	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
>  	struct list_head *dispatch;	/* driver dispatch queue */
>  	struct list_head *hash;		/* request hash */
> -	unsigned long new_success; /* anticipation success on new proc */
>  	unsigned long current_batch_expires;
>  	unsigned long last_check_fifo[2];
>  	int changed_batch;		/* 1: waiting for old batch to end */
> @@ -585,18 +584,11 @@ static void as_antic_stop(struct as_data
>  	int status = ad->antic_status;
>  
>  	if (status == ANTIC_WAIT_REQ || status == ANTIC_WAIT_NEXT) {
> -		struct as_io_context *aic;
> -
>  		if (status == ANTIC_WAIT_NEXT)
>  			del_timer(&ad->antic_timer);
>  		ad->antic_status = ANTIC_FINISHED;
>  		/* see as_work_handler */
>  		kblockd_schedule_work(&ad->antic_work);
> -
> -		aic = ad->io_context->aic;
> -		if (aic->seek_samples == 0)
> -			/* new process */
> -			ad->new_success = (ad->new_success * 3) / 4 + 256;
>  	}
>  }
>  
> @@ -612,14 +604,8 @@ static void as_antic_timeout(unsigned lo
>  	spin_lock_irqsave(q->queue_lock, flags);
>  	if (ad->antic_status == ANTIC_WAIT_REQ
>  			|| ad->antic_status == ANTIC_WAIT_NEXT) {
> -		struct as_io_context *aic;
>  		ad->antic_status = ANTIC_FINISHED;
>  		kblockd_schedule_work(&ad->antic_work);
> -
> -		aic = ad->io_context->aic;
> -		if (aic->seek_samples == 0)
> -			/* new process */
> -			ad->new_success = (ad->new_success * 3) / 4;
>  	}
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
> @@ -708,11 +694,10 @@ static int as_can_break_anticipation(str
>  		return 1;
>  	}
>  
> -	if (ad->new_success < 256 &&
> -			(aic->seek_samples == 0 || aic->ttime_samples == 0)) {
> +	if (aic->seek_samples == 0 || aic->ttime_samples == 0) {
>  		/*
> -		 * Process has just started IO and we have a bad history of
> -		 * success anticipating on new processes!
> +		 * Process has just started IO. Don't anticipate.
> +		 * TODO! Must fix this up.
>  		 */
>  		return 1;
>  	}
> @@ -1292,7 +1277,7 @@ fifo_expired:
>  
>  		ad->changed_batch = 0;
>  
> -		arq->request->flags |= REQ_SOFTBARRIER;
> +//		arq->request->flags |= REQ_SOFTBARRIER;
>  	}
>  
>  	/*
> @@ -1391,6 +1376,7 @@ static void as_add_request(struct as_dat
>  
>  	} else {
>  		as_add_aliased_request(ad, arq, alias);
> +
>  		/*
>  		 * have we been anticipating this request?
>  		 * or does it come from the same process as the one we are
> @@ -1427,8 +1413,6 @@ static void as_requeue_request(request_q
>  
>  	/* Stop anticipating - let this request get through */
>  	as_antic_stop(ad);
> -
> -	return;
>  }
>  
>  static void
> @@ -1437,10 +1421,12 @@ as_insert_request(request_queue_t *q, st
>  	struct as_data *ad = q->elevator.elevator_data;
>  	struct as_rq *arq = RQ_DATA(rq);
>  
> +#if 0
>  	/* barriers must flush the reorder queue */
>  	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
>  			&& where == ELEVATOR_INSERT_SORT))
>  		where = ELEVATOR_INSERT_BACK;
> +#endif
>  
>  	switch (where) {
>  		case ELEVATOR_INSERT_BACK:
> @@ -1823,8 +1809,6 @@ static int as_init(request_queue_t *q, e
>  	if (ad->write_batch_count < 2)
>  		ad->write_batch_count = 2;
>  
> -	ad->new_success = 512;
> -
>  	return 0;
>  }
>  
> 
> _
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

