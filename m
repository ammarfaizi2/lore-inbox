Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSLaTTN>; Tue, 31 Dec 2002 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSLaTTN>; Tue, 31 Dec 2002 14:19:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:36259 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264729AbSLaTTL>;
	Tue, 31 Dec 2002 14:19:11 -0500
Message-ID: <3E11EF9D.93EBB5F4@digeo.com>
Date: Tue, 31 Dec 2002 11:27:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: patch -- mempool buglet (?)
References: <3E11DF87.4090901@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 19:27:30.0231 (UTC) FILETIME=[A8F27C70:01C2B102]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
> I noticed this when reading the mempool code ... looked
> wrong to me, it was using kfree() not the de-allocator
> matching the allocation it just made.  This is on a fault
> path that likely doesn't get much use.
> 
> Compiles, untested, "looks right".
> 

Yup, thanks.  We actually need to drop the pool->lock
around the pool->free invokation to be consistent.  I'll
send in a fix.


--- 25/mm/mempool.c~mempool_resize-fix	Tue Dec 31 11:12:39 2002
+++ 25-akpm/mm/mempool.c	Tue Dec 31 11:23:15 2002
@@ -87,7 +87,13 @@ mempool_t * mempool_create(int min_nr, m
 	}
 	return pool;
 }
+EXPORT_SYMBOL(mempool_create);
 
+/*
+ * mempool_resize is disabled for now, because it has no callers.  Feel free
+ * to turn it back on if needed.
+ */
+#if 0
 /**
  * mempool_resize - resize an existing memory pool
  * @pool:       pointer to the memory pool which was allocated via
@@ -143,16 +149,21 @@ int mempool_resize(mempool_t *pool, int 
 		if (!element)
 			goto out;
 		spin_lock_irqsave(&pool->lock, flags);
-		if (pool->curr_nr < pool->min_nr)
+		if (pool->curr_nr < pool->min_nr) {
 			add_element(pool, element);
-		else
-			kfree(element);		/* Raced */
+		} else {
+			spin_unlock_irqrestore(&pool->lock, flags);
+			pool->free(element, pool->pool_data);	/* Raced */
+			spin_lock_irqsave(&pool->lock, flags);
+		}
 	}
 out_unlock:
 	spin_unlock_irqrestore(&pool->lock, flags);
 out:
 	return 0;
 }
+EXPORT_SYMBOL(mempool_resize);
+#endif
 
 /**
  * mempool_destroy - deallocate a memory pool
@@ -169,6 +180,7 @@ void mempool_destroy(mempool_t *pool)
 		BUG();		/* There were outstanding elements */
 	free_pool(pool);
 }
+EXPORT_SYMBOL(mempool_destroy);
 
 /**
  * mempool_alloc - allocate an element from a specific memory pool
@@ -230,6 +242,7 @@ repeat_alloc:
 
 	goto repeat_alloc;
 }
+EXPORT_SYMBOL(mempool_alloc);
 
 /**
  * mempool_free - return an element to the pool.
@@ -255,6 +268,7 @@ void mempool_free(void *element, mempool
 	}
 	pool->free(element, pool->pool_data);
 }
+EXPORT_SYMBOL(mempool_free);
 
 /*
  * A commonly used alloc and free fn.
@@ -264,17 +278,11 @@ void *mempool_alloc_slab(int gfp_mask, v
 	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
 	return kmem_cache_alloc(mem, gfp_mask);
 }
+EXPORT_SYMBOL(mempool_alloc_slab);
 
 void mempool_free_slab(void *element, void *pool_data)
 {
 	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
 	kmem_cache_free(mem, element);
 }
-
-EXPORT_SYMBOL(mempool_create);
-EXPORT_SYMBOL(mempool_resize);
-EXPORT_SYMBOL(mempool_destroy);
-EXPORT_SYMBOL(mempool_alloc);
-EXPORT_SYMBOL(mempool_free);
-EXPORT_SYMBOL(mempool_alloc_slab);
 EXPORT_SYMBOL(mempool_free_slab);

_
