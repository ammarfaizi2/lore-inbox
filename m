Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJUISe>; Mon, 21 Oct 2002 04:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJUISe>; Mon, 21 Oct 2002 04:18:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20699 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261246AbSJUISc>;
	Mon, 21 Oct 2002 04:18:32 -0400
Date: Mon, 21 Oct 2002 10:24:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Priorities for I/O
Message-ID: <20021021082429.GE11594@suse.de>
References: <20021021072629.GD6630@nbkurt.casa-etp.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021072629.GD6630@nbkurt.casa-etp.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21 2002, Kurt Garloff wrote:
> Hi Jens,
> 
> one of the shortcomings of Linux process priority system is that it only
> affects CPU resources (and even those are not affected strongly enough for
> some applications). 
> As soon as processes waits for I/O, they are all equal.

I agree that it's a feature that would be nice to have, but I also don't
think it's that important.

> I wonder how difficult it was to just add priorities to your I/O scheduler.
> Basically, I think everything is there: You sort requests already and we
> have deadlines. For sorting scores are used.
> So the idea is: Why not just give I/O submitted on behalf of -19 processes
> (and RT) some higher score and a shorter deadline than +19 ones?
> Probably, it would only affect reads, as there we have the processes wait
> on them; writes are often triggered asynchronously anyway.

You are missing one little detail -- yes there is an expire list for
reads, and it is indeed sorted by deadline. Right now this operates in
O(1) time for insert and retrieval, since it's a plain FIFO (well
sometimes we move entries from the middle of the list as well).

So if you want to starting basing deadlines on process priority, you
would have to sort insert instead.

It's not a big issue, but cycles spent in the io scheduler was very much
considered when I wrote it (it's faster than the old one). And we could
always just replace the simple doubly linked list with something else.
Back in the early days of bio, I actually had the sorting changed to a
binomial heap. Given that both the read+write sort lists and expire
lists are just priority queues now, it would work easily. Anyways,
getting off track...

> This should have the effects that we want: When there's no fight for I/O
> bandwidth, everybody just gets maximum performance as the I/O scheduler's
> queue will be short. As soon as processes fight for reads, unniced processes
> have a higher chance of getting served first.
> 
> Just think of nightly updatedb on a webserver for a real-world example why
> this may matter.
> 
> Looks like something not too difficult to do, but my current knowledge on
> 2.5 code is somewhat sparse :-(

If you want to give it a try, it's pretty easy to add. dd->read_fifo is
our fifo expire list right now, you'd want to change that to
dd->read_prio or something. And in deadline_add_request(), the very last
thing we do is add the read to the tail of the expire list:

	drq->expires = jiffies + dd->read_expire;
	list_add_tail(&drq->fifo, &dd->read_fifo);

you'd just want something ala

	struct list_head *foo = &dd->read_prio;
	struct deadline_rq *__drq;

	drq->expires = jiffies + deadline_process_expire();
	while ((foo = foo->prev) != &dd->read_prio) {
		__drq = list_entry_fifo(foo);
		if (__drq->expires > drq->expires)
			break;
	}

	list_add(&drq->fifo, foo);

you get the picture. And that should be it, really. Everything else
should just work as-is, iirc.

-- 
Jens Axboe

