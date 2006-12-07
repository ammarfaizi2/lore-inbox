Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031716AbWLGGmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031716AbWLGGmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 01:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031720AbWLGGmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 01:42:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54007 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031716AbWLGGmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 01:42:42 -0500
Date: Wed, 6 Dec 2006 22:42:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061206224207.8a8335ee.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
	<20061206075729.b2b6aa52.akpm@osdl.org>
	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 17:21:50 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 6 Dec 2006, Linus Torvalds wrote:
> > 
> > How about something like this?
> 
> I didn't get any answers on this. I'd like to get this issue resolved, but 
> since I don't even use libphy on my main machine, I need somebody else to 
> test it for me.
> 
> Just to remind you all, here's the patch again. This is identical to the 
> previous version except for the trivial cleanup to use "work_pending()" 
> instead of open-coding it in two places.
> 
> 		Linus
> 
> ...
>
> +static int __run_work(struct cpu_workqueue_struct *cwq, struct work_struct *work)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cwq->lock, flags);
> +	/*
> +	 * We need to re-validate the work info after we've gotten
> +	 * the cpu_workqueue lock. We can run the work now iff:
> +	 *
> +	 *  - the wq_data still matches the cpu_workqueue_struct
> +	 *  - AND the work is still marked pending
> +	 *  - AND the work is still on a list (which will be this
> +	 *    workqueue_struct list)
> +	 *
> +	 * All these conditions are important, because we
> +	 * need to protect against the work being run right
> +	 * now on another CPU (all but the last one might be
> +	 * true if it's currently running and has not been
> +	 * released yet, for example).
> +	 */
> +	if (get_wq_data(work) == cwq
> +	    && work_pending(work)
> +	    && !list_empty(&work->entry)) {
> +		work_func_t f = work->func;
> +		list_del_init(&work->entry);
> +		spin_unlock_irqrestore(&cwq->lock, flags);
> +
> +		if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
> +			work_release(work);
> +		f(work);
> +
> +		spin_lock_irqsave(&cwq->lock, flags);
> +		cwq->remove_sequence++;
> +		wake_up(&cwq->work_done);
> +		ret = 1;
> +	}
> +	spin_unlock_irqrestore(&cwq->lock, flags);
> +	return ret;
> +}
> +
> +/**
> + * run_scheduled_work - run scheduled work synchronously
> + * @work: work to run
> + *
> + * This checks if the work was pending, and runs it
> + * synchronously if so. It returns a boolean to indicate
> + * whether it had any scheduled work to run or not.
> + *
> + * NOTE! This _only_ works for normal work_structs. You
> + * CANNOT use this for delayed work, because the wq data
> + * for delayed work will not point properly to the per-
> + * CPU workqueue struct, but will change!
> + */
> +int fastcall run_scheduled_work(struct work_struct *work)
> +{
> +	for (;;) {
> +		struct cpu_workqueue_struct *cwq;
> +
> +		if (!work_pending(work))
> +			return 0;

But this will return to the caller if the callback is presently running on
a different CPU.  The whole point here is to be able to reliably kill off
the pending work so that the caller can free resources.

> +		if (list_empty(&work->entry))
> +			return 0;
> +		/* NOTE! This depends intimately on __queue_work! */
> +		cwq = get_wq_data(work);
> +		if (!cwq)
> +			return 0;
> +		if (__run_work(cwq, work))
> +			return 1;
> +	}
> +}
> +EXPORT_SYMBOL(run_scheduled_work);

Also, I worry that this code can run the callback on the caller's CPU. 
Users of per-cpu workqueues can legitimately assume that each callback runs
on the right CPU.  I doubt if many callers _do_ do that - there's
schedule_delayed_work_on(), but that's a bit different.

A solution to both problems is of course to block the caller if the
callback is running.  We can perhaps borrow cwq->work_done for that.


But I wouldn't want to think about an implementation as long as we have
that WORK_STRUCT_NOAUTOREL horror in there.  Can we just nuke that?  Only
three drivers need it and I bet they can be modified to use the usual
mechanisms.

