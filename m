Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161426AbWHJQXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161426AbWHJQXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWHJQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:23:10 -0400
Received: from sd291.sivit.org ([194.146.225.122]:11269 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1161424AbWHJQXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:23:08 -0400
Subject: Re: [PATCH] memory ordering in __kfifo primitives
From: Stelian Pop <stelian@popies.net>
To: paulmck@us.ibm.com
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       open-iscsi@googlegroups.com, pradeep@us.ibm.com, mashirle@us.ibm.com
In-Reply-To: <20060810161129.GF1298@us.ibm.com>
References: <20060810001823.GA3026@us.ibm.com>
	 <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu>
	 <20060810134135.GB1298@us.ibm.com>
	 <1155220013.1108.4.camel@localhost.localdomain>
	 <20060810153915.GE1298@us.ibm.com>
	 <1155224842.5393.13.camel@localhost.localdomain>
	 <20060810161129.GF1298@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 10 Aug 2006 18:23:04 +0200
Message-Id: <1155226984.5393.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 10 août 2006 à 09:11 -0700, Paul E. McKenney a écrit :
> On Thu, Aug 10, 2006 at 05:47:22PM +0200, Stelian Pop wrote:
> > Le jeudi 10 août 2006 à 08:39 -0700, Paul E. McKenney a écrit :
> > > On Thu, Aug 10, 2006 at 04:26:53PM +0200, Stelian Pop wrote:
> > > > Le jeudi 10 août 2006 à 06:41 -0700, Paul E. McKenney a écrit :
> > > > 
> > > > > I am happy to go either way -- the patch with the memory barriers
> > > > > (which does have the side-effect of slowing down kfifo_get() and
> > > > > kfifo_put(), by the way), or a patch removing the comments saying
> > > > > that it is OK to invoke __kfifo_get() and __kfifo_put() without
> > > > > locking.
> > > > > 
> > > > > Any other thoughts on which is better?  (1) the memory barriers or
> > > > > (2) requiring the caller hold appropriate locks across calls to
> > > > > __kfifo_get() and __kfifo_put()?
> > > > 
> > > > If someone wants to use explicit locking, he/she can go with kfifo_get()
> > > > instead of the __ version.
> > > 
> > > However, the kfifo_get()/kfifo_put() interfaces use the internal lock,
> > 
> > ... and the internal lock can be supplied by the user at kfifo_alloc()
> > time.
> 
> Would that really work for them?  Looks to me like it would result
> in self-deadlock if they passed in session->lock.

Yeah, it will deadlock if the lock is already taken before calling
__kfifo_get and __kfifo_put.

> Or did you have something else in mind for them?

What I had in mind is to replace all occurences of:
	kfifo_alloc(..., NULL);
	...
	spin_lock(&session->lock)
	__kfifo_get()
	spin_unlock()

with the simpler:
	kfifo_alloc(..., &session->lock)
	...
	kfifo_get()

As for the occurences of:
	...
	spin_lock(&session->lock)
	do_something();
	__kifo_get();

well, there is not much we can do about them...

Let's take this problem differently: is a memory barrier cheaper than a
spinlock ? 

If the answer is yes as I suspect, why should the kfifo API force the
user to take a spinlock ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>

