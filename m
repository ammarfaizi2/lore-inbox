Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131947AbQLHW7a>; Fri, 8 Dec 2000 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131814AbQLHW7U>; Fri, 8 Dec 2000 17:59:20 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:3588 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131947AbQLHW7B>; Fri, 8 Dec 2000 17:59:01 -0500
Date: Fri, 8 Dec 2000 22:24:55 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: Mark Vojkovich <mvojkovich@valinux.com>, Andi Kleen <ak@suse.de>,
        Rainer Mager <rmager@vgkk.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <20001208161645.A6075@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.30.0012082224110.1210-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Jeff V. Merkey wrote:

> I have not seen it on UP systems either.  I only see it on SMP systems.
> After trying very hard last night, I was able to get my 4 x PPro system to
> do it with 2.4.0-12.  It seems related to loading in some way.  If you
> have more than two processors, the loading is less since there's more
> processors, and for whatever reason, it makes it harder to produce
> whatever race condition is causing it.  I can get it to happen
> pretty easily on a 2 x PII system.

Can you reproduce it with bcrl's patch below:

Index: mm/memory.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/mm/memory.c,v
retrieving revision 1.2.2.40
diff -u -r1.2.2.40 memory.c
--- mm/memory.c	2000/12/05 13:33:39	1.2.2.40
+++ mm/memory.c	2000/12/08 22:24:09
@@ -860,6 +860,7 @@
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
+	set_pte(page_table, pte);
 	spin_unlock(&mm->page_table_lock);
 	new_page = page_cache_alloc();
 	if (!new_page)
@@ -870,6 +871,12 @@
 	 * Re-check the pte - we dropped the lock
 	 */
 	if (pte_same(*page_table, pte)) {
+		/* We are changing the pte, so get rid of the old
+		 * one to avoid races with the hardware, this really
+		 * only affects the accessed bit here.
+		 */
+		pte = ptep_get_and_clear(page_table);
+
 		if (PageReserved(old_page))
 			++mm->rss;
 		break_cow(vma, old_page, new_page, address, page_table);
@@ -1216,12 +1223,14 @@
 		return do_swap_page(mm, vma, address, pte,
pte_to_swp_entry(entry), write_access);
 	}

+	entry = ptep_get_and_clear(pte);
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, entry);

 		entry = pte_mkdirty(entry);
 	}
+
 	entry = pte_mkyoung(entry);
 	establish_pte(vma, address, pte, entry);
 	spin_unlock(&mm->page_table_lock);


-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
