Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbULBSzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbULBSzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULBSzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:55:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:18304
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261702AbULBSzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:55:18 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <20041202180823.GD32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 19:55:16 +0100
Message-Id: <1102013716.13353.226.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 19:08 +0100, Andrea Arcangeli wrote:
> OTOH we must not forget 2.4(-aa) calls do_exit synchronously and it
> never sends signals. That might be why 2.4 doesn't kill more than one
> task by mistake, even without a callback-wakeup. 

I just run the same test on 2.4.27 and the behaviour is completely
different.

The box seems to be stuck in a swap in/out loop for quite a long time.
During this time the box is not responsive at all. It finally stops the
forking after quite a long time of swapping with
fork() (error: resource temporarily not available). 

There is no output in dmesg, but I'm not able to remove the remaining
hackbench processes as even a kill -SIGKILL returns with 
fork() (error: resource temporarily not available)

I'm not sure, which of the two scenarios I like better :)

FYI, I tried with 2.6 UP and PREEMPT=n. The result is more horrible. The
box just gets stuck in an endless swap in/swap out and does not respond
to anything else than SysRq-T and the reset button.

With the callback the machine did not come back after 20 Minutes.

Without the callback the machine dies after about 10 Minutes and killing
all available processes except init with:
Kernel panic - not syncing: Out of memory and no killable processes...

> So if we keep sending
> signals I certainly agree with Thomas that using a callback to stop the
> VM until the task is rescheduled is a good idea, and potentially it may
> be even the only possible fix when the oom killer is enabled like in 2.6
> (though the 300 kills in between SIGKILL and the reschedule sounds like
> the VM isn't even trying anymore).  Otherwise perhaps his workload is
> spawning enough tasks, that it takes an huge time for the rechedule
> (that would explain it too).

Yeah, there are enough tasks and with preempt enabled more than one
tasks requests memory. That explains the repetitive calls to
out_of_memory(). This only happens on UP + PREEMPT=y and SMP. See above.

> Actually this should fix it too btw:
> 
> -	if (p->flags & PF_MEMDIE)
> -		return 0;
> 
> Thomas can you try the above?

You meant the one in badness() right ?
Well it makes it better, but I was able to have a second invocation
before the first killed tasks exited. That's simple to explain. The task
is on the way out and releases resources, so the VM size is reduced and
the killer picks another process. 

> I'd rather fix this by removing buggy code, than by adding additional
> logics on top of already buggy code (i.e. setting PF_MEMDIE is a smp
> race and can corrupt other bitflags), but at least the
> oom-wakeup-callback from do_exit still makes a lot of sense (even if
> PF_MEMDIE must be dropped since it's buggy, and something else should be
> used instead).

I think the callback is the only safe way to fix that. If PF_MEMDIE is
racy then I'm sure we will find a different indicator for that.

> Whatever we change I'd like to change it on top of my last patch that
> already removes the 5 seconds fixed waits, and does the right watermark
> checks before killing the next task (Thomas already attempted that with
> a not accurate nr_free_pages check, so he at least agrees about the need
> of checking watermarks before firing up the oom killer).

Yep, but the reentrancy blocking with the callback makes the time, count
crap and the watermark check go away, as it is safe to reenable the
killer at this point because we definitely freed memory resources. So
the watermark comes for free.

> BTW, checking for pid == 1 like in Thomas's patch is a must, I advocated
> it for years but nobody listened yet, hope Thomas will be better at
> convincing the VM mainline folks than me.

:)

tglx


