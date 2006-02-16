Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWBPSLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWBPSLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWBPSLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:11:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:21183 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932545AbWBPSLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:11:36 -0500
Message-ID: <43F4BFFC.8050604@austin.ibm.com>
Date: Thu, 16 Feb 2006 12:10:04 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nathan Lynch <nathanl@austin.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/4] s390: fix preempt_count of idle thread with cpu hotplug
References: <20060216071808.GE9241@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060216071808.GE9241@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Set preempt_count of idle_thread to zero before switching off cpu.
> Otherwise the preempt_count will be wrong if the cpu is switched on again
> since the thread will be reused.
> 

I had a similar discussion back in November, that one about 
/proc/interrupts stats.  Rather than do that all over again below is a 
cut and paste of my reply to that discussion.  The executive summary is 
I rather like the current behavior as is.

-------------------------------------------------------------

 > When CPU2 is off-lined, the statistics for CPU2 do not appear
 >(expected). However when you look at the before picture (all CPUs
 >present) and after picture (all cpus present after CPU2 re-added), you
 >see that the original data was returned and has incremented:

<snip>

 > Results are similar for other interrupt levels.
 >
 > This does not seem like the correct approach. Shouldn't an
 > added CPU be considered new and stats begin again from zero?
 > Can you please give us guidance on this issue?  Is it
 > a bug or expected behavior?

There are several legitimate options here, including the current 
behavior.  I'm not clear other than kernel developers doing debugging 
who consumes this data. If it is just kernel developers I contend we are 
capable of understanding whatever data is presented.

Current Behavior:
Stats carry over.  The advantage of this is that the stats history is 
not lost.  Consider the scenario where a cpu is moved regularly between 
two partitions in response to workload.  It would probably be best in 
that situation to keep the full history of that cpu during all the times 
it has been in the partition. This view would be consistent with the cpu 
always being there, just sometimes being off.  I haven't fully thought 
through the impact of a different physical cpu being added in the same 
logical slot, or how virtualized cpus fits into this paradigm.  But I 
suspect they shouldn't change the concept.

Reset every time:
The advantage of this is the cpus start with a clean slate.  There is 
logic to avoiding the situation where some hotplug added cpus have state 
already and some hotplug added cpus start with nothing.  Consistency is 
not a bad thing.  On the other hand this is a bit of selective amnesia, 
we would be forgetting all past statistics only for cpus that had taken 
some time off.  It's like taking a vacation from work and having your 
old email thrown away while you are gone.

Reset all every time:
It could well be argued that the old cpu statistics from every active 
cpu serve only to confuse things because the cpus were in a different 
state.  If you didn't reset all cpus statistics, then after adding a new 
cpu you couldn't say for instance that cpu 5 is taking 45% of the 
interrupts.  The statistics are meaningless without their context, and 
by adding a cpu we have destroyed their context.  Therefore we should 
reset all statistics so they all have the same frame of reference.  The 
downside of course is that we lose all history on all cpus.

Personally, I'm fine with the current behavior.  It makes the most sense 
to me and is the least complex to implement (already done).  We maybe 
should document it (send a patch in reply to the one Ashok Raj just 
posted to lkml).  Unless somebody has a real user of cpu statistics that 
this behavior breaks.
