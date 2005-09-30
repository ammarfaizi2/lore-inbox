Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVI3AgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVI3AgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVI3AgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:36:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:55963 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932417AbVI3AgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:36:03 -0400
Date: Thu, 29 Sep 2005 17:36:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, Robert.Olsson@data.slu.se,
       davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930003642.GQ8177@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu> <20050930002346.GP8177@us.ibm.com> <20050930002719.GC21062@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930002719.GC21062@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 10:27:19AM +1000, Herbert Xu wrote:
> On Thu, Sep 29, 2005 at 05:23:46PM -0700, Paul E. McKenney wrote:
> > 
> > Is there any case where __in_dev_get() might be called without
> > needing to be wrapped with rcu_dereference()?  If so, then I
> > agree (FWIW, given my meagre knowledge of Linux networking).
> 
> Yes.  All paths that call __in_dev_get() under the rtnl do not
> need rcu_dereference (or any RCU at all) since the rtnl prevents
> any ip_ptr modification from occuring.
> 
> > However, rcu_dereference() only generates a memory barrier on DEC
> > Alpha, so there is normally no penalty for using it in the NULL-pointer
> > case.  So, when using rcu_dereference() unconditionally simplifies
> > the code, it may make sense to "just do it".
> 
> Here is what the code would look like:
> 
> 	rcu_read_lock();
> 	in_dev = dev->ip_ptr;
> 	if (in_dev) {
> 		in_dev = rcu_dereference(in_dev);
> 		atomic_inc(&in_dev->refcnt);
> 	}
> 	rcu_read_unlock();
> 	return in_dev;

How about:

	rcu_read_lock();
	in_dev = dev->ip_ptr;
	if (rcu_dereference(in_dev)) {
		atomic_inc(&in_dev->refcnt);
	}
	rcu_read_unlock();
	return in_dev;

Admittedly only saves one line, but...

							Thanx, Paul
