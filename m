Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVC2MPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVC2MPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVC2MPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:15:12 -0500
Received: from [24.24.2.58] ([24.24.2.58]:41368 "EHLO ms-smtp-04.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S262233AbVC2MMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:12:20 -0500
Subject: Re: [RFC] logdev debugging memory device for tough to debug areas
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050329115656.GA15708@elte.hu>
References: <1109032784.32648.24.camel@localhost.localdomain>
	 <20050329090707.GD7074@elte.hu>
	 <1112097210.3691.51.camel@localhost.localdomain>
	 <20050329115656.GA15708@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 29 Mar 2005 07:12:03 -0500
Message-Id: <1112098323.3691.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 13:56 +0200, Ingo Molnar wrote:

> > To have a task take back the ownership, I had the stealer call 
> > task_blocks_on_lock on the task that it stole it from. To get this to 
> > work, when a task is given the pending ownership, it doesn't NULL the 
> > blocked_on at that point (although the waiter->task is set to NULL).  
> > But this gives the race condition in pi_setprio where it checks for 
> > p->blocked_on still exists. Reason is that I don't want the waking up 
> > of a process to call any more locks. To solve this, I had to (and this 
> > is what I don't like right now) add another flag for the process 
> > called PF_BLOCKED. So that this can tell the pi_setprio when to stop.  
> > This flag is set in task_blocks_on_lock and cleared in pick_new_owner 
> > where the setting of blocked_on to NULL use to be.
> 
> which locks are affected? I'd prefer the simplest solution. If there's 
> more overhead with deadlock detection (which is a debugging feature), 
> that doesnt matter much.

I've already covered the deadlock detection problems, and that didn't
add anymore overhead. That was just what kept breaking every time I
changed something ;-)

The overhead is caused by the pi_setprio knowing when to stop following
the chain of blocked processes. Since it can't check for p->blocked_on
== NULL anymore. I first had it check that or p->flags & PF_PENDOWNER,
but since the process waking up can happen at anytime without grabbing
any lock, this flag can be cleared as well as the blocked_on at the time
of this test.  So I added another flag to p->flags to tell when the
process is locked and not pending ownership.  I don't know yet if this
works, I have to run to an appointment now and I'll find out when I get
back.

Oh, and I disabled the deadlock check on the stolen case. So when a
pending owner goes back to blocked, right now it doesn't check the
deadlock, since the code uses current as the test, and that no longer
applies. So for now I have a test in task_blocks_on_lock to see if task
== current otherwise, don't check for deadlocks.

-- Steve


