Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVBNWAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVBNWAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVBNWAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:00:05 -0500
Received: from orb.pobox.com ([207.8.226.5]:60361 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261561AbVBNV7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:59:54 -0500
Date: Mon, 14 Feb 2005 15:59:48 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
Message-ID: <20050214215948.GA22304@otto>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 11:59:04AM -0700, Zwane Mwaikambo wrote:
> How about;
> 
> Index: linux-2.6.11-rc3-mm2/kernel/softirq.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.11-rc3-mm2/kernel/softirq.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 softirq.c
> --- linux-2.6.11-rc3-mm2/kernel/softirq.c	11 Feb 2005 05:14:57 -0000	1.1.1.1
> +++ linux-2.6.11-rc3-mm2/kernel/softirq.c	12 Feb 2005 18:24:54 -0000
> @@ -355,8 +355,12 @@ static int ksoftirqd(void * __bind_cpu)
>  	set_current_state(TASK_INTERRUPTIBLE);
>  
>  	while (!kthread_should_stop()) {
> -		if (!local_softirq_pending())
> +		preempt_disable();
> +		if (!local_softirq_pending()) {
> +			preempt_enable_no_resched();
>  			schedule();
> +			preempt_disable();
> +		}
>  
>  		__set_current_state(TASK_RUNNING);
>  
> @@ -364,14 +368,14 @@ static int ksoftirqd(void * __bind_cpu)
>  			/* Preempt disable stops cpu going offline.
>  			   If already offline, we'll be on wrong CPU:
>  			   don't process */
> -			preempt_disable();
>  			if (cpu_is_offline((long)__bind_cpu))
>  				goto wait_to_die;
>  			do_softirq();
> -			preempt_enable();
> +			preempt_enable_no_resched();
>  			cond_resched();
> +			preempt_disable();
>  		}
> -
> +		preempt_enable();
>  		set_current_state(TASK_INTERRUPTIBLE);
>  	}
>  	__set_current_state(TASK_RUNNING);
> 

Works ok here.

It looks as if we need to explicitly bind worker threads to a newly
onlined cpu.  This gets rid of the smp_processor_id warnings from
cache_reap.  Adding a little more instrumentation to the debug
smp_processor_id showed that new worker threads were actually running
on the wrong cpu...

Does this look ok?

Index: linux-2.6.11-rc4-bk2/kernel/workqueue.c
===================================================================
--- linux-2.6.11-rc4-bk2.orig/kernel/workqueue.c	2005-02-14 11:13:08.000000000 -0600
+++ linux-2.6.11-rc4-bk2/kernel/workqueue.c	2005-02-14 15:18:35.000000000 -0600
@@ -485,8 +485,10 @@
 
 	case CPU_ONLINE:
 		/* Kick off worker threads. */
-		list_for_each_entry(wq, &workqueues, list)
+		list_for_each_entry(wq, &workqueues, list) {
+			kthread_bind(wq->cpu_wq[hotcpu].thread, hotcpu);
 			wake_up_process(wq->cpu_wq[hotcpu].thread);
+		}
 		break;
 
 	case CPU_UP_CANCELED:
