Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbVKRTvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbVKRTvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKRTvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:51:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:51179 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161146AbVKRTvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:51:08 -0500
Message-ID: <437E30A8.1040307@us.ibm.com>
Date: Fri, 18 Nov 2005 11:51:04 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <437E2C69.4000708@us.ibm.com> <437E2F22.6000809@argo.co.il>
In-Reply-To: <437E2F22.6000809@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Matthew Dobson wrote:
> 
>> We have a clustering product that needs to be able to guarantee that the
>> networking system won't stop functioning in the case of OOM/low memory
>> condition.  The current mempool system is inadequate because to keep the
>> whole networking stack functioning, we need more than 1 or 2 slab
>> caches to
>> be guaranteed.  We need to guarantee that any request made with a
>> specific
>> flag will succeed, assuming of course that you've made your "critical
>> page
>> pool" big enough.
>>
>> The following patch series implements such a critical page pool.  It
>> creates 2 userspace triggers:
>>
>> /proc/sys/vm/critical_pages: write the number of pages you want to
>> reserve
>> for the critical pool into this file
>>
>> /proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
>> the system is in an emergency state and authorize the kernel to dip into
>> the critical pool to satisfy critical allocations.
>>
>> We mark critical allocations with the __GFP_CRITICAL flag, and when the
>> system is in an emergency state, we are allowed to delve into this
>> pool to
>> satisfy __GFP_CRITICAL allocations that cannot be satisfied through the
>> normal means.
>>
>>  
>>
> 1. If you have two subsystems which allocate critical pages, how do you
> protect against the condition where one subsystem allocates all the
> critical memory, causing the second to oom?

You don't.  You make sure that you size the critical pool appropriately for
your workload.


> 2. There already exists a critical pool: ordinary allocations fail if
> free memory is below some limit, but special processes (kswapd) can
> allocate that memory by setting PF_MEMALLOC. Perhaps this should be
> extended, possibly with a per-process threshold.

The exception for threads with PF_MEMALLOC set is there because those
threads are essentially promising that if the kernel gives them memory,
they will use that memory to free up MORE memory.  If we ignore that
promise, and (ab)use the PF_MEMALLOC flag to simply bypass the
zone_watermarks, we'll simply OOM faster, and potentially in situations
that could be avoided (ie: we steal memory that kswapd could have used to
free up more memory).

Thanks for your feedback!

-Matt
