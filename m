Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUCWM2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUCWM2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:28:51 -0500
Received: from witte.sonytel.be ([80.88.33.193]:47097 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262525AbUCWM2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:28:42 -0500
Date: Tue, 23 Mar 2004 13:28:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: remove-page-list patch in -mm breaks m68k
In-Reply-To: <pan.2004.03.23.11.15.01.701720@smurf.noris.de>
Message-ID: <Pine.GSO.4.58.0403231322200.4928@waterleaf.sonytel.be>
References: <pan.2004.03.23.11.15.01.701720@smurf.noris.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Matthias Urlichs wrote:
> The patch mentioned in $SUBJECT, which is included in Andrew's mm tree,
> does this to "struct page":
>
> diff -Nru a/include/linux/mm.h b/include/linux/mm.h
> --- a/include/linux/mm.h        Tue Mar 23 11:29:11 2004
> +++ b/include/linux/mm.h        Tue Mar 23 11:29:11 2004
> @@ -177,7 +177,6 @@
>         page_flags_t flags;             /* atomic flags, some possibly
>                                            updated asynchronously */
>         atomic_t count;                 /* Usage count, see below. */
> -       struct list_head list;          /* ->mapping has some page lists. */
>         struct address_space *mapping;  /* The inode (or ...) we belong to. */
>         pgoff_t index;                  /* Our offset within mapping. */
>         struct list_head lru;           /* Pageout list, eg. active_list;
>
> In principle, anything that makes "struct page" smaller is a good idea.
> Unfortunately, this change breaks m68k, as arch/m68k/mm/memory.c has,
> and actually uses,
>
> #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->list))
>
> Thus, apparently this change
>
> /* ++andreas: {get,free}_pointer_table rewritten to use unused fields from
>    struct page instead of separately kmalloced struct.  Stolen from
>    arch/sparc/mm/srmmu.c ... */

Apparently arch/sparc/mm/srmmu.c stopped using this a long time ago...

> needs to be reverted. It seems that a binary search through old kernel
> archives is in order.

I don't have a copy of the latest mm tree at hand, but in plain 2.6.5-rc2, we
have several users:

| tux$ find arch -type f | xargs grep 'page.*->list'
| arch/i386/mm/pageattr.c:                list_add(&kpte_page->list, &df_list);
| arch/i386/mm/hugetlbpage.c:     list_add(&page->list,
| arch/i386/mm/hugetlbpage.c:             list_del(&page->list);
| arch/i386/mm/hugetlbpage.c:     INIT_LIST_HEAD(&page->list);
| arch/m68k/mm/memory.c:#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->list))
| arch/sparc64/mm/hugetlbpage.c:  list_add(&page->list,
| arch/sparc64/mm/hugetlbpage.c:          list_del(&page->list);
| arch/sparc64/mm/hugetlbpage.c:  INIT_LIST_HEAD(&page->list);
| arch/ia64/mm/hugetlbpage.c:     list_add(&page->list,
| arch/ia64/mm/hugetlbpage.c:             list_del(&page->list);
| arch/ia64/mm/hugetlbpage.c:     INIT_LIST_HEAD(&page->list);
| arch/ppc64/mm/hugetlbpage.c:    list_add(&page->list,
| arch/ppc64/mm/hugetlbpage.c:            list_del(&page->list);
| arch/ppc64/mm/hugetlbpage.c:    INIT_LIST_HEAD(&page->list);
| arch/arm26/machine/small_page.c:                        list_del_init(&page->list);
| arch/arm26/machine/small_page.c:                        list_add(&page->list, &order->queue);
| arch/arm26/machine/small_page.c:                        list_add(&page->list, &order->queue);
| arch/arm26/machine/small_page.c:        list_del_init(&page->list);
| tux$

Are all of these (except for m68k) converted in the mm tree?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
