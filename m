Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVDOWxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVDOWxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVDOWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 18:53:34 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:19473 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262029AbVDOWvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 18:51:33 -0400
Date: Fri, 15 Apr 2005 15:51:37 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dwalker@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Esben Nielsen <simlo@phys.au.dk>, "Bill Huey (hui)" <bhuey@lnxw.com>
Subject: Re: FUSYN and RT
Message-ID: <20050415225137.GA23222@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk> <1113352069.6388.39.camel@dhcp153.mvista.com> <1113407200.4294.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113407200.4294.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:46:40AM -0400, Steven Rostedt wrote:
> On Tue, 2005-04-12 at 17:27 -0700, Daniel Walker wrote:
> > There is a great big snag in my assumptions. It's possible for a process
> > to hold a fusyn lock, then block on an RT lock. In that situation you
> > could have a high priority user space process be scheduled then block on
> > the same fusyn lock but the PI wouldn't be fully transitive , plus there
> > will be problems when the RT mutex tries to restore the priority. 
> > 
> > We could add simple hooks to force the RT mutex to fix up it's PI, but
> > it's not a long term solution.

Ok, I've been thinking about these issues and I believe there are a number
of misunderstandings here. The user and kernel space mutexes need to be
completely different implementations. I'll have more on this later.

First of all, priority transitivity should be discontinuous at the user/kernel
space boundary, but be propagated by the scheduler, via an API or hook,
upon a general priority boost to the thread in question.

You have thread A blocked in the kernel holding is onto userspace mutex 1a
and kernel mutex 2a. Thread A is priority boosted by a higher priority
thread B trying to acquire mutex 1a. The transitivity operation propagates
through the rest of the lock graph in userspace, via depth first search,
as usual. When it hits the last userspace mutex in question, this portion
of the propagation activity stops. Next, the scheduler itself finds out
that thread A has had it's priority altered because of a common priority
change API and starts another priority propagation operation in kernel
space to mutex 1b. There you have it. It's complete from user to kernel
space using a scheduler event/hook/api to propagate priority changes
into the kernel.

With all of that in place, you do a couple of things for the mutex
implementation. First, you convert as much code of the current RT mutex
code to be type polymorphic
as you can:

1) You use Daniel Walker's PI list handling for wait queue insertion for
   both mutex implementation. This is done since it's already a library
   and is already generic.

2) Then you generalize the dead lock detection code so that things like
   "what to do in a deadlock case" is determine at the instantiation of
   the code. You might have to use C preprocessor macros to do a generic
   implementation and then fill in the parametric values for creating a
   usable instance.

3) Make the grab owner code generic.

4) ...more part of the RT mutex...
   etc...

> How hard would it be to use the RT mutex PI for the priority inheritance
> for fusyn?  I only work with the RT mutex now and haven't looked at the
> fusyn.  Maybe Ingo can make a separate PI system with its own API that
> both the fusyn and RT mutex can use. This way the fusyn locks can still
> be separate from the RT mutex locks but still work together. 

I'd apply these implementation ideas across both mutexes, but keep the
individual mutexes functionality distinct. I look at this problem from
more of a reusability perspective than anything else.
 
> Basically can the fusyn work with the rt_mutex_waiter?  That's what I
> would pull into its own subsystem.  Have another structure that would
> reside in both the fusyn and RT mutex that would take over for the
> current rt_mutex that is used in pi_setprio and task_blocks_on_lock in
> rt.c.  So if both locks used the same PI system, then this should all be
> cleared up. 

Same thing...

There will be problems trying to implement a Posix read/write lock using
this method and the core RT mutex might have to be fundamentally altered
to handle recursion of some sort, decomposed into smaller bits and
recomposed into something else.

bill

