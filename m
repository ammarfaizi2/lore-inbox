Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSJ3HuY>; Wed, 30 Oct 2002 02:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSJ3HuY>; Wed, 30 Oct 2002 02:50:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:57078 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264617AbSJ3HuX>;
	Wed, 30 Oct 2002 02:50:23 -0500
Message-ID: <3DBF90A8.9989492C@mvista.com>
Date: Tue, 29 Oct 2002 23:56:24 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 8
References: <3DBEE360.EE73EF8C@mvista.com> <1035935049.1580.463.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> 
> Your patch adds a new config option that seems like a step backwards in
> ease of use. The CONFIG_TIMERLIST option is adding a new dimension to
> complexity kernel configuration. For no other parameter that I can think
> of does the kernel configuration process ask for a size information.
> Number of users, processes, threads, groups, are all sized dynamically
> now; this is good.
> 
> How is the end user supposed to know how many timer list entries are
> expected?  There is no context about what a timer list entry is and no
> direct correlation back to anything meaningful in user terms (processes,
> devices, sockets, ...).  Also, what happens if the time list size is
> exhausted? does the kernel die? is it slower?...
> 
Ok, first, somehow in the chase to stay up with 2.5, this
bit was lost:
Configure timer list size
CONFIG_TIMERLIST_512
  This choice allows you to choose the timer list size you
want.  The
  list insert time is Order(N/size) where N is the number of
active
  timers.  Each list head is 8 bytes, thus a 512 list size
requires 4K
  bytes.  Use larger numbers if you will be using a large
number of
  timers and are more concerned about list insertion time
than the extra
  memory usage.  (The list size must be a power of 2.)

from the Config.help file.  The timer list is a hash list
and the size this lets you set changes the number of
buckets, the only affect its size has is on the insertion
time, more buckets => faster.  So the kernel does not die
and the list will never be exhausted (or even full).

> Can't this just be dynamically sized?

As to choosing it dynamically, it needs to be fixed rather
early in the game, compile time or boot time, no later. 

That said, we have run tests to see how the list insert time
varies with number of timers (in fact the test program is in
the support package on the sourceforge site, called
"performance.c" in the tests directory once you install that
package).  The test was done with a 512 entry list and with
1 to 4000 timers.  Insertion time went from about 4 micro
seconds to about 7 over that range, with the first insert
taking about 40 micro seconds.  The conclusion was that the
cache misses on the first insertion were FAR more important
than the list size.

Also, since that time, Ingo's salability changes went in,
which means that each cpu has its own list.

The net of all this is that, on reflection, I think I will
remove the configure option on timer list size.  I will
leave the code in place so that, if some special application
wants to change it, it will be easy to do, much as changing
HZ (only easier as it has NO impact outside of the kernel).

Thanks for bringing this to my attention.  The patch for the
next bk release will reflect this change.



-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
