Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTFJBDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 21:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTFJBDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 21:03:53 -0400
Received: from sccrmhc13.attbi.com ([204.127.202.64]:64253 "EHLO
	sccrmhc13.attbi.com") by vger.kernel.org with ESMTP id S262409AbTFJBDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 21:03:50 -0400
Message-ID: <3EE531AA.4090404@quark.didntduck.org>
Date: Mon, 09 Jun 2003 21:17:30 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] optimize fixed size kmalloc calls
References: <3EE4E23E.4070307@colorfullife.com>
In-Reply-To: <3EE4E23E.4070307@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------050201090202090601060602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050201090202090601060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:
> Hi,
> 
> kmalloc(constant,GFP_KERNEL) spends a singificant amount of time in the 
> initial loop that finds the correct cache. For constant allocations, the 
> correct cache can be indentified at compile time.
> 
> What do you think about the attached patch? It's not pretty, but it 
> should work will all gcc versions. Any other ideas?
> Just FYI: The function that forced me to use use switch/case instead of 
> if is interrupts_open in fs/proc/proc_misc.c.

How about this?  GCC 3.2.2 is able to optimize it away properly from the 
tests that I've run.

--
				Brian Gerst

--------------050201090202090601060602
Content-Type: text/plain;
 name="kmalloc-const-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmalloc-const-1"

diff -ur linux-2.5.70-bk/include/linux/slab.h linux/include/linux/slab.h
--- linux-2.5.70-bk/include/linux/slab.h	2003-05-26 22:27:29.000000000 -0400
+++ linux/include/linux/slab.h	2003-06-09 17:24:40.000000000 -0400
@@ -62,7 +62,36 @@
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
-extern void *kmalloc(size_t, int);
+/* Size description struct for general caches. */
+struct cache_sizes {
+	size_t		 cs_size;
+	kmem_cache_t	*cs_cachep;
+	kmem_cache_t	*cs_dmacachep;
+};
+extern struct cache_sizes malloc_sizes[];
+extern void *__kmalloc(size_t, int);
+
+static inline void *kmalloc(size_t size, int flags)
+{
+	if (__builtin_constant_p(size)) {
+		int i = 0;
+#define CACHE(x) \
+		if (size <= x) \
+			goto found; \
+		else \
+			i++;
+#include "kmalloc_sizes.h"
+#undef CACHE
+		extern void __you_cannot_kmalloc_that_much(void);
+		__you_cannot_kmalloc_that_much();
+found:
+		return kmem_cache_alloc((flags & GFP_DMA) ?
+			malloc_sizes[i].cs_dmacachep :
+			malloc_sizes[i].cs_cachep, flags);
+	}
+	return __kmalloc(size, flags);
+}
+
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
diff -ur linux-2.5.70-bk/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.70-bk/kernel/ksyms.c	2003-06-08 23:50:12.000000000 -0400
+++ linux/kernel/ksyms.c	2003-06-09 16:44:27.000000000 -0400
@@ -95,7 +95,8 @@
 EXPORT_SYMBOL(kmem_cache_size);
 EXPORT_SYMBOL(set_shrinker);
 EXPORT_SYMBOL(remove_shrinker);
-EXPORT_SYMBOL(kmalloc);
+EXPORT_SYMBOL(malloc_sizes);
+EXPORT_SYMBOL(__kmalloc);
 EXPORT_SYMBOL(kfree);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(__alloc_percpu);
diff -ur linux-2.5.70-bk/mm/slab.c linux/mm/slab.c
--- linux-2.5.70-bk/mm/slab.c	2003-06-08 23:50:13.000000000 -0400
+++ linux/mm/slab.c	2003-06-09 16:43:55.000000000 -0400
@@ -385,11 +385,7 @@
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->list.prev)
 
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
-static struct cache_sizes {
-	size_t		 cs_size;
-	kmem_cache_t	*cs_cachep;
-	kmem_cache_t	*cs_dmacachep;
-} malloc_sizes[] = {
+struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
 #include <linux/kmalloc_sizes.h>
 	{ 0, }
@@ -1967,7 +1963,7 @@
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void * kmalloc (size_t size, int flags)
+void * __kmalloc (size_t size, int flags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 

--------------050201090202090601060602--

