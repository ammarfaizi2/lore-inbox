Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTDIC1B (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTDIC1A (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:27:00 -0400
Received: from fmr06.intel.com ([134.134.136.7]:47076 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261826AbTDIC06 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 22:26:58 -0400
Message-ID: <16019.34302.176320.974892@milikk.co.intel.com>
Date: Tue, 8 Apr 2003 19:31:26 -0700
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 2.5.66] Real-time futexes (priority inheritance/protection/robust support) take 5
To: linux-kernel@vger.kernel.org, phil-list@redhat.com
X-Mailer: VM 7.07 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

More fixes for the real-time futexes. Priority inheritance has now
some more fixes (some of them more or less ugly tweaks) and it
should work better now (some bugs and deadlocks fixed). Still
work-in-progress. 

This is my second try into implementing real-time futex
support. The patch below encloses a proposal on a way to do
real-time futexes that support priority-inheritance,
priority-protection, dead-owner recovery (more flexible than Sun's
Robust Mutex Extension) and dead lock detection, a sample
implementation (sans priority-protection) and a set of test
programs along with a very simple thread library to test it.

Note this is NOT a replacement for futexes. rtfutexes cannot do
things that normal futexes can do because of the constraints that
"real-time-ness" impose. It is intended as a complementary
interface.

I have been working on this for a while, and got input from many
different people in different companies who are interested in
these features (eg: Intel, Cisco, Montavista, OSDL ...) We are
also working on a way to blend this into NPTL so it can do
real-time. 

Version 5

- Ported to 2.5.66 - this fixed the timing problems found;
  according to George Anzinger, it was a problem in the timer
  code.

- Fix allocation of rtfutex_q: when we drop the spin lock, we need
  to claim again, as somebody else might have preempted and
  modified it. This makes the code much more stable.

- General cleanups (debug, doc) and optimizations (moving
  not-common code paths out of the way - it makes it kind of
  uglier though).

- Fix deadlock caused when rtfutex_do_recycle() runs while the
  same CPU was running with the rtfutex_lock held (I keep stomping
  into this one) - right now just do a trylock and abort if not
  possible. 

- Fail when trying to lock a futex in non recoverable state.

- Fix different aspects in PI (stop the propagation when a
  non-PI/PP futex is hit and fall back to deadlock
  detection). Make it cleaner when we set the priority of a task
  because of inheritance. Force a boosted task to yield when the
  boosting task stops waiting (still needs some work).

- Optimize rtfutex_sign_task() a wee bit for the "all clear" case.

- Allow any kind of task to use rtfutex, even if it is not
  realtime. However, PI/PP requires SCHED_FIFO or SCHED_RR. Use
  static_prio for non-realtime tasks instead of prio.

- Is slow as hell ... I mean, it is expected to be slower than
  normal futexes because they are more complex, but currently it
  sucks. Working on that - mainly removing any usage of
  kmap_atomic(); the TLB flush is a killer.

- Funny behavior on PI with test-11.c; sometimes the thread TL
  overpowers lower-prio TP from the very start.

Version 4

- Currently on 2.5.64

- Does not modify original futexes - a new interface is added

Caveats:

- Priority protection not yet implemented.

- Many fixmes here and there that require answers

- Hook for properly acting when the priority of a waiting task is
  changed not implemented yet. 

- The tweak in timer.c is kind of ugly, and needs to be done much more
  generic; maybe even moved into wake_up_process().

Check out kernel/rtfutex.c for a quick roadmap;
Documentation/rtfutex.txt for a longer series of rants and a
something more like a design reference. Documentation/rtfutex-api.txt 
describes how to call the functions (in the test library,
test/src/include/rtfutex.h is more up-to-date). 

Patch at: http://sost.net/pub/linux/rtfutex-5.patch
Test pkg at: http://sost.net/pub/linux/rtfutex-test-5.tar.gz

Build with:

./configure --with-headers=RTFUTEX-PATCHED-LINUX-TREE/include
make

-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
