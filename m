Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUGIXy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUGIXy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUGIXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:54:26 -0400
Received: from gizmo12ps.bigpond.com ([144.140.71.43]:53915 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S265222AbUGIXx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:53:26 -0400
Message-ID: <40EF2FF2.6000001@bigpond.net.au>
Date: Sat, 10 Jul 2004 09:53:22 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
References: <40EE6CC2.8070001@kolivas.org>
In-Reply-To: <40EE6CC2.8070001@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> A quick question about the usefulness of making rt_task() checks 
> unlikely in sched-unlikely-rt_task.patch which is in -mm
> 
> quote:
> 
> diff -puN include/linux/sched.h~sched-unlikely-rt_task 
> include/linux/sched.h
> --- 25/include/linux/sched.h~sched-unlikely-rt_task    Fri Jul  2 
> 16:33:01 2004
> +++ 25-akpm/include/linux/sched.h    Fri Jul  2 16:33:01 2004
> @@ -300,7 +300,7 @@ struct signal_struct {
> 
>  #define MAX_PRIO        (MAX_RT_PRIO + 40)
> 
> -#define rt_task(p)        ((p)->prio < MAX_RT_PRIO)
> +#define rt_task(p)        (unlikely((p)->prio < MAX_RT_PRIO))
> 
>  /*
>   * Some day this will be a full-fledged user tracking system..
> 
> ---
> While rt tasks are normally unlikely, what happens in the case when you 
> are scheduling one or many running rt_tasks and the majority of your 
> scheduling is rt? Would it be such a good idea in this setting that it 
> is always hitting the slow path of branching all the time?

Even when this isn't the case you don't want to make all rt_task() 
checks "unlikely".  In particular, during "wake up" using "unlikely" 
around rt_task() will increase the time that it takes for SCHED_FIFO 
tasks to get onto the CPU when they wake which will be bad for latency 
(which is generally important to these tasks as evidenced by several 
threads on the topic).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

