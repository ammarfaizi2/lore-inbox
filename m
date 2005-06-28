Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVF1A5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVF1A5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVF1A5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:57:07 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:878 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262356AbVF1A46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:56:58 -0400
Message-ID: <42C0A04D.9060906@yahoo.com.au>
Date: Tue, 28 Jun 2005 10:56:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <20050627141220.GM3334@holomorphy.com> <42C093B4.3010707@yahoo.com.au>
In-Reply-To: <42C093B4.3010707@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> William Lee Irwin III wrote:
> 
>> On Mon, Jun 27, 2005 at 04:32:38PM +1000, Nick Piggin wrote:
>>
>>> +static inline struct page *page_cache_get_speculative(struct page 
>>> **pagep)
>>> +{
>>> +    struct page *page;
>>> +
>>> +    preempt_disable();
>>> +    page = *pagep;
>>> +    if (!page)
>>> +        goto out_failed;
>>> +
>>> +    if (unlikely(get_page_testone(page))) {
>>> +        /* Picked up a freed page */
>>> +        __put_page(page);
>>> +        goto out_failed;
>>> +    }
>>
>>
>>
>> So you pick up 0->1 refcount transitions.
>>
> 
> Yep ie. a page that's freed or being freed.
> 

Oh, one thing it does need is a check for PageFree(), so it also
picks up 1->2 and other transitions without freeing the free page
if the put()s are done out of order. Maybe that's what you were
alluding to.

I'll add that.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
