Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUBWAeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUBWAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:34:50 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:45734 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261294AbUBWAen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:34:43 -0500
Message-ID: <40394A9F.1050606@cyberone.com.au>
Date: Mon, 23 Feb 2004 11:34:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cw@f00f.org, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <20040222033111.GA14197@dingdong.cryptoapps.com>	<4038299E.9030907@cyberone.com.au>	<40382BAA.1000802@cyberone.com.au>	<4038307B.2090405@cyberone.com.au>	<40383300.5010203@matchmail.com>	<4038402A.4030708@cyberone.com.au>	<40384325.1010802@matchmail.com>	<403845CB.8040805@cyberone.com.au>	<20040221221721.42e734d6.akpm@osdl.org>	<40384D9D.6040604@cyberone.com.au>	<20040222083637.GA15589@dingdong.cryptoapps.com>	<20040222011350.58f756e8.akpm@osdl.org>	<40394662.5060104@cyberone.com.au> <20040222162634.560c5306.akpm@osdl.org>
In-Reply-To: <20040222162634.560c5306.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>Andrew Morton wrote:
>>
>>
>>>
>>>We do need to scan slab in response to highmem page reclaim as well. 
>>>Because all the math is based around the total amount of memory in the
>>>machine, and we know that if we're performing highmem page reclaim then the
>>>lower zones have no free memory.
>>>
>>>
>>>
>>I don't understand this. Presumably if the lower zones have no free
>>memory then we'll be doing lowmem page reclaim too, and that will
>>be shrinking the slab.
>>
>
>We should be performing lowmem page reclaim, but we're not.  With some
>highmem/lowmem size combinations the `incremental min' logic in the page
>allocator will prevent __GFP_HIGHMEM allocations from taking ZONE_NORMAL
>below pages_high and kswapd then does not perform page reclaim in the
>lowmem zone at all.  I'm seeing some workloads where we reclaim 700 highmem
>pages for each lowmem page.  This hugely exacerbated the slab problem on
>1.5G machines.  I have that fixed up now.
>
>

This is the incremental min logic doing its work though. Maybe
that should be fixed up to be less aggressive instead of putting
more complexity in the scanner to work around it.

Anyway could you post the patch you're using to fix it?

>Regardless of that, we do, logically, want to reclaim slab in response to
>highmem reclaim pressure because any highmem allocation can be satisfied by
>lowmem too.
>
>

The logical extension of that is: "we want to reclaim *lowmem* in
response to highmem reclaim pressure because any ..."

If this isn't what the scanner is doing then it should be fixed in
a more generic way.

