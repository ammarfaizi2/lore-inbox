Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSKEFxh>; Tue, 5 Nov 2002 00:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSKEFxh>; Tue, 5 Nov 2002 00:53:37 -0500
Received: from dp.samba.org ([66.70.73.150]:48587 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264919AbSKEFxe>;
	Tue, 5 Nov 2002 00:53:34 -0500
Date: Tue, 5 Nov 2002 16:49:48 +1100
From: Anton Blanchard <anton@samba.org>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix slab allocator for non zero boot cpu
Message-ID: <20021105054948.GA10335@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The slab allocator doesnt initialise ->array for all cpus. This means
we fail to boot on a machine with boot cpu != 0. I was testing current
2.5 BK.

Luckily Rusty was at hand to explain the ins and outs of initialisers
to me. Manfred, does this look OK to you?

Anton

===== mm/slab.c 1.46 vs edited =====
--- 1.46/mm/slab.c	Sat Nov  2 08:34:38 2002
+++ edited/mm/slab.c	Tue Nov  5 15:55:55 2002
@@ -437,7 +437,8 @@
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
 	.lists		= LIST3_INIT(cache_cache.lists),
-	.array		= { [0] = &initarray_cache.cache },
+	/* Allow for boot cpu != 0 */
+	.array		= { [0 ... NR_CPUS-1] = &initarray_cache.cache },
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
 	.objsize	= sizeof(kmem_cache_t),
