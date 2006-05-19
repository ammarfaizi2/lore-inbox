Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWESBII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWESBII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWESBII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:08:08 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:31973 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932112AbWESBIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:08:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Fri, 19 May 2006 11:07:40 +1000
User-Agent: KMail/1.9.1
Cc: "Mike Galbraith" <efault@gmx.de>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>
References: <4t153d$14p68g@azsmga001.ch.intel.com>
In-Reply-To: <4t153d$14p68g@azsmga001.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605191107.40770.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 May 2006 09:34, Chen, Kenneth W wrote:
> Con Kolivas wrote on Wednesday, May 17, 2006 10:52 PM
>
> > The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
> > and not explicit enough. The sleep boost is not supposed to be any larger
> > than without this code and the comment is not clear enough about what
> > exactly it does, just the reason it does it.
> >
> > There is a ceiling to the priority beyond which tasks that only ever
> > sleep for very long periods cannot surpass.
> >
> > Opportunity to micro-optimise and re-use the ceiling variable.
> >
> > --- linux-2.6.17-rc4-mm1.orig/kernel/sched.c	2006-05-17
> > 15:57:49.000000000 +1000 +++
> > linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-18 15:48:47.000000000 +1000
> > @@ -925,12 +924,12 @@ static int recalc_task_prio(task_t *p, u
> >  			 * are likely to be waiting on I/O
> >  			 */
> >  			if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
> > -				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
> > +				if (p->sleep_avg >= ceiling)
> >  					sleep_time = 0;
> >  				else if (p->sleep_avg + sleep_time >=
> > -						INTERACTIVE_SLEEP(p)) {
> > -					p->sleep_avg = INTERACTIVE_SLEEP(p);
> > -					sleep_time = 0;
> > +					 ceiling) {
> > +						p->sleep_avg = ceiling;
> > +						sleep_time = 0;
>
> Watch for white space damage, last two lines has one extra tab on the
> indentation.

Hmm a component of the if() is up to that tab so it seemed appropriate to 
indent the body further to me.

> By the way, there is all kinds of non-linear behavior with priority boost
> adjustment:
>
>         if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
>                 if (p->sleep_avg >= ceiling)
>                         sleep_time = 0;
>                 else if (p->sleep_avg + sleep_time >= ceiling) {
>                         p->sleep_avg = ceiling;
>                         sleep_time = 0;
>                 }
>         }
>
> For large p->sleep_avg, kernel don't clamp it to ceiling, yet clamp small
> incremental sleep.  This all seems very fragile.

Yes it is. sleep_avg affecting priority in a linear fashion in the original 
design was basically the reason interactivity was not flexible enough for a 
wide range of workloads. I don't like it much myself any more either, and 
have been maintaining a complete rewrite for some time. However the fact is 
that the number of valid bug reports is very low, so tiny tweaks as issues 
have come up have sufficed so far.

-- 
-ck
