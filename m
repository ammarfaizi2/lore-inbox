Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269054AbUIABDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269054AbUIABDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUIABDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:03:21 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:49818 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S269066AbUIABBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:01:46 -0400
Date: Tue, 31 Aug 2004 17:57:50 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jim Houston <jim.houston@comcast.net>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC&PATCH] Alternative RCU implementation
Message-ID: <20040901005750.GG1241@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m3brgwgi30.fsf@new.localdomain> <20040830004322.GA2060@us.ibm.com> <1093886020.984.238.camel@new.localdomain> <20040830173853.GB4639@in.ibm.com> <1093997450.4069.1.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093997450.4069.1.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 08:10:50PM -0400, Jim Houston wrote:
> On Mon, 2004-08-30 at 13:38, Dipankar Sarma wrote:
> 
> > > I'm also trying to figure out if I need the call_rcu_bh() changes.
> > > Since my patch will recognize a grace periods as soon as any 
> > > pending read-side critical sections complete, I suspect that I
> > > don't need this change.
> > 
> > Except that under a softirq flood, a reader in a different read-side
> > critical section may get delayed a lot holding up RCU. Let me know
> > if I am missing something here.
> 
> Hi Dipankar,
> 
> O.k.  That makes sense.  So the rcu_read_lock_bh(), rcu_read_unlock_bh()
> and call_rcu_bh() would be the preferred interface.  Are there cases
> where they can't be used?  How do you decide where to use the _bh 
> flavor?

Hello, Jim,

You would use rcu_read_lock() instead of rcu_read_lock_bh() in cases
where you did not want the read-side code to disable bottom halves.
This is very similar to choosing between read_lock() and read_lock_bh()
-- if you unnecessarily use read_lock_bh() or rcu_read_lock_bh(), you
will be unnecessarily delaying drivers' bottom-half execution.

> I see that local_bh_enable() WARNS if interrupts are disabled.  Is that
> the issue?  Are rcu_read_lock()/rcu_read_unlock() ever called from 
> code which disables interrupts?

The RCU "_bh()" interfaces correspond to a different set of quiescent
states than do the standard interfaces.  You could indeed use
rcu_read_lock() with interrupts disabled, but I don't know of any
such use.

						Thanx, Paul

> Jim Houston - Concurrent Computer Corp.
> 
> 
