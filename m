Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbTFSPrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbTFSPrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:47:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43003 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265817AbTFSPrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:47:47 -0400
Message-ID: <3EF1DE35.20402@mvista.com>
Date: Thu, 19 Jun 2003 09:00:53 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Andrew Morton'" <akpm@digeo.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>,
       Robert Love <rml@mvista.com>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
 sks
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> Hi All
> 
> I have another test case that is showing this behavior.
> It is very similar to George's, however, it is a simplification
> of another one using threads that a co-worker, Adam Li found
> a few days ago.
> 
> Parent (FIFO 5) forks child that sets itself to FIFO 4 and 
> busy loops, then it sleeps five seconds and kills the child. 
> 
> Doing SysRq + T after a while shows the parent'd call trace 
> to be at sys_rt_sigaction+0xd1, that is just inside the final 
> copy_to_user() in signal.c:sys_rt_sigaction().
> 
> Reprioritizing events/0 to FIFO 5+ fixes the inversion. 
> 
> If I call nanosleep directly (with system() instead of
> glibc's sleep(), so I avoid all the rt_sig calls),
> I get the parent process always stuck in work_resched+0x5,
> in entry.S:work_resched, just after the call to the
> scheduler - however, I cannot trace what is happening
> inside the scheduler.
> 
> My point here is: I am trying to trace where this program
> is making use of workqueues inside of the kernel, and I
> can find none. The only place where I need to look some
> more is inside the timer code, but in a quick glance,
> it seems it is not being used, so why is it affected by
> the reprioritization of the events/0 thread? George, can
> you help me here?
> 

Hm!  I wonder.  Robert is working on a fix for schedsetschedule() 
where it fails to actually tell the scheduler to switch to a process 
that it just made higher priority or away from one it just lowered.

The net result is that the caller keeps running (FIFO for all in this 
case) when, in fact it should have been switched out.  Next time 
schedule() actually switches, it is all sorted out again.  Could the 
elavation of the events/0 thread cause this needed switch?

-g

> kernel is 2.5.67, SMP and PREEMPT with maxcpus=1; tomorrow
> I will try .72 ... 
> 
> Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
> (and my fault)
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

