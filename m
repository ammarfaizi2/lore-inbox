Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWEHTge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWEHTge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWEHTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:36:34 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23169 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750708AbWEHTgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:36:33 -0400
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Bj=F6rn?= Steinbrink" <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, Christoph Lameter <clameter@sgi.com>,
       manfred@colorfullife.com, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>
	 <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
	 <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
	 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>
	 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
	 <1147104412.22096.8.camel@localhost>
	 <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org>
Date: Mon, 08 May 2006 22:36:30 +0300
Message-Id: <1147116991.11282.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 09:28 -0700, Linus Torvalds wrote:
> So from a performance standpoint, maybe my previous trivial patch is the 
> right thing to do, along with an even _stronger_ test for 
> kmem_cache_free(), where we could do
> 
> 	BUG_ON(virt_to_cache(objp) != cachep);
> 
> which you can then remove from the slab debug case.
> 
> So for a lot of the normal paths, you'd basically have no extra cost (two 
> instructions, no data cache pressure), but for kmem_cache_free() we'd have 
> a slight overhead (but a lot lower than SLAB_DEBUG, and at least for NUMA 
> it's reading a cacheline that we'd be using regardless.
> 
> I think it sounds like it's worth it, but I'm not going to really push it.

Sounds good to me. Andrew?

				Pekka

[PATCH] slab: verify pointers before free

From: Pekka Enberg <penberg@cs.helsinki.fi>

Passing an invalid pointer to kfree() and kmem_cache_free() is likely
to cause bad memory corruption or even take down the whole system
because the bad pointer is likely reused immediately due to the
per-CPU caches.  Until now, we don't do any verification for this if
CONFIG_DEBUG_SLAB is disabled.

As suggested by Linus, add PageSlab check to page_to_cache() and
page_to_slab() to verify pointers passed to kfree().  Also, move the
stronger check from cache_free_debugcheck() to kmem_cache_free() to
ensure the passed pointer actually belongs to the cache we're about to
free the object.

For page_to_cache() and page_to_slab(), the assertions should have
virtually no extra cost (two instructions, no data cache pressure) and
for kmem_cache_free() the overhead should be minimal.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 mm/slab.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

8e4b800f3fb45bbffcc7b365115a63b2a4c911cb
diff --git a/mm/slab.c b/mm/slab.c
index c32af7e..bc9805a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -597,6 +597,7 @@ static inline struct kmem_cache *page_ge
 {
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
+	BUG_ON(!PageSlab(page));
 	return (struct kmem_cache *)page->lru.next;
 }
 
@@ -609,6 +610,7 @@ static inline struct slab *page_get_slab
 {
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
+	BUG_ON(!PageSlab(page));
 	return (struct slab *)page->lru.prev;
 }
 
@@ -2597,15 +2599,6 @@ static void *cache_free_debugcheck(struc
 	kfree_debugcheck(objp);
 	page = virt_to_page(objp);
 
-	if (page_get_cache(page) != cachep) {
-		printk(KERN_ERR "mismatch in kmem_cache_free: expected "
-				"cache %p, got %p\n",
-		       page_get_cache(page), cachep);
-		printk(KERN_ERR "%p is %s.\n", cachep, cachep->name);
-		printk(KERN_ERR "%p is %s.\n", page_get_cache(page),
-		       page_get_cache(page)->name);
-		WARN_ON(1);
-	}
 	slabp = page_get_slab(page);
 
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -3361,6 +3354,8 @@ void kmem_cache_free(struct kmem_cache *
 {
 	unsigned long flags;
 
+	BUG_ON(virt_to_cache(objp) != cachep);
+
 	local_irq_save(flags);
 	__cache_free(cachep, objp);
 	local_irq_restore(flags);
-- 
1.3.0




