Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVC3T76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVC3T76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVC3T6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:58:20 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:4602 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262430AbVC3T46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:56:58 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 30 Mar 2005 14:56:48 -0500
Message-Id: <1112212608.3691.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 20:44 +0100, Esben Nielsen wrote:
> On Wed, 30 Mar 2005, Steven Rostedt wrote:
> 
> > [...] 
> > 
> > Heck, I'll make it bloat city till I get it working, and then tone it
> > down a little :-)  And maybe later we can have a better solution for the
> > BKL.
> > 
> What about removing it alltogether?
> Seriously, how much work would it be to simply remove it and go in and
> make specific locks in all those places the code can't compile?

I would really love to do that!  But I don't have the time or the
knowledge on the effects that would have.

Because of the stupid BKL, I'm going with a combination of your idea and
my idea for the solution of pending owners.  I originally wanted the
stealer of the lock to put the task that was robbed back on the list.
But because of the BKL, you end up with a state that a task can be
blocked by two locks at the same time. This causes hell with priority
inheritance.

So finally, what I'm doing now is to have the lock still pick the
pending owner, and that owner is not blocked on the lock. If another
process comes along and steals the lock, the robbed task goes to a state
as if it was just before calling __down*. So when it wakes up, it checks
to see if it is the pending owner, and if not, then it tries to grab the
lock again, if it doesn't get it, it just calls task_blocks_on_lock
again.

This is the easiest solution so far, but I still like the stealer to put
it back on the list.  But until we get rid of the BKL that wont happen.

-- Steve


