Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVI3BP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVI3BP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVI3BP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:15:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38617 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751274AbVI3BP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:15:27 -0400
Date: Thu, 29 Sep 2005 18:16:03 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, Robert.Olsson@data.slu.se,
       davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930011603.GT8177@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu> <20050930002346.GP8177@us.ibm.com> <20050930002719.GC21062@gondor.apana.org.au> <20050930003642.GQ8177@us.ibm.com> <20050930010404.GA21429@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930010404.GA21429@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 11:04:04AM +1000, Herbert Xu wrote:
> On Thu, Sep 29, 2005 at 05:36:42PM -0700, Paul E. McKenney wrote:
> >
> > > 	rcu_read_lock();
> > > 	in_dev = dev->ip_ptr;
> > > 	if (in_dev) {
> > > 		in_dev = rcu_dereference(in_dev);
> > > 		atomic_inc(&in_dev->refcnt);
> > > 	}
> > > 	rcu_read_unlock();
> > > 	return in_dev;
> > 
> > How about:
> > 
> > 	rcu_read_lock();
> > 	in_dev = dev->ip_ptr;
> > 	if (rcu_dereference(in_dev)) {
> > 		atomic_inc(&in_dev->refcnt);
> > 	}
> > 	rcu_read_unlock();
> > 	return in_dev;
> 
> With this the barrier will taken even when in_dev is NULL.
> 
> I agree this isn't such a big deal since it only impacts Alpha and then
> only when in_dev is NULL.  But as we already do the branch anyway to
> increment the reference count, we might as well make things a little
> better for Alpha.

OK, how about this instead?

	rcu_read_lock();
	in_dev = dev->ip_ptr;
	if (in_dev) {
		atomic_inc(&rcu_dereference(in_dev)->refcnt);
	}
	rcu_read_unlock();
	return in_dev;

						Thanx, Paul
