Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTGOGnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTGOGnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:43:14 -0400
Received: from pop.gmx.net ([213.165.64.20]:4777 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263875AbTGOGnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:43:13 -0400
Message-Id: <5.2.1.1.2.20030715071702.01af6290@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 15 Jul 2003 09:02:20 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] N1int for interactivity
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org
In-Reply-To: <200307151403.33321.kernel@kolivas.org>
References: <20030714205915.5a4c8d16.akpm@osdl.org>
 <200307151355.23586.kernel@kolivas.org>
 <20030714205915.5a4c8d16.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:03 PM 7/15/2003 +1000, Con Kolivas wrote:
>On Tue, 15 Jul 2003 13:59, Andrew Morton wrote:
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > I've modified Mike Galbraith's nanosleep work for greater resolution to
> > > help the interactivity estimator work I've done in the O*int patches.

(I think a repeat of an earlier public warning wrt this diff may be in 
order: run irman/contest before you proceed... here there be giant economy 
sized dragons)

> > >
> > > +inline void __scheduler_tick(runqueue_t *rq, task_t *p)
> >
> > Two callsites, this guy shouldn't be inlined.

(I just wild-guessed that it'd be a tiny bit faster while i was coding... 
_the_ fast-path and all)

> >
> > Should it have static scope?  The code as-is generates a third copy...
> >
> > >  static unsigned long long monotonic_clock_tsc(void)
> > >  {
> > >     unsigned long long last_offset, this_offset, base;
> > > -
> > > +   unsigned long flags;
> > > +
> > >     /* atomically read monotonic base & last_offset */
> > > -   read_lock_irq(&monotonic_lock);
> > > +   read_lock_irqsave(&monotonic_lock, flags);
> > >     last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
> > >     base = monotonic_base;
> > > -   read_unlock_irq(&monotonic_lock);
> > > +   read_unlock_irqrestore(&monotonic_lock, flags);
> > >
> > >     /* Read the Time Stamp Counter */
> >
> > Why do we need to take a global lock here?  Can't we use
> > get_cycles() or something?

The scalability issue is gone I'm told.

 > Have all the other architectures been reviewed to see if they need this
> > change?
>
>I'm calling for help here. This is getting way out of my depth; I've simply
>applied Mike's patch.

Everyone will likely need that, or there will be major explosions.  You'll 
also have to deal with the no-tsc case... either return jiffies * 1000000 
or make it a config option.

(I'd go with a config option if I were you...dragons aren't all that likely 
to torch a desktop load, but if you do this globally, I'm quite certain 
that something is going to get char-broiled;)

         -Mike 

