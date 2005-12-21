Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVLUBrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVLUBrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLUBrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:47:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29141 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932243AbVLUBrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:47:53 -0500
Date: Tue, 20 Dec 2005 17:47:47 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt22 (and mainline) excessive latency
Message-ID: <20051221014747.GB5741@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1135039244.28649.41.camel@mindpipe> <20051220042442.GA32039@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220042442.GA32039@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 05:24:42AM +0100, Ingo Molnar wrote:
> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I captured this 3+ ms latency trace when killing a process with a few 
> > thousand threads.  Can a cond_resched be added to this code path?
> 
> >     bash-17992 0.n.1   29us : eligible_child (do_wait)
> > 
> >     [ 3000+ of these deleted ]
> > 
> >     bash-17992 0.n.1 3296us : eligible_child (do_wait)
> 
> Atomicity of signal delivery is pretty much a must, so i'm not sure this 
> particular latency can be fixed, short of running PREEMPT_RT. Paul E.  
> McKenney is doing some excellent stuff by RCU-ifying the task lookup and 
> signal code, but i'm not sure whether it could cover do_wait().

Took a quick break from repeatedly shooting myself in the foot with
RCU read-side priority boosting (still have a few toes left) to take
a quick look at this.  The TASK_TRACED and TASK_STOPPED cases seem
non-trivial, and I am concerned about races with exit.

Any thoughts on whether the latency is due to contention on the
tasklist lock vs. the "goto repeat" in do_wait()?

						Thanx, Paul
