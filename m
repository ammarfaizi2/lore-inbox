Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWC1KGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWC1KGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWC1KGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:06:43 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:19888 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750903AbWC1KGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:06:42 -0500
Message-ID: <44290A78.3050509@cosmosbay.com>
Date: Tue, 28 Mar 2006 12:05:44 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pierre PEIFFER <pierre.peiffer@bull.net>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net>
In-Reply-To: <4428E7B7.8040408@bull.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 28 Mar 2006 12:05:47 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre PEIFFER a écrit :
> Hi,
> 
> 
> I found a (optimization ?) problem in the futexes, during a futex_wake, 
>  if the waiter has a higher priority than the waker.
> 
> In fact, in this case, the waiter is immediately scheduled and tries to 
> take a lock still held by the waker. This is specially expensive on UP 
> or if both threads are on the same CPU, due to the two task-switchings. 
> This produces an extra latency during a wakeup in pthread_cond_broadcast 
> or pthread_cond_signal, for example.
> 
> See below my detailed explanation.
> 
> I found a solution given by the patch, at the end of this mail. It works 
> for me on kernel 2.6.16, but the kernel hangs if I use it with -rt patch 
> from Ingo Molnar. So, I have a doubt on the correctness of the patch.
> 
> The idea is simple: in unqueue_me, I first check
>     "if (list_empty(&q->list))"
> 
> If yes => we were woken (the list is initialized in wake_futex).
> Then, it immediately returns and let the waker drop the key_refs 
> (instead of the waiter).
> 
> 

Its true that futex code implies lot of context switches (kernel side but also 
user side).

Even if you change kernel behavior in futex_wake(), you wont change the fact 
that a typical pthread_cond_signal does :

1) lock cond var
lll_lock(cv->lock);
2) wake one waiter if necessary
FUTEX_WAKE(cv->wakeup_seq, 1);
3) unlock cond var

If a waiter process B has higher priority than the wake process A, then most 
probably, B is scheduled before A had a chance to unlock cond var (step 3))

So B will re-enter kernel (because of the contended cond var lock), and A will 
re-enter kernel too to futex_wake() process A again, but on cond var lock this 
time, not on condvar wakeup_seq futex.

Each time a thread enters futex kernel code, an expensive find_extend_vma() 
lookup is done, (expensive because of the read_lock but also the possible 
amount of vm_area_struct in mm_struct)

I wish futex code had a special implementation for PTHREAD_SCOPE_PROCESS 
futexes , where no vma lookups would be necessary at all. Most mutexes or 
condvar have a process private scope (not shared by different processes)

Eric



