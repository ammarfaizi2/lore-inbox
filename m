Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUATIhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUATIhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:37:20 -0500
Received: from [66.35.79.110] ([66.35.79.110]:38058 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265264AbUATIhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:37:09 -0500
Date: Tue, 20 Jan 2004 00:37:01 -0800
From: Tim Hockin <thockin@hockin.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: vatsa@in.ibm.com, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120083700.GB15733@hockin.org>
References: <20040120063316.GA9736@hockin.org> <20040120082232.ED1282C2ED@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120082232.ED1282C2ED@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 06:45:41PM +1100, Rusty Russell wrote:
> In message <20040120063316.GA9736@hockin.org> you write:
> > I added a new TASK_UNRUNNABLE state for these tasks, too.  By adding the
> > task's current (or most recent) CPU and the task's cpus_allowed and
> > cpus_allowed_mask to /proc/pid/status, we gave simple tools for finding
> > these unrunnable tasks.
> > 
> > I think the sanest thing for a CPU removal is to migrate everything off the
> > processor in question, move unrunnable tasks into TASK_UNRUNNABLE state,
> > then notify /sbin/hotplug.  The hotplug script can then find and handle the
> > unrunnable tasks.  No SIGPWR grossness needed.
> 
> Interesting.
> 
> The downside is that you now need some script needs to know what to do
> with the tasks (unless you have something like DBUS, but that's a ways

Well, if we provide a sane example script, the rest is up to the distros or
the people with this hardware to decide.

> off).  There are no correctness concerns AFAICT with userspace not
> being on a particular CPU, just performance.

Correctness does matter if an affined task violates that affinity.  If we
are going to provide explicit affinity, we need to honor it under all
conditions, or at least provide an option to honor it.

> The SIGPWR solution lets a random process deal appropriately without
> having to interface with /sbin/hotplug, if it wants to.  And it's a
> lot less invasive.

I agree about invasiveness.  Maybe a combo?  Send SIGPWR iff a task is
actually handling it, otherwise mark it TASK_UNRUNNABLE and let hotplug
handle it?  A new signal would be much more polite, but SIGPWR can be made
to work.  What if a process catches SIGPWR, but does not handle CPU removal?
Do we wait for it's signal handler to finish before re-evaluating it for
TASK_UNRUNNABLE?  Yuck.  If a CPU gets yanked with no warning, where do we
run the signal handler?  Violating affinity again.

Tim
