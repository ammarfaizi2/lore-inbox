Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUDUD6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUDUD6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 23:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUDUD6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 23:58:14 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:55538 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264697AbUDUD6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:08 -0400
Date: Tue, 20 Apr 2004 21:03:26 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux try 2.2
Message-ID: <0404202103.Zbzc4dTagcfbnbya~accIbGbHcAcwbBb1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This is a new release of the code for providing a user and kernel
space synchronization infrastructure that provides real-time friendly
behavior, priority inversion protection (through serialized unlocks,
priority inheritance and protection), deadlock detection and
robustness.

It builds upon the design of futexes and its usage model as NPTL does.

Please look at the first patch, containing the documentation for
information on how is it implemented.

High level changelog since release 2.1:

- Ported to 2.6.5

- Priority inheritance rework: now it should be fully functional:
supports SCHED_NORMAL tasks, holding multiple mutexes (without bugs),
ownership/wait chains with complex propagation rules and plays fine
with the planned priority protection support. It required
kind of invasive surgery at sched.c; need to find a way to simplify
it as it is touching some very hot paths.

- Added unserialized mode: in this mode, during unlocks, the mutex is
not kept locked (this is how NPTL works). Performance increases, but
you loose robustness guarantees.

- Greg Weeks, from TimeSYS, provided the ports to ppc and ppc64;
haven't tested myself as I lack such a machine.

- Fix nasty bug when a signal is sent to a waiter--still can be
improved.

- Fix nastier bug in changing the priority of a waiter--can't call
fuqueue_waiter_chprio() from inside a task_rq_lock/unlock pair or
bad things might happen during priority inheritance (double spin
lock).

- Updated a wee bit the consistency() interface, now called ctl(), as
it does way more than consistency control. Made the implementation a
wee bit cleaner, still very ugly though.

- Clean up some symbol names for correctness and meaning; wipe out
some debugging stuff--still a lot left around, but will clean
up IANF.

Still to-do:

- Requeue-like support for speeding up conditional variables.

- Jamie's auto unlock-method detection.

- Ugly bug triggered by running rtnptl-test-misc::str03 with:

$ (ulimit -s 32; time ./str03 -b5 -d5 > /tmp/kk)

[triggers inconsistency warning on NPTL patched with the rtnptl
patch--haven't been able to reproduce it lately using the
unserialized mode, but need to try with the serialized one again].

- Finish implementing priority protection; most of the infrastructure
is there already.

- Add a flag to the passing of timeout information to indicate
if it is relative or absolute, and as we are there, the clock
source. This way we avoid a costly kernel access in
pthread_mutex_timelock() and friends. Plan to encapsulate the whole
thing (timespec, rel/abs, clock source) in a struct copied from user
space.

- Wipe out debug stuff

- research using single bit mode for fast-path on arches without
compare-and-exchange but with test-and-set bit.

- Call fuqueue_waiter_cancel() into try_to_wake_up?

- Add CONFIG option to compile out parts or all.

- Research more into safe static allocation as proposed by Scott
Wood--the basic idea has a bunch of problems, mainly that it
kills caching and some others, but needs further research.

Did I miss anything?

The patch is split in the following parts:

1/11: documentation files
2/11: modifications to the core
3/11: Support for i386
4/11: Support for ia64
5/11: Support for ppc
6/11: Support for ppc64
7/11: kernel fuqueues
8/11: user space/kernel space tracker
9/11: user space fuqueues
10/11: kernel fulocks
11/11: user space fulocks

We have a site at http://developer.osdl.org/dev/robustmutexes
with references to all the releases, test code and NPTL
modifications (rtnptl) to use this code. As well, the patch
is there in a single file, in case you don't want to paste
them manually.


