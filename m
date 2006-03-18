Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751978AbWCRGZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWCRGZA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 01:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWCRGZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 01:25:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751978AbWCRGY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 01:24:59 -0500
Date: Fri, 17 Mar 2006 22:22:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-Id: <20060317222203.06d7f450.akpm@osdl.org>
In-Reply-To: <1142661030.8937.7.camel@homer>
References: <1142658480.8262.38.camel@homer>
	<20060317211529.26969a16.akpm@osdl.org>
	<1142661030.8937.7.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> > Does this have to be a macro?
> > 
> 
> I suppose not, now inlined.
> 

It would be nice to uninline the function and then to modify it in a
followup patch.  That way, we get to see what changed, which is one of the
reasons to not use megamacros (sorry).

> +static inline int expired_starving(runqueue_t *rq)
> +{
> +	int limit = STARVATION_LIMIT * rq->nr_running, starving;
> +
> +	if (!limit || !rq->expired_timestamp)
> +		return 0;
> +	starving = jiffies - rq->expired_timestamp >= limit;
> +	starving += rq->curr->static_prio > rq->best_expired_prio;
> +
> +	return starving;
> +}

ick.  Is that really what that macros does??

The function returns a boolean, so we should short-circuit the evaluation
where possible.


static inline int expired_starving(runqueue_t *rq)
{
	int limit;

	/* Comment goes here */
	if (!rq->expired_timestamp)
		return 0;

	limit = STARVATION_LIMIT * rq->nr_running;

	/* Here too */
	if (!limit)
		return 0;

	/* And here */
	if (jiffies - rq->expired_timestamp >= limit)
		return 1;

	/* And here */
	if (rq->curr->static_prio > rq->best_expired_prio)
		return 1;

	/* And here */
	return 0;
}

This way

a) We get somewhere to put comments describing each step of the logic.

b) We get to select the order of the comparisons in decreasing
   (probability*expensiveness) order.

   See how you're performing an unneeded multiplication if
   !rq->expired_timestamp?

c) See how the first test of `limit' comes after that multiplication? 
   STARVATION_LIMIT is a constant (isn't it?) If so, we need only test
   rq->nr_running.  

d) The next guy who comes along has to update the comments ;)


