Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTJOPLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTJOPLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:11:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38391 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263388AbTJOPLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:11:43 -0400
Message-ID: <3F8D63AA.9000509@mvista.com>
Date: Wed, 15 Oct 2003 08:11:38 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Marshall <tmarshall@real.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com> <20031014235213.GC860@real.com>
In-Reply-To: <20031014235213.GC860@real.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Marshall wrote:
>>Since the actual interval used by the system is a bit larger than what 
>>was asked for, there will be fewer ticks.
> 
> 
> I understand what happens and why.  I admit that I'm not familiar with the
> POSIX standard on this issue.  Questions:
> 
>  * I've heard that the kernel's timer resolution has increased from 10ms to
>    1ms in 2.6.  Why does the itimer have such a large granularity?  I
>    expected it to be highly accurate in this range.

I think it is.  The missing understanding is, I think, that you expect the 
resolution to be exactly 1/HZ or 1ms.  It is actually not exactly that because 
the PIC can not generate 1ms interrupts (close but not close enough for NTP). 
So the kernel figures out what the true PIC rate is and sets up the resolution 
for that.  This results in a resolution of ~999,849 nanoseconds (i.e. instead of 
1,000,000 nano seconds per tick).  Now there is some errors in converting this 
to micro seconds..., but the actual math is done with more precision with the 
conversion after (which is why the various times the program tries don't come 
out being exact multiples of each other, or of anything expressed as only 
microseconds).
> 
>  * Is this how the timer is supposed to work?  It seems to me that an
>    algorithm which kept running track of the difference in requested and
>    actual times (a la Bresenham) could make the itimer behave closer to what
>    the user requested.

I THINK you are suggesting that a different increment be used each timer expiry 
to get closer to the desired rate.  Sorry, not only is this a LOT more overhead, 
it is not the way the standard is written.  The standard says all these times 
are to be rounded up to the resolution, which is what the system does.  It is 
just that the resolution is not what you expect.

For what its worth, the POSIX clocks and timers (accessed through timer_settime, 
etc.) compute time to the nanosecond, so they will have less rounding error and 
will be a tad closer to the requested.  Still, we are dealing with an underlying 
ticker that only has 999,849 nanosecond resolution.

Hope this helps

George
> 
> 
>>Maybe you could save this code if it is part of a test suite....
> 
> 
> This code is part of a "timer calibration" routine used by the RealNetworks
> Helix Server.  I just noticed that the timer calibration failed on a machine
> that had 2.6.0-test7 installed (we have not officially looked at supporting
> 2.6 yet).  The test runs on many different flavors of *nix (probably a dozen
> or so).  I can check to see what the behavior is on the other platforms if
> that would be useful.  If this is the Right Way to do timers, we'll probably
> end up changing our "calibration" routine to read back the actual timer
> interval as you suggest.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

