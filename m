Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTLAXq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 18:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLAXq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 18:46:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:13721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264257AbTLAXqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 18:46:22 -0500
Date: Mon, 1 Dec 2003 15:46:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1069889123.20138.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.58.0312011537470.2733@home.osdl.org>
References: <mnet1.1069889123.20138.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Nov 2003 pinotj@club-internet.fr wrote:
>
> Here is the result of test of 2.6.0-test10 with the printk patch in
> slab.c and this new patch for fork.c from Linus :

The fork.c change can really only affect threaded programs using the new
threading, and even then is likely to hit only in very unlikely
circumstances. Certainly not a kernel compile.

I'm wondering if the slab debugging code is just broken somehow. If you
have lots of memory, it should even work for you.

NOTE! For this patch to make sense, you have to enable the page allocator
debugging thing (CONFIG_DEBUG_PAGEALLOC), and you have to live with the
fact that it wastes a _lot_ of memory.

There's another problem with this patch: if the bug is actually in the
slab code itself, this will obviously not find it, since it disables that
code entirely.

		Linus

----
===== mm/slab.c 1.110 vs edited =====
--- 1.110/mm/slab.c	Tue Oct 21 22:10:10 2003
+++ edited/mm/slab.c	Mon Dec  1 15:29:06 2003
@@ -1906,6 +1906,21 @@

 static inline void * __cache_alloc (kmem_cache_t *cachep, int flags)
 {
+#if 1
+	void *ptr = (void*)__get_free_pages(flags, cachep->gfporder);
+	if (ptr) {
+		struct page *page = virt_to_page(ptr);
+		SET_PAGE_CACHE(page, cachep);
+		SET_PAGE_SLAB(page, 0x01020304);
+		if (cachep->ctor) {
+			unsigned long ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+			if (!(flags & __GFP_WAIT))
+				ctor_flags |= SLAB_CTOR_ATOMIC;
+			cachep->ctor(ptr, cachep, ctor_flags);
+		}
+	}
+	return ptr;
+#else
 	unsigned long save_flags;
 	void* objp;
 	struct array_cache *ac;
@@ -1925,6 +1940,7 @@
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
 	return objp;
+#endif
 }

 /*
@@ -2042,6 +2058,15 @@
  */
 static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
+#if 1
+	{
+		struct page *page = virt_to_page(objp);
+		int order = cachep->gfporder;
+		if (cachep->dtor)
+			cachep->dtor(objp, cachep, 0);
+		__free_pages(page, order);
+	}
+#else
 	struct array_cache *ac = ac_data(cachep);

 	check_irq_off();
@@ -2056,6 +2081,7 @@
 		cache_flusharray(cachep, ac);
 		ac_entry(ac)[ac->avail++] = objp;
 	}
+#endif
 }

 /**
