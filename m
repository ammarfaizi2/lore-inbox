Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUBQHa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUBQHa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:30:29 -0500
Received: from dp.samba.org ([66.70.73.150]:34485 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261270AbUBQHa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:30:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, lhcs-devel@lists.sourceforge.net,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][2.6-mm] split drain_local_pages 
In-reply-to: Your message of "Mon, 16 Feb 2004 17:40:54 CDT."
             <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com> 
Date: Tue, 17 Feb 2004 18:29:34 +1100
Message-Id: <20040217073038.33DA62C594@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com> you write:
> CPU hotplug core needs to pass a cpu parameter to drain_local_pages, it's
> safe to call __drain_local_pages if the cpu being drained is offline. The
> semantics for drain_local_pages do not change.

I prefer this version: it gets the #ifdef correct too.

Name: Introduce __drain_pages() To Take a CPU Number
Author: Rusty Russell
Status: Booted on 2.6.2-rc2-bk2

Hotplug CPU needs to drain pages on a downed CPU (usually it's the
current cpu).  Introduce "__drain_pages", make the CPU an argument,
and expose it if CONFIG_HOTPLUG_CPU as well as CONFIG_PM.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26287-linux-2.6.3-rc3-bk1/mm/page_alloc.c .26287-linux-2.6.3-rc3-bk1.updated/mm/page_alloc.c
--- .26287-linux-2.6.3-rc3-bk1/mm/page_alloc.c	2004-02-15 18:17:22.000000000 +1100
+++ .26287-linux-2.6.3-rc3-bk1.updated/mm/page_alloc.c	2004-02-17 17:22:10.000000000 +1100
@@ -390,6 +390,27 @@ static int rmqueue_bulk(struct zone *zon
 	return allocated;
 }
 
+#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
+static void __drain_pages(unsigned int cpu)
+{
+	struct zone *zone;
+	int i;
+
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pset;
+
+		pset = &zone->pageset[cpu];
+		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
+			struct per_cpu_pages *pcp;
+
+			pcp = &pset->pcp[i];
+			pcp->count -= free_pages_bulk(zone, pcp->count,
+						&pcp->list, 0);
+		}
+	}
+}
+#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
+
 #ifdef CONFIG_PM
 int is_head_of_free_region(struct page *page)
 {
@@ -419,22 +440,9 @@ int is_head_of_free_region(struct page *
 void drain_local_pages(void)
 {
 	unsigned long flags;
-	struct zone *zone;
-	int i;
 
 	local_irq_save(flags);	
-	for_each_zone(zone) {
-		struct per_cpu_pageset *pset;
-
-		pset = &zone->pageset[smp_processor_id()];
-		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &pset->pcp[i];
-			pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
-		}
-	}
+	__drain_pages(smp_processor_id());
 	local_irq_restore(flags);	
 }
 #endif /* CONFIG_PM */
@@ -1574,7 +1586,7 @@ static int page_alloc_cpu_notify(struct
 		count = &per_cpu(nr_pagecache_local, cpu);
 		atomic_add(*count, &nr_pagecache);
 		*count = 0;
-		drain_local_pages(cpu);
+		__drain_pages(cpu);
 	}
 	return NOTIFY_OK;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
