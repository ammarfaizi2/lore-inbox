Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161447AbWHJQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161447AbWHJQrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161423AbWHJQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:47:13 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:65193 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161447AbWHJQrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:47:10 -0400
Date: Thu, 10 Aug 2006 09:47:52 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Stelian Pop <stelian@popies.net>
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       open-iscsi@googlegroups.com, pradeep@us.ibm.com, mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810164752.GG1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060810001823.GA3026@us.ibm.com> <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu> <20060810134135.GB1298@us.ibm.com> <1155220013.1108.4.camel@localhost.localdomain> <20060810153915.GE1298@us.ibm.com> <1155224842.5393.13.camel@localhost.localdomain> <20060810161129.GF1298@us.ibm.com> <1155226984.5393.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155226984.5393.26.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 06:23:04PM +0200, Stelian Pop wrote:
> Le jeudi 10 août 2006 à 09:11 -0700, Paul E. McKenney a écrit :
> > On Thu, Aug 10, 2006 at 05:47:22PM +0200, Stelian Pop wrote:
> > > Le jeudi 10 août 2006 à 08:39 -0700, Paul E. McKenney a écrit :
> > > > On Thu, Aug 10, 2006 at 04:26:53PM +0200, Stelian Pop wrote:
> > > > > Le jeudi 10 août 2006 à 06:41 -0700, Paul E. McKenney a écrit :
> > > > > 
> > > > > > I am happy to go either way -- the patch with the memory barriers
> > > > > > (which does have the side-effect of slowing down kfifo_get() and
> > > > > > kfifo_put(), by the way), or a patch removing the comments saying
> > > > > > that it is OK to invoke __kfifo_get() and __kfifo_put() without
> > > > > > locking.
> > > > > > 
> > > > > > Any other thoughts on which is better?  (1) the memory barriers or
> > > > > > (2) requiring the caller hold appropriate locks across calls to
> > > > > > __kfifo_get() and __kfifo_put()?
> > > > > 
> > > > > If someone wants to use explicit locking, he/she can go with kfifo_get()
> > > > > instead of the __ version.
> > > > 
> > > > However, the kfifo_get()/kfifo_put() interfaces use the internal lock,
> > > 
> > > ... and the internal lock can be supplied by the user at kfifo_alloc()
> > > time.
> > 
> > Would that really work for them?  Looks to me like it would result
> > in self-deadlock if they passed in session->lock.
> 
> Yeah, it will deadlock if the lock is already taken before calling
> __kfifo_get and __kfifo_put.
> 
> > Or did you have something else in mind for them?
> 
> What I had in mind is to replace all occurences of:
> 	kfifo_alloc(..., NULL);
> 	...
> 	spin_lock(&session->lock)
> 	__kfifo_get()
> 	spin_unlock()
> 
> with the simpler:
> 	kfifo_alloc(..., &session->lock)
> 	...
> 	kfifo_get()

Fair enough!

> As for the occurences of:
> 	...
> 	spin_lock(&session->lock)
> 	do_something();
> 	__kifo_get();
> 
> well, there is not much we can do about them...

Agreed!

> Let's take this problem differently: is a memory barrier cheaper than a
> spinlock ? 

Almost always, yes.  But a spinlock is cheaper than a spinlock plus
a pair of memory barriers.

> If the answer is yes as I suspect, why should the kfifo API force the
> user to take a spinlock ?

My concern is that currently a majority of the calls to __kfifo_{get,put}()
are already holding a spinlock.

But if you could send me your tests for lock-free __kfifo_{get,put}(),
I would be happy to run them on weak-memory-consistency model machines
with the memory barriers.  And without the memory barriers -- we need
a test that fails in the latter case to prove that the memory barriers
really are in the right place and that all of them are present.

Does this sound reasonable?

						Thanx, Paul
