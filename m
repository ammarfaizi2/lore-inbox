Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSLaSgM>; Tue, 31 Dec 2002 13:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSLaSgM>; Tue, 31 Dec 2002 13:36:12 -0500
Received: from host194.steeleye.com ([66.206.164.34]:53264 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264681AbSLaSgJ>; Tue, 31 Dec 2002 13:36:09 -0500
Message-Id: <200212311844.gBVIiUe02655@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Tue, 31 Dec 2002 10:11:50 PST." <3E11DDE6.7050601@pacbell.net> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-18660083880"
Date: Tue, 31 Dec 2002 12:44:30 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-18660083880
Content-Type: text/plain; charset=us-ascii

david-b@pacbell.net said:
> Nobody's done that yet, and it's been a couple years now since that
> point was made as a desirable evolution path for pci_pool.  In fact
> the first (only!) step on that path was the dma_pool update I just
> posted. 

> Modifying the slab allocator like that means passing extra parameters
> around (for dma_addr_t), causing extra register pressure even for
> non-dma allocations. I have a hard time seeing that not slow things
> down, even on x86 (etc) where we know we can already get all the
> benefits of the slab allocator without any changes to that critical
> code. 

I think the attached should do the necessary with no slow down in the slab 
allocator.

Now all that has to happen for use with the dma pools is to wrapper 
dma_alloc/free_coherent().

Note that the semantics won't be quite the same as the pci_pool one since you 
can't guarantee that allocations don't cross the particular boundary 
parameter.  There's also going to be a reliance on the concept that the dma 
coherent allocators will return a page bounded chunk of memory.  Most seem 
already to be doing this because the page properties are only controllable at 
that level, so it shouldn't be a problem.

James


--==_Exmh_-18660083880
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== mm/slab.c 1.52 vs edited =====
--- 1.52/mm/slab.c	Sat Dec 21 10:24:34 2002
+++ edited/mm/slab.c	Tue Dec 31 12:35:39 2002
@@ -260,6 +260,12 @@
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
+	/* page based allocator */
+	unsigned long FASTCALL((*getpages)(unsigned int gfp_mask, unsigned int order));
+
+	/* release pages allocated above */
+	void FASTCALL((*freepages)(unsigned long addr, unsigned int order));
+
 /* 4) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
@@ -715,7 +721,7 @@
 	 * would be relatively rare and ignorable.
 	 */
 	flags |= cachep->gfpflags;
-	addr = (void*) __get_free_pages(flags, cachep->gfporder);
+	addr = (void*) cachep->getpages(flags, cachep->gfporder);
 	/* Assume that now we have the pages no one else can legally
 	 * messes with the 'struct page's.
 	 * However vm_scan() might try to test the structure to see if
@@ -741,7 +747,7 @@
 		dec_page_state(nr_slab);
 		page++;
 	}
-	free_pages((unsigned long)addr, cachep->gfporder);
+	cachep->freepages((unsigned long)addr, cachep->gfporder);
 }
 
 #if DEBUG
@@ -811,13 +817,15 @@
 }
 
 /**
- * kmem_cache_create - Create a cache.
+ * kmem_cache_create_alloc - Create a cache with a custom allocator.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
  * @offset: The offset to use within the page.
  * @flags: SLAB flags
  * @ctor: A constructor for the objects.
  * @dtor: A destructor for the objects.
+ * @getpages: A function to get the memory pages
+ * @freepages: A function to free the corresponding pages
  *
  * Returns a ptr to the cache on success, NULL on failure.
  * Cannot be called within a int, but can be interrupted.
@@ -844,9 +852,12 @@
  * as davem.
  */
 kmem_cache_t *
-kmem_cache_create (const char *name, size_t size, size_t offset,
-	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
-	void (*dtor)(void*, kmem_cache_t *, unsigned long))
+kmem_cache_create_with_alloc (const char *name, size_t size, size_t offset,
+	unsigned long flags,
+	void (*ctor)(void*, kmem_cache_t *, unsigned long),
+	void (*dtor)(void*, kmem_cache_t *, unsigned long),
+	unsigned long FASTCALL((*getpages)(unsigned int gfp_mask, unsigned int order)),
+	void FASTCALL((*freepages)(unsigned long addr, unsigned int order)))
 {
 	const char *func_nm = KERN_ERR "kmem_create: ";
 	size_t left_over, align, slab_size;
@@ -1010,6 +1021,9 @@
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
+	BUG_ON(getpages == NULL || freepages == NULL);
+	cachep->getpages = getpages;
+	cachep->freepages = freepages;
 	cachep->name = name;
 
 	if (g_cpucache_up == FULL) {
@@ -1072,6 +1086,50 @@
 	up(&cache_chain_sem);
 opps:
 	return cachep;
+}
+
+/**
+ * kmem_cache_create_alloc - Create a cache with a custom allocator.
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @size: The size of objects to be created in this cache.
+ * @offset: The offset to use within the page.
+ * @flags: SLAB flags
+ * @ctor: A constructor for the objects.
+ * @dtor: A destructor for the objects.
+ * @getpages: A function to get the memory pages
+ * @freepages: A function to free the corresponding pages
+ *
+ * Returns a ptr to the cache on success, NULL on failure.
+ * Cannot be called within a int, but can be interrupted.
+ * The @ctor is run when new pages are allocated by the cache
+ * and the @dtor is run before the pages are handed back.
+ *
+ * @name must be valid until the cache is destroyed. This implies that
+ * the module calling this has to destroy the cache before getting 
+ * unloaded.
+ * 
+ * The flags are
+ *
+ * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
+ * to catch references to uninitialised memory.
+ *
+ * %SLAB_RED_ZONE - Insert `Red' zones around the allocated memory to check
+ * for buffer overruns.
+ *
+ * %SLAB_NO_REAP - Don't automatically reap this cache when we're under
+ * memory pressure.
+ *
+ * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
+ * cacheline.  This can be beneficial if you're counting cycles as closely
+ * as davem.
+ */
+kmem_cache_t *
+kmem_cache_create (const char *name, size_t size, size_t offset,
+	unsigned long flags,
+	void (*ctor)(void*, kmem_cache_t *, unsigned long),
+	void (*dtor)(void*, kmem_cache_t *, unsigned long))
+{
+	return kmem_cache_create_with_alloc(name, size, offset, flags, ctor, dtor, __get_free_pages, free_pages);
 }
 
 static inline void check_irq_off(void)

--==_Exmh_-18660083880--


