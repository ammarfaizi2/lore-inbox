Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSKBSO7>; Sat, 2 Nov 2002 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSKBSO7>; Sat, 2 Nov 2002 13:14:59 -0500
Received: from [195.39.17.254] ([195.39.17.254]:24324 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261384AbSKBSNC>;
	Sat, 2 Nov 2002 13:13:02 -0500
Date: Sat, 2 Nov 2002 19:19:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: akpm@zip.com.au, kernel list <linux-kernel@vger.kernel.org>
Subject: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021102181900.GA140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Swsusp counts free pages, and relies on fact that when it allocates
page there's one free page less. That is no longer true with hot
pages.

I attempted to work it around but it seems I am getting hot pages even
when I ask for cold one. This seems to fix it. Does it looks like
"possibly mergable" patch?

									Pavel

--- clean/kernel/suspend.c	2002-11-01 00:37:42.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-01 22:51:28.000000000 +0100
@@ -549,7 +550,7 @@
 
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
 	if(!pagedir)
 		return NULL;
 
@@ -558,11 +559,11 @@
 		SetPageNosave(page++);
 		
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC);
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if(!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
--- clean/mm/page_alloc.c	2002-11-01 00:37:44.000000000 +0100
+++ linux-swsusp/mm/page_alloc.c	2002-11-01 22:53:47.000000000 +0100
@@ -361,7 +361,7 @@
 	unsigned long flags;
 	struct page *page = NULL;
 
-	if (order == 0) {
+	if ((order == 0) && !cold) {
 		struct per_cpu_pages *pcp;
 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
