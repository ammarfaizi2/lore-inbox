Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWALFEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWALFEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWALFEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:04:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48042 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030285AbWALFEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:04:34 -0500
Date: Wed, 11 Jan 2006 21:04:53 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
Message-ID: <20060112050453.GA23673@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060111213910.GA17986@sgi.com> <8699.1137036592@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8699.1137036592@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:29:52PM +1100, Keith Owens wrote:
> John Hesterberg (on Wed, 11 Jan 2006 15:39:10 -0600) wrote:
> >On Wed, Jan 11, 2006 at 01:02:10PM -0800, Matt Helsley wrote:
> >> 	Have you looked at Alan Stern's notifier chain fix patch? Could that be
> >> used in task_notify?
> >
> >I have two concerns about an all-tasks notification interface.
> >First, we want this to scale, so don't want more global locks.
> >One unique part of the task notify is that it doesn't use locks.
> 
> Neither does Alan Stern's atomic notifier chain.  Indeed it cannot use
> locks, because the atomic notifier chains can be called from anywhere,
> including non maskable interrupts.  The downside is that Alan's atomic
> notifier chains require RCU.
> 
> An alternative patch that requires no locks and does not even require
> RCU is in http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2

Interesting!  Missed this on the first time around...

But doesn't notifier_call_chain_lockfree() need to either disable
preemption or use atomic operations to update notifier_chain_lockfree_inuse[]
in order to avoid problems with preemption?  If I understand the
code, one such problem could be caused by the following sequence
of events:

1.	Task A enters notifier_call_chain_lockfree(), gets a copy
	of the current CPU in local variable "cpu", snapshots the
	(initially zero) value of notifier_chain_lockfree_inuse[cpu]
	into local variable "nested", then is preempted.

2.	Task B enters notifier_call_chain_lockfree(), gets a copy
	of the current CPU in local variable "cpu", snapshots the
	(still zero) value of notifier_chain_lockfree_inuse[cpu]
	into local variable "nested", sets the value of
	notifier_chain_lockfree_inuse[cpu] to 1.

3.	Task A runs again, perhaps because Task B's priority dropped,
	perhaps because some other CPU became available.  It also
	sets the value of notifier_chain_lockfree_inuse[cpu] to 1.
	It then gains a reference to a notifier_block (call it Fred).

4.	Task B completes running through the notifier chain and sets
	notifier_chain_lockfree_inuse[cpu] = nested, which is zero.

5.	Task C invokes notifier_chain_unregister_lockfree() in order
	to remove Fred.  Task C finds all notifier_chain_lockfree_inuse[cpu]
	entries equal to zero, so removes Fred while Task A is still
	referencing it.  Which I believe is what was to be prevented.

If one updates notifier_chain_lockfree_inuse[cpu] using atomics,
then one could imagine a sequence of calls to notifier_call_chain_lockfree()
and preemptions that prevented one of the notifier_chain_lockfree_inuse[]
elements from ever reaching zero (though maybe this is being overly
paranoid).  If one disables preemption, then latency might become
excessive.

So what am I missing?

						Thanx, Paul
