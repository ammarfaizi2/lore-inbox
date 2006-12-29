Return-Path: <linux-kernel-owner+w=401wt.eu-S1755085AbWL2X0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbWL2X0Y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755086AbWL2X0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:26:24 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:53186
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbWL2X0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:26:23 -0500
Date: Fri, 29 Dec 2006 15:26:19 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14 slowdown compared to 2.6.19]
Message-ID: <20061229232618.GA11239@gnuppy.monkey.org>
References: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 04:51:21PM -0800, Chen, Tim C wrote:
> Ingo Molnar wrote:
> > If you'd like to profile this yourself then the lowest-cost way of
> > profiling lock contention on -rt is to use the yum kernel and run the
> > attached trace-it-lock-prof.c code on the box while your workload is
> > in 'steady state' (and is showing those extended idle times):
> > 
> >   ./trace-it-lock-prof > trace.txt
>
> Thanks for the pointer.  Will let you know of any relevant traces.

Tim,
	http://mmlinux.sourceforge.net/public/patch-2.6.20-rc2-rt2.lock_stat.patch

You can also apply this patch to get more precise statistics down to
the lock. For example:

...

	[50, 30, 279 :: 1, 0]		{tty_ldisc_try, -, 0}
	[5, 5, 0 :: 19, 0]		{alloc_super, fs/super.c, 76}
	[5, 5, 3 :: 1, 0]		{__free_pages_ok, -, 0}
	[5728, 862, 156 :: 2, 0]		{journal_init_common, fs/jbd/journal.c, 667}
	[594713, 79020, 4287 :: 60818, 0]		{inode_init_once, fs/inode.c, 193}
	[602, 0, 0 :: 1, 0]		{lru_cache_add_active, -, 0}
	[63, 5, 59 :: 1, 0]		{lookup_mnt, -, 0}
	[6425, 378, 103 :: 24, 0]		{initialize_tty_struct, drivers/char/tty_io.c, 3530}
	[6708, 1, 225 :: 1, 0]		{file_move, -, 0}
	[67, 8, 15 :: 1, 0]		{do_lookup, -, 0}
	[69, 0, 0 :: 1, 0]		{exit_mmap, -, 0}
	[7, 0, 0 :: 1, 0]		{uart_set_options, drivers/serial/serial_core.c, 1876}
	[76, 0, 0 :: 1, 0]		{get_zone_pcp, -, 0}
	[7777, 5, 9 :: 1, 0]		{as_work_handler, -, 0}
	[8689, 0, 0 :: 15, 0]		{create_workqueue_thread, kernel/workqueue.c, 474}
	[89, 7, 6 :: 195, 0]		{sighand_ctor, kernel/fork.c, 1474}
	@contention events = 1791177
	@found = 21

Is the output from /proc/lock_stat/contention. First column is the number
of contention that will results in a full block of the task, second is the
number of times the mutex owner is active on a per cpu run queue the
scheduler and third is the number of times Steve Rostedt's ownership handoff
code averted a full block. Peter Zijlstra used it initially during his
files_lock work.

Overhead of the patch is very low since it is only recording stuff in the
slow path of the rt-mutex implementation.

Writing to that file clears all of the stats for a fresh run with a
benchmark. This should give a precise point at which any contention would
happen in -rt. In general, -rt should do about as well as the stock kernel
minus the overhead of interrupt threads.

Since the last release, I've added checks for whether the task is running
as "current" on a run queue to see if adaptive spins would be useful in -rt.

These new stats show that only a small percentage of events would benefit
from the use of adaptive spins in front of a rt- mutex. Any implementation
of it would have little impact on the system. It's not the mechanism but
the raw MP work itself that contributes to the good MP performance of Linux.

Apply and have fun.

bill

