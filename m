Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTFITI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTFITI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:08:58 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:58376 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264173AbTFITI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:08:56 -0400
Subject: Re: scheduler interactivity - does this patch help?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <36450000.1055137396@[10.10.2.4]>
References: <36450000.1055137396@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1055186553.707.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 09 Jun 2003 21:22:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 07:43, Martin J. Bligh wrote:
> I've had this patch (I think from Ingo) kicking around in -mjb
> for a while. I'm going to drop it unless someone thinks it's useful
> for some testcase you have ... anyone interested?
> 
> Thanks,
> 
> M.
> 
> diff -urpN -X /home/fletch/.diff.exclude 400-reiserfs_dio/kernel/sched.c 420-sched_interactive/kernel/sched.c
> --- 400-reiserfs_dio/kernel/sched.c	Fri May 30 19:26:34 2003
> +++ 420-sched_interactive/kernel/sched.c	Fri May 30 19:28:06 2003
> @@ -89,6 +89,8 @@ int node_threshold = 125;
>  #define STARVATION_LIMIT	(starvation_limit)
>  #define NODE_THRESHOLD		(node_threshold)
>  
> +#define TIMESLICE_GRANULARITY (HZ/20 ?: 1)
> +
>  /*
>   * If a task is 'interactive' then we reinsert it in the active
>   * array after it has expired its current timeslice. (it will not
> @@ -1365,6 +1367,27 @@ void scheduler_tick(int user_ticks, int 
>  			enqueue_task(p, rq->expired);
>  		} else
>  			enqueue_task(p, rq->active);
> +	} else {
> +		/*
> +		 * Prevent a too long timeslice allowing a task to monopolize
> +		 * the CPU. We do this by splitting up the timeslice into
> +		 * smaller pieces.
> +		 *
> +		 * Note: this does not mean the task's timeslices expire or
> +		 * get lost in any way, they just might be preempted by
> +		 * another task of equal priority. (one with higher
> +		 * priority would have preempted this task already.) We
> +		 * requeue this task to the end of the list on this priority
> +		 * level, which is in essence a round-robin of tasks with
> +		 * equal priority.
> +		 */
> +		if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
> +			       		(p->array == rq->active)) {
> +			dequeue_task(p, rq->active);
> +			set_tsk_need_resched(p);
> +			p->prio = effective_prio(p);
> +			enqueue_task(p, rq->active);
> +		}
>  	}
>  out_unlock:
>  	spin_unlock(&rq->lock);
> 

I'm currently testing it on a modified 2.5.70-mm6 kernel (with HZ set to
1000) and seems to help a little with XMMS's chunky audio playback when
X is reniced to -20.

