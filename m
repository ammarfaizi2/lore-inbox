Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRKHRID>; Thu, 8 Nov 2001 12:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRKHRHn>; Thu, 8 Nov 2001 12:07:43 -0500
Received: from [208.129.208.52] ([208.129.208.52]:14086 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S276707AbRKHRHe>;
	Thu, 8 Nov 2001 12:07:34 -0500
Date: Thu, 8 Nov 2001 09:15:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111080913560.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Ingo Molnar wrote:

>
> i've attached a patch that fixes a long-time performance problem in the
> Linux scheduler.
>
> it's a fix for a UP and SMP scheduler problem Alan described to me
> recently, the 'CPU intensive process scheduling' problem. The essence of
> the problem: if there are multiple, CPU-intensive processes running,
> intermixed with other scheduling activities such as interactive work or
> network-intensive applications, then the Linux scheduler does a poor job
> of affinizing processes to processor caches. Such scheduler workload is
> common for a large percentage of important application workloads: database
> server workloads, webserver workloads and math-intensive clustered jobs,
> and other applications.
>
> If there are CPU-intensive processes A B and C, and a scheduling-intensive
> X task, then in the stock 2.4 kernels we end up scheduling in the
> following way:
>
>     A X A X A ... [timer tick]
>     B X B X B ... [timer tick]
>     C X C X C ... [timer tick]
>
> ie. we switch between CPU-intensive (and possibly cache-intensive)
> processes every timer tick. The timer tick can be 10 msec or shorter,
> depending on the HZ value.
>
> the intended length of the timeslice of such processes is supposed to be
> dependent on their priority - for typical CPU-intensive processes it's 100
> msecs. But in the above case, the effective timeslice of the
> CPU/cache-intensive process is 10 msec or lower, causing potential cache
> trashing if the working set of A, B and C are larger than the cache size
> of the CPU but the invidivual process' workload fits into cache.
> Repopulating a large processor cache can take many milliseconds (on a 2MB
> on-die cache Xeon CPU it takes more than 10 msecs to repopulate a typical
> cache), so the effect can be significant.
>
> The correct behavior would be:
>
>     A X A X A ... [10 timer ticks]
>     B X B X B ... [10 timer ticks]
>     C X C X C ... [10 timer ticks]
>
> this is in fact what happens if the scheduling acitivity of process 'X'
> does not happen.
>
> solution: i've introduced a new current->timer_ticks field (which is not
> in the scheduler 'hot cacheline', nor does it cause any scheduling
> overhead), which counts the number of timer ticks registered by any
> particular process. If the number of timer ticks reaches the number of
> available timeslices then the timer interrupt marks the process for
> reschedule, clears ->counter and ->timer_ticks. These 'timer ticks' have
> to be correctly administered across fork() and exit(), and some places
> that touch ->counter need to deal with timer_ticks too, but otherwise the
> patch has low impact.
>
> scheduling semantics impact: this causes CPU hogs to be more affine to the
> CPU they were running on, and will 'batch' them more agressively - without
> giving them more CPU time than under the stock scheduler. The change does
> not impact interactive tasks since they grow their ->counter above that of
> CPU hogs anyway. It might cause less 'interactivity' in CPU hogs - but
> this is the intended effect.

Maybe you missed this :

http://www.xmailserver.org/linux-patches/mss.html

where the patch that does this is here :

http://www.xmailserver.org/linux-patches/lnxsched.html#CPUHist




- Davide


