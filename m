Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWCGXcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWCGXcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWCGXcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:32:17 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:16597 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964805AbWCGXcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:32:16 -0500
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org>
Message-ID: <cone.1141774323.5234.18683.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Wed, 08 Mar 2006 10:32:03 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> Swap prefetching doesn't use very much cpu but spends a lot of time waiting on 
>> disk in uninterruptible sleep. This means it won't get preempted often even at 
>> a low nice level since it is seen as sleeping most of the time. We want to 
>> minimise its cpu impact so yield where possible.
>> 
>> Signed-off-by: Con Kolivas <kernel@kolivas.org>
>> ---
>>  mm/swap_prefetch.c |    1 +
>>  1 file changed, 1 insertion(+)
>> 
>> Index: linux-2.6.15-ck5/mm/swap_prefetch.c
>> ===================================================================
>> --- linux-2.6.15-ck5.orig/mm/swap_prefetch.c	2006-03-02 14:00:46.000000000 +1100
>> +++ linux-2.6.15-ck5/mm/swap_prefetch.c	2006-03-08 08:49:32.000000000 +1100
>> @@ -421,6 +421,7 @@ static enum trickle_return trickle_swap(
>>  
>>  		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
>>  			break;
>> +		yield();
>>  	}
>>  
>>  	if (sp_stat.prefetched_pages) {
> 
> yield() really sucks if there are a lot of runnable tasks.  And the amount
> of CPU which that thread uses isn't likely to matter anyway.
> 
> I think it'd be better to just not do this.  Perhaps alter the thread's
> static priority instead?  Does the scheduler have a knob which can be used
> to disable a tasks's dynamic priority boost heuristic?

We do have SCHED_BATCH but even that doesn't really have the desired effect. 
I know how much yield sucks and I actually want it to suck as much as yield 
does.

Cheers,
Con

