Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTIWQSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbTIWQSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:18:39 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:27339 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261757AbTIWQSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:18:36 -0400
Date: Wed, 24 Sep 2003 00:24:34 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Waychison <michael.waychison@sun.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
In-Reply-To: <3F706764.1090203@sun.com>
Message-ID: <Pine.LNX.4.44.0309232348480.2808-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003, Mike Waychison wrote:

> I'm not extremely familiar with the autofs4 implementation, but why is 
> the expiring process in the wait queue to start off with?  Doesn't 
> autofs4 let the daemon's pgrp bypass the waitqueue completely?
> 

The daemon issues expire requests to the kernel module every timeout 
interval. When the kernel module identifies a eligible dentry to expire it 
posts a message to the user space daemon and waits on a wait queue for the 
daemon to signal completion. Any other process that do a lookup on the 
dentry being expired wait on the queue for completion. Upon completion 
the waiters are awoken. The O(1) scheduler never seems to pick the 
process that posted the expire whereas the 2.4 kernel does. I have tried 
an exclusive wait queue without success (among other things). Delaying 
waiters other than the owner seems a fairly effective method of 
letting the owner complete its task before the other waiters continue.

> > 
> > The problem of the remount that this causes remains and I an not sure how 
> > to deal with that at this stage.
> 
> This is purely a userspace issue.  Nautilus trampling all over the 
> filesystem is greatly unjustified.  If they want a decent filesystem 
> change notification system put in place, let them propose something. 
> Caching mountpoints entries is a bad idea.

Yes and maybe I can do something about in the userspace daemon, but it is 
a problem that exists and we need to ba aware of.

I have subscribed to the Nautilus list and got some pointers to the parts 
of the code that may be in question. I haven't had a chance to examine it 
yet.

> 
> > 
> > Comments and suggestions please.
> > 
> > Is this acceptable for inclusion in the kernel?
> > If so what should I do to make this happen?
> > 
> > diff -Nur autofs4-2.6.orig/fs/autofs4/autofs_i.h autofs4-2.6.deadlock/fs/autofs4/autofs_i.h
> > --- autofs4-2.6.orig/fs/autofs4/autofs_i.h	2003-09-09 03:50:14.000000000 +0800
> > +++ autofs4-2.6.deadlock/fs/autofs4/autofs_i.h	2003-09-22 22:48:11.000000000 +0800
> > @@ -82,6 +82,7 @@
> >  	char *name;
> >  	/* This is for status reporting upon return */
> >  	int status;
> > +	struct task_struct *owner;
> 
> This new field isn't even set anywhere!!

Right you are, sorry, I'll repost a corrected patch.

It's late and I'll have to test it again to make sure it works, so that 
won't be till tomorrow.

Clearly this will only work for the case of one additional waiter that is 
scheduled before the wait owner. The case that occurs here.

> 
> >  	int wait_ctr;
> >  };
> >  
> > diff -Nur autofs4-2.6.orig/fs/autofs4/waitq.c autofs4-2.6.deadlock/fs/autofs4/waitq.c
> > --- autofs4-2.6.orig/fs/autofs4/waitq.c	2003-09-09 03:50:31.000000000 +0800
> > +++ autofs4-2.6.deadlock/fs/autofs4/waitq.c	2003-09-23 00:02:29.209789432 +0800
> > @@ -206,6 +206,11 @@
> >  
> >  		interruptible_sleep_on(&wq->queue);
> >  
> > +		if (waitqueue_active(&wq->queue) && current != wq->owner) {
> > +			set_current_state(TASK_INTERRUPTIBLE);
> > +			schedule_timeout(wq->wait_ctr * (HZ/10));
> > +		}
> > +
> 
> This doesn't avoid the problem, it just makes it go away 99.99% of the 
> time.  I would suggest using a complete_all from the owner of the wq, 
> and let all other waiters wait for the completion.

I thought of that also. I tried to work a completion into the code without 
success. Anyway, an exclusive wait queue, similar in concept, didn't 
solve the problem. It was still be necessary to delay releasing 
other waiters.

Perhaps you would like to offer some code as an example of how best to do 
this with a completion or other means.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

