Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbULHXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbULHXYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbULHXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:24:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16887 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261395AbULHXYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:24:14 -0500
Message-ID: <41B77134.90804@mvista.com>
Date: Wed, 08 Dec 2004 13:25:08 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>  <1102533066.1281.81.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com> <1102535891.1281.148.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 8 Dec 2004, john stultz wrote:
> 
> 
>>>With the improved scaling factor one should be able to come very close to
>>>ntp scaled time without invoking ntp_scale itself. Tick processing will
>>>then update time to be ntp scaled by fine tuning the scaling factor (with
>>>the bit shifting we can get very fine tuning) and eventually skip a few
>>>nanoseconds. Its basically some piece of interpolator logic in there so
>>>that the heavyweight calculations can just be done once in a while.
>>
>>No. I agree ntp_scale() is a performance concern. However I'm not sure
>>how your suggestion of just slowing or tweaking the timesource
>>mult/shift frequency values will allow us to implement the expected
>>behavior of adjtimex().  We need to be able to implement the following
>>adjustments within a single tick:
>>
>>1. Adjust the frequency by 500ppm for 10usecs
>>2. After that adjust the frequency by 30ppm for the rest of the tick.
> 
> 
> Frequency adjustments just means an adjustment of the scaling factor.
> Am I missing something?
> 
> 
>>We can see how much of this can be fudged or generalized, but I'm
>>hesitant to be too flippant about changing the NTP behavior for fear
>>that the astronomers who so dearly care about leap seconds and minute
>>time adjustments will "forget" to mention the asteroid heading towards
>>my home. :)
> 
> 
> I am not sure what NTP behavior needs to be fudged. Sorry about my limited
> NTP knowledge. Could you elaborate on what the problem is?
> 
>>I may have asked this before, but w/ 32 bit mult and shifts, how
>>granular can these adjustments be?
> 
> 
> Yes. 128bit would be great for this. 64bit is fine though as
> far as I can see and allows granularity up to fractions of
> nanoseconds if applied between 1ms intervals.
> 
> 
>>Also additional complications arise when we have multiple things (like
>>cpufreq) playing with the timesource frequency values as well.
> 
> 
> I think these could all be taken into account by a scaling factor off a
> certain base established at a tick-like event that does the ntp scaling.
> The scaling between tick-like event needs to be just a scaling factor for
> performance reasons.

Right.  We seem to be doing ok now by just adjusting things at tick time and 
using the "normal" interpolation between ticks.

As for the math, the current code keeps a running "remainder" which is the 
amount of the correction that was finer than the clock resolution (i.e. less 
than a nano second) and rolls this in on the next tick.  This gives resolution 
out to several bits to the right of the nano second.  And I think this is all 
done with 32 bit math (if memory serves).
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

