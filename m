Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVGMUDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVGMUDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVGMTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:54:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14319 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262727AbVGMTyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:54:19 -0400
Message-ID: <42D570F2.8030609@mvista.com>
Date: Wed, 13 Jul 2005 12:52:18 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 13 Jul 2005, Vojtech Pavlik wrote:
> 
>>No, but 1/1000Hz = 1000000ns, while 1/864Hz = 1157407.407ns. If you have
>>a counter that counts the ticks in nanoseconds (xtime ...), the first
>>will be exact, the second will be accumulating an error.
> 
> 
> It's not even that we have a counter like that, it's the simple fact that
> we have a standard interface to user space that is based on milli-, micro-
> and nanoseconds.
> 
> (For "poll()", "struct timeval" and "struct timespec" respectively).
> 
> It's totally pointless saying that we can do 864 Hz "exactly", when the
> fact is that all the timeouts we ever get from user space aren't in that 
> format. So the only thing that matters is how close to a millisecond we 
> can get, not how close to some random number.
> 
> So we do a lot of conversions from "struct timeval" to "jiffies", and if
> you don't take the error in that conversion into account, then you're
> ignoring what is likely a _bigger_ error.
> 
> Long-term time drift is a known issue, and is unavoidable since you don't 
> even know the exact frequency of the crystal, since that is not only not 
> that exact in the first place, it depends on temperature etc. So long-term 
> time drift is something that we inevitably have to use things like NTP to 
> handle, if you want an exact clock.
> 
> And in short-term things, the timeval/jiffie conversion is likely to be a 
> _bigger_ issue than the crystal frequency conversion.
> 
> So we should aim for a HZ value that makes it easy to convert to and from
> the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> good values for that reason. 864 is not.Linus Torvalds wrote:
> 
> On Wed, 13 Jul 2005, Vojtech Pavlik wrote:
> 
>>No, but 1/1000Hz = 1000000ns, while 1/864Hz = 1157407.407ns. If you have
>>a counter that counts the ticks in nanoseconds (xtime ...), the first
>>will be exact, the second will be accumulating an error.
> 
> 
> It's not even that we have a counter like that, it's the simple fact that
> we have a standard interface to user space that is based on milli-, micro-
> and nanoseconds.
> 
> (For "poll()", "struct timeval" and "struct timespec" respectively).
> 
> It's totally pointless saying that we can do 864 Hz "exactly", when the
> fact is that all the timeouts we ever get from user space aren't in that 
> format. So the only thing that matters is how close to a millisecond we 
> can get, not how close to some random number.
> 
> So we do a lot of conversions from "struct timeval" to "jiffies", and if
> you don't take the error in that conversion into account, then you're
> ignoring what is likely a _bigger_ error.
> 
> Long-term time drift is a known issue, and is unavoidable since you don't 
> even know the exact frequency of the crystal, since that is not only not 
> that exact in the first place, it depends on temperature etc. So long-term 
> time drift is something that we inevitably have to use things like NTP to 
> handle, if you want an exact clock.
> 
> And in short-term things, the timeval/jiffie conversion is likely to be a 
> _bigger_ issue than the crystal frequency conversion.
> 
> So we should aim for a HZ value that makes it easy to convert to and from
> the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> good values for that reason. 864 is not.

Uh, WAIT A NANOSECOND!  Look at what we are doing today in that department.  The 
key is not the ability to convert based on the value of HZ but on the implied 
value of jiffie given CLOCK_TICK_RATE.  Today the value we use for jiffie is 
999849 nanoseconds which is what the given CLOCK_TICK_RATE and HZ end up getting 
from the PIT.

By the time the user comes along we have TICK_NSEC and the current conversion 
routines which are not exactly simple but they are correct.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
