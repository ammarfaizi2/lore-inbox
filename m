Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUJWK0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUJWK0a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUJWKYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:24:02 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:43106 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266498AbUJWKWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:22:45 -0400
Message-ID: <417A30EE.1030205@yahoo.com.au>
Date: Sat, 23 Oct 2004 20:22:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au> <20041023095955.GR14325@dualathlon.random>
In-Reply-To: <20041023095955.GR14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Sat, Oct 23, 2004 at 02:33:39PM +1000, Nick Piggin wrote:
> 
>>Andrea Arcangeli wrote:
>>
>>>I don't see any benefit in limiting the high order, infact it seems a
>>>bad bug. If something you should limit the _small_ order, so that the
>>>high order will have a slight chance to succeed. You're basically doing
>>>the opposite.
>>>
>>
>>You need the order there so someone can't allocate a huge amount
>>of memory and deplete all your reserves and crash the system.
> 
> 
> what? the point of alloc_pages is to allow people to allocate memory,
> what's the difference of 1 2M allocation and 512 4k allocations? No
> difference at all. Infact if something the 512 4k allocations hurts a
> lot more since they can fragment the memory, while the single 2M
> allocation will not fragment the memory. So if you really want to limit
> something you should do the exact opposite of what the allocator is
> doing.
> 
> 
>>For day to day running, it should barely make a difference because
>>the watermarks will be an order of magnitude larger.
> 
> 
> yes, it makes little difference, this is why it doesn't hurt that much.
> 

It is an unlikely scenario, but it is definitely good for robustness.
Especially on small memory systems where the amount allocated doesn't
have to be that large.

Let's say a 16MB system pages_low ~= 64K, so we'll also say we've
currently got 64K free. Someone then wants to do an order 4 allocation
OK they succeed (assuming memory isn't fragmented) and there's 0K free.

Which is bad because you can now get deadlocks when trying to free
memory.

> 
>>AFAIKS, pages_min, pages_low and pages_high are all required for
>>what we want to be doing. I don't see you you could remove any one
>>of them and still have everything functioning properly....
>>
>>I haven't really looked at 2.4 or your patches though. Maybe I
>>misunderstood you.
> 
> 
> 2.4 has everything functionally properly but it has no
> pages_min/low/high, it only has the watermarks. Infact the watermarks
> _are_ low/min/high. That's what I'm forward porting to 2.6 (besides
> fixing minor mostly not noticeable but harmful bits like the order
> nosense described above).
> 

Oh if you've still got the three watermarks then that may work -
I thought you meant getting rid of one of the *completely*.

But I'm still not sure what advantage you see in moving from
pages_xxx + protection to a single watermark.
