Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135859AbRDZSTq>; Thu, 26 Apr 2001 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135853AbRDZST0>; Thu, 26 Apr 2001 14:19:26 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:23215 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135822AbRDZSTY>; Thu, 26 Apr 2001 14:19:24 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 26 Apr 2001 11:19:23 -0700
Message-Id: <200104261819.LAA03836@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: #define HZ 1024 -- negative effects?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have not tried it, but I would think that setting HZ to 1024
should make a big improvement in responsiveness.

	Currently, the time slice allocated to a standard Linux process
is 5*HZ, or 50ms when HZ is 100.  That means that you will notice
keystrokes being echoed slowly in X when you have just one or two running
processes, no matter how fast your CPU is, assuming these processes 
do not complete in that time.  Setting HZ to 1000 should improve that
a lot, and the cost of the extra context switches should still be quite
small in comparison to time slice length (a 1ms time slize = 1 million
cycles on a 1GHz processor or a maximum of 532kB of memory bus
utilization on a PC-133 bus that transfer 8 bytes on an averge of every
two cycles based to 5-1-1-1 memory timing).

	I would think this would be particularly noticible for internet
service providers that offer shell accounts or VNC accounts (like
WorkSpot and LastFoot).

	A few of other approaches to consider if one is feeling
more ambitious are:
	1. Make the time slice size scale to the number of
	   currently runnable processes (more precisely, threads)
	   divided by number of CPU's.  I posted something about this
	   a week or two ago.  This way, responsiveness is maintained,
	   but people who are worried about the extra context switch
	   and caching effects can rest assured that this shorter time slices
	   would only happen when responsiveness would otherwise be bad.
	2. Like #1, but only shrink the time slices when at least
	   one of the runnable processes is running at regular or high
	   CPU priority.
	3. Have the current process give up the CPU as soon as another
	   process awaiting the CPU has a higher current->count value.
	   That would increase the number of context switches like
	   increasing HZ by 5X (with basically the same trade-offs),
	   but without increasing the number of timer interrupts.
	   By itself, this is probably not worth the complexity.
	4. Similar to #3, but only switch on current->count!=0 when
	   another process has just become unblocked.
	5. I haven't looked at the code closely enough yet, but I tend
	   to wonder about the usefulness of having "ticks" when you have
	   a real time clock and avoid unnecessary "tick" interrupts by
	   just accounting based on microroseconds or something.  I
	   understand there may be issues of inaccuracy due to not knowing
	   exactly where you are in the current RTC tick, and the cost
	   of the unnecessary tick interrupts is probably pretty small.
	   I mention this just for completeness.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
