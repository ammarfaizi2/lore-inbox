Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbUANWsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUANWsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:48:00 -0500
Received: from fmr05.intel.com ([134.134.136.6]:51846 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264929AbUANWrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:47:47 -0500
Date: Wed, 14 Jan 2004 14:49:46 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2.1
Message-ID: <0401141449.CaWdGcXb9b6caaodvdxcqcwdkc7cOazb9031@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This code proposes an implementation of kernel based mutexes,
taking ideas from the actual implementations using futexes
(namely NPTL), intending to solve its limitations (see doc) and
adding some features, such as real-time behavior, priority
inheritance and protection, deadlock detection and robustness.

Please look at the first patch, containing the documentation
for information on how is it implemented.

High level changelog since release 2.0:

- Fix docs, document the convoy phenomenon.

- Fix bugs in maintiaining the state of the ufulock when
switching back and forth to "fast-path mode".

- Added a few ioctl-like commands for querying state of the
ufulock as well as destruction.

- Add KCO mode, where the fast path is not available. This can
be used by architectures that don't have
compare-and-exchange. As well, it is the foundation for
priority protection.  All tests pass, and seems to work
[although didn't have too much time to go over it].

- Ported to 2.6.1 (basing it on mm2 to get kgdb goodies);
patches vanilla ok; however, you will get a couple of rejects
in kernel/Makefile -- it expects a line with ktrhead.o [just
make sure the line with all the fuqueue stuff is there].

Still to-do:

- Ugly bug triggered by running rtnptl-test-misc::str03 with:

$ (ulimit -s 32; time ./str03 -b5 -d5 > /tmp/kk)

[triggers inconsistency warning on NPTL patched with the rtnptl
patch].

- Finish implementing priority protection; this requires the
changes to implement priority inheritance with SCHED_NORMAL
tasks--need to find a way to have kind of an 'effective'
priority vs the original one that is not too invasive.

- Add a flag to the passing of timeout information to indicate
if it is relative or absolute, and as we are there, the clock
source. This way we avoid a costly kernel access in
pthread_mutex_timelock() and friends.

- Need to rename VFULOCK_KCO to VFULOCK_WP, to reduce confusions
with the KCO mode [that was _a_ mistake].

- Wipe out debug stuff (when not needed any more)

- research using single bit mode for fast-path on arches without
compare-and-exchange but with test-and-set bit.

- Add CONFIG option to compile out parts or all.

- Call __fuqueue_wait_cancel() into try_to_wake_up?

- unlock()-to-task, as suggested by Jamie...is it really needed?

- Research more into safe static allocation as proposed by Scott
Wood--the basic idea has a bunch of problems, mainly that it
kills caching and some others, but needs further research.

Did I miss anything?

The patch is split in the following parts:

1/10: documentation files
2/10: modifications to the core
3/10: Support for i386
4/10: Support for ia64
5/10: kernel fuqueues
6/10: user space/kernel space tracker
7/10: user space fuqueues
8/10: kernel fulocks
9/10: stub for priority protection
10/10: user space fulocks

We have a site at http://developer.osdl.org/dev/robustmutexes
with references to all the releases, test code and NPTL
modifications (rtnptl) to use this code. As well, the patch
is there in a single file, in case you don't want to paste
them manually.

