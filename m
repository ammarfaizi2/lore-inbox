Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVEDWOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVEDWOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEDWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 18:14:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11773 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261930AbVEDWNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 18:13:21 -0400
Subject: Re: Help with the high res timers
From: john stultz <johnstul@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <42790A5C.4050403@mvista.com>
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net>
	 <20050503024336.GA4023@ict.ac.cn>  <4277EEF7.8010609@mvista.com>
	 <1115158804.13738.56.camel@cog.beaverton.ibm.com>
	 <427805F8.7000309@mvista.com>
	 <1115166592.13738.96.camel@cog.beaverton.ibm.com>
	 <42790A5C.4050403@mvista.com>
Content-Type: text/plain
Date: Wed, 04 May 2005 15:13:18 -0700
Message-Id: <1115244798.13738.127.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 10:46 -0700, George Anzinger wrote:
> > Well, as long as the HZ period is close to the timer-interval unit
> > length, this is true. However if the timer-interval unit is smaller,
> > multiple bucket entries would be expired. The performance considerations
> > here are being looked at and this may be an area where the concepts in
> > HRT might help (having a HRT specific sub-bucket).
> 
> This is where we get in trouble with HR timers.  For a HR timer, we need to know 
> how to get a timer to expire (i.e. appear in the call back) at a well defined 
> and presise time (leaving aside latency issues).  The above discription allows 
> timers to be put in buckets without (as near as I can tell) making transparent 
> exactly when the bucket will be emptied, only saying that it will be after the 
> latest timer in the bucket is due.

<snip>

> 
> Think of it this way.  Decompose a HR timer into corse and fine units (you 
> choose, but here let say jiffies and nanoseconds).  Now we want the normal timer 
> system to handle the jiffies part of the time and to turn the timer over to the 
> HR timer code to take care of the nanosecond remainder.  If the jiffie part is 
> late, depending on the nanosecond part, it could make the timer late (i.e for 
> low values of the nanosecond part).  For high values of the nanosecond part, we 
> can compenstate...
> 
> This decomposition makes a lot of sense, by the way, for, at least, the 
> following reasons:
> 1) it keeps the most of the HR issues out of the normal timer code,
> 2) it keeps high res and low res timer in the correct time order, i.e. a low res 
> timer for jiffie X will expire prior to a high res timer for jiffie X + Y 
> nanoseconds.
> 3) handling the high res timer list is made vastly easier as it will only need 
> to have a rather small number of timers in it at any given time (i.e. those that 
> are to expire prior to the next corse timer tick).


Hmmm. Ok I think I see what your getting at. Let me know where I go
wrong:

1. Since HR soft-timers are a special case, their absolute nanosecond
expire values (exp_ns) are decomposed into a low-res portion and a high-
res portion. In your case it is units of jiffies (exp_jf) and
arch_cycles (exp_ac) respectively.

2. Since jiffies units map directly to a periodic tick, one can set a
regular soft-timer to expire at exp_jf. Then when it is expired, it is
added to a separate HR-timers list to expire in exp_ac  arch_cycles
units.

3. With the new-timeofday rework and Nish's soft-timers code, the soft-
timers bucket entries map to actual nanosecond time values, rather then
ticks. This causes a problem with your two level (regular periodic and
hr-timer) timer-lists because since entries don't strictly map to
interrupts, you don't how to decompose the nanosecond expiration into
low-res and high-res portions.


Here is my possible solution: Still keeping Nish's soft-timer rework
where we use nanoseconds instead of ticks or jiffies, provide an
expected interrupt-period value, which gives you the maximum interval
length between ticks. Thus you schedule a regular-low-res timer for the
nanosecond value (exp_ns - expected_interrupt_period). When that timer
expires, you move the timer to the HR timer list and schedule an
interrupt for the remaining time.

Let me know how that sounds.

thanks
-john

