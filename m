Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDAVIq>; Sun, 1 Apr 2001 17:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRDAVIg>; Sun, 1 Apr 2001 17:08:36 -0400
Received: from nrg.org ([216.101.165.106]:21093 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132558AbRDAVIa>;
	Sun, 1 Apr 2001 17:08:30 -0400
Date: Sun, 1 Apr 2001 14:07:42 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <m14j5FD-001PKFC@mozart>
Message-ID: <Pine.LNX.4.05.10104011347060.14420-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2001, Rusty Russell wrote:
> > 		if (p->state == TASK_RUNNING ||
> > 				(p->state == (TASK_RUNNING|TASK_PREEMPTED))) {
> > 			p->flags |= PF_SYNCING;
> 
> Setting a running task's flags brings races, AFAICT, and checking
> p->state is NOT sufficient, consider wait_event(): you need p->has_cpu
> here I think.

My thought here was that if p->state is anything other than TASK_RUNNING
or TASK_RUNNING|TASK_PREEMPTED, then that task is already at a
synchonize point, so we don't need to wait for it to arrive at another
one - it will get a consistent view of the data we are protecting.
wait_event() qualifies as a synchronize point, doesn't it?  Or am I
missing something?

> The only way I can see is to have a new element in "struct
> task_struct" saying "syncing now", which is protected by the runqueue
> lock.  This looks like (and I prefer wait queues, they have such nice
> helpers):
> 
> 	static DECLARE_WAIT_QUEUE_HEAD(syncing_task);
> 	static DECLARE_MUTEX(synchronize_kernel_mtx);
> 	static int sync_count = 0;
> 
> schedule():
> 	if (!(prev->state & TASK_PREEMPTED) && prev->syncing)
> 		if (--sync_count == 0) wake_up(&syncing_task);

Don't forget to reset prev->syncing.  I agree with you about wait
queues, but didn't use them here because of the problem of avoiding
deadlock on the runqueue lock, which the wait queues also use.  The
above code in schedule needs the runqueue lock to protect sync_count.


Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

