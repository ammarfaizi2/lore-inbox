Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbTCYV7I>; Tue, 25 Mar 2003 16:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbTCYV7I>; Tue, 25 Mar 2003 16:59:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:60778 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261392AbTCYV7E>; Tue, 25 Mar 2003 16:59:04 -0500
Date: Tue, 25 Mar 2003 22:12:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 02/13 !CONFIG_SWAP try_to_unmap
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252210550.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raised #endif CONFIG_SWAP in shrink_list, it was excluding
try_to_unmap of file pages.  Suspect !CONFIG_MMU relied on
that to suppress try_to_unmap, added SWAP_FAIL stub for it.

--- swap01/include/linux/swap.h	Tue Mar 25 20:42:56 2003
+++ swap02/include/linux/swap.h	Tue Mar 25 20:43:07 2003
@@ -175,19 +175,18 @@
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
 int FASTCALL(try_to_unmap(struct page *));
 
-/* return values of try_to_unmap */
-#define	SWAP_SUCCESS	0
-#define	SWAP_AGAIN	1
-#define	SWAP_FAIL	2
-
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
-
 #else
-#define page_referenced(page) \
-	TestClearPageReferenced(page)
+#define page_referenced(page)	TestClearPageReferenced(page)
+#define try_to_unmap(page)	SWAP_FAIL
 #endif /* CONFIG_MMU */
 
+/* return values of try_to_unmap */
+#define	SWAP_SUCCESS	0
+#define	SWAP_AGAIN	1
+#define	SWAP_FAIL	2
+
 #ifdef CONFIG_SWAP
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
--- swap01/mm/vmscan.c	Tue Mar 25 20:42:56 2003
+++ swap02/mm/vmscan.c	Tue Mar 25 20:43:07 2003
@@ -277,6 +277,7 @@
 			pte_chain_lock(page);
 			mapping = page->mapping;
 		}
+#endif /* CONFIG_SWAP */
 
 		/*
 		 * The page is mapped into the page tables of one or more
@@ -294,7 +295,6 @@
 				; /* try to free the page below */
 			}
 		}
-#endif /* CONFIG_SWAP */
 		pte_chain_unlock(page);
 
 		/*

