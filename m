Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbSJISSs>; Wed, 9 Oct 2002 14:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbSJISSs>; Wed, 9 Oct 2002 14:18:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:8078 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261927AbSJISSq>;
	Wed, 9 Oct 2002 14:18:46 -0400
Message-ID: <3DA47455.6F78E6F1@digeo.com>
Date: Wed, 09 Oct 2002 11:24:21 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41-mm1 panics on boot, 2.5.41-vanilla OK
References: <ao1orf$m2l$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 18:24:21.0702 (UTC) FILETIME=[16859660:01C26FC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> As per subject: 2.5.41-mm1 panics on boot, 2.5.41-vanilla OK.
> 
> -mm1 panics at the point where -vanilla says "Initializing RT netlink socket".
> 

Does this fix it?

--- 2.5.41/mm/slab.c~slab-split-10-list_for_each_fix	Tue Oct  8 15:40:52 2002
+++ 2.5.41-akpm/mm/slab.c	Tue Oct  8 15:40:52 2002
@@ -461,7 +461,7 @@ static kmem_cache_t cache_cache = {
 static struct semaphore	cache_chain_sem;
 static rwlock_t cache_chain_lock = RW_LOCK_UNLOCKED;
 
-#define cache_chain (cache_cache.next)
+struct list_head cache_chain;
 
 /*
  * chicken and egg problem: delay the per-cpu array allocation
@@ -617,6 +617,7 @@ void __init kmem_cache_init(void)
 
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
+	list_add(&cache_cache.next, &cache_chain);
 
 	cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
@@ -2093,10 +2094,10 @@ static void *s_start(struct seq_file *m,
 	down(&cache_chain_sem);
 	if (!n)
 		return (void *)1;
-	p = &cache_cache.next;
+	p = cache_chain.next;
 	while (--n) {
 		p = p->next;
-		if (p == &cache_cache.next)
+		if (p == &cache_chain)
 			return NULL;
 	}
 	return list_entry(p, kmem_cache_t, next);
@@ -2107,9 +2108,9 @@ static void *s_next(struct seq_file *m, 
 	kmem_cache_t *cachep = p;
 	++*pos;
 	if (p == (void *)1)
-		return &cache_cache;
-	cachep = list_entry(cachep->next.next, kmem_cache_t, next);
-	return cachep == &cache_cache ? NULL : cachep;
+		return list_entry(cache_chain.next, kmem_cache_t, next);
+	return cachep->next.next == &cache_chain ? NULL
+		: list_entry(cachep->next.next, kmem_cache_t, next);
 }
 
 static void s_stop(struct seq_file *m, void *p)

.
