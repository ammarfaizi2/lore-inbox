Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262818AbSJFALR>; Sat, 5 Oct 2002 20:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262822AbSJFALR>; Sat, 5 Oct 2002 20:11:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:59521 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262818AbSJFALQ>;
	Sat, 5 Oct 2002 20:11:16 -0400
Message-ID: <3D9F80EA.2768688@digeo.com>
Date: Sat, 05 Oct 2002 17:16:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] patch-slab-split-08-reap
References: <3D9EBFA9.90806@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 00:16:45.0887 (UTC) FILETIME=[A7C92CF0:01C26CCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
>  int __init cpucache_init(void)
>  {
>         struct list_head* p;
> +       int i;
> 
>         down(&cache_chain_sem);
>         g_cpucache_up = FULL;
> 
> -       p = &cache_cache.next;
> -       do {
> +       list_for_each(p, &cache_chain) {
>                 kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
>                 enable_cpucache(cachep);
>                 p = cachep->next.next;
> -       } while (p != &cache_cache.next);
> +       }

You're only visiting every second member in this list walk.
I added the below diff which gets me to a login prompt.  I need
to get another rollup out - I'll beat on the slab changes a bit
and include them if they look solid; otherwise I'll upload an
incremental diff for them.

--- 2.5.40/mm/slab.c~cpucache_init-fix	Sat Oct  5 17:06:28 2002
+++ 2.5.40-akpm/mm/slab.c	Sat Oct  5 17:06:28 2002
@@ -697,17 +697,14 @@ void __init kmem_cache_sizes_init(void)
 
 int __init cpucache_init(void)
 {
-	struct list_head* p;
+	kmem_cache_t *cachep;
 	int i;
 
 	down(&cache_chain_sem);
 	g_cpucache_up = FULL;
 
-	list_for_each(p, &cache_chain) {
-		kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
+	list_for_each_entry(cachep, &cache_chain, next)
 		enable_cpucache(cachep);
-		p = cachep->next.next;
-	}
 	
 	/* 
 	 * Register the timers that return unneeded

.
