Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbUKXN15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUKXN15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbUKXN1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:27:19 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64148 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262661AbUKXNDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:03:25 -0500
Subject: Suspend 2 merge: 30/51: Enable slab alloc fallback to suspend
	memory pool
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297401.5805.311.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we are preparing the image and have eaten all available memory, but
before page allocations have been switched over to the memory pool, we
sometimes need to allocate memory from slab for the image metadata (swap
header information). This code allows the slab allocator to fall back to
the memory pool in such circumstances. There is some extra debugging
code there at the moment while I seek to diagnose intermittent slab
corruption (not sure if it's suspend related).

diff -ruN 817-enable-slab-alloc-fallback-to-suspend-memory-pool-old/mm/slab.c 817-enable-slab-alloc-fallback-to-suspend-memory-pool-new/mm/slab.c
--- 817-enable-slab-alloc-fallback-to-suspend-memory-pool-old/mm/slab.c	2004-11-24 15:48:55.066733152 +1100
+++ 817-enable-slab-alloc-fallback-to-suspend-memory-pool-new/mm/slab.c	2004-11-23 07:11:42.000000000 +1100
@@ -874,14 +874,30 @@
 	flags |= cachep->gfpflags;
 	if (likely(nodeid == -1)) {
 		addr = (void*)__get_free_pages(flags, cachep->gfporder);
+		if (unlikely((!addr) && (current->pid == suspend_task) &&
+		    test_suspend_state(SUSPEND_SLAB_ALLOC_FALLBACK))) {
+			addr = (void *) suspend2_get_grabbed_pages(0);
+			printk("!! Slab addition satisfied via fallback code.\n");
+		}
 		if (!addr)
 			return NULL;
+		if (unlikely(test_suspend_state(SUSPEND_RUNNING)))
+			printk("Order %d allocation %p added to slab %p.\n",
+				cachep->gfporder, addr, cachep);
 		page = virt_to_page(addr);
 	} else {
 		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+		if (unlikely((!page) && (current->pid == suspend_task) &&
+		    test_suspend_state(SUSPEND_SLAB_ALLOC_FALLBACK))) {
+			page = virt_to_page(suspend2_get_grabbed_pages(0));
+			printk("!! Slab addition satisfied via fallback code.\n");
+		}
 		if (!page)
 			return NULL;
 		addr = page_address(page);
+		if (unlikely(test_suspend_state(SUSPEND_RUNNING)))
+			printk("Order %d allocation %p added to slab %p.\n",
+				cachep->gfporder, addr, cachep);
 	}
 
 	i = (1 << cachep->gfporder);


