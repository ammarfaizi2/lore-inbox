Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272276AbTGYTot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272277AbTGYTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:44:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26300 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272276AbTGYTor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:44:47 -0400
Date: Fri, 25 Jul 2003 21:59:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] sched-2.6.0-test1-G3, interactivity changes, audio latency
Message-ID: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


my current "interactivity changes" scheduler patchset can be found at:

	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G3

(this patch is mostly orthogonal to Con's patchset, but obviously collides
patch-wise. The patch should also cleanly apply to 2.6.0-test1-bk2.)

Changes:

 - cycle accuracy (nanosec resolution) timekeeping within the scheduler. 
   This fixes a number of audio artifacts (skipping) i've reproduced. I
   dont think we can get away without going cycle accuracy - reading the
   cycle counter adds some overhead, but it's acceptable. The first
   nanosec-accuracy patch was done by Mike Galbraith - this patch is
   different but similar in nature. I went further in also changing the
   sleep_avg to be of nanosec resolution.

 - more finegrained timeslices: there's now a timeslice 'sub unit' of 50 
   usecs (TIMESLICE_GRANULARITY) - CPU hogs on the same priority level 
   will roundrobin with this unit. This change is intended to make gaming
   latencies shorter.

 - include scheduling latency in sleep bonus calculation. This change 
   extends the sleep-average calculation to the period of time a task
   spends on the runqueue but doesnt get scheduled yet, right after
   wakeup. Note that tasks that were preempted (ie. not woken up) and are 
   still on the runqueue do not get this benefit. This change closes one 
   of the last hole in the dynamic priority estimation, it should result 
   in interactive tasks getting more priority under heavy load. This
   change also fixes the test-starve.c testcase from David Mosberger.

 - (some other, smaller changes.)

if you've experienced audio skipping in 2.6.0-test1 (and later) kernels
then please give this patch a go. Reports, testing feedback and comments
are welcome,

	Ingo

