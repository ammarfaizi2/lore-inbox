Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWDHQzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWDHQzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWDHQzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:55:07 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:45622 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965026AbWDHQzG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:55:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FgYMan+7fsbnKINtuRQAkoPA9unl539pkEDVuhv7Nwfovf8oNVe7l8CmMWv7XSZN0Ou5kR2d6mrptRmI2i4dZYtqrdjQhNMZ6O9sG+dnuzEtvHmPHEpWelem/VgzCuYkrDnF1FzjmyNm6oixakEZZxk5Ly0gCBQ1Xd4gB7PYc2I=
Message-ID: <84144f020604080955kd7d1fd5ge3b47dc6a268c6a0@mail.gmail.com>
Date: Sat, 8 Apr 2006 19:55:05 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Luke Yang" <luke.adi@gmail.com>
Subject: Re: [PATCH] Fix mm regression bug: nommu use compound page in slab allocator
Cc: "Nick Piggin" <npiggin@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <489ecd0c0603301811u3c8b6ac3lbe03a93a92bebf44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0603301811u3c8b6ac3lbe03a93a92bebf44@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 3/31/06, Luke Yang <luke.adi@gmail.com> wrote:
>   The earlier patch to consolidate mmu and nommu page allocation
> and refcounting by using compound pages for nommu allocations
> had a bug: kmalloc slabs who's pages were initially allocated
> by a non-__GFP_COMP allocator could be passed into mm/nommu.c
> kmalloc allocations which really wanted __GFP_COMP underlying
> pages. Fix that by having nommu pass __GFP_COMP to all higher order
> slab allocations.

Any reason we are not doing this for CONFIG_MMU as well? We could then
fix the slab callers to not pass __GFP_COMP at all which seems broken
anyway.

                                 Pekka

> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> Acked-by: Nick Piggin <npiggin@suse.de>
>
>  slab.c |    4 ++++
> 1 files changed, 4 insertions(+)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 4cbf8bb..388a6a9 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1454,7 +1454,11 @@ static void *kmem_getpages(struct kmem_c
>         int i;
>
>         flags |= cachep->gfpflags;
> +#ifdef CONFIG_MMU
>         page = alloc_pages_node(nodeid, flags, cachep->gfporder);
> +#else
> +       page = alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfporder);
> +#endif
>         if (!page)
>                 return NULL;
>         addr = page_address(page);
