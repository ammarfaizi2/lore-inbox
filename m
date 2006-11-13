Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754336AbWKMJn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbWKMJn5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbWKMJn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:43:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:18073 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1754336AbWKMJn4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:43:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,416,1157353200"; 
   d="scan'208"; a="162726327:sNHT26060986"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.19-rc5-git2]  EFI: mapping memory region of runtime services when using memmap kernel parameter
Date: Mon, 13 Nov 2006 11:43:49 +0200
Message-ID: <C1467C8B168BCF40ACEC2324C1A2B0740170445A@hasmsx411.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc5-git2]  EFI: mapping memory region of runtime services when using memmap kernel parameter
thread-index: AccHCDjMzax8V33MScWqQ5cDC5XxJw==
From: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
To: <davej@codemonkey.org.uk>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>, "Satt, Shai" <shai.satt@intel.com>
X-OriginalArrivalTime: 13 Nov 2006 09:43:50.0477 (UTC) FILETIME=[393CD7D0:01C70708]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
 
When using memmap kernel parameter in EFI boot we should also map memory
regions of runtime services to enable their mapping later.

Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
---

diff -uprN linux-2.6.19-rc5-git2.orig/arch/i386/kernel/setup.c
linux-2.6.19-rc5-git2/arch/i386/kernel/setup.c
--- linux-2.6.19-rc5-git2.orig/arch/i386/kernel/setup.c	2006-11-13
11:15:17.000000000 +0200
+++ linux-2.6.19-rc5-git2/arch/i386/kernel/setup.c	2006-11-13
11:15:42.000000000 +0200
@@ -346,28 +346,44 @@ static void __init probe_roms(void)
 	}
 }
 
+extern int is_available_memory(efi_memory_desc_t * md);
+
 static void __init limit_regions(unsigned long long size)
 {
 	unsigned long long current_addr = 0;
-	int i;
+	int i , j;
 
-	if (efi_enabled) {
-		efi_memory_desc_t *md;
-		void *p;
+	if (efi_enabled) {		
+		efi_memory_desc_t *md, *next_md = 0;
+		void *p, *p1;
 
-		for (p = memmap.map, i = 0; p < memmap.map_end;
+		for (p = memmap.map, i = 0,j = 0, p1 = memmap.map; p <
memmap.map_end;
 			p += memmap.desc_size, i++) {
 			md = p;
+			next_md = p1;
 			current_addr = md->phys_addr + (md->num_pages <<
12);
-			if (md->type == EFI_CONVENTIONAL_MEMORY) {
-				if (current_addr >= size) {
-					md->num_pages -=
-						(((current_addr-size) +
PAGE_SIZE-1) >> PAGE_SHIFT);
-					memmap.nr_map = i + 1;
-					return;
+			if (is_available_memory(md)) {
+				if (md->phys_addr >= size) continue;
+				memcpy(next_md, md, memmap.desc_size);

+                                if (current_addr >= size) {
+					next_md->num_pages -=
(((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
 				}
+				p1 += memmap.desc_size;
+				next_md = p1;
+				j++;
 			}
-		}
+			else if ((md->attribute & EFI_MEMORY_RUNTIME) ==
EFI_MEMORY_RUNTIME) {
+				/* In order to make runtime services
available we have to include runtime 
+				 * memory regions in memory map */
+				memcpy(next_md, md, memmap.desc_size);
+				p1 += memmap.desc_size;
+				next_md = p1;
+				j++;
+			}		
+		}
+		memmap.nr_map = j;
+		memmap.map_end = memmap.map + (memmap.nr_map *
memmap.desc_size);
+                return;
 	}
 	for (i = 0; i < e820.nr_map; i++) {
 		current_addr = e820.map[i].addr + e820.map[i].size;
