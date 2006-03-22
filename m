Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWCVWrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWCVWrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWCVWdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:33:06 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:30230 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932871AbWCVWcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:32:52 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223218.12658.40531.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 07/34] mm: page-replace-move-macros.patch
Date: Wed, 22 Mar 2006 23:32:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

move macro's out of vmscan into the generic page replace header so the
rest of the world can use them too.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h |   30 ++++++++++++++++++++++++++++++
 mm/vmscan.c                     |   30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -8,6 +8,36 @@
 #include <linux/pagevec.h>
 #include <linux/mm_inline.h>
 
+#define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
+
+#ifdef ARCH_HAS_PREFETCH
+#define prefetch_prev_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.prev != _base) {			\
+			struct page *prev;				\
+									\
+			prev = lru_to_page(&(_page->lru));		\
+			prefetch(&prev->_field);			\
+		}							\
+	} while (0)
+#else
+#define prefetch_prev_lru_page(_page, _base, _field) do { } while (0)
+#endif
+
+#ifdef ARCH_HAS_PREFETCHW
+#define prefetchw_prev_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.prev != _base) {			\
+			struct page *prev;				\
+									\
+			prev = lru_to_page(&(_page->lru));		\
+			prefetchw(&prev->_field);			\
+		}							\
+	} while (0)
+#else
+#define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
+#endif
+
 /* void page_replace_hint_active(struct page *); */
 /* void page_replace_hint_use_once(struct page *); */
 extern void fastcall page_replace_add(struct page *);
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -93,36 +93,6 @@ struct shrinker {
 	long			nr;	/* objs pending delete */
 };
 
-#define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
-
-#ifdef ARCH_HAS_PREFETCH
-#define prefetch_prev_lru_page(_page, _base, _field)			\
-	do {								\
-		if ((_page)->lru.prev != _base) {			\
-			struct page *prev;				\
-									\
-			prev = lru_to_page(&(_page->lru));		\
-			prefetch(&prev->_field);			\
-		}							\
-	} while (0)
-#else
-#define prefetch_prev_lru_page(_page, _base, _field) do { } while (0)
-#endif
-
-#ifdef ARCH_HAS_PREFETCHW
-#define prefetchw_prev_lru_page(_page, _base, _field)			\
-	do {								\
-		if ((_page)->lru.prev != _base) {			\
-			struct page *prev;				\
-									\
-			prev = lru_to_page(&(_page->lru));		\
-			prefetchw(&prev->_field);			\
-		}							\
-	} while (0)
-#else
-#define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
-#endif
-
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
