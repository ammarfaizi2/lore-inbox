Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSIHSVC>; Sun, 8 Sep 2002 14:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSIHSVC>; Sun, 8 Sep 2002 14:21:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:36518 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S313060AbSIHSVB>;
	Sun, 8 Sep 2002 14:21:01 -0400
Message-ID: <3D7B9988.6B8CD04F@digeo.com>
Date: Sun, 08 Sep 2002 11:40:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <2090000.1031442267@flay> <1031504848.26888.238.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2002 18:25:36.0920 (UTC) FILETIME=[208CB180:01C25765]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sun, 2002-09-08 at 00:44, Martin J. Bligh wrote:
> > >> Perhaps testing with overcommit on would be useful.
> > >
> > > Well yes - the new overcommit code was a significant hit on the 16ways
> > > was it not?  You have some numbers on that?
> >
> > About 20% hit on system time for kernel compiles.
> 
> That suprises me a lot. On a 2 way and 4 way the 2.4 memory overcommit
> check code didnt show up. That may be down to the 2 way being on a CPU
> that has no measurable cost for locked operations and the 4 way being an
> ancient ppro a friend has.
> 
> If it is the memory overcommit handling then there are plenty of ways to
> deal with it efficiently in the non-preempt case at least. I had
> wondered originally about booking chunks of pages off per CPU (take the
> remaining overcommit divide by four and only when a CPU finds its
> private block is empty take a lock and redistribute the remaining
> allocation). Since boxes almost never get that close to overcommit
> kicking in then it should mean we close to never touch a locked count.

Martin had this profile for a kernel build on 2.5.31-mm1:



c01299d0 6761     1.28814     vm_enough_memory
c0114584 8085     1.5404      load_balance
c01334c0 8292     1.57984     __free_pages_ok
c011193c 11559    2.20228     smp_apic_timer_interrupt
c0113040 12075    2.3006      do_page_fault
c012bf08 12075    2.3006      find_get_page
c0114954 12912    2.46007     scheduler_tick
c012c430 13199    2.51475     file_read_actor
c01727e8 20440    3.89434     __generic_copy_from_user
c0133fb8 25792    4.91403     nr_free_pages
c01337c0 27318    5.20478     rmqueue
c0129588 36955    7.04087     handle_mm_fault
c013a65c 38391    7.31447     page_remove_rmap
c0134094 43755    8.33645     get_page_state
c0105300 57699    10.9931     default_idle
c0128e64 58735    11.1905     do_anonymous_page

We can make nr_free_pages go away by adding global free page 
accounting to struct page_states.  So we're accounting it in
two places, but it'll be simple.

The global page accounting is very much optimised for the fast path at
the expense of get_page_state().  (And that kernel didn't have the
rmap speedups).

We need to find some way of making vm_enough_memory not call get_page_state
so often.  One way of doing that might be to make get_page_state dump
its latest result into a global copy, and make vm_enough_memory()
only get_page_state once per N invokations.  A speed/accuracy tradeoff there.
