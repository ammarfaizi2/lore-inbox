Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUATGdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUATGdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:33:40 -0500
Received: from [66.35.79.110] ([66.35.79.110]:64937 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265211AbUATGdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:33:39 -0500
Date: Mon, 19 Jan 2004 22:33:16 -0800
From: Tim Hockin <thockin@hockin.org>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: vatsa@in.ibm.com, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120063316.GA9736@hockin.org>
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120060027.91CC717DE5@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 04:44:45PM +1100, Rusty Russell wrote:
> The other issue I wanted to revisit: we currently send SIGPWR to all
> processes which we have to undo the CPU affinity for (with a new
> si_info field containing the cpu going down).
> 
> The main problem is that a process can call sched_setaffinity on
> another (unrelated) task, which might not know about it.  One option
> would be to only deliver the signal if it's not SIG_DFL for that
> process.  Another would be not to signal, and expect hotplug scripts
> to clean up.

I had to deal with this in my procstate patch (was against RH 2.4 with O(1)
sched but not 2.6).  What I chose to do (and what the people who were
wanting the code wanted) was to move tasks which had no CPU to run upon onto
an unrunnable list.  Whenever a CPU's state is changed, scan the list.
Whenevr a task's affinity mask is changed, check if it needs to go onto or
come off of the unrunnable_list.

I added a new TASK_UNRUNNABLE state for these tasks, too.  By adding the
task's current (or most recent) CPU and the task's cpus_allowed and
cpus_allowed_mask to /proc/pid/status, we gave simple tools for finding
these unrunnable tasks.

I think the sanest thing for a CPU removal is to migrate everything off the
processor in question, move unrunnable tasks into TASK_UNRUNNABLE state,
then notify /sbin/hotplug.  The hotplug script can then find and handle the
unrunnable tasks.  No SIGPWR grossness needed.

Code against 2.4 at http://www.hockin.org/~thockin/procstate - it was
heavily tested and I *think* it is all correct (for that kernel snapshot).

Tim
