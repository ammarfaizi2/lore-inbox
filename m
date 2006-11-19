Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756495AbWKSHtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbWKSHtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 02:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756497AbWKSHtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 02:49:53 -0500
Received: from mail.gmx.de ([213.165.64.20]:1438 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1756495AbWKSHtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 02:49:52 -0500
X-Authenticated: #14349625
Subject: Re: Sluggish system responsiveness on I/O
From: Mike Galbraith <efault@gmx.de>
To: Christian <christiand59@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200611181412.29144.christiand59@web.de>
References: <200611181412.29144.christiand59@web.de>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 08:51:34 +0100
Message-Id: <1163922694.7504.42.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-18 at 14:12 +0100, Christian wrote: 
> Hello lkml!
> 
> Im currently testing 2.6.19-rc5-mm1. Everything works really fine except the 
> little wart with bad multimedia interactivity with a kernel compiling in the 
> background. So I tried to narrow it down as much 
> as possible.
> 
> I did several find's,dd's and cats in parrallel and watched four instances of 
> glxgears and also played a little enemy-territory. The interactivity was very 
> good, in fact no loss of interactivity at all. This was contrary to what I 
> believed the whole time. The loss of interactivity has nothing to do with 
> heavy I/O. In fact it happens only when I run a task which is I/O and CPU 
> heavy at the same time. That means a single kernel compile (with -j1) is able 
> to harm interactivity with glxgears and enemy-territory, but fully loading my 
> three disks does no harm at all.

That makes sense, I/O tasks don't generally hold the cpu for extended
periods, whereas a cpu bound task does.  I suspect you'll get the same
result by running a shell doing while true; do i=i+1; done while your
glxgears test is running.  Anything which uses lots of cpu continuously
will eventually lose it's "interactive" status, and will therefore
round-robin with any other cpu hogs in the system with no ability to
preempt, other than when their competition runs out of timeslice.

> So I tried to nice the make and see what happens:
> 
> nice 5 make -j4: Seems to make no difference. Heavy stuttering in glxgears and 
> et
> nice 10 make -j4: Somewhat better but still unusable with et
> 
> everything above nice 15 is usable. nice 19 has full interactivity, that means 
> you can't make out a difference between no load and kernel compile while 
> playing enemy-territory.

That makes sense too if enemy-territory sleeps ever so briefly very
frequently.  At nice 19, there is no possibility that gcc is at the same
priority or above enemy-territory or any other nice 0 cpu hog regardless
of any dynamic priority adjustment.  At every wake-up, it will be able
to preempt gcc.  If enemy-territory doesn't sleep frequently and very
briefly, I'd expect the anti-starvation logic combined 100ms timeslices
to give you noticeable hiccups.

> I suspect that it has something to do with the priority boost for I/O hogs. 
> But if this is a "general" scheduler problem, then why aren't more people 
> complaining about this?

I suspect it's because most of the time, even heavy cpu using
interactive tasks sleep enough to not lose their interactive status with
the scheduler.  IOW, the heuristics work well, but are not perfect.  The
scheduler simply cannot determine that any task is truely interactive,
so can't automatically give it as much cpu as it wants when the system
is over-loaded.

What if:  the scheduler did always give glxgears super high priority,
and you start a kernel compile and glxgears... and leave both running
while you go shopping.  While you're gone, glxgears has nobody to
interact with, but the scheduler can't possibly know that you left.
When you come back, you expect your compile to have finished, but it
just sat there while glxgears used 100% cpu.  Kobiashi Maru.

	-Mike

