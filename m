Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVGNQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVGNQgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVGNQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:36:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45293 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261575AbVGNQf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:35:26 -0400
Date: Thu, 14 Jul 2005 08:44:50 -0500
From: serue@us.ibm.com
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David A. Wheeler" <dwheeler@ida.org>, Tony Jones <tonyj@immunix.com>
Subject: Re: rcu-refcount stacker performance
Message-ID: <20050714134450.GB7296@sergelap.austin.ibm.com>
References: <20050714142107.GA20984@serge.austin.ibm.com> <20050714152321.GB1299@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714152321.GB1299@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul E. McKenney (paulmck@us.ibm.com):
> On Thu, Jul 14, 2005 at 09:21:07AM -0500, serue@us.ibm.com wrote:
> > On July 8 I sent out a patch which re-implemented the rcu-refcounting
> > of the LSM list in stacker for the sake of supporting safe security
> > module unloading.  (patch reattached here for convenience)  Here are
> > some performance results with and without that patch.  Tests were run
> > on a 16-way ppc64 machine.  Dbench was run 50 times, and kernbench
> > and reaim were run 10 times, and intervals are 95% confidence half-
> > intervals.
> > 
> > These results seem pretty poor.  I'm now wondering whether this is
> > really necessary.  David Wheeler's original stacker had an option
> > of simply waiting a while after a module was taken out of the list
> > of active modules before freeing the modules.  Something like that
> > is of course one option.  I'm hoping we can also take advantage of
> > some already known module state info to be a little less coarse
> > about it.  For instance, sys_delete_module() sets m->state to
> > MODULE_STATE_GOING before calling mod->exit().  If in place of
> > doing atomic_inc(&m->use), stacker skipped the m->hook() if
> > m->state!=MODULE_STATE_LIVE, then it may be safe to assume that
> > any m->hook() should be finished before sys_delete_module() gets
> > to free_module(mod).  This seems to require adding a struct
> > module argument to security/security:mod_reg_security() so an LSM
> > can pass itself along.
> > 
> > So I'll try that next.  Hopefully by avoiding the potential cache
> > line bounces which atomic_inc(&m->use) bring, this should provide
> > far better performance.
> 
> My guess is that the reference count is indeed costing you quite a
> bit.  I glance quickly at the patch, and most of the uses seem to
> be of the form:
> 
> 	increment ref count
> 	rcu_read_lock()
> 	do something
> 	rcu_read_unlock()
> 	decrement ref count
> 
> Can't these cases rely solely on rcu_read_lock()?  Why do you also
> need to increment the reference count in these cases?

The problem is on module unload: is it possible for CPU1 to be
on "do something", and sleep, and, while it sleeps, CPU2 does
rmmod(lsm), so that by the time CPU1 stops sleeping, the code it
is executing has been freed?

Because stacker won't remove the lsm from the list of modules
until mod->exit() is executed, and module_free(mod) happens
immediately after that, the above scenario seems possible.

thanks,
-serge
