Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268471AbUG2QO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268471AbUG2QO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268517AbUG2QOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:14:55 -0400
Received: from services.exanet.com ([212.143.73.102]:7942 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S268521AbUG2QJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:09:24 -0400
Message-ID: <41092131.2060200@exanet.com>
Date: Thu, 29 Jul 2004 19:09:21 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au> <41075034.7080701@exanet.com> <410752BE.80808@yahoo.com.au> <41075986.8020401@exanet.com> <41076C6C.2010401@yahoo.com.au> <41077BB5.7050007@exanet.com> <4107805A.3090609@yahoo.com.au> <4107927E.9070406@exanet.com> <4108B558.2050905@yahoo.com.au>
In-Reply-To: <4108B558.2050905@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 16:09:22.0504 (UTC) FILETIME=[693F4C80:01C47586]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Avi Kivity wrote:
>
>> Nick Piggin wrote:
>>
>>> Avi Kivity wrote:
>>>
>>>> Nick Piggin wrote:
>>>
>>>
>>>
>>>>>> What's stopping the NFS server from ooming the machine then? 
>>>>>> Every time some bit of memory becomes free, the server will 
>>>>>> consume it instantly. Eventually ext3 will not be able to write 
>>>>>> anything out because it is out of memory.
>>>>>>
>>>>> The NFS server should do the writeout a page at a time.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> The NFS server writes not only in response to page reclaim (as a 
>>>> local NFS client), but also in response to pressure from non-local 
>>>> clients. If both ext3 and NFS have the same allocation limits, NFS 
>>>> may starve out ext3.
>>>>
>>>
>>> What do you mean starve out ext3? ext3 gets written to *by the NFS 
>>> server*
>>> which is PF_MEMALLOC. 
>>
>>
>>
>> When the NFS server writes, it allocates pagecache and temporary 
>> objects. When ext3 writes, it allocates temporary objects. If the NFS 
>> server writes too much, ext3 can't allocate memory, and will never be 
>> able to allocate memory.
>>
>
> That is because your NFS server shouldn't hog as much memory as
> it likes when it is PF_MEMALLOC. The entire writeout path should
> do a page at a time if it is PF_MEMALLOC. Ie, the server should
> be doing write, fsync. 

We attempted to use sync local mounts (not what you are suggesting: on 
the NFS client side, without the PF_MEMALLOC hack) and still got the 
same deadlock. I am unable to explain why.

>
>
> But now that I think about it, I guess you may not be able to
> distinguish that from regular writeout, so doing a page at a time
> would hurt performance too much.
>
> Hmm so I guess the idea of a per task reserve limit may be the way
> to do it, yes. Thanks for bearing with me!

It was my pleasure.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


