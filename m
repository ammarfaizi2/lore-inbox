Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUDPC64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 22:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUDPC64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 22:58:56 -0400
Received: from fmr04.intel.com ([143.183.121.6]:14253 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262273AbUDPC6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 22:58:51 -0400
Message-Id: <200404160258.i3G2w8F13087@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [2/3]
Date: Thu, 15 Apr 2004 19:58:07 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjW6m77dYTwQWVSSum5XTHDInVDgAAf8WQ
In-Reply-To: <20040416023442.GF12735@zax>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> David Gibson wrote on Thursday, April 15, 2004 7:35 PM
> > Yes, killing follow_hugetlb_page() is safe because follow_page() takes
> > care of hugetlb page.  See 2nd patch posted earlier in
> > hugetlb_demanding_generic.patch
>
> Yes, I looked at it already.  But what I'm asking about is applying
> this patch *without* (or before) going to demand paging.
>
> Index: working-2.6/mm/memory.c
> ===================================================================
> --- working-2.6.orig/mm/memory.c	2004-04-13 11:42:42.000000000 +1000
> +++ working-2.6/mm/memory.c	2004-04-16 11:46:31.935870496 +1000
> @@ -766,16 +766,13 @@
>  				|| !(flags & vma->vm_flags))
>  			return i ? : -EFAULT;
>
> -		if (is_vm_hugetlb_page(vma)) {
> -			i = follow_hugetlb_page(mm, vma, pages, vmas,
> -						&start, &len, i);
> -			continue;
> -		}
>  		spin_lock(&mm->page_table_lock);
>  		do {
>  			struct page *map;
>  			int lookup_write = write;
>  			while (!(map = follow_page(mm, start, lookup_write))) {
> +				/* hugepages should always be prefaulted */
> +				BUG_ON(is_vm_hugetlb_page(vma));
>  				/*
>  				 * Shortcut for anonymous pages. We don't want
>  				 * to force the creation of pages tables for
>
> Yes, I looked at it already.  But what I'm asking about is applying
> this patch *without* (or before) going to demand paging.

In that case, yes, it is not absolutely required. But we do special
optimization for follow_hugetlb_pages() in the prefaulting implementation,
at least for ia64 arch. It give a sizable gain on db benchmark.

- Ken


