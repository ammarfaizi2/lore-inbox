Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWCNKUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWCNKUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWCNKUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:20:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51632 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751771AbWCNKU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:20:29 -0500
Date: Tue, 14 Mar 2006 11:18:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060314101811.GA10450@elte.hu>
References: <20060314081212.GD13662@elte.hu> <Pine.LNX.4.44L0.0603140944050.1291-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603140944050.1291-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > Thomas' testing method has the advantage that it utilizes the kernel's
> > PI mechanism directly, hence it is easy to keep it uptodate without
> > having to port the kernel's PI code to userspace.
> 
> I call that a disadvantage. I the impression you work like this
> 0) Write or fix code
> 1) Try to compile the kernel
> 2) On compile error goto 0
> 3) Try to boot the kernel
> 4) If the kernel doesn't boot goto 0
> 5) Test whatever you have changed
> 6) If your test fails goto 0
> 
> Just the time spend in 1) is between a few seconds to figure out 
> simple syntax errors and up to several minuttes to recompile a lot of 
> the kernel. 3) takes a minute or two, 5) usually also takes some time, 
> depending on how much you have set up automaticly. In short: Each 
> iteration is minuttes.

correct workload but wrong timing assumptions. For me to reboot into a 
completely rebuilt kernel is about 90 seconds (from the point of having 
saved the change in the editor, to the point i can ssh into the freshly 
booted up box). To reboot into a partially rebuilt kernel is less than 
30 seconds. (It is important to keep this particular latency as low as 
possible, for a number of other reasons as well, not just pure 
development time.)

> The way I work is
> 0) Fix whatever code (in TestRTMutex, rt.c or wherever)
> 1) Try to compile rttest and run the tests (done as one step with make)
> 2) If something fails goto 0,
> 
> Each iteration takes a few seoncds. I can do it within Emacs (please, 
> no flame wars! :-) where I in the compile buffer can jump directly to 
> the lines in the C-code or in the test-scripts where the error is 
> reported. I can also to some degree (as shown below) find SMP 
> deadlocks without having a SMP machine.

the PI code, while currently seeing alot of changes, isnt supposed to 
change all that often in the long run. Hence it is far more important 
to:

- _always_ have a testsuite available without maintainance overhead, 
  even if we only do small fixes to the PI code. With your method, both 
  the userspace PI code, and the kernel-space PI code has to be updated, 
  all the time.

- the have the _real_ PI code utilized. The real scheduler, and on a 
  real box.

- to be able to do stress-tests too, which is much less possible and 
  practical in a simulated PI environment.

> The point is: Even though you have to maintain an extra level of stubs 
> in userspace you gain much speedier development cycle. You gain 
> quality as you can test the logic in a more controlled manner 
> independent of the real timing on the target. You are forced to think 
> isolation and therefore get an overall better architecture.

the same benefit can be gotten by simply cutting down on the kernel 
compilation time and on the install-new-kernel-and-reboot latency.

> > thanks, applied. [NOTE: had to apply it by hand because the patch was
> > whitespace damaged, it had all tabs converted to spaces.]
> 
> Not again! I even used Pico from within Pine to paste it in...

hm, did you use Ctrl-R to read the patchfile in? That's pretty much the 
only good way to get a patch into Pine.

> > > 2) There is a spinlock deadlock when doing the following test on SMP:
> > >
> > > threads:   1            2
> > >          lock 1         +
> > >           +          lock 2
> > > test:   lockcount 1   lockcount 1
> > >
> > >          lock 2      lock 1            <- spin deadlocks here
> > >           -             -
> > > test:   lockcount 1   lockcount 1
> > >
> > > This happens because both tasks tries to lock both tasks's pi_lock but
> > > in opposit order.  I don't have fix for that one yet.
> >
> > well, this is a circular dependency deadlock - which is illegal in the
> > kernel,
> 
> I still find it better to gracefully go to sleep or report a bug than 
> just crashing the machine.

we do report it.

> > and which we detect for futex locks too - so it shouldnt happen.
> 
> You mean that you have to run deadlock detection for all futexes to 
> avoid crashing the kernel? [...]

no. We have to run deadlock detection to avoid things like circular lock 
dependencies causing an infinite schedule+wakeup 'storm' during priority 
boosting. (like possible with your wakeup based method i think) Note 
that deadlock detection and priority boosting is 'merged', so there is 
no CPU overhead from it. There is no global lock for deadlock detection 
anymore, etc.

> Anyway: As far as I can see the deadlock happens in 
> adjust_prio_chain() no matter what the detect_deadlock argument is.  
> The bug is because you to lock current->pi_lock and owner->pi_lock at 
> the same time in different order. As far as I can see that can happen 
> from futex_lock_pi() as well.

ok, checking this.

> We are basicly back to the discussions I had last fall: Doing deadlock 
> detection and PI is almost the same thing. You have to somehow 
> traverse the list of locks. So to protect the kernel from crashing in 
> the PI code when futexes deadlock, you have to traverse the list of 
> locks without spin deadlocking to detect the futex deadlock. If you 
> can do that, you could just as well do the PI that way in the first 
> place.

we are doing it precisely that way - PI and deadlock detection is 
'merged'. We do it in one go, in adjust_prio_chain().

	Ingo
