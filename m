Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVERRDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVERRDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVERRCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:02:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:454 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262374AbVERRAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:00:48 -0400
Date: Wed, 18 May 2005 10:00:39 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][UPDATE PATCH 2/4] convert soft-timer subsystem to timerintervals
Message-ID: <20050518170039.GD4205@us.ibm.com>
References: <20050518082141.GC4205@us.ibm.com> <20050518155927.8751.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518155927.8751.qmail@lwn.net>
X-Operating-System: Linux 2.6.12-rc4 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2005 [09:59:27 -0600], Jonathan Corbet wrote:
> Hi, Nishanth,
> 
> To my uneducated eye, this patch looks like a useful cleaning-up of the
> timer API.  I do have one question, though...

Thanks! I think one of the best side-effects (beyond a more accurate
execution of sleep requests) of my patch is that the new interfaces are
a heck of a lot saner :)

> > @@ -238,15 +327,41 @@ void add_timer_on(struct timer_list *tim
> >  	check_timer(timer);
> >  
> >  	spin_lock_irqsave(&base->lock, flags);
> > +	timer->expires = jiffies_to_timerintervals(timer->expires);
> 
> It would appear that, depending on where you are, ->expires can be
> expressed in two different units.  Users of add_timer() and mod_timer()
> are expecting jiffies, but the internal code uses timer intervals.  What
> happens when somebody does something like this?
> 
> 	mod_timer(&my_timer, my_timer.expires + additional_delay);
> 
> Might it be better to store the timerintervals value in a different
> field, and leave ->expires as part of the legacy interface only?

This is definitely an option. Currently, it is somewhat vague as to
whether, once a timer has been submitted, whether the expires field is
still valid to the caller. In the new system, it will clearly explicitly
not be (I meant to modify the comment to add_timer(), mod_timer() and
set_timer_nsecs() appropriately, but have not yet.

The problem with the mod_timer() approach you suggest is that there is
no guarantee that my_timer.expires represents anything close to the
current time. And, as far as my experience with reviewing the current
callers is concerned, there is no such usage.

It definitely is feasible and reasonable, though, to make that change. I
will look into it and see what I can do.

Thanks for the feedback!

-Nish
