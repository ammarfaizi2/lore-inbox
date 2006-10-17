Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWJQRx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWJQRx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWJQRx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:53:26 -0400
Received: from smtp-out.google.com ([216.239.45.12]:3635 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751174AbWJQRxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:53:25 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=GPPqKRa4MGchnJF42vvl1KpAIA+Zxud+xCL6G6CNaGgLkGQ/f7huKDcw5Owc7eGXx
	v7BsMk/uPz6TevlQ50NxQ==
Message-ID: <45351877.9030107@google.com>
Date: Tue, 17 Oct 2006 10:52:55 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] Remove temp_priority
References: <45351423.70804@google.com> <4535160E.2010908@yahoo.com.au>
In-Reply-To: <4535160E.2010908@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Martin Bligh wrote:
> 
>> This is not tested yet. What do you think?
>>
>> This patch removes temp_priority, as it is racy. We're setting
>> prev_priority from it, and yet temp_priority could have been
>> set back to DEF_PRIORITY by another reclaimer.
> 
> 
> I like it.

OK, I think that should fix most of it, and I'll admit it's cleaner
than the first one.

> I wonder if we should get kswapd to stick its priority
> into the zone at the point where zone_watermark_ok becomes true,
> rather than setting all zones to the lowest priority? That would
> require a bit more logic though I guess.
 >
> For that matter (going off the topic a bit), I wonder if
> try_to_free_pages should have a watermark check there too? This
> might help reduce the latency issue you brought up where one process
> has reclaimed a lot of pages, but another isn't making any progress
> and has to go through the full priority range? Maybe that's
> statistically pretty unlikely?

I've been mulling over how to kill prev_priority (and make everyone
happy, including akpm). My original thought was to keep a different
min_priority for each of GFP_IO, GFP_IO|GFP_FS, and the no IO ones.
But we still have the problem of how to accurately set the min back
up when we are sucessful.

Perhaps we should be a little more radical, and treat everyone apart
from kswapd as independant. Keep a kswapd_priority in the zone
structure, and all the direct reclaimers have their own local priority.
Then we set distress from min(kswap_priority, priority). All that does
is kick the direct reclaimers up a bit faster - kswapd has the easiest
time reclaiming pages, so that should never be too low.

M.




