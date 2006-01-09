Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWAIVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWAIVTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWAIVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:19:45 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:20127 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750723AbWAIVTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:19:44 -0500
Date: Mon, 9 Jan 2006 22:19:08 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <robustmutexes@lists.osdl.org>, <dino@in.ibm.com>,
       David Singleton <dsingleton@mvista.com>
Subject: Re: robust futex deadlock detection patch
In-Reply-To: <1136840886.6197.14.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0601092213580.19569-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Steven Rostedt wrote:

> On Mon, 2006-01-09 at 21:16 +0100, Esben Nielsen wrote:
>
> > You only take the spinlocks corresponding to the current lock. What about
> > the next locks in the chain? Remember those locks might not be
> > futexes but a lock inside the kernel, taken in system calls. I.e. the
> > robust_sem might not protect you.
> > If there are n locks you need to lock n lock->wait_lock and n
> > owner->task->pi_lock as you traverse the locks. That is what I tried to
> > sketch in the examble below.
>
> The thing about this is that you can't (if the kernel is not buggy)
> deadlock on the kernel spin locks.  As long as you protect the locks in
> the futex from deadlocking you are fine.  This is because you don't grab
> a futex after grabbing a kernel spin lock.  All kernel spin locks
> __must__ be released before going back to user land, and that's where
> you grab the futexes.
>
Yes, but the deadlock-detect code doesn't know what is a futex and what
isn't. Therefore when it starts to traverse rt_mutexes which aren't
futexes it has to be _very_ carefull taking the right spinlocks. On the
other hand when traversing the futexes it has to be carefull not to
deadlocks on those very same spinlocks.

And yes, you _can_ traverse the lock chain without deadlocking the kernel.
The code I sketched in the previouse mail should do it.

Anyway, I am trying to rewrite rt_mutex to remove the spinlock deadlock
altogether. My girlfriend is away with our daugther a few days so I might
get time to do finish it :-)

> -- Steve
>
>

Esben

