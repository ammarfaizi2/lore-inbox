Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUKEFQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUKEFQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbUKEFQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:16:43 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:58637 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S262605AbUKEFQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:16:40 -0500
Message-ID: <418B0C82.6060107@snapgear.com>
Date: Fri, 05 Nov 2004 15:15:46 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] bug in order>0 page allocations with !CONFIG_MMU
References: <19972.1099578526@redhat.com>
In-Reply-To: <19972.1099578526@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Howells wrote:
> I've found that this:
> 
> 	[mm/page_alloc.c]
> 	static inline void set_page_refs(struct page *page, int order)
> 	{
> 	#ifdef CONFIG_MMU
> 		set_page_count(page, 1);
> 	#else
> 		int i;
> 
> 		/*
> 		 * We need to reference all the pages for this order, otherwise if
> 		 * anyone accesses one of the pages with (get/put) it will be freed.
> 		 */
> 		for (i = 0; i < (1 << order); i++)
> 			set_page_count(page+i, 1);
> 	#endif /* CONFIG_MMU */
> 	}
> 
> Causes problems if !CONFIG_MMU because __free_pages_ok()/free_pages_check()
> reports a bad page on the second page when it comes time to free it:
> 
> 	Bad page state at __free_pages_ok (in process 'events/0', page c08132e0)
> 	flags:0x20000000 mapping:00000000 mapcount:0 count:1

That itself can be fixed by not checking the page_counts in
__free_pages_ok():

@@ -219,7 +219,9 @@
  {
         if (    page_mapped(page) ||
                 page->mapping != NULL ||
+#ifdef CONFIG_MMU
                 page_count(page) != 0 ||
+#endif
                 (page->flags & (
                         1 << PG_lru     |
                         1 << PG_private |



> Why is doing this necessary at all? No one should be touching the individual
> pages of a block allocation. The kernel should defend itself against
> userspace trying to munmap part of a multipage mmap.

I don't recall right now why we had to do this originally.
It was absolutely neccessary once, but I don't think we need
this anymore. At least it runs fine on m68knommu targets now
without this.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
