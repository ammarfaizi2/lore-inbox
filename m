Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRCWTlv>; Fri, 23 Mar 2001 14:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRCWTlo>; Fri, 23 Mar 2001 14:41:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8971 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131378AbRCWTl2>; Fri, 23 Mar 2001 14:41:28 -0500
Date: Fri, 23 Mar 2001 11:40:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Patch(?): linux-2.4.3-pre6/mm/vmalloc.c could return with
 init_mm.page_table_lock held
In-Reply-To: <20010323023149.A250@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.31.0103231130390.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Adam J. Richter wrote:
>
> 	In linux-2.4.3-pre6, a call to vmalloc can result in a call to
> pte_alloc without the appropriate page_table_lock being held.  Here is
> the call graph, from my post of about half an hour ago:

Good find.

HOWEVER, the patch is not right.

You cannot get the kernel lock from within a spinlock, so you should
_replace_ the kernel lock with the spinlock (which is definitely the
correct thing to do anyway - the kernel lock is there exactly because we
didn't have any other good synchronization primitive, and that's _exactly_
what the spinlock in question is all about).

Also, you have to drop the spinlock over the actual page allocation inside
alloc_area_pte(). So I'd suggest something along the lines of the attached
(completely untested) patch.

		Linus

-----
--- pre6/linux/mm/vmalloc.c	Tue Mar 20 23:13:03 2001
+++ linux/mm/vmalloc.c	Fri Mar 23 11:38:24 2001
@@ -102,9 +102,11 @@
 		end = PMD_SIZE;
 	do {
 		struct page * page;
+		spin_unlock(&init_mm.page_table_lock);
+		page = alloc_page(gfp_mask);
+		spin_lock(&init_mm.page_table_lock);
 		if (!pte_none(*pte))
 			printk(KERN_ERR "alloc_area_pte: page already exists\n");
-		page = alloc_page(gfp_mask);
 		if (!page)
 			return -ENOMEM;
 		set_pte(pte, mk_pte(page, prot));
@@ -143,7 +145,7 @@

 	dir = pgd_offset_k(address);
 	flush_cache_all();
-	lock_kernel();
+	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;

@@ -161,7 +163,7 @@

 		ret = 0;
 	} while (address && (address < end));
-	unlock_kernel();
+	spin_unlock(&init_mm.page_table_lock)
 	flush_tlb_all();
 	return ret;
 }

