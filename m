Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUG1HFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUG1HFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUG1HFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:05:37 -0400
Received: from services.exanet.com ([212.143.73.102]:13888 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266569AbUG1HF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:05:26 -0400
Message-ID: <41075034.7080701@exanet.com>
Date: Wed, 28 Jul 2004 10:05:24 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au>
In-Reply-To: <410739BD.2040203@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2004 07:05:24.0894 (UTC) FILETIME=[414D7BE0:01C47471]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Avi Kivity wrote:
>
>> Nick Piggin wrote:
>>
>>>
>>> There is some need arising for a call to set the PF_MEMALLOC flag for
>>> userspace tasks, so you could probably get a patch accepted. Don't
>>> call it KSWAPD_HELPER though, maybe MEMFREE or RECLAIM or 
>>> RECLAIM_HELPER.
>>
>>
>>
>> I don't think my patch is general enough, it deals with only one 
>> level of dependencies, and doesn't work if the NFS server (or other 
>> process that kswapd depends on) depends on kswapd itself. It was 
>> intended more as an RFC than a request for inclusion.
>>
>> It's probably fine for those with the exact same problem as us.
>>
>
> Well it isn't that you depend on kswapd, but that your task gets called
> into via page reclaim (to facilitate page reclaim). In which case having
> the task block in memory allocation can cause a deadlock.

In my particular case that's true, so I only depended on kswapd as a 
side effect of the memory allocation logic. Setting PF_MEMALLOC fixed that.

>
> The solution is that PF_MEMALLOC tasks are allowed to access the reserve
> pool. Dependencies don't matter to this system. It would be your job to
> ensure all tasks that might need to allocate memory in order to free
> memory have the flag set.

In the general case that's not sufficient. What if the NFS server wrote 
to ext3 via the VFS? We might have a ton of ext3 pagecache waiting for 
kswapd to reclaim NFS memory, while kswapd is waiting on the NFS server 
writing to ext3.

The patch I posted is simple and quite sufficient for my needs, but I'm 
sure more convoluted cases will turn up where something more complex is 
needed. Probably one can construct such cases out of in-kernel 
components like the loop device, dm, and the NFS client and server.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


