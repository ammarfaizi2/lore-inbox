Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUKOOjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUKOOjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUKOOiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:38:50 -0500
Received: from zamok.crans.org ([138.231.136.6]:33233 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261609AbUKOOhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:37:43 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.10-rc1-mm5: fixes more warnings wrt kunmap_atomic API changes
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Mon, 15 Nov 2004 15:37:47 +0100
Message-ID: <87is87w538.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Hi Andrew,
(sorry for resending, forgot to CC: linux-kernel@)

This fixes more compile warnings, wrt last changes in k[un]map* prototypes.
I did _not_ fold the compile fix you provided later when CONFIG_HIGHMEM=y,
in include/asm-i386/highmem.h.
This patch:
  - adds (char *) casts in pte_* macros in include/asm-i386/pgtable.h
    when CONFIG_HIGHMEM=y
  - casts swp_entry_t object entry to (char *) in mm/shmem.c.

Signed-off-by: Mathieu Segaud <matt@minas-morgul.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=kunmap-fallout-more-fixes.patch

diff -Naur linux-2.6.10-rc1-mm5/include/asm-i386/highmem.h linux-2.6.10-rc1-mm5-fixes/include/asm-i386/highmem.h
--- linux-2.6.10-rc1-mm5/include/asm-i386/highmem.h	2004-11-15 12:10:04.727560936 +0100
+++ linux-2.6.10-rc1-mm5-fixes/include/asm-i386/highmem.h	2004-11-15 12:13:00.764799208 +0100
@@ -62,7 +62,7 @@
 char *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(char *kvaddr, enum km_type type);
 char *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
-struct page *kmap_atomic_to_page(void *ptr);
+struct page *kmap_atomic_to_page(char *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
 
diff -Naur linux-2.6.10-rc1-mm5/include/asm-i386/pgtable.h linux-2.6.10-rc1-mm5-fixes/include/asm-i386/pgtable.h
--- linux-2.6.10-rc1-mm5/include/asm-i386/pgtable.h	2004-11-15 12:10:04.736559568 +0100
+++ linux-2.6.10-rc1-mm5-fixes/include/asm-i386/pgtable.h	2004-11-15 12:43:52.831242312 +0100
@@ -358,8 +358,8 @@
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
 #define pte_offset_map_nested(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
-#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
-#define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
+#define pte_unmap(pte) kunmap_atomic((char *)pte, KM_PTE0)
+#define pte_unmap_nested(pte) kunmap_atomic((char *)pte, KM_PTE1)
 #else
 #define pte_offset_map(dir, address) \
 	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
diff -Naur linux-2.6.10-rc1-mm5/mm/shmem.c linux-2.6.10-rc1-mm5-fixes/mm/shmem.c
--- linux-2.6.10-rc1-mm5/mm/shmem.c	2004-11-15 12:10:06.720258000 +0100
+++ linux-2.6.10-rc1-mm5-fixes/mm/shmem.c	2004-11-15 12:44:19.963117640 +0100
@@ -327,7 +327,7 @@
 	entry->val = value;
 	info->swapped += incdec;
 	if ((unsigned long)(entry - info->i_direct) >= SHMEM_NR_DIRECT)
-		kmap_atomic_to_page(entry)->nr_swapped += incdec;
+		kmap_atomic_to_page((char *)entry)->nr_swapped += incdec;
 }
 
 /*

--=-=-=


-- 
Catastrophic failure of the IDE cable???.
What are you doing to the poor thing, jumping on it?

	- Beau Kuiper on linux-kernel

--=-=-=--

