Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUCSCRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUCSCRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:17:55 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:34724 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262206AbUCSCRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:17:52 -0500
Message-ID: <405A584B.40601@cyberone.com.au>
Date: Fri, 19 Mar 2004 13:17:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random>
In-Reply-To: <20040318145129.GA2246@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>
>BTW, with preempt enabled there is no guarantee that RCU can ever reach
>a quiescient point and secondly there is no guarantee that you will ever
>be allowed to unplug a CPU hotline since again there's no guarantee to
>reach a quiescient point. Think a kernel thread doing for (;;) (i.e.
>math computations in background, to avoid starving RCU the kernel thread
>will have to add schedule() explicitly no matter if PREEMPT=y or
>PREEMPT=n, again invalidating the point of preempt, the rcu tracking for
>PREEMT=y is also more expensive).
>
>

Why is this so? schedule() runs RCU_qsctr(task_cpu(prev))++;
whether it is called directly or via preempt_schedule.


>Note, the work you and the other preempt developers did with preempt was
>great, it wouldn't be possible to be certain that it wasn't worthwhile
>until we had the thing working and finegrined (i.e. in all in_interrupt
>etc..), and now we know it doesn't payoff and in turn I'm going to try
>the explicit-preempt that is to explicitly enable preempt in a few
>cpu-intensive kernel spots where we don't take locks (i.e. copy-user),
>the original suggestion I did 4 years ago, I believe in such places an
>explicit-preempt will work best since we've already to check every few
>bytes the current->need_resched, so adding a branch there should be very
>worthwhile. Doing real preempt like now is overkill instead and should
>be avoided IMHO.
>
>

Technically, I think preempt can still reduce maximum latency
depending on whether the time between explicit resched checks
is greater than the (small) scheduling overhead that preempt
adds.

But yeah, that would be in the noise compared with long
preempt-off regions.

I'm not sure about applications, but maybe some soft-realtime
things like audio software benefit from a lower average latency
(I don't know).

