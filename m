Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTERXFx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTERXFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:05:53 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40122
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262263AbTERXFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:05:49 -0400
Date: Mon, 19 May 2003 01:18:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Schwartz <davids@webmaster.com>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030518231825.GG1429@dualathlon.random>
References: <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net> <MDEHLPKNGKAHNMBLJOLKEEPADAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEPADAAA.davids@webmaster.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 10:46:24AM -0700, David Schwartz wrote:
> 
> > Is there any down-side to not preempting quite as often?  It seems like
> > there should be a bandwidth gain.
> >
> >          -Mike
> 
> 	The theoretical down-side is that interactivity might suffer a bit because
> a process isn't scheduled quite as quickly. Yes, the less-often you preempt
> a process, the faster the system will go in the sense of work done per unit
> time. But those pesky users want their characters to echo quickly and the
> mouse pointer to track their physical motions.
> 
> 	Obviously, we must preempt when a process with a higher static priority

the static priority is the same for all tasks in the system unless you
use nice. I believe linux should do well without forcing the user to set
the GUI at high prio etc..

> becomes ready to run. However, preempting based on dynamic priorities
> has
> permitted time slices to be even longer, permitting a reduction in context

the dyn prio doesn't change the timeslice size, it only chooses if to
wakeup a task immediatly or not, timeslices are calculated in function
of the static priority, not the dyn prio. Those interactive tasks uses
nearly zero of their timeslice anyways, the size of the timeslice has
little meaning for interactive tasks, what matters is "when" they run
and that's controlled by the dyn prio.

> switches without sacrificing interactivity.
> 
> 	I still believe, however, that a process should be 'guaranteed' some slice
> of time every time it's scheduled unless circumstances make it impossible to
> allow the process to continue running. IMO, the pendulum has swung too far
> in favor of interactivity. Obviously, if the process faults, blocks, or a
> process with higher static priority becomes ready to run, then we must

if the static priority is much higher the immediate switch already
happens. But if we choose to guarantee a min_timeslice to tasks to avoid
the ctx switch flood for your testcase, then also the higher static prio
tasks will have to wait for this min_timeslice. The issue is no
different with higher static prio, or you will complain next time that
you get a ctx switch flood from a dd bs=1 writing into a pty connected
to an xterm running at -20 prio.

> terminate the process' time slice early.
> 
> 	DS
> 
> 


Andrea
