Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbULBXfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbULBXfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULBXfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:35:31 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:58051 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261803AbULBXfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:35:16 -0500
Date: Fri, 3 Dec 2004 00:35:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041202233459.GF32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041201211638.GB4530@dualathlon.random> <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102013716.13353.226.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 07:55:16PM +0100, Thomas Gleixner wrote:
> On Thu, 2004-12-02 at 19:08 +0100, Andrea Arcangeli wrote:
> > OTOH we must not forget 2.4(-aa) calls do_exit synchronously and it
> > never sends signals. That might be why 2.4 doesn't kill more than one
> > task by mistake, even without a callback-wakeup. 
> 
> I just run the same test on 2.4.27 and the behaviour is completely
> different.
> 
> The box seems to be stuck in a swap in/out loop for quite a long time.
> During this time the box is not responsive at all. It finally stops the
> forking after quite a long time of swapping with
> fork() (error: resource temporarily not available). 

Fork eventually failing is very reasonable if you're executing a fork
loop.

> 
> There is no output in dmesg, but I'm not able to remove the remaining
> hackbench processes as even a kill -SIGKILL returns with 
> fork() (error: resource temporarily not available)
> 
> I'm not sure, which of the two scenarios I like better :)

Please try with 2.4.23aa3, I think there was some oom killer change
after I had no resources to track 2.4 anymore. I'm not saying 2.4.23aa3
will work better though, but I would like to know if there's some corner
case still open in 2.4-aa. Careful, 2.4.23aa3 has security bugs (only
local security of course, i.e. normally not a big issue, sure good
enough for a quick test).

I doubt your testcase simulates anything remotely realistic but
anyway it's still informative.

What I'm simulating here is very real life scenario with a couple of
apps allocating more memory than ram.

> FYI, I tried with 2.6 UP and PREEMPT=n. The result is more horrible. The
> box just gets stuck in an endless swap in/swap out and does not respond
> to anything else than SysRq-T and the reset button.
> 
> With the callback the machine did not come back after 20 Minutes.

Was the oom killer invoked at all? If yes, and it works with preempt,
that could mean a cond_resched is simply missing...

> You meant the one in badness() right ?

yes.

> Well it makes it better, but I was able to have a second invocation
> before the first killed tasks exited. That's simple to explain. The task
> is on the way out and releases resources, so the VM size is reduced and
> the killer picks another process. 

That's trivial to fix checking for PF_DEAD/PF_EXITING.

> > I'd rather fix this by removing buggy code, than by adding additional
> > logics on top of already buggy code (i.e. setting PF_MEMDIE is a smp
> > race and can corrupt other bitflags), but at least the
> > oom-wakeup-callback from do_exit still makes a lot of sense (even if
> > PF_MEMDIE must be dropped since it's buggy, and something else should be
> > used instead).
> 
> I think the callback is the only safe way to fix that. If PF_MEMDIE is
> racy then I'm sure we will find a different indicator for that.

The callback adds overhead to the exit path. Plus strictly speaking it's
not actually a callback, you're just "polling" for the bitflag :)

> Yep, but the reentrancy blocking with the callback makes the time, count
> crap and the watermark check go away, as it is safe to reenable the
> killer at this point because we definitely freed memory resources. So
> the watermark comes for free.

You can get an I/O race where your program is about to finish a failing
try_to_free_pages pass (note that a task exiting won't make
try_to_free_pages work any easier, try_to_free_pages has to free
allocated memory, it doesn't care if there's 1M or 100M of free memory).
If you don't check the watermarks after waiting for I/O, you're going to
generate a suprious oom-killing. Your changes can't help.

Note that even the watermark checks leaves a race window open, but at
least it's not an I/O window. While try_to_free_pages can wait for I/O
and then fail.

I'll add to my last patch the removal of the PF_MEMDIE check in oom_kill
plus I'll fix the remaining race with PF_EXITING/DEAD, and I'll add a
cond_resched. Then you can try again with my simple way (w/ and w/o
PREEMPT ;).

Thanks for the great feedback.
