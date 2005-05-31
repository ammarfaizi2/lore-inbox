Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVEaRqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVEaRqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVEaRqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:46:20 -0400
Received: from mail.ccur.com ([208.248.32.212]:55433 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261266AbVEaRqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:46:00 -0400
Subject: SD_SHARE_CPUPOWER breaks scheduler fairness
From: Steve Rotolo <steve.rotolo@ccur.com>
To: linux-kernel@vger.kernel.org
Cc: bugsy@ccur.com
Content-Type: text/plain
Organization: Concurrent Computer Corporation
Message-Id: <1117561608.1439.168.camel@whiz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 31 May 2005 13:46:48 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2005 17:45:57.0275 (UTC) FILETIME=[999AAEB0:01C56608]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SD_SHARE_CPUPOWER flag in SMT scheduling domains (hyperthread
systems) can starve out sched_other tasks and even hang the system.  A
long-running (or run-away) sched_fifo task causes sched_other tasks to
get stuck on the sibling cpu's runqueue without any chance to run.  The
sibling cpu simply stays idle with tasks on it's runqueue for as long as
the sched_fifo task runs on the other sibling cpu.  The culprit is
dependent_sleeper() in sched.c.

I guess the SD_SHARE_CPUPOWER is supposed to cause the scheduler to
prohibit non-real-time tasks from running on a cpu while a real-time
task is running on the sibling cpu.  The problem is that sched_other
tasks are not migrated to a different runqueue and essentially get stuck
on a dead runqueue until either the sched_fifo task yields or the
load-balancer moves him.  Unfortunately, the load-balancer will never
migrate the task if the runqueue length is not sufficiently out of
balance.  Even more unfortunate, the load-balancer will actually move
tasks *to* the dead runqueue if it is less busy.  And still worse, since
SD_WAKE_IDLE is also set in the scheduling domain, the dead cpu will
actually attract waking tasks to it because it is idle!  The cpu becomes
a sort-of black-hole sucking in innocent tasks so they can no longer
run.

The worst-case scenario is when there are N spinning sched_fifo tasks on
an N-way hyperthreaded system.  This hangs the system since nothing can
run on the virtual cpus.  If you turn off the SD_SHARE_CPUPOWER flag,
the system stays fully functional until you have N*2 spinners hogging
all the virtual cpus.

I get the same behavior from 2.6.9 to 2.6.12-rc5.  So is this a bug or a
feature?

-- 
Steve Rotolo
Concurrent Computer Corporation

