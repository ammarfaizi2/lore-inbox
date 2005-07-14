Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVGNQ7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVGNQ7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVGNQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:59:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39666 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261566AbVGNQ7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:59:08 -0400
Date: Thu, 14 Jul 2005 09:59:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       "David A. Wheeler" <dwheeler@ida.org>, Tony Jones <tonyj@immunix.com>
Subject: Re: rcu-refcount stacker performance
Message-ID: <20050714165936.GE1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050714142107.GA20984@serge.austin.ibm.com> <20050714152321.GB1299@us.ibm.com> <20050714134450.GB7296@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714134450.GB7296@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 08:44:50AM -0500, serue@us.ibm.com wrote:
> Quoting Paul E. McKenney (paulmck@us.ibm.com):
> > My guess is that the reference count is indeed costing you quite a
> > bit.  I glance quickly at the patch, and most of the uses seem to
> > be of the form:
> > 
> > 	increment ref count
> > 	rcu_read_lock()
> > 	do something
> > 	rcu_read_unlock()
> > 	decrement ref count
> > 
> > Can't these cases rely solely on rcu_read_lock()?  Why do you also
> > need to increment the reference count in these cases?
> 
> The problem is on module unload: is it possible for CPU1 to be
> on "do something", and sleep, and, while it sleeps, CPU2 does
> rmmod(lsm), so that by the time CPU1 stops sleeping, the code it
> is executing has been freed?

OK, but in the above case, "do something" cannot be sleeping, since
it is under rcu_read_lock().

> Because stacker won't remove the lsm from the list of modules
> until mod->exit() is executed, and module_free(mod) happens
> immediately after that, the above scenario seems possible.

Right, if you have some other code path that sleeps (outside of
rcu_read_lock(), right?), then you need the reference count for that
code path.  But the code paths that do not sleep should be able to
dispense with the reference count, reducing the cache-line traffic.

						Thanx, Paul
