Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUIFBM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUIFBM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUIFBLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:11:16 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:34239 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267381AbUIFBK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:10:26 -0400
Message-ID: <413BB8C2.6010705@yahoo.com.au>
Date: Mon, 06 Sep 2004 11:09:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net> <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au> <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Sun, 5 Sep 2004, Nick Piggin wrote:
>
>>Hmm, and the crowning argument for not stopping at order 3 is that if we
>>never use higher order allocations, nothing will care about their watermarks
>>anyway. I think I had myself confused when that question in the first place.
>>
>>So yeah, stopping at a fixed number isn't required, and as you say it keeps
>>things general and special cases minimal.
>>
>
>Hey, please refute my "you need 20% free" to get even to order-3 for most
>cases first.
>
>

s/need 20% free/need to free 20%/ ?

I won't refute that. It is an unfortunate effect of using dumb scanning to
free higher order memory. Orthogonal to my patch, which just uses the 
current
freeing mechanism to ensure kswapd gets off its bottom and does some 
work for
higher order allocators.

>It's probably acceptable to have a _very_ backgrounded job that does
>freeing if order-3 isn't available, but it had better be pretty
>slow-moving, I suspect. On the order of "It's probably ok to try to aim
>for up to 25% free 'overnight' if the machine is idle" but it's almost
>certainly not ok to aggressively push things out to that degree..
>
>

I think my mechanism is about as on-demand as you can get. I think we've
typically leaned this way WRT the memory manager as opposed to background
scanning and freeing.... so sure you could introduce a new method for 
freeing
higher order memory (ie. defragmenting), but I think you'd still want to use
my kswapd scheme in that case as well.

So instead of always freeing pages, you'd say:
    if (!watermark_ok(order 0 pages))
       try_to_free_pages
    if (!watermark_ok(order-that-i-need))
       try_to_defragment_pages

