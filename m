Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVHWBcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVHWBcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 21:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVHWBcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 21:32:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30083 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751295AbVHWBcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 21:32:54 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124758291.9158.17.camel@dhcp153.mvista.com>
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
	 <1124756775.5350.14.camel@localhost.localdomain>
	 <1124758291.9158.17.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 21:32:05 -0400
Message-Id: <1124760725.5350.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 17:51 -0700, Daniel Walker wrote:
> On Mon, 2005-08-22 at 20:26 -0400, Steven Rostedt wrote:
> 
> > 
> > How would you add to a lock with just holding a lock for a task?  When
> > you are grabbing a lock, you must first grab a raw lock associated to
> > the lock being grabbed.  Although, I'm starting to look into this idea,
> > and I'm going to first see if the current wait_lock could suffice.  I
> > may also need to add an additional lock to the task to follow the lock
> > -> task -> lock route.  The tasks order should be the same as the locks
> > when the are bound (holding) a lock. Since the task won't be able to
> > release it without holding the raw lock of the lock it is releasing.
> > (boy this gets confusing to talk about, since you need to talk about
> > locks and the locking method within the lock!)
> 
> You might need to explain that one more time . I'm sure it needs more
> though, but the pi_lock just protects another cpu from enter
> pi_setprio() . What we really want is to protect only the specific
> structures modified inside pi_setprio() . Or that's my understanding .
> Are you thinking of something else?

Nope, nothing else. That's pretty much it.

> 
> I think you would at least need to lock the wait_lock for each lock that
> is looped over inside pi_setprio() . Because you access the wait_list
> inside the loop .

That's what I was thinking. The wait_list locks could be the lock that
is used to replace the pi_lock.

> 
> There is also a pi_waiters list that is per task. You would need to make
> a lock for that, I think . Or protect it somehow .
> 

Yeah this is sort of what I was thinking of when I follow the
lock->task->lock route.

Here's a visual:

X=> : blocked on
->  : owned by

P1 X=> L1 -+
       ^   |
P2 X===+   |
           |
           +->P4 X=> L3 -> P5
           |
P3 X=> L2 -+

So P4 owns locks L1 and L2 with tasks P1 and P2 blocked on L1 and P3
blocked on L2.  And P4 is blocked on lock L3 owned by P5.

This has the following lists:

L1->wait_list => P1 => P2
L2->wait_list => P3
L3->wait_list => P4

P4->pi_waiters => P1 => P2 => P3
P5->pi_waiters => P4


OK, we add another lock to the task that protects the pi_waiters.
Always grab this lock _after_ grabbing all the necessary wait_locks.

So when P5 needs to update it's pi_waiters, it first grabs the
L3->wait_lock, and then the P5->pi_lock.

So when blocking on a lock, you would grab the lock->wait_locks of all
the locks that you are blocked on.  When P2 blocked on a L1 it would
have grabbed (in this order) L1->wait_lock, L3->wait_lock, P4->pi_lock. 

Actually, for simplicity, since the pi_lock is associated to the task,
we may be able to safely grab the task pi_lock before a wait_lock. Say
if we have P5 blocked on L4 owned by P6.  When updating the
P4->pi_waiters (say when P2 blocked on L1), we could do this:

Grab L1->wait_lock, L3->wait_lock, P4->pi_lock, L4->wait_lock.  Since we
should never be grabbing the L4->wait_lock (or higher) when grabbing the
P4->pi_lock.

God, I think a thesis can be made out of this.  Well, let me start
coding, since I'm one of those that write code better than I design.
I'm a Spiral type of guy, not a Waterfall one ;-)
Code crap, write about it, recode it as gold!

-- Steve


