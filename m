Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTCWUtE>; Sun, 23 Mar 2003 15:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbTCWUtD>; Sun, 23 Mar 2003 15:49:03 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9609 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263204AbTCWUs7>;
	Sun, 23 Mar 2003 15:48:59 -0500
Message-ID: <3E7E204C.2040700@colorfullife.com>
Date: Sun, 23 Mar 2003 21:59:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Brian Gerst <bgerst@didntduck.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab.c cleanup
Content-Type: multipart/mixed;
 boundary="------------080208060303060004010206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080208060303060004010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Anton wrote:

>> - Don't create caches that are not multiples of L1_CACHE_BYTES.
>
>Nice idea, I often see the list walk (of the cache sizes) in kmalloc in kernel
>profiles. eg a bunch of kmalloc(2k) for network drivers.
>
>Since we have a 128byte cacheline on ppc64 this patch should reduce that.
>  
>
No, the patch is a bad thing: It means that everyone who does 
kmalloc(32,) now allocates 128 bytes, i.e. 3/4 wasted. IMHO not acceptable.

I agree that the list walk in kmalloc is a problem - but the right 
solution is a quicker lookup.
Perhaps something like the attached patch.
For networking: I bet that virtually all allocations have the same size 
- what about calling kmem_find_general_cachep, and caching the last 
request/result? Then the next calls can allocate directly from the 
appropriate cache, without any lookup.

--
    Manfred


--------------080208060303060004010206
Content-Type: text/plain;
 name="patch-fast-kmalloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fast-kmalloc"

--- 2.5/mm/slab.c	Sat Oct 26 21:13:33 2002
+++ build-2.5/mm/slab.c	Sun Oct 27 13:48:06 2002
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
+		int size = (1<<i)+1;
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
+	if (unlikely(size < 2))
+		size = 2;
+	csizep = malloc_hints[fls((size-1))-1];
 
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)

--------------080208060303060004010206--

