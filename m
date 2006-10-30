Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWJ3JyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWJ3JyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161148AbWJ3JyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:54:24 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:53771 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1161134AbWJ3JyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:54:23 -0500
Message-ID: <4545CB9B.2040502@shadowen.org>
Date: Mon, 30 Oct 2006 09:53:31 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@google.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
References: <454442DC.9050703@google.com> <20061029000513.de5af713.akpm@osdl.org> <4544E92C.8000103@shadowen.org> <4545325D.8080905@mbligh.org> <Pine.LNX.4.64.0610291718481.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610291718481.25218@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 29 Oct 2006, Martin J. Bligh wrote:
>> Seems like that doesn't fix it, I'm afraid.
> 
> Does the one in the current -git tree? It's commit 
> 5211e6e6c671f0d4b1e1a1023384d20227d8ee65, as below..
> 
> 		Linus

Submitted that commit, results in a couple of hours.

-apw

> 
> ---
> commit 5211e6e6c671f0d4b1e1a1023384d20227d8ee65
> Author: Giridhar Pemmasani <pgiri@yahoo.com>
> Date:   Sun Oct 29 04:46:55 2006 -0800
> 
>     [PATCH] Fix GFP_HIGHMEM slab panic
>     
>     As reported by Martin J. Bligh <mbligh@google.com>, we let through some
>     non-slab bits to slab allocation through __get_vm_area_node when doing a
>     vmalloc.
>     
>     I haven't been able to reproduce this, although I understand why it
>     happens: vmalloc allocates memory with
>     
>     GFP_KERNEL | __GFP_HIGHMEM
>     
>     and commit 52fd24ca1db3a741f144bbc229beefe044202cac resulted in the same
>     flags are passed down to cache_alloc_refill, causing the BUG.  The
>     following patch fixes it.
>     
>     Note that when calling kmalloc_node, I am masking off __GFP_HIGHMEM with
>     GFP_LEVEL_MASK, whereas __vmalloc_area_node does the same with
>     
>     ~(__GFP_HIGHMEM | __GFP_ZERO).
>     
>     IMHO, using GFP_LEVEL_MASK is preferable, but either should fix this
>     problem.
>     
>     Signed-off-by: Giridhar Pemmasani (pgiri@yahoo.com)
>     Cc: Martin J. Bligh <mbligh@google.com>
>     Cc: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6d381df..46606c1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -182,7 +182,7 @@ static struct vm_struct *__get_vm_area_n
>  	addr = ALIGN(start, align);
>  	size = PAGE_ALIGN(size);
>  
> -	area = kmalloc_node(sizeof(*area), gfp_mask, node);
> +	area = kmalloc_node(sizeof(*area), gfp_mask & GFP_LEVEL_MASK, node);
>  	if (unlikely(!area))
>  		return NULL;
>  

