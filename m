Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVCXG7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVCXG7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVCXG7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:59:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38304 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263067AbVCXG7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:59:32 -0500
Date: Wed, 23 Mar 2005 22:59:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324065941.GH1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323071604.GA32712@elte.hu> <20050323214645.GA10535@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323214645.GA10535@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 10:46:45PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i think the 'migrate read-count' method is not adequate either, 
> > because all callbacks queued within an RCU read section must be called 
> > after the lock has been dropped - while with the migration method 
> > CPU#1 would be free to process callbacks queued in the RCU read 
> > section still active on CPU#2.
> > 
> > i'm wondering how much of a problem this is though. Can there be stale 
> > pointers at that point? Yes in theory, because code like:
> > 
> > 	rcu_read_lock();
> > 	call_rcu(&dentry->d_rcu, d_callback);
> > 	func(dentry->whatever);
> > 	rcu_read_unlock();
> 
> but, this cannot happen, because call_rcu() is used by RCU-write code.

The code would not look exactly like this, but acquiring the update-side
lock inside an RCU read-side critical section can be thought of as
a reader-to-writer lock upgrade.  RCU can do this unconditionally,
which was one of the walls I was banging my head against when trying
to think up a realtime-safe RCU implementation.

So something like the following would be legitimate RCU code:

	rcu_read_lock();
	spin_lock(&dcache_lock);
	call_rcu(&dentry->d_rcu, d_callback);
	spin_unlock(&dcache_lock);
	rcu_read_unlock();

The spin_lock() call upgrades from a read-side to a write-side critical
section.

> so the important property seems to be that any active RCU-read section 
> should keep at least one CPU's active_readers count elevated 
> permanently, for the duration of the RCU-read section.

Yep!

>                                                         It doesnt matter 
> that the reader migrates between CPUs - because the RCU code itself 
> guarantees that no callbacks will be executed until _all_ CPUs have been 
> in quiescent state. I.e. all CPUs have to go through a zero 
> active_readers value before the callback is done.

Yep again!

						Thanx, Paul
