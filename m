Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752049AbWCNKCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbWCNKCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWCNKCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:02:13 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:55996 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1752049AbWCNKCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:02:12 -0500
Date: Tue, 14 Mar 2006 11:02:04 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <20060314081212.GD13662@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603140944050.1291-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > Well, I got my TestRTMutex compiled and it was successfull: It found
> > bugs.
>
> great!
>
> I forgot to announce Thomas' great new rt-tester framework, which allows
> easy testing of the kernel's PI implementation, via userspace scripts.
> You can enable it via CONFIG_RT_MUTEX_TESTER, and the userspace scripts
> are at:
>
>  http://people.redhat.com/mingo/realtime-preempt/testing/rt-tester.tar.bz2
>
> Thomas' testing method has the advantage that it utilizes the kernel's
> PI mechanism directly, hence it is easy to keep it uptodate without
> having to port the kernel's PI code to userspace.

I call that a disadvantage. I the impression you work like this
0) Write or fix code
1) Try to compile the kernel
2) On compile error goto 0
3) Try to boot the kernel
4) If the kernel doesn't boot goto 0
5) Test whatever you have changed
6) If your test fails goto 0

Just the time spend in 1) is between a few seconds to figure out simple
syntax errors and up to several minuttes to recompile a lot of the
kernel. 3) takes a minute or two, 5) usually also takes some time,
depending on how much you have set up automaticly.
In short: Each iteration is minuttes.


The way I work is
0) Fix whatever code (in TestRTMutex, rt.c or wherever)
1) Try to compile rttest and run the tests (done as one step with make)
2) If something fails goto 0,

Each iteration takes a few seoncds. I can do it within Emacs (please, no
flame wars! :-) where I in the compile buffer can jump directly to the
lines in the C-code or in the test-scripts where the error is reported.
I can also to some degree (as shown below) find SMP deadlocks without
having a SMP machine.

I carry around similar experience from work where I rewrote a protocol
stack. I started out with an integration type test as Thomas's, but
including a physical network, running on the existing stack. That was
helpfull, but not really very stable, in that it could be hard to figure
out where the bugs really were. Was it the physical network or the
driver, or the timeout handling in the OS? But when I started to rewrite I
wrote unit tests for everything. I thus could work as above. When I later
actually  put it into the RTOS we use at work I could run the integration
test and  find extra bugs. Then when I had to actually had to port the
application  to use the new stack, it ran more stable than on the old
stack from day one. An extra plus: It was relatively easy to run on Linux
(in userspace), too, because the unittest forced me to think what I used
from the OS.

The point is: Even though you have to maintain an extra level of stubs in
userspace you gain much speedier development cycle. You gain quality as
you can test the logic in a more controlled manner independent of the real
timing on the target. You are forced to think isolation and therefore get
an overall better architecture.

But notice in the above examble: I keeped the integration test. Both
levels of test are needed. But the integration test takes longer to
perform as equipment is needed, and it is (at least in the case above)
also harder to maintain as it depends on a lot of things other than the
module directly being tested.


> We should add the
> testcases for the bugs you just found.
>
> > 1) Boosting nested locks simply doesn't work:
>
> > This is easily fixed by
>
> thanks, applied. [NOTE: had to apply it by hand because the patch was
> whitespace damaged, it had all tabs converted to spaces.]

Not again! I even used Pico from within Pine to paste it in...

>
> > 2) There is a spinlock deadlock when doing the following test on SMP:
> >
> > threads:   1            2
> >          lock 1         +
> >           +          lock 2
> > test:   lockcount 1   lockcount 1
> >
> >          lock 2      lock 1            <- spin deadlocks here
> >           -             -
> > test:   lockcount 1   lockcount 1
> >
> > This happens because both tasks tries to lock both tasks's pi_lock but
> > in opposit order.  I don't have fix for that one yet.
>
> well, this is a circular dependency deadlock - which is illegal in the
> kernel,

I still find it better to gracefully go to sleep or report a bug than just
crashing the machine.

> and which we detect for futex locks too - so it shouldnt happen.

You mean that you have to run deadlock detection for all futexes to avoid
crashing the kernel? Sounds like waste of CPU. I would prefer that they
tasks just go to sleep and then the user can detect it postmortem.

Anyway: As far as I can see the deadlock happens in adjust_prio_chain()
no matter what the detect_deadlock argument is. The bug is because you to
lock current->pi_lock and owner->pi_lock at the same time in different
order. As far as I can see that can happen from futex_lock_pi() as well.

We are basicly back to the discussions I had last fall: Doing deadlock
detection and PI is almost the same thing. You have to somehow traverse
the list of locks. So to protect the kernel from crashing in the PI code when
futexes deadlock, you have to traverse the list of locks without
spin deadlocking to detect the futex deadlock. If you can do that, you
could just as well do the PI that way in the first place.

> Or did you see it happen for real?

No, I have not booted the new kernel at all. I just ran TestRTMutex.

>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

