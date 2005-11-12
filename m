Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVKLT10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVKLT10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 14:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVKLT10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 14:27:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:27535 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932472AbVKLT10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 14:27:26 -0500
Date: Sat, 12 Nov 2005 11:28:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain mechanism
Message-ID: <20051112192809.GA5296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051112052213.GB3335@us.ibm.com> <Pine.LNX.4.44L0.0511121029450.30363-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511121029450.30363-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 10:35:07AM -0500, Alan Stern wrote:
> On Fri, 11 Nov 2005, Paul E. McKenney wrote:
> 
> > > > > +	down_write(&nh->rwsem);
> > > > > +	nl = &nh->head;
> > > > > +	while ((*nl) != NULL) {
> > > > > +		if (n->priority > (*nl)->priority)
> > > > > +			break;
> > > > > +		nl = &((*nl)->next);
> > > > > +	}
> > > > > +	rcu_assign_pointer(n->next, *nl);
> > > > 
> > > > The above can simply be "n->next = *nl;".  The reason is that this change
> > > > of state is not visible to RCU readers until after the following statement,
> > > > and it therefore need not be an RCU-reader-safe assignment.  You only need
> > > > to use rcu_assign_pointer() when the results of the assignment are
> > > > immediately visible to RCU readers.
> > > 
> > > Correct, the rcu call isn't really needed.  It doesn't hurt perceptibly,
> > > though, and part of the RCU documentation states:
> > > 
> > >  * ...  More importantly, this
> > >  * call documents which pointers will be dereferenced by RCU read-side
> > >  * code.
> > > 
> > > For that reason, I felt it was worth putting it in.
> > 
> > But the following statement does a much better job of documenting the
> > pointer that is to be RCU-dereferenced.  Duplicate documentation can
> > be just as confusing as no documentation.
> 
> It's not really duplicate documentation since _both_ pointers are to be 
> RCU-dereferenced.  But maybe you mean that only the second pointer can be 
> RCU-dereferenced at the time the write occurs?  I don't think that's what 
> the documentation comment intended.

I am the guy who wrote that documentation ocmment.  ;-)

							Thanx, Paul
