Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbUCXHGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCXHGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:06:19 -0500
Received: from ozlabs.org ([203.10.76.45]:201 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263034AbUCXHGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:06:07 -0500
Subject: Re: [PATCH - cpu hotplug] Fix races in kmem_cache_create and
	kmem_cache_destroy
From: Rusty Russell <rusty@rustcorp.com.au>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040323131731.GA6914@in.ibm.com>
References: <20040323131731.GA6914@in.ibm.com>
Content-Type: text/plain
Message-Id: <1080111959.11383.358.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 18:06:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-24 at 00:17, Srivatsa Vaddagiri wrote:
> Hi Rusty,
> 	Hit couple of (cpu hotplug) races in slab allocator during my tests.
> Mostly it was because of continuous loading/unloading fs/minix/minix.ko while
> simultaneously doing offline/online of CPUs. As part of its init and exit
> routines, minix.ko create/destroys caches, which lead to several oopses.

Your patch is simple and obviously correct, but I wonder about the whole
way this does things.

AFAICT, the kmem_cache_create -> enable_cpucache -> do_tune_cpucache ->
smp_call_function() path is a little convoluted anyway.  I'll look at
that tomorrow.

Meanwhile, Andrew, could you take this patch...

Name: Slab Creation/Destruction vs. CPU Hotplug
Author: Srivatsa Vaddagiri <vatsa@in.ibm.com>

Hit couple of (cpu hotplug) races in slab allocator during my tests.
Mostly it was because of continuous loading/unloading
fs/minix/minix.ko while simultaneously doing offline/online of
CPUs. As part of its init and exit routines, minix.ko create/destroys
caches, which lead to several oopses.

1. kmem_cache_create
	In brief, kmem_cache_create does:
		a) calls enable_cpucache to create per-cpu cache for all 
		   online CPUs. 
		b) adds the cache to the global list of caches 

	These two are not done atomically and thats what causes problems.

	For ex: lets say that at the time of step a) CPU1 is not online.
	Hence no per-cpu cache is created for CPU1 (cachep->array[1] is NULL). 
	However CPU1 is not completely dead in the sense that CPU_DEAD 
	processing for it is not yet over.  By the time CPU_DEAD processing 
	starts for CPU1, step b) is complete. So cpuup_callback finds this 
	cache and tries freeing it's per-cpu cache associated with CPU1.
	In the process it dereferences a NULL pointer and dies.


2. kmem_cache_destroy
	In brief, kmem_cache_destroy does:
		a) deletes the cache from the global list of caches
		b) Drain per-cpu cache (drain_cpu_caches), which
		   basically uses smp_call_function to run do_drain
		   on all online CPUs.

	One possible race is let's say that CPU1 is coming up. 
	By the time CPU_UP_PREPARE is processed for CPU1, step a) is
	complete. Hence cpuup_callback does not allocate any per-cpu cache
	for the cache that is being destroyed. 

	However by the time step b) is run, CPU1 is completely online
	(taking interrupts). It receives the IPI and tries draining
	it per-cpu cache (which is NULL) and dies there.

I think we need to serialize kmem_cache_create/destroy against CPU hotplug
to prevent these problems. Patch below does that by taking CPU Hotplug sem
(which is OK since kmem_cache_create/destroy are not very frequently used?).
Patch was generated against (2.6.5-rc1 + your hotplug patches).

diff -puN mm/slab.c~kmem_cache_destroy_create-oops-fix mm/slab.c
--- linux-2.6.5-rc1/mm/slab.c~kmem_cache_destroy_create-oops-fix	2004-03-23 13:54:54.000000000 +0530
+++ linux-2.6.5-rc1-vatsa/mm/slab.c	2004-03-23 17:14:12.000000000 +0530
@@ -1279,6 +1279,9 @@ next:
 	cachep->dtor = dtor;
 	cachep->name = name;
 
+	/* Don't let CPUs to come and go */
+	lock_cpu_hotplug();
+
 	if (g_cpucache_up == FULL) {
 		enable_cpucache(cachep);
 	} else {
@@ -1328,6 +1331,7 @@ next:
 			if (!strcmp(pc->name,name)) { 
 				printk("kmem_cache_create: duplicate cache %s\n",name); 
 				up(&cache_chain_sem); 
+				unlock_cpu_hotplug();
 				BUG(); 
 			}	
 		}
@@ -1337,6 +1341,7 @@ next:
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
 	up(&cache_chain_sem);
+	unlock_cpu_hotplug();
 opps:
 	return cachep;
 }
@@ -1487,6 +1492,9 @@ int kmem_cache_destroy (kmem_cache_t * c
 	if (!cachep || in_interrupt())
 		BUG();
 
+	/* Don't let CPUs to come and go */
+	lock_cpu_hotplug();
+
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
 	/*
@@ -1500,6 +1508,7 @@ int kmem_cache_destroy (kmem_cache_t * c
 		down(&cache_chain_sem);
 		list_add(&cachep->next,&cache_chain);
 		up(&cache_chain_sem);
+		unlock_cpu_hotplug();
 		return 1;
 	}
 
@@ -1514,6 +1523,8 @@ int kmem_cache_destroy (kmem_cache_t * c
 	cachep->lists.shared = NULL;
 	kmem_cache_free(&cache_cache, cachep);
 
+	unlock_cpu_hotplug();
+
 	return 0;
 }
 


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

