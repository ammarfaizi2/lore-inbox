Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVEGS0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVEGS0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVEGS0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 14:26:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:56967 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262737AbVEGS0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 14:26:42 -0400
Date: Sat, 7 May 2005 23:57:28 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050507182728.GA29592@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I need some inputs from the community (specifically from virtual
machine and embedded/power-management folks) on something that I am working on.

	This is regarding cutting off the regular timer ticks when a CPU
becomes idle and it does not have any next timer set to expire in the "near"
term. Both CONFIG_VST and CONFIG_NO_IDLE_HZ deal with this. Both embedded and
virtualized platforms (ex: UML/S390) benefit from this. For ex: if 100s
of guest are running on a single box, then cutting off some useless HZ ticks
in the idle CPUs of all guests will lead to efficient use of host CPU's cycles.

Cutting of local timer ticks has an effect on the scheduler load balance
activity and I am trying to see how best to reduce the impact.

Two solutions have been proposed so far:

	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
	   say a second, Nick?) on how long a idle CPU can avoid taking
	   local-timer ticks. As a result, the load imbalance could exist only
	   for this max duration, after which the sleeping CPU will wake up
	   and balance itself. If there is no imbalance, it can go and sleep
	   again for the max duration.

 	   For ex, lets say a idle CPU found that it doesn't have any near timer
	   for the next 1 minute. Instead of letting it sleep for 1 minute in
	   a single stretch, we let it sleep in bursts of 100 msec (or whatever
	   is the max. duration chosen). This still is better than having
	   the idle CPU take HZ ticks a second.

	   As a special case, when all the CPUs of an image go idle, we
	   could consider completely shutting off local timer ticks
	   across all CPUs (till the next non-timer interrupt).


	B. Don't impose any max limit on how long a idle CPU can sleep.
	   Here we let the idle CPU sleep as long as it wants. It is
	   woken up by a "busy" CPU when it detects an imbalance. The
	   busy CPU acts as a watchdog here. If there are no such
	   busy CPUs, then it means that nobody will acts as watchdogs
	   and idle CPUs sleep as long as they want. A possible watchdog
	   implementation has been discussed at:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2

A is obviously more simpler to implement compared to B!
Whether both are more or less equally efficient is something that I dont know.

To help us decide which way to go, could I have some comments from the virtual
machine and embedded folks on which solution they prefer and why?



--


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
