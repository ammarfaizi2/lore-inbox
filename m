Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVCVKUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVCVKUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVCVKUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:20:39 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:52122 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262605AbVCVKUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:20:25 -0500
Date: Tue, 22 Mar 2005 11:19:58 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050322092032.GA20240@elte.hu>
Message-Id: <Pine.OSF.4.05.10503221102200.25802-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > On the other hand with a rw-lock being unlimited - and thus do not
> > keep track of it readers - the readers can't be boosted by the writer.
> > Then you are back to square 1: The grace period can take a very long
> > time.
> 
> btw., is the 'very long grace period' a real issue? We could avoid all
> the RCU read-side locking latencies by making it truly unlocked and just
> living with the long grace periods. Perhaps it's enough to add an
> emergency mechanism to the OOM handler, which frees up all the 'blocked
> by preemption' RCU callbacks via some scheduler magic. (e.g. such an
> emergency mechanism could be _conditional_ locking on the read side -
> i.e. new RCU read-side users would be blocked until the OOM situation
> goes away, or something like that.)

You wont catch RCU read-sides already entered - see below.

> 
> your patch is implementing just that, correct? Would you mind redoing it
> against a recent -RT base? (-40-04 or so)
>

In fact I am working on clean 2.6.12-rc1 right now. I figured this is
orthorgonal to the rest RT patch and can probably go upstream immediately.
Seemed to work. I'll try to make into a clean patch soonish and also try
it on -40-04. 
I am trying to make a boosting mechanism in the scheduler such that RCU
readers are boosted to MAX_RT_PRIO when preempted. I have to take it out
first.

Any specific tests I have to run? I am considering making an RCU test
device.

> also, what would be the worst-case workload causing long grace periods?

A nice 19 task, A, enter an RCU region and is preempted. A lot of other
tasks starts running. Then task A might starved for _minuttes_ such that
there is no RCU-grace periods in all that time.

> 
> 	Ingo

Esben

