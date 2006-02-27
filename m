Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWB0Sau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWB0Sau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWB0Sau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:30:50 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:3248 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751358AbWB0Sat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:30:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH -mm 1/2] mm: make shrink_all_memory overflow-resistant
Date: Mon, 27 Feb 2006 19:28:22 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200602271926.20294.rjw@sisk.pl>
In-Reply-To: <200602271926.20294.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271928.22791.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make shrink_all_memory() overflow-resistant.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/swap.h |    2 +-
 mm/vmscan.c          |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
+++ linux-2.6.16-rc4-mm2/mm/vmscan.c
@@ -1785,18 +1785,19 @@ void wakeup_kswapd(struct zone *zone, in
  * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
  * pages.
  */
-int shrink_all_memory(unsigned long nr_pages)
+unsigned long shrink_all_memory(unsigned int nr_pages)
 {
 	pg_data_t *pgdat;
-	unsigned long nr_to_free = nr_pages;
-	int ret = 0;
+	long long nr_to_free = nr_pages;
+	unsigned long ret = 0;
 	struct reclaim_state reclaim_state = {
 		.reclaimed_slab = 0,
 	};
 
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
-		int freed;
+		unsigned long freed;
+
 		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
 		nr_to_free -= freed;
Index: linux-2.6.16-rc4-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.16-rc4-mm2.orig/include/linux/swap.h
+++ linux-2.6.16-rc4-mm2/include/linux/swap.h
@@ -173,7 +173,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern unsigned long try_to_free_pages(struct zone **, gfp_t);
-extern int shrink_all_memory(unsigned long nr_pages);
+extern unsigned long shrink_all_memory(unsigned int nr_pages);
 extern int vm_swappiness;
 
 #ifdef CONFIG_NUMA

