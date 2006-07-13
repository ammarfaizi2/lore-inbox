Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWGMHih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWGMHih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWGMHih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:38:37 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40114 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1751226AbWGMHig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:38:36 -0400
Message-ID: <44B5F87E.6020708@web.de>
Date: Thu, 13 Jul 2006 09:38:38 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix oom roll-back of __vmalloc_area_node
References: <44B3FDE4.4040209@web.de> <20060713001433.801fa304.akpm@osdl.org>
In-Reply-To: <20060713001433.801fa304.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> On Tue, 11 Jul 2006 21:37:08 +0200
> Jan Kiszka <jan.kiszka@web.de> wrote:
>
>   
>> __vunmap must not rely on area->nr_pages when picking the
>> release methode for area->pages. It may be too small when
>> __vmalloc_area_node failed early due to lacking memory.
>> Instead, use a flag in vmstruct to differentiate.
>>     
>
> So you mean that when this:
>
> 		if (unlikely(!area->pages[i])) {
> 			/* Successfully allocated i pages, free them in __vunmap() */
> 			area->nr_pages = i;
> 			goto fail;
>
> happens, it could be that i <= PAGE_SIZE/sizeof(struct page *) and __vunmap
> kfree()s something which it should have vfree()d, yes?
>
>   

Yes, exactly. It then causes some BUG in kfree during unroll.


> That sounds like a dead box, or worse.
>
>   
Someone triggered a too large vmalloc request, that was the scenario here.

> I think the change would be a good one even if it didn't fix a bug, thanks.
>
>   
Meanwhile I thought about an even simpler solution:


__vunmap must not rely on area->nr_pages when picking the
release methode for area->pages. It may be too small when
__vmalloc_area_node failed due to lacking memory. Check
for the vmalloc address range instead.

Signed-off by: Jan Kiszka <jan.kiszka@web.de>

Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -340,7 +340,7 @@ void __vunmap(void *addr, int deallocate
 			__free_page(area->pages[i]);
 		}
 
-		if (area->nr_pages > PAGE_SIZE/sizeof(struct page *))
+		if (area->pages >= VMALLOC_START && area->pages < VMALLOC_END)
 			vfree(area->pages);
 		else
 			kfree(area->pages);


