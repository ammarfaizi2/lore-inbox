Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWDVAgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWDVAgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWDVAgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:36:54 -0400
Received: from mga06.intel.com ([134.134.136.21]:20388 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750790AbWDVAgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:36:53 -0400
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="26302461:sNHT19560275"
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="26331369:sNHT16371614"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="26302460:sNHT17116519"
Date: Fri, 21 Apr 2006 17:34:16 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH] sched: Avoid unnecessarily moving highest priority task move_tasks()
Message-ID: <20060421173416.C17932@unix-os.sc.intel.com>
References: <44485E21.6070801@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44485E21.6070801@bigpond.net.au>; from pwil3058@bigpond.net.au on Fri, Apr 21, 2006 at 02:22:57PM +1000
X-OriginalArrivalTime: 22 Apr 2006 00:36:52.0255 (UTC) FILETIME=[D95ED2F0:01C665A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 02:22:57PM +1000, Peter Williams wrote:
> @@ -2052,7 +2055,13 @@ static int move_tasks(runqueue_t *this_r
>  
>  	rem_load_move = max_load_move;
>  	pinned = 1;
> -	this_min_prio = this_rq->curr->prio;
> +	this_best_prio = rq_best_prio(this_rq);
> +	busiest_best_prio = rq_best_prio(busiest);
> +	/*
> +	 * Enable handling of the case where there is more than one task
> +	 * with the best priority.
> +	 */
> +	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;

>From this hunk, it seems like we don't want to override the skip of highest 
priority task as long as there is one such task in active list(even though
there may be few such tasks on expired list). Right? And why?

If we fix the above, we don't need busiest_best_prio_seen. Once we move one 
highest priority task, we are changing this_best_prio anyhow right?

This patch doesn't address the issue where we can skip the highest priority 
task movement if there is only one such task on the busy runqueue
(and is on the expired list..)

I can send a fix if I understand your intention for the above hunk.

thanks,
suresh
