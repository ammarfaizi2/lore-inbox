Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292826AbSBVHOZ>; Fri, 22 Feb 2002 02:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292827AbSBVHOP>; Fri, 22 Feb 2002 02:14:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37018 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292826AbSBVHOF>;
	Fri, 22 Feb 2002 02:14:05 -0500
Date: Fri, 22 Feb 2002 10:12:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Erich Focht <efocht@ess.nec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech <lse-tech@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.SGI.4.21.0202211313200.561412-100000@sam.engr.sgi.com>
Message-ID: <Pine.LNX.4.33.0202221003120.3674-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Feb 2002, Paul Jackson wrote:

> Could you, or some other kind soul who understands this, to explain
> why the following alternative for migrating proceses currently running
> on some other cpu wouldn't have been better (simpler and sufficient):
>
>     - add another variable to the task_struct, say "eviction_notice"
>     - when it comes time to tell a process to migrate, set this
> 	eviction_notice (and then continue without waiting)
>     - rely on code that fires each time slice on the cpu currently
>         hosting the evicted process to notice the eviction notice and
> 	serve it (migrate the process instead of giving it yet another
> 	slice).

well, how do you migrate the task from an IRQ context? This is the
fundamental question. A task can only be removed from the runqueue if it's
not running currently. (the only exception is schedule() itself.)

even if it worked, this adds a 1/(2*HZ) average latency to the migration.
I wanted to have something that is capable of migrating tasks 'instantly'.
(well, as 'instantly' as soon the migrated task can be preempted.) I also
wanted to have a set_cpus_allowed() interface that guarantees that the
task has migrated to the valid set.

i'm doing one more variation wrt. migration threads: instead of the
current method of waking up the target CPU's migration thread and 'kicking
off' the migrated task from its current CPU, it's much cleaner to do the
following:

 - every migration thread has maximum priority.
 - in set_cpus_allowed() we wake up the migration thread on the *source*
   CPU.
 - the migration thread preempts the migrated thread on the source CPU -
   and it can just remove the migrated task from the local runqueue. (if
   the task is still there at that point.)

this is even simpler and does not change p->state in any way.

	Ingo

