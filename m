Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269247AbUICH2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbUICH2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbUICH2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:28:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63993 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269247AbUICH2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:28:07 -0400
Message-ID: <41381C2D.7080207@mvista.com>
Date: Fri, 03 Sep 2004 00:24:29 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
In-Reply-To: <1094193731.434.7232.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Thu, 2004-09-02 at 21:39, George Anzinger wrote:
> 
>>john stultz wrote:
> 
> 
>>>+
>>>+static nsec_t jiffies_cyc2ns(cycle_t cyc, cycle_t* remainder)
>>>+{
>>>+
>>>+	cyc *= NSEC_PER_SEC/HZ;
>>
>>Hm... This assumes that 1/HZ is what is needed here.  Today this value is 
>>999898.  Not exactly reachable by NSEC_PER_SEC/HZ.  Or did I miss something, 
>>like the relationship of jiffie to 1/HZ and to real time.
> 
> 
> HZ not being HZ is the source of many foul problems.
> 
> NTP should be able to correct for the error. For systems
> not running NTP, provide a fake NTP to make corrections
> based on the expected frequency error.
> 
> Based on that, skip or double-up on the ticks to make
> them be exactly HZ over long periods of time.

There are several problems here.  First, to make this possible, you will have to 
outlaw several values for HZ (1024 comes to mind).  Second, like it or not, 1/HZ 
or something close to it, is the timer resolution.  I think we need to try and 
keep this a power of 10, mostly because there are a lot of folks who just don't 
understand it if it is not.  And third, you need to get real close to it with 
the hardware timer.  If you introduce NTP or some such to fix things, well, 
things just break another place.  For example, we started 2.6 with HZ=1000 and 
had problems like:
 > time sleep 10
sleeping for 9.9 seconds.  This will just not do.  Any corrections made to the 
wall clock really need to be made to the timer system as well.  As it is we 
assume that, by correctly choosing the tick value, the wall clock will be 
correct on average, even under NTP.  I.e. that the NTP correction will be, over 
time, very small.  We really do want code that is much more accurate than "time 
sleep 10" to be right, i.e. if we sleep for x nanoseconds, the wall clock will 
have changed by x nanoseconds while we did so.
> 
>

~

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

