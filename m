Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVAXUMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVAXUMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVAXUMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:12:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:50620 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261609AbVAXUMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:12:31 -0500
Message-ID: <41F54CBC.9030606@colorfullife.com>
Date: Mon, 24 Jan 2005 20:30:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Andrew Morton <akpm@zip.com.au>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] Make slab use alloc_pages directly
References: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

>__get_free_pages() calls alloc_pages, finds the page_address() and
>throws away the struct page *.  Slab then calls virt_to_page to get it
>back again.  Much more efficient for slab to call alloc_pages itself,
>as well as making the NUMA and non-NUMA cases more similarr to each other.
>
>Signed-off-by: Matthew Wilcox <matthew@wil.cx>
>
>  
>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

>Index: linux-2.6/mm/slab.c
>===================================================================
>RCS file: /var/cvs/linux-2.6/mm/slab.c,v
>retrieving revision 1.29
>diff -u -p -r1.29 slab.c
>--- linux-2.6/mm/slab.c	12 Jan 2005 20:18:07 -0000	1.29
>+++ linux-2.6/mm/slab.c	24 Jan 2005 16:47:02 -0000
>@@ -894,16 +894,13 @@ static void *kmem_getpages(kmem_cache_t 
> 
> 	flags |= cachep->gfpflags;
> 	if (likely(nodeid == -1)) {
>-		addr = (void*)__get_free_pages(flags, cachep->gfporder);
>-		if (!addr)
>-			return NULL;
>-		page = virt_to_page(addr);
>+		page = alloc_pages(flags, cachep->gfporder);
> 	} else {
> 		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
>-		if (!page)
>-			return NULL;
>-		addr = page_address(page);
> 	}
>+	if (!page)
>+		return NULL;
>+	addr = page_address(page);
> 
> 	i = (1 << cachep->gfporder);
> 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
>
>  
>

