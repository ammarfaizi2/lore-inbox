Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269823AbRHDHVz>; Sat, 4 Aug 2001 03:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269822AbRHDHVo>; Sat, 4 Aug 2001 03:21:44 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:35118 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S269823AbRHDHV2>; Sat, 4 Aug 2001 03:21:28 -0400
Message-Id: <4.3.2.7.2.20010803225855.00bc2a60@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 04 Aug 2001 00:21:11 -0700
To: <linux-kernel@vger.kernel.org>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108031907220.11893-100000@imladris.rielhom
 e.conectiva>
In-Reply-To: <007801c11c67$87d55980$b6562341@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:08 PM 8/3/01 -0300, you wrote:
>On Fri, 3 Aug 2001, Mike Black wrote:
>
> > Couldn't kswapd just gracefully back-off when it doesn't make any
> > progress? In my case (with ext3/raid5 and a tiobench test) kswapd
> > NEVER actually swaps anything out. It just chews CPU time.
>
> > So...if kswapd just said "didn't make any progress...*2 last sleep" so
> > it would degrade itself.
>
>It wouldn't just degrade itself.
>
>It would also prevent other programs in the system
>from allocating memory, effectively halting anybody
>wanting to allocate memory.

(Summary:  alternate view of the sleepy-kswapd suggestion, and a pointer to 
sysinfo(2) for userland programs to avoid allocating too much memory.)

While the idea halts other programs trying to allocate memory, it would 
provide cycles to programs that want to RELEASE memory (such as consuming 
data in network buffers) and thus reduce the kswapd thumb-twiddling time.

This is especially important when a piggy process is written to use the 
sysinfo(2) call to monitor resource usage.  (Reminder: sysinfo(2) is 
specific to Linux, and therefore not portable.)  There is no reason that a 
process that is a memory hog can't "play nice in the neighborhood".

A full treatment is off-topic for this list, but a brief summary would be 
useful:  the piggy process would monitor its own memory usage by doing 
bookkeeping on its malloc(2) and free(2) calls.  It would monitor via 
sysinfo(2) the amount of swap space remaining, and determine the percentage 
of swap space the piggy process is using.

The piggy process would have a low-water mark for memory usage (it could be 
a fixed amount such as 4 MB, or it could be a percentage of the available 
swap space, say 5%) which it would feel free to allocate at any time.  The 
piggy process would also have a high-water mark for memory usage, say 70% 
of swap space.

As the piggy process continues to execute, it monitors sysinfo(2).  If the 
system's free swap space falls below a threshold (say the larger of 15% or 
5 MB), the process will begin to shed memory allocations to free up space 
down to its low-water mark.  The intent here is that if two or more piggy 
processes are launched, they won't overload the system and kill each other 
via the OOM killer.

Mr. Baker, it's wonderful to say "Hey, the SYSTEM should take care of 
that."  The problem is, the userland application is as much a part of the 
system as the Linux kernel is.  All the kernel can do is try to minimize 
the carnage when two processes have a head-on collision.  It's up to the 
userland processes to avoid the collision in the first place.

To the rest of the kernel list:  apologies for taking up so much space with 
a userland issue.  The thing is, in the months I've seen the VM problem 
discussed, and the "zillionth person to complain about it," I haven't seen 
any pointer to any discussion about how userland programs can insulate 
themselves from being killed when they try to use up too much 
RAM.  Commercial quality programs, and programs wanting to use as much of 
the resources as possible to minimize run times, need to monitor what they 
are doing to the system and pull back when they tread toward suicide.

Put another way, people should NOT use safety nets as the only means of 
breaking a fall.

Satch

