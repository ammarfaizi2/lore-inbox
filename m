Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSALTQh>; Sat, 12 Jan 2002 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287334AbSALTQ1>; Sat, 12 Jan 2002 14:16:27 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:25499 "EHLO
	out007pub.verizon.net") by vger.kernel.org with ESMTP
	id <S287333AbSALTQT>; Sat, 12 Jan 2002 14:16:19 -0500
Message-ID: <3C408B78.6050102@bellatlantic.net>
Date: Sat, 12 Jan 2002 14:16:08 -0500
From: "James C. Owens" <owensjc@bellatlantic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020105
X-Accept-Language: en-us
MIME-Version: 1.0
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: O(1) scheduler ver H6 - more straightforward timeslice macros
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I like the new scheduler. It seems like the timeslice macros in sched.h 
could be more straighforward - i.e. instead of

#define PRIO_TO_TIMESLICE(p) \
((( (MAX_USER_PRIO-1-USER_PRIO(p))*(MAX_TIMESLICE-MIN_TIMESLICE) + \
MAX_USER_PRIO-1) / MAX_USER_PRIO) + MIN_TIMESLICE)

#define RT_PRIO_TO_TIMESLICE(p) \
((( (MAX_RT_PRIO-(p)-1)*(MAX_TIMESLICE-MIN_TIMESLICE) + \
MAX_RT_PRIO-1) / MAX_RT_PRIO) + MIN_TIMESLICE)

why not

#define PRIO_TO_TIMESLICE(p) \
(MAX_TIMESLICE - 
(USER_PRIO(p)/(MAX_USER_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))

#define RT_PRIO_TO_TIMESLICE(p) \
(MAX_TIMESLICE - (p/(MAX_RT_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))


The second way seems simpler to me, and really illustrates what you are 
doing in a more straightforward manner.

I also cleaned up some of the comments. The sched.h diff between the H6 
version of the scheduler applied to 2.4.18-pre3 and vanilla 2.4.18-pre3 
follows: (Note that I changed the min and max timeslices to 20 and 100 
for my own use.)


474c474

< * is for SCHED_OTHER tasks.
---
 > * is for SCHED_OTHER tasks. (Max Priority is 168.)
481c481
< * to static priority [ 24 ... 63 (MAX_PRIO-1) ]
---
 > * to static priority [ 128 ... 167 (MAX_PRIO-1) ]
483,484c483,484
< * User-nice value of -20 == static priority 24, and
< * user-nice value 19 == static priority 63. The lower
---
 > * User-nice value of -20 == static priority 128, and
 > * user-nice value 19 == static priority 167. The lower
486,488d485
< *
< * Note that while static priority cannot go below 24,
< * the priority of a process can go as low as 0.
495,496c492,493
< * Default timeslice is 90 msecs, maximum is 150 msecs.
< * Minimum timeslice is 30 msecs.
---
 > * Default timeslice is 60 msecs; maximum is 100 msecs.
 > * Minimum timeslice is 20 msecs.
498,499c495,496
< #define MIN_TIMESLICE	( 30 * HZ / 1000)
< #define MAX_TIMESLICE	(150 * HZ / 1000)
---
 > #define MIN_TIMESLICE	(20 * HZ / 1000)
 > #define MAX_TIMESLICE	(100 * HZ / 1000)
500a498,503
 > /*
 > * Scales priority values to user priority values.
 > * This means nice of -20 => p of 128 => user priority of 0.
 > * This means nice of +19 => p of 167 => user priority of 39.
 > * MAX_USER_PRIO is 40 which would be nice of +20.
 > */
505,506c508,512
< * PRIO_TO_TIMESLICE scales priority values [ 100 ... 139  ]
< * to initial time slice values [ MAX_TIMESLICE (150 msec) ... 2 ]
---
 > * PRIO_TO_TIMESLICE scales priority values [ 128 ... 167  ]
 > * to initial time slice values [ MAX_TIMESLICE ... MIN_TIMESLICE ]
 > *
 > * RT_PRIO_TO_TIMESLICE scales priority values [ 0 ... 127  ]
 > * to initial time slice values [ MAX_TIMESLICE ... MIN_TIMESLICE ]
508,509c514,515
< * The higher a process's priority, the bigger timeslices
< * it gets during one round of execution. But even the lowest
---
 > * The numerically lower a process's priority, the bigger timeslices
 > * it gets during one round of execution. But even the numerically highest
513,514c519
< ((( (MAX_USER_PRIO-1-USER_PRIO(p))*(MAX_TIMESLICE-MIN_TIMESLICE) + \
< MAX_USER_PRIO-1) / MAX_USER_PRIO) + MIN_TIMESLICE)
---
 > (MAX_TIMESLICE - 
(USER_PRIO(p)/(MAX_USER_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
517,518c522
< ((( (MAX_RT_PRIO-(p)-1)*(MAX_TIMESLICE-MIN_TIMESLICE) + \
< MAX_RT_PRIO-1) / MAX_RT_PRIO) + MIN_TIMESLICE)
---
 > (MAX_TIMESLICE - (p/(MAX_RT_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))


To lkml - please cc me on any response, as I do not subscribe to the 
lkml - I read it via a news gateway.


Jim Owens
SuSE Linux 6.4 (kernel 2.4.18-pre3)
Tyan Tiger MP 2xAthlon MP 1600+
1.25 GB RAM

