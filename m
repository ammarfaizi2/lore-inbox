Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUCRTiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUCRTiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:38:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41093
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262896AbUCRTit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:38:49 -0500
Date: Thu, 18 Mar 2004 20:39:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318193936.GB2022@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318110159.321754d8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 11:01:59AM -0800, Andrew Morton wrote:
> weird situations in which the kernel fails to make any forward progress. 

definitely agreed.

the old lowlatency patches had the same issue too and that's why I
rejected it for some time, but eventually I changed them to go stright
the second time.

breaking the loop _once_ (and having to restart from scratch) is ok,
because we may be starting the loop with only 1msec of timeslice left
for example. Second time in the loop (or at some point) we can ignore
need_resched, to guarantee forwards progress.

> I've been meaning to do another round of latency tuneups for ages, so I'll
> check this one out, thanks.

thanks Andrew!

> There's also the SMP problem: this CPU could be spinning on a lock with
> need_resched() true, but the other CPU is hanging on the lock for ages
> because its need_resched() is false.  In the 2.4 ll patch I solved that via
> the scary hack of broadcasting a reschedule instruction to all CPUs if an
> rt-prio task just became runnable.  In 2.6-preempt we use
> preempt_spin_lock().
> 
> But in 2.6 non-preempt we have no solution to this, so worst-case
> scheduling latencies on 2.6 SMP CONFIG_PREEMPT=n are high.
> 
> 
> Last time I looked the worst-case latency is in fact over in the ext3
> checkpoint code.  It's under spinlock and tricky to fix.

preempt_spin_lock is the wrong way to go, the right way to go is to
fix the broken code that is "hanging on the lock for ages" ;). More
seriously: if you need a lock for ages, you must use a semaphore not a
spinlock.

spinlocked critical sections must be small, oh and you can always
trivially add a spin_lock_schedule() API that is doing the same thing of
preempt_spin_lock if you really want because you've an obscure lock
taken inside other locks, but some "quick" reader that could sleep
happens to have to wait the writer to do the bulk of the work.

The only difference is that spin_lock_schedule must be called in a place
where you're sure you can sleep.

So a spin_lock_schedule is doable just fine, but if you need it, it's
possible the code could be written better with a semaphore or by
avoiding big loops holding locks.

> low-latency developers from O(2) to O(lots).  If some user is complaining

;)
