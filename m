Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVIMLnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVIMLnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVIMLnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:43:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63453 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932613AbVIMLnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:43:16 -0400
Date: Tue, 13 Sep 2005 13:42:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050912153135.3812d8e2.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0509131120020.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org> <20050912075155.3854b6e3.pj@sgi.com>
 <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Sep 2005, Paul Jackson wrote:

> There are two reasons a cpuset is accessed from within the
> allocation code.
>  1) Update the per-task mems_allowed if the current tasks cpuset
>     has changed its memory placement due to some other task
>     independently modifying that cpuset.
>  2) Walk up the cpuset hierarchy, starting from the tasks
>     cpuset, looking for a cpuset that is marked mem_exclusive,
>     and using the mems_allowed from that exclusive cpuset.

If I read the source correctly, a cpuset cannot be removed or moved while 
it's attached to a task, which makes it a lot simpler.

This means you have to take the second lock when accessing tsk->cpuset 
(you can basically replace task_lock()). Any allocator callback can now 
use the second lock to scan the cpusets. IOW as soon as count is different 
from zero, the cpuset is active and certain members become read-only. 
Activation/deactivation is controlled by the second lock.

You can BTW avoid locking in cpuset_exit() completely in the common case:

	tsk->cpuset = NULL;
	if (atomic_dec_and_test(&cs->count) && notify_on_release(cs)) {
		...
	}

Here you only need to release the reference, noone else should use that 
task anymore. You only have to check in attach_task() that you don't 
change a dead task.

There may be a subtle problem with cpuset_fork(), there is a window from 
dup_task_struct() until cpuset_fork(), where we have two pointers to a 
cpuset but only a single reference. Another process could now change the 
cpuset of the parent process to a different cpuset and the child process 
may end up with an invalid cpuset and I don't see how this protected. The 
only (simple) solution I see is to do this:

	lock();
	tsk->cpuset = current->cpuset;
	atomic_inc(&tsk->cpuset->count);
	unlock();

bye, Roman
