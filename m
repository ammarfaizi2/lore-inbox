Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVHWA1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVHWA1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHWA1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:27:39 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:47578 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932252AbVHWA1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:27:38 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124749192.17515.16.camel@dhcp153.mvista.com>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124749192.17515.16.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 20:26:15 -0400
Message-Id: <1124756775.5350.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 15:19 -0700, Daniel Walker wrote:
> On Mon, 2005-08-22 at 15:44 -0400, Steven Rostedt wrote:
> > On Mon, 2005-08-22 at 20:33 +0200, Ingo Molnar wrote:
> > 
> > > any ideas how to get rid of pi_lock altogether?
> > 
> > I've toyed with the idea of adding another raw_spin_lock to the mutex. A
> > lock specific pi_lock.   Instead of grabbing a global pi_lock, grab the
> > pi_lock of a lock.  To modify any lock w.r.t PI, you must first grab all
> > the lock's pi_locks being referenced.
> 
> Are you saying that you want to convert the current system to lock all
> the pi_locks for all the locks in the sequence?
> 
> It seems like you could make it a per task lock, then only lock the
> task's pi_lock for pi operations.

How would you add to a lock with just holding a lock for a task?  When
you are grabbing a lock, you must first grab a raw lock associated to
the lock being grabbed.  Although, I'm starting to look into this idea,
and I'm going to first see if the current wait_lock could suffice.  I
may also need to add an additional lock to the task to follow the lock
-> task -> lock route.  The tasks order should be the same as the locks
when the are bound (holding) a lock. Since the task won't be able to
release it without holding the raw lock of the lock it is releasing.
(boy this gets confusing to talk about, since you need to talk about
locks and the locking method within the lock!)

> 
> > The idea stems from the fact that the kernel must order its taking of
> > locks to prevent deadlocks.  This way the order of locks that are taken
> > are also always in order. 
> > 
> > So if you have the following case:
> > 
> > P1 blocked_on L1 owned_by P2 blocked_on L2 owned_by P3 ...
> > 
> > The L1, L2, L3 ... must always be in the same order, otherwise the
> > kernel itself can have a deadlock.
> > 
> > OK, let me prove this (for myself as well ;-)
> > 
> > Lets go by contradiction.
> 
> Proof seems straight forward enough. 
> 
> One downside would be an increase in mutex structure size though.

If I do need to add an additional lock to the mutex, I would abstract it
all, so that the old global pi_lock can be used if configured.  This
way, a UP or a low memory 2x SMP machine can still use the old method,
but when it needs to grow, switch over to the new non-global pi_locking
method.  But, maybe I can still get away with just using the wait_lock
and not add any more overhead to the size of the mutex.

I've just started to expiremnent with this idea, so I really don't know
yet how this will work.

-- Steve


