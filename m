Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRHWTd1>; Thu, 23 Aug 2001 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270194AbRHWTdT>; Thu, 23 Aug 2001 15:33:19 -0400
Received: from mailc.telia.com ([194.22.190.4]:21714 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S270174AbRHWTdO>;
	Thu, 23 Aug 2001 15:33:14 -0400
Message-Id: <200108231933.f7NJX8j21551@mailc.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Rik van Riel <riel@conectiva.com.br>,
        torvalds@transmeta.com (Linus Torvalds), alan.cox@redhat.com
Subject: Upd: [PATCH NG] alloc_pages_limit & pages_min
Date: Thu, 23 Aug 2001 21:28:44 +0200
X-Mailer: KMail [version 1.3]
Cc: <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108231600020.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108231600020.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riel convinced be to back off a part of the patch.
Here comes an updated one.

-- 
Roger Larsson
Skellefteå
Sweden

*******************************************
Patch prepared by: roger.larsson@norran.net
Name of file: linux-2.4.8-pre3-pages_min-R3

--- linux/mm/page_alloc.c.orig  Thu Aug 23 19:58:55 2001
+++ linux/mm/page_alloc.c       Thu Aug 23 21:19:20 2001
@@ -253,11 +253,26 @@

                if (z->free_pages + z->inactive_clean_pages >= water_mark) {
                        struct page *page = NULL;
-                       /* If possible, reclaim a page directly. */
-                       if (direct_reclaim)
+
+                       /*
+                        * Reclaim a page from the inactive_clean list.
+                        * If needed, refill the free list up to the
+                        * low water mark.
+                        */
+                       if (direct_reclaim) {
                                page = reclaim_page(z);
-                       /* If that fails, fall back to rmqueue. */
-                       if (!page)
+
+                               while (page && z->free_pages < z->pages_min) {
+                                       __free_page(page);
+                                       page = reclaim_page(z);
+                               }
+
+                               /* let kreclaimd handle up to pages_high */
+                       }
+                       /* If that fails, fall back to rmqueue, but never let
+                       *  free_pages go below pages_min...
+                       */
+                       if (!page && z->free_pages >= z->pages_min)
                                page = rmqueue(z, order);
                        if (page)
                                return page;
