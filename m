Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVDLXNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVDLXNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbVDLXLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:11:54 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:13226 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262979AbVDLUhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:37:24 -0400
Date: Tue, 12 Apr 2005 22:35:35 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
In-Reply-To: <20050411085737.GA11109@elte.hu>
Message-Id: <Pine.OSF.4.05.10504122231270.6111-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at the PI-code to see what priority the task (old_owner below)
would end up with when it released a lock. From rt.c:

	prio = mutex_getprio(old_owner);
	if (new_owner && !plist_empty(&new_owner->pi_waiters)) {
		w = plist_entry(&new_owner->pi_waiters, struct
rt_mutex_waiter, pi_list);
		prio = w->task->prio;
	}
	if (prio != old_owner->prio)
		pi_setprio(lock, old_owner, prio);

What has new_owner to do with it? Shouldn't it be old_owner in these
lines? I.e. the prio we want to set old_owner to should be the prio of the
head of the old_owner->pi_waiters, not the new_owner!

Esben


On Mon, 11 Apr 2005, Ingo Molnar wrote:

> 
> * Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
> 
> > Let me re-phrase then: it is a must have only on PI, to make sure you 
> > don't have a loop when doing it. Maybe is a consequence of the 
> > algorithm I chose. -However- it should be possible to disable it in 
> > cases where you are reasonably sure it won't happen (such as kernel 
> > code). In any case, AFAIR, I still did not implement it.
> 
> are there cases where userspace wants to disable deadlock-detection for 
> its own locks?
> 
> the deadlock detector in PREEMPT_RT is pretty much specialized for 
> debugging (it does all sorts of weird locking tricks to get the first 
> deadlock out, and to really report it on the console), but it ought to 
> be possible to make it usable for userspace-controlled locks as well.
> 
> 	Ingo
> 

