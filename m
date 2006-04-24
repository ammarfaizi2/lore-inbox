Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWDXXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWDXXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDXXu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:50:59 -0400
Received: from mga07.intel.com ([143.182.124.22]:18950 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932128AbWDXXu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:50:58 -0400
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27241410:sNHT19854534"
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27241404:sNHT25398212"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="28030928:sNHT49577402"
Date: Mon, 24 Apr 2006 16:48:00 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: Avoid unnecessarily moving highest priority task move_tasks()
Message-ID: <20060424164800.B16716@unix-os.sc.intel.com>
References: <44485E21.6070801@bigpond.net.au> <20060421173416.C17932@unix-os.sc.intel.com> <44498771.1030409@bigpond.net.au> <20060424120014.A16716@unix-os.sc.intel.com> <444D5989.3060002@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <444D5989.3060002@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Apr 25, 2006 at 09:04:41AM +1000
X-OriginalArrivalTime: 24 Apr 2006 23:50:56.0931 (UTC) FILETIME=[EE4EFF30:01C667F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 09:04:41AM +1000, Peter Williams wrote:
> Looks like there's a NOT missing doesn't it.  So there is an error but I 
> don't think that your patch is the right way to fix it.  We just need to 
> negate the above assignment.  E.g.
> 
> skip_for_load = !(busiest_best_prio_seen || idx != busiest_best_prio);
> 
> or
> 
> skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
> 
> whichever is more efficient.

That just will not be enough. busiest_best_prio needs to be set to '1'
whenever we skip the first best priority task(not whenever we move it)

And we also need to initialize busiest_best_prio_seen inside this check.
(like in my patch)
	if (busiest->expired->nr_active) {

And we need to reset busiest_best_prio_seen to '0' whenever we finished
the checking of expired list (and move onto active list) and there are
no best prio tasks on expired list..

> > @@ -2072,6 +2067,13 @@ static int move_tasks(runqueue_t *this_r
> >  	if (busiest->expired->nr_active) {
> >  		array = busiest->expired;
> >  		dst_array = this_rq->expired;
> > +		/*
> > +		 * We already have one or more busiest best prio tasks on
> > +		 * active list.
> 
> This is a pretty bold assertion.  How do we know that this is true.

That comment refers to when 'busiest_best_prio_seen' is initialized to '1'.
Comment needs to be fixed.

thanks,
suresh

> 
> > So if we encounter any busiest best prio task
> > +		 * on expired list, consider it for the move, if it becomes
> > +		 * the best prio on new queue.
> > +		 */
> > +		busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
> >  	} else {
> >  		array = busiest->active;
> >  		dst_array = this_rq->active;
> > @@ -2089,6 +2091,7 @@ skip_bitmap:
> >  		if (array == busiest->expired && busiest->active->nr_active) {
> >  			array = busiest->active;
> >  			dst_array = this_rq->active;
> > +			busiest_best_prio_seen = 0;
> >  			goto new_array;
> >  		}
> >  		goto out;
> > @@ -2107,8 +2110,9 @@ skip_queue:
> >  	 * prio value) on its new queue regardless of its load weight
> >  	 */
> >  	skip_for_load = tmp->load_weight > rem_load_move;
> > -	if (skip_for_load && idx < this_best_prio)
> > -		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
> > +	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
> > +		skip_for_load = !busiest_best_prio_seen &&
> > +				head->next == head->prev;
> >  	if (skip_for_load ||
> >  	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
> >  		if (curr != head)
> > @@ -2133,8 +2137,6 @@ skip_queue:
> >  	if (pulled < max_nr_move && rem_load_move > 0) {
> >  		if (idx < this_best_prio)
> >  			this_best_prio = idx;
> > -		if (idx == busiest_best_prio)
> > -			busiest_best_prio_seen = 1;
> >  		if (curr != head)
> >  			goto skip_queue;
> >  		idx++;
> 
> 
> Peter
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce
