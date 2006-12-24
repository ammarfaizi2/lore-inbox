Return-Path: <linux-kernel-owner+w=401wt.eu-S1752451AbWLXShh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWLXShh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 13:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbWLXShh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 13:37:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50542 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbWLXShg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 13:37:36 -0500
Date: Sun, 24 Dec 2006 10:37:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, 24 Dec 2006, Linus Torvalds wrote:
>
> How about this particularly stupid diff? (please test with something that 
> _would_ cause corruption normally).

Actually, here's an even more stupid diff, which actually to some degree 
seems to capture the real problem better.

Peter, tell me I'm crazy, but with the new rules, the following condition 
is a bug:

 - shared mapping
 - writable
 - not already marked dirty in the PTE

because that combination means that the hardware can mark the PTE dirty 
without us even realizing (and thus not marking the "struct page *" 
dirty).

(The above is actually a valid situation for IO mappings, but not for 
"real" mappings. And IO mappings should never take page faults, I think).

So, with that in mind, I wrote this stupid patch (for 32-bit x86, since I 
used my Mac Mini for testing ratehr than my main machine - but the x86-64 
version should be pretty much identcal)..

And you know what, Peter? It triggers for me. I get

	WARNING at mm/memory.c:2274 do_no_page()
	 [<c0103d4a>] show_trace_log_lvl+0x1a/0x2f
	 [<c010436c>] show_trace+0x12/0x14
	 [<c01043f0>] dump_stack+0x16/0x18
	 [<c0159790>] __handle_mm_fault+0x38d/0x919
	 [<c011c8c4>] do_page_fault+0x1ff/0x507
	 [<c03fabcc>] error_code+0x7c/0x84

which seems to say that do_no_page() can be used to insert shared and 
non-dirty, but still writable, pages.

But maybe my patch is just bogus, and I didn't think it through.

Peter, I realize it's Christmas Eve, but let's face it, Santa appreciates 
good boys and girls, and we all want tons of loot. So please be good, and 
waste some time looking at this and tell me why I'm either wrong, or 
there's a real smoking gun here.. ;)

		Linus

---
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
index e6a4723..1389bb7 100644
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -494,7 +494,13 @@ do {									\
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
  */
-#define update_mmu_cache(vma,address,pte) do { } while (0)
+#define bad_shared_pte(pte) (pte_write(pte) && !pte_dirty(pte))
+#define update_mmu_cache(vma,address,pte) do {		\
+	static int __cnt;				\
+	WARN_ON(((vma)->vm_flags & VM_SHARED)		\
+		 && bad_shared_pte(pte)			\
+		 && ++__cnt < 5);			\
+} while (0)
 #endif /* !__ASSEMBLY__ */
 
 #ifdef CONFIG_FLATMEM
