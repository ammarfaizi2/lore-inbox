Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWEJNCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWEJNCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWEJNCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:02:25 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:40620 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751149AbWEJNCZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:02:25 -0400
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060510100858.GA31504@elte.hu>
References: <20060510112651.24a36e7b@frecb000686>
	 <20060510100858.GA31504@elte.hu>
Date: Wed, 10 May 2006 15:03:55 +0200
Message-Id: <1147266235.3969.31.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 15:02:34,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 15:02:36,
	Serialize complete at 10/05/2006 15:02:36
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 12:08 +0200, Ingo Molnar wrote:
> * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
> >   in the current futex implementation, tasks are woken up in FIFO 
> > order, (i.e. in the order they were put to sleep). For realtime 
> > systems needing system wide strict realtime priority scheduling, tasks 
> > should be woken up in priority order.
> > 
> >   This patchset achieves this by changing the futex hash bucket list 
> > into a plist. Tasks waiting on a futex are enqueued in this plist 
> > based on their priority so that they can be woken up in priority 
> > order.
> 
> hm, i dont think this is enough. Basically, waking up in priority order 
> is just the (easier) half of the story - what you want is to also 
> propagate priorities when you block. We provided a complete solution via 
> the PI-futex patchset (currently included in -mm).
> 
> In other words: as long as locking primitives go, i dont think real-time 
> applications should use wakeup-priority-ordered futexes, they should use 
> the real thing, PI futexes.

  Yeah, that's right as long as userland pthread_mutexes are used, but
currently, pthread_condvars do not use PI-futexes. Therefore when we
have some threads sleeping on a condvar and the condvar is broadcasted,
those blocked threads are woken up through futex_requeue() in the order
they were put to sleep and not in their priority order.

  Maybe the pthread_cond_*() function should be made to use the
PI-futexes support in glibc.

> 
> There is one exception: when a normal futex is used as a waitqueue 
> without any contention properties. (for example a waitqueue for worker 
> threads) But those are both rare, and typically dont muster tasks with 
> different priorities - i.e. FIFO is good enough.
> 
> Also, there's a performance cost to this. Could you try to measure the 
> impact to SCHED_OTHER tasks via some pthread locking benchmark?

  Right, I will try to quantify the impact for SCHED_OTHER tasks. Any
pointers to such a benchmark?

  Thanks,

  Sébastien.


