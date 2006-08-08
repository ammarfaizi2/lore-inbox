Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWHHIMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWHHIMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWHHIMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:12:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21379 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932562AbWHHIME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:12:04 -0400
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
	aliasing problem)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, schwidefsky@googlemail.com,
       johnstul@us.ibm.com, zippel@linux-m68k.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, ak@muc.de
In-Reply-To: <20060807125810.e021c91b.akpm@osdl.org>
References: <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
	 <20060804.005352.128616651.anemo@mba.ocn.ne.jp>
	 <6e0cfd1d0608040702h15371d31q1c3d1c305c3da424@mail.gmail.com>
	 <20060807.011319.41196590.anemo@mba.ocn.ne.jp>
	 <20060807125810.e021c91b.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 08 Aug 2006 10:11:59 +0200
Message-Id: <1155024719.26277.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 12:58 -0700, Andrew Morton wrote:
> > [PATCH] cleanup do_timer and update_times
> > 
> > Pass ticks to do_timer() and update_times().
> > 
> > This also make a barrier added by
> > 5aee405c662ca644980c184774277fc6d0769a84 needless.
> > 
> > Also adjust x86_64 and s390 timer interrupt handler with this change.
> > 
> 
> This is a rather terse description for a change of this nature..
> 
> Why was this patch created?  What problem is it solving?  etcetera.

The problem is that we are wasting time calling do_timer in a loop. This
is especially true on system that switch off the timer interrupt while
the cpu is idle. You can easily have thousands of lost ticks.

> > ...
> >
> > --- a/kernel/timer.c
> > +++ b/kernel/timer.c
> > @@ -1218,7 +1218,7 @@ static inline void calc_load(unsigned lo
> >  	static int count = LOAD_FREQ;
> >  
> >  	count -= ticks;
> > -	if (count < 0) {
> > +	while (count < 0) {
> >  		count += LOAD_FREQ;
> >  		active_tasks = count_active_tasks();
> >  		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> 
> OK, we do need the loop here to get the arithmetic in CALC_LOAD to work
> correctly.
> 
> But I don't think the expensive count_active_tasks() needs to be evaluated
> each time around.

This is what I hoped would happen. The loops gets pushed through the
layers to the place where it is actually needed. The next step could be
to get rid of the loop altogether by changing CALC_LOAD.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


