Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUENRX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUENRX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUENRX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:23:27 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:47505 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261832AbUENRXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:23:23 -0400
In-Reply-To: <20040514165311.GC6908@bitmover.com>
References: <200405122234.06902.elenstev@mesatop.com> <15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040513183316.GE17965@bitmover.com> <200405131723.15752.elenstev@mesatop.com> <6616858C-A5AF-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040514144617.GE20197@work.bitmover.com> <200405122234.06902.elenstev@mesatop.com> <15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040513183316.GE17965@bitmover.com> <200405131723.15752.elenstev@mesatop.com> <20040514165311.GC6908@bitmover.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <65922594-A5CB-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Steven Cole <elenstev@mesatop.com>, torvalds@osdl.org,
       support@bitmover.com, Andrew Morton <akpm@osdl.org>
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Fri, 14 May 2004 11:23:20 -0600
To: Andy Isaacson <adi@bitmover.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 14, 2004, at 10:53 AM, Andy Isaacson wrote:

> Apologies for the enormous quote, but I wanted to get the lspci and
> dmesg in here, in case someone else has some insight.
>
[enormous quote snipped]

>
> So, in the oddball config department, you've got a ISAPnP modem over
> which you're running PPP; CONFIG_PREEMPT is on.
>
> That corruption size really does make me think of network packets, so
> I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
> link?  "ifconfig ppp0" or something like that.
>
> Can you try doing something like
>
> #!/bin/sh
> x=0
> while true; do
> 	bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
> 	(cd foo; bk pull -q)
> 	rm -rf foo
> 	x=`expr $x + 1`
> 	echo -n "$x "
> done
>
Yes, I'll do those tests tonight.

> On Fri, May 14, 2004 at 07:46:17AM -0700, Larry McVoy wrote:
>> My instinct is that this is a file system or VM problem.  Here's why: 
>> BK
>> wraps its data in multiple integrity checks.  When you are doing a 
>> pull,
>> the data that is sent across the wire is wrapped both at the 
>> individual
>> diff level (each delta has a check) as well as a CRC around the whole
>> set of diffs and metadata sent.  Since Steven is pulling (I believe,
>> please confirm) from bkbits.net, we know that the data being generated
>> is fine - if it wasn't the whole world would be on our case.
>>
>> On the receiving side BK splats the entire set of diffs and metadata
>> down on disk, checking the CRC, and it doesn't proceed to the apply 
>> patch
>> part until the entire thing is on disk and checked.  Then when the 
>> patches
>> are applied, each per patch checksum is verified (except, as we 
>> recently
>> found out, in the case of the changeset file, we added some fast path
>> optimization for that and dropped the check on the floor.  Oops).
>>
>> I don't think pppd can be part of the problem because of the way BK is
>> designed - you shouldn't have gotten to the place you did if the data
>> was corrupted in transit.
>
> I agree, I don't see how it could be an in-flight corruption.
>
>> If any of pppd/kernel stuff is corrupting in memory pages, that's a
>> different matter entirely, that could cause these problems.
>
> This is my current top suspect.  Well, that, or rotted hardware with 
> the
> most bizarre symptoms I've ever seen.  A 16550, or ISA DMA controller,
> that just happens to stomp on buffer cache pages?
>
>> The fact that Steven is the only guy seeing this really makes me
>> suspicious that it is something with his kernel.  I don't think this
>> is a memory error problem, those never look like this, they look like
>> a few bits being flipped.  Blocks of nulls are always file/vm system.
>
> Yeah, I'm sure it's some function of his hardware and config.  But
> really, how many people do you suppose are running 2.6 with PPP and
> PREEMPT?  And how many of them would notice a few pages per day of
> partial buffer cache trashing?  I had a machine with one byte of memory
> that gave you "x" 50% of the time, and "x & 0xdf" the other 50% of the
> time; it took several months and a fairly serious filesystem blowup
> before I noticed enough problems to go run memtest86.
>
> -andy

And in case anyone is wondering, yes I did run memtest86 all night
on that machine with zero errors for all tests.

Question for the list.  Have the few folks out there still using dialup
ever seen the following problem with pppd and 2.6.x?

Occasionally, perhaps once every couple of hours of dialup connection 
time,
the data flow from pppd comes to a halt, and messages reporting
"too much work for irq10" appear in dmesg at that time.  Using the kppp 
2.4.2
GUI to exit leaves pppd still running.  Killing pppd works, and pppd 
can be
restarted normally. These failures never occurred with 2.4.x.

	Steven

