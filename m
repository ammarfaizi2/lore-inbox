Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWF0TS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWF0TS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWF0TS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:18:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:38821 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030294AbWF0TS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:18:56 -0400
Date: Tue, 27 Jun 2006 12:19:33 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu: RCU variant permitting read-side blocking
Message-ID: <20060627191933.GA2170@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627211358.GA484@oleg> <20060627185945.GD1286@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627185945.GD1286@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 11:59:45AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 28, 2006 at 01:13:58AM +0400, Oleg Nesterov wrote:
> > "Paul E. McKenney" wrote:
> > > +	idx = sp->completed & 0x1;
> > > +	sp->completed++;
> > 
> > But srcu_read_lock()'s path and rcu_dereference() doesn't have rmb(),
> > and the reader can block, so I can't understand how this all works.
> > 
> > Suppose ->completed == 0,
> > 
> > 	WRITER:						READER:
> > 
> > 	old = global_ptr;
> > 	rcu_assign_pointer(global_ptr, new);
> > 
> > 	synchronize_srcu:
> > 
> > 		locks mutex, does mb,
> > 		->completed++;
> > 		
> > 							srcu_read_lock();
> > 								// reads ->completed == 1
> > 								// does .c[1]++
> > 							ptr = rcu_dereference(global_ptr)
> > 								// reads the *OLD* value,
> > 								// because we don't have rmb()
> 
> Hmmm...  I thought I was handling this case, but my rationale as to
> how is looking a bit flimsy at the moment.  ;-)  I will look at this
> more carefully.  If you are correct, one fix is to replace the prior mb
> with synchronize_sched().  Do you agree that this would fix the problem?

Never mind -- this fix would have no effect.  Guess I should engage
my brain before sending email.  :-/

First to review my reasoning, and then to provide either the explanation
should my reasoning prove true or a fix otherwise...

							Thanx, Paul
