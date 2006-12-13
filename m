Return-Path: <linux-kernel-owner+w=401wt.eu-S1751797AbWLMXjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWLMXjz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWLMXjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:39:55 -0500
Received: from mga07.intel.com ([143.182.124.22]:30052 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbWLMXjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:39:54 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:39:54 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="157933369:sNHT45117849"
Date: Wed, 13 Dec 2006 15:03:14 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, clameter@sgi.com, tglx@linutronix.de,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061213150314.B12795@unix-os.sc.intel.com>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061213231316.GA13849@elte.hu>; from mingo@elte.hu on Thu, Dec 14, 2006 at 12:13:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:13:16AM +0100, Ingo Molnar wrote:
> there's another bug as well: in schedule() resched_cpu() is called with 
> the current runqueue held in two places, which is deadlock potential. 

resched_cpu() was getting called after prepare_task_switch() which
releases the current runqueue lock. Isn't it?

> The easiest fix for this is to use trylock - find the patch for that. 
> This is a hint only anyway - and if a CPU is idle its runqueue will be 

Though I don't see a potential deadlock, I like this optimization.

thanks,
suresh

> lockable. (fixing it via double-locking is easy in the first call site, 
> but the second one looks harder)
> 
> 	Ingo
> 
> Index: linux/kernel/sched.c
> ===================================================================
> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -1167,12 +1167,14 @@ static void resched_task(struct task_str
>  	if (!tsk_is_polling(p))
>  		smp_send_reschedule(cpu);
>  }
> +
>  static void resched_cpu(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> -	unsigned int flags;
> +	unsigned long flags;
>  
> -	spin_lock_irqsave(&rq->lock, flags);
> +	if (!spin_trylock_irqsave(&rq->lock, flags))
> +		return;
>  	resched_task(cpu_curr(cpu));
>  	spin_unlock_irqrestore(&rq->lock, flags);
>  }
