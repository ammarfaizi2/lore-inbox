Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266863AbUG1KLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUG1KLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUG1KLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:11:23 -0400
Received: from services.exanet.com ([212.143.73.102]:40360 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266863AbUG1KLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:11:03 -0400
Message-ID: <41077BB5.7050007@exanet.com>
Date: Wed, 28 Jul 2004 13:11:01 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au> <41075034.7080701@exanet.com> <410752BE.80808@yahoo.com.au> <41075986.8020401@exanet.com> <41076C6C.2010401@yahoo.com.au>
In-Reply-To: <41076C6C.2010401@yahoo.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2004 10:11:02.0144 (UTC) FILETIME=[2F9EF800:01C4748B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>>>
>>>>>
>>>>> The solution is that PF_MEMALLOC tasks are allowed to access the 
>>>>> reserve
>>>>> pool. Dependencies don't matter to this system. It would be your 
>>>>> job to
>>>>> ensure all tasks that might need to allocate memory in order to free
>>>>> memory have the flag set.
>>>>
>>>> In the general case that's not sufficient. What if the NFS server 
>>>> wrote to ext3 via the VFS? We might have a ton of ext3 pagecache 
>>>> waiting for kswapd to reclaim NFS memory, while kswapd is waiting 
>>>> on the NFS server writing to ext3.
>>>>
>>> It is sufficient.
>>>
>>> You didn't explain your example very well, but I'll assume it is the
>>> following:
>>>
>>> dirty NFS data -> NFS server on localhost -> ext3 filesystem. 
>>
>>
>> That's what I meant, sorry for not making it clear.
>>
>>> So kswapd tries to reclaim some memory and writes out the dirty NFS
>>> data. The NFS server then writes this data to ext3 (it can do this
>>> because it is PF_MEMALLOC). The data gets written out, the NFS server
>>> tells the client it is clean, kswapd continues.
>>>
>>> Right?
>>
>>
>> What's stopping the NFS server from ooming the machine then? Every 
>> time some bit of memory becomes free, the server will consume it 
>> instantly. Eventually ext3 will not be able to write anything out 
>> because it is out of memory.
>>
> The NFS server should do the writeout a page at a time.

The NFS server writes not only in response to page reclaim (as a local 
NFS client), but also in response to pressure from non-local clients. If 
both ext3 and NFS have the same allocation limits, NFS may starve out ext3.

(In my case the NFS server actually writes data asynchronously, so it 
doesn't really know it is responding to page reclaim, but the problem 
occurs even in a synchrounous NFS server.)

>
>> An even more complex case is when ext3 depends on some other process, 
>> say it is mounted on a loopback nbd.
>>
>>  dirty NFS data -> NFS server -> ext3 -> nbd -> nbd server on 
>> localhost -> ext3/raw device
>>
>> You can't have both the NFS server and the nbd server PF_MEMALLOC, 
>> since the NFS server may consume all memory, then wait for the nbd 
>> server to reclaim.
>>
> The memory allocators will block when memory reaches the reserved
> mark. Page reclaim will ask NFS to free one page, so the server
> will write something out to the filesystem, this will cause the nbd
> server (also PF_MEMALLOC) to write out to its backing filesystem.

If NFS and nbd have the same limit, then NFS may cause nbd to stall. 
We've already established that NFS must be PF_MEMALLOC, so nbd must be 
PF_MEMALLOC_HARDER or something like that.

> The solution I have in mind is to replace the sync allocation logic from
>
>>
>>    if (free_mem() < some_global_limit && !current->PF_MEMALLOC)
>>        wait_for_kswapd()
>>
>> to
>>
>>    if (free_mem() < current->limit)
>>        wait_for_kswapd()
>>
>> kswapd would have the lowest ->limit, other processes as their place 
>> in the food chain dictates. 
>
>
> I think this is barking up the wrong tree. It really doesn't matter
> what process is freeing memory. There isn't really anything special
> about the way kswapd frees memory.

To free memory you need (a) to allocate memory (b) possibly wait for 
some freeing process to make some progress. That means all processes in 
the freeing chain must be able to allocate at least some memory. If two 
processes in the chain share the same blocking logic, they may deadlock 
on each other.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


