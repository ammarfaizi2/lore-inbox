Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSFDSHU>; Tue, 4 Jun 2002 14:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFDSHT>; Tue, 4 Jun 2002 14:07:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55291 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315266AbSFDSHS>; Tue, 4 Jun 2002 14:07:18 -0400
Subject: Re: [PATCH] scheduler hints
From: Robert Love <rml@tech9.net>
To: Simon Trimmer <simon@veritas.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206041826430.26249-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 11:07:18 -0700
Message-Id: <1023214038.912.128.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 10:38, Simon Trimmer wrote:

> Hi Robert,
> This isn't my thing but my flatmate had left a copy of solaris internals on
> the table ;)
> 
> This is briefly mentioned around about page 384 and appears to be targetted
> at userspace processes for exactly the cases you're suggesting (holding
> global resources).

I knew I read it there ;) My copy of "Solaris Internals" is elsewhere so
I could not confirm.

> A good entry point into the sun online documentation for this stuff is
> schedctl_init() -
> http://docs.sun.com/db?q=schedctl_init&p=/doc/816-0216/6m6ngupm0&a=view

Hm, what they export is a bit different.  I wonder what the internal
kernel interface is like (i.e. how close to sched_hint it is)?

Since they have a start_hint and stop_hint, that is where they are able
to enforce their fairness.  When you call stop, I suspect they penalize
your timeslice by some amount similar to the duration from start to
stop.  If you don't call stop before you reschedule, then you probably
forfeit a large chunk of your timeslice.

This would be doable with our scheduler - and perhaps even with minimal
impact (which is my goal).  However, since I wrote this more as an
exercise in fun than something to merge, I do not know if it is worth it
to make a whole infrastructure around this.  Those who really see
benefit (scientific computing or real-time or whatever) could just grab
the patch, remove the permission check, and code their applications to
fit -- they trust their application base.

Anyhow, to pique interest, here are some benchmark numbers.  I have 5
pthreads contesting over a single semaphore.  They loop, doing some busy
looping, down the semaphore, busy loop, and then up the semaphore.  Thus
they use a lot of their timeslice and spend the rest of the time
blocking on the semaphore.  I let them loop a fixed number of times
before exiting.

(These are average of ~10 runs)

With a call to sched_hint(HINT_TIME) after successfully downing the
semaphore the avg total duration is 7233459 us.  Without the sched_hint,
the avg total duration is 7683220 us.

That is an improvement of 6% - with only 5 threads.

A quick glance shows a reduction in context switches, but what really
matters is if we are entering schedule and neither (a) rescheduling the
same task, or (b) running another thread that quickly blocks on the
semaphore.

It is all academic anyhow...

	Robert Love

