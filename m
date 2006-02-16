Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWBPXYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWBPXYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBPXY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:24:29 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:28644 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932507AbWBPXY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:24:29 -0500
Date: Fri, 17 Feb 2006 00:20:34 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
In-Reply-To: <20060216223618.GA8182@elte.hu>
Message-Id: <Pine.OSF.4.05.10602170003380.22107-100000@da410>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > As I understand the protocol the userspace task writes it's pid into 
> > the lock atomically when locking it and erases it atomically when it 
> > leaves the lock. If it is killed inbetween the pid is still there. Now 
> > if another task comes along it reads the pid, sets the wait flag and 
> > goes into the kernel. The kernel will now be able to see that the pid 
> > is no longer valid and therefore the owner must be dead.
> 
> this is racy - we cannot know whether the PID wrapped around.
>
What about adding more bits to check on? The PID to lookup the task_t and
then some extra bits to uniquely identify the actual task.
 
> nor does this method offer any solution for the case where there are 
> already waiters pending: they might be hung forever. 
It was for this case I suggested maintaining a list of waiters within the
kernel on each task_t. The adding has to be done FUTEX_WAIT so the adding
operation needs to be protected.

> With our solution 
> one of those waiters gets woken up and notice that the lock is dead. 
> (and in the unlikely even of that thread dying too while trying to 
> recover the data, the kernel will do yet another wakeup, of the next 
> waiter.)
> 
I admit your solution is a good one. The only drawback - besides being
untraditional - is that memory corruption can leave futexes locked at
exit.

Esben

> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

