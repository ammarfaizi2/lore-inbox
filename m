Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUG1JJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUG1JJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUG1JJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:09:16 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:21634 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266836AbUG1JIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:08:46 -0400
Message-ID: <41076C6C.2010401@yahoo.com.au>
Date: Wed, 28 Jul 2004 19:05:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Avi Kivity <avi@exanet.com>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au> <41075034.7080701@exanet.com> <410752BE.80808@yahoo.com.au> <41075986.8020401@exanet.com>
In-Reply-To: <41075986.8020401@exanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Nick Piggin wrote:
> 
>> Avi Kivity wrote:
>>
>>> Nick Piggin wrote:
>>
>>
>>
>>>>
>>>> The solution is that PF_MEMALLOC tasks are allowed to access the 
>>>> reserve
>>>> pool. Dependencies don't matter to this system. It would be your job to
>>>> ensure all tasks that might need to allocate memory in order to free
>>>> memory have the flag set.
>>>
>>>
>>>
>>>
>>> In the general case that's not sufficient. What if the NFS server 
>>> wrote to ext3 via the VFS? We might have a ton of ext3 pagecache 
>>> waiting for kswapd to reclaim NFS memory, while kswapd is waiting on 
>>> the NFS server writing to ext3.
>>>
>>
>> It is sufficient.
>>
>> You didn't explain your example very well, but I'll assume it is the
>> following:
>>
>> dirty NFS data -> NFS server on localhost -> ext3 filesystem. 
> 
> 
> That's what I meant, sorry for not making it clear.
> 
>>
>>
>> So kswapd tries to reclaim some memory and writes out the dirty NFS
>> data. The NFS server then writes this data to ext3 (it can do this
>> because it is PF_MEMALLOC). The data gets written out, the NFS server
>> tells the client it is clean, kswapd continues.
>>
>> Right?
> 
> 
> What's stopping the NFS server from ooming the machine then? Every time 
> some bit of memory becomes free, the server will consume it instantly. 
> Eventually ext3 will not be able to write anything out because it is out 
> of memory.
> 

The NFS server should do the writeout a page at a time.

> An even more complex case is when ext3 depends on some other process, 
> say it is mounted on a loopback nbd.
> 
>  dirty NFS data -> NFS server -> ext3 -> nbd -> nbd server on localhost 
> -> ext3/raw device
> 
> You can't have both the NFS server and the nbd server PF_MEMALLOC, since 
> the NFS server may consume all memory, then wait for the nbd server to 
> reclaim.
> 

The memory allocators will block when memory reaches the reserved
mark. Page reclaim will ask NFS to free one page, so the server
will write something out to the filesystem, this will cause the nbd
server (also PF_MEMALLOC) to write out to its backing filesystem.

> The solution I have in mind is to replace the sync allocation logic from
> 
>    if (free_mem() < some_global_limit && !current->PF_MEMALLOC)
>        wait_for_kswapd()
> 
> to
> 
>    if (free_mem() < current->limit)
>        wait_for_kswapd()
> 
> kswapd would have the lowest ->limit, other processes as their place in 
> the food chain dictates. 

I think this is barking up the wrong tree. It really doesn't matter
what process is freeing memory. There isn't really anything special
about the way kswapd frees memory.
