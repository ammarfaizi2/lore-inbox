Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTFPKNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 06:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTFPKNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 06:13:25 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:43533 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263638AbTFPKNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 06:13:24 -0400
Date: Mon, 16 Jun 2003 12:27:42 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Rusty Russell <rusty@rustcorp.com.au>
cc: NeilBrown <neilb@cse.unsw.edu.au>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules.
In-Reply-To: <20030616092316.3E31B2C013@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306161145570.2079-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Rusty Russell wrote:

> > You mean your cleanup_thread would block for completion of the keventd 
> > stuff? Ok, this would work. But then, when calling cleanup_thread, f.e. we 
> > must not hold any semaphore which might be acquired by _any_ other work 
> > scheduled for keventd or we might end in deadlock (like the rtnl+hotplug 
> > issue we had seen recently).
> 
> I think we're talking across each other: take a look at the existing
> kernel/kmod.c __call_usermodehelper to see how we wait at the moment.

Maybe talking across each other... what I meant is some deadlock like 
this (IMHO possible both on UP and SMP):

rmmod (f.e.)			keventd			somewhere else

down(&some_sem)
cleanup_thread()
	.
	.						schedule_work(w1)
	.
	.		w1 (queued, or maybe running):
	.			down(&some_sem);
	.			...
	.			up(&some_sem);
	.
schedule_work(w2)
	.
	.		w2 (queued behind w1)
	.			should_die = 1
	.			sys_wait4()
	.			complete(thread_exit)
	.
/* some_sem still hold */
wait_for_completion(thread_exit)


Next time we schedule keventd w1 will be executed first which wants to 
acquire some_sem which is still hold by the rmmod-thread - which in turn 
blocks for completion of w2 which is queued behind w1 -> deadlock.

The point is the queueing in keventd combined with stuff waiting for 
keventd-completion could create some possibilities for lock order 
violation which are at least not very obvious.

IMHO cleanup_thread would be something one MUST NOT call with any lock 
hold, not even a semaphore if it might get acquired anywhere else in 
keventd-context.

Thanks.
Martin

