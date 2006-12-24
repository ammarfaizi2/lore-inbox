Return-Path: <linux-kernel-owner+w=401wt.eu-S1752581AbWLXTS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbWLXTS4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLXTS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 14:18:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52068 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbWLXTSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 14:18:55 -0500
Date: Sun, 24 Dec 2006 11:18:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>
cc: Andrew Morton <akpm@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> 
 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> 
 <20061222100004.GC10273@deprecation.cyrius.com>  <20061222021714.6a83fcac.akpm@osdl.org>
 <1166790275.6983.4.camel@localhost>  <20061222123249.GG13727@deprecation.cyrius.com>
  <20061222125920.GA16763@deprecation.cyrius.com>  <1166793952.32117.29.camel@twins>
  <20061222192027.GJ4229@deprecation.cyrius.com> 
 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com> 
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>  <20061224005752.937493c8.akpm@osdl.org>
 <1166962478.7442.0.camel@localhost>  <20061224043102.d152e5b4.akpm@osdl.org>
 <1166978752.7022.1.camel@localhost> <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2006, Linus Torvalds wrote:
> 
> Peter, tell me I'm crazy, but with the new rules, the following condition 
> is a bug:
> 
>  - shared mapping
>  - writable
>  - not already marked dirty in the PTE

Ok, so how about this diff.

I'm actually feeling good about this one. It really looks like 
"do_no_page()" was simply buggy, and that this explains everything.

Please please please test. Throw all the other patches away (with the 
possible exception of the "update_mmu_cache()" sanity checker, which is 
still interesting in case some _other_ place does this too).

Don't do the "wait_on_page_writeback()" thing, because it changes timings 
and might hide thngs for the wrong reasons.  Just apply this on top of a 
known failing kernel, and test.

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
