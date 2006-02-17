Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWBQAUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWBQAUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWBQAUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:20:54 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:47848 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1161133AbWBQAUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:20:54 -0500
Date: Fri, 17 Feb 2006 01:20:18 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
In-Reply-To: <20060216233952.GB12143@elte.hu>
Message-Id: <Pine.OSF.4.05.10602170111450.22107-100000@da410>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > this is racy - we cannot know whether the PID wrapped around.
> > >
> > What about adding more bits to check on? The PID to lookup the task_t 
> > and then some extra bits to uniquely identify the actual task.
> 
> which would just be a fancy name for a wider PID space, and would thus 
> still not protect against PID reuse :-)
> 
Can it really be correct there is no way to uniquely identify a thread in
the uptime of the system? It could be done with BigIntegers :-)


> > > nor does this method offer any solution for the case where there are 
> > > already waiters pending: they might be hung forever. 
> >
> > It was for this case I suggested maintaining a list of waiters within 
> > the kernel on each task_t. The adding has to be done FUTEX_WAIT so the 
> > adding operation needs to be protected.
> 
> i'm not sure i follow - what list is this and how would it be 
> maintained?
>

At the FUTEX_WAIT operation add the waiter to a list of waiters on the
owner's task_t. At FUTEX_WAKE remove the waiter. At task exit wake up the
waiters.
 
> > > With our solution 
> > > one of those waiters gets woken up and notice that the lock is dead. 
> > > (and in the unlikely even of that thread dying too while trying to 
> > > recover the data, the kernel will do yet another wakeup, of the next 
> > > waiter.)
> > > 
> > I admit your solution is a good one. The only drawback - besides being 
> > untraditional - is that memory corruption can leave futexes locked at 
> > exit.
> 
> so? Memory corruption can overwrite the futex value anyway, and can thus 
> cause the wrong owner to be identified - causing a locked futex. This 
> patch does not protect against bad effects of memory corruption - 
> there's really no way to keep userspace from breaking itself.
> 

At least you could wake up those who are already blocked in the kernel...

Esben

> 	Ingo
> 

