Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVCQQXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVCQQXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVCQQXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:23:46 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48341 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261942AbVCQQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:23:24 -0500
Date: Thu, 17 Mar 2005 11:23:01 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <1111074082.23171.8.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0503171108510.17696@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> 
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>  <20050315120053.GA4686@elte.hu>
  <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> 
 <20050315133540.GB4686@elte.hu>  <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
  <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> 
 <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org> 
 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org> 
 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain> 
 <20050316031909.08e6cab7.akpm@osdl.org>  <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
  <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain> 
 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain> 
 <1111000818.21369.8.camel@mindpipe>  <Pine.LNX.4.58.0503170210530.17019@localhost.localdomain>
 <1111074082.23171.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Mar 2005, Lee Revell wrote:

>
> Sorry, it's hard to follow this thread.  Just to make sure we're all on
> the same page, what exactly is the symptom of this ext3 issue you are
> working on?  Is it a performance regression, or a latency issue, or a
> lockup - ?
>
> Whatever your problem is, I am not seeing it.
>

The root is a lockup.  I think you can get this lockup whether or not it
is PREEMPT_RT or PREEPMT_DESKTOP.  All you need is CONFIG_PREEMPT turned
on. Then this is what you want to do on a UP Machine.

Set kjournald to FIFO (any realtime priority).  And then from a non-RT
task, just do a "make clean; make" on the kernel. It may take a few
minutes but your system will lock up.  That's because kjournal will wait
on the bit_spin_lock, but will never be preempted by the one holding the
lock, because it is FIFO and the one holding the lock (the kernel compile)
is not RT. Even if it was, and the same priority as kjournal, it would
still lock, since kjournal is FIFO and will only yield to higher
priority threads.

Now this lockup has uncovered other problems with ext3.  Mainly that it
uses bit spinlocks, which in of itself is bad.  You don't want a busy wait
unless you really need it.  A normal spinlock is such a thing in vanilla
SMP systems, since a schedule would take longer than the one holding the
lock. Ingo's RT kernel, removes most of these, and makes them into
mutexes.  This may slow down the overall performance but it shortens
latencies for RT tasks, which is what RT tries to do.

Now the latest problem is also bad, since you should never just call
schedule as a "yield" to let someone else release a lock.  Since the
ranking order of the locks prevents just grabbing the lock and then
risking a deadlock, ext3 tries to get the lock, and if it fails, it
releases the other lock it has, calls schedule, then tries again.  This is
usually bad, since it would most likely be rescheduled, so basically it is
worst than a spinlock, since it actually goes through the schedule logic
again and spins!  With Ingo's RT patch, this also becomes a deadlock
the same way as bit_spin_locks can.

Hope this helps,

-- Steve

