Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWIJCYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWIJCYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 22:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWIJCYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 22:24:20 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:5645 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965090AbWIJCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 22:24:19 -0400
Message-ID: <4503772C.5010105@shadowen.org>
Date: Sun, 10 Sep 2006 03:23:40 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] linear reclaim core
References: <exportbomb.1157718286@pinky>	<20060908122718.GA1662@shadowen.org> <20060908114114.87612de3.akpm@osdl.org>
In-Reply-To: <20060908114114.87612de3.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 8 Sep 2006 13:27:18 +0100
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>> When we are out of memory of a suitable size we enter reclaim.
>> The current reclaim algorithm targets pages in LRU order, which
>> is great for fairness but highly unsuitable if you desire pages at
>> higher orders.  To get pages of higher order we must shoot down a
>> very high proportion of memory; >95% in a lot of cases.
>>
>> This patch introduces an alternative algorithm used when requesting
>> higher order allocations.  Here we look at memory in ranges at the
>> order requested.  We make a quick pass to see if all pages in that
>> area are likely to be reclaimed, only then do we apply reclaim to
>> the pages in the area.
>>
>> Testing in combination with fragmentation avoidance shows
>> significantly improved chances of a successful allocation at
>> higher order.
> 
> I bet it does.
> 
> I'm somewhat surprised at the implementation.  Would it not be sufficient
> to do this within shrink_inactive_list()?  Something along the lines of:
> 
> - Pick tail page off LRU.
> 
> - For all "neighbour" pages (alignment == 1<<order, count == 1<<order)
> 
>   - If they're all PageLRU and !PageActive, add them all to page_list for
>     possible reclaim
> 
> And, in shrink_active_list:
> 
> - Pick tail page off LRU
> 
> - For all "neighbour" pages (alignment == 1<<order, count == 1<<order)
> 
>   If they're all PageLRU, put all the active pages in this block onto
>   l_hold for possible deactivation.
> 
> 
> Maybe all that can be done in isolate_lru_pages().

When we started out down this road we though we needed to scan linearly
too due to the buddy marking scheme.  Now that we're at this end of the
road we know thats pretty easy to fix, we're already considering merging
the two reclaims anyhow.

Probabally this would do something pretty similar.  It feels at a quick
glance as it its going to have slightly different semantics, but that
may be better or worse.

I'll go try it out and see how it looks.

Thanks for reading.

-apw
