Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWGGXOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWGGXOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWGGXOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:14:49 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:40365 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932373AbWGGXOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:14:49 -0400
Date: Fri, 7 Jul 2006 16:15:24 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: mingo@elte.hu, oleg@tv-sign.ru, linux-kernel@vger.kernel.org,
       dino@us.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH -rt] catch put_task_struct RCU handling up to mainline
Message-ID: <20060707231524.GI1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060707192955.GA2219@us.ibm.com> <Pine.LNX.4.64.0607072352390.12372@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607072352390.12372@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 11:56:00PM +0100, Esben Nielsen wrote:
> On Fri, 7 Jul 2006, Paul E. McKenney wrote:
> 
> >Hello!
> >
> >Due to the separate -rt and mainline evolution of RCU signal handling,
> >the -rt patchset now makes each task struct go through two RCU grace
> >periods, with one call_rcu() in release_task() and with another
> >in put_task_struct().  Only the call_rcu() in release_task() is
> >required, since this is the one that is associated with tearing down
> >the task structure.
> >
> >This patch removes the extra call_rcu() in put_task_struct(), synching
> >this up with mainline.  Tested lightly on i386.
> >
> 
> The extra call_rcu() has an advantage:
> It defers work away from the task doing the last put_task_struct().
> It could be a priority 99 task with hard latency requirements doing 
> some PI boosting, forinstance. The extra call_rcu() defers non-RT work to 
> a low priority task. This is in generally a very good idea in a real-time 
> system.
> So unless you can argue that the work defered is as small as the work of 
> doing a call_rcu() I would prefer the extra call_rcu().

I would instead argue that the only way that the last put_task_struct()
is an unrelated high-priority task is if it manipulating an already-exited
task.  In particular, I believe that the sys_exit() path prohibits your
example of priority-boosting an already-exited task by removing the
exiting task from the various lists before doing the release_task()
on itself.

Please let me know what I am missing here!

							Thanx, Paul
