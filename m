Return-Path: <linux-kernel-owner+w=401wt.eu-S1753990AbWLRNUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbWLRNUl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbWLRNUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:20:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:38242 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbWLRNUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:20:40 -0500
Subject: Re: Task watchers v2
From: Matt Helsley <matthltc@us.ibm.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>,
       systemtap@sources.redhat.com
In-Reply-To: <1166420641.15989.117.camel@ymzhang>
References: <20061215000754.764718000@us.ibm.com>
	 <20061215000817.771088000@us.ibm.com>  <1166420641.15989.117.camel@ymzhang>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Mon, 18 Dec 2006 05:18:21 -0800
Message-Id: <1166447901.995.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 13:44 +0800, Zhang, Yanmin wrote:
> On Thu, 2006-12-14 at 16:07 -0800, Matt Helsley wrote:
> > plain text document attachment (task-watchers-v2)
> > Associate function calls with significant events in a task's lifetime much like
> > we handle kernel and module init/exit functions. This creates a table for each
> > of the following events in the task_watchers_table ELF section:
> >
> > WATCH_TASK_INIT at the beginning of a fork/clone system call when the
> > new task struct first becomes available.
> >
> > WATCH_TASK_CLONE just before returning successfully from a fork/clone.
> >
> > WATCH_TASK_EXEC just before successfully returning from the exec
> > system call.
> >
> > WATCH_TASK_UID every time a task's real or effective user id changes.
> >
> > WATCH_TASK_GID every time a task's real or effective group id changes.
> >
> > WATCH_TASK_EXIT at the beginning of do_exit when a task is exiting
> > for any reason.
> >
> > WATCH_TASK_FREE is called before critical task structures like
> > the mm_struct become inaccessible and the task is subsequently freed.
> >
> > The next patch will add a debugfs interface for measuring fork and exit rates
> > which can be used to calculate the overhead of the task watcher infrastructure.
> >
> > Subsequent patches will make use of task watchers to simplify fork, exit,
> > and many of the system calls that set [er][ug]ids.
> It's easier to get such watch capabilities by kprobe/systemtap. Why to
> add new codes to kernel?

Good question! Disclaimer: Everything I know about kprobes I learned
from Documentation/kprobes.txt

The task watchers patches have a few distinguishing capabilities yet
lack capabilities important for kprobes -- so neither is a replacement
for the other. Specifically:

- Task watchers are for use by the kernel for more than profiling and
debugging. They need to work even when kernel debugging and
instrumentation are disabled.

- Task watchers do not need to be dynamically enabled, disabled, or
removed (though dynamic insertion would be nice -- I'm working on that).
In fact I've been told that dynamically enabling, disabling, or removing
them would incur unacceptable complexity and/or cost for an
uninstrumented kernel.

- Task watchers don't require arch support. They use completely generic
code.
	- Since they are written into the code task watchers don't need
	  to modify instructions.

	- Task watchers doesn't need to single-step an instruction

	- Task watchers don't need to know about arch registers, calling
	  conventions, etc. to work

- Task watchers don't need to have the same (possibly extensive)
argument list as the function being "probed". This makes maintenance
easier -- no need to keep the signature of the watchers in synch with
the signature of the "probed" function.

- Task watchers don't require MODULES (2.6.20-rc1-mm1's
arch/i386/Kconfig suggests this is true of kprobes).

- Task watchers don't need kernel symbols.

- Task watchers can affect flow control (see the patch hunks that change
copy_process()) with their return value.

- Task watchers do not need to know the instruction address to be
"probed".

- Task watchers can actually improve kernel performance slightly (up to
2% in extremely fork-heavy workloads for instance).

- Task watchers require local variables -- not necessarily arguments to
the "probed" function.

- Task watchers don't care if preemption is enabled or disabled.

- Task watchers could sleep if they want to.

	So to the best of my knowledge kprobes isn't a replacement for task
watchers nor is task watchers capable of replacing kprobes.

Cheers,
	-Matt Helsley

