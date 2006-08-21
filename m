Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWHUMfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWHUMfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWHUMfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:35:41 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40379 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751136AbWHUMfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:35:40 -0400
Message-ID: <44E9A938.6010103@sw.ru>
Date: Mon, 21 Aug 2006 16:38:16 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>	 <1155825493.9274.42.camel@localhost.localdomain> <44E588F0.40502@sw.ru> <1155913582.9274.99.camel@localhost.localdomain>
In-Reply-To: <1155913582.9274.99.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2006-08-18 at 13:31 +0400, Kirill Korotaev wrote:
> 
>>they all are troublesome :/
>>user can create lots of vmas, w/o page tables.
>>lots of fdsets, ipcids.
>>These are not reclaimable.
> 
> 
> In the real world, with the customers to which you've given these
> patches, which of these objects is most likely to be consuming the most
> space?  Is there one set of objects that we could work on that would fix
> _most_ of the cases which you have encountered?
the question is not about which one consumes more in "real life".
The question is "which of the resources are allocated on user demand
and should be limited for the environment to be secure and isolated".

>>Also consider the following scenario with reclaimable page tables.
>>e.g. user hit kmemsize limit due to fat page tables.
>>kernel reclaims some of the page tables and frees user kenerl memory.
>>after that user creates some uncreclaimable objects like fdsets or ipcs
>>and then accesses memory with reclaimed page tables.
>>Sooner or later we kill user with SIGSEGV from page fault due to
>>no memory. This is worse then returning ENOMEM from poll() or
>>mmap() where user allocates kernel objects. 
> 
> 
> I think you're claiming that doing reclaim of kernel objects causes much
> more severe and less recoverable errors than does reclaiming of user
> pages.
I also claim that reclaiming some of kernel pages is almost undoable :)
Look, the page can be used by slab objects from 2 different containers.
Why one container should suffer from the second one which needs to be reclaimed?
What to do? separate allocators per container? And if you want to reclaim
say a page with vma you need to replaces tons of pointers all over the objects
in SMP safe manner.

 That might generally be true, but I have one example that's
> killing me.  (You shouldn't have mentioned mmap ;)
> 
> Let's say you have a memory area mapped by one pagetable page, and with
> 1 user page mapped in it.  The system is out of memory, and if you
> reclaim either the pagetable page or the user page, you're never going
> to get it back.
> 
> So, you pick the user page to reclaim.  The user touches it, the memory
> allocation fails, and the process gets killed.
> 
> Instead, you reclaim the pagetable page.  The user touches their page,
> the memory allocation for the pagetable fails, and the process gets
> killed.  
> 
> Seems like the same end result to me.  
because you suggest the same limit for pagetables and user memory.
Thats why we have separate kmemsize limit for kernel objects and privvmpages for
user memory.
privvmpages limit hit will result in -ENOMEM on mmap() system call,
which is memory friendly.

Kirill

