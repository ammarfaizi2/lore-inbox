Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWDYCPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWDYCPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWDYCPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:15:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751525AbWDYCPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:15:53 -0400
Date: Mon, 24 Apr 2006 19:13:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: kernel@kolivas.org, mingo@elte.hu, suresh.b.siddha@intel.com,
       efault@gmx.de, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] sched: Fix boolean expression in move_tasks()
Message-Id: <20060424191358.08c73e31.akpm@osdl.org>
In-Reply-To: <444D637F.5040702@bigpond.net.au>
References: <444D637F.5040702@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> Negate the expression and apply de Marcos rule to simplify it.  This 
>  patch is on top of 
>  sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
> 
>  Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
>  -- 
>  Peter Williams                                   pwil3058@bigpond.net.au
> 
>  "Learning, n. The kind of ignorance distinguishing the studious."
>    -- Ambrose Bierce
> 
> 
> [smpnice-fix-boolean-expression  text/plain (824 bytes)]
>  Index: MM-2.6.17-rc1-mm3/kernel/sched.c
>  ===================================================================
>  --- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-21 12:26:54.000000000 +1000
>  +++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-25 09:09:54.000000000 +1000
>  @@ -2108,7 +2108,7 @@ skip_queue:
>   	 */
>   	skip_for_load = tmp->load_weight > rem_load_move;
>   	if (skip_for_load && idx < this_best_prio)
>  -		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
>  +		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;

But Suresh's
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks-fix.patch
changed all this code:

	/*
	 * To help distribute high priority tasks accross CPUs we don't
	 * skip a task if it will be the highest priority task (i.e. smallest
	 * prio value) on its new queue regardless of its load weight
	 */
	skip_for_load = tmp->load_weight > rem_load_move;
	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
		skip_for_load = !busiest_best_prio_seen &&
				head->next == head->prev;
	if (skip_for_load ||
	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
		if (curr != head)
			goto skip_queue;
		idx++;
		goto skip_bitmap;
	}


What to do?
