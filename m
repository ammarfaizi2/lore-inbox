Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTEQCfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTEQCfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:35:50 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23282 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261169AbTEQCfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:35:47 -0400
Date: Fri, 16 May 2003 19:50:25 -0700
From: Andrew Morton <akpm@digeo.com>
To: John Myers <jgmyers@netscape.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: aio_poll in 2.6?
Message-Id: <20030516195025.4bf5dd8d.akpm@digeo.com>
In-Reply-To: <200305170054.RAA10802@pagarcia.nscp.aoltw.net>
References: <fa.mc7vl0v.u7u2ah@ifi.uio.no>
	<200305170054.RAA10802@pagarcia.nscp.aoltw.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2003 02:48:35.0848 (UTC) FILETIME=[CFDD2880:01C31C1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Myers <jgmyers@netscape.com> wrote:
>
> It's basically waiting for someone to merge the patch.  There were
> some people making unsubstantiated claims that it didn't scale, but
> the available benchmarks showed that it scaled perfectly across the
> parameters tested.

What is the testing status of this?

Have any real-life applications been converted?

Does it require libaio changes to test?

>  
> +int async_poll(struct kiocb *iocb, int events);
> +

growl.  Please don't put function prototypes in .c files.  It defeats
typechecking.  I've moved this to aio.h.

> +int async_poll(struct kiocb *iocb, int events)
> +{
> +	unsigned int mask;
> +	struct async_poll_iocb *apiocb = kiocb_to_apiocb(iocb);
> +
> +	/* Fast path */
> +	if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll) {
> +		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
> +		mask &= events | POLLERR | POLLHUP;
> +		if (mask & events)
> +			return events;
> +	}
> +
> +	init_poll_funcptr(&apiocb->pt, async_poll_queue_proc);
> +	apiocb->armed = &apiocb;
> +	apiocb->outofmem = 0;
> +	apiocb->events = events;
> +	apiocb->ehead = NULL;
> +
> +	iocb->ki_users++;

There is no locking around this modification of ->ki_users.  Is this
correct?

> +	wmb();

Barriers always need comments explaining why they are there.

> +
> +	mask = DEFAULT_POLLMASK;
> +	if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll)
> +		mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, &apiocb->pt);
> +	mask &= events | POLLERR | POLLHUP;
> + 	if (mask && xchg(&apiocb->armed, NULL)) {
> +		async_poll_freewait(apiocb, NULL);
> +		aio_complete(iocb, mask, 0);
> +	}
> +	if (unlikely(apiocb->outofmem) && xchg(&apiocb->armed, NULL)) {
> +		async_poll_freewait(apiocb, NULL);
> +		aio_put_req(iocb);
> +		aio_put_req(iocb);

Is the double-put intentional?


