Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbTCGQNi>; Fri, 7 Mar 2003 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbTCGQNi>; Fri, 7 Mar 2003 11:13:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60305 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261638AbTCGQNg>; Fri, 7 Mar 2003 11:13:36 -0500
Date: Fri, 07 Mar 2003 08:24:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Rick Lindsley <ricklind@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NUMA scheduler broken 
Message-ID: <330040000.1047054242@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303071339090.10744-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303071339090.10744-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Looks like __activate_task() should call nr_running_inc(rq) rather than
>> rq->nr_running++, and the same in wake_up_forked_process().  My guess is
>> that the bogus node_nr_running value is causing some really poor
>> scheduling decisions to be made on NUMA.  See if that changes your
>> result.

Yay! that fixes it. Nice catch Rick.

> indeed. The attached patch (against BK-curr) fixes this.

Thanks Ingo ... Linus, could you add that one?

Thanks,

M.
 
> 	Ingo
> 
> --- kernel/sched.c.orig	2003-03-07 13:40:53.000000000 +0100
> +++ kernel/sched.c	2003-03-07 13:41:19.000000000 +0100
> @@ -325,7 +325,7 @@
>  static inline void __activate_task(task_t *p, runqueue_t *rq)
>  {
>  	enqueue_task(p, rq->active);
> -	rq->nr_running++;
> +	nr_running_inc(rq);
>  }
>  
>  static inline void activate_task(task_t *p, runqueue_t *rq)
> @@ -545,7 +545,7 @@
>  		list_add_tail(&p->run_list, &current->run_list);
>  		p->array = current->array;
>  		p->array->nr_active++;
> -		rq->nr_running++;
> +		nr_running_inc(rq);
>  	}
>  	task_rq_unlock(rq, &flags);
>  }
> 
> 


