Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbSJZTPl>; Sat, 26 Oct 2002 15:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSJZTPl>; Sat, 26 Oct 2002 15:15:41 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:51125 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261475AbSJZTPk>;
	Sat, 26 Oct 2002 15:15:40 -0400
Message-ID: <3DBAEB64.1090109@colorfullife.com>
Date: Sat, 26 Oct 2002 21:22:12 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH,RFC] faster kmalloc lookup
Content-Type: multipart/mixed;
 boundary="------------060408060206060505050903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408060206060505050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

kmalloc spends a large part of the total execution time trying to find 
the cache for the passed in size.

What about the attached patch (against 2.5.44-mm5)?
It uses fls jump over the caches that are definitively too small.

--
    Manfred

--------------060408060206060505050903
Content-Type: text/plain;
 name="patch-fast-kmalloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fast-kmalloc"

--- 2.5/mm/slab.c	Sat Oct 26 21:13:33 2002
+++ build-2.5/mm/slab.c	Sat Oct 26 20:40:09 2002
@@ -424,6 +430,7 @@
 	CN("size-131072")
 }; 
 #undef CN
+static struct cache_sizes *malloc_hints[sizeof(size_t)*8];
 
 struct arraycache_init initarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 struct arraycache_init initarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
@@ -587,6 +594,7 @@
 void __init kmem_cache_init(void)
 {
 	size_t left_over;
+	int i;
 
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
@@ -604,6 +612,18 @@
 	 * that initializes ac_data for all new cpus
 	 */
 	register_cpu_notifier(&cpucache_notifier);
+
+	for (i=0;i<sizeof(size_t)*8;i++) {
+		struct cache_sizes *csizep = malloc_sizes;
+		int size = (1<<i)/2+1;
+
+		for ( ; csizep->cs_size; csizep++) {
+			if (size > csizep->cs_size)
+				continue;
+			break;
+		}
+		malloc_hints[i] = csizep;
+	}
 }
 
 
@@ -1796,7 +1816,11 @@
  */
 void * kmalloc (size_t size, int flags)
 {
-	struct cache_sizes *csizep = malloc_sizes;
+	struct cache_sizes *csizep;
+	
+	if(unlikely(size<2))
+		size=2;
+	csizep = malloc_hints[fls((size-1))];
 
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)

--------------060408060206060505050903--

