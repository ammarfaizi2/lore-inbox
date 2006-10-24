Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWJXSbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWJXSbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbWJXSbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:31:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8586 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161152AbWJXSbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:31:22 -0400
Date: Tue, 24 Oct 2006 11:31:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/5] On demand sched_domain balancing in tasklet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset moves potentially expensive load balancing out of the scheduler
tick (where we run with interrupts disabled) into a tasklet that is triggered
if necessary from scheduler_tick(). Load balancing will then run with interrupts
enabled. This eliminates interrupt holdoff times and avoids potential machine
livelock if f.e. load balancing is performed over a large number of processors
and many of the nodes experience heavy load which may lead to delays in
fetching cachelines. We have currently up to 1024 processors and may go up
to 4096 soon. Similar issues were seen on a Fujitsu system in the past.

The moving of the load balancing into a tasklet also allows some
cleanup in scheduler_tick(). It gets easier to read and the determination
of the state for load balancing can be moved out of scheduler_tick().

Further optimization of scheduler_tick() processing occurs because we
no longer check all the sched domains on each tick.
We determine the time of the next load balancing on every load balancing
and check against this single value in scheduler_tick().

Another optimization is that we perform the staggering of the individual
load balance operations not during load balancing but shift that
to the setup of the sched domains.

For the earlier discussion see:
http://marc.theaimsgroup.com/?t=116119187800002&r=1&w=2

Tested on:
NUMA ia64/sn2
SMP i386
UP x86_64

