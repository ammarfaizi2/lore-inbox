Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVC3Gci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVC3Gci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVC3Gch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:32:37 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61337 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261755AbVC3GcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:32:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503261047190.27746@localhost.localdomain>
References: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
	 <Pine.LNX.4.58.0503261047190.27746@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 30 Mar 2005 01:31:53 -0500
Message-Id: <1112164313.3691.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 11:04 -0500, Steven Rostedt wrote:
> 
> On Fri, 25 Mar 2005, Esben Nielsen wrote:

> >
> > I like the idea of having the scheduler take care of it - it is a very
> > optimal coded queue-system after all. That will work on UP but not on SMP.
> > Having the unlock operation to set the mutex in a "partially owned" state
> > will work better. The only problem I see, relative to Ingo's
> > implementation, is that then the awoken task have to go in and
> > change the state of the mutex, i.e. it has to lock the wait_lock again.
> > Will the extra schedulings being the problem happen offen enough in
> > practise to have the extra overhead?
> 
> Another answer is to have the "pending owner" bit be part of the task
> structure. A flag maybe.  If a higher priority process comes in and
> decides to grab the lock from this owner, it does a test_and_clear on the
> this flag on the pending owner task.  When the pending owner task wakes
> up, it does the test_and_clear on its own bit.  Who ever had the bit set
> on the test wins. If the higher prio task were to clear it first, then it
> takes the ownership away from the pending owner.  If the pending owner
> were to clear the bit first, it won and would contiue as though it got the
> lock.  The higher priority tasks would do this test within the wait_lock
> to keep from having more than one trying to grab the lock from the pending
> owner, but the pending owner won't need to do anything since it will know
> if it was the new owner just by testing its own bit.

OK, I'm declaring defeat here. I've been fighting race conditions all
day, and it's now 1 in the morning where I live. It looks like this
implementation has no other choice but to have the waking up "pending
owner" take the wait_list lock once again.  How heavy of a overhead is
that really?  

The problem I've painfully discovered, is that a task trying to take the
lock must test the pending owner for two things. One is, is the pending
owner owning the same lock as the one the task is trying to get. Since
the waking up of the pending owner has no synchronous locking, it can
grab the lock and then become a pending owner to another lock after the
other task thinks it's still the pending owner of the lock its trying to
get, but before testing it. So it can mistake it as the pending owner
still for this lock, when in reality it owns to lock and is pending for
another.

The other test must also do the test_and_clear_bit on the pending owner
bit. So you need to make sure the owner not only stays the owner of the
lock the task is trying to get, but also be able to do the atomic
test_and_clear on the owner's pending owner bit.

I can't get these two in sync without grabbing a lock (in this case, the
wait_list lock). 

Ingo, unless you can think of a way to do this, tomorrow (actually
today), I'll change this to have the end of __down (and friends) grab
the wait_list lock to test and clear it's pending owner bit. 

-- Steve


