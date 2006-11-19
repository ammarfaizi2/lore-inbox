Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933154AbWKSUMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbWKSUMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933155AbWKSUMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:12:18 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:42967 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S933154AbWKSUMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:12:17 -0500
Date: Sun, 19 Nov 2006 15:12:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061118224627.GA270@oleg>
Message-ID: <Pine.LNX.4.44L0.0611191457440.15059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Oleg Nesterov wrote:

> > Put it this way: If the missing memory barrier in srcu_read_lock() after
> > the atomic_inc call isn't needed, then neither is the existing memory
> > barrier after the per-cpu counter gets incremented.
> 
> I disagree. There is another reason for mb() after the per-cpu counter gets
> incremented. Without this barrier we can read the updated value of ->completed
> (incremented by synchronize_srcu()), but then read a stale data of the rcu
> protected memory.

You are right.

> > What you're ignoring is the synchronize_sched() call at the end of
> > synchronize_srcu(), which has been replaced with smp_mb().  The smp_mb()
> > needs to pair against a memory barrier on the read side, and that memory
> > barrier has to occur after srcu_read_lock() has incremented the counter
> > and before the read-side critical section begins.  Otherwise code in the
> > critical section might leak out to before the counter is incremented.
> 
> Still I am not sure you are right. It is ok (I think) if the code in the
> critical section leaks out to before the atomic_inc(). In fact this doesn't
> differ from the case when srcu_read_lock() happens before synchronize_srcu()
> starts. In that case synchronize_srcu() will wait until the critical section
> is closed via srcu_read_unlock(). Because of synchronize_sched() synchronize_srcu()
> can't miss the fact that the critical section is in progress, so it doesn't
> matter if it leaks _before_.

That's right.  I was forgetting an important difference between the c[idx]
and the hardluckref paths:  With c[idx] there has to be 2-way
communication (writer increments completed, then reader increments
c[idx]).  With hardluckref there is only 1-way communication (reader
increments hardluckref).  The synchronize_sched call takes care of the
reader->writer message; the memory barrier is needed for the
writer->reader message.  Hence it isn't necessary after the atomic_inc.

But of course it _is_ needed for the fastpath to work.  In fact, it might 
not be good enough, depending on the architecture.  Here's what the 
fastpath ends up looking like (using c[idx] is essentially the same as 
using hardluckref):

	WRITER				READER
	------				------
	dataptr = &(new data)		atomic_inc(&hardluckref)
	mb				mb
	while (hardluckref > 0) ;	access *dataptr

Notice the pattern: Each CPU does store-mb-load.  It is known that on 
some architectures each CPU can end up loading the old value (the value 
from before the other CPU's store).  This would mean the writer would see 
hardluckref == 0 right away and the reader would see the old dataptr.

On architectures where the store-mb-load pattern works, the fastpath would 
be safe.  But on others it would not be.

Heh, Paul, this highlights the usefulness of our long discussion about 
memory barrier semantics.  :-)

Alan

