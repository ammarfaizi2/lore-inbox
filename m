Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSKZX3J>; Tue, 26 Nov 2002 18:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSKZX3J>; Tue, 26 Nov 2002 18:29:09 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:57290 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S263204AbSKZX3I>; Tue, 26 Nov 2002 18:29:08 -0500
Date: Tue, 26 Nov 2002 17:07:23 -0700
From: Matt Porter <porter@cox.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] update ref counts on all allocated pages
Message-ID: <20021126170723.A23962@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch sets the ref count on all pages of an
allocation.  This allows an allocation with order>0 to be freed
via individual __free_page() calls within vfree().
  
This is important on non cache coherent processors which
have a pci_alloc_consistent/consistent_alloc() implementation
that involves creating a vmalloc area cache inhibited mapping
of allocated pages.
  
Because of this implementation, the implementation
of pci_free_consistent/consistent_free is done via
a vfree().  Without this patch only the first page
of the allocated memory is freed since successive pages
all have ref counts of zero.

-Matt

===== mm/page_alloc.c 1.56 vs edited =====
--- 1.56/mm/page_alloc.c	Tue Aug 20 04:39:48 2002
+++ edited/mm/page_alloc.c	Tue Nov 26 12:03:38 2002
@@ -203,6 +203,7 @@
 	struct list_head *head, *curr;
 	unsigned long flags;
 	struct page *page;
+	int i;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	do {
@@ -224,7 +225,10 @@
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);
 
-			set_page_count(page, 1);
+			/* Set ref count on all pages */
+			for (i = 0; i < (1 << order); i++)
+				set_page_count(page+i, 1);
+
 			if (BAD_RANGE(zone,page))
 				BUG();
 			if (PageLRU(page))

-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
