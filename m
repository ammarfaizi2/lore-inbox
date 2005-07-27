Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVG0LaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVG0LaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVG0LaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:30:24 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:41673 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262196AbVG0LaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:30:19 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [patch 2/6] mm: micro-optimise rmap
From: Alexander Nyberg <alexn@telia.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42E5F19A.6050407@yahoo.com.au>
References: <42E5F139.70002@yahoo.com.au> <42E5F173.3010409@yahoo.com.au>
	 <42E5F19A.6050407@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 13:30:05 +0200
Message-Id: <1122463805.1166.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Nick, your mail bounced while sending this privately so reply-all this
time]

> Index: linux-2.6/mm/rmap.c
> ===================================================================
> --- linux-2.6.orig/mm/rmap.c
> +++ linux-2.6/mm/rmap.c
> @@ -442,22 +442,23 @@ int page_referenced(struct page *page, i
>  void page_add_anon_rmap(struct page *page,
>  	struct vm_area_struct *vma, unsigned long address)
>  {
> -	struct anon_vma *anon_vma = vma->anon_vma;
> -	pgoff_t index;
> -
>  	BUG_ON(PageReserved(page));
> -	BUG_ON(!anon_vma);
>  
>  	inc_mm_counter(vma->vm_mm, anon_rss);
>  
> -	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
> -	index = (address - vma->vm_start) >> PAGE_SHIFT;
> -	index += vma->vm_pgoff;
> -	index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
> -
>  	if (atomic_inc_and_test(&page->_mapcount)) {
> -		page->index = index;
> +		struct anon_vma *anon_vma = vma->anon_vma;
> +		pgoff_t index;
> +
> +		BUG_ON(!anon_vma);
> +		anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
>  		page->mapping = (struct address_space *) anon_vma;
> +
> +		index = (address - vma->vm_start) >> PAGE_SHIFT;
> +		index += vma->vm_pgoff;
> +		index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
> +		page->index = index;
> +

linear_page_index() here too?


