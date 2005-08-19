Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932745AbVHSXMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbVHSXMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbVHSXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:12:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10203 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932745AbVHSXMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:12:38 -0400
Date: Fri, 19 Aug 2005 16:12:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt6
Message-ID: <20050819231223.GN1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1124252419.5764.83.camel@localhost.localdomain> <1124257580.5764.105.camel@localhost.localdomain> <20050817064750.GA8395@elte.hu> <1124287505.5764.141.camel@localhost.localdomain> <1124288677.5764.154.camel@localhost.localdomain> <1124295214.5764.163.camel@localhost.localdomain> <20050817162324.GA24495@elte.hu> <1124486548.18408.18.camel@localhost.localdomain> <20050819224758.GJ1298@us.ibm.com> <1124492562.18408.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124492562.18408.35.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 07:02:42PM -0400, Steven Rostedt wrote:
> On Fri, 2005-08-19 at 15:47 -0700, Paul E. McKenney wrote:
> 
> > Good catch -- but a few changes needed to be perfectly safe:
> > 
> > 	static inline void *netpoll_poll_lock(struct net_device *dev)
> > 	{
> > 
> > 		struct netpoll_info *npi;
> > 
> > 		rcu_read_lock();
> > 		npi = rcu_dereference(dev)->npinfo;
> > 		if (have) {
> 
> Here I'm sure you mean "if (npi) {" :-)

Right you are!  ;-)

> > 			spin_lock(&npi->poll_lock);
> > 			npi->poll_owner = smp_processor_id();
> > 			return npi;
> > 		}
> > 		return NULL;
> > 	}
> > 
> > The earlier version could get in trouble if dev->npinfo was set
> > to NULL while this was executing.
> 
> Truth be told,  I was just fixing the race with getting the npinfo
> pointer set between netpoll_poll_lock and netpoll_poll_unlock.  I wrote
> a patch that fixed that but nothing with the rcu_locks.  Then I looked
> at the current git tree and saw that they already had my changes, but
> also included the rcu locks.  So I just (blindly) added them.

Understood!

> > Again, I do not fully understand this code, so a grain of salt might
> > come in handy.  But there definitely need to be some rcu_dereference()
> > and rcu_assign_pointer() primitives in there somewhere.  ;-)
> > 
> > The following changes look good to me, but, as I said earlier, I do
> > not claim to fully understand this code.
> 
> netpoll has changed quite a bit in the last few releases. I've seen lots
> of fixup code sent in (which usually means there's lots of new broken
> code ;-)
> 
> Anyway, I don't quite fully understand RCU. I read a few of the
> documents on your web site, but I haven't had time to really digest it.
> Have you taken a look at the latest git tree?  The rcu_locks are used
> for net poll quite a bit more there.

Hmmm....  Guess it is time for me to stop procrastinating on better
understanding git...

						Thanx, Paul
