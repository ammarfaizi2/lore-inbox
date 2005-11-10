Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVKJGuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVKJGuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 01:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVKJGuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 01:50:21 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:50078 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751196AbVKJGuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 01:50:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=eaSOlVVKiyN1ErTo3eecC51r6yMr6Q1M4v807/qXS479BZgUuKBLnZaYquhoQbiv8ZSHbkX1W9Azaex6fcu7wABdwsA/uLJhLNQRok9hS6rhpACQeMz/vZUSWkpAr/dRqwWbBC12/Ba2WI6TCg7izXcmt3CbZ7hJS0LMCnsUVdk=  ;
Message-ID: <4372EDA1.3000103@yahoo.com.au>
Date: Thu, 10 Nov 2005 17:50:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 04/16] radix-tree: look-aside cache
References: <20051109134938.757187000@localhost.localdomain> <20051109141448.974675000@localhost.localdomain> <437286BD.4000107@yahoo.com.au> <20051110052538.GA6585@mail.ustc.edu.cn>
In-Reply-To: <20051110052538.GA6585@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>Hi Nick,
>
>On Thu, Nov 10, 2005 at 10:31:09AM +1100, Nick Piggin wrote:
>
>>Does this cache add much performance compared with simple repeated
>>lookups? If the access patterns are highly local, the top of the
>>radix tree should be in cache.
>>
>It just guarantees constant lookup time for small/large files.
>
>My context based read-ahead code has been quite tricky just to avoid many radix
>tree lookups. I made it much simple and robust in the recent versions by just
>scanning through the cache. With the help of look-aside cache, the performance
>remains comparable with the tricky one. Sorry, the oprofile log was overwrote.
>But if you do need some numbers about the cache, I'll make one.
>
>

But it isn't *really* constant time lookups? I mean you'll
always have the O(logn) lookup. Amortised I guess that
becomes insignificant?

Briefly: is there a reason why you couldn't use gang lookups
instead? (Sorry I haven't been able to read and understand your
actual readahead code).

>>Do you think you could provide a simple 'use case' for an overview
>>of how you use the cache and what calls to make?
>>
>Ok, here it is:
>
> void func() {
>+       struct radix_tree_cache cache;
>+
>+       radix_tree_cache_init(&cache);
>        read_lock_irq(&mapping->tree_lock);
>        for(;;) {
>-               page = radix_tree_lookup(&mapping->page_tree, index);
>+               page = radix_tree_cache_lookup(&mapping->page_tree, &cache, index);
>        }
>        read_unlock_irq(&mapping->tree_lock);
> }
>
>

OK, I guess that seems reasonable.
You have introduced some other APIs as well...

Profile numbers would be great for the cached / non-cached cases.


Send instant messages to your online friends http://au.messenger.yahoo.com 
