Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288506AbSAHW1R>; Tue, 8 Jan 2002 17:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288510AbSAHW1H>; Tue, 8 Jan 2002 17:27:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18195 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288506AbSAHW07>; Tue, 8 Jan 2002 17:26:59 -0500
Message-ID: <3C3B70D7.43786888@zip.com.au>
Date: Tue, 08 Jan 2002 14:21:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16Nxjg-00009W-00@starship.berlin> <3C3B4CB7.FEAAF5FC@zip.com.au>,
		<3C3B4CB7.FEAAF5FC@zip.com.au> <E16O3L5-0000B8-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 8, 2002 08:47 pm, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > What a preemptible kernel can do that a non-preemptible kernel can't is:
> > > reschedule exactly as often as necessary, instead of having lots of extra
> > > schedule points inserted all over the place, firing when *they* think the
> > > time is right, which may well be earlier than necessary.
> >
> > Nope.  `if (current->need_resched)' -> the time is right (beyond right,
> > actually).
> 
> Oops, sorry, right.
> 
> The preemptible kernel can reschedule, on average, sooner than the
> scheduling-point kernel, which has to wait for a scheduling point to roll
> around.
> 

Yes.  It can also fix problematic areas which my testing
didn't cover.

Incidentally, there's the SMP problem.  Suppose we
have the code:

	lock_kernel();
	for (lots) {
		do(something sucky);
		if (current->need_resched)
			schedule();
	}
	unlock_kernel();

This works fine on UP, but not on SMP.  The scenario:

- CPU A runs this loop.

- CPU B is spinning on the lock.

- Interrupt occurs, kernel elects to run RT task on CPU B.
  CPU A doesn't have need_resched set, and just keeps 
  on going.  CPU B is stuck spinning on the lock.

This is only an issue for the low-latency patch - all the
other approaches still have sufficiently bad worse-case that
this scenario isn't worth worrying about.

I toyed with creating spin_lock_while_polling_resched(),
but ended up changing the scheduler to set need_resched
against _all_ CPUs if an RT task is being woken (yes, yuk).

-
