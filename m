Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWCRHgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWCRHgY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 02:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCRHgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 02:36:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbWCRHgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 02:36:24 -0500
Date: Fri, 17 Mar 2006 23:33:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-Id: <20060317233327.787b4d07.akpm@osdl.org>
In-Reply-To: <1142666985.7881.5.camel@homer>
References: <1142658480.8262.38.camel@homer>
	<20060317211529.26969a16.akpm@osdl.org>
	<1142661030.8937.7.camel@homer>
	<20060317222203.06d7f450.akpm@osdl.org>
	<1142666985.7881.5.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> On Fri, 2006-03-17 at 22:22 -0800, Andrew Morton wrote:
> > Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > > Does this have to be a macro?
> > > > 
> > > 
> > > I suppose not, now inlined.
> > > 
> > 
> > It would be nice to uninline the function and then to modify it in a
> > followup patch.  That way, we get to see what changed, which is one of the
> > reasons to not use megamacros (sorry).
> 
> Ok, take 3 below, with updated main comment as well.
> 

Thanks for doing that.  Not really your job, but someone has to do these
things ;)

> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>

You can't trick me that easily - I kept a copy of your changlog!

>  /*
> + * We place interactive tasks back into the active array, if possible.
> + *
> + * To guarantee that this does not starve expired tasks we ignore the
> + * interactivity of a task if the first expired task had to wait more
> + * than a 'reasonable' amount of time. This deadline timeout is
> + * load-dependent, as the frequency of array switched decreases with
> + * increasing number of running tasks. We also ignore the interactivity
> + * if a better static_prio task has expired, and switch periodically
> + * regardless, to ensure that highly interactive tasks do not starve
> + * the less fortunate for unreasonably long periods.
> + */
> +static int expired_starving(runqueue_t *rq)

I'll make that inline..

> +{
> +	int limit;
> +
> +	/*
> +	 * Arrays were recently switched, all is well.
> +	 */
> +	if (!rq->expired_timestamp)
> +		return 0;
> +
> +	limit = STARVATION_LIMIT * rq->nr_running;

In the previous iteration you had, effectively,

	if (!limit)
		return 0;

in here.   But it's now gone.   Deliberate?
	
> +	/*
> +	 * It's time to switch arrays.
> +	 */
> +	if (jiffies - rq->expired_timestamp >= limit)
> +		return 1;
> +
> +	/*
> +	 * There's a better selection in the expired array.
> +	 */
> +	if (rq->curr->static_prio > rq->best_expired_prio)
> +		return 1;
> +
> +	/*
> +	 * All is well.
> +	 */
> +	return 0;
> +}

