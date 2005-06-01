Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVFACry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFACry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFACry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:47:54 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:6121 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261244AbVFACru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:47:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Steve Rotolo <steve.rotolo@ccur.com>
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Wed, 1 Jun 2005 12:49:47 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <1117561608.1439.168.camel@whiz>
In-Reply-To: <1117561608.1439.168.camel@whiz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011249.47655.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005 03:46 am, Steve Rotolo wrote:
> The SD_SHARE_CPUPOWER flag in SMT scheduling domains (hyperthread
> systems) can starve out sched_other tasks and even hang the system.  A
> long-running (or run-away) sched_fifo task causes sched_other tasks to
> get stuck on the sibling cpu's runqueue without any chance to run.  The
> sibling cpu simply stays idle with tasks on it's runqueue for as long as
> the sched_fifo task runs on the other sibling cpu.  The culprit is
> dependent_sleeper() in sched.c.
>
> I guess the SD_SHARE_CPUPOWER is supposed to cause the scheduler to
> prohibit non-real-time tasks from running on a cpu while a real-time
> task is running on the sibling cpu.  The problem is that sched_other
> tasks are not migrated to a different runqueue and essentially get stuck
> on a dead runqueue until either the sched_fifo task yields or the
> load-balancer moves him.  Unfortunately, the load-balancer will never
> migrate the task if the runqueue length is not sufficiently out of
> balance.  Even more unfortunate, the load-balancer will actually move
> tasks *to* the dead runqueue if it is less busy.  And still worse, since
> SD_WAKE_IDLE is also set in the scheduling domain, the dead cpu will
> actually attract waking tasks to it because it is idle!  The cpu becomes
> a sort-of black-hole sucking in innocent tasks so they can no longer
> run.
>
> The worst-case scenario is when there are N spinning sched_fifo tasks on
> an N-way hyperthreaded system.  This hangs the system since nothing can
> run on the virtual cpus.  If you turn off the SD_SHARE_CPUPOWER flag,
> the system stays fully functional until you have N*2 spinners hogging
> all the virtual cpus.
>
> I get the same behavior from 2.6.9 to 2.6.12-rc5.  So is this a bug or a
> feature?

Sort of yes and yes. The idea that the sibling gets put to sleep if a real 
time task is running is a workaround for the fact that you do share cpu power 
(as you've correctly understood) and a real time task will slow down if a 
SCHED_NORMAL task is running on its sibling which it should not.  The 
limitation is that, yes, for all intents you only have N hyperthreaded cpus 
for spinning N rt tasks before nothing else runs, but you can actually run 
N*2 rt tasks in this setting which you would not be able to if hyperthreading 
was disabled.

For some time I've been thinking about changing the balance between the 
siblings slightly to allow SCHED_NORMAL tasks to run a small proportion of 
time when rt tasks are running on the sibling. The tricky part is that 
SCHED_FIFO tasks have no timeslice so we can't proportion cpu out according 
to the difference in size of the timeslices, which is currently how we 
proportion out cpu across siblings with SCHED_NORMAL, and this maintains cpu 
distribution very similarly to how 'nice' does on the same cpu.

Cheers,
Con
