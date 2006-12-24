Return-Path: <linux-kernel-owner+w=401wt.eu-S1752532AbWLXTfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWLXTfr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 14:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWLXTfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 14:35:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52827 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbWLXTfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 14:35:46 -0500
Date: Sun, 24 Dec 2006 11:35:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <97a0a9ac0612241127u1051f7eay70065b03f27ae668@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612241131570.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <1166793952.32117.29.camel@twins>  <20061222192027.GJ4229@deprecation.cyrius.com>
  <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com> 
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>  <20061224005752.937493c8.akpm@osdl.org>
  <1166962478.7442.0.camel@localhost>  <20061224043102.d152e5b4.akpm@osdl.org>
  <1166978752.7022.1.camel@localhost>  <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
 <97a0a9ac0612241127u1051f7eay70065b03f27ae668@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2006, Gordon Farquharson wrote:
> 
> The apt cache files (/var/cache/apt/*.bin) still get corrupted with
> this patch and 2.6.19.

Yeah, if my guess about do_no_page() is right, _none_ of the previous 
patches should have ANY effect what-so-ever. In fact, I'd say that even 
the "ext3 works in writeback mode" thing that Andrei reports is probably a 
total fluke brought on by timing changes rather than anything else.

So please try the latest patch instead (on top of anything that shows 
corruption reliably - the patch should be _totally_ independent of all the 
other issues, and I think it will apply cleanly on top of 2.6.18.3 and 
2.6.19 too, so anything that shows corruption is a fine target - but try 
to choose something that has been the "best" at corrupting things for you, 
to make the testing as good as possible).

Patch included here again (although I think you were cc'd on my previous 
email too, so you should already have it, and our emails just crossed)

And if this doesn't fix it, I don't know what will..

		Linus

---
diff --git a/mm/memory.c b/mm/memory.c
index 563792f..cf429c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2247,21 +2249,23 @@ retry:
 	if (pte_none(*page_table)) {
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		if (write_access)
-			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
 			lru_cache_add_active(new_page);
 			page_add_new_anon_rmap(new_page, vma, address);
+			if (write_access)
+				entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		} else {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
+			entry = pte_wrprotect(entry);
 			if (write_access) {
 				dirty_page = new_page;
 				get_page(dirty_page);
+				entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 			}
 		}
+		set_pte_at(mm, address, page_table, entry);
 	} else {
 		/* One of our sibling threads was faster, back out. */
 		page_cache_release(new_page);
