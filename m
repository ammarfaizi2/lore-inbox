Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUDORfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUDORcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:32:41 -0400
Received: from fmr04.intel.com ([143.183.121.6]:26520 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263027AbUDORbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:31:01 -0400
Message-Id: <200404151727.i3FHRwF08564@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [2/3]
Date: Thu, 15 Apr 2004 10:27:58 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040415071728.GE25560@zax>
Thread-Index: AcQjBNiluzp39IC6SlOg90j8XJy+UgACKnUg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> David Gibson wrote on Thursday, April 15, 2004 12:17 AM
> > diff -Nurp linux-2.6.5/mm/memory.c linux-2.6.5.htlb/mm/memory.c
> > +++ linux-2.6.5.htlb/mm/memory.c	2004-04-13 12:02:31.000000000 -0700
> > @@ -769,11 +769,6 @@ int get_user_pages(struct task_struct *t
> >  		if ((pages && vm_io) || !(flags & vma->vm_flags))
> >  			return i ? : -EFAULT;
> >
> > -		if (is_vm_hugetlb_page(vma)) {
> > -			i = follow_hugetlb_page(mm, vma, pages, vmas,
> > -						&start, &len, i);
> > -			continue;
> > -		}
> >  		spin_lock(&mm->page_table_lock);
> >  		do {
> >  			struct page *map = NULL;
>
> Ok, I notice that you've removed the follow_hugtlb_page() function
> (and from the arch specific stuff, as well).  As far as I can tell,
> this isn't actually related to demand-paging, in fact as far as I can
> tell this function is unnecessary

That was the reason I removed the function because it is no longer used
with demand paging.


> should already work for huge pages.  In particular the path in
> get_user_pages() which can call handle_mm_fault() (which won't work on
> hugepages without your patch) should never get triggered, since
> hugepages are all prefaulted.

> Does that sound right?  In other words, do you think the patch below,
> which just kills off follow_hugetlb_page() is safe, or have I missed
> something?
>
> Index: working-2.6/mm/memory.c
> ===================================================================
> --- working-2.6.orig/mm/memory.c	2004-04-13 11:42:42.000000000 +1000
> +++ working-2.6/mm/memory.c	2004-04-15 17:03:01.421905400 +1000
> @@ -766,16 +766,13 @@
> [snip]
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

This portion is incorrect, because it will trigger BUG_ON all the time
for faulting hugetlb page.

Yes, killing follow_hugetlb_page() is safe because follow_page() takes
care of hugetlb page.  See 2nd patch posted earlier in
hugetlb_demanding_generic.patch


