Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265383AbSJRWot>; Fri, 18 Oct 2002 18:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265384AbSJRWot>; Fri, 18 Oct 2002 18:44:49 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:15593 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265383AbSJRWor>;
	Fri, 18 Oct 2002 18:44:47 -0400
Date: Fri, 18 Oct 2002 15:50:46 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: how to force a task out in SMP?
Message-ID: <20021018155046.H30560@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am developing a kernel performance monitoring (perfmon) subsystem in 
Linux/ia64 and I need to access the perfmon state of another task that
is *possibly* running at the same time in a SMP configurations. Unlike 
debuggers, I don't want to change the behavior of the task. For instance, 
if it was blocked, then it must stay blocked, i.e., no EINTR.

I have looked in the lkml archives and found that some people have had
to deal with the same problem when trying to dump core in a multithreaded
applications. While their goal is different, what they need is similar.

What we want: "a mechanism to force a task out of the CPU, if it is running,
which also ensures that it will not be scheduled again  until we tell
it to do so". 

There has been several iterations of the multithreaded core dump patch, 
some for 2.4 and some for 2.5. They used the following techniques:

For 2.4:
	1/ cpus_allowed

	stop   : force task->cpus_allowed=0, task->need_resched=1 and force a 
	         reschedule. Then wait until task leaves cpu. 
	restart: restablish a good task->cpus_allowed and force a resched.

For 2.5 several versions exist:

	1/ SIGSTOP/SIGCONT

	stop   : send SIGSTOP to the other task, wait until it leaves the CPU
	restart: send SIGCONT.

	2/ Phantom runqueue

	add a runqueue not associated with any CPU (NR_CPUS+1).
	stop   : move task to phantom runqueue
	restart: move back to valid queue.
	

The cpus_allowed is clearly a hack which is not possible in 2.5 (see
set_cpus_allowed()).

The SIGSTOP/SIGCONT technique is not that good because it is visible to the
program and possibly others. For instance, your shell gets notified if the
task is stopped (if was launched from it). Then the job control gets confused.

The shadow runqueue seems interesting but I am wondering if it could not be
implemented with no extra queue. All that is needed is to get the task out 
of the queue it is on and then put it back into a queue when we're done. 
I am no expert in the scheduler code but it seems to have internal routines
to do just that (deactivate_task() and activate_task()). I wonder if those
could be used (if made visible outside of sched.c), however I can believe
that they are called in a specific context and that it may be difficult to
export them.

My question is then what is the right way of implementing this in 2.5?

Thanks.

-- 
-Stephane
