Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311547AbSCTEFq>; Tue, 19 Mar 2002 23:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311520AbSCTEEk>; Tue, 19 Mar 2002 23:04:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11024 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311504AbSCTEDW>; Tue, 19 Mar 2002 23:03:22 -0500
Message-ID: <3C9809B2.BDBB9401@zip.com.au>
Date: Tue, 19 Mar 2002 20:01:54 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-170-drain_cpu_caches
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A performance tweak (I guess): perform the cross-CPU cache reclaim
operation outside the global semaphore.  Needs more explanation.


=====================================

--- 2.4.19-pre3/mm/slab.c~aa-170-drain_cpu_caches	Tue Mar 19 19:49:03 2002
+++ 2.4.19-pre3-akpm/mm/slab.c	Tue Mar 19 19:49:03 2002
@@ -916,8 +916,6 @@ static int __kmem_cache_shrink(kmem_cach
 	slab_t *slabp;
 	int ret;
 
-	drain_cpu_caches(cachep);
-
 	spin_lock_irq(&cachep->spinlock);
 
 	/* If the cache is growing, stop shrinking. */
@@ -987,6 +985,8 @@ int kmem_cache_destroy (kmem_cache_t * c
 						kmem_cache_t, next);
 	list_del(&cachep->next);
 	up(&cache_chain_sem);
+
+	drain_cpu_caches(cachep);
 
 	if (__kmem_cache_shrink(cachep)) {
 		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",


-
