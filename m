Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbULBSa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbULBSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbULBSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:30:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:20902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261716AbULBSaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:30:06 -0500
Date: Thu, 2 Dec 2004 10:29:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-Id: <20041202102935.5d75c2be.akpm@osdl.org>
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
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Dec 02, 2004 at 08:55:18AM -0800, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > I believe the thing you're hiding with the callback, is some screwup in
> > >  the VM. It shouldn't fire oom 300 times in a row.
> > 
> > Well no ;)
> 
> Could you explain why do we need all_unreclaimable?  What is the point
> of all_unreclaimable if we bypass it at priority = 0?  Just to loop a
> few times (between DEF_PRIORITY and 1) at 100% cpu load?

It addresses the situation where all of a zone's pages are pinned down for
some reason (say, they're all mlocked, or we're out of swapspace).  There's
no point in chewing tons of CPU scanning this zone on every reclaim attempt,
so the VM marks the zone as being full of unreclaimable pages.

When the zone is marked all_unreclaimable, we *logically* don't scan it at
all - just skip it.  But in practice we do need to detect the situation
where some of the zone's pages have become reclaimable again.  That could
happen because more swapspace has become available, or an app ran munlock()
or whatever.  So to perform this detection we perform tiny scans to just
poll the zone.  If that tiny scan results in a page getting reclaimed then
we clear all_reclaimable and the zone returns to normal state.

As an alternative to the tiny-scan-polling we could clear all_unreclaimable
in all zones when releasing swapspace, when running munlock(), etc.

Probably free_pages_bulk() should only be clearing all_unreclaimable if
current->reclaim_state != NULL, because random page freeings in the zone
don't necessarily mean that any pages have become reclaimable.  Or clear
all_unreclaimable in shrink_list() rather than free_pages_bulk().

> OTOH we must not forget 2.4(-aa) calls do_exit synchronously and it
> never sends signals. That might be why 2.4 doesn't kill more than one
> task by mistake, even without a callback-wakeup. So if we keep sending
> signals I certainly agree with Thomas that using a callback to stop the
> VM until the task is rescheduled is a good idea, and potentially it may
> be even the only possible fix when the oom killer is enabled like in 2.6
> (though the 300 kills in between SIGKILL and the reschedule sounds like
> the VM isn't even trying anymore).  Otherwise perhaps his workload is
> spawning enough tasks, that it takes an huge time for the rechedule
> (that would explain it too).

Could be, I dunno.  I've never done any work on the oom-killer and I tend
to regard it as a stupid thing which is only there so you can get back into
the machine to shut down and restart everything.

I mean, if you ran the machine out of memory then it is underprovisioned
and it *will* become unreliable whatever we do.  The answer is to Not Do
That.  As long as the oom-killer allows you to get in and admin the machine
later on then that's good enough as far as I'm concerned.  Others probably
disagree ;)

> Actually this should fix it too btw:
> 
> -	if (p->flags & PF_MEMDIE)
> -		return 0;
> 
> Thomas can you try the above?
> 
> I'd rather fix this by removing buggy code, than by adding additional
> logics on top of already buggy code (i.e. setting PF_MEMDIE is a smp
> race and can corrupt other bitflags),

Yes, that needs a separate task_struct field.

> but at least the
> oom-wakeup-callback from do_exit still makes a lot of sense (even if
> PF_MEMDIE must be dropped since it's buggy, and something else should be
> used instead).

Probably.

> does the right watermark checks before killing the next task

yes, we should do that.

> BTW, checking for pid == 1 like in Thomas's patch is a must, I advocated
> it for years but nobody listened yet, hope Thomas will be better at
> convincing the VM mainline folks than me.

hm.  I thought we were already doing that, but it seems not.
