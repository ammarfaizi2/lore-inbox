Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSJRQkZ>; Fri, 18 Oct 2002 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265311AbSJRQkY>; Fri, 18 Oct 2002 12:40:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43771 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265306AbSJRQkU>;
	Fri, 18 Oct 2002 12:40:20 -0400
Message-ID: <3DB03AB5.99A91B6F@mvista.com>
Date: Fri, 18 Oct 2002 09:45:41 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
References: <1034915132.1681.144.camel@cog> 
		<20021018111442.GH16501@dualathlon.random> <1034957619.5401.8.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> 
> One reason gettimeofday ends up being important is that several
> databases call it a lot. They use it to build up a transaction id. Under
> big transaction loads, even the fast linux syscall path ends up being a
> bottleneck. Also, on NUMA machines the data used for time of day (xtime)
> ends up being a significant portion of the cache traffic.
> 
> It would be great to rework the whole TSC time of day stuff to work with
> per cpu data and allow unsychronized TSC's like NUMA. The problem is
> that for fast user level access, there would need to be some way to find
> out the current CPU and avoid preemption/migration for a short period.
> It seems like the LDT stuff for per-thread data could provide the
> current cpu (and maybe current pid) somehow.  And it would be possible
> to avoid  preemption while in a vsyscall text page, some other Unix
> variants do this to implement portions of the thread library in kernel
> provided user text pages.
> 
Now there is an idea!  Lock preemption in user space if and
only if the user is executing in a text page shared with the
kernel.  I have seen the need for such locking, but have
always thought they were too dangerous.  This convention
would introduce a much higher level of security.  What is
left is to devise a way to let the kernel know that the
preemption targeted task has left such a page so that the
preemption may proceed.  Possibly the kernel could plant a
hint on the page that each function would check for on exit.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
