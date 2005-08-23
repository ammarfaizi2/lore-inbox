Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVHWDiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVHWDiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 23:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVHWDiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 23:38:46 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:37854 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932071AbVHWDip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 23:38:45 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1124760725.5350.47.camel@localhost.localdomain>
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
	 <1124760725.5350.47.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 23:38:02 -0400
Message-Id: <1124768282.5350.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 21:32 -0400, Steven Rostedt wrote:

> 
> God, I think a thesis can be made out of this.  Well, let me start
> coding, since I'm one of those that write code better than I design.
> I'm a Spiral type of guy, not a Waterfall one ;-)
> Code crap, write about it, recode it as gold!
> 

I'm really made a mess of the code now and having a lot of fun ;-)

I think this can be pulled off, but I'm seeing that the easiest way is
to do the grabbing of locks with lock -> owner -> lock -> owner ...

So if you have the chain.

P1 X=> L1 -> P2 X=> L2 X=> P3

You would always need to grab the locks in this order:

P1->pi_lock, L1->wait_lock, P2->pi_lock, L2->wait_lock, P3->pi_lock

So on a __down, if you don't get the lock, this makes for easy
transition in the pi_setprio.  You have the current->pi_lock, and then
grab the lock->wait_lock that current is blocked on.  In the loop, you
need to first grab p->wait_lock, to prevent the race with p->blocked_on
and setting it up.  Having to get the lock->wait_lock first would mean
there's a race to get blocked_on, and knowing what it was blocked on.

Now the PITA is with the __up.  Here we have the lock, and we need to
change the owner.  So we need to unlock the lock (as well as the current
owner pi_lock), before giving it to the new owner.  So the race is, if
you have the lock->wait_lock, find the new owner, then unlock the
lock->wait_lock, lock new_owner->pi_lock and then grab the
lock->wait_lock again, in this time a higher priority process could have
come and blocked on this lock.  So the new_owner should really be the
high priority process that just came in. This skips by the pending owner
algorithm.

There's more than one solution to solve this.  The easy, inefficient
way, is to have a test to see if this occurred and try again. But I was
thinking of the following.

When grabbing a lock, you check if there are waiters (although there may
not be an owner or even a pending owner), if you are the highest
priority process, grab the lock and go, otherwise, just add yourself to
the waiting list (and perhaps the pi_list).  So when the original owner
giving up the lock finally runs, it won't need to do anymore work.  If
the lock is owned, then it just unlocks everything, and then it's
someone elses problem.  

The situation could even occur that the higher priority process that
came in and took the lock gave it back to the "new" guy, and the lock
isn't owned at all.  So a simple check of, is the "new" guy still
blocked on the lock and the lock is not owned should be good enough to
finish the change owner job.

It's all complex, but what did you expect when removing a global lock
that makes life simple :-)

-- Steve

