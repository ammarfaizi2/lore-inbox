Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290745AbSA3XgL>; Wed, 30 Jan 2002 18:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSA3XgD>; Wed, 30 Jan 2002 18:36:03 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:30662 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290745AbSA3Xfs>; Wed, 30 Jan 2002 18:35:48 -0500
Date: Thu, 31 Jan 2002 00:35:07 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Speed bootmem up for simulators
Message-ID: <20020131003507.A1453@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is a old patch from the x86-64 tree. It just optimizes the final memory
freeing pass to be a bit more efficient. It probably doesn't make much
difference on any CPU, but it is a big time win in a slow CPU simulator
with huge memory where the freeing can take minutes sometimes.

It is just an obvious optimization for the freeing loop. 

Patch against 2.5.3. Please apply.

Thanks,

-Andi


--- linux-2.5.3-work/mm/bootmem.c-BOOTMEM	Tue Jan 15 17:53:36 2002
+++ linux-2.5.3-work/mm/bootmem.c	Wed Jan 30 23:21:35 2002
@@ -247,19 +247,30 @@
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
+	unsigned long *map; 
 
 	if (!bdata->node_bootmem_map) BUG();
 
 	count = 0;
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
-	for (i = 0; i < idx; i++, page++) {
-		if (!test_bit(i, bdata->node_bootmem_map)) {
+	map = bdata->node_bootmem_map;
+	for (i = 0; i < idx; ) {
+		unsigned long v = ~map[i / BITS_PER_LONG];
+		if (v) { 
+			unsigned long m;
+			for (m = 1; m && i < idx; m<<=1, page++, i++) { 
+				if (v & m) {
 			count++;
 			ClearPageReserved(page);
 			set_page_count(page, 1);
 			__free_page(page);
 		}
 	}
+		} else {
+			i+=BITS_PER_LONG;
+			page+=BITS_PER_LONG; 
+		} 	
+	}	
 	total += count;
 
 	/*
