Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbULZTbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbULZTbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 14:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbULZTbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 14:31:06 -0500
Received: from ssatchell1.pyramid.net ([208.170.252.115]:9925 "EHLO
	ssatchell1.pyramid.net") by vger.kernel.org with ESMTP
	id S261473AbULZTax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 14:30:53 -0500
Message-ID: <41CF116C.1030202@satchell.net>
Date: Sun, 26 Dec 2004 11:30:52 -0800
From: Stephen Satchell <list@satchell.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesse <jessezx@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
References: <20041221024347.3004.qmail@web52606.mail.yahoo.com>
In-Reply-To: <20041221024347.3004.qmail@web52606.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse wrote:
>  
> As i know, in linux, user space application is
> preemptive at any time. however, linux kernel is NOT
> preemptive, that means, even some event is finished,
> Linux kernel scheduler itself still can't have
> opportunity to interrupt the current user application
> and switch it out. it is called scheduler latency.
> normally , the latency is about 88us in mean , maximum
> : 200ms. Thus, the short latency shouldn't impact user
> applications too much and is not a problem. It is an
> issue in those embedded voice processing systems by
> introducing jitters, thus smart people came up with
> two kernel schedule patch: preemptive patch and low
> latency patch. 
> 
> My application which has nice value as 10 of low
> priority, however, it holds the CPU and excludes other
> applciations that have higher priority (nice 0) to
> run, my application causes CPU pegging. 
> 
> Thus, I am wondering: why  user space application
> can't be effectively interrupted? why there is CPU
> pegging?   Could you please educate me 
> on this particular issue and shed me some light to
> address it? 
> 
> my system: 
> [root@sa-c2-7 proc]# uname  -a 
> Linux sa-c2-7 2.4.21-15.ELsmp #1 SMP Thu Apr 22
> 00:18:24 EDT 2004 i686 i686 i386 GNU/Linux 

First, a pre-emption happens when an external event occurs that makes a 
higher priority task change state from blocked to ready-to-run, and the 
scheduling algorithm says that the new task should be run in place of 
the old task -- and the complexity of the time-slice schedule is such 
that your assumption doesn't always hold true.

If you have a low-priority task that needs to make sure that 
higher-priority functions *always* run, and you can't move up to the 2.6 
kernel (or even after moving up you find yourself with problems) the 
userland solution is a simple one:

   if (1) {
    struct timeval delay = {0,20000};
    select(0, NULL, NULL, NULL, &delay);
    }

(DON'T declare the variable delay as constant, because select modifies 
the contents of this variable.)

A number of real-time operating systems provide for a give-up-control 
system call, which says "if you have something better to do than to run 
me, then do it" for just this sort of thing.  The legacy of the Linux 
schedules being from a classic time-sharing system, which trys to 
implement "fairness" in allocating CPU resources,  there is no 
equivalent call that I'm aware of.

So you have to make your program block in order to guarantee that you 
give up the CPU.  The delay of 20 ms in my example call assumes your HZ 
value is 100, and that you really don't mind having a few idle CPU 
cycles if your higher-priority program isn't ready to run when you make 
the select call.  In my Web servers, I use 100 ms delays to ensure that 
I/O for other processes is allowed to take place; Webalizer stats, for 
example, have hogged disk access to the point that it impacts the entire 
system, so I've inserted the Perl equivalent of the above code in key 
places so that background tasks really do run in the background.

A delay value of zero to select is, I believe, an effective no-operation 
which may or may not trigger a scheduling event.  (I looked a long time 
ago at this -- many, MANY kernels ago -- and it's as though you didn't 
make the call at all, absent the CPU cycles expended to make the call 
and for the kernel to get back to the userland task.)  A value of 10 ms 
(on a system with HZ set to 100) can also be taken as though you coded 
zero in some cases -- at least some code I wrote a couple of years ago 
suggests this.

Why select?  I write portable code, and this is in my cookbook.  There 
is a nanosleep system call that is part of POSIX, and that looks to be a 
preferable way to deal with things.  You would need to look at the Linux 
source code to see what a nanosleep with a value of one nanosecond does, 
and whether that's guaranteed to block your code for one scheduling cycle.

How frequently you put scheduling breaks into your code is up to you.  I 
typicall profile code, and try to put in scheduling breaks at 1/4 of the 
desired system response latency.  For a 100 ms latency, that means that 
I do scheduling breaks no less frequently than 25 ms., and in many cases 
more often than that.  Don't forget that I/O provides breaks, too, so 
the number of places where you need to put in explicit scheduling breaks 
may be small, indeed.

For Webalizer, I run a scheduling break every 100 lines read from the 
log files.  That count, by experimentation, has shown to provide a good 
balance between throughout of the background process and system reaction 
latency.  That's stuff running on a 2.4 kernel, by the way, because I'm 
slow to adopt new, bleeding-edge stuff in my production environments.

A couple of thoughts from a different place in the trenches.

Stephen Satchell

