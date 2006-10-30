Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWJ3RkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWJ3RkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWJ3RkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:40:05 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:65204 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161216AbWJ3RkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:40:01 -0500
Message-ID: <454638D2.7050306@in.ibm.com>
Date: Mon, 30 Oct 2006 23:09:30 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org>
In-Reply-To: <4546212B.4010603@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> [snip]
> 
>> Reclaimable memory
>>
>> (i)   Anonymous pages - Anonymous pages are pages allocated by the user space,
>>       they are mapped into the user page tables, but not backed by a file.
> 
> I do not agree with such classification.
> When one maps file then kernel can remove page from address
> space as there is already space on disk for it. When one
> maps an anonymous page then kernel won't remove this page
> for sure as system may simply be configured to be swapless.

Yes, I agree if there is no swap space, then anonymous memory is pinned.
Assuming that we'll end up using a an abstraction on top of the
existing reclaim mechanism, the mechanism would know if a particular
type of memory is reclaimable or not.

But your point is well taken.

[snip]

>> (i)  Slabs
>> (ii) Kernel pages and page_tables allocated on behalf of a task.
> 
> I'd pay more attention to kernel memory accounting and less
> to user one as having kmemsize resource actually protects
> the system from DoS attacks. Accounting and limiting user
> pages doesn't protect system from anything.
> 

Please see my comments at the end

[snip]

> 
>> +----+---------+------+---------+------------+----------------+-----------+
>> | No |Guarantee| Limit| User I/F| Controllers| New Controllers|Statistics |
>> +----+---------+------+---------+------------+----------------+-----------+
>> | i  |  No     | Yes  | syscall | Memory     | No framework   |   Yes     |
>> |    |         |      |         |            | to write new   |           |
>> |    |         |      |         |            | controllers    |           |
> 
> The lattest Beancounter patches do provide framework for
> new controllers.
> 

I'll update the RFC.

> [snip]
> 
>> a. Beancounters currently account for the following resources
>>
>> (i)   kmemsize - memory obtained through alloc_pages() with __GFP_BC flag set.
>> (ii)  physpages - Resident set size of the tasks in the group.
>>       Reclaim support is provided for this resource.
>> (iii) lockedpages - User pages locked in memory
>> (iv)  slabs - slabs allocated with kmem_cache_alloc_bc are accounted and
>>       controlled.
> 
> This is also not true now. The latest beancounter code accounts for
> 1. kmemsie - this includes slab and vmalloc objects and "raw" pages
>    allocated directly from buddy allocator.

This is what I said, pages marked with __GFP_BC, so far on i386 I see
slab, vmalloc, PTE & LDT entries marked with the flag.


> 2. unreclaimable memory - this accounts for the total length of
>    mappings of a certain type. These are _mappings_ that are
>    accounted since limiting mapping limits memory usage and alows
>    a grace rejects (-ENOMEM returned from sys_mmap), but with
>    unlimited mappings you may limit memory usage with SIGKILL only.

ok, I'll add this too.

> 3. physical pages - these includes pages mapped in page faults and
>    hitting the pyspages limit starts pages reclamation.
> 

Yep, thats what I said.

> [snip]
> 
>> 5. Open issues
>>
>> (i)    Can we allow threads belonging to the same process belong
>>        to two different resource groups? Does this mean we need to do per-thread
>>        VM accounting now?
> 
> Solving this question is the same as solving "how would we account for
> pages that are shared between several processes?".
> 

Yes and that's an open issue too :)

>> (ii)   There is an overhead associated with adding a pointer in struct page.
>>        Can this be reduced/avoided? One solution suggested is to use a
>>        mirror mem_map.
> 
> This does not affect infrastructure, right? E.g. current beancounter
> code uses page_bc() macro to get BC pointer from page. Changing it
> from
> #define page_bc(page) ((page)->page_bc)
> to
> #define page_bc(page) ((bc_mmap[page_to_pfn(page)])
> or similar may be done at any moment.

The goal of the RFC is to discuss the controller. In the OLS BOF
on resource management, it was agreed that the controllers  should be
discussed and designed first, so that the proper infrastructure
could be put in place. Please see  http://lkml.org/lkml/2006/7/26/237.

> 
> We may deside that "each page has an associated BC pointer" and
> go on further discussion (e.g. which interface to use). The solution
> where to store this pointer may be taken after we agree on all the
> rest.


Yes, what you point out is an abstraction mechanism, that abstracts
out the implementation detail right now. I think its a good starting
point for further discussion.

[snip]

>>
>> 6. Going forward
>>
>> (i)    Agree on requirements (there has been some agreement already, please
>>        see http://lkml.org/lkml/2006/9/6/102 and the BOF summary [7])
>> (ii)   Agree on minimum accounting and hooks in the kernel. It might be
>>        a good idea to take this up in phases
>>        phase 1 - account for user space memory
>>        phase 2 - account for kernel memory allocated on behalf of the user/task
> 
> I'd raised the priority of kernel memory accounting.
> 
> I see that everyone agree that we want to see three resources:
>   1. kernel memory
>   2. unreclaimable memory
>   3. reclaimable memory
> if this is right then let's save it somewhere
> (e.g. http://wiki.openvz.org/Containers/UBC_discussion)
> and go on discussing the next question - interface.

I understand that kernel memory accounting is the first priority for
containers, but accounting kernel memory requires too many changes
to the VM core, hence I was hesitant to put it up as first priority.

But in general I agree, these are the three important resources for
accounting and control

[snip]

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
