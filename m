Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUAUHI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 02:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAUHI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 02:08:58 -0500
Received: from [66.35.79.110] ([66.35.79.110]:19331 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261929AbUAUHI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 02:08:56 -0500
Date: Tue, 20 Jan 2004 23:08:44 -0800
From: Tim Hockin <thockin@hockin.org>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040121070844.GA31807@hockin.org>
References: <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com> <400DFC8B.7020906@cyberone.com.au> <20040121103933.B3236@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121103933.B3236@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:39:33AM +0530, Srivatsa Vaddagiri wrote:
> > *Before* that happens, tasks that don't handle the signal should just
> > have their affinity changed to all cpus.
> 
> Currently, handle or not handle the signal, affinity is changed
> to all cpus for tasks that are bound only to the dying CPU.

OK, so lets assume this scenarion:

process A affined to cpu1
all other processes affined to 0xffffffff
cpu1 goes down
 - process A affined to 0xffffffff
hotplug "cpu1 removed" event
cpu1 comes back
hotplug "cpu1 inserted" event

Process A has now discarded useful potentially VALUABLE information, with no
way to retrieve it.  The hot plug scripts do not have enough information to
put things the way they were before.  I can't believe that anyone considers
this to be OK.

Userspace gave us EXPLICIT instructions, which we then violate.  By granting
affinity, we have made a contract with userspace.  Changing affinity without
userspace's direct instruction is wrong.

What about this:

We already can not handle unexpected CPU removals gracefully, correct?  So
we expect some user-provided notification, right?

So force userland to handle it before we give the OK to remove a CPU.

pid_t sys_proc_offline(int cpu)
{
	pid_t p;

	/* flag cpu as not schedulale anymore */
	dont_add_tasks_to(cpu);

	p = find_first_unrunnable(cpu);
	if (p)
		return p;

	take_proc_offline(cpu);
	return 0;
}
 
The userspace control can then loop on this until it returns 0.  Each time
it return a pid, userspace must try to handle that pid - kill it, 
re-affine it, or provide some way to suspend it.

Simpler yet:

int sys_proc_offline(int cpu, int reaffine)
{
	pid_t p;

	/* flag cpu as not schedulale anymore */
	dont_add_tasks_to(cpu);

	while ((p = find_first_unrunnable(cpu))) {
		if (reaffine)
			reaffine(p);
		else
			make_unrunnable(p);
	}

	take_proc_offline(cpu);
	return 0;
}

Less flexible, but workable.  I prefer the first.  Yes it's racy, but the
worst case is that you receive a pid that you don't need to handle (died or
re-affined already).

Anything that violates affinity without permission just is so WRONG.
