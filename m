Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbRBMBLO>; Mon, 12 Feb 2001 20:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRBMBLE>; Mon, 12 Feb 2001 20:11:04 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:63495 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129273AbRBMBKr>; Mon, 12 Feb 2001 20:10:47 -0500
Date: Mon, 12 Feb 2001 21:21:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: NIIBE Yutaka <gniibe@m17n.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] swapin flush cache bug
Message-ID: <Pine.LNX.4.21.0102122107550.29855-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Niibe Yutaka noted (and added an entry on the MM bugzilla system) that
cache flushing on do_swap_page() is buggy. Here: 

---
        struct page *page = lookup_swap_cache(entry);
        pte_t pte;

        if (!page) {
                lock_kernel();
                swapin_readahead(entry);
                page = read_swap_cache(entry);
                unlock_kernel();
                if (!page)
                        return -1;

                flush_page_to_ram(page);
                flush_icache_page(vma, page);
        }

        mm->rss++;
--

If lookup_swap_cache() finds a page in the swap cache, and that page was
in memory because of the swapin readahead, the cache is not flushed.

Here is a patch to fix the problem by always flushing the cache including
for pages in the swap cache:

--- linux.orig/mm/memory.c.orig       Thu Feb  8 10:52:20 2001
+++ linux/mm/memory.c    Thu Feb  8 10:54:07 2001
@@ -1033,12 +1033,12 @@
                unlock_kernel();
                if (!page)
                        return -1;
-
-               flush_page_to_ram(page);
-               flush_icache_page(vma, page);
        }
 
        mm->rss++;
+
+       flush_page_to_ram(page);
+       flush_icache_page(vma, page);
 
        pte = mk_pte(page, vma->vm_page_prot);




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
