Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTJOWvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 18:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTJOWvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 18:51:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29678 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262009AbTJOWvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 18:51:42 -0400
Message-ID: <3F8DCF73.3000707@mvista.com>
Date: Wed, 15 Oct 2003 15:51:31 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Marshall <tmarshall@real.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com> <20031014235213.GC860@real.com> <3F8D63AA.9000509@mvista.com> <20031015165016.GA2167@real.com>
In-Reply-To: <20031015165016.GA2167@real.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Marshall wrote:
>>>I understand what happens and why.  I admit that I'm not familiar with the
>>>POSIX standard on this issue.  Questions:
>>>
>>>* I've heard that the kernel's timer resolution has increased from 10ms to
>>>  1ms in 2.6.  Why does the itimer have such a large granularity?  I
>>>  expected it to be highly accurate in this range.
>>
>>I think it is.  The missing understanding is, I think, that you expect the 
>>resolution to be exactly 1/HZ or 1ms.  It is actually not exactly that 
>>because the PIC can not generate 1ms interrupts (close but not close enough 
>>for NTP). So the kernel figures out what the true PIC rate is and sets up 
>>the resolution for that.  This results in a resolution of ~999,849 
>>nanoseconds (i.e. instead of 1,000,000 nano seconds per tick).  Now there 
>>is some errors in converting this to micro seconds..., but the actual math 
>>is done with more precision with the conversion after (which is why the 
>>various times the program tries don't come out being exact multiples of 
>>each other, or of anything expressed as only microseconds).
> 
> 
> I expect there are at least a few applications that will misbehave because
> the developers did not expect a timer to behave this way (regardless of
> whether it's proper according to the spec).
> 
> Is it possible to choose a timer resolution that errs on the high side of
> 1ms instead of the low side? [*]  It seems to me that would result in the
> application getting very close to the expected number of alarm signals.  I
> am not at all familiar with the kernel design so I don't know if this would
> be feasible or not.
> 
> [*] If this is the 8254 timer, using 1192 as a divisor should result in a
> resolution of ~1,000,686 nanoseconds.

Well here is the rub.  Your high side give an error of 686 PPM while the low 
side has an error of only 152 PPM.  This assumes, of course, that you are trying 
to hit exactly 1,000,000 nano seconds per tick.

On the other hand, since we do correct for this error, I suspect one could use 
the high side number.

Still, if an application depends on the count rather than just reading the 
clock, I suspect that some would consider it broken.  Timer signals can be 
delayed and may, in fact overrun with out notice (unlike POSIX timers which tell 
you when they overrun).

What you really need is a higher resolution timer.  Funny, there seems to be a 
reference to such a thing in my signature :)
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

