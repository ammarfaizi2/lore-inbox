Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSFTAkh>; Wed, 19 Jun 2002 20:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318077AbSFTAkg>; Wed, 19 Jun 2002 20:40:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54516 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318076AbSFTAkb>;
	Wed, 19 Jun 2002 20:40:31 -0400
Message-ID: <3D11245F.DB13A07C@mvista.com>
Date: Wed, 19 Jun 2002 17:39:59 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <200206181829.WAA13590@sex.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > > But this is impossible, timers must not race with another BHs,
> > > all the code using BHs depends on this. That's why they are BHs.
> >
> > If indeed they do "race" the old code had the timer_bh being first.
> > So does this patch.
> 
> I do not understand what you mean here.
> 
> I feel you misunderstand my comment. I said the patch is one pure big bug,
> because tasklets are not serialized wrt BHs. Timer MUST. If you are going
> to get rid of this must, start from editing all the code which makes this
> assumption.

At this point I am only aware of one place in the kernel where timers and 
other BH code interact, that being deliver_to_old_ones() in net/core/dev.c.
Even there, it appears that the interaction is not with another BH but with
code that at one time was BH code.  As I understand it, BH and all of its
support stuff is being removed from the kernel.  That is why I was asked to
submit this patch.  So far, this is the only area that has come up as a 
locking or serialization problem.

As to this bit of code, it appears that changing it to do much the same as 
it did to the timer_bh to the new timer softirq should resolve the issue.

If you have additional input on this or other problems that need to be addressed,
I welcome it.

Correct me if I am wrong, but it looks like the network code has already left
the BH playing field.
> 
~snip
> 
> > Not really.  One REALLY expects timers to expire in timed order :)  Using
> > a separate procedure to deliver a timer just because it is of a different
> > resolution opens one up to a world of pathology.
> 
> Are you going to mix use of hires and lores timers for one task?  

Of course.  Why use high-res when you don't need it?  There is additional
overhead for high-res.  To require all timers to be high-res when only one
is needed is a waste.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
