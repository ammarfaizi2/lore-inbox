Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130874AbQLJNFZ>; Sun, 10 Dec 2000 08:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130989AbQLJNFQ>; Sun, 10 Dec 2000 08:05:16 -0500
Received: from colorfullife.com ([216.156.138.34]:59921 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130874AbQLJNFF>;
	Sun, 10 Dec 2000 08:05:05 -0500
Date: Sun, 10 Dec 2000 12:37:12 +0100 (CET)
From: Manfred <manfred@colorfullife.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [uPATCH] bugfix for slab tuning race
Message-ID: <Pine.LNX.4.21.0012101224560.1447-100000@clmsdevli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the patch below fixes a race in the slab allocator:
If one cpu increases the batch count (kmem_tune_cpucache, just before 
smp_call_function_all_cpus()) and another cpu allocates a new batch
of slab entries before the IPI arrives, then kmem_cache_alloc_batch
writes behind the end of the cpu local array.

The patch is against 2.4.0-test11.
--
  Manfred

<<<<<<<<<<<<<<
--- 2.4/mm/slab.c	Tue Oct  3 20:03:44 2000
+++ build-2.4/mm/slab.c	Sat Dec  2 15:00:32 2000
@@ -188,7 +188,7 @@
 	unsigned int		num;	/* # of objs per slab */
 	spinlock_t		spinlock;
 #ifdef CONFIG_SMP
-	unsigned int		batchcount;
+	volatile unsigned int	batchcount;
 #endif
 
 /* 2) slab additions /removals */
@@ -1637,11 +1637,19 @@
 		}
 	}
 	new.cachep = cachep;
-	spin_lock_irq(&cachep->spinlock);
-	cachep->batchcount = batchcount;
-	spin_unlock_irq(&cachep->spinlock);
+	if(batchcount < cachep->batchcount) {
+		spin_lock_irq(&cachep->spinlock);
+		cachep->batchcount = batchcount;
+		spin_unlock_irq(&cachep->spinlock);
+	}
 
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
+
+	if(batchcount > cachep->batchcount) {
+		spin_lock_irq(&cachep->spinlock);
+		cachep->batchcount = batchcount;
+		spin_unlock_irq(&cachep->spinlock);
+	}
 
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpucache_t* ccold = new.new[cpu_logical_map(i)];
>>>>>>>>>>>>>>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
