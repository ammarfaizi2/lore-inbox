Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTIADxg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 23:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbTIADxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 23:53:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49426
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262095AbTIADxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 23:53:34 -0400
Subject: Re: [SHED] Questions.
From: Robert Love <rml@tech9.net>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062374409.5171.194.camel@big.pomac.com>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
	 <1062359478.1313.9.camel@boobies.awol.org>
	 <1062369684.9959.166.camel@big.pomac.com>
	 <1062373274.1313.28.camel@boobies.awol.org>
	 <1062374409.5171.194.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1062389038.1313.39.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 00:03:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 20:00, Ian Kumlien wrote:

> Then i'm beginning to agree with the time unit... Large timeslice but in
> units for high pri tasks... So that high pri can run (if needed) 2 or 3
> times / timeslice.

Exactly.

> > This implies that a high priority, which has exhausted its timeslice,
> > will not be allowed to run again until _all_ other runnable tasks
> > exhaust their timeslice (this ignores the reinsertion into the active
> > array of interactive tasks, but that is an optimization that just
> > complicates this discussion).
> 
> So it's penalised by being in the corner for one go? or just pri
> penalised (sounds like it could get a corner from what you wrote... Or
> is it time for bed).

Not penalized... all tasks go through the same thing.

Look at it like this.  Assume we have:

	Task A, B, and C at priority 10 (the highest)
	Task D at priority 5
	Tasks E and F at priority 0 (the lowest)

We run them in that order: A, B, C, D, E, then F.  And repeat. 
(Actually, within a given priority, the tasks are run round-robin in any
nonspecific order.. effectively first-come, first-served scheduling).

If [any task] has exhausted its timeslice, it will not run until the
remaining tasks exhaust their timeslice.  Once all tasks have expired,
we start over.

So the total scheduling routine tasks the sum of the timeslices of tasks
A,B,C,D,E,F.  And only when they are all 100% CPU bound.

> Yes, but how many runable tasks would you have on a system in one go,
> while maintaining interactivity...
> (Ie, what amount would the scheduler actually have to deal with..)

Most systems only have a handful (1-2) running tasks that are actually
running.

For example:

	$ ps aux|awk '{print $8}'|grep R|wc -l
	     4
	$ ps aux|wc -l
	     87

But Unix is designed for timesharing among many interactive tasks.  It
works.  The problem faced today in 2.6 is juggling throughput versus
latency in the scheduler, with the interactivity estimator.

	Robert Love


