Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbSLSWIK>; Thu, 19 Dec 2002 17:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbSLSWH2>; Thu, 19 Dec 2002 17:07:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5124 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266795AbSLSWGZ>;
	Thu, 19 Dec 2002 17:06:25 -0500
Date: Thu, 19 Dec 2002 21:04:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: akpm@digeo.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Cold allocation so that swsusp works
Message-ID: <20021219200408.GA7252@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is my try to make swsusp work... Does it look acceptable?
								Pavel

--- clean/include/linux/gfp.h	2002-11-01 00:37:40.000000000 +0100
+++ linux-swsusp/include/linux/gfp.h	2002-12-19 20:35:47.000000000 +0100
@@ -18,6 +18,7 @@
 #define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
 #define __GFP_FS	0x100	/* Can call down to low-level FS? */
 #define __GFP_COLD	0x200	/* Cache-cold page required */
+#define __GFP_SWSUSP	0x400	/* We want page that used to be free, not some page from list */
 
 #define GFP_NOHIGHIO	(             __GFP_WAIT | __GFP_IO)
 #define GFP_NOIO	(             __GFP_WAIT)
--- clean/kernel/suspend.c	2002-12-18 22:21:13.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-12-19 20:39:26.000000000 +0100
@@ -547,7 +547,7 @@
 
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_SWSUSP, pagedir_order);
 	if(!pagedir)
 		return NULL;
 
@@ -556,7 +556,7 @@
 		SetPageNosave(page++);
 		
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_SWSUSP);
 		if(!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
--- clean/mm/page_alloc.c	2002-12-18 22:21:13.000000000 +0100
+++ linux-swsusp/mm/page_alloc.c	2002-12-19 20:51:59.000000000 +0100
@@ -389,10 +389,10 @@
 	unsigned long flags;
 	struct page *page = NULL;
 
-	if (order == 0) {
+	if ((order == 0) && !(cold & __GFP_SWSUSP)) {
 		struct per_cpu_pages *pcp;
 
-		pcp = &zone->pageset[get_cpu()].pcp[cold];
+		pcp = &zone->pageset[get_cpu()].pcp[!!cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
@@ -444,15 +444,10 @@
 	struct zone **zones, *classzone;
 	struct page *page;
 	int i;
-	int cold;
 
 	if (wait)
 		might_sleep();
 
-	cold = 0;
-	if (gfp_mask & __GFP_COLD)
-		cold = 1;
-
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 	classzone = zones[0]; 
 	if (classzone == NULL)    /* no zones in the zonelist */
@@ -466,7 +461,7 @@
 		min += z->pages_low;
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
-			page = buffered_rmqueue(z, order, cold);
+			page = buffered_rmqueue(z, order, gfp_mask & (__GFP_COLD | __GFP_SWSUSP));
 			if (page)
 				return page;
 		}
@@ -489,7 +484,7 @@
 		min += local_min;
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
-			page = buffered_rmqueue(z, order, cold);
+			page = buffered_rmqueue(z, order, gfp_mask & (__GFP_COLD | __GFP_SWSUSP));
 			if (page)
 				return page;
 		}
@@ -504,7 +499,7 @@
 		for (i = 0; zones[i] != NULL; i++) {
 			struct zone *z = zones[i];
 
-			page = buffered_rmqueue(z, order, cold);
+			page = buffered_rmqueue(z, order, gfp_mask & (__GFP_COLD | __GFP_SWSUSP));
 			if (page)
 				return page;
 		}
@@ -527,7 +522,7 @@
 		min += z->pages_min;
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
-			page = buffered_rmqueue(z, order, cold);
+			page = buffered_rmqueue(z, order, gfp_mask & (__GFP_COLD | __GFP_SWSUSP));
 			if (page)
 				return page;
 		}

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
