Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVCIDOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVCIDOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCIDOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:14:00 -0500
Received: from fmr22.intel.com ([143.183.121.14]:57319 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261516AbVCIDN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:13:58 -0500
Message-Id: <200503090313.j293Dog17032@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>
Subject: Bug fix in slab.c:alloc_arraycache
Date: Tue, 8 Mar 2005 19:13:50 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkVgOxEsoxvoSsTpq+ImpbGFczFQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kmem_cache_alloc_node is not capable of handling a null cachep
pointer as its input argument.

If I try to increase a slab limit by echoing a very large number
into /proc/slabinfo, kernel will panic from alloc_arraycache()
because Kmem_find_general_cachep() can actually return a NULL
pointer if the size argument is sufficiently large.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.11/mm/slab.c	Mon Oct 18 14:55:43 2004
+++ linux-2.6.11.ken/mm/slab.c	Tue Mar  1 19:14:07 2005
@@ -643,8 +645,10 @@
 	struct array_cache *nc = NULL;

 	if (cpu != -1) {
-		nc = kmem_cache_alloc_node(kmem_find_general_cachep(memsize,
-					GFP_KERNEL), cpu_to_node(cpu));
+		kmem_cache_t * cachep;
+		cachep = kmem_find_general_cachep(memsize, GFP_KERNEL);
+		if (cachep)
+			nc = kmem_cache_alloc_node(cachep, cpu_to_node(cpu));
 	}
 	if (!nc)
 		nc = kmalloc(memsize, GFP_KERNEL);


