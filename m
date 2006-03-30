Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWC3DFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWC3DFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWC3DFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:05:20 -0500
Received: from wproxy.gmail.com ([64.233.184.228]:15946 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751227AbWC3DFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:05:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=O1aEs6zWgPfbkMhZJwmUQnNaEq3YbjDdmOdwnBD3MOJqpo7TAaU027320i6yPgJzw+dz1Z4yNSjk/qCoaR8WJvKm5T/Kzyfej5C3ropP1BOv/qgCVfxXUplHxpzJIIZ8V9oW/AyZ+yHuNiex9pVrzOPQRRH4i2TtnspWD3GCjH8=
Message-ID: <489ecd0c0603291905m7ebffff2j83809cc3c93595f1@mail.gmail.com>
Date: Thu, 30 Mar 2006 11:05:18 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <npiggin@suse.de>
Subject: [PATCH] nommu page refcount bug fixing
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11426_32688172.1143687918560"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_11426_32688172.1143687918560
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

   The previous "nommu use compound pages" patch has a problem: when
the pages allocated is not compound page (eg: slab allocator), the
refcount value of every page still need to be set, otherwise the
get/put_page() would free a single page improperly, such as in
access_process_vm().

Signed-off-by: Luke Yang <luke.adi@gmail.com>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b7f14a4..fc8b544 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -436,6 +436,14 @@ static void __free_pages_ok(struct page
                mutex_debug_check_no_locks_freed(page_address(page),
                                                 PAGE_SIZE<<order);

+#ifndef CONFIG_MMU
+       if (!PageCompound(page)) {
+               for (i =3D 1 ; i < (1 << order) ; ++i) {
+                       __put_page(page + i);
+               }
+       }
+#endif
+
        for (i =3D 0 ; i < (1 << order) ; ++i)
                reserved +=3D free_pages_check(page + i);
        if (reserved)
@@ -453,6 +461,8 @@ static void __free_pages_ok(struct page
  */
 void fastcall __init __free_pages_bootmem(struct page *page, unsigned
int order)
 {
+       int i;
+
        if (order =3D=3D 0) {
                __ClearPageReserved(page);
                set_page_count(page, 0);
@@ -472,6 +482,11 @@ void fastcall __init __free_pages_bootme
                }

                set_page_refcounted(page);
+
+#ifndef CONFIG_MMU
+               for (i =3D 1; i < (1 << order); i++)
+                       set_page_refcounted(page + i);
+#endif
                __free_pages(page, order);
        }
 }
@@ -512,6 +527,8 @@ static inline void expand(struct zone *z
  */
 static int prep_new_page(struct page *page, int order, gfp_t gfp_flags)
 {
+       int i;
+
        if (unlikely(page_mapcount(page) |
                (page->mapping !=3D NULL)  |
                (page_count(page) !=3D 0)  |
@@ -539,7 +556,21 @@ static int prep_new_page(struct page *pa
                        1 << PG_referenced | 1 << PG_arch_1 |
                        1 << PG_checked | 1 << PG_mappedtodisk);
        set_page_private(page, 0);
+
        set_page_refcounted(page);
+
+#ifndef CONFIG_MMU
+       if (!(gfp_flags & __GFP_COMP)) {
+               /*
+                * Reference all the pages for this order, otherwise if
+                * anyone accesses one of the pages with (get/put) it
+                * will be freed. - eg: access_process_vm()
+                */
+               for (i =3D 1; i < (1 << order); i++)
+                       set_page_refcounted(page + i);
+       }
+#endif
+
        kernel_map_pages(page, 1 << order, 1);

        if (gfp_flags & __GFP_ZERO)

--
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_11426_32688172.1143687918560
Content-Type: text/x-patch; name=nommu_page_count_fix.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eldg7710
Content-Disposition: attachment; filename="nommu_page_count_fix.patch"

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b7f14a4..fc8b544 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -436,6 +436,14 @@ static void __free_pages_ok(struct page 
 		mutex_debug_check_no_locks_freed(page_address(page),
 						 PAGE_SIZE<<order);
 
+#ifndef CONFIG_MMU
+	if (!PageCompound(page)) {
+		for (i = 1 ; i < (1 << order) ; ++i) {
+			__put_page(page + i);
+		}
+	}
+#endif
+
 	for (i = 0 ; i < (1 << order) ; ++i)
 		reserved += free_pages_check(page + i);
 	if (reserved)
@@ -453,6 +461,8 @@ static void __free_pages_ok(struct page 
  */
 void fastcall __init __free_pages_bootmem(struct page *page, unsigned int order)
 {
+	int i;
+
 	if (order == 0) {
 		__ClearPageReserved(page);
 		set_page_count(page, 0);
@@ -472,6 +482,11 @@ void fastcall __init __free_pages_bootme
 		}
 
 		set_page_refcounted(page);
+
+#ifndef CONFIG_MMU
+		for (i = 1; i < (1 << order); i++)
+			set_page_refcounted(page + i);
+#endif
 		__free_pages(page, order);
 	}
 }
@@ -512,6 +527,8 @@ static inline void expand(struct zone *z
  */
 static int prep_new_page(struct page *page, int order, gfp_t gfp_flags)
 {
+	int i;
+
 	if (unlikely(page_mapcount(page) |
 		(page->mapping != NULL)  |
 		(page_count(page) != 0)  |
@@ -539,7 +556,21 @@ static int prep_new_page(struct page *pa
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
+
 	set_page_refcounted(page);
+
+#ifndef CONFIG_MMU
+	if (!(gfp_flags & __GFP_COMP)) {
+		/*
+		 * Reference all the pages for this order, otherwise if
+		 * anyone accesses one of the pages with (get/put) it
+		 * will be freed. - eg: access_process_vm()
+		 */
+		for (i = 1; i < (1 << order); i++)
+			set_page_refcounted(page + i);
+	}
+#endif
+
 	kernel_map_pages(page, 1 << order, 1);
 
 	if (gfp_flags & __GFP_ZERO)

------=_Part_11426_32688172.1143687918560--
