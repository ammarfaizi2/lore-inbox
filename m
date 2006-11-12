Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932935AbWKLPpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWKLPpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWKLPpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:45:33 -0500
Received: from mga03.intel.com ([143.182.124.21]:38749 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S932935AbWKLPpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:45:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,414,1157353200"; 
   d="scan'208"; a="144998649:sNHT26783953"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.18.2] EFI: mapping memory region of runtime services when using memmap kernel parameter
Date: Sun, 12 Nov 2006 17:45:26 +0200
Message-ID: <C1467C8B168BCF40ACEC2324C1A2B074016C5DE9@hasmsx411.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.18.2] EFI: mapping memory region of runtime services when using memmap kernel parameter
thread-index: AccGcZK/LK2WA67/QtKDjoY/2v3DnA==
From: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
To: <davej@codemonkey.org.uk>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Narayanan, Chandramouli" <chandramouli.narayanan@intel.com>,
       "Jiossy, Rami" <rami.jiossy@intel.com>,
       "Satt, Shai" <shai.satt@intel.com>
X-OriginalArrivalTime: 12 Nov 2006 15:45:27.0586 (UTC) FILETIME=[934F3020:01C70671]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
 
When using memmap kernel parameter in EFI boot we should also map memory
regions of runtime services to enable their mapping later.

Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
---

diff -uprN linux-2.6.18.2.orig/arch/i386/kernel/setup.c
linux-2.6.18.2/arch/i386/kernel/setup.c
--- linux-2.6.18.2.orig/arch/i386/kernel/setup.c	2006-11-12
11:22:22.000000000 +0200
+++ linux-2.6.18.2/arch/i386/kernel/setup.c	2006-11-12
16:31:32.000000000 +0200
@@ -364,28 +364,44 @@ static void __init probe_roms(void)
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
