Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWA3XhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWA3XhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWA3XhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:37:18 -0500
Received: from science.horizon.com ([192.35.100.1]:16971 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964937AbWA3XhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:37:16 -0500
Date: 30 Jan 2006 18:37:11 -0500
Message-ID: <20060130233711.23743.qmail@science.horizon.com>
From: linux@horizon.com
To: davids@webmaster.com
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thinking some more on my example, for SCHED_OTHER threads, it is possible
to define the problem away by making pthread_mutex_trylock behave
compatibly with pthread_mutex_lock.  That is, threads in pthread_mutex_lock()
are actually descheduled just before waiting for the lock (SCHED_OTHER is
allowed to do that), and when the lock becomes available, the scheduler
then decides who to run through the acquisition code.

As long as pthread_mutex_trylock() succeeds in such a case, some may call
it weird, but it's conformant, and the performance arguments for the
"unfair" case might easily win the day.

This is assuming that SCHED_OTHER can block a process for an arbitrary
time for no good reason.  Otherwise, if the lock holder is waiting for
device I/O and no other processes are competing for the CPU, perhaps
blocking on the edge like that for an unbounded time is illegal.


However, if you have priorities and can't redefine locking using creative
scheduling policies, it's less clear.  If I have a couple of real-time
tasks, I can't decide arbitrarily to run one in lieu of the other.
For example, suppose that without priority inheritance, you have three
tasks, A (highest priority), B, and C (lowest).

There are three locks.  Initially, A holds lock 1 and C holds lock 2.
Then A tries to acquire lock 2.  A blocks, so B runs until it blocks trying
to get lock 1.  Then C runs and drops lock 2.  A gets it, then drops lock 1
and tries to re-acquire it.

It seems to me that the Posix spec mandates that B gets lock 1 (and A
must block) before A can re-acquire it.

(This can also be done with priority inheritance, although it's a bit
different.  A version that works whether priority inheritance is
implemented or not is probably possible, too.)

I'm not saying that this is a good thing, but it's distinguishable, and I
don't have any language-lawyer way to escape the obligation.
