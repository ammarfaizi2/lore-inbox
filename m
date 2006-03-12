Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWCLNJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWCLNJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWCLNJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:09:50 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53735
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750731AbWCLNJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:09:50 -0500
Subject: Re: [patch 5/8] hrtimer remove state field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0603121302590.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 14:10:10 +0100
Message-Id: <1142169010.19916.397.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 13:13 +0100, Roman Zippel wrote:
> >  		spin_lock_irq(&base->lock);
> >  
> > -		/* Another CPU has added back the timer */
> > -		if (timer->state != HRTIMER_INACTIVE)
> > -			continue;
> > -
> > -		if (restart != HRTIMER_NORESTART)
> > +		if (restart != HRTIMER_NORESTART &&
> > +		    !hrtimer_active(timer))
> >  			enqueue_hrtimer(timer, base);
> >  	}
> >  	set_curr_timer(base, NULL);
> 
> BTW the active check can be removed again, as it was added for a state 
> machine problem, I only didn't want to remove it for 2.6.16.

The check can not be removed. The reason why it was added is still the
same. 

It has nothing to do with a state machine. It's a simple SMP locking
issue.

softirq runs on CPU0
base->lock()

remove_timer(timer);

base->unlock()
			signal of previous expiry is delivered on CPU1
			timer is reqeued.
requeue = timer->fn();

base->lock()

if (requeue)
	enqueue_timer(timer)

--> OOPS

We can not wait in the signal delivery path until the callback has been
executed, as we hold the posix-timer->lock and this would deadlock
timer->fn().

	tglx


