Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVCNXn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVCNXn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVCNXn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:43:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56316 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262092AbVCNXnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:43:19 -0500
Message-ID: <423620EA.3040205@mvista.com>
Date: Mon, 14 Mar 2005 15:40:26 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Matt Mackall <mpm@selenic.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>	 <20050313004902.GD3163@waste.org> <1110825765.30498.370.camel@cog.beaverton.ibm.com>
In-Reply-To: <1110825765.30498.370.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Sat, 2005-03-12 at 16:49 -0800, Matt Mackall wrote:
>
~

>> 
> 
>>>+	/* finally, update legacy time values */
>>>+	write_seqlock_irqsave(&xtime_lock, x_flags);
>>>+	xtime = ns2timespec(system_time + wall_time_offset);
>>>+	wall_to_monotonic = ns2timespec(wall_time_offset);
>>>+	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
>>>+	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
>>>+	/* XXX - should jiffies be updated here? */
>>
>>Excellent question. 
> 
> 
> Indeed.  Currently jiffies is used as both a interrupt counter and a
> time unit, and I'm trying make it just the former. If I emulate it then
> it stops functioning as a interrupt counter, and if I don't then I'll
> probably break assumptions about jiffies being a time unit. So I'm not
> sure which is the easiest path to go until all the users of jiffies are
> audited for intent. 

Really?  Who counts interrupts???  The timer code treats jiffies as a unit of 
time.  You will need to rewrite that to make it otherwise.  But then you have 
another problem.  To correctly function, times need to expire on time (hay how 
bout that) not some time later.  To do this we need an interrupt source.  To 
this point in time, the jiffies interrupt has been the indication that one or 
more timer may have expired.  While we don't need to "count" the interrupts, we 
DO need them to expire the timers AND they need to be on time.
> 
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

