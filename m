Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVCVPKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVCVPKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCVPKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:10:19 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:34521 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261346AbVCVPJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:09:23 -0500
Date: Tue, 22 Mar 2005 16:08:44 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050322131016.GA2674@elte.hu>
Message-Id: <Pine.OSF.4.05.10503221557100.19869-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > > +static inline void rcu_read_lock(void)
> > > > +{	
> > > > +	preempt_disable(); 
> > > > +	__get_cpu_var(rcu_data).active_readers++;
> > > > +	preempt_enable();
> > > > +}
> > > 
> > > this is buggy. Nothing guarantees that we'll do the rcu_read_unlock() on
> > > the same CPU, and hence ->active_readers can get out of sync.
> > > 
> > 
> > Ok, this have to be handled in the mitigration code somehow. I have already 
> > added an 
> >   current->rcu_read_depth++
> > so it ought to be painless. A simple solution would be not to
> > mititagrate threads with rcu_read_depth!=0.
> 
> could you elaborate?
> 
Put an rcu_read_depth on each task. In rcu_read_lock() make a 
 current->rcu_read_depth++;
and visa versa in rcu_read_unlock(). In can_migrate_task() add
   if(p->rcu_read_depth)
         return 0;
That might do the trick.
 

> In any case, see the new PREEMPT_RCU code in the -40-07 patch (and
> upwards). I've also attached a separate patch, it should apply cleanly
> to 2.6.12-rc1.
> 

I barely have time to download at the patches - let alone applying them!

Anyway: I find one thing I don't like: using atomic_inc()/dec() in
rcu_read_lock()/unlock() to touch rcu_data which might be on another
CPU. Then rcu_data is not really per-CPU data anymore and it also hurts
performance of RCU readers.
I think it will be cheaper to use the above rcu_read_depth and then either
not migrate tasks at all or make the migrate code take care of migrating
the rcu_read_depth count to the new CPU - one would have to take care to
increment it in the rcu_data of the new CPU on the new CPU (it isn't
atomic) and then decrement it in the rcu_data of the old CPU on the old
CPU - in that order.


> 	Ingo
> 


Esben

