Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUBPWlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265967AbUBPWlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:41:24 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57539 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265961AbUBPWlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:41:13 -0500
Date: Mon, 16 Feb 2004 17:40:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, lhcs-devel@lists.sourceforge.net,
       Pavel Machek <pavel@ucw.cz>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.6-mm] split drain_local_pages
Message-ID: <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU hotplug core needs to pass a cpu parameter to drain_local_pages, it's
safe to call __drain_local_pages if the cpu being drained is offline. The
semantics for drain_local_pages do not change.

Index: linux-2.6.3-rc3-mm1/mm/page_alloc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/mm/page_alloc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 page_alloc.c
--- linux-2.6.3-rc3-mm1/mm/page_alloc.c	16 Feb 2004 20:42:50 -0000	1.1.1.1
+++ linux-2.6.3-rc3-mm1/mm/page_alloc.c	16 Feb 2004 21:58:19 -0000
@@ -414,19 +414,19 @@ int is_head_of_free_region(struct page *
 }

 /*
- * Spill all of this CPU's per-cpu pages back into the buddy allocator.
+ * drain_local_pages helper, this is only safe to use when the cpu
+ * being drained isn't currently online.
  */
-void drain_local_pages(void)
+
+void __drain_local_pages(int cpu)
 {
-	unsigned long flags;
 	struct zone *zone;
 	int i;
-
-	local_irq_save(flags);
+
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;

-		pset = &zone->pageset[smp_processor_id()];
+		pset = &zone->pageset[cpu];
 		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
 			struct per_cpu_pages *pcp;

@@ -435,7 +435,19 @@ void drain_local_pages(void)
 						&pcp->list, 0);
 		}
 	}
-	local_irq_restore(flags);
+}
+
+/*
+ * Spill all of this CPU's per-cpu pages back into the buddy allocator.
+ */
+
+void drain_local_pages(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__drain_local_pages(smp_processor_id());
+	local_irq_restore(flags);
 }
 #endif /* CONFIG_PM */

@@ -1574,7 +1586,7 @@ static int page_alloc_cpu_notify(struct
 		count = &per_cpu(nr_pagecache_local, cpu);
 		atomic_add(*count, &nr_pagecache);
 		*count = 0;
-		drain_local_pages(cpu);
+		__drain_local_pages(cpu);
 	}
 	return NOTIFY_OK;
 }
