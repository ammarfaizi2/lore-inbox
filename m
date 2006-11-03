Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWKCUql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWKCUql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbWKCUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:46:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57013 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753528AbWKCUql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:46:41 -0500
Date: Fri, 3 Nov 2006 12:46:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/7] sched_domain balancing via tasklet V3
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

However, this issue also highlights the general problem of interrupt
holdoff during scheduler load balancing.

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
V1: http://marc.theaimsgroup.com/?l=linux-kernel&m=116171494001548&w=2
V2: http://marc.theaimsgroup.com/?l=linux-kernel&m=116200355408187&w=2

V1-V2:
- Keep last_balance and calculate the next balancing from that start
  point.
- Move more code into time_slice calculation and rename time_slice()
  to task_running_tick().
- Separate out the wake_priority_sleeper optimization as a first patch.

V2->V3
- Rediff against 2.6.19-rc4-mm2
- Remove useless check for rq->idle in rebalance_domains()

