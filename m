Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbVKLCar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVKLCar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbVKLCar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:30:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:8154 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751032AbVKLCar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:30:47 -0500
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain
	mechanism
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
       lse-tech@lists.sourceforge.net
In-Reply-To: <20051112014421.GH1289@us.ibm.com>
References: <1131752619.14041.125.camel@linuxchandra>
	 <20051112014421.GH1289@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 11 Nov 2005 18:30:42 -0800
Message-Id: <1131762642.14041.151.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 17:44 -0800, Paul E. McKenney wrote:

Thanks for the comments Paul.


> > +	rcu_assign_pointer(n->next, *nl);
> 
> The above can simply be "n->next = *nl;".  The reason is that this change
> of state is not visible to RCU readers until after the following statement,
> and it therefore need not be an RCU-reader-safe assignment.  You only need
> to use rcu_assign_pointer() when the results of the assignment are
> immediately visible to RCU readers.

will do.

> 
> > +	rcu_assign_pointer(*nl, n);
> > +	up_write(&nh->rwsem);
> > +	if (nh->type == ATOMIC_NOTIFIER)
> > +		synchronize_rcu();
> 
> This "if" statement and the "synchronize_rcu()" are not needed.  Nothing
> has been removed from the list, so nothing will be freed, so no need to
> wait for readers to get done.
> 
> In contrast, the synchronize_rcu() in notifier_chain_unregister() -is-
> needed, since we need to free the removed element.

will do


> > +	if (nh->type == ATOMIC_NOTIFIER)
> > +		rcu_read_lock();
> > +	else
> > +		down_read(&nh->rwsem);
> 
> Is it possible for the value of nh->type to change?  If so, there needs
> to be some additional mechanism to guard against such a change.  However,
> if this field is constant, this code is just fine as is.

No, it is not supposed to change.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


