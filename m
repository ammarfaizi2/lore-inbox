Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTKXXpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTKXXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:45:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:55749 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbTKXXp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:45:27 -0500
Date: Mon, 24 Nov 2003 15:45:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <Pine.LNX.4.58.0311241452550.15101@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0311241540550.1581@home.osdl.org>
References: <20031124224514.56242.qmail@web40908.mail.yahoo.com>
 <Pine.LNX.4.58.0311241452550.15101@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Nov 2003, Linus Torvalds wrote:
>
> The PAGEFREE debug option works well for page allocations, but the slab
> cache is not very amenable to it. For slab debugging, it would be
> wonderful if somebody made a _truly_ debugging slab allocator that didn't
> use the slab cache at all, but used the page allocator (and screw the fact
> that you use too much memory ;) instead.

Ok, this is quite possibly the ugliest patch I've ever made, but it might
catch some of the "use-after-free" issues with slab.

IT WILL NOT WORK IN GENERAL! In particular, you'll need to have tons of
memory free for this patch to work, since it basically scrapes off all the
regular slab code, and replaces it with some really nasty crud. I was
lazy. Whatever. It means that the slab memory balancing won't work etc,
but maybe somebody else can integrate my quick hack better.

It boots for me, but I won't say anything beyond that (oh, do NOT enable
slab debugging if you want to test this out - I pretty much guarantee it
won't work with this hack. You should enable DEBUG_PAGEALLOC instead,
and see if you get anything interesting out of that..).

		Linus

-----
--- 1.110/mm/slab.c	Tue Oct 21 22:10:10 2003
+++ edited/mm/slab.c	Mon Nov 24 15:34:23 2003
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
@@ -2043,10 +2059,20 @@
 static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
 	struct array_cache *ac = ac_data(cachep);
+

 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));

+#if 1
+	{
+		struct page *page = virt_to_page(objp);
+		int order = cachep->gfporder;
+		if (cachep->dtor)
+			cachep->dtor(objp, cachep, 0);
+		__free_pages(page, order);
+	}
+#else
 	if (likely(ac->avail < ac->limit)) {
 		STATS_INC_FREEHIT(cachep);
 		ac_entry(ac)[ac->avail++] = objp;
@@ -2056,6 +2082,7 @@
 		cache_flusharray(cachep, ac);
 		ac_entry(ac)[ac->avail++] = objp;
 	}
+#endif
 }

 /**
