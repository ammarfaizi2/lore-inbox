Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317228AbSFBXNh>; Sun, 2 Jun 2002 19:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSFBXNg>; Sun, 2 Jun 2002 19:13:36 -0400
Received: from holomorphy.com ([66.224.33.161]:45218 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317228AbSFBXNe>;
	Sun, 2 Jun 2002 19:13:34 -0400
Date: Sun, 2 Jun 2002 16:13:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: make balance_classzone() use list.h
Message-ID: <20020602231312.GR14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

balance_classzone() does a number of open-coded list operations. This
adjusts balance_classzone() to use generic list.h operations as well
as renaming __freed and restructuring some of the control flow to use
if (unlikely(...))) goto handle_rare_case; for additional conciseness
and reducing the number of indentation levels required.

Against 2.5.19


Cheers,
Bill


===== mm/page_alloc.c 1.72 vs edited =====
--- 1.72/mm/page_alloc.c	Sun Jun  2 15:49:05 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 16:02:35 2002
@@ -265,8 +265,9 @@
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
-	struct page * page = NULL;
-	int __freed = 0;
+	struct page *tmp, *page = NULL;
+	list_t *save, *entry, *local_pages;
+	int nr_pages, reclaimed = 0;
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
@@ -275,52 +276,57 @@
 	current->allocation_order = order;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
 
-	__freed = try_to_free_pages(classzone, gfp_mask, order);
+	reclaimed = try_to_free_pages(classzone, gfp_mask, order);
 
 	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);
 
-	if (current->nr_local_pages) {
-		struct list_head * entry, * local_pages;
-		struct page * tmp;
-		int nr_pages;
-
-		local_pages = &current->local_pages;
-
-		if (likely(__freed)) {
-			/* pick from the last inserted so we're lifo */
-			entry = local_pages->next;
-			do {
-				tmp = list_entry(entry, struct page, list);
-				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
-					list_del(entry);
-					current->nr_local_pages--;
-					set_page_count(tmp, 1);
-					page = tmp;
-
-					BUG_ON(PagePrivate(page));
-					BUG_ON(page->mapping);
-					BUG_ON(PageLocked(page));
-					BUG_ON(PageLRU(page));
-					BUG_ON(PageActive(page));
-					BUG_ON(PageDirty(page));
-					BUG_ON(PageWriteback(page));
-					break;
-				}
-			} while ((entry = entry->next) != local_pages);
-		}
-
-		nr_pages = current->nr_local_pages;
-		/* free in reverse order so that the global order will be lifo */
-		while ((entry = local_pages->prev) != local_pages) {
-			list_del(entry);
-			tmp = list_entry(entry, struct page, list);
-			__free_pages_ok(tmp, tmp->index);
-			BUG_ON(!nr_pages--);
-		}
-		current->nr_local_pages = 0;
+	if (!current->nr_local_pages)
+		goto out;
+
+	local_pages = &current->local_pages;
+
+	if (unlikely(!reclaimed))
+		goto reverse_free;
+
+	/* pick from the last inserted so we're lifo */
+	list_for_each_safe(entry, save, local_pages) {
+		tmp = list_entry(entry, struct page, list);
+
+		if (tmp->index != order)
+			continue;
+		if (memclass(page_zone(tmp), classzone))
+			continue;
+
+		list_del(entry);
+		current->nr_local_pages--;
+		set_page_count(tmp, 1);
+		page = tmp;
+
+		BUG_ON(PagePrivate(page));
+		BUG_ON(page->mapping);
+		BUG_ON(PageLocked(page));
+		BUG_ON(PageLRU(page));
+		BUG_ON(PageActive(page));
+		BUG_ON(PageDirty(page));
+		BUG_ON(PageWriteback(page));
+		break;
+	}
+
+reverse_free:
+	nr_pages = current->nr_local_pages;
+	/* free in reverse order so that the global order will be lifo */
+	while (!list_empt(local_pages)) {
+		entry = local_pages->prev;
+		list_del(entry);
+		tmp = list_entry(entry, struct page, list);
+		__free_pages_ok(tmp, tmp->index);
+		BUG_ON(!nr_pages);
+		nr_pages--;
 	}
- out:
-	*freed = __freed;
+	BUG_ON(nr_pages);
+	current->nr_local_pages = 0;
+out:
+	*freed = reclaimed;
 	return page;
 }
 
