Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUJDHFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUJDHFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 03:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268487AbUJDHFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 03:05:39 -0400
Received: from [203.124.158.219] ([203.124.158.219]:37254 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S268231AbUJDHFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 03:05:36 -0400
Subject: [RFC] [PATCH] Performance of del_single_shot_timer_sync
From: shobhit dayal <shobhit@calsoftinc.com>
Reply-To: shobhit@calsoftinc.com
To: linux-kernel@vger.kernel.org, geoff@linux.intel.com, mingo@elte.hu
Content-Type: text/plain
Message-Id: <1096874675.11717.33.camel@kuber>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 04 Oct 2004 12:54:35 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                                                                                                  This is with reference to the del_timer_sync patch submitted by Geoff Gustafson http://lwn.net/Articles/84839/
I profiled a postgress load on a 8p( 4 nodes) NUMA machine. This
profiler logs functions that access memory on remote nodes, and
del_timer_sync was one of the top few functions doing this. The culprit
is the for loop in del_timer_sync that reads the running_timer field of
the per cpu tvec_bases_t structure on all nodes in the system. It get
invoked most times from del_singleshot_timer_sync. Andrew Morton had
suggested a patch for this, when the top callers to del_timer sync were
schedule_timeout and clear_timeout, the fix being the
del_single_shot_timer_sync patch,  with the knowledge that
schedule_timeout and clear_timeout do not create timers that re-add
themselves. This may not be enough, the problem is that schedule_timeout
at most times will call del_single_shot_timer_sync after the timer has
expired. This will cause del_timer to asume that the handler is running
on some cpu and del_timer_sync will still get invoked. Ofcourse, it also
means that del_timer_sync will continue to be a hotspot as far as taking
up cpu time is concerned.
	To confirm whether timers are mostly getting deleted before they expire
or after, I profiled the kernel, running a postgres load, logging
occurances of timer deletions before they expired and timer deletions
after they expired. The results show that the ratio of timers being
deleted after expiry to timers being deleted before expiry was 10:1.
This profiling was only done for schedule_timeout since it is the most
frequent caller to del_timer_singleshot_sync. There were 10000 occurance
of timers being deleted after expiry from schedule_timeout and 997
occurances of timers being deleted before expiry from schedule_timout, 
while the postgress workload ran. The ratio was always 10:1 from the
start of the workload to end as the number of deletions climbed. The
del_timer_singleshot_sync improves performance for the case where timers
are deleted before expiry but not for the case of timers being deleted
after expiry. The profiling data shows that the most frequesnt
occurance, is that of timers being deleted after expiry, to the ratio of
10:1. In such a case del_timer_singleshot_sync may not provide the
needed performance gain.

I tried Geoff's patch and it does seem to improve performance. Has
anyone else seen del_timer_sync as a hotspot after the
del_singleshot_timer_sync patch?

