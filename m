Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270998AbTHFSzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271002AbTHFSzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:55:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12284 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S270998AbTHFSzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:55:40 -0400
Message-ID: <3F314F0B.7040101@mvista.com>
Date: Wed, 06 Aug 2003 11:55:07 -0700
From: George Anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Patrick Moor <pmoor@netpeople.ch>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: time jumps (again)
References: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de> <3F314603.7050907@techsource.com>
In-Reply-To: <3F314603.7050907@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> Is there any way the kernel could detect clock problems like drift and 
> jumps by comparing the effects of different timers?  And when a problem 
> is detected, it can correct the situation automatically.
> 
> How many interrupt timers are there in various systems?  How much can we 
> rely on the accuracy of each one?
> 
In my high-res-timers model I don't rely on interrupts to "clock" 
time, but rather pick some stable time source such as the ACPIC 
pm_timer.  The interrupts are just used to remind the system to read 
the clock.

In this model, the gettimeofday() request just reads that clock. 
There is also code to keep the interrupts occurring on the proper 
"boundaries" as defined by that clock.

The problem is finding a stable fast (as in time to read) clock 
source.  The TSC is not stable in a fair number of machines.  The 
pm_timer is an I/O access which is sloooow and will only get slower 
WRT cpu cycle time as the boxes get faster.

Archs other than the x86 seem to do much better in this regard.

As for fixing what is in the x86 now,  I would suggest that, if we are 
using the TSC, we trust it with a bit of a longer time than the tick 
time.  It is relatively easy to detect drift WRT the PIT and correct 
the TSC base line, but this should be done over a second or so and not 
each tick as is done now.  This would eliminate the PIT as well as the 
TSC reference read at each interrupt and result in a more stable result.

To work correctly with NTP we would also need to adjust the TSC to 
useconds multiplier to match what NTP thinks the TSC rate should be at 
the moment.

I don't know if this work should be attempted at this point in the 
development cycle, however.  Possibly waiting for 2.7 is better.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

