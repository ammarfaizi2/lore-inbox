Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUIFBfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUIFBfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIFBfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:35:25 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:42083 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267381AbUIFBfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:35:10 -0400
Message-ID: <413BBECB.1060400@yahoo.com.au>
Date: Mon, 06 Sep 2004 11:35:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
References: <413AA7B2.4000907@yahoo.com.au>  <20040904230210.03fe3c11.davem@davemloft.net>  <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au>  <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org> <1094405830.2809.8.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Sun, 5 Sep 2004, Arjan van de Ven wrote:
>
>>well... we have a reverse mapping now. What is stopping us from doing
>>physical defragmentation ?
>>
>
>Nothing but replacement policy, really, and the fact that not everything
>is rmappable.
>
>I think we should _normally_ honor replacement policy, the way we do now.  
>Only if we are in the situation "we have enough memory, but not enough
>high-order-pages" should we go to a separate physical defrag algorithm.
>
>

Sure.

>So either kswapd should have a totally different mode, or there should be
>a separate "kdefragd". It would potentially also be good if it is user-
>triggerable, so that you could, for example, have a heavier defragd run
>from the daily "cron" runs - something that doesn't seem to make much
>sense from a traditional kswapd standpoint.
>
>In other words, I don't think the physical thing should be triggered at 
>all by normal memory pressure. A large-order allocation failure would 
>trigger it "somewhat", and maybe it might run very slowly in the 
>background (wake up every five minutes or so to see if it is worth doing 
>anything), and then some user-triggerable way to make it more aggressive.
>
>Does that sound sane to people?
>
>

Not to me :P

I think doing it just in time with kswapd and watermarks like we
do for order 0 allocations should be fine.

If you think of kswapd as "do the same freeing work the allocator
will otherwise have to" and "provide a context for doing freeing
work if the allocator can't" (in the !wait case)... then I think my
changes are pretty logical.

I think I confused everybody in the first email - we *do not* try
to heed any order-3 and above watermarks if we're only doing order-2
and below allocations... maybe this was the sticking point?

