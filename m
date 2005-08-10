Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVHJUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVHJUKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVHJUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:09:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22421 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030246AbVHJUJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:09:53 -0400
Message-Id: <20050810200944.197606000@jumble.boston.redhat.com>
References: <20050810200216.644997000@jumble.boston.redhat.com>
Date: Wed, 10 Aug 2005 16:02:21 -0400
From: Rik van Riel <riel@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 5/5] CLOCK-Pro page replacement
Content-Disposition: inline; filename=clockpro-stats
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export the active limit statistic through /proc.  We may want to
export some more CLOCK-Pro statistics in the future, but I'm not
sure yet which ones.

Signed-off-by: Rik van Riel

Index: linux-2.6.12-vm/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.12-vm.orig/fs/proc/proc_misc.c
+++ linux-2.6.12-vm/fs/proc/proc_misc.c
@@ -125,11 +125,13 @@ static int meminfo_read_proc(char *page,
 	unsigned long free;
 	unsigned long committed;
 	unsigned long allowed;
+	unsigned long active_limit;
 	struct vmalloc_info vmi;
 	long cached;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
+	active_limit = get_active_limit();
 
 /*
  * display in kilobytes.
@@ -158,6 +160,7 @@ static int meminfo_read_proc(char *page,
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8lu kB\n"
 		"Inactive:     %8lu kB\n"
+		"ActiveLimit:  %8lu kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -181,6 +184,7 @@ static int meminfo_read_proc(char *page,
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
+		K(active_limit),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
Index: linux-2.6.12-vm/include/linux/swap.h
===================================================================
--- linux-2.6.12-vm.orig/include/linux/swap.h
+++ linux-2.6.12-vm/include/linux/swap.h
@@ -161,6 +161,7 @@ extern void init_nonresident(void);
 /* linux/mm/clockpro.c */
 extern void remember_page(struct page *, struct address_space *, unsigned long);
 extern int page_is_hot(struct page *, struct address_space *, unsigned long);
+extern unsigned long get_active_limit(void);
 DECLARE_PER_CPU(unsigned long, evicted_pages);
 
 /* linux/mm/page_alloc.c */
Index: linux-2.6.12-vm/mm/clockpro.c
===================================================================
--- linux-2.6.12-vm.orig/mm/clockpro.c
+++ linux-2.6.12-vm/mm/clockpro.c
@@ -100,3 +100,14 @@ void remember_page(struct page * page, s
 			zone->active_limit < zone->present_pages * 7 / 8)
 		zone->active_limit++;
 }
+
+unsigned long get_active_limit(void)
+{
+	unsigned long total = 0;
+	struct zone * zone;
+	
+	for_each_zone(zone)
+		total += zone->active_limit;
+
+	return total;
+}

--
-- 
All Rights Reversed
