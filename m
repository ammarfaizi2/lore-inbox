Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUJDIRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUJDIRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUJDIQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:16:42 -0400
Received: from mail-07.iinet.net.au ([203.59.3.39]:52171 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267798AbUJDIQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:16:01 -0400
Message-ID: <416106BB.9090908@cyberone.com.au>
Date: Mon, 04 Oct 2004 18:15:55 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-mm@kvack.org, akpm@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
References: <20041001182221.GA3191@logos.cnet> <415E12A9.7000507@cyberone.com.au> <20041002030857.GB4635@logos.cnet>
In-Reply-To: <20041002030857.GB4635@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>On Sat, Oct 02, 2004 at 12:30:01PM +1000, Nick Piggin wrote:
>
>>
>>Marcelo Tosatti wrote:
>>
>>
>>>With such a thing in place we can build a mechanism for kswapd 
>>>(or a separate kernel thread, if needed) to notice when we are low on 
>>>high order pages, and use the coalescing algorithm instead blindly 
>>>freeing unique pages from LRU in the hope to build large physically 
>>>contiguous memory areas.
>>>
>>>Comments appreciated.
>>>
>>>
>>>
>>Hi Marcelo,
>>Seems like a good idea... even with regular dumb kswapd "merging",
>>you may easily get stuck for example on systems without swap...
>>
>>Anyway, I'd like to get those beat kswapd patches in first. Then
>>your mechanism just becomes something like:
>>
>>   if order-0 pages are low {
>>       try to free memory
>>   }
>>   else if order-1 or higher pages are low {
>>        try to coalesce_memory
>>        if that fails, try to free memory
>>   }
>>
>
>Hi Nick!
>
>

Sorry, I'd been away for the weekend which is why I didn't get a
chance to reply to you.

>I understand that kswapd is broken, and it needs to go into the page reclaim path 
>to free pages when we are out of high order pages (what your 
>"beat kswapd" patches do and fix high-order failures by doing so), but 
>Linus's argument against it seems to be that "it potentially frees too much pages" 
>causing harm to the system. He also says this has been tried in the past, 
>with not nice results.
>
>

Not quite. I think a (the) big thing with my patch is that it will
check order-0...n watermarks when an order-n allocation is made.

So if there is no order >2 allocations happening, it won't attempt
to keep higher order memory available (until someone attempts an
allocation).

Basically, it gets kswapd doing the work when it would otherwise
have to be done in direct reclaim, *OR* otherwise indefinitely fail
if the allocations aren't blockable.

>And that is why its has not been merged into mainline.
>
>Is my interpretation correct?
>
>But right, kswapd needs to get fixed to honour high order
>pages.
>
>

Well Linus was silent on the issue after I answered his concerns.
I mailed him privately and he basically said that it seems sane,
and he is waiting for patches. Of course, by that stage it was
fairly late into 2.6.9, and the current behaviour isn't a regression,
so I'm shooting for 2.6.10.

Your defragmentor should sit very nicely on top of it, of course.


