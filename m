Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUCWRnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCWRnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:43:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:26794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262721AbUCWRnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:43:03 -0500
Date: Tue, 23 Mar 2004 09:42:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: smurf@smurf.noris.de, linux-m68k@lists.linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: remove-page-list patch in -mm breaks m68k
Message-Id: <20040323094220.2a6e729e.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0403231322200.4928@waterleaf.sonytel.be>
References: <pan.2004.03.23.11.15.01.701720@smurf.noris.de>
	<Pine.GSO.4.58.0403231322200.4928@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, 23 Mar 2004, Matthias Urlichs wrote:
> > The patch mentioned in $SUBJECT, which is included in Andrew's mm tree,
> > does this to "struct page":
> >
> > diff -Nru a/include/linux/mm.h b/include/linux/mm.h
> > --- a/include/linux/mm.h        Tue Mar 23 11:29:11 2004
> > +++ b/include/linux/mm.h        Tue Mar 23 11:29:11 2004
> > @@ -177,7 +177,6 @@
> >         page_flags_t flags;             /* atomic flags, some possibly
> >                                            updated asynchronously */
> >         atomic_t count;                 /* Usage count, see below. */
> > -       struct list_head list;          /* ->mapping has some page lists. */
> >         struct address_space *mapping;  /* The inode (or ...) we belong to. */
> >         pgoff_t index;                  /* Our offset within mapping. */
> >         struct list_head lru;           /* Pageout list, eg. active_list;
> >
> > In principle, anything that makes "struct page" smaller is a good idea.
> > Unfortunately, this change breaks m68k, as arch/m68k/mm/memory.c has,
> > and actually uses,
> >
> > #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->list))
> >

ah-hah, thanks.

--- 25/arch/m68k/mm/memory.c~m68k-stop-using-page-list	2004-03-23 09:39:17.212548984 -0800
+++ 25-akpm/arch/m68k/mm/memory.c	2004-03-23 09:39:31.179425696 -0800
@@ -29,8 +29,8 @@
 typedef struct list_head ptable_desc;
 static LIST_HEAD(ptable_list);
 
-#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->list))
-#define PD_PAGE(ptable) (list_entry(ptable, struct page, list))
+#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
+#define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
 #define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
 
 #define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))

_

> | tux$ find arch -type f | xargs grep 'page.*->list'
> | arch/i386/mm/pageattr.c:                list_add(&kpte_page->list, &df_list);
> | arch/i386/mm/hugetlbpage.c:     list_add(&page->list,
> | arch/i386/mm/hugetlbpage.c:             list_del(&page->list);
> | arch/i386/mm/hugetlbpage.c:     INIT_LIST_HEAD(&page->list);
> | arch/m68k/mm/memory.c:#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->list))
> | arch/sparc64/mm/hugetlbpage.c:  list_add(&page->list,
> | arch/sparc64/mm/hugetlbpage.c:          list_del(&page->list);
> | arch/sparc64/mm/hugetlbpage.c:  INIT_LIST_HEAD(&page->list);
> | arch/ia64/mm/hugetlbpage.c:     list_add(&page->list,
> | arch/ia64/mm/hugetlbpage.c:             list_del(&page->list);
> | arch/ia64/mm/hugetlbpage.c:     INIT_LIST_HEAD(&page->list);
> | arch/ppc64/mm/hugetlbpage.c:    list_add(&page->list,
> | arch/ppc64/mm/hugetlbpage.c:            list_del(&page->list);
> | arch/ppc64/mm/hugetlbpage.c:    INIT_LIST_HEAD(&page->list);
> | arch/arm26/machine/small_page.c:                        list_del_init(&page->list);
> | arch/arm26/machine/small_page.c:                        list_add(&page->list, &order->queue);
> | arch/arm26/machine/small_page.c:                        list_add(&page->list, &order->queue);
> | arch/arm26/machine/small_page.c:        list_del_init(&page->list);
> | tux$
> 
> Are all of these (except for m68k) converted in the mm tree?

All except for arm26:

--- 25/arch/arm26/machine/small_page.c~arm-stop-using-page-list	2004-03-23 09:35:33.994483288 -0800
+++ 25-akpm/arch/arm26/machine/small_page.c	2004-03-23 09:37:08.227157744 -0800
@@ -95,7 +95,7 @@ again:
 		offset = ffz(USED_MAP(page));
 		SET_USED(page, offset);
 		if (USED_MAP(page) == order->all_used)
-			list_del_init(&page->list);
+			list_del_init(&page->lru);
 		spin_unlock_irqrestore(&small_page_lock, flags);
 
 		return (unsigned long) page_address(page) + (offset << order->shift);
@@ -110,7 +110,7 @@ need_new_page:
 				goto no_page;
 			SetPageReserved(page);
 			USED_MAP(page) = 0;
-			list_add(&page->list, &order->queue);
+			list_add(&page->lru, &order->queue);
 			goto again;
 		}
 
@@ -151,7 +151,7 @@ static void __free_small_page(unsigned l
 		spin_lock_irqsave(&small_page_lock, flags);
 
 		if (USED_MAP(page) == order->all_used)
-			list_add(&page->list, &order->queue);
+			list_add(&page->lru, &order->queue);
 
 		if (!TEST_AND_CLEAR_USED(page, spage))
 			goto already_free;
@@ -167,7 +167,7 @@ free_page:
 	/*
 	 * unlink the page from the small page queue and free it
 	 */
-	list_del_init(&page->list);
+	list_del_init(&page->lru);
 	spin_unlock_irqrestore(&small_page_lock, flags);
 	ClearPageReserved(page);
 	__free_page(page);

_

