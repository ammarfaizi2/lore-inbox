Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288397AbSAHVYQ>; Tue, 8 Jan 2002 16:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288393AbSAHVYJ>; Tue, 8 Jan 2002 16:24:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1802 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288394AbSAHVXz>; Tue, 8 Jan 2002 16:23:55 -0500
Message-ID: <3C3B605C.9B52A121@zip.com.au>
Date: Tue, 08 Jan 2002 13:10:52 -0800
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

That's theory.  Practice (ie: instrumentation) says that the preempt
patch makes little improvement over conditional yields in generic_file_read()
and generic_file_write().  Four lines.  Additional yields in wait_for_buffers()
(where we move zillions of buffers from BUF_LOCKED to BUF_CLEAN) and in submit_bh()
and bread() are cream.

Preemptability is global in its impact, and in its effect.  It requires
global changes to make it useful.  If we're prepared to make those
changes (scan_swap_map, truncate_inode_pages, etc) then fine.  Go for
it.  We'll end up with a better kernel.

> And while I'm enumerating differences, the preemptable kernel (in this
> incarnation) has a slight per-spinlock cost, while the non-preemptable kernel
> has the fixed cost of checking for rescheduling, at intervals throughout all
> 'interesting' kernel code, essentially all long-running loops.  But by clever
> coding it's possible to finesse away almost all the overhead of those loop
> checks, so in the end, the non-preemptible low-latency patch has a slight
> efficiency advantage here, with emphasis on 'slight'.
> 

As I said: I don't buy the efficiency worries at all.  If scheduling pressure
is so high that either approach impacts performance, then scheduling pressure
is too high.  We need to fix the context switch rate and/or speed up context
switches.  The overhead of conditional_schedule() or preempt will be zilch.

-
