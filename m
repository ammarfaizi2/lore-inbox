Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVI3AXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVI3AXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVI3AXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:23:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:27324 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932404AbVI3AXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:23:07 -0400
Date: Thu, 29 Sep 2005 17:23:46 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: herbert@gondor.apana.org.au, Robert.Olsson@data.slu.se,
       davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050930002346.GP8177@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509292330.j8TNUSmH019572@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:30:28PM -0700, Suzanne Wood wrote:
> > Date: Fri, 30 Sep 2005 07:28:36 +1000
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> > On Thu, Sep 29, 2005 at 09:02:29AM -0700, Suzanne Wood wrote:
> > > 
> > > The exchange below suggests that it is equally important 
> > > to have the rcu_dereference() in __in_dev_get(), so the 
> > > idea of the only difference between in_dev_get and 
> > > __in_dev_get being the refcnt may be accepted.
> 
> > With __in_dev_get() it's the caller's responsibility to ensure
> > that RCU works correctly.  Therefore if any rcu_dereference is
> > needed it should be done by the caller.
> 
> This sounds reasonable to me.  Does everyone agree? 

Is there any case where __in_dev_get() might be called without
needing to be wrapped with rcu_dereference()?  If so, then I
agree (FWIW, given my meagre knowledge of Linux networking).

If all __in_dev_get() invocations need to be wrapped in
rcu_dereference(), then it seems to me that there would be
motivation to bury rcu_dereference() in __in_dev_get().

> > Some callers of __in_dev_get() don't need rcu_dereference at all
> > because they're protected by the rtnl.
> 
> > BTW, could you please move the rcu_dereference in in_dev_get()
> > into the if clause? The barrier is not needed when ip_ptr is
> > NULL.
> 
> The trouble with that may be that there are three events, the
> dereference, the assignment, and the conditional test.  The
> rcu_dereference() is meant to assure deferred destruction
> throughout.

One only needs an rcu_dereference() once on the data-flow path from
fetching the RCU-protected pointer to dereferencing that pointer.
If the pointer is NULL, there is no way you can dereference it,
so, technically, Herbert is quite correct.

However, rcu_dereference() only generates a memory barrier on DEC
Alpha, so there is normally no penalty for using it in the NULL-pointer
case.  So, when using rcu_dereference() unconditionally simplifies
the code, it may make sense to "just do it".

							Thanx, Paul
