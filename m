Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVEDWs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVEDWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 18:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEDWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 18:48:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57592 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261940AbVEDWsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 18:48:18 -0400
Message-ID: <42795125.9030905@mvista.com>
Date: Wed, 04 May 2005 15:48:05 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net>	 <20050503024336.GA4023@ict.ac.cn>  <4277EEF7.8010609@mvista.com>	 <1115158804.13738.56.camel@cog.beaverton.ibm.com>	 <427805F8.7000309@mvista.com>	 <1115166592.13738.96.camel@cog.beaverton.ibm.com>	 <42790A5C.4050403@mvista.com> <1115244798.13738.127.camel@cog.beaverton.ibm.com>
In-Reply-To: <1115244798.13738.127.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2005-05-04 at 10:46 -0700, George Anzinger wrote:
> 
>>>Well, as long as the HZ period is close to the timer-interval unit
>>>length, this is true. However if the timer-interval unit is smaller,
>>>multiple bucket entries would be expired. The performance considerations
>>>here are being looked at and this may be an area where the concepts in
>>>HRT might help (having a HRT specific sub-bucket).
>>
>>This is where we get in trouble with HR timers.  For a HR timer, we need to know 
>>how to get a timer to expire (i.e. appear in the call back) at a well defined 
>>and precise time (leaving aside latency issues).  The above description allows 
>>timers to be put in buckets without (as near as I can tell) making transparent 
>>exactly when the bucket will be emptied, only saying that it will be after the 
>>latest timer in the bucket is due.
> 
> 
> <snip>
> 
>>Think of it this way.  Decompose a HR timer into coarse and fine units (you 
>>choose, but here let say jiffies and nanoseconds).  Now we want the normal timer 
>>system to handle the jiffies part of the time and to turn the timer over to the 
>>HR timer code to take care of the nanosecond remainder.  If the jiffie part is 
>>late, depending on the nanosecond part, it could make the timer late (i.e for 
>>low values of the nanosecond part).  For high values of the nanosecond part, we 
>>can compenstate...
>>
>>This decomposition makes a lot of sense, by the way, for, at least, the 
>>following reasons:
>>1) it keeps the most of the HR issues out of the normal timer code,
>>2) it keeps high res and low res timer in the correct time order, i.e. a low res 
>>timer for jiffie X will expire prior to a high res timer for jiffie X + Y 
>>nanoseconds.
>>3) handling the high res timer list is made vastly easier as it will only need 
>>to have a rather small number of timers in it at any given time (i.e. those that 
>>are to expire prior to the next coarse timer tick).
> 
> 
> 
> Hmmm. Ok I think I see what your getting at. Let me know where I go
> wrong:
> 
> 1. Since HR soft-timers are a special case, their absolute nanosecond
> expire values (exp_ns) are decomposed into a low-res portion and a high-
> res portion. In your case it is units of jiffies (exp_jf) and
> arch_cycles (exp_ac) respectively.
> 
> 2. Since jiffies units map directly to a periodic tick, one can set a
> regular soft-timer to expire at exp_jf. Then when it is expired, it is
> added to a separate HR-timers list to expire in exp_ac  arch_cycles
> units.
> 
> 3. With the new-timeofday rework and Nish's soft-timers code, the soft-
> timers bucket entries map to actual nanosecond time values, rather then
> ticks. This causes a problem with your two level (regular periodic and
> hr-timer) timer-lists because since entries don't strictly map to
> interrupts, you don't how to decompose the nanosecond expiration into
> low-res and high-res portions.
> 
> 
> Here is my possible solution: Still keeping Nish's soft-timer rework
> where we use nanoseconds instead of ticks or jiffies, provide an
> expected interrupt-period value, which gives you the maximum interval
> length between ticks. Thus you schedule a regular-low-res timer for the
> nanosecond value (exp_ns - expected_interrupt_period). When that timer
> expires, you move the timer to the HR timer list and schedule an
> interrupt for the remaining time.

Oh, I have been thinking along these same lines.  I don't recall at the moment, 
but I depend on the timer retaining the absolute expire time as I set it.  This 
is used both by the secondary timer, and by the rearm code.  I need to look more 
closely at that.  But this is picking things apart at a very low level and does 
not, I think, address timer ordering to the point where I feel completely safe. 
  I.e. will such a scheme allow a LR time at time X to expire after a HR timer 
for time X+y.
> 
> Let me know how that sounds.
> 
> thanks
> -john
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
