Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbVJ1PDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbVJ1PDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbVJ1PDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:03:49 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:1382 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750744AbVJ1PDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:03:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=be6690JMWD5w+pBUUJaVLItCtvZ2xyA2Dp0tubbGgPepc9FZ1PGdeaKh44nOuEf3/KtNhYG6O6O3l5O4qQrl+OzWtx3+a5fl1Z1qb0Pgvg0PUS3/LKZNs6R/zoULFSbZLFV7frm18It4OHP/r+MfDHAqKxB+DdqpFDRmzKm59Ig=  ;
Message-ID: <43623DEA.3010506@yahoo.com.au>
Date: Sat, 29 Oct 2005 01:04:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better wake-balancing: respin
References: <200510270124.j9R1OPg27107@unix-os.sc.intel.com> <4361EC95.5040800@yahoo.com.au> <20051028100806.GA19507@elte.hu> <43620583.9080500@yahoo.com.au> <20051028143750.GA1806@elte.hu>
In-Reply-To: <20051028143750.GA1806@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------020104000606000109010900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020104000606000109010900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Ingo, I wasn't aware that tasks are bouncing around wildly; does your 
>>patch improve things? Then by definition it must penalise workloads 
>>where the pairings are more predictable?
> 
> 
> for TPC, most of the non-to-idle migrations are 'wrong'. So basically

Sure, OK.

> any change that gets rid of extra migrations is a win. This does not 
> mean that it is all bouncing madly.
> 

Yes... semantics aside it is obviously something we want to eliminate
if possible.

> 
>>I would prefer to try fixing wake balancing before giving up and 
>>turning it off for busy CPUs.
> 
> 
> agreed, and that was my suggestion: improve the heuristics to not hurt 
> workloads where there is no natural pairing.
> 
> one possible way would be to do a task_hot() check in the passive 
> balancing code, and only migrate the task when it's been inactive for a 
> long time: that should be the case for most TPC wakeups. (This assumes 
> an accurate cache-hot estimator, for which another patch exists.)
> 

That sounds like a reasonable avenue to investigate. There was
something similar there before, but I found that there was a sharp
point where runqueue lengths got just the right length for performance
characteristics of some things to change.

This could have been made worse by inadequate cache-hot estimate though.

One thing I will look into is to check whether we can use previous
wakeup patterns to check whether the pattern looks random, or affine to
some group of CPUs. This could potentially allow us to have stronger
affinity than we currently do for the "good" workloads, while eliminating
task movement completely for bad cases.

Something along the lines of the attached patch may be 'good enough',
though I'd like to try a few other things as well.

> 
>>Without any form of wake balancing, then a multiprocessor system will 
>>tend to have a completely random distribution of tasks over CPUs over 
>>time. I prefer to add a driver so it is not completely random for 
>>amenable workloads.
> 
> 
> but my patch does not do 'no form of wake balancing'. It will do 
> non-load-related wake balancing if the target CPU is idle. Arguably, 
> that can easily be 'never' under common workloads.
> 

No that's true - I didn't mean to imply that your patch would
completely eliminate this input.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------020104000606000109010900
Content-Type: text/plain;
 name="sched-less-affine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-less-affine.patch"

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-10-29 00:52:31.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2005-10-29 00:58:51.000000000 +1000
@@ -648,9 +648,12 @@ struct task_struct {
 
 	int lock_depth;		/* BKL lock depth */
 
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#if defined(CONFIG_SMP)
+	int last_waker_cpu;	/* CPU that last woke this task up */
+#if defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	int oncpu;
 #endif
+#endif
 	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-10-29 00:52:34.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-10-29 01:00:53.000000000 +1000
@@ -1183,6 +1183,10 @@ static int try_to_wake_up(task_t *p, uns
 		}
 	}
 
+	if (p->last_waker_cpu != this_cpu)
+		goto out_set_cpu;
+
+
 	if (unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
@@ -1253,6 +1257,8 @@ out_set_cpu:
 		cpu = task_cpu(p);
 	}
 
+	p->last_waker_cpu = this_cpu;
+	
 out_activate:
 #endif /* CONFIG_SMP */
 	if (old_state == TASK_UNINTERRUPTIBLE) {
@@ -1334,9 +1340,12 @@ void fastcall sched_fork(task_t *p, int 
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#if defined(CONFIG_SMP)
+	p->last_waker_cpu = cpu;
+#if defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	p->oncpu = 0;
 #endif
+#endif
 #ifdef CONFIG_PREEMPT
 	/* Want to start with kernel preemption disabled. */
 	p->thread_info->preempt_count = 1;

--------------020104000606000109010900--
Send instant messages to your online friends http://au.messenger.yahoo.com 
