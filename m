Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbTESCqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 22:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTESCqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 22:46:12 -0400
Received: from mail.webmaster.com ([216.152.64.131]:31430 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262313AbTESCqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 22:46:10 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Mike Galbraith" <efault@gmx.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Scheduling problem with 2.4?
Date: Sun, 18 May 2003 19:59:04 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEBNDBAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030518231825.GG1429@dualathlon.random>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	Obviously, we must preempt when a process with a higher
> > static priority

> the static priority is the same for all tasks in the system unless you
> use nice. I believe linux should do well without forcing the user to set
> the GUI at high prio etc..

	Exactly. Pre-emption based on dynamic priorities is an "if it helps"
feature and not one required by the semantics. On the other hand,
pre-emption based on static priorities is pretty much required and not doing
that would certainly violate the principle of least astonishment.

> > becomes ready to run. However, preempting based on dynamic priorities
> > has
> > permitted time slices to be even longer, permitting a reduction
> > in context

> the dyn prio doesn't change the timeslice size, it only chooses if to
> wakeup a task immediatly or not, timeslices are calculated in function
> of the static priority, not the dyn prio. Those interactive tasks uses
> nearly zero of their timeslice anyways, the size of the timeslice has
> little meaning for interactive tasks, what matters is "when" they run
> and that's controlled by the dyn prio.

	You say "the dyn prio doesn't change the timeslice size", but that's not
true. If a process with low dynamic priority writes to a FIFO, its timeslice
will be cut short, whereas one with a higher dynamic priorit would enjoy a
longer timeslice. Yes, priority doesn't affect the *intended* timeslice, but
it can affect the effective timeslice.

> > 	I still believe, however, that a process should be
> > 'guaranteed' some slice
> > of time every time it's scheduled unless circumstances make it
> > impossible to
> > allow the process to continue running. IMO, the pendulum has
> > swung too far
> > in favor of interactivity. Obviously, if the process faults,
> > blocks, or a
> > process with higher static priority becomes ready to run, then we must

> if the static priority is much higher the immediate switch already
> happens.

	As it certainly should. The maximum amount of time we could justify
delaying a task with a higher static priority in the name of better 'bulk
data' performance is so small that it's probably not feasible to do it at
all.

> But if we choose to guarantee a min_timeslice to tasks to avoid
> the ctx switch flood for your testcase, then also the higher static prio
> tasks will have to wait for this min_timeslice.

	No. I don't think that's appropriate. Higher statis priority is an explicit
decision made by users for the specific reason of getting the faster
response. Under no circumstances should an NTP process that received a UDP
packet be prevented from getting that packet as quickly as possible.

> The issue is no
> different with higher static prio, or you will complain next time that
> you get a ctx switch flood from a dd bs=1 writing into a pty connected
> to an xterm running at -20 prio.

	With static priorities, you can always tell people "Don't do that then, you
got what you asked for. The system doesn't know what you 'really want'."
With dynamic priorities, however, this is not the case.

	I'm not sure what the best solution is. But I think it's along the lines of
deferring a deschedule based purely on dynamic priorities if the task has
used only a small fraction of its timeslice. Perhaps, for example, a normal
timeslice should be four jiffies. If a reschule would normally occur during
the first jiffy, and it's based purely on dynamic priorities, we set a flag
which we check when the first jiffy ends.

	Now maybe in some cases where the static priorities only differ slightly,
we should defer even based on static priorities. Perhaps immediate
pre-emption during the beginning of a timeslice should only occur when the
winning process has an elevated priority (and not just because the losing
process has a reduced one).

	I don't really know. But I think what we're doing now is fundamentally
wrong because processes should be allowed to use up their timeslices when
possible.

	DS


