Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbULCVKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbULCVKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbULCVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:10:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:36992
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262360AbULCVKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:10:08 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <20041202233459.GF32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>
	 <20041202233459.GF32635@dualathlon.random>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 22:10:06 +0100
Message-Id: <1102108206.13353.263.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 00:35 +0100, Andrea Arcangeli wrote:
> Fork eventually failing is very reasonable if you're executing a fork
> loop.

Yes, it's reasonable, but the effect that any consequent command is
aborted then is not so reasonable.
 
> > There is no output in dmesg, but I'm not able to remove the remaining
> > hackbench processes as even a kill -SIGKILL returns with 
> > fork() (error: resource temporarily not available)
> > 
> > I'm not sure, which of the two scenarios I like better :)
> 
> Please try with 2.4.23aa3, I think there was some oom killer change
> after I had no resources to track 2.4 anymore. I'm not saying 2.4.23aa3
> will work better though, but I would like to know if there's some corner
> case still open in 2.4-aa. Careful, 2.4.23aa3 has security bugs (only
> local security of course, i.e. normally not a big issue, sure good
> enough for a quick test).

I try, if I find some time, but I'm not too interested in 2.4 :)

> I doubt your testcase simulates anything remotely realistic but
> anyway it's still informative.

The hackbench testcase resembles the real life problem I encountered
quite realistic. Of course we have fixed the application since then, but
I bet that I'm not the only one who uses forking servers.

> What I'm simulating here is very real life scenario with a couple of
> apps allocating more memory than ram.

Use a forking server, connect a lot of clients and it is real life. :)

> > FYI, I tried with 2.6 UP and PREEMPT=n. The result is more horrible. The
> > box just gets stuck in an endless swap in/swap out and does not respond
> > to anything else than SysRq-T and the reset button.
> > 
> > With the callback the machine did not come back after 20 Minutes.
> 
> Was the oom killer invoked at all? If yes, and it works with preempt,
> that could mean a cond_resched is simply missing...

Yes, it was invoked

> > I think the callback is the only safe way to fix that. If PF_MEMDIE is
> > racy then I'm sure we will find a different indicator for that.
> 
> The callback adds overhead to the exit path. Plus strictly speaking it's
> not actually a callback, you're just "polling" for the bitflag :)

I know :)

> > Yep, but the reentrancy blocking with the callback makes the time, count
> > crap and the watermark check go away, as it is safe to reenable the
> > killer at this point because we definitely freed memory resources. So
> > the watermark comes for free.
> 
> You can get an I/O race where your program is about to finish a failing
> try_to_free_pages pass (note that a task exiting won't make
> try_to_free_pages work any easier, try_to_free_pages has to free
> allocated memory, it doesn't care if there's 1M or 100M of free memory).
> If you don't check the watermarks after waiting for I/O, you're going to
> generate a suprious oom-killing. Your changes can't help.

True, I did not take the I/O into account.

> Note that even the watermark checks leaves a race window open, but at
> least it's not an I/O window. While try_to_free_pages can wait for I/O
> and then fail.
> 
> I'll add to my last patch the removal of the PF_MEMDIE check in oom_kill
> plus I'll fix the remaining race with PF_EXITING/DEAD, and I'll add a
> cond_resched. Then you can try again with my simple way (w/ and w/o
> PREEMPT ;).
> 
> Thanks for the great feedback.


