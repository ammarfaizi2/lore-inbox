Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269855AbUH0BuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269855AbUH0BuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269813AbUH0Bst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:48:49 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:8637 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269940AbUH0Bni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:43:38 -0400
Message-ID: <412E91C4.5020901@yahoo.com.au>
Date: Fri, 27 Aug 2004 11:43:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <50490000.1093553473@flay>
In-Reply-To: <50490000.1093553473@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --On Thursday, August 26, 2004 21:07:39 +1000 Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
>>>
>>>
>>>- nicksched is still here.  There has been very little feedback, except that
>>>  it seems to slow some workloads on NUMA.
>>
>>That's because most people aren't interested in a new cpu scheduler for
>>2.6. The current one works well enough in most situations and people
>>aren't trying -mm to fix their interactive problems since they are few
>>and far between. The only reports about adverse behaviour with 2.6 we track down to "It behaves differently to what I expect" or applications with no (b)locking between threads suck under load. Personally I think the latter is a good thing as it encourages better coding, and the former is something we'll have with any alternate design.
> 
> 
> Well ... it'd be nice to know what nicksched was trying to fix. Then maybe
> we could try to measure it. There's lots of stuff in the changelog about
> what technical stuff was fiddled with ... but nothing I can see about what
> it was meant to acheive.
> 

It is supposed to be "as simple as possible and no simpler" approach to
the 2 array scheduler.

The current one has a lot of 'unfairness' and temporal dependencies. Eg,
"if a process has been in an interruptible sleep and woken from interrupt,
and has been previously marked as 'interactive' then blah. If it has been
in an uninterruptible sleep then do something completely different"
(I just made that up)

So, some people's watchdog process that is using *no* CPU get 50 second
latencies. And you get unfairness problems where one CPU hog is given twice
the amount of CPU time as another because it got marked as interactive long
ago.

Basically, the only inputs into nicksched are when a process sleeps and
when it runs. The only per-process state is basically how much it runs and
how much it sleeps. Everyone is treated the same.

The kernbench regression is something I don't take lightly though. I'll see
if I can get to the bottom of it.
