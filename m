Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSHICyh>; Thu, 8 Aug 2002 22:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSHICx0>; Thu, 8 Aug 2002 22:53:26 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45027 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318129AbSHICxK>; Thu, 8 Aug 2002 22:53:10 -0400
Message-Id: <200208090256.g792uWF05167@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: akpm@zip.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (3/4) discontigmem support for i386 against 2.5.30
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-774610680"
Date: Thu, 08 Aug 2002 19:56:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-774610680
Content-Type: text/plain; charset=us-ascii


This patch restructures mem_init() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.  A version of this patch is the in 2.4 aa tree.

This patch does not depend on the other patches I'm submitting today, but 
my discontigmem patch does depend on this one.

I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
multiquad, multiquad PAE.

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/



--==_Exmh_-774610680
Content-Type: application/x-patch ; name="linux-2.5.30-meminit_A2.patch"
Content-Description: linux-2.5.30-meminit_A2.patch
Content-Disposition: attachment; filename="linux-2.5.30-meminit_A2.patch"

diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Thu Aug  8 18:54:14 2002
+++ b/arch/i386/mm/init.c	Thu Aug  8 18:54:14 2002
@@ -213,27 +213,28 @@
 	pkmap_page_table = pte;	
 }
 
+void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
+{
+	if (!page_is_ram(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
+	if (bad_ppro && page_kills_ppro(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
+	ClearPageReserved(page);
+	set_bit(PG_highmem, &page->flags);
+	atomic_set(&page->count, 1);
+	__free_page(page);
+	totalhigh_pages++;
+}
+
 void __init set_highmem_pages_init(int bad_ppro) 
 {
 	int pfn;
-	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++) {
-		struct page *page = mem_map + pfn;
-
-		if (!page_is_ram(pfn)) {
-			SetPageReserved(page);
-			continue;
-		}
-		if (bad_ppro && page_kills_ppro(pfn))
-		{
-			SetPageReserved(page);
-			continue;
-		}
-		ClearPageReserved(page);
-		set_bit(PG_highmem, &page->flags);
-		atomic_set(&page->count, 1);
-		__free_page(page);
-		totalhigh_pages++;
-	}
+	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
+		one_highpage_init((struct page *)(mem_map + pfn), pfn, bad_ppro);
 	totalram_pages += totalhigh_pages;
 }
 
@@ -405,7 +406,17 @@
 		printk("Ok.\n");
 	}
 }
-	
+
+static void __init set_max_mapnr_init(void)
+{
+#ifdef CONFIG_HIGHMEM
+	highmem_start_page = mem_map + highstart_pfn;
+	max_mapnr = num_physpages = highend_pfn;
+#else
+	max_mapnr = num_physpages = max_low_pfn;
+#endif
+}
+
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -418,12 +429,8 @@
 	
 	bad_ppro = ppro_with_ram_bug();
 
-#ifdef CONFIG_HIGHMEM
-	highmem_start_page = mem_map + highstart_pfn;
-	max_mapnr = num_physpages = highend_pfn;
-#else
-	max_mapnr = num_physpages = max_low_pfn;
-#endif
+	set_max_mapnr_init();
+
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 	/* clear the zero-page */

--==_Exmh_-774610680--


