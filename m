Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRIRMi2>; Tue, 18 Sep 2001 08:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270314AbRIRMiT>; Tue, 18 Sep 2001 08:38:19 -0400
Received: from ns.suse.de ([213.95.15.193]:7175 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270257AbRIRMiG>;
	Tue, 18 Sep 2001 08:38:06 -0400
Date: Tue, 18 Sep 2001 14:38:27 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
Message-ID: <20010918143827.A16003@gruyere.muc.suse.de>
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel> <E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel> <9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel> <oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de> <jeelp4rbtf.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <jeelp4rbtf.fsf@sykes.suse.de>; from schwab@suse.de on Tue, Sep 18, 2001 at 01:13:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 01:13:48PM +0200, Andreas Schwab wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> |> +#define likely(x)  __builtin_expect((x), !0) 
> 
> IMHO, this should better be written as
> 
> #define likely(x) __builtin_expect(!!(x), 1)
> 
> because x is not required to be pure boolean, so any nonzero value of x is
> as likely as 1.

Good point. I somehow assumed that __builtin_expect would just signify
a boolean, but if I read gcc source correctly this was wrong.

Here is an updated patch.

-Andi


--- mm/slab.c-LIKELY	Tue Sep 18 03:37:30 2001
+++ mm/slab.c	Tue Sep 18 11:26:43 2001
@@ -1230,7 +1230,7 @@
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
 	slabp->free=slab_bufctl(slabp)[slabp->free];
 
-	if (__builtin_expect(slabp->free == BUFCTL_END, 0)) {
+	if (unlikely(slabp->free == BUFCTL_END)) {
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
 	}
@@ -1264,11 +1264,11 @@
 								\
 	slabs_partial = &(cachep)->slabs_partial;		\
 	entry = slabs_partial->next;				\
-	if (__builtin_expect(entry == slabs_partial, 0)) {	\
+	if (unlikely(entry == slabs_partial)) {	\
 		struct list_head * slabs_free;			\
 		slabs_free = &(cachep)->slabs_free;		\
 		entry = slabs_free->next;			\
-		if (__builtin_expect(entry == slabs_free, 0))	\
+		if (unlikely(entry == slabs_free))	\
 			goto alloc_new_slab;			\
 		list_del(entry);				\
 		list_add(entry, slabs_partial);			\
@@ -1291,11 +1291,11 @@
 		/* Get slab alloc is to come from. */
 		slabs_partial = &(cachep)->slabs_partial;
 		entry = slabs_partial->next;
-		if (__builtin_expect(entry == slabs_partial, 0)) {
+		if (unlikely(entry == slabs_partial)) {
 			struct list_head * slabs_free;
 			slabs_free = &(cachep)->slabs_free;
 			entry = slabs_free->next;
-			if (__builtin_expect(entry == slabs_free, 0))
+			if (unlikely(entry == slabs_free))
 				break;
 			list_del(entry);
 			list_add(entry, slabs_partial);
@@ -1436,11 +1436,11 @@
 	/* fixup slab chains */
 	{
 		int inuse = slabp->inuse;
-		if (__builtin_expect(!--slabp->inuse, 0)) {
+		if (unlikely(!--slabp->inuse)) {
 			/* Was partial or full, now empty. */
 			list_del(&slabp->list);
 			list_add(&slabp->list, &cachep->slabs_free);
-		} else if (__builtin_expect(inuse == cachep->num, 0)) {
+		} else if (unlikely(inuse == cachep->num)) {
 			/* Was full. */
 			list_del(&slabp->list);
 			list_add(&slabp->list, &cachep->slabs_partial);
--- mm/vmscan.c-LIKELY	Tue Sep 18 03:37:30 2001
+++ mm/vmscan.c	Tue Sep 18 11:22:09 2001
@@ -335,7 +335,7 @@
 	while (__max_scan && (entry = lru->prev) != lru) {
 		struct page * page;
 
-		if (__builtin_expect(current->need_resched, 0)) {
+		if (unlikely(current->need_resched)) {
 			spin_unlock(&pagemap_lru_lock);
 			schedule();
 			spin_lock(&pagemap_lru_lock);
@@ -344,7 +344,7 @@
 
 		page = list_entry(entry, struct page, lru);
 
-		if (__builtin_expect(!PageInactive(page) && !PageActive(page), 0))
+		if (unlikely(!PageInactive(page) && !PageActive(page)))
 			BUG();
 
 		if (PageTestandClearReferenced(page)) {
@@ -363,7 +363,7 @@
 		list_del(entry);
 		list_add_tail(entry, &inactive_local_lru);
 
-		if (__builtin_expect(!memclass(page->zone, classzone), 0))
+		if (unlikely(!memclass(page->zone, classzone)))
 			continue;
 
 		__max_scan--;
@@ -380,7 +380,7 @@
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
 		 */
-		if (__builtin_expect(TryLockPage(page), 0))
+		if (unlikely(TryLockPage(page)))
 			continue;
 
 		if (PageDirty(page) && is_page_cache_freeable(page)) {
@@ -456,10 +456,10 @@
 			}
 		}
 
-		if (__builtin_expect(!page->mapping, 0))
+		if (unlikely(!page->mapping))
 			BUG();
 
-		if (__builtin_expect(!spin_trylock(&pagecache_lock), 0)) {
+		if (unlikely(!spin_trylock(&pagecache_lock))) {
 			/* we hold the page lock so the page cannot go away from under us */
 			spin_unlock(&pagemap_lru_lock);
 
@@ -479,7 +479,7 @@
 		}
 
 		/* point of no return */
-		if (__builtin_expect(!PageSwapCache(page), 1))
+		if (likely(!PageSwapCache(page)))
 			__remove_inode_page(page);
 		else
 			__delete_from_swap_cache(page);
--- mm/page_alloc.c-LIKELY	Tue Sep 18 03:37:30 2001
+++ mm/page_alloc.c	Tue Sep 18 11:26:44 2001
@@ -372,7 +372,7 @@
 		return page;
 
 	zone = zonelist->zones;
-	if (__builtin_expect(freed, 1)) {
+	if (likely(freed)) {
 		for (;;) {
 			zone_t *z = *(zone++);
 			if (!z)
--- include/linux/kernel.h-LIKELY	Tue Sep 18 11:12:20 2001
+++ include/linux/kernel.h	Tue Sep 18 14:35:17 2001
@@ -171,4 +171,14 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
+
+/* This loses on a few early 2.96 snapshots, but hopefully nobody uses them anymore. */ 
+#if __GNUC__ > 2 || (__GNUC__ == 2 && _GNUC_MINOR__ == 96)
+#define likely(x)  __builtin_expect(!!(x), 1) 
+#define unlikely(x)  __builtin_expect((x), 0) 
+#else
+#define likely(x) (x)
+#define unlikely(x) (x)
+#endif
+
 #endif
