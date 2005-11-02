Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbVKBFBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbVKBFBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbVKBFBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:01:12 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:40614 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751494AbVKBFBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:01:11 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
X-Message-Flag: Warning: May contain useful information
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
	<Pine.LNX.4.61.0511010039370.1387@scrub.home>
	<20051031160557.7540cd6a.akpm@osdl.org>
	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
	<20051031163408.41a266f3.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 01 Nov 2005 21:01:01 -0800
In-Reply-To: <20051031163408.41a266f3.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 31 Oct 2005 16:34:08 -0800")
Message-ID: <52y847abjm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 02 Nov 2005 05:01:02.0406 (UTC) FILETIME=[6C28AE60:01C5DF6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And a lot of it is us just being bloated. Argh.

Perhaps it's time to dust this patch off:


Reduce kernel text by moving many uses of GFP_KERNEL out of line, by
creating __kmem_cache_alloc_gfp_kernel(), __kmalloc_gfp_kernel() and
__kzalloc_gfp_kernel() wrapper functions.  Then kmem_cache_alloc(),
kmalloc() and kzalloc() can be inline functions that just call their
_gfp_kernel version if their flags parameter is a compile-time
constant and is GFP_KERNEL, and call their ordinary version otherwise.

On an x86_64 allnoconfig kernel, I see the following sizes:

	   text	   data	    bss	    dec	    hex	filename
	 795683	 197356	 116384	1109423	 10edaf	vmlinux-before
	 794894	 197420	 116384	1108698	 10eada	vmlinux-after

for a net savings of 789 bytes of text.  More realistic configs will
save even more.  With my usual config, the patched kernel boots and
runs fine.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 09b9aa6..618331d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -61,7 +61,8 @@ extern kmem_cache_t *kmem_cache_create(c
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
-extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
+extern void *__kmem_cache_alloc(kmem_cache_t *, gfp_t);
+extern void *__kmem_cache_alloc_gfp_kernel(kmem_cache_t *);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 extern const char *kmem_cache_name(kmem_cache_t *);
@@ -75,6 +76,15 @@ struct cache_sizes {
 };
 extern struct cache_sizes malloc_sizes[];
 extern void *__kmalloc(size_t, gfp_t);
+extern void *__kmalloc_gfp_kernel(size_t);
+
+static inline void *kmem_cache_alloc(kmem_cache_t *cache, gfp_t flags)
+{
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kmem_cache_alloc_gfp_kernel(cache);
+
+	return __kmem_cache_alloc(cache, flags);
+}
 
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
@@ -96,10 +106,22 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kmalloc_gfp_kernel(size);
 	return __kmalloc(size, flags);
 }
 
-extern void *kzalloc(size_t, gfp_t);
+extern void *__kzalloc(size_t, gfp_t);
+extern void *__kzalloc_gfp_kernel(size_t);
+
+static inline void *kzalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kzalloc_gfp_kernel(size);
+
+	return __kzalloc(size, flags);
+}
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
diff --git a/mm/slab.c b/mm/slab.c
index 22bfb0b..2971e1c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2788,11 +2788,17 @@ static inline void __cache_free(kmem_cac
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+void *__kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
 {
 	return __cache_alloc(cachep, flags);
 }
-EXPORT_SYMBOL(kmem_cache_alloc);
+EXPORT_SYMBOL(__kmem_cache_alloc);
+
+void *__kmem_cache_alloc_gfp_kernel(kmem_cache_t *cachep)
+{
+	return __cache_alloc(cachep, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kmem_cache_alloc_gfp_kernel);
 
 /**
  * kmem_ptr_validate - check if an untrusted pointer might
@@ -2925,6 +2931,12 @@ void *__kmalloc(size_t size, gfp_t flags
 }
 EXPORT_SYMBOL(__kmalloc);
 
+void *__kmalloc_gfp_kernel(size_t size)
+{
+	return __kmalloc(size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kmalloc_gfp_kernel);
+
 #ifdef CONFIG_SMP
 /**
  * __alloc_percpu - allocate one copy of the object for every present
@@ -2998,14 +3010,20 @@ EXPORT_SYMBOL(kmem_cache_free);
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  */
-void *kzalloc(size_t size, gfp_t flags)
+void *__kzalloc(size_t size, gfp_t flags)
 {
 	void *ret = kmalloc(size, flags);
 	if (ret)
 		memset(ret, 0, size);
 	return ret;
 }
-EXPORT_SYMBOL(kzalloc);
+EXPORT_SYMBOL(__kzalloc);
+
+void *__kzalloc_gfp_kernel(size_t size)
+{
+	return __kzalloc(size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kzalloc_gfp_kernel);
 
 /**
  * kfree - free previously allocated memory
