Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVISAr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVISAr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 20:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVISAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 20:47:29 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:14018 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932272AbVISAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 20:47:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bernardo Innocenti <bernie@develer.com>
Subject: Re: RFA: Changing scheduler quantum (Was: REQUEST: OpenLDAP 2.3.7)
Date: Mon, 19 Sep 2005 10:46:59 +1000
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjanv@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <432B9F4A.6070805@develer.com> <200509182144.50571.kernel@kolivas.org> <432DE1C9.5050809@develer.com>
In-Reply-To: <432DE1C9.5050809@develer.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509191046.59801.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005 07:53, Bernardo Innocenti wrote:
> Con Kolivas wrote:
> > On Sun, 18 Sep 2005 21:37, Bernardo Innocenti wrote:
> >>The DEF_TIMESLICE of 400ms looks a bit too gross for
> >>most applications and the maximum 800ms is just
> >>ridicolously high.
> >
> > Not quite.
> >
> > The default timeslice of nice 0 tasks is 100ms. The timeslice is not
> > altered the way you have read sched.c. It is altered thus:
> > 1. For 'nice' levels it varies from 5ms at nice 19 to 800ms at nice -20.
> > 2. For interactive tasks, it is cut up into smaller pieces down to 10ms
> > and round robins with other tasks at the same dynamic priority, but still
> > is based on the nice levels for the full length of cpu time before
> > expiration overall.

Please do not cc mailing lists that reply with the "your email is awaiting 
moderator approval" to lkml.

> I see.  Then there must be something else to explain
> the behavior I'm observing with slapd.
>
> Each and every call to sched_yield() makes the process
> sleep for over *50ms* while a "nice make bootstrap" is
> running in the background:

Why this preoccupation with how long sched_yield takes? We've already 
established that it takes a variable unpredictable (yet long) time for 
SCHED_NORMAL tasks. No, cancel that question or we'll start having people 
tell us what the kernel should do all over again.

You're almost certainly seeing the effect of fork during 'make bootstrap' and 
multiple tasks are running prior to expiration on the active runqueue. 
SCHED_NORMAL tasks that have done sched_yield will yield till nothing is left 
wanting cpu time on the active runqueue.

> Actually, I'm now noticing that several slapd threads were
> involved here.  Depending how strace handles relative
> timestamps of multiple processes, it may mean both 8780 and
> 8781 slept too much or just 8781 did and 8780 was quick.
>
> Any idea?  I'm planning to patch my kernel to print the
> time_slice value in /proc/*/stat.  This way I can check
> it's being computed as intended for both slapd and gcc.

Feel free to do as much checking on kernel code as you like.

Cheers,
Con
