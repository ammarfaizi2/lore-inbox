Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTE2Flv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTE2Flv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:41:51 -0400
Received: from imap.gmx.net ([213.165.64.20]:35041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261873AbTE2Flt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:41:49 -0400
Message-Id: <5.2.0.9.2.20030529062657.01fcaa50@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 29 May 2003 07:59:22 +0200
To: Bill Davidsen <davidsen@tmr.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030528180909.21414B-100000@gatekeeper.tmr.c
 om>
References: <20030521135154.GA15462@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:12 PM 5/28/2003 -0400, Bill Davidsen wrote:
>On Wed, 21 May 2003, Olivier Galibert wrote:
>
> > On Wed, May 21, 2003 at 03:12:12PM +0200, Arjan van de Ven wrote:
> > > if you had spent the time you spent on this colorful graphic on reading
> > > SUS or Posix about what sched_yield() means, you would actually have
> > > learned something. sched_yield() means "I'm the least important thing in
> > > the system".
> >
> > Susv2:
> >
> > DESCRIPTION
> >
> >  The sched_yield() function forces the running thread to relinquish
> >  the processor until it again becomes the head of its thread list. It
> >  takes no arguments.
> >
> >
> > Aka "I skip the rest of my turn, try the others again once", not "I'm
> > unimportant" nor "please rerun me immediatly".
> >
> > What is it with you people wanting to make sched_yield() unusable for
> > anything that makes sense?
>
>Have to agree, I have a context switching benchmark which uses a spinlock
>in shared memory for do-it-yourself gating, and it wants sched_yeild() to
>be useful on uni. The SuS is pretty clear about this, the useful behaviour
>is also the required behaviour, why are people resisting doing it that
>way?

It can be argued that the current implementation does exactly what SuS 
describes.  The thread's list can be considered to be the sum of the active 
queue and the expired queue.  Merely rotating the active queue and 
scheduling away excludes the yielding thread's equally important expired 
peers from participation in the game.  Furthermore, if you are the only 
thread left in the active array, (you are at the head obviously), and all 
of your peers are currently expired, yielding would become meaningless... 
the thing you're trying to yield (the remainder of your slice) sticks to you.

Having said that, it can also be argued that we are violating the SuS 
description in that yielding the remainder of your slice yields to all 
threads in all lists, not only it's list.  What makes more sense to me than 
the current implementation is to rotate the entire peer queue when a thread 
expires... ie pull in the head of the expired queue into the tail of the 
active queue at the same time so you always have a player if one 
exists.  (you'd have to select queues based on used cpu time to make that 
work right though)

That would still suck rocks for mutex usage... as it must with any 
implementation of sched_yield() in the presence of peer threads who are not 
playing with the mutex.  Actually, using sched_yield() makes no sense what 
so ever to me, other than what Arjan said.  It refers to yielding your 
turn, but from userland "your turn" has no determinate meaning.  There is 
exactly one case where it has a useable value, and that is  when you're the 
_only_ runnable thread... at which time it means precisely zero. (blech)

         -Mike 

