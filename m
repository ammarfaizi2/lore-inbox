Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVDLO5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVDLO5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVDLOyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:54:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50131 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262447AbVDLOuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:50:22 -0400
Date: Tue, 12 Apr 2005 07:50:38 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Keys: Use RCU to manage session keyring pointer
Message-ID: <20050412145038.GC1367@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050411224500.GB1304@us.ibm.com> <29204.1111608899@redhat.com> <29827.1111611346@redhat.com> <31445.1113297110@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31445.1113297110@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:11:50AM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > >  	spin_lock_irqsave(&tsk->sighand->siglock, flags);
> > > -	old = tsk->signal->session_keyring;
> > > -	tsk->signal->session_keyring = keyring;
> > > +	old = rcu_dereference(tsk->signal->session_keyring);
> > 
> > I don't understand why rcu_dereference() is needed in this case.
> > Since we are holding the lock, it should not be possible for
> > this to change, right?  Or am I missing something?  (Quite possible,
> > am not all that familiar with this code.)
> 
> Erm... you're right. I stuck the rcu_dereference() in then added the locks
> back in when I realised I still needed them.
> 
> > > +	synchronize_kernel();
> > 
> > This would want to become synchronize_rcu().
> 
> I think the deprecation happened since I wrote my patch.

Yes, sorry, I should have made it clear that this was a change that
affected your code rather than an error on your part.

> > > +	if (tsk->signal->session_keyring) {
> > > +		rcu_read_lock();
> > > +		key = keyring_search_aux(
> > > +			rcu_dereference(tsk->signal->session_keyring),
> > > +			type, description, match);
> > > +		rcu_read_unlock();
> > > +	}
> > > +	else {
> > > +		key = keyring_search_aux(tsk->user->session_keyring,
> > > +					 type, description, match);
> > 
> > This one is constant, right?  If not, I don't understand the locking design.
> 
> Which one? tsk->user->session_keyring is, tsk->signal->session_keyring is not.

Good, that matches the code!

							Thanx, Paul

> Thanks for the review.
> 
> David
> 
