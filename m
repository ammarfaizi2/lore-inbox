Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291281AbSBGUdY>; Thu, 7 Feb 2002 15:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291280AbSBGUdG>; Thu, 7 Feb 2002 15:33:06 -0500
Received: from colorfullife.com ([216.156.138.34]:56335 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S291284AbSBGUcY>;
	Thu, 7 Feb 2002 15:32:24 -0500
Message-ID: <3C62E438.787393B9@colorfullife.com>
Date: Thu, 07 Feb 2002 21:31:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C618863.DA7AC3B9@zip.com.au> <Pine.LNX.4.21.0202061958100.2009-100000@localhost.localdomain> <3C619C0F.367A6E67@zip.com.au>
Content-Type: multipart/mixed;
 boundary="------------0203480051190256D75CEE62"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0203480051190256D75CEE62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
> Al suggests a `honey pot' kernel thread which ticks over,
> allocating, validating and releasing memory, waiting for
> it to get stomped on.   If it gets corrupted we can dump
> lots of memory and a task list, I guess.
> 	
> We could also re-enable slab debugging.
>
I've attached my updated memory poisoning patch. I'm running it right
now, but I didn't perform any major testing with this version.

I've added poisoning to _alloc_pages.

I did send the previous version to a user with a spurious oops, and it
was a complete failure - oops disappreared after the patch was applied
:-(

--
	Manfred
--------------0203480051190256D75CEE62
Content-Type: text/plain; charset=us-ascii;
 name="patch-poison"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poison"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 18
//  EXTRAVERSION = -pre8
--- 2.4/drivers/block/ll_rw_blk.c	Tue Feb  5 18:48:20 2002
+++ build-2.4/drivers/block/ll_rw_blk.c	Thu Feb  7 19:37:35 2002
@@ -348,6 +348,8 @@
 		}
 		memset(rq, 0, sizeof(struct request));
 		rq->rq_status = RQ_INACTIVE;
+		poison_obj(&rq->elevator_sequence, sizeof(struct request)
+				-offsetof(struct request,elevator_sequence));
 		list_add(&rq->queue, &q->rq[i&1].free);
 		q->rq[i&1].count++;
 	}
@@ -428,8 +430,12 @@
 	if (!list_empty(&rl->free)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
+		/* FIXME: clear or not clear? */
+		check_poison(&rq->elevator_sequence, sizeof(struct request)
+				- offsetof(struct request,elevator_sequence));
 		rl->count--;
 		rq->rq_status = RQ_ACTIVE;
+		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
 	}
@@ -560,6 +566,8 @@
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
+		poison_obj(&req->elevator_sequence, sizeof(struct request)
+				-offsetof(struct request,elevator_sequence));
 		if (++q->rq[rw].count >= batch_requests && waitqueue_active(&q->wait_for_request))
 			wake_up(&q->wait_for_request);
 	}
--- 2.4/fs/file_table.c	Sun Sep 30 16:25:45 2001
+++ build-2.4/fs/file_table.c	Thu Feb  7 19:37:35 2002
@@ -39,6 +39,8 @@
 	used_one:
 		f = list_entry(free_list.next, struct file, f_list);
 		list_del(&f->f_list);
+		check_poison (&f->f_dentry, sizeof(struct file) -
+				offsetof(struct file, f_dentry));
 		files_stat.nr_free_files--;
 	new_one:
 		memset(f, 0, sizeof(*f));
@@ -118,6 +120,8 @@
 		file->f_dentry = NULL;
 		file->f_vfsmnt = NULL;
 		list_del(&file->f_list);
+		poison_obj(&file->f_dentry, sizeof(struct file) -
+				offsetof(struct file, f_dentry));
 		list_add(&file->f_list, &free_list);
 		files_stat.nr_free_files++;
 		file_list_unlock();
@@ -147,6 +151,8 @@
 		file_list_lock();
 		list_del(&file->f_list);
 		list_add(&file->f_list, &free_list);
+		poison_obj(&file->f_dentry, sizeof(struct file) -
+				offsetof(struct file, f_dentry));
 		files_stat.nr_free_files++;
 		file_list_unlock();
 	}
--- 2.4/include/linux/slab.h	Tue Dec 25 17:12:07 2001
+++ build-2.4/include/linux/slab.h	Thu Feb  7 20:45:12 2002
@@ -78,6 +78,39 @@
 extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*sigact_cachep;
 
+
+#ifdef CONFIG_DEBUG_SLAB
+extern void __check_poison(void *obj, int size, char *file, int line);
+
+#define check_and_clear_poison(obj, size) \
+		do { \
+			__check_poison(obj, size, __FILE__, __LINE__); \
+			memset(obj, 0, size); \
+		} while(0)
+
+#define check_poison(obj, size) \
+		do { \
+			__check_poison(obj, size, __FILE__, __LINE__); \
+			memset(obj, 0x2C, size); \
+		} while(0)
+
+#define poison_obj(obj, size) \
+			memset(obj, 0xe3, size); \
+
+#else
+static inline void check_and_clear_poison(void *obj, int size)
+{
+	memset(obj, 0, size);
+}
+static inline void check_poison(void *obj, int size)
+{
+	/* nop */
+}
+static inline void poison_obj(void *obj, int size)
+{
+	/* nop */
+}
+#endif
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
--- 2.4/mm/slab.c	Tue Dec 25 17:12:07 2001
+++ build-2.4/mm/slab.c	Thu Feb  7 19:37:35 2002
@@ -1196,8 +1196,11 @@
 
 	if (objnr >= cachep->num)
 		BUG();
-	if (objp != slabp->s_mem + objnr*cachep->objsize)
+	if (objp != slabp->s_mem + objnr*cachep->objsize) {
+		printk("cache %s: got objp %p, objnr %d, s_mem %ph.\n",
+				cachep->name, objp, objnr, slabp->s_mem);
 		BUG();
+	}
 
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
@@ -1210,6 +1213,9 @@
 
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
+#ifdef DEBUG
+	if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
+		BUG();
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
 			BUG();
@@ -1217,6 +1223,7 @@
 		if (cachep->gfpflags & GFP_DMA)
 			BUG();
 	}
+#endif
 }
 
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
@@ -1347,6 +1354,15 @@
 	objp = kmem_cache_alloc_one(cachep);
 #endif
 	local_irq_restore(save_flags);
+#if DEBUG
+	if (cachep->flags & SLAB_RED_ZONE) {
+		kmem_extra_free_checks(cachep, GET_PAGE_SLAB(virt_to_page(objp)),
+				objp-BYTES_PER_WORD);
+	} else {
+		kmem_extra_free_checks(cachep, GET_PAGE_SLAB(virt_to_page(objp)),
+				objp);
+	}
+#endif
 	return objp;
 alloc_new_slab:
 #ifdef CONFIG_SMP
@@ -1475,6 +1491,15 @@
 #ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
 
+#if DEBUG
+	if (cachep->flags & SLAB_RED_ZONE) {
+		kmem_extra_free_checks(cachep, GET_PAGE_SLAB(virt_to_page(objp)),
+				objp-BYTES_PER_WORD);
+	} else {
+		kmem_extra_free_checks(cachep, GET_PAGE_SLAB(virt_to_page(objp)),
+				objp);
+	}
+#endif
 	CHECK_PAGE(virt_to_page(objp));
 	if (cc) {
 		int batchcount;
@@ -2039,3 +2064,17 @@
 #endif
 }
 #endif
+
+#ifdef CONFIG_DEBUG_SLAB
+void __check_poison(void *obj, int size, char *file, int line)
+{
+	int i;
+	for (i=0;i<size;i++) {
+		if (((unsigned char*)obj)[i] != 0xe3) {
+			printk(KERN_INFO "poison error in obj %p, len %d, file %s, line %d, offset %d is: 0x%x\n",
+					obj, size, file, line, i, ((unsigned char*)obj)[i]);
+		}
+	}
+}
+#endif
+
--- 2.4/mm/page_alloc.c	Tue Feb  5 18:48:23 2002
+++ build-2.4/mm/page_alloc.c	Thu Feb  7 19:50:22 2002
@@ -76,6 +76,8 @@
 	if (PageLRU(page))
 		lru_cache_del(page);
 
+	if (!PageHighMem(page))
+		poison_obj(page_address(page), (1<<order)*PAGE_SIZE);
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -95,7 +97,16 @@
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
  back_local_freelist:
-
+#ifdef CONFIG_DEBUG_SLAB
+	page->mapping = (void*)0xdeadbeef;
+	page->index = 0xbaadc0de;
+	page->next_hash = (void*)0xbeefdead;
+	atomic_set(&page->count,1);
+	page->lru.next = (void*)0xbaadf00d;
+	page->lru.prev = (void*)0xf00dbaad;
+	page->pprev_hash = (void*)0xdeadbeef;
+	page->buffers = (void*)0xdeadbeef;
+#endif
 	zone = page->zone;
 
 	mask = (~0UL) << order;
@@ -206,6 +217,26 @@
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);
 
+#ifdef CONFIG_DEBUG_SLAB
+			if (page->mapping != (void*)0xdeadbeef)
+				printk(KERN_ERR"got mapping %p.\n", page->mapping);
+			if (page->index != 0xbaadc0de)
+				printk(KERN_ERR "got index %lxh.\n", page->index);
+			if (page->next_hash != (void*)0xbeefdead)
+				printk(KERN_ERR "got next_hash %p.\n", page->next_hash);
+			if (atomic_read(&page->count) != 1)
+				printk(KERN_ERR "bad page count %d.\n", atomic_read(&page->count));
+			if (page->lru.next != (void*)0xbaadf00d)
+				printk(KERN_ERR" bad lru_next %p.\n", page->lru.next);
+			if (page->lru.prev != (void*)0xf00dbaad)
+				printk(KERN_ERR" bad lru_prev %p.\n", page->lru.prev);
+			if (page->pprev_hash != (void*)0xdeadbeef)
+				printk(KERN_ERR" bad pprev_hash %p.\n", page->pprev_hash);
+			if (page->buffers != (void*)0xdeadbeef)
+				printk(KERN_ERR" bad page->buffers %p.\n", page->buffers); 
+			page->mapping = NULL;
+			page->buffers = NULL; 
+#endif
 			set_page_count(page, 1);
 			if (BAD_RANGE(zone,page))
 				BUG();
@@ -226,8 +257,12 @@
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
-	return __alloc_pages(gfp_mask, order,
+	struct page * pg;
+	pg = __alloc_pages(gfp_mask, order,
 		contig_page_data.node_zonelists+(gfp_mask & GFP_ZONEMASK));
+	if (pg && !PageHighMem(page))
+		check_poison(page_address(pg), (1<<order)*PAGE_SIZE);
+	return pg;
 }
 #endif
 
--- 2.4/fs/buffer.c	Tue Feb  5 18:48:22 2002
+++ build-2.4/fs/buffer.c	Thu Feb  7 19:37:35 2002
@@ -1207,6 +1207,7 @@
 		bh->b_dev = B_FREE;
 		bh->b_blocknr = -1;
 		bh->b_this_page = NULL;
+		bh->b_size = 0xbaad;
 
 		nr_unused_buffer_heads++;
 		bh->b_next_free = unused_list;
@@ -1237,6 +1238,8 @@
 		unused_list = bh->b_next_free;
 		nr_unused_buffer_heads--;
 		spin_unlock(&unused_list_lock);
+		if (bh->b_size != 0xbaad)
+			printk(KERN_ERR "wrong size %lxh.\n", bh->b_size);
 		return bh;
 	}
 	spin_unlock(&unused_list_lock);
@@ -1261,6 +1264,8 @@
 			unused_list = bh->b_next_free;
 			nr_unused_buffer_heads--;
 			spin_unlock(&unused_list_lock);
+			if (bh->b_size != 0xbaad)
+				printk(KERN_ERR "wrong size %lxh.\n", bh->b_size);
 			return bh;
 		}
 		spin_unlock(&unused_list_lock);

--------------0203480051190256D75CEE62--


