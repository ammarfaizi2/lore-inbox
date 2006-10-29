Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWJ2JSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWJ2JSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWJ2JSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:18:13 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:60301 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932123AbWJ2JSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:18:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yvqmEeXJ5OMQbo07qa+d++J/+DZsDj5hIVqSrPMpVMC2ac2GL/Tk81y/WL3fCS1eguwseilkPZhB13JlSEVVy56iUlB5HI6kQ3O9uSo4Vk2IQqSBHtCuYnD8ut7LJkrNsvYkae8Ub/+ukcGG1rRC5uRCmFW7qpP+BYkhbJXlNkw=  ;
Message-ID: <454471C3.2020005@yahoo.com.au>
Date: Sun, 29 Oct 2006 20:17:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@google.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
References: <454442DC.9050703@google.com> <20061029000513.de5af713.akpm@osdl.org>
In-Reply-To: <20061029000513.de5af713.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 28 Oct 2006 22:57:48 -0700
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
> 
>>-git4 was fine. -git5 is broken (on PPC64 blade)
>>
>>As -rc2-mm2 seemed fine on this box, I'm guessing it's something
>>that didn't go via Andrew ;-( Looks like it might be something
>>JFS or slab specific. Bigger PPC64 box with different config
>>was OK though.
>>
>>Full log is here: http://test.kernel.org/abat/59046/debug/console.log
>>Good -git4 run: http://test.kernel.org/abat/58997/debug/console.log
>>
>>kernel BUG in cache_grow at mm/slab.c:2705!
> 
> 
> This?
> 
> --- a/mm/vmalloc.c~__vmalloc_area_node-fix
> +++ a/mm/vmalloc.c
> @@ -428,7 +428,8 @@ void *__vmalloc_area_node(struct vm_stru
>  	area->nr_pages = nr_pages;
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
> -		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
> +		pages = __vmalloc_node(array_size, gfp_mask & ~__GFP_HIGHMEM,
> +					PAGE_KERNEL, node);
>  		area->flags |= VM_VPAGES;
>  	} else {
>  		pages = kmalloc_node(array_size,

Don't you actually *want* the page array to be allocated from highmem? So the
gfp mask here should be just for whether we're allowed to sleep / reclaim (ie
gfp_mask & ~(__GFP_DMA|__GFP_DMA32) | (__GFP_HIGHMEM))?

Slab allocations should be (gfp_mask & ~(__GFP_DMA|__GFP_DMA32|__GFP_HIGHMEM)),
which you could mask in __get_vm_area_node

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
