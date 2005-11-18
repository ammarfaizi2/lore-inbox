Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVKRUms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVKRUms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKRUms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:42:48 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:26375 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964782AbVKRUmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:42:46 -0500
Message-ID: <437E3CC2.6000003@argo.co.il>
Date: Fri, 18 Nov 2005 22:42:42 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <437E2C69.4000708@us.ibm.com> <437E2F22.6000809@argo.co.il> <437E30A8.1040307@us.ibm.com>
In-Reply-To: <437E30A8.1040307@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2005 20:42:44.0965 (UTC) FILETIME=[A0EAF950:01C5EC80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

>Avi Kivity wrote:
>  
>
>>1. If you have two subsystems which allocate critical pages, how do you
>>protect against the condition where one subsystem allocates all the
>>critical memory, causing the second to oom?
>>    
>>
>
>You don't.  You make sure that you size the critical pool appropriately for
>your workload.
>
>  
>
This may not be possible. What if subsystem A depends on subsystem B to 
do its work, both are critical, and subsystem A allocated all the memory 
reserve?
If A and B have different allocation thresholds, the deadlock is avoided.

At the very least you need a critical pool per subsystem.

>  
>
>>2. There already exists a critical pool: ordinary allocations fail if
>>free memory is below some limit, but special processes (kswapd) can
>>allocate that memory by setting PF_MEMALLOC. Perhaps this should be
>>extended, possibly with a per-process threshold.
>>    
>>
>
>The exception for threads with PF_MEMALLOC set is there because those
>threads are essentially promising that if the kernel gives them memory,
>they will use that memory to free up MORE memory.  If we ignore that
>promise, and (ab)use the PF_MEMALLOC flag to simply bypass the
>zone_watermarks, we'll simply OOM faster, and potentially in situations
>that could be avoided (ie: we steal memory that kswapd could have used to
>free up more memory).
>  
>
Sure, but that's just an example of a critical subsystem.

If we introduce yet another mechanism for critical memory allocation, 
we'll have a hard time making different subsystems, which use different 
critical allocation mechanisms, play well together.

I propose that instead of a single watermark, there should be a 
watermark per critical subsystem. The watermarks would be arranged 
according to the dependency graph, with the depended-on services allowed 
to go the deepest into the reserves.

(instead of PF_MEMALLOC have a tsk->memory_allocation_threshold, or 
similar. set it to 0 for kswapd, and for other systems according to taste)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

