Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWDYLqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWDYLqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWDYLqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:46:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:60388 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751548AbWDYLqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:46:36 -0400
Date: Tue, 25 Apr 2006 04:46:56 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, schwidefsky@de.ibm.com
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060425114656.GA16719@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425052721.GA9458@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 07:27:21AM +0200, Heiko Carstens wrote:
> > > @@ -485,6 +485,14 @@ int rcu_pending(int cpu)
> > >  		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
> > >  }
> > >  
> > > +int rcu_soon_pending(int cpu)
> > > +{
> > > +	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > > +	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
> > > +
> > > +	return (!!rdp->curlist || !!rdp_bh->curlist);
> > > +}
> > 
> > This patch sets my nerves a-jangling.
> > 
> > What are the units of soonness?  It's awfully waffly.  Can we specify this
> > more tightly?
> > 
> > Neither rcu_pending() nor rcu_soon_pending() are commented or documented. 
> > Pity the poor user trying to work out what they do, and how they differ. 
> > They're global symbols and they form part of the RCU API - they should be
> > kernel docified, please.
> > 
> > There's probably a reason why neither of these symbols are exported to
> > modules.  Once they're actually documented I mught be able to work out what
> > that reason is ;)
> 
> Maybe rcu_batch_pending() would be a better name for rcu_soon_pending(). Also
> rcu_batch_in_work() would be a more descriptive name for rcu_pending() as far
> as I can tell.
> Actually I was hoping for a better solution from the rcu experts, since I
> don't like this too, but couldn't find something better.

OK, got a look at your patch.

You are using this internally, as part of the RCU -implementation-.
You are determining whether this CPU will still be needed by RCU,
or whether it can be turned off.  So how 'bout calling the (internal)
API something like rcu_needs_cpu()?

int rcu_needs_cpu(int cpu)
{
	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);

	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
}

Then you can drop the rcu_pending() check from your 390 patch.

Seem reasonable?

The meaning of rcu_pending() is "Does RCU have some work pending on
this CPU, so that there is a need to invoke rcu_check_callbacks() on
this CPU?"

							Thanx, Paul
