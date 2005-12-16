Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVLPFUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVLPFUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 00:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVLPFUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 00:20:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45469 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932130AbVLPFUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 00:20:53 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [RFC] Add thread_info flag for "no cpu migration"
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Dec 2005 16:20:41 +1100
Message-ID: <9019.1134710441@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thread below talks about disabling preemption in udelay() because
different cpus can have hardware clocks that move at different rates.

http://marc.theaimsgroup.com/?l=linux-ia64&m=113460274218885&w=2

preempt_disable() is overkill for this class of problem.  Code that
uses per cpu variables and/or hardware often only has the requirement
that it not be migrated off the current cpu, it can cope with
preemption as long as it gets scheduled back onto the same cpu.
Disabling preemption just to prevent cpu migration can introduce
additional preemption delays.

The normal way of pinning a task to a cpu is to use set_cpus_allowed(),
but that requires that the caller hold no locks and be running enabled.
Code such as udelay() can be called in any context, it may or may not
be runing atomic.

Could we add a TIF_ flag that says "no migration to another cpu"?  It
would be very light weight, functions cpu_migration_save(flags) and
cpu_migration_restore(flags) plus a couple of tests in the scheduler.

#define cpu_migration_save(flags) do { flags = test_and_set_thread_flag(TIF_NO_CPU_MIGRATION); } while(0)
#define cpu_migration_restore(flags) do { if (!flags) clear_thread_flag(TIF_NO_CPU_MIGRATION); } while(0)

Unlike set_cpus_allowed(), TIF_NO_CPU_MIGRATION can be set in any
context.  This makes it far more useful for lower level code, which may
be called with interrupts or preemption enabled or disabled.

I do not know enough about the scheduler to be completely sure of what
changes are required there, but at a quick glance -

set_cpus_allowed() returns -EBUSY if TIF_NO_CPU_MIGRATION is set and
the new mask does not include the current cpu.

can_migrate_task() returns 0 if TIF_NO_CPU_MIGRATION is set.

sched_fork() and sched_exec() BUG if TIF_NO_CPU_MIGRATION is set, it
makes no sense to fork/exec with migration disabled.  These are sanity
checks, and may not be absolutely required.

If this feature is added, some uses of get_cpu() could be redefined to
use cpu_migration_save(), further reducing the size of code that runs
with preempt disabled.

The debug version of smp_processor_id() would accept
TIF_NO_CPU_MIGRATION being set as one of the criteria for not
complaining.

