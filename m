Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269906AbUJMXTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269906AbUJMXTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbUJMXTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:19:05 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:35601 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S269906AbUJMXNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:13:38 -0400
Date: Wed, 13 Oct 2004 16:13:02 -0700
To: linux-kernel@vger.kernel.org
Cc: Sven Dietrich <sdietrich@mvista.com>, Thomas Gleixner <tglx@linutronix.de>,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, amakarov@ru.mvista.com,
       "La Monte H.P. Yarroll" <piggy@timesys.com>, ext-rt-dev@mvista.com
Subject: [ANNOUNCE] mmLinux (preemptable kernel for multimedia)
Message-ID: <20041013231302.GA9934@nietzsche.lynx.com>
References: <20041013230550.GA9855@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013230550.GA9855@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Try it again, this time to the correct linux-kernel address. :)]

This is a LynuxWorks project.

Project Page:
	http://mmlinux.sourceforge.net

Source tarball against 2.6.7-mm7:
	http://mmlinux.sourceforge.net/temp

mmLinux is a project that is dedicated to making Linux 2.6
series kernels fully preemptable. A short description of the
project's goals are on the web site itself, but the ultimate
target is to server multimedia applications under high
computational load without latency glitches using hard RT
features.

Code from this project is not meant for inclusion into the
Linux kernel.  

We use:

1)  Scott Wood's (TimeSys) patches for irq-threads.

2)  The stock rw/semaphore from Linux for all blocking
    synchronization including standard semaphore operations
    by overloading it using exclusive operation, not shared,
    via {down,up}_write with no priority inheritance.
    Priority inheritance is something that can be added later.

3) All {read,write,spin}_(bh,irq}{,save,restore), basically
    everything but plain read/write/spin locks, have been
    transformed to use (2) a type overloaded blocking semaphore.

    This has the advantage that a single locking primitive
    can be used for both priority inheritance and deadlock
    detection, which will simplify development of theses
    features into a single mutex primitive.

    Priority inheritance can be built on top of a the current
    include/linux/rwsem.h implementation by using simple
    priority borrowing at block points, specifically at
    read->write promotions or write->read demotions. The
    latter can simply apply the write threads's priority to
    all remaining readers to get basic late priority inheritance.
    In the case were there's is 1 reader and writer, it
    functions as a normal priority inheritance semaphore.
    We plan to do and implementation of this, but are open
    to using other mutex implementation through use of a
    simple series of #define substitutions.

The current code tree is used primarily as a testing harness
for overall kernel correctness and as a testing framework
for radical synchronization changes at this time. All future
work is dependent on a hard real time core.

Notes:
    This kernel boots as of 8/5/04, two months ago. With
    recent sleep violation fixes across the entire IO and
    file system layer, the kernel is stable under heavy
    load on specific with these fixes. This however
    outlines various structural problems with the Linux
    kernel itself and the lock reversions to fix sleeping
    violations can be used as a path for targetting various
    places where top-level locks in the lock graph must be
    transformed.

    These are:
	1) RCU and dcache_lock.
		This forces many locks, sb_lock and friends, back to
		being non-preemptable.

		Making RCU critical sections preemptable fixes this.

		Some per-CPU lock like (pseudo code):

		...

		DECLARE_PER_CPU_VAR(__per_cpu_preemption_mutex);

		void per_cpu_lock()
		{
			int cpu_id;

			task_lock(current);
			cpu_id = smp_processor_id();

			current->cpu_id_cpu_local;

			save_cpu_migration_state(); // in task_struct
			task_unlock(current);

			lock_mutex(per_cpu_var(__per_cpu_preemption_mutex[cpu_id]));
		}

		void per_cpu_unlock()
		{
			int cpu_id = current->cpu_id_cpu_local;
			unlock_mutex(per_cpu_var(__per_cpu_preemption_mutex[cpu_id]));

			task_lock(current);
			restore_cpu_migration_state(); // in task_struct
			task_unlock(current);
		}

		...

		"dcache_lock" effects all file systems. With this lock
		replaced, many file systems should be free of this
		dependency.


	2) local_bh_*.
		{spin,read,write}_bh use preempt_count() > 0. This
		effects things like the block IO layers, IO schedulers
		and down to the SCSI driver.

		If this lock is made preempt safe, then it would allow
		for all of the IO layer locking to substituted with
		blocking mutexes in place without any spinlock reversions.

		It might be good to use the per-CPU lock to convert
		local_bh*

	3) Various places that need to use mm_struct->page_lock_table.
		Think about this more...

    This runs under a dual processor machine with only a single CPU
    enabled on Adaptec SCSI controllers. SMP is an option for a later
    development cycle at this time.

    kgdb works with this system.

Future:
    Sync up with Ingo Molnar's tree and migrate whatever changes
    are needed to remove non-preemptable locks in the system. This
    is going to happen in days.

    [I've been talking to him about these issues and he's got a
    number of fixes that I'm wait on... per CPU locks specifically]

    Crazy, nutty, brain twisting stuff. :)

Other:
    [I expect this to be resolve within a few days. And I'm observing
    various parallel projects and have been suggesting things that
    need to be solved. I'll probably move/merge into either Ingo's
    or "Open Source Real-Time" projects tree. We'll see. ]

    More to come...
   
bill

