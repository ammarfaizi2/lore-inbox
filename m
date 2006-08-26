Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422919AbWHZD4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbWHZD4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 23:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422931AbWHZD4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 23:56:22 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:24733 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422919AbWHZD4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 23:56:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CCYBjIUt2WNHXsVybiz1/uzLrICGAv5K7XmylpPFZzbjLiMJiRsWphUWlMalmfkjXrnL+A2g3nduaxiWZZcktpaqrISckXmON5MTilEKx+FRA8zerQ6924oFw5s1U8m3x7d9b71n0XTVX/yghGfrZ8jSlasp1RlMUCfqGll0xk4=  ;
Message-ID: <44EFC63F.7030309@yahoo.com.au>
Date: Sat, 26 Aug 2006 13:55:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru>	<20060823100532.459da50a.akpm@osdl.org>	 <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>	 <44EF13BB.9030406@yahoo.com.au> <1156521434.3007.251.camel@localhost.localdomain>
In-Reply-To: <1156521434.3007.251.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sad, 2006-08-26 am 01:14 +1000, ysgrifennodd Nick Piggin:
> 
>>I still think doing simple accounting per-page would be a better way to
>>go than trying to pin down all "user allocatable" kernel allocations.
>>And would require all of about 2 hooks in the page allocator. And would
>>track *actual* RAM allocated by that container.
> 
> 
> You have a variety of kernel objects you want to worry about and they
> have very differing properties.
> 
> Some are basically shared resources - page cache, dentries, inodes, etc
> and can be balanced pretty well by the kernel (ok the dentries are a bit
> of a problem right now). Others are very specific "owned" resources -
> like file handles, sockets and vmas.

That's true (OTOH I'd argue it would still be very useful for things
like pagecache, so one container can't start a couple of 'dd' loops
and turn everyone else to crap). And while the sharing may not be
exactly captured, statistically things should balance over time.

So I'm not arguing about _also_ accounting resources that are limited
in other ways (than just the RAM they consume).

But as a DoS protection measure on RAM usage, trying to account all
kernel allocations that are user triggerable just sounds hard to
maintain, holey, ugly, invsive (and not perfect either -- in fact it
still isn't clear to me that it is any better than my proposal).

> 
> Tracking actual RAM use by container/user/.. isn't actually that
> interesting. It's also inconveniently sub page granularity.

If it isn't interesting, then I don't think we want it (at least, until
someone does get an interest in it).

> 
> Its a whole seperate question whether you want a separate bean counter
> limit for sockets, file handles, vmas etc.

Yeah that's fair enough. We obviously want to avoid exposing limits on
things that it doesn't make sense to limit, or that is a kernel
implementation detail as much as possible.

eg. so I would be happy to limit virtual address, less happy to limit
vmas alone (unless that is in the context of accounting their RAM usage
or their implied vaddr charge).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
