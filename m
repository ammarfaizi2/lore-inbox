Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVJRQV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVJRQV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 12:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVJRQV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 12:21:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:37833 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750953AbVJRQVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 12:21:55 -0400
Date: Tue, 18 Oct 2005 09:22:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: dipankar@in.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051018162222.GA1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <20051017225925.GB1298@us.ibm.com> <4354C476.40901@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4354C476.40901@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 11:46:30AM +0200, Eric Dumazet wrote:
> Paul E. McKenney a écrit :
> >
> >
> >>+/*
> >>+ *  Should we directly call rcu_do_batch() here ?
> >>+ *  if (unlikely(rdp->count > 10000))
> >>+ *      rcu_do_batch(rdp);
> >>+ */
> >
> >
> >Good thing that the above is commented out!  ;-)
> >
> >Doing this can result in self-deadlock, for example with the following:
> >
> >	spin_lock(&mylock);
> >	/* do some stuff. */
> >	call_rcu(&p->rcu_head, my_rcu_callback);
> >	/* do some more stuff. */
> >	spin_unlock(&mylock);
> >
> >void my_rcu_callback(struct rcu_head *p)
> >{
> >	spin_lock(&mylock);
> >	/* self-deadlock via call_rcu() via rcu_do_batch()!!! */
> >	spin_unlock(&mylock);
> >}
> >
> >
> >						Thanx, Paul
> 
> Thanks Paul for reminding us that call_rcu() should not ever call the 
> callback function, as very well documented in Documentation/RCU/UP.txt
> (Example 3: Death by Deadlock)
> 
> But is the same true for call_rcu_bh() ?

Yes, same rules for this aspect of call_rcu_bh() and call_rcu().

> I intentionally wrote the comment to remind readers that a low maxbatch can 
> trigger OOM in case a CPU is filled by some kind of DOS (network IRQ flood 
> for example, targeting the IP dst cache)
> 
> To solve this problem, may be we could add a requirement to 
> call_rcu_bh/callback functions  : If they have to lock a spinlock, only use 
> a spin_trylock() and make them returns a status (0 : sucessfull callback, 
> 1: please requeue me)
> 
> As most callback functions just kfree() some memory, most of OOM would be 
> cleared.
> 
> int my_rcu_callback(struct rcu_head *p)
> {
> 	if (!spin_trylock(&mylock))
> 		return 1; /* please call me later */
> 	/* do something here */
> 	...
> 	spin_unlock(&mylock);
> 	return 0;
> }
> 
> (Changes to rcu_do_batch() are left as an exercice :) )

Another approach that would keep the current easier-to-use semantics
would be to schedule a tasklet or workqueue to process the callbacks
in a safe context.

						Thanx, Paul
