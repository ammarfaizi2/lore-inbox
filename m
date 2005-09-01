Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbVIAWZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVIAWZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVIAWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:25:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44510 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030467AbVIAWZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:25:18 -0400
Subject: Re: [RFC][PATCH] Use proper casting with signed timespec.tv_nsec
	values
From: john stultz <johnstul@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4317749E.3020109@cosmosbay.com>
References: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
	 <4317749E.3020109@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 01 Sep 2005 15:25:14 -0700
Message-Id: <1125613515.22448.12.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 23:37 +0200, Eric Dumazet wrote:
> john stultz a écrit :
> > All,
> > 	I recently ran into a bug with an older kernel where xtime's tv_nsec
> > field had accumulated more then 2 seconds worth of time. The timespec's
> > tv_nsec is a signed long, however gettimeofday() treats it as an
> > unsigned long. Thus when the failure occured, very strange and difficult
> > to debug time problems occurred.
> > 
> > The main cause of the problem I was seeing is already fixed in mainline,
> > however just to be safe, I figured the following patch would be wise.
> > 
> > I only audited i386 and x86_64, however other arches probably could have
> > similar signed problems as well.
> > 
> > Please let me know if you have any further comments or feedback.
> 
> What happens on i386 when/if more than 4 seconds accumulate ?

Well, then we overflow.

> That should happens too.
> Maybe the real fix is elsewhere ?

We just don't have much more then 4 seconds worth of bits there. So I
don't know what your suggesting. Granted, my patch is a bit paranoid, it
tries to make the casts more explicit so when something goes wrong, it
makes more sense (then, say, strange 70minute jumps in time caused by
the signed divide being implicitly cast unsigned).

> > 
> > linux-2.6.13_signed-tv_nsec_A0.patch
> > ====================================
> > --- a/kernel/timer.c
> > +++ b/kernel/timer.c
> > @@ -824,7 +824,7 @@ static void update_wall_time(unsigned lo
> >  	do {
> >  		ticks--;
> >  		update_wall_time_one_tick();
> > -		if (xtime.tv_nsec >= 1000000000) {
> > +		if ((unsigned long)xtime.tv_nsec >= 1000000000) {
> >  			xtime.tv_nsec -= 1000000000;
> >  			xtime.tv_sec++;
> >  			second_overflow();
> > 
> 
> maybe here a :
> 
> while ((unsigned long)xtime.tv_nsec >= 1000000000) {
> 	xtime.tv_nsec -= 1000000000;
> 	xtime.tv_sec++;
> 	second_overflow();
> 	...
> 	}

That would only be necessary if update_wall_time_one_tick() could
increment tv_nsec by more then 1 billion. That seems to be a touch
over-cautious, considering we're already in a while loop. 

thanks
-john

