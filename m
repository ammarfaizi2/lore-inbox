Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVL3WmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVL3WmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVL3Wln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:41:43 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:44350 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932154AbVL3WlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:41:17 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224052.765.81067.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 06/14] page-replace-move-macros.patch
Date: Fri, 30 Dec 2005 23:41:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Move some utility marco's to the new common header to they can be used
by the code moved over to page_replace.c

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

--- linux-2.6-git.orig/include/linux/mm_page_replace.h	2005-12-10 20:50:44.000000000 +0100
+++ linux-2.6-git/include/linux/mm_page_replace.h	2005-12-10 20:53:12.000000000 +0100
@@ -6,6 +6,36 @@
 #include <linux/mmzone.h>
 #include <linux/mm.h>
 
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
 void __page_replace_insert(struct zone *, struct page *);
 static inline void page_replace_activate(struct page *page)
 {
--- linux-2.6-git.orig/mm/vmscan.c	2005-12-10 20:50:44.000000000 +0100
+++ linux-2.6-git/mm/vmscan.c	2005-12-10 20:53:12.000000000 +0100
@@ -104,36 +104,6 @@
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
