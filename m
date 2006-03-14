Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWCNUkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWCNUkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCNUkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:40:49 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:41352 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751814AbWCNUkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:40:49 -0500
Date: Tue, 14 Mar 2006 21:40:31 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <1142333882.19916.612.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0603141756500.1291-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Mar 2006, Thomas Gleixner wrote:

> On Tue, 2006-03-14 at 11:02 +0100, Esben Nielsen wrote:
> > > Thomas' testing method has the advantage that it utilizes the kernel's
> > > PI mechanism directly, hence it is easy to keep it uptodate without
> > > having to port the kernel's PI code to userspace.
> >
> > I call that a disadvantage. I the impression you work like this
> > 0) Write or fix code
> > 1) Try to compile the kernel
> > 2) On compile error goto 0
> > 3) Try to boot the kernel
> > 4) If the kernel doesn't boot goto 0
> > 5) Test whatever you have changed
> > 6) If your test fails goto 0
> >
> > Just the time spend in 1) is between a few seconds to figure out simple
> > syntax errors and up to several minuttes to recompile a lot of the
> > kernel. 3) takes a minute or two, 5) usually also takes some time,
> > depending on how much you have set up automaticly.
> > In short: Each iteration is minuttes.
>
> Well, the time for the kernel compile/boot cycles is less than the time
> I spent trying to get your tester compiled. I gave up on it and wrote
> the simple in kernel tester.
>
Ok, I missed the last 5% of work, making nice REAME and better Makefile.

> I agree, that your method is nice and fast, but then it has to be
>
> - completely self contained.
Mine could be it it was maintained and distributed with the kernel source.
Your tester also needs to have a userspace script driver to be usefull.

> - no drag in of other kernel headers and kernel code except the few
> source files you want to test
> - compilable out of the box
>
> Still I want to have both ways. An unittester can not emulate the
> dynamic behaviour on a real kernel.

No, it is not supposed to. It is supposed to test the algorithms. If you
want to have real dynamic behaviour it is an integration test.
The nice thing about _not_ having the real time involved is that
everything is 100% reproduceable. There are no random flukes. The results
doesn't depend on the processor speed or any other thing which can change
from setup to setup.

>
> > But notice in the above examble: I keeped the integration test. Both
> > levels of test are needed. But the integration test takes longer to
> > perform as equipment is needed, and it is (at least in the case above)
> > also harder to maintain as it depends on a lot of things other than the
> > module directly being tested.
>
> He? Why should an integrated tester be harder to maintain ? The unittest
> is the hard stuff, looking at the number of stubs you have to implement
> and keep up to date with the ongoing kernel development.

The trick is: Maintain the unittest along with the code you are testing.
Unfortunately a lot of people haven't discovered that yet. As I said
before, the Linux kernel sould should have a tests/ directory in the main
directory and a "make tests". For any patch to be accepted, should "make
tests" should "build". Patches ofcouse include changes to the kernel code
and the tests/ directory as it is one distribution.  Notice the tests are
run _without_ running the kernel!
That is how I do it at work: I have it all in one source repository and
the "tests" target is the first dependency of "all:" in the makefile.

>
> > > well, this is a circular dependency deadlock - which is illegal in the
> > > kernel,
> >
> > I still find it better to gracefully go to sleep or report a bug than just
> > crashing the machine.
>
> If you have debug deadlock detection enabled it triggers a bug and shows
> you exactly the place where it is called from. If debug is disabled it
> just goes to sleep  (deadlocked).

Well, that is not what my tester sees, and I am pretty sure it detects a
real raw spinlock deadlock.

>
> > > and which we detect for futex locks too - so it shouldnt happen.
> >
> > You mean that you have to run deadlock detection for all futexes to avoid
> > crashing the kernel?
>
> Why should the kernel crash ? I have no idea why you insist on that.

Raw spin deadlocks...

>
> >  Sounds like waste of CPU. I would prefer that they
> > tasks just go to sleep and then the user can detect it postmortem.
>
> The deadlock detection is done, when requested. So you _have_ to do it
> by following the lock chain. When the task goes to sleep, then there is
> no postmortem. When a futex requests deadlock detection you have to do
                              --------
> it in the locking path, as you have to return that information to
> userspace.
>
> http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_lock.html
>
The point is that when deadlock detection isn't requested it ought not to
be forced on the application.

> > Anyway: As far as I can see the deadlock happens in adjust_prio_chain()
> > no matter what the detect_deadlock argument is. The bug is because you to
> > lock current->pi_lock and owner->pi_lock at the same time in different
> > order. As far as I can see that can happen from futex_lock_pi() as well.
> >
> > We are basicly back to the discussions I had last fall: Doing deadlock
> > detection and PI is almost the same thing. You have to somehow traverse
> > the list of locks. So to protect the kernel from crashing in the PI code when
> > futexes deadlock, you have to traverse the list of locks without
> > spin deadlocking to detect the futex deadlock. If you can do that, you
> > could just as well do the PI that way in the first place.
>
> We do deadlock detection and PI in one go.
>
> And we have to hold the locks for already discussed reasons. There is no
> spinlock deadlocking going on.
>
> 		/* Try to lock the lock */
> 		for (;;) {
> 			waiter = owner->pi_blocked_on;
> 			if (!waiter)
> 				goto out_unlock_owner;
> 			lock = waiter->lock;
>
> 			if (unlikely(lock == act_lock)) {
> 				debug_rt_mutex_deadlock(deadlock_detect,
> 							act_lock, lock, ip);
> 				ret = deadlock_detect ? -EDEADLK : 0;
> 				goto out_unlock_chain;
> 			}
> 			if (_raw_spin_trylock(&lock->wait_lock))
> 				break;
>
> 			_raw_spin_unlock(&owner->pi_lock);
> 			cpu_relax();
> 			_raw_spin_lock(&owner->pi_lock);
> 		}
>
It happens before getting into that loop

task1 locks lock A             task2 locks lock B
task1 locks lock B:            task2 locks lock A:
  ...                           ...
  lock task1->pi_lock           lock task2->pi_lock
  ...                           ....
  lock task2->pi_lock           lock task1->pi_lock

Please follow sequence of locks in task_blocks_on_rt_mutex().

> A futex deadlock does not crash the kernel. Wyh should it ?
As above.

>
> It is either silently going to sleep with the deadlock or reporting back
> to the calling code, when deadlock detection is requested. In that case
> the deadlock is removed by removing the task from the waiters and
> returning -EDEADLK to the caller.
>
>
> > > Or did you see it happen for real?
> >
> > No, I have not booted the new kernel at all. I just ran TestRTMutex.
>
> Well. Running the in kernel tester with a deadlock test just simply
> works. This is the output with deadlock debugging disabled.
>
Sure. But you might not hit the exact timing as above. My TestRTMutex was
designed to hit that timing because that was the well accepted bug in
Steven's original code. My tester could see it. Then I recoded it to use
the scheduler and the test parses. Now it the problem is back. That is
precisely what unitests are good for: Find bugs in deterministic fashion.
You can't do that in simple in-kernel test. You might find it if you run
your test enough times and you exactly hit the right timing. Or you might
not. If the two last calls to down() aren't done _at the same
time_ there will be no deadlock.

> testsmp:~/rt-tester# ./rt-tester.py t2-l2-2rt-deadlock.tst
> C: resetevent:          0:      0
> W: opcodeeq:            0:      0
>    O:    0, E:       0, S: 0x00000002, P:  -11, N:  -11, B: 00000000, K: 0, M:00000000, T: c155c170, R: 00000000
> C: schedfifo:           0:      80
> W: opcodeeq:            0:      0
>    O:    0, E:       0, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000000, T: c155c170, R: 00000000
> C: schedfifo:           1:      80
> W: opcodeeq:            1:      0
>    O:    0, E:       0, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000000, T: c1565240, R: 00000000
> C: locknowait:          0:      0
> W: locked:              0:      0
>    O:    0, E:       2, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000004, T: c155c170, R: c155c170
> C: locknowait:          1:      1
> W: locked:              1:      1
>    O:    0, E:       4, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000040, T: c1565240, R: c1565240
> C: lockintnowait:       0:      1
> W: blocked:             0:      1
>    O:    6, E:       6, S: 0x00000002, P:   80, N:   80, B: c1567f30, K: 0, M:00000024, T: c155c170, R: c155c170
> C: lockintnowait:       1:      0
> W: blocked:             1:      0
>    O:    6, E:       8, S: 0x00000002, P:   80, N:   80, B: c150df30, K: 0, M:00000042, T: c1565240, R: c1565242
> C: signal:              1:      0
> W: unlocked:            1:      0
>    O:   -4, E:      10, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000040, T: c1565240, R: c1565242
> C: signal:              0:      0
> W: unlocked:            0:      1
>    O:   -4, E:      12, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000004, T: c155c170, R: c155c170
> C: unlock:              0:      0
> W: unlocked:            0:      0
>    O:    0, E:      14, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000000, T: c155c170, R: 00000000
> C: unlock:              1:      1
> W: unlocked:            1:      1
>    O:    0, E:      16, S: 0x00000002, P:   80, N:   80, B: 00000000, K: 0, M:00000000, T: c1565240, R: 00000000
> Pass
>
>
> The test does the following:
> # T0 lock L0
> C: locknowait:          0:      0
> W: locked:              0:      0
>
> # T1 lock L1
> C: locknowait:          1:      1
> W: locked:              1:      1
>
> # T0 lock L1
> C: lockintnowait:       0:      1
> W: blocked:             0:      1
>
> # T1 lock L0
> C: lockintnowait:       1:      0
> W: blocked:             1:      0
>
> # Make deadlock go away
> C: signal:              1:      0
> W: unlocked:            1:      0
> C: signal:              0:      0
> W: unlocked:            0:      1
>
> # Unlock and exit
> C: unlock:              0:      0
> W: unlocked:            0:      0
> C: unlock:              1:      1
> W: unlocked:            1:      1
>

It looks like your test-operations are executed sequentially. Am I
right? If so you will never hit the bug.

> The lock ops causing the deadlock are locked interruptible, so I can
> resolve the deadlock by sending a signal.
>
> When deadlock debugging is enabled I simply get a bug showing the exact
> place.
>
> root@testbox2:~/rt-tester# ./rt-tester.py t2-l2-2rt-deadlock.tst1
> C: resetevent:          0:      0
> W: opcodeeq:            0:      0
>    O:    0, E:       0, S: 0x00000002, P:  -11, N:  -11, B: 00000000, K:
> 0, M:00000000, T: c7dcb910, R: 00000000
> C: schedfifo:         ~  0
> ============================================
> [ BUG: circular locking deadlock detected! ]
> --------------------------------------------
> rt-test-0/94 is deadlocking current task rt-test-1/96
>
>
> 1) rt-test-1/96 is trying to acquire this lock:
>  [c0599680] {init_rttest}
> .. ->owner: c7dcb912
> .. held by:         rt-test-0:   94 [c7dcb910,  19]
> ... acquired at:               handle_op+0x1fc/0x310
> ... trying at:                 handle_op+0x2b8/0x310
>
> 2) rt-test-0/94 is blocked on this lock:
>  [c05996b8] {init_rttest}
> .. ->owner: c7df9912
> .. held by:         rt-test-1:   96 [c7df9910,  19]
> ... acquired at:               handle_op+0x1fc/0x310
>
>
> 	tglx
>
>

Esben

