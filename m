Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbVHSXCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbVHSXCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbVHSXCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:02:53 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:49324 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932743AbVHSXCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:02:53 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050819224758.GJ1298@us.ibm.com>
References: <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124486548.18408.18.camel@localhost.localdomain>
	 <20050819224758.GJ1298@us.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 19 Aug 2005 19:02:42 -0400
Message-Id: <1124492562.18408.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 15:47 -0700, Paul E. McKenney wrote:

> Good catch -- but a few changes needed to be perfectly safe:
> 
> 	static inline void *netpoll_poll_lock(struct net_device *dev)
> 	{
> 
> 		struct netpoll_info *npi;
> 
> 		rcu_read_lock();
> 		npi = rcu_dereference(dev)->npinfo;
> 		if (have) {

Here I'm sure you mean "if (npi) {" :-)

> 			spin_lock(&npi->poll_lock);
> 			npi->poll_owner = smp_processor_id();
> 			return npi;
> 		}
> 		return NULL;
> 	}
> 
> The earlier version could get in trouble if dev->npinfo was set
> to NULL while this was executing.

Truth be told,  I was just fixing the race with getting the npinfo
pointer set between netpoll_poll_lock and netpoll_poll_unlock.  I wrote
a patch that fixed that but nothing with the rcu_locks.  Then I looked
at the current git tree and saw that they already had my changes, but
also included the rcu locks.  So I just (blindly) added them.


> 
> Again, I do not fully understand this code, so a grain of salt might
> come in handy.  But there definitely need to be some rcu_dereference()
> and rcu_assign_pointer() primitives in there somewhere.  ;-)
> 
> The following changes look good to me, but, as I said earlier, I do
> not claim to fully understand this code.

netpoll has changed quite a bit in the last few releases. I've seen lots
of fixup code sent in (which usually means there's lots of new broken
code ;-)

Anyway, I don't quite fully understand RCU. I read a few of the
documents on your web site, but I haven't had time to really digest it.
Have you taken a look at the latest git tree?  The rcu_locks are used
for net poll quite a bit more there.

-- Steve


