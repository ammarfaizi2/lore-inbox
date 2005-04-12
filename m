Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVDLJMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVDLJMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVDLJMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:12:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59529 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262068AbVDLJMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:12:12 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050411224500.GB1304@us.ibm.com> 
References: <20050411224500.GB1304@us.ibm.com>  <29204.1111608899@redhat.com> <29827.1111611346@redhat.com> 
To: paulmck@us.ibm.com
Cc: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Keys: Use RCU to manage session keyring pointer 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 12 Apr 2005 10:11:50 +0100
Message-ID: <31445.1113297110@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney <paulmck@us.ibm.com> wrote:

> >  	spin_lock_irqsave(&tsk->sighand->siglock, flags);
> > -	old = tsk->signal->session_keyring;
> > -	tsk->signal->session_keyring = keyring;
> > +	old = rcu_dereference(tsk->signal->session_keyring);
> 
> I don't understand why rcu_dereference() is needed in this case.
> Since we are holding the lock, it should not be possible for
> this to change, right?  Or am I missing something?  (Quite possible,
> am not all that familiar with this code.)

Erm... you're right. I stuck the rcu_dereference() in then added the locks
back in when I realised I still needed them.

> > +	synchronize_kernel();
> 
> This would want to become synchronize_rcu().

I think the deprecation happened since I wrote my patch.

> > +	if (tsk->signal->session_keyring) {
> > +		rcu_read_lock();
> > +		key = keyring_search_aux(
> > +			rcu_dereference(tsk->signal->session_keyring),
> > +			type, description, match);
> > +		rcu_read_unlock();
> > +	}
> > +	else {
> > +		key = keyring_search_aux(tsk->user->session_keyring,
> > +					 type, description, match);
> 
> This one is constant, right?  If not, I don't understand the locking design.

Which one? tsk->user->session_keyring is, tsk->signal->session_keyring is not.

Thanks for the review.

David
