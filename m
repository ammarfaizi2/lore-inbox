Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbTCJWK6>; Mon, 10 Mar 2003 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261496AbTCJWK6>; Mon, 10 Mar 2003 17:10:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:61943 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261493AbTCJWK5>;
	Mon, 10 Mar 2003 17:10:57 -0500
Message-ID: <3E6D0FD5.2090707@mvista.com>
Date: Mon, 10 Mar 2003 14:21:09 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@digeo.com>, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
References: <Pine.LNX.4.44.0303101147200.2542-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303101147200.2542-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 10 Mar 2003, george anzinger wrote:
> 
>>Lets consider this one on its own merits.  What SHOULD sleep do when 
>>asked to sleep for MAX_INT number of jiffies or more, i.e. when 
>>jiffies overflows?  My notion, above, it that it is clearly an error. 
> 
> 
> My suggestion (in order of preference):
>  - sleep the max amount, and then restart as if a signal had happened

I think this will require a 64-bit expire in the timer_struct 
(actually it would not be treated as such, but the struct would still 
need the added bits).  Is this ok?

I will look at the problem in detail and see if there might be another 
way without the need of the added bits.

>  - sleep the max amount (old behavior)
>  - consider it an error (new behavior)
> 
> In this case the error case actually helped find the other unrelated bug, 
> so in this case the error actually _helped_ us. However, that was only 
> "help" from a kernel perspective, from a user perspective I definitely 
> think that it makes no sense to have "sleep(largenum)" return -EINVAL.
> 
> And in the end it's the user that matters.
> 
Hm...  I changed it to what it is to make it easier to track down 
problems in the test code... and this was user code.  My thinking was 
that such large values are clear errors, and having the code "hang" in 
the sleep just hides the problem.  But then, I NEVER make a system 
call without checking for errors....  And, I was making a LOT of sleep 
calls and wanted to know which one(s) were wrong.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

