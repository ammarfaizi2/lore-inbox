Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284968AbRLFEVM>; Wed, 5 Dec 2001 23:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284969AbRLFEVD>; Wed, 5 Dec 2001 23:21:03 -0500
Received: from mangalore.zip.com.au ([203.12.97.48]:12558 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284968AbRLFEUu>; Wed, 5 Dec 2001 23:20:50 -0500
Message-ID: <3C0EF20C.36449AAB@zip.com.au>
Date: Wed, 05 Dec 2001 20:20:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0
In-Reply-To: Your message of "Wed, 05 Dec 2001 14:13:17 -0800."
	             <3C0E9BFD.BC189E17@zip.com.au> <E16Bo4c-00031f-00@wagner>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3C0E9BFD.BC189E17@zip.com.au> you write:
> > Rusty Russell wrote:
> > >
> > > PS.  Also would be nice to #define del_timer del_timer_sync, and have a
> > >      del_timer_async for those (very few) cases who really want this.
> >
> > That could cause very subtle deadlocks.   I'd prefer to do:
> >
> > #define del_timer_async       del_timer
> 
> I'd prefer to audit them all, create a patch, and remove del_timer.
> Doing it slowly usually means things just get forgotten, then hacked
> around when it finally gets ripped out.

um.  Auditing them all is a big task:

akpm-1:/usr/src/linux-2.4.17-pre4> grep -r del_timer . | wc
    800    2064   48299
akpm-1:/usr/src/linux-2.4.17-pre4> grep -r del_timer_sync . | wc 
     85     245    5384

I tried it, when I was a young man.

One mindset would be to just replace all the del_timer calls
with del_timer_sync by default, and to then look for the below
deadlock pattern.   But if you do this, Alexey shouts at you,
because his code actually gets del_timer right, by looking at
its return value.

I'd urge you to reconsider.  We have a *lot* of timer deletion
races in Linux, and squashing them all in one patch just isn't
feasible.

> The deadlock you're referring to is, I assume, del_timer_sync() called
> inside the timer itself?  Can you think of any other dangerous cases?

Nope.  The deadlock is where the caller of del_timer_sync holds
some lock which would prevent the completion of the timer handler.
It happens, and is sometimes subtle.

drivers/video/txfxfb.c is an unsubtle example.

-
