Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWGKO4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWGKO4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWGKO4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:56:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47372 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750950AbWGKO4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:56:06 -0400
Date: Tue, 11 Jul 2006 10:56:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       <matthltc@us.ibm.com>, <dipankar@in.ibm.com>, <mingo@elte.hu>,
       <tytso@us.ibm.com>, <dvhltc@us.ibm.com>, <jes@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
In-Reply-To: <20060711172530.GA93@oleg>
Message-ID: <Pine.LNX.4.44L0.0607111044021.6494-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Oleg Nesterov wrote:

> Let's look at the 3-rd synchronize_sched() call.
> 
> Suppose that the reader writes to the rcu-protected memory and then
> does srcu_read_unlock(). It is possible that the writer sees the result
> of srcu_read_unlock() (so that srcu_readers_active_idx() returns 0)
> but does not see other writes yet. The writer does synchronize_sched(),
> the reader (according to 2) above) does mb(). But this doesn't guarantee
> that all preceding mem ops were finished, so it is possible that
> synchronize_srcu() returns and probably frees that memory too early.
> 
> If it were possible to "insert" mb() into srcu_read_unlock() before ->c[]--,
> we are ok, but synchronize_sched() is a "shot in the dark".
> 
> In a similar manner, the 2-nd synchronize_sched() requires (I think) that
> all changes which were done by the current CPU should be visible to other
> CPUs before return.
> 
> Does it make sense?

Yes, it's a valid concern.

Paul will correct me if this is wrong...  As I understand it, the code 
which responds to a synchronize_sched() call (that is, the code which runs 
on other CPUs) does lots of stuff, involving context changes and 
who-knows-what else.  There are lots of memory barriers in there, buried 
in the middle, along with plenty of other memory reads and writes.

In outline, the reader's CPU responds to synchronize_sched() something 
like this:

	At the next safe time (context switch):
		mb();
		Tell the writer's CPU that the preempt count on
			the reader's CPU is 0

Since that "tell the writer's CPU" step won't complete until after the 
mb() has forced all preceding memory operations to complete, we are safe.

So perhaps the documentation for synchronize_sched() and synchronize_rcu()  
should say that when the call returns, all CPUs (including the caller's)
will have executed a memory barrier and so will have completed all memory
operations that started before the synchronize_xxx() call was issued.

Alan Stern

