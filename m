Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTLCRNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTLCRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:13:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:43992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265087AbTLCRNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:13:44 -0500
Date: Wed, 3 Dec 2003 09:13:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nathan Scott <nathans@sgi.com>
cc: Jens Axboe <axboe@suse.de>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
In-Reply-To: <20031203143229.A1918624@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0312030851180.5258@home.osdl.org>
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de>
 <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de>
 <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202082713.GN12211@suse.de>
 <20031202211002.C2009778@wobbly.melbourne.sgi.com>
 <20031203143229.A1918624@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Nathan Scott wrote:
>
> The XFS tests just tripped up a panic in raid5 in -test11 -- a kdb
> stacktrace follows.  Seems to be reproducible, but not always the
> same test that causes it.  And I haven't seen a double bio_put yet,
> this first problem keeps getting in the way I guess.

Ok, debugging this oops makes me _think_ that the problem comes from here:

	raid5.c: around line 1000:
			....
                            wbi = dev->written;
                            dev->written = NULL;
                            while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
                                    wbi2 = wbi->bi_next;
                                    if (--wbi->bi_phys_segments == 0) {
                                            md_write_end(conf->mddev);
                                            wbi->bi_next = return_bi;
                                            return_bi = wbi;
                                    }
                                    wbi = wbi2;
                            }
			....

where it appears that the "wbi->bi_sector" access takes a page fault,
probably due to PAGE_ALLOC debugging. It appears that somebody has already
finished (and thus free'd) that bio.

I dunno - I can't follow what that code does at all.

One problem is that the slab code - because it caches the slabs and shares
pages between different slab entryes - will not trigger the bugs that
DEBUG_PAGEALLOC would show very easily. So here's my ugly hack once more,
to see if that makes the bug show up more repeatably and quicker. Nathan?

			Linus


-+- slab-debug-on-steroids -+-

NOTE! For this patch to make sense, you have to enable the page allocator
debugging thing (CONFIG_DEBUG_PAGEALLOC), and you have to live with the
fact that it wastes a _lot_ of memory.

There's another problem with this patch: if the bug is actually in the
slab code itself, this will obviously not find it, since it disables that
code entirely.

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

