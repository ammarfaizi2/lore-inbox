Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbTCJTb7>; Mon, 10 Mar 2003 14:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbTCJTb7>; Mon, 10 Mar 2003 14:31:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50683 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261430AbTCJTb4>;
	Mon, 10 Mar 2003 14:31:56 -0500
Message-ID: <3E6CEA91.9060603@mvista.com>
Date: Mon, 10 Mar 2003 11:42:09 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: cobra@compuserve.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
References: <3E6AEDA5.D4C0FC83@compuserve.com>	<20030309000839.31041e3e.akpm@digeo.com> <20030309001706.75467db1.akpm@digeo.com>
In-Reply-To: <20030309001706.75467db1.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton <akpm@digeo.com> wrote:
> 
>>errr, OK.  This returns -EINVAL:
>>
>>#include <time.h>
>>
>>main()
>>{
>>	struct timespec req;
>>	struct timespec rem;
>>	int ret;
>>
>>	req.tv_sec = 5000000;
>>	req.tv_nsec = 0;
>>
>>	ret = nanosleep(&req, &rem);
>>	if (ret)
>>		perror("nanosleep");
>>}
>>
> 
> 
> OK, I give up.
> 
> 			/*
> 			 * This is a considered response, not exactly in
> 			 * line with the standard (in fact it is silent on
> 			 * possible overflows).  We assume such a large 
> 			 * value is ALMOST always a programming error and
> 			 * try not to compound it by setting a really dumb
> 			 * value.
> 			 */
> 			return -EINVAL;
> 
> George, RH7.3 and RH8.0 cron daemons are triggering this (trying to sleep
> for 4,500,000 seconds) and it causes them to go into a busy loop.
> 
> I think we need to just sleep for as long as we can and return an
> appropriate partial result.
> 
> 
Linus has fixed the problem cron showed up, so.

Lets consider this one on its own merits.  What SHOULD sleep do when 
asked to sleep for MAX_INT number of jiffies or more, i.e. when 
jiffies overflows?  My notion, above, it that it is clearly an error. 
  I suppose as HZ gets bigger, this argument will carry less weight, 
but, still:

We have, I think, three choices:
1.) Error out as it does now,
2.) Sleep for MAX_INT and return ?????
3.) Sleep for MAX_INT and then sleep some more until the actual time 
is reached.

2.) Requires, if we are to return other than OK, some way to flag that 
the error happened.

3.) Likewise, requires more bits in the timer.  If we went to a 64-bit 
expire count, we could do the "right" thing, however it adds an int to 
the size of the timer_struct.

So, folks, what is the _right_ thing to do here?

-g

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

