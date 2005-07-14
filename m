Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVGNAqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVGNAqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVGNAp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:45:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27119 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262852AbVGNApw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:45:52 -0400
Message-ID: <42D5B54B.8020400@mvista.com>
Date: Wed, 13 Jul 2005 17:43:55 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <200507140954.54444.kernel@kolivas.org>
In-Reply-To: <200507140954.54444.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thu, 14 Jul 2005 05:10, Linus Torvalds wrote:
> 
>>On Wed, 13 Jul 2005, Vojtech Pavlik wrote:
>>
>>>No, but 1/1000Hz = 1000000ns, while 1/864Hz = 1157407.407ns. If you have
>>>a counter that counts the ticks in nanoseconds (xtime ...), the first
>>>will be exact, the second will be accumulating an error.
>>
>>It's not even that we have a counter like that, it's the simple fact that
>>we have a standard interface to user space that is based on milli-, micro-
>>and nanoseconds.
>>
>>(For "poll()", "struct timeval" and "struct timespec" respectively).
>>
>>It's totally pointless saying that we can do 864 Hz "exactly", when the
>>fact is that all the timeouts we ever get from user space aren't in that
>>format. So the only thing that matters is how close to a millisecond we
>>can get, not how close to some random number.
> 
> 
> That may be the case but when I've measured the actual delay of schedule 
> timeout when using nanosleep from userspace, the average at 1000Hz was 1.4ms 
> +/- 1.5 sd . When we're expecting a sleep of "up to 1ms" we're getting 50% 
> longer than the longest expected. Purely mathematically the accuracy of 
> changing HZ from 1000 -> 864 will not bring with it any significant change to 
> the accuracy. This can easily be measured as well to confirm. 
> 
> Using schedule timeout as an argument against it doesn't hold for me. 
> Vojtech's comment of :
> 
>>"No, but 1/1000Hz = 1000000ns, while 1/864Hz = 1157407.407ns. If you have a 
>>counter that counts the ticks in nanoseconds (xtime ...), the first will be 
>>exact, the second will be accumulating an error." 
> 
> is probably the most valid argument against such a funky number. 

No, that doesn't hold water either.  We already jigger jiffie to be _close_ to 
1/HZ and closer still to what we can get from the PIT as its true period (for 
example, today the jiffie is 999849 nanoseconds) and this too is only accurate 
to the nanosecond.  Here are the jiffie values for several HZ values using the 
formulas in the code which use the TICK_RATE as given by the hardware.  Note the 
error here is the difference between an asked for repeating timer of 1 second 
and what the system clock on the same system says, NOT what real time is in 
either case, just relative between the two.  In otherwords, if you set up an 
itimer to signal every second and looked at the long term drift between the 
signals it gives and the system clock you would see the itimer drifting by 
~914ppm (with HZ = 846).

HZ  	TICK RATE	jiffie(ns)	second(ns)	 error (ppbillion)
  100	 1193182	10000000	1000000000	       0
  200	 1193182	 5000098	1000019600	   19600
  250	 1193182	 4000250	1000062500	   62500
  500	 1193182	 1999688	1001843688	 1843688
1000	 1193182	  999848	1000847848	  847848
  846	 1193182	 1181717	1000914299	  914299

> 
> Cheers,
> Con

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
