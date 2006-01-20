Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWATQ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWATQ5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWATQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:57:34 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21127
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751089AbWATQ5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:57:34 -0500
Subject: Re: [PATCH 7/7] [hrtimers] Set correct initial expiry time for
	relative SIGEV_NONE timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mwildturkeyranch.net
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <43D110C3.6020604@wildturkeyranch.net>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
	 <20060120021343.296071000@tglx.tec.linutronix.de>
	 <43D110C3.6020604@wildturkeyranch.net>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 17:58:12 +0100
Message-Id: <1137776292.28034.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 08:33 -0800, George Anzinger wrote:
> > a1f15939b7af18c5abcd4810ccd512467c77a6b1
> > diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
> > index 28e72fd..e2fa4c0 100644
> > --- a/kernel/posix-timers.c
> > +++ b/kernel/posix-timers.c
> > @@ -724,8 +724,13 @@ common_timer_set(struct k_itimer *timr, 
> >  	timr->it.real.interval = timespec_to_ktime(new_setting->it_interval);
> >  
> >  	/* SIGEV_NONE timers are not queued ! See common_timer_get */
> > -	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
> > +	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
> > +		/* Setup correct expiry time for relative timers */
> > +		if (mode == HRTIMER_REL)
> > +			timer->expires = ktime_add(timer-expires,
> > +						   timer->base->get_time());
> This is only part of the problem.  When the user does a timer_gettime() the 
> expiry time is taken from the hrtimer field and NOT the posix-timer part. 
> Somewhere this value needs to be copied to the hrtimer sub structure.

Well timer->expires is the hrtimer struct itself.

	tglx




