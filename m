Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVBHKdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVBHKdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 05:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVBHKdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 05:33:50 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:55754 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261508AbVBHKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 05:33:47 -0500
Date: Tue, 8 Feb 2005 11:33:46 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.netfilter.org
Subject: [PATCH] Fix small vmalloc per allocation limit
Message-ID: <20050208103345.GA9724@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The vmap vmalloc rework in 2.5 had a unintended side effect.
vmalloc uses kmalloc now to allocate an array with a list of pages.
kmalloc has a 128K maximum. This limits the vmalloc maximum size 
to 64MB on a 64bit system with 4K pages. That limit causes problems
with other subsystems, e.g. iptables relies on allocating large
vmallocs for its rule sets. 

This is a bug IMHO - on 64bit platforms there shouldn't be 
such a low limit on the vmalloc size. And even on 32bit it's too
small for custom kernels with enlarged vmalloc area.

Another problem is that this makes vmalloc unreliable. After the
system has been running for some time it is unlikely that kmalloc
will be able to allocate >order 2 pages due to memory fragmentation.

This patch takes the easy way out for fixing this by just allocating
this array with vmalloc when it is larger than a page.
While more complicated and intrusive solutions would be possible
they didn't use vmalloc recursively they didn't seem it worth
to handle this very infrequent case.

Please note that the vmalloc recursion is strictly bounded
because each nested allocation will generate a much smaller
stack frame. Also the kernel stack can handle even a few
recursion steps easily because vmalloc has only a  small
stack frame.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.11rc3/mm/vmalloc.c-o linux-2.6.11rc3/mm/vmalloc.c
--- linux-2.6.11rc3/mm/vmalloc.c-o	2005-02-04 09:13:51.000000000 +0100
+++ linux-2.6.11rc3/mm/vmalloc.c	2005-02-08 10:59:58.000000000 +0100
@@ -378,7 +378,10 @@
 			__free_page(area->pages[i]);
 		}
 
-		kfree(area->pages);
+		if (area->nr_pages > PAGE_SIZE/sizeof(struct page *))
+			vfree(area->pages);
+		else
+			kfree(area->pages);
 	}
 
 	kfree(area);
@@ -482,7 +485,12 @@
 	array_size = (nr_pages * sizeof(struct page *));
 
 	area->nr_pages = nr_pages;
-	area->pages = pages = kmalloc(array_size, (gfp_mask & ~__GFP_HIGHMEM));
+	/* Please note that the recursion is strictly bounded. */
+	if (array_size > PAGE_SIZE) 
+		pages = __vmalloc(array_size, gfp_mask, PAGE_KERNEL);
+	else
+		pages = kmalloc(array_size, (gfp_mask & ~__GFP_HIGHMEM));
+	area->pages = pages;
 	if (!area->pages) {
 		remove_vm_area(area->addr);
 		kfree(area);
