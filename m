Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266882AbUG1LsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUG1LsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUG1LsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:48:23 -0400
Received: from services.exanet.com ([212.143.73.102]:47585 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266882AbUG1LsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:48:16 -0400
Message-ID: <4107927E.9070406@exanet.com>
Date: Wed, 28 Jul 2004 14:48:14 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au> <41075034.7080701@exanet.com> <410752BE.80808@yahoo.com.au> <41075986.8020401@exanet.com> <41076C6C.2010401@yahoo.com.au> <41077BB5.7050007@exanet.com> <4107805A.3090609@yahoo.com.au>
In-Reply-To: <4107805A.3090609@yahoo.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2004 11:48:14.0597 (UTC) FILETIME=[C408AB50:01C47498]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Avi Kivity wrote:
>
>> Nick Piggin wrote:
>
>
>>>> What's stopping the NFS server from ooming the machine then? Every 
>>>> time some bit of memory becomes free, the server will consume it 
>>>> instantly. Eventually ext3 will not be able to write anything out 
>>>> because it is out of memory.
>>>>
>>> The NFS server should do the writeout a page at a time.
>>
>>
>>
>> The NFS server writes not only in response to page reclaim (as a 
>> local NFS client), but also in response to pressure from non-local 
>> clients. If both ext3 and NFS have the same allocation limits, NFS 
>> may starve out ext3.
>>
>
> What do you mean starve out ext3? ext3 gets written to *by the NFS 
> server*
> which is PF_MEMALLOC. 

When the NFS server writes, it allocates pagecache and temporary 
objects. When ext3 writes, it allocates temporary objects. If the NFS 
server writes too much, ext3 can't allocate memory, and will never be 
able to allocate memory.

>
>
>> (In my case the NFS server actually writes data asynchronously, so it 
>> doesn't really know it is responding to page reclaim, but the problem 
>> occurs even in a synchrounous NFS server.)
>>
>
> I can't see this being the responsibility of the kernel. The NFS server
> could probably find out if it is servicing a loopback request or not. 

It might be emptying its own caches. Or any one of a hundred other 
things. Everything can be hacked around (as I did with PF_MEMALLOC, and 
relying on my server to write directly), but that's not a general solution.

>
> Remote requests don't help to free memory... unless maybe you want a
> filesystem on a remote nbd to be exported back to server via NFS or
> something crazy. 

Cycles can easily happen in clusters, especially with failover and failback.

>>>> An even more complex case is when ext3 depends on some other 
>>>> process, say it is mounted on a loopback nbd.
>>>>
>>>>  dirty NFS data -> NFS server -> ext3 -> nbd -> nbd server on 
>>>> localhost -> ext3/raw device
>>>>
>>>> You can't have both the NFS server and the nbd server PF_MEMALLOC, 
>>>> since the NFS server may consume all memory, then wait for the nbd 
>>>> server to reclaim.
>>>>
>>> The memory allocators will block when memory reaches the reserved
>>> mark. Page reclaim will ask NFS to free one page, so the server
>>> will write something out to the filesystem, this will cause the nbd
>>> server (also PF_MEMALLOC) to write out to its backing filesystem.
>>
>>
>> If NFS and nbd have the same limit, then NFS may cause nbd to stall. 
>> We've already established that NFS must be PF_MEMALLOC, so nbd must 
>> be PF_MEMALLOC_HARDER or something like that.
>
>
> No, your NFS server has to be coded differently. You can't allow it
> to use up all PF_MEMALLOC memory just because it can. 

There is no API that the NFS server can use to block and unblock on 
memory allocation.

My proposal extends memory allocation in general to block and unblock in 
a way that prevents deadlocks, providing the reservation levels have 
been set up correctly. And it can work cluster-wide.

>>> The solution I have in mind is to replace the sync allocation logic 
>>> from
>>>
>>>>
>>>>    if (free_mem() < some_global_limit && !current->PF_MEMALLOC)
>>>>        wait_for_kswapd()
>>>>
>>>> to
>>>>
>>>>    if (free_mem() < current->limit)
>>>>        wait_for_kswapd()
>>>>
>>>> kswapd would have the lowest ->limit, other processes as their 
>>>> place in the food chain dictates. 
>>>
>>>
>>> I think this is barking up the wrong tree. It really doesn't matter
>>> what process is freeing memory. There isn't really anything special
>>> about the way kswapd frees memory.
>>
>>
>> To free memory you need (a) to allocate memory (b) possibly wait for 
>> some freeing process to make some progress. That means all processes 
>> in the freeing chain must be able to allocate at least some memory. 
>> If two processes in the chain share the same blocking logic, they may 
>> deadlock on each other.
>>
>
> The PF_MEMALLOC path isn't to be used like that. If a *single*
> PF_MEMALLOC task were to allocate all its memory then that would
> be a bug too.

Again, there is no way for a task to know how much memory to allocate. 
Even if it writes out one page at a time, if it's PF_MEMALLOC and it 
generates dirty pagecache, it will soon consume all memory. Would you 
have the server sleep() after every write?

Note that my proposal is a generalization of PF_MEMALLOC; instead of 
setting the PF_MEMALLOC flag in kswapd you can set 
current->min_free_mem_to_allocate_nonblockingly to 0.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


