Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSIHSIf>; Sun, 8 Sep 2002 14:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSIHSIe>; Sun, 8 Sep 2002 14:08:34 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:10392 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311025AbSIHSId>; Sun, 8 Sep 2002 14:08:33 -0400
Date: Sun, 08 Sep 2002 11:11:26 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <232327228.1031483485@[10.10.2.3]>
In-Reply-To: <1031504848.26888.238.camel@irongate.swansea.linux.org.uk>
References: <1031504848.26888.238.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Perhaps testing with overcommit on would be useful.
>> > 
>> > Well yes - the new overcommit code was a significant hit on the 16ways
>> > was it not?  You have some numbers on that?
>> 
>> About 20% hit on system time for kernel compiles.
> 
> That suprises me a lot. On a 2 way and 4 way the 2.4 memory overcommit
> check code didnt show up. That may be down to the 2 way being on a CPU
> that has no measurable cost for locked operations and the 4 way being an
> ancient ppro a friend has.

Remember this is a NUMA machine - gathering global information
is extremely expensive. On an SMP system, I wouldn't expect it
to show up so much, though it still doesn't seem terribly efficient. 
The code is admits it's broken anyway, for the overcommit = 2 case
(which was NOT what I was running - the 20% is for 1). Below is a 
simple patch that I've never got around to testing, that I think 
will improve that case (not that I'm that interested in setting
overcommit to 2 ;-)).
 
> If it is the memory overcommit handling then there are plenty of ways to
> deal with it efficiently in the non-preempt case at least. I had
> wondered originally about booking chunks of pages off per CPU (take the
> remaining overcommit divide by four and only when a CPU finds its
> private block is empty take a lock and redistribute the remaining
> allocation). Since boxes almost never get that close to overcommit
> kicking in then it should mean we close to never touch a locked count.

Can you use per-zone stats rather than global ones? That tends to
fix things pretty efficently on these type of machines - per zone 
LRUs made a huge impact.

Here's a little patch (untested!). I'll go look at the other case
and see if there's something easy to do, but I think it needs some
significant rework to do anything.

--- virgin-2.5.30.full/mm/mmap.c	Thu Aug  1 14:16:05 2002
+++ linux-2.5.30-vm_enough_memory/mm/mmap.c	Wed Aug  7 13:26:46 2002
@@ -74,7 +74,6 @@
 int vm_enough_memory(long pages)
 {
 	unsigned long free, allowed;
-	struct sysinfo i;
 
 	atomic_add(pages, &vm_committed_space);
 
@@ -115,12 +114,7 @@
 		return 0;
 	}
 
-	/*
-	 * FIXME: need to add arch hooks to get the bits we need
-	 * without this higher overhead crap
-	 */
-	si_meminfo(&i);
-	allowed = i.totalram * sysctl_overcommit_ratio / 100;
+	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
 	if (atomic_read(&vm_committed_space) < allowed)


