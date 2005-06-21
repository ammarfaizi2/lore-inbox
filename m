Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVFUUnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFUUnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFUUnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:43:19 -0400
Received: from alog0236.analogic.com ([208.224.220.251]:36998 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261667AbVFUUfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:35:12 -0400
Date: Tue, 21 Jun 2005 16:35:00 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12 memory mapping broken
In-Reply-To: <Pine.LNX.4.61.0506212041000.7385@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0506211630020.5140@chaos.analogic.com>
References: <Pine.LNX.4.61.0506201548150.5317@chaos.analogic.com>
 <Pine.LNX.4.61.0506212041000.7385@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Hugh Dickins wrote:

> On Mon, 20 Jun 2005, Richard B. Johnson wrote:
>>
>> To the memory expert that made the massive changes to mm/memory.c:
>>
>> Code in linux-2.6.12 fails with the following (remap_pfn_range
>> gets the exact same values):
>>
>> UNIQUE.dma.len = 04001fe0
>> vma->vm_end-vma->vm_start=04002000
>> About to execute remap_pfn_range
>> vma->vm_start = 20000000
>> base address = 30003000
>>            length = 04001fe0 >> PAGE_SHIFT
>> vma->vm_page_prot = 0000003f
>> ------------[ cut here ]------------
>> kernel BUG at mm/memory.c:1112!
>>
>> I can test any patches.
>
> You are right, and it's my fault.  May I wriggle a little and point
> out that your length is unusual, and even you seem confused whether
> you want to map 0x4001 or 0x4002 pages?  But the blame lies with me.
>

The user isn't supposed to be able to map 'my' reserved page, therefore
there is a check in the code which made the number less than what
your code expected, triggering the loop problem.

> Please try this patch, which I'll send to Andrew and -stable if you
> can confirm that it fixes your problem.  remap_pfn_range is, I believe
> (and shall recheck), the only exported interface vulnerable to this
> loop-termination issue.
>
> Thanks,
> Hugh
>
> --- 2.6.12/mm/memory.c	2005-06-17 20:48:29.000000000 +0100
> +++ linux/mm/memory.c	2005-06-21 20:31:42.000000000 +0100
> @@ -1164,7 +1164,7 @@ int remap_pfn_range(struct vm_area_struc
> {
> 	pgd_t *pgd;
> 	unsigned long next;
> -	unsigned long end = addr + size;
> +	unsigned long end = addr + PAGE_ALIGN(size);
> 	struct mm_struct *mm = vma->vm_mm;
> 	int err;
>
>

Thank you. It works perfectly now.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
