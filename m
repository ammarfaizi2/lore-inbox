Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422991AbWJaIxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422991AbWJaIxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWJaIxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:53:12 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:14405 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1422991AbWJaIxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:53:11 -0500
Message-ID: <45470DF4.70405@openvz.org>
Date: Tue, 31 Oct 2006 11:48:52 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com>
In-Reply-To: <454638D2.7050306@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Pavel Emelianov wrote:
>> [snip]
>>
>>> Reclaimable memory
>>>
>>> (i)   Anonymous pages - Anonymous pages are pages allocated by the user space,
>>>       they are mapped into the user page tables, but not backed by a file.
>> I do not agree with such classification.
>> When one maps file then kernel can remove page from address
>> space as there is already space on disk for it. When one
>> maps an anonymous page then kernel won't remove this page
>> for sure as system may simply be configured to be swapless.
> 
> Yes, I agree if there is no swap space, then anonymous memory is pinned.
> Assuming that we'll end up using a an abstraction on top of the
> existing reclaim mechanism, the mechanism would know if a particular
> type of memory is reclaimable or not.

If memory is considered to be unreclaimable then actions should be
taken at mmap() time, not later! Rejecting mmap() is the only way to
limit user in unreclaimable memory consumption.

> But your point is well taken.

Thank you.

[snip]

>> This is also not true now. The latest beancounter code accounts for
>> 1. kmemsie - this includes slab and vmalloc objects and "raw" pages
>>    allocated directly from buddy allocator.
> 
> This is what I said, pages marked with __GFP_BC, so far on i386 I see
> slab, vmalloc, PTE & LDT entries marked with the flag.

Yes. I just wanted to keep all the things together.

[snip]

> I understand that kernel memory accounting is the first priority for
> containers, but accounting kernel memory requires too many changes
> to the VM core, hence I was hesitant to put it up as first priority.

Among all the kernel-code-intrusive patches in BC patch set
kmemsize hooks are the most "conservative" - only one place
is heavily patched - this is slab allocator. Buddy is patched,
but _significantly_ smaller. The rest of the patch adds __GFP_BC
flags to some allocations and SLAB_BC to some kmem_caches.

User memory controlling patch is much heavier...

I'd set priorities of development that way:

1. core infrastructure (mainly headers)
2. interface
3. kernel memory hooks and accounting
4. mappings hooks and accounting
5. physical pages hooks and accounting
6. user pages reclamation
7. moving threads between beancounters
8. make beancounter persistent
